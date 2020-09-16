package TeX::Parser;

use strict;
use warnings;

use version; our $VERSION = qv '1.14.0';

use base qw(TeX::Lexer);

use PTG::Class;

use Carp;

use PTG::Errors;
use PTG::Utils;

use TeX::WEB2C qw(:catcodes);
use TeX::Token qw(:factories);
use TeX::TokenList;

use UNIVERSAL;

my %handler_stack    :ARRAY(:name<handler_stack>);
my %catcode_handlers :ATTR;
my %handlers         :ATTR;
my %default_handler  :ATTR;

my %math_nesting_of :COUNTER(:name<math_nesting>);

sub SHOUT { print STDERR @_; }

sub __report_token($$) {
    my $parser = shift;
    my $token  = shift;

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

    my $line = $parser->get_line_no();

    print STDERR "Line $line ($caller1): token = $string called from $caller2\n";
}

sub null_handler($$) {
    my $parser = shift;
    my $input  = shift;

    return;
}

sub __capture_text_into( $ ) {
    my $text_r = shift;

    return sub {
        my $parser = shift;
        my $text   = shift;

        ${ $text_r } .= $text; # ->to_string();

        return;
    };
}

sub __make_handler( $ ) {
    my $handler = shift;

    if (ref($handler) eq 'CODE') {
        return $handler;
    } elsif (ref($handler) eq 'SCALAR') {
        return __capture_text_into($handler);
    } else {
        croak "Invalid handler: neither a code ref or a scalar ref";
    }
}

######################################################################
##                                                                  ##
##                           CONSTRUCTORS                           ##
##                                                                  ##
######################################################################

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->clear_handlers();

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
    my $handler = __make_handler(shift);

    return $catcode_handlers{ident $self}->[$catcode] = $handler;
}

sub __get_raw_catcode_handler {
    my $self = shift;

    my $catcode = UNIVERSAL::isa($_[0], "TeX::Token") ? $_[0]->get_catcode() : $_[0];

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

    my $handler = __make_handler(shift);

    return $default_handler{ident $self} = $handler;
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

    my $handler = __make_handler(shift);

    my $ident = ident $self;

    for my $catcode (CATCODE_SPACE, CATCODE_LETTER, CATCODE_OTHER) {
        $catcode_handlers{$ident}->[$catcode] ||= $handler;
    }

    return;
}

######################################################################
##                                                                  ##
##                   CUSTOM CONTROL NAME HANDLERS                   ##
##                                                                  ##
######################################################################

sub set_handler {
    my $self = shift;

    my $csname  = shift;
    my $handler = __make_handler(shift);

    return $handlers{ident $self}->{$csname} = $handler;
}

sub get_handler {
    my $self = shift;

    my $name = shift;

    return $self->get_raw_handler($name)
        || $self->__get_catcode_handler(CATCODE_CSNAME);
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

######################################################################
##                                                                  ##
##                         STACK MANAGEMENT                         ##
##                                                                  ##
######################################################################

sub clear_handlers {
    my $self = shift;

    $handlers{ident $self}         = {};
    $catcode_handlers{ident $self} = [];

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

    croak "Tried to pop empty handler stack" unless defined $frame;

    my ($default_handler, $handlers, $catcode_handlers) = @{ $frame };

    $handlers{$ident}         = $handlers;
    $catcode_handlers{$ident} = $catcode_handlers;
    $default_handler{$ident}  = $default_handler;

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
        if (UNIVERSAL::isa($_, "TeX::TokenList")) {
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
    }

    return;
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
        croak "End of input while looking for alphabetic constant";
    }

    if ($token == CATCODE_CSNAME) {
        my $char = $token->get_csname();

        if (length($char) != 1) {
            my $line = $self->get_line_no();

            fatal_error "Improper alphabetic constant \\$char on line $line";
        }

        return ord($char);
    }

    return ord($token->get_datum());
}

sub read_literal_integer {
    my $self = shift;

    my $next_token = $self->get_x_token();

    if (! defined($next_token)) {
        croak "End of input while reading integer literal";
    }

    if ($next_token == CATCODE_CSNAME) {
        croak "Can't handle <internal integer> ($next_token) yet";
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

    fatal_error "Invalid integer: '$next_token' on line $line\n";
}

sub read_unsigned_number {
    my $self = shift;

    my $next_token = $self->get_x_token();

    $self->unget_tokens($next_token);

    if ($next_token->is_character()) {
        return $self->read_literal_integer();
    } else {
        croak "TeX::Parser can only understand literal integers";
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

    return $self->get_next_token();
}

sub get_maybe_expanded_token {
    my $self = shift;

    my $expanded = shift;

    if ($expanded) {
        return $self->get_x_token();
    }

    return $self->get_next_token();
}

##  Assumes the { has already been consumed.  Leaves the closing } to
##  be read again.

sub read_balanced_text {
    my $self = shift;

    my $def = shift;

    my $expanded = shift || 0;

    my $balanced = TeX::TokenList->new();

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
                my $line = $self->get_line_no();

                fatal_error "Not a definition: You can't use the macro parameter $token here on line $line\n";
            }

            my $next = $self->get_maybe_expanded_token();

            if (! defined($next)) {
                croak "End of input while reading balanced text";
            }

            if ($next == CATCODE_PARAMETER) {
                $balanced->push($next);
                $balanced->push($next);
            } elsif ($next == CATCODE_OTHER && $next =~ /[1-9]/) {
                $balanced->push(make_param_ref_token($next->get_datum()));
            } else {
                my $line = $self->get_line_no();

                fatal_error "You can't the macro parameter $token before $next on line $line\n";
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
            fatal_error("Illegal end of group $token in parameter text ",
                        "on line ",
                        $self->get_line_no(),
                        " of ",
                        $self->get_file_name(),
                        "\n");
        }

        if ($token == CATCODE_PARAMETER) {
            my $next_token = $self->get_next_token();

            if (! defined($next_token)) {
                croak "End of input while reading parameter text";
            }

            if ($next_token == CATCODE_OTHER) {
                my $char = $next_token->get_char();

                if ($char =~ /^[0-9]$/) {
                    if ($char == ++$max_arg) {
                        push @parameter_text, make_param_ref_token($char);
                    } else {
                        fatal_error("Parameter numbers must be consecutive ",
                                    "on line ",
                                    $self->get_line_no(),
                                    " of ",
                                    $self->get_file_name(),
                                    "\n");
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

    return TeX::TokenList->new({ tokens => \@parameter_text });
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

    if (@_ == 1 && ref($_[0]) eq 'ARRAY') {
        @parameter_text = @{ $_[0] };
    } else {
        @parameter_text = @_;
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

sub read_undelimited_parameter {
    my $self = shift;

    my $as_def = shift;

    my $token = $self->get_next_token();

    if (! defined($token)) {
        croak "End of input while reading undelimited parameter";
    }

    while ($token == CATCODE_SPACE) {
        $token = $self->get_next_token();
    }

    if (! defined($token)) {
        croak "End of input while reading undelimited parameter";
    }

    my $token_list;

    if ($token == CATCODE_BEGIN_GROUP) {
        $token_list = $self->read_balanced_text($as_def);

        $self->consume_next_token();
    } else {
        $token_list = TeX::TokenList->new({ tokens => [ $token ] });
    }

    return $token_list;
}

sub read_delimited_parameter {
    my $self  = shift;
    my $limit = shift;

    my $parameter = TeX::TokenList->new();

    while (my $token = $self->get_next_token()) {
        last if $token == $limit;

        if ($token == CATCODE_BEGIN_GROUP) {
            my $balanced = $self->read_balanced_text();

            my $closing_brace = $self->get_next_token();

            if (! defined($closing_brace)) {
                croak "End of input: expected '}'";
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

    my $saved = TeX::TokenList->new();

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

    my $name = TeX::TokenList->new();

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

    my $scanned = TeX::TokenList->new();

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

1;

__END__
