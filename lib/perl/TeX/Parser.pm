package TeX::Parser;

# Copyright (C) 2022, 2024 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

use strict;
use warnings;

use version; our $VERSION = qv '2.12.0';

use base qw(TeX::Lexer);

######################################################################
##                                                                  ##
##                         PACKAGE IMPORTS                          ##
##                                                                  ##
######################################################################

use Carp qw(shortmess);

use File::Basename;

use TeX::Class;

use Scalar::Util qw(blessed reftype);

use TeX::Utils::Misc;

use TeX::Parser::Macro qw(:factories);

use TeX::Token qw(:catcodes :factories);
use TeX::TokenList qw(:factories);

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %handler_stack    :ARRAY(:name<handler_stack>);
my %catcode_handlers :ATTR;
my %handlers         :ATTR;
my %default_handler  :ATTR;

my %math_nesting_of :COUNTER(:name<math_nesting>);

my %execute_input_of :BOOLEAN(:name<execute_input> :get<execute_input> :default<0>);

my %execute_defs_of  :BOOLEAN(:name<execute_defs> :get<execute_defs> :default<0>);
my %expand_macros_of :BOOLEAN(:name<expand_macros> :get<expand_macros> :default<0>);

my %buffer_output_of :BOOLEAN(:name<buffer_output> :get<buffer_output> :default<0>);

my %output_buffer_of :ATTR();

my %output_buffer_stack :ARRAY(:name<output_stack>);

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

use constant {
    PAR_TOKEN => make_csname_token('par'),
    FI_TOKEN  => make_csname_token('fi')
};

######################################################################
##                                                                  ##
##                            UTILITIES                             ##
##                                                                  ##
######################################################################

sub SHOUT { print STDERR @_; }

sub __report_token($$) {
    my $self  = shift;
    my $token = shift;

    # return;

    my (undef, undef, undef, $caller1) = caller(1);
    my (undef, undef, undef, $caller2) = caller(2);

    $caller1 =~ s/^TeX::Parser:://;
    $caller2 =~ s/^TeX::Parser:://;

    my $class = ref($token) || '';

    my $string;

    if (ref($token)) {
        $string = '(' . $token->get_datum(). ", " . $token->get_catcode() . ')';
    } else {
        $string = $token;
    }

    my $line = $self->get_line_no();

    print STDERR "Line $line ($caller1): token = $string called from $caller2\n";
}

sub null_handler($$) {
    my $self  = shift;
    my $token = shift;

    $self->add_to_buffer($token);

    return;
}

sub __capture_text_into( $ ) {
    my $text_r = shift;

    return sub {
        my $parser = shift;
        my $text   = shift;

        ${ $text_r } .= $text if defined $text; # ->to_string();

        return;
    };
}

sub __make_handler {
    my $self    = shift;
    my $handler = shift;

    if (ref($handler) eq 'CODE') {
        return $handler;
    } elsif (blessed($handler) && $handler->isa('TeX::Parser::Macro')) {
        return $handler;
    } elsif (ref($handler) eq 'SCALAR') {
        return __capture_text_into($handler);
    } else {
        $self->warn(shortmess "Invalid handler: neither a code ref or a scalar ref");
    }
}

######################################################################
##                                                                  ##
##                           CONSTRUCTORS                           ##
##                                                                  ##
######################################################################

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->clear_handlers();

    $self->set_handler(def => \&do_def);

    $self->set_handler(input => \&do_input);

    return;
}

{ no warnings qw(redefine);

  sub clone {
      my $self = shift;

      my $class = ref $self;

      my $clone = $class->new({ encoding      => $self->get_encoding(),
                                end_line_char => $self->get_end_line_char(),
                              });

      my $parent_ident = ident $self;
      my $clone_ident  = ident $clone;

      $handlers{$clone_ident}         = { %{ $handlers{$parent_ident} } };
      $catcode_handlers{$clone_ident} = [ @{ $catcode_handlers{$parent_ident} } ];
      $default_handler{$clone_ident}  = $default_handler{$parent_ident};

      $clone->copy_catcodes($self);

      return $clone;
  }
}

######################################################################
##                                                                  ##
##                         CATCODE HANDLERS                         ##
##                                                                  ##
######################################################################

sub __set_catcode_handler {
    my $self = shift;

    my $catcode = shift;
    my $handler = $self->__make_handler(shift);

    return $catcode_handlers{ident $self}->[$catcode] = $handler;
}

sub delete_catcode_handler {
    my $self = shift;

    my $catcode = shift;

    delete $catcode_handlers{ident $self}->[$catcode];

    return;
}

sub __get_raw_catcode_handler {
    my $self = shift;

    my $catcode = shift;

    if (blessed($catcode) && $catcode->isa("TeX::Token")) {
        $catcode = $catcode->get_catcode();
    }

    return $catcode_handlers{ident $self}->[$catcode];
}

sub __get_catcode_handler {
    my $self = shift;

    my $catcode = shift;

    return $self->__get_raw_catcode_handler($catcode)
        || $self->get_default_handler();
}

sub set_begin_group_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_BEGIN_GROUP, $handler);
}

sub begin_group_handler {
    my $self = shift;
    my $text = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_BEGIN_GROUP);

    return $handler->($self, $text);
}

sub set_end_group_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_END_GROUP, $handler);
}

sub end_group_handler {
    my $self = shift;
    my $text = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_END_GROUP);

    return $handler->($self, $text);
}

sub set_math_shift_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_MATH_SHIFT, $handler);
}

sub math_shift_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_MATH_SHIFT);

    return $handler->($self, $char);
}

sub set_alignment_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_ALIGNMENT, $handler);
}

sub alignment_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_ALIGNMENT);

    return $handler->($self, $char);
}

sub set_parameter_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_PARAMETER, $handler);
}

sub parameter_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_PARAMETER);

    return $handler->($self, $char);
}

sub set_superscript_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_SUPERSCRIPT, $handler);
}

sub superscript_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_SUPERSCRIPT);

    return $handler->($self, $char);
}

sub set_subscript_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_SUBSCRIPT, $handler);
}

sub subscript_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_SUBSCRIPT);

    return $handler->($self, $char);
}

sub set_space_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_SPACE, $handler);
}

sub space_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_SPACE);

    return $handler->($self, $char);
}

sub set_letter_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_LETTER, $handler);
}

sub letter_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_LETTER);

    return $handler->($self, $char);
}

sub set_other_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_OTHER, $handler);
}

sub other_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_OTHER);

    return $handler->($self, $char);
}

sub set_active_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_ACTIVE, $handler);
}

sub active_handler {
    my $self = shift;
    my $char = shift;

    my $handler = $self->__get_catcode_handler(CATCODE_ACTIVE);

    return $handler->($self, $char);
}

sub set_comment_handler {
    my $self = shift;

    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_COMMENT, $handler);
}

sub set_csname_handler {
    my $self = shift;
    my $handler = shift;

    return $self->__set_catcode_handler(CATCODE_CSNAME, $handler);
}

sub get_comment_handler {
    my $self = shift;

    return $self->__get_catcode_handler(CATCODE_COMMENT);
}

sub delete_comment_handler {
    my $self = shift;

    delete $catcode_handlers{ident $self}->[CATCODE_COMMENT];

    return;
}

sub csname_handler {
    my $self   = shift;
    my $csname = shift;

    my $handler = $self->get_handler($csname);

    return $handler->($self, $csname);
}

sub default_handler {
    my $self   = shift;
    my $token = shift;

    my $handler = $self->get_default_handler();

    return $handler->($self, $token);
}

######################################################################
##                                                                  ##
##                         SPECIAL HANDLERS                         ##
##                                                                  ##
######################################################################

sub set_default_handler {
    my $self = shift;

    my $handler = $self->__make_handler(shift);

    return $default_handler{ident $self} = $handler;
}

sub delete_default_handler {
    my $self = shift;

    undef $default_handler{ident $self};

    return;
}

sub get_default_handler {
    my $self = shift;

    return $default_handler{ident $self} || \&null_handler;
}

## Typically, letters, spaces and other characters will be handled
## identically, so we provide a convenience method to set them all at
## the same time.

sub set_text_handlers {
    my $self = shift;

    my $handler = $self->__make_handler(shift);

    my $ident = ident $self;

    for my $catcode (CATCODE_SPACE, CATCODE_LETTER, CATCODE_OTHER) {
        $catcode_handlers{$ident}->[$catcode] ||= $handler;
    }

    return;
}

######################################################################
##                                                                  ##
##                          OUTPUT BUFFER                           ##
##                                                                  ##
######################################################################

sub add_to_buffer {
    my $self  = shift;
    my $token = shift;

    if ($self->buffer_output()) {
        $output_buffer_of{ident $self} .= $token;
    }

    return;
}

sub output_buffer {
    my $self = shift;

    return $output_buffer_of{ident $self};
}

sub clear_output_buffer {
    my $self = shift;

    my $ident = ident $self;

    my $output = $output_buffer_of{$ident};

    $output_buffer_of{$ident} = "";

    return $output;
}

sub push_output_buffer {
    my $self = shift;

    my $buffering = shift;

    my $saved_buffering = $self->buffer_output();
    my $saved_contents  = $self->clear_output_buffer();

    $self->push_output_stack([ $saved_buffering, $saved_contents ]);

    $self->set_buffer_output($buffering);

    return;
}

sub pop_output_buffer {
    my $self = shift;

    if ($self->num_output_stacks() < 1) {
        $self->warn(shortmess "Invalid attempt to pop output buffer");

        return;
    }

    my $contents = $self->clear_output_buffer();

    my ($saved_status, $saved_contents) = @{ $self->pop_output_stack() };

    $self->set_buffer_output($saved_status);
    $output_buffer_of{ident $self} = $saved_contents;

    return $contents;
}

sub par {
    my $self = shift;

    my $par_handler = $self->get_handler('par');

    if (defined $par_handler) {
        $par_handler->($self, PAR_TOKEN);
    }

    return;
}

######################################################################
##                                                                  ##
##                   CUSTOM CONTROL NAME HANDLERS                   ##
##                                                                  ##
######################################################################

sub let {
    my $self = shift;

    my $alias = shift;
    my $target = shift;

    $self->set_raw_handler($alias => $self->get_raw_handler($target));

    return;
}

sub set_handler {
    my $self = shift;

    my $csname  = shift;
    my $handler = $self->__make_handler(shift);

    return $handlers{ident $self}->{$csname} = $handler;
}

sub get_handler {
    my $self = shift;

    my $name = shift;

    my $handler = $self->get_raw_handler($name)
        || $self->__get_catcode_handler(CATCODE_CSNAME);

    if (blessed($handler) && $handler->can('expand')) {
        return sub { $handler->expand(@_) };
    }

    return $handler;
}

sub delete_handler {
    my $self = shift;

    my $csname  = shift;

    delete $handlers{ident $self}->{$csname};

    return;
}

sub get_raw_handler {
    my $self = shift;

    my $name = shift;

    return $handlers{ident $self}->{$name};
}

sub set_raw_handler {
    my $self = shift;

    my $name = shift;
    my $handler = shift;

    $handlers{ident $self}->{$name} = $handler;

    return;
}

######################################################################
##                                                                  ##
##                         STACK MANAGEMENT                         ##
##                                                                  ##
######################################################################

sub clear_handlers {
    my $self = shift;

    my $arg_ref = shift || {};

    my $keep_set;

    if (defined(my $keep = $arg_ref->{keep})) {
        $keep_set = $self->make_handler_set(@{ $keep });
    }

    $handlers{ident $self}         = {};
    $catcode_handlers{ident $self} = [];

    if (defined $keep_set) {
        $self->restore_handler_set($keep_set);
    }

    return;
}

sub save_handlers {
    my $self = shift;

    my $ident = ident $self;

    $self->push_handler_stack([ $default_handler{$ident},
                                { %{ $handlers{$ident} } },
                                [ @{ $catcode_handlers{$ident} } ] ]);

    return;
}

sub restore_handlers {
    my $self = shift;

    my $ident = ident $self;

    my $frame = $self->pop_handler_stack();

    $self->warn("Tried to pop empty handler stack") unless defined $frame;

    my ($default_handler, $handlers, $catcode_handlers) = @{ $frame };

    $handlers{$ident}         = $handlers;
    $catcode_handlers{$ident} = $catcode_handlers;
    $default_handler{$ident}  = $default_handler;

    return;
}

sub make_handler_set {
    my $self = shift;

    my %set;

    for my $csname (@_) {
        my $handler = $self->get_raw_handler($csname);

        $set{$csname} = $handler;
    }

    return \%set;
}

sub restore_handler_set {
    my $self = shift;

    my $set = shift;

    while (my ($csname, $handler) = each %{ $set }) {
        $self->set_raw_handler($csname, $handler);
    }

    return;
}

######################################################################
##                                                                  ##
##                         THE CORE PARSER                          ##
##                                                                  ##
######################################################################

sub insert_tokens {
    my $self = shift;

    local $_;

    for (reverse @_) {
        if (blessed($_) && $_->isa("TeX::TokenList")) {
            $self->unget_tokens($_->get_tokens());
        } else {
            $self->unget_tokens($_);
        }
    }

    return;
}

sub parse {
    my $self = shift;

    while (my $token = $self->get_next_token()) {
        my $handler;

        if ($token == CATCODE_CSNAME) {
            $handler = $self->get_handler($token->get_csname());
        } else {
            $handler = $self->__get_catcode_handler($token->get_catcode);
        }

        $handler->($self, $token);
    }

    $self->par();

    return;
}

######################################################################
##                                                                  ##
##                  MISCELLANEOUS PARSING METHODS                   ##
##                                                                  ##
######################################################################

use constant {
    octal_token => make_character_token("'", CATCODE_OTHER),
    hex_token   => make_character_token('"', CATCODE_OTHER),
    alpha_token => make_character_token('`', CATCODE_OTHER),
    point_token => make_character_token('.', CATCODE_OTHER),
    continental_point_token => make_character_token(',', CATCODE_OTHER),
};

my $TOKEN_PLUS  = make_character_token('+', CATCODE_OTHER);
my $TOKEN_MINUS = make_character_token('-', CATCODE_OTHER);
my $TOKEN_EQUAL = make_character_token('=', CATCODE_OTHER);

# Finalization glitch workaround.

END {
    undef $TOKEN_PLUS;
    undef $TOKEN_MINUS;
    undef $TOKEN_EQUAL;
}

sub require_token {
    my $self = shift;

    my $token = shift;

    my $next = $self->get_next_token();

    return unless defined $next;

    return 1 if $token == $next;

    $self->unget_tokens($next);

    return;
}

sub is_digit {
    my $self = shift;
    my $token = shift;

    return $token == CATCODE_OTHER && $token =~ /^\d$/;
}

sub is_octal_digit {
    my $self = shift;
    my $token = shift;

    return $token == CATCODE_OTHER && $token =~ /^[0-7]$/;
}

sub is_hex_digit {
    my $self = shift;
    my $token = shift;

    return 1 if $self->is_digit($token);

    return unless $token == CATCODE_LETTER || $token == CATCODE_OTHER;

    return $token =~ /^[A-F]$/;
}

sub is_implicit_space {
    my $self = shift;
    my $token = shift;

    ## This depends on the interpreter.

    return;
}

sub is_space_token {
    my $self = shift;
    my $token = shift;

    return $token == CATCODE_SPACE || $self->is_implicit_space($token);
}

sub skip_optional_spaces {
    my $self = shift;

    while (my $token = $self->get_x_token()) {
        next if $self->is_space_token($token);

        ## These could show up if we're in verbatim or non-filter mode.

        next if $token == CATCODE_END_OF_LINE;
        next if $token == CATCODE_INVALID;
        next if $token == CATCODE_IGNORED;
        next if $token == CATCODE_COMMENT;

        $self->unget_tokens($token);

        last;
    }

    return;
}

sub scan_one_optional_space {
    my $self = shift;

    my $token = $self->get_x_token();

    if (! $self->is_space_token($token)) {
        $self->unget_tokens($token);

        return;
    }

    return $token;
}

sub scan_optional_equals {
    my $self = shift;

    $self->skip_optional_spaces();

    my $token = $self->get_x_token();

    unless ($token == $TOKEN_EQUAL) {
        $self->unget_tokens($token);
    }

    return;
}

## Deprecated. skip_equals() is wrong and should go away.

sub skip_equals {
    my $self = shift;

    while (my $token = $self->get_next_token()) {
        next if $self->is_space_token($token);

        next if $token == $TOKEN_EQUAL;

        $self->unget_tokens($token);
        last;
    }

    return;
}

sub read_optional_signs {
    my $self = shift;

    my $sign = 1;

    while (my $token = $self->get_x_token()) {
        next if $self->is_space_token($token);

        ##* This is a good argument for making Token into a flyweight
        ##* class.

        next if $token == $TOKEN_PLUS;

        if ($token == $TOKEN_MINUS) {
            $sign *= -1;
            next;
        }

        $self->unget_tokens($token);
        last;
    }

    return $sign;
}

sub read_integer_constant {
    my $self = shift;

    my $number = 0;

    while (my $token = $self->get_x_token()) {
        if ($self->is_digit($token)) {
            $number .= $token;
            next;
        }

        if (! $self->is_space_token($token)) {
            $self->unget_tokens($token);
        }

        last;
    }

    return $number + 0;
}

sub read_octal_constant {
    my $self = shift;

    my $number = "";

    while (my $token = $self->get_x_token()) {
        if ($self->is_octal_digit($token)) {
            $number .= $token;
            next;
        }

        if (! $self->is_space_token($token)) {
            $self->unget_tokens($token);
        }

        last;
    }

    return oct($number);
}

sub read_hexadecimal_constant {
    my $self = shift;

    my $number = "";

    while (my $token = $self->get_x_token()) {
        if ($self->is_hex_digit($token)) {
            $number .= $token;
            next;
        }

        if (! $self->is_space_token($token)) {
            $self->unget_tokens($token);
        }

        last;
    }

    return hex($number);
}

sub read_alphabetic_constant {
    my $self = shift;

    my $token = $self->get_x_token();

    if (! defined($token)) {
        $self->warn("End of input while looking for alphabetic constant");
    }

    if ($token == CATCODE_CSNAME) {
        my $char = $token->get_csname();

        if (length($char) != 1) {
            my $line = $self->get_line_no();

            $self->warn("Improper alphabetic constant \\$char");
        }

        return ord($char);
    }

    return ord($token->get_datum());
}

sub read_literal_integer {
    my $self = shift;

    my $next_token = $self->get_x_token();

    if (! defined($next_token)) {
        $self->warn("End of input while reading integer literal");
    }

    if ($next_token == CATCODE_CSNAME) {
        $self->warn("Can't handle <internal integer> ($next_token) yet");
    }

    if ($next_token == octal_token) {
        return $self->read_octal_constant();
    }

    if ($next_token == hex_token) {
        return $self->read_hexadecimal_constant();
    }

    if ($next_token == alpha_token) {
        return $self->read_alphabetic_constant();
    }

    if ($self->is_digit($next_token)) {
        $self->unget_tokens($next_token);
        return $self->read_integer_constant();
    }

    my $line = $self->get_line_no();

    $self->warn("Invalid integer: '$next_token'");
}

sub read_unsigned_number {
    my $self = shift;

    my $next_token = $self->get_x_token();

    $self->unget_tokens($next_token);

    if ($next_token->is_character()) {
        return $self->read_literal_integer();
    } else {
        $self->warn("TeX::Parser can only understand literal integers");
    }

    #* or <coerced integer>
}

sub read_number {
    my $self = shift;

    my $sign = $self->read_optional_signs();

    my $number = $self->read_unsigned_number();

    return $sign * $number;
}

sub get_x_token {
    my $self = shift;

    my $next = $self->get_next_token();

    return unless defined $next;

    if ($next == CATCODE_CSNAME) {
        my $raw_handler = $self->get_raw_handler($next->get_csname());

        if (blessed($raw_handler) && $raw_handler->can('expand')) {
            $raw_handler->expand($self, $next);

            return $self->get_x_token();
        }
    }

    return $next;
}

sub get_maybe_expanded_token {
    my $self = shift;

    my $expanded = shift;

    if ($expanded) {
        return $self->get_x_token();
    }

    return $self->get_next_token();
}

sub peek_x_token {
    my $self = shift;

    my $next = $self->get_x_token();

    $self->unget_tokens($next);

    return $next;
}

sub peek_nonspace_token {
    my $self = shift;

    my $saved = new_token_list;

    my $next;

    while (my $token = $self->get_next_token()) {
        $saved->push($token);

        next if $self->is_space_token($token);

        next if $token == CATCODE_END_OF_LINE;

        $next = $token;

        last;
    }

    $self->unget_tokens($saved->get_tokens());

    return $next;
}

sub peek_x_nonspace_token {
    my $self = shift;

    my $saved = new_token_list;

    my $next;

    while (my $x_token = $self->get_x_token()) {
        $saved->push($x_token);

        next if $self->is_space_token($x_token);

        next if $x_token == CATCODE_END_OF_LINE;

        $next = $x_token;

        last;
    }

    $self->unget_tokens($saved->get_tokens());

    return $next;
}

##  Assumes the { has already been consumed.  Leaves the closing } to
##  be read again.

sub read_balanced_text {
    my $self = shift;

    my $def = shift;

    my $expanded = shift || 0;

    my $balanced = new_token_list;

    my $level = 0;

    while (my $token = $self->get_maybe_expanded_token($expanded)) {
        if ($token == CATCODE_END_GROUP) {
            if ($level == 0) {
                $self->unget_tokens($token);

                last;
            }

            $level--;
        } elsif ($token == CATCODE_BEGIN_GROUP) {
            $level++;
        }

        if ($token == CATCODE_PARAMETER) {
            if (! $def) {
                $self->warn("Not a definition: You can't use the macro parameter $token here");
            }

            my $next = $self->get_maybe_expanded_token();

            if (! defined($next)) {
                $self->warn("End of input while reading balanced text");
            }

            if ($next == CATCODE_PARAMETER) {
                $balanced->push($next);
                $balanced->push($next);
            } elsif ($next == CATCODE_OTHER && $next =~ /[1-9]/) {
                $balanced->push(make_param_ref_token($next->get_datum()));
            } else {
                $self->warn("You can't the macro parameter $token before $next");
            }

            next;
        }

        $balanced->push($token);
    }

    return $balanced;
}

sub read_parameter_text {
    my $self = shift;

    my @parameter_text;

    my $max_arg = 0;

    while (my $token = $self->get_next_token()) {
        last if $token == CATCODE_BEGIN_GROUP;

        if ($token == CATCODE_END_GROUP) {
            $self->warn("Illegal end of group $token in parameter text");
        }

        if ($token == CATCODE_PARAMETER) {
            my $next_token = $self->get_next_token();

            if (! defined($next_token)) {
                $self->warn("End of input while reading parameter text");
            }

            if ($next_token == CATCODE_OTHER) {
                my $char = $next_token->get_char();

                if ($char =~ /^[0-9]$/) {
                    if ($char == ++$max_arg) {
                        push @parameter_text, make_param_ref_token($char);
                    } else {
                        $self->warn("Parameter numbers must be consecutive");
                    }
                } else {
                    push @parameter_text, $next_token;
                }
            } elsif ($next_token == CATCODE_BEGIN_GROUP) {
                push @parameter_text, $next_token;
                last;
            } else {
                push @parameter_text, $token;
            }

            next;
        }

        push @parameter_text, $token;
    }

    return new_token_list(@parameter_text);
}

sub read_replacement_text {
    my $self = shift;

    my $expanded = shift;

    my $replacement_text = $self->read_balanced_text(1, $expanded);

    $self->consume_next_token();

    return $replacement_text;
}

## This reads as much of the parameter_text as possible, but if it
## can't read the entire parameter_text, it returns an empty list and
## loses any tokens that it has already read.  It might be useful to
## have a version that returns the input buffer to it's original state
## if it can't read the entire expected text.

sub read_macro_parameters {
    my $self = shift;

    my @parameter_text;

    while (my $arg = shift) {
        if (reftype($arg) eq 'ARRAY') {
            push @parameter_text, @{ $arg};
        } elsif (blessed($arg) && $arg->isa('TeX::TokenList')) {
            push @parameter_text, $arg->get_tokens();
        } elsif (blessed($arg) && $arg->isa('TeX::Token')) {
            push @parameter_text, $arg;
        } else {
            my $tl = $self->__parameterize($self->tokenize($arg));

            push @parameter_text, $tl->get_tokens();
        }
    }

    my @parameters = (undef);

    while (my $token = shift @parameter_text) {
        if ($token->is_param_ref()) {
            my $next = $parameter_text[0];

            my $arg;

            if ( (! defined $next) || $next->is_param_ref()) {
                $arg = $self->read_undelimited_parameter();
            } else {
                $arg = $self->read_delimited_parameter($next);

                shift @parameter_text;
            }

            push @parameters, $arg;
        } else {
            return unless $self->require_token($token);
        }
    }

    return @parameters;
}

sub read_expanded_parameter {
    my $self = shift;

    return $self->read_undelimited_parameter(undef, 1);
}

sub read_undelimited_parameter {
    my $self = shift;

    my $as_def   = shift; # This is probably deprecated;
    my $expanded = shift;

    my $token = $self->get_next_token();

    if (! defined($token)) {
        $self->warn(shortmess "End of input while reading undelimited parameter");

        return;
    }

    while ($token == CATCODE_SPACE) {
        $token = $self->get_next_token();
    }

    if (! defined($token)) {
        $self->warn(shortmess "End of input while reading undelimited parameter");

        return;
    }

    my $token_list;

    if ($token == CATCODE_BEGIN_GROUP) {
        $token_list = $self->read_balanced_text($as_def, $expanded);

        $self->consume_next_token();
    } else {
        $token_list = new_token_list($token);
    }

    return $token_list;
}

sub read_delimited_parameter {
    my $self  = shift;
    my $limit = shift;

    my $parameter = new_token_list;

    while (my $token = $self->get_next_token()) {
        last if $token == $limit;

        if ($token == CATCODE_BEGIN_GROUP) {
            my $balanced = $self->read_balanced_text();

            my $closing_brace = $self->get_next_token();

            if (! defined($closing_brace)) {
                $self->warn("End of input: expected '}'");
            }

            if ($parameter->length() == 0) {
                my $next_token = $self->peek_next_token();

                if ($next_token == $limit) {
                    $parameter = $balanced;

                    $self->consume_next_token();

                    last;
                }
            }

            $parameter->push($token, $balanced, $closing_brace);

            next;
        }

        $parameter->push($token);
    }

    return $parameter;
}

## See normalizetex for an example of looks_like_assignment() in
## action.  Strictly speaking, it's completely wrong since you have to
## look at what comes before the dimen or glue variable to know
## whether it's being used in an assignment context.  Also, this only
## recognizes assignments to literal values.  However, this should be
## good enough for most uses.

sub looks_like_assignment {
    my $tex = shift;

    my $result = 0;

    my $saved = new_token_list;

    $tex->skip_optional_spaces();

    my $next = $tex->get_next_token();

    $saved->push($next);

    if ($next == $TOKEN_EQUAL) {
        $tex->skip_optional_spaces();
        $next = $tex->get_next_token();

        $saved->push($next);
    }

    if ($next == $TOKEN_MINUS) {
        $tex->skip_optional_spaces();
        $next = $tex->get_next_token();

        $saved->push($next);
    }

    if ($tex->is_digit($next)) {
        $result = 1;
    } elsif ($next == point_token || $next == continental_point_token) {
        $next = $tex->get_next_token();

        $saved->push($next);

        if ($tex->is_digit($next)) {
            $result = 1;
        }
    }

    $tex->insert_tokens($saved);

    return $result;
}

sub scan_file_name {
    my $tex = shift;

    my $name = new_token_list;

    ## TeX expands tokens while reading filenames, but TeX::Parser
    ## doesn't implement expansion, so we're limited to scanning
    ## constant filenames. This means we can't handle things like
    ##
    ##     \input\subdirectory/foo.tex
    ##
    ## and we have to treat control sequences and active characters as
    ## file name terminators.
    ##
    ## This is similar to the way that read_integer_constant() can
    ## only process explicit integers.

    while (my $token = $tex->peek_next_token()) {
        my $catcode = $token->get_catcode();

        # TeX disallows anything above CATCODE_OTHER.  In our case,
        # this will include active characters and comments.

        last if $catcode > CATCODE_OTHER;

        ## We have to check for the next two because verbatim mode
        ## might let them through.  Note that ignored characters don't
        ## terminate the filename.

        next if $catcode == CATCODE_IGNORED;
        last if $catcode == CATCODE_END_OF_LINE;

        ## We can't expand macros, so we treat a control sequence as
        ## the end of the filename.

        last if $catcode == CATCODE_CSNAME;

        last if $catcode == CATCODE_SPACE;

        $name->push($token);

        $tex->consume_next_token();
    }

    return $name;
}

######################################################################
##                                                                  ##
##                       SCANNING DIMENSIONS                        ##
##                                                                  ##
######################################################################

sub scan_keyword {
    my $tex = shift;

    my $s = shift;

    my $scanned = new_token_list;

    my $match = 1;

    my @chars = split '', $s;

    for my $char (split '', $s) {
        my $token = $tex->get_x_token();

        $scanned->push($token);

        if ($token < CATCODE_ACTIVE) {
            my $this_char = $token->get_char();

            if (lc($this_char) ne lc($char)) {
                $match = 0;

                last;
            }
        } elsif (! $tex->is_space_token($token) || $scanned->length() > 0) {
            $match = 0;

            last;
        }
    }

    if (! $match) {
        $tex->unget_tokens($scanned->get_tokens());
    }

    return $match;
}

## NOTE: This returns the dimen as a string, *not* a TokenList.  This
## also does minimal sanity checking.

sub scan_dimen {
    my $tex = shift;

    my $sign = $tex->read_optional_signs();

    my $cur_val;

    my $cur_tok = $tex->peek_next_token();

    unless ($cur_tok == continental_point_token || $cur_tok == point_token) {
        $cur_val = $tex->read_number();
    }

    $cur_tok = $tex->peek_next_token();

    if ($cur_tok == continental_point_token || $cur_tok == point_token) {
        $tex->get_next_token();

        $cur_val .= ".";

        if ((my $frac = $tex->read_integer_constant()) > 0) {
            $cur_val .= $frac;
        }
    }

    # @<Scan for \(a)all other units and adjust |cur_val| and |f| accordingly;
    #   |goto done| in the case of scaled points@>;

    if ($tex->scan_keyword('true')) {
        $tex->skip_optional_spaces();
    }

    for my $unit (qw(pt in pc cm mm bp dd nd cc nc sp em ex)) {
        if ($tex->scan_keyword($unit)) {
            $cur_val .= $unit;

            last;
        }
    }

    $tex->scan_one_optional_space();

    if ($sign < 0) {
        $cur_val = "-" . $cur_val;
    }

    return $cur_val;
}

## TBD: scan_glue() needs to be finished.

sub scan_glue {
    my $tex = shift;

    return $tex->scan_dimen();
}

######################################################################
##                                                                  ##
##                           DEFINITIONS                            ##
##                                                                  ##
######################################################################

## This should probably be built into tokenize();

sub __parameterize {
    my $self = shift;

    my $in = shift;

    my $out = new_token_list();

    my @tokens = $in->get_tokens();

    while (my $token = shift @tokens) {
        if ($token == CATCODE_PARAMETER) {
            my $next = shift @tokens;

            if ($next == CATCODE_PARAMETER) {
                $out->push(next);
                $out->push(next);
            } elsif ($next == CATCODE_OTHER && $next =~ /[1-9]/) {
                $out->push(make_param_ref_token($next->get_datum()));
            } else {
                $self->warn("You can't the macro parameter $token before $next");
            }
        } else {
            $out->push($token);
        }
    }

    return $out;
}

sub define_macro {
    my $tex = shift;

    my $csname     = shift;
    my $param_text = shift;
    my $macro_text = shift;
    my $opt_arg    = shift;

    unless (blessed $param_text && $param_text->isa("TeX::TokenList")) {
        my $tl = $tex->tokenize($param_text);

        $param_text = $tex->__parameterize($tl);
    }

    if (blessed($macro_text)) {
        if ($macro_text->isa("TeX::Token")) {
            $macro_text = new_token_list($macro_text);
        } elsif (! $macro_text->isa("TeX::TokenList")) {
            die "wut?";
        }
    } else {
        my $tl = $tex->tokenize($macro_text);

        $macro_text = $tex->__parameterize($tl);
    }

    if ($macro_text->contains(FI_TOKEN)) {
        $tex->verbose("\\$csname looks like it contains a conditional; skipping it\n");

        return;
    }

    if (defined $opt_arg) {
        unless (blessed $opt_arg && $opt_arg->isa("TeX::TokenList")) {
            $opt_arg = $tex->tokenize($opt_arg);
        }
    }

    my $macro = make_macro($param_text, $macro_text, $opt_arg);

    $tex->set_handler($csname, $macro);

    return;
}

sub do_def {
    my $tex   = shift;
    my $token = shift;

    if (! $tex->execute_defs()) {
        $tex->csname_handler($token);

        return;
    }

    my $expanded = ($token->get_csname() =~ m{^[ex]def$});

    my $control_sequence = $tex->read_undelimited_parameter();

    if ($control_sequence->length() != 1) {
        my $line_no = $tex->get_line_no();

        $tex->warn("Malformed ${token}{$control_sequence}");

        return;
    }

    my $param_text = $tex->read_parameter_text();
    my $macro_text = $tex->read_replacement_text($expanded);

    ## TBD Check that this is either a csname or an active character.

    my $csname = $control_sequence->index(0)->get_csname();

    $tex->define_macro($csname, $param_text, $macro_text);

    return;
}

######################################################################
##                                                                  ##
##                            FILE INPUT                            ##
##                                                                  ##
######################################################################

sub do_input($$) {
    my $self = shift;
    my $csname = shift;

    my $file_name = $self->scan_file_name();

    if ($self->execute_input()) {
        $self->__process_included_file($file_name);
    }

    return;
}

my %SKIPPED_FILE = (pstricks => 1,
                    pictex   => 1,
                    xy => 1,
                    xyv2 => 1,
                    cyracc => 1);

sub __skip_file :PROTECTED {
    my $self = shift;

    my $filename = shift;

    return 1 if $filename =~ m{^/};

    (my $basename = basename($filename)) =~ s{\.[^.]+$}{};

    return 1 if $SKIPPED_FILE{$basename};

    return 1 if $filename =~ m{\.(pstex|eps)_t$};

    return;
}

sub __process_included_file {
    my $self = shift;

    my $token_list = shift;

    my $file_name = $token_list->to_string();

    if (empty $file_name) {
        $self->warn("Null filename");

        return;
    }

    ## Don't try to read the pstricks or xy packages.  This is ugly,
    ## but it avoids problems with authors write "\input pstricks" or
    ## "\input xy" instead of "\usepackage{pstricks}" or
    ## "\usepackage{xy}".

    if ( $self->__skip_file($file_name)) {
        # $self->warn("Skipping file $file_name\n");

        return;
    }

    ## GRRR.  TeX::KPSE is only available inside the AMS, so only load
    ## it if it's actually needed.  It will only be needed if
    ## execute_input is true and either \input or \include is
    ## encountered.

    require TeX::KPSE;

    my $path = TeX::KPSE::kpse_lookup($file_name);

    return if $path =~ m{^/};

    if (empty $path) {
        $path = TeX::KPSE::kpse_lookup("$file_name.tex");
    }

    if (! defined $path) {
        $self->warn("Can't find file $file_name");

        return;
    }

    $self->push_input();

    $self->bind_to_file($path);

    $self->parse();

    $self->pop_input();

    return;
}

######################################################################
##                                                                  ##
##                             MODULES                              ##
##                                                                  ##
######################################################################

my %module_list_of :HASH(:name<module_list>);

use constant {
    LOAD_FAILED    => 0,
    LOAD_SUCCESS   => 1,
    ALREADY_LOADED => 2,
};

sub load_module {
    my $tex = shift;

    my @options = @_;

    my $module = shift;

    (my $module_file = $module) =~ s{::}{/}g;

    $module_file .= ".pm";

    if (! exists $INC{$module_file}) {
        eval { require $module_file };

        if ($@) {
            if ($@ !~ m/^Can\'t locate \Q$module_file\E/) {
                $tex->warn($@);
            }

            return LOAD_FAILED;
        }
    }

    # $tex->warn("Installing macro class $module_file");

    eval { $module->install($tex, @options) };

    if ($@) {
        $tex->warn("Can't install macro class $module_file: $@");
    }

    return LOAD_SUCCESS;
}

######################################################################
##                                                                  ##
##                       PUBLIC ENTRY POINTS                        ##
##                                                                  ##
######################################################################

sub parse_file( $ ) {
    my $self = shift;
    my $file = shift;

    $self->bind_to_file($file);

    $self->parse();

    return;
}

sub parse_string( $ ) {
    my $self   = shift;
    my $string = shift;

    $self->bind_to_string($string);

    $self->parse();

    return;
}

## Should this return a token list instead of a string?

sub expand_string {
    my $self = shift;

    my $tex_string = shift;

    my $sub_parser = $self->clone();

    $sub_parser->delete_handler('par');

    $sub_parser->bind_to_string($tex_string);

    $sub_parser->set_handler(par => sub {});

    ## If we stop using the default_handler to collect output into a
    ## string, we can probably do without the following line.

    $sub_parser->set_default_handler(\&null_handler);

    $sub_parser->set_buffer_output(1);

    $sub_parser->clear_output_buffer();

    $sub_parser->parse();

    return $sub_parser->output_buffer();
}

1;

__END__
