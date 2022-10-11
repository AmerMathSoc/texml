package TeX::Interpreter;

# Copyright (C) 2022 American Mathematical Society
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

our $TRACING = 1;

sub TRACE {
    return unless $TRACING;

    my $subroutine = (caller(1))[3];

    $subroutine =~ s{^TeX::Interpreter::}{};

    print STDERR "\n*** ${subroutine}: ", @_;

    return;
}

use strict;
use warnings;

use version; our $VERSION = qv '1.10.1';

use base qw(Exporter);

our %EXPORT_TAGS = (all            => [ qw(make_eqvt) ],
                    frozen_csnames => [ qw(END_TEX_TOKEN
                                           FROZEN_CR
                                           FROZEN_DONT_EXPAND_TOKEN
                                           FROZEN_END_GROUP
                                           FROZEN_FI
                                           FROZEN_NULL_FONT
                                           FROZEN_PAR
                                           FROZEN_PRIMITIVE_TOKEN
                                           FROZEN_RELAX
                                           FROZEN_RIGHT
                                           UNDEFINED_CS) ],

    );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} },
                   @{ $EXPORT_TAGS{frozen_csnames} },
    );

our @EXPORT;

use Carp;

use TeX::Class;

use Fcntl qw(:seek);

use File::Basename;
use File::Spec::Functions;

use List::Util qw(none uniq);

use TeX::Utils::Unicode::Diacritics qw(apply_accent);

use TeX::Utils::Misc;

use TeX::Arithmetic qw(:arithmetic :string);

use TeX::Constants qw(:all);

use TeX::FMT::File;

use TeX::KPSE qw(kpse_lookup);

use TeX::Utils;
use TeX::Node::Utils qw(nodes_to_string);

use TeX::WEB2C qw(:all);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Interpreter::Constants;

use TeX::Token qw(:catcodes :constants :factories);

use TeX::Token::Constants;

use TeX::TokenList qw(:factories);

use TeX::Type::GlueSpec qw(:factories);

use TeX::Nodes qw(:factories);

use TeX::Node::HListNode qw(new_null_box);
use TeX::Node::XmlComment;
use TeX::Node::XmlAttributeNode;
use TeX::Node::XmlClassNode qw(:constants);
use TeX::Node::XmlImportNode;

use TeX::Node::MathOpenNode;
use TeX::Node::MathCloseNode;

use TeX::Node::Extension::UnicodeCharNode qw(:factories);
use TeX::Node::Extension::UnicodeStringNode qw(:factories);

use TeX::Primitive::CharGiven;
use TeX::Primitive::Macro     qw(make_anonymous_macro);
use TeX::Primitive::MathGiven qw(make_math_given);
use TeX::Primitive::Parameter qw(:factories);
use TeX::Primitive::Prefix;
use TeX::Primitive::Register;
use TeX::Primitive::SetFont;
use TeX::Primitive::def;

use TeX::Output::FontMapper qw(decode_character);

use Unicode::UCD qw(charinfo);

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

use constant MATH_SHIFT_TOKEN => make_character_token('\$', CATCODE_MATH_SHIFT);
use constant TAB_TOKEN        => make_character_token('&', CATCODE_ALIGNMENT);
use constant SPACE_TOKEN      => make_character_token(' ', CATCODE_SPACE);

## The following properly belong to BASIC SCANNING ROUTINES [26], but
## were moved here because point_token is useful elsewhere.

use constant {
    octal_token => make_character_token("'", CATCODE_OTHER),
    hex_token   => make_character_token('"', CATCODE_OTHER),
    alpha_token => make_character_token('`', CATCODE_OTHER),
    point_token => make_character_token('.', CATCODE_OTHER),
    continental_point_token => make_character_token(',', CATCODE_OTHER),
};

my $TOKEN_PLUS   = make_character_token('+', CATCODE_OTHER);
my $TOKEN_MINUS  = make_character_token('-', CATCODE_OTHER);
my $TOKEN_EQUAL  = make_character_token('=', CATCODE_OTHER);

use constant DEV_NULL => "/dev/null";

use constant EMPTY_TOKEN_LIST => new_token_list();

######################################################################
##                                                                  ##
##                         CLASS ATTRIBUTES                         ##
##                                                                  ##
######################################################################

my %fmt_of :ATTR(:name<fmt>);

my %fmt_file_of :ATTR(:name<fmt_file>);

my %interaction_mode_of :ATTR(:name<interaction_mode> :default<error_stop_mode>);

my %cur_font_of :ATTR(:name<cur_font> :default(-1));
my %cur_lang_of :ATTR(:name<cur_lang> :set<*custom*> :default(0)); #*
my %cur_enc_of  :ATTR;

my %cur_page_of :ARRAY(:name<cur_page>);

my %debugging_of :BOOLEAN(:name<debugging> :default<false>);

my %profiling_of :BOOLEAN(:name<profiling> :default<false>);

my %nofiles_of :BOOLEAN(:name<nofiles> :get<nofiles> :default<false>);

my %newlines_per_par_of :COUNTER(:name<newlines_per_par> :default<2>);

my %unicode_input_of :BOOLEAN(:name<unicode_input> :default<false>);
my %unicode_output_of :BOOLEAN(:name<unicode_output> :default<true>);

## The bindle attribute provides a place for clients to stash
## arbitrary bits of information.

my %bindle_of :HASH(:name<parcel>);

######################################################################
##                                                                  ##
##                          INITIALIZATION                          ##
##                                                                  ##
######################################################################

sub START {
    my ($tex, $ident, $arg_ref) = @_;

    ## iniTeX-type stuff goes here

    # @<Initialize whatever \TeX\ might access@>

    $tex->init_save_stack();

    $tex->init_semantic_nest();

    $tex->init_eqtb();

    $tex->init_prim();

    $tex->set_encoding("T1");

    return;
}

sub INITIALIZE :CUMULATIVE(BASE FIRST) {
    my $tex = shift;

    $tex->set_initialized(true);

    if (nonempty(my $fmt_file = $tex->get_fmt_file())) {
        $tex->load_fmt_file($fmt_file);
    } elsif (nonempty(my $fmt = $tex->get_fmt())) {
        $tex->load_format($fmt);
    }

    return;
}

######################################################################
##                                                                  ##
##                            DEBUGGING                             ##
##                                                                  ##
######################################################################

sub DEBUG {
    # my $tex = shift;

    return unless $_[0]->TeXML_debug_output();

    goto \&__DEBUG;
}

sub __DEBUG {
    my $tex = shift;

    my $subroutine = (caller(1))[3];

    $subroutine =~ s{^TeX::Interpreter::}{};

    my $file_name = $tex->get_file_name() || '<undef>';
    my $line_no   = $tex->input_line_no() || '<undef>';

    $subroutine .= " ($file_name, l. $line_no)";

    for my $par (@_) {
        for my $line (split /\n/, $par) {
            if (nonempty($line)) {
                $tex->print_nl("*** ${subroutine}: ");
                $tex->print($line);
            } else {
                $tex->print_ln();
            }
        }
    }

    $tex->print_ln();

    return;
}

######################################################################
##                                                                  ##
##                             TEX.WEB                              ##
##                                                                  ##
######################################################################

## Most constants that we need (as well as a bunch that we don't) are
## in TeX::WEB2C.

######################################################################
##                                                                  ##
##                         [1] INTRODUCTION                         ##
##                                                                  ##
######################################################################

use constant BANNER => 'This is AMS texml <https://github.com/AmerMathSoc/texml>';

######################################################################
##                                                                  ##
##                      [2] THE CHARACTER SET                       ##
##                                                                  ##
######################################################################

## We character-set handling to Perl's I/O layers (see a_open_in and
## a_open_out), so we don't need xchr and xord.

######################################################################
##                                                                  ##
##                       [3] INPUT AND OUTPUT                       ##
##                                                                  ##
######################################################################

# Copy of current input line for use by show_context().

my %context_line_of :ATTR(:name<context_line>);

use constant term_in  => \*STDIN;
use constant term_out => \*STDOUT;

sub a_open_in {
    my $tex = shift;
    my $src = shift;

    my $mode = $tex->is_unicode_input() ? "<:utf8" : "<";

    open(my $fh, $mode, $src);

    return $fh;
}

sub a_open_out {
    my $tex      = shift;
    my $src = shift;

    my $mode = $tex->is_unicode_output() ? ">:utf8" : ">";

    open(my $fh, $mode, $src);

    return $fh;
}

sub input_ln {
    my $tex = shift;

    my $fh = shift;

    return unless defined $fh;

    return if eof($fh);

    chomp(my $line = <$fh>);

    $line =~ s/ +\z//;

    $tex->set_context_line($line);

    my @chars = split //, $line;

    $tex->push_char(@chars);

    return true;
}

sub update_terminal() {
    my $tex = shift;

    term_out->flush();

    return;
}

sub clear_terminal {
    my $tex = shift;

    term_in->flush();

    return;
}

sub wake_up_terminal {
    my $tex = shift;

    return;
}

## We don't need init_terminal because term_in (aka STDIN) is
## automatically opened, and we aren't interested in supporting the
## special input from the terminal that TeX performs when invoked with
## out an input file.

######################################################################
##                                                                  ##
##                       [4] STRING HANDLING                        ##
##                                                                  ##
######################################################################

## Unlike Pascal-H, Perl has a well-developed string mechanism, so we
## don't need any of this.  We also assume the terminal can handle
## UTF-8 output, so we don't worry about converting output to ^^
## notation.  (TBD: Should we implement some xchr-like handling of
## control characters for for terminal output in wlog and wterm?)

######################################################################
##                                                                  ##
##                [5] ON-LINE AND OFF-LINE PRINTING                 ##
##                                                                  ##
######################################################################

my %log_file_of :ATTR(:name<log_file>);

my %selector_of    :COUNTER(:name<selector> :default<term_only>);
my %old_setting_of :COUNTER(:name<old_setting>);

# my %tally_of       :COUNTER(:name<tally>);
my %term_offset_of :COUNTER(:name<term_offset> :get<term_offset> :incr<*custom*>);
my %file_offset_of :COUNTER(:name<file_offset> :get<file_offset> :incr<*custom>);

my %max_print_line_of :COUNTER(:name<max_print_line> :get<max_print_line> :default<1024>);

## cur_str is needed to implement the new_string selector, which is
## currently only used in the implementation of meaning.  It's ugly
## and it would be nice to eliminate it, but that would require an
## overhaul of the print routines and would probably result in
## incompatibilities with TeX's output conventions, so it might not be
## worth doing.

my %cur_str_of :ATTR(:name<cur_str> :get<*custom*> :set<*custom*> :default<"">);

sub get_cur_str {
    my $tex = shift;

    my $ident = ident $tex;

    my $str = $cur_str_of{$ident};

    $cur_str_of{$ident} = "";

    return $str;
}

sub incr_term_offset {
    my $tex = shift;

    my $length = defined $_[0] ? shift : 1;

    my $ident = ident $tex;

    $term_offset_of{$ident} += $length;

    return;
}

sub incr_file_offset {
    my $tex = shift;

    my $length = defined $_[0] ? shift : 1;

    my $ident = ident $tex;

    $file_offset_of{$ident} += $length;

    return;
}

## TBD: Should the wterm* and wlog* parameters handle non-printable
## characters and carriage returns specially?  Cf. print_raw_char.

sub wterm {
    my $tex = shift;

    print { term_out } @_;

    return;
}

sub wterm_ln {
    my $tex = shift;

    print { term_out } @_, "\n";

    return;
}

sub wterm_cr {
    my $tex = shift;

    $tex->wterm_ln();

    return;
}

sub wlog {
    my $tex = shift;

    my $fh = $tex->get_log_file();

    print { $fh } @_;

    return;
}

sub wlog_ln {
    my $tex = shift;

    my $fh = $tex->get_log_file();

    print { $fh } @_, "\n";

    return;
}

sub wlog_cr {
    my $tex = shift;

    $tex->wlog_ln();

    return;
}

sub print_ln {
    my $tex = shift;

    my $selector = $tex->selector();

    if ($selector < no_print) {
        print { $tex->get_write_file($selector) } "\n";
    } elsif ( $selector == term_and_log ) {
        $tex->wterm_cr();
        $tex->wlog_cr();
        $tex->set_term_offset(0);
        $tex->set_file_offset(0);
    } elsif ( $selector == log_only ) {
        $tex->wlog_cr();
        $tex->set_file_offset(0);
    } elsif ( $selector == term_only ) {
        $tex->wterm_cr();
        $tex->set_term_offset(0);
    }

    return;
}

sub print_char {
    my $tex = shift;

    my $char = shift;

    my $char_code = ord($char);

    my $selector = $tex->selector();

    if ($tex->is_new_line($char_code)) {
        if ($selector < pseudo) {
            $tex->print_ln();
            return;
        }
    }

    my $max_print_line = $tex->max_print_line();

    my $term_offset = $tex->term_offset();
    my $file_offset = $tex->file_offset();

    my $char_string;

    if ($tex->is_unicode_output()) {
        $char_string = chr($char_code);
    } else {
        $char_string = print_char_code($char_code);
    }

    my $char_length = length($char_string);

    if ($selector < no_print) {
        print { $tex->get_write_file($selector) } $char_string;
    } elsif ( $selector == term_and_log) {
        $tex->wterm($char_string);
        $tex->wlog($char_string);

        $tex->incr_term_offset($char_length);
        $tex->incr_file_offset($char_length);

        if ( $term_offset == $max_print_line ) {
            $tex->wterm_cr();
            $tex->set_term_offset(0);
        }

        if ( $file_offset == $max_print_line ) {
            $tex->wlog_cr();

            $tex->set_file_offset(0)
        }
    } elsif ( $selector == log_only ) {
        $tex->wlog($char_string);

        $tex->incr_file_offset($char_length);

        if ( $file_offset == $max_print_line-1 ) { ##* CHECK THIS
            $tex->print_ln();
        }
    } elsif ( $selector == term_only ) {
        $tex->wterm($char_string);

        $tex->incr_term_offset($char_length);

        if ( $term_offset == $max_print_line-1 ) { ##* CHECK THIS
            $tex->print_ln();
        }
    }
    elsif ( $selector == new_string ) {
        $cur_str_of{ident $tex} .= $char_string;
    }
    else {
        ##  no_print: do_nothing;
        ##
        ##  pseudo: if tally < trick_count then
        ##      trick_buf[tally mod error_line] := s;
    }

    ## $tex->incr_tally($char_length);

    return;
}

sub print {
    my $tex = shift;

    my $string = join('', @_);

    my $selector = $tex->selector();

    if ( length($string) == 1 ) {
        if ( $selector > pseudo ) {
            $tex->print_char($string);
            return; # internal strings are not expanded
        }

        if ($tex->is_new_line(ord($string))) {
            if ( $selector < pseudo ) {
                $tex->print_ln();
                return;
            }
        }

        my $nl = $tex->new_line_char();

        # temporarily disable new-line character

        $tex->set_new_line_char(-1);

        $tex->slow_print($string);

        $tex->set_new_line_char($nl);

        return;
    }

    $tex->slow_print($string);

    return;
}

## This should probably be eliminated.

sub slow_print( $ ) {
    my $tex = shift;

    my $string = shift;

    # if (! defined $string) {
    #     use Carp;
    #     Carp::confess "slow_print() invoked with undefined string";
    # }

    for my $char (split //, $string) {
        $tex->print_char($char);
    }

    return;
}

sub print_nl {
    my $tex = shift;

    my $selector = $tex->selector();

    if ( ( $tex->term_offset() > 0 and odd($selector) ) or
         ( $tex->file_offset() > 0 and $selector >= log_only ) ) {
        $tex->print_ln();
    }

    $tex->print(@_);

    return;
}

sub print_esc {
    my $tex = shift;

    my $s = shift;

    my $escape_char = $tex->escape_char();

    if ($escape_char >= 0 && $escape_char < 256) {
        $tex->print(print_char_code($escape_char));
    }

    $tex->slow_print($s);

    return;
}

sub print_int {
    my $tex = shift;

    my $n = shift;

    $tex->print(sprintf "%d", $n);

    return;
}

sub print_hex {
    my $tex = shift;

    my $n = shift;

    my $hex = int_as_hex($n);

    $tex->print($hex);

    return;
}

sub print_roman_int {
    my $tex = shift;

    my $n = shift;

    my $roman = int_as_roman($n);

    $tex->print($roman);

    return;
}

sub prompt_input {
    my $tex = shift;

    my $prompt = shift;

    $tex->print($prompt);

    return $tex->term_input();
}

sub term_input {
    my $tex = shift;

    $tex->update_terminal();

    if (! $tex->input_ln(term_in)) {
        $tex->fatal_error("End of file on the terminal!");
    }

    $tex->set_term_offset(0);

    $tex->decr_selector();

    my @chars = $tex->get_chars();

    if (@chars > 0) {
        $tex->print(@chars);
    }

    $tex->print_ln();

    $tex->incr_selector();

    return;
}

######################################################################
##                                                                  ##
##                       [6] REPORTING ERRORS                       ##
##                                                                  ##
######################################################################

my %err_help_of :ARRAY(:name<err_help>);

my %history_of    :ATTR(:name<history> :default<fatal_error_stop>);

my %deletions_allowed :BOOLEAN(:name<deletions_allowed> :default<true>);
my %set_box_allowed   :BOOLEAN(:name<set_box_allowed> :getter<set_box_allowed> :default<true>);

my %error_count_of :COUNTER(:name<error_count> :default<0>);

my %use_err_help_of :BOOLEAN(:name<use_err_help> :default<false>);

my %interrupt_of       :BOOLEAN(:name<OK_interrupt>    :default<false>);
my %OK_to_interrupt_of :BOOLEAN(:name<OK_to_interrupt> :default<true>);

sub set_help {
    my $tex = shift;

    my $ident = ident $tex;

    $err_help_of{$ident} = \@_;

    return;
}

sub print_err {
    my $tex = shift;

    my $err = join "", @_;

    $tex->print_nl("! ");
    $tex->print($err);

    return;
}

sub initialize_print_selector {
    my $tex = shift;

    my $interaction = $tex->get_interaction_mode();

    if ($interaction == batch_mode) {
        $tex->set_selector(no_print);
    } else {
        $tex->set_selector(term_only);
    }

    return;
}

sub jump_out {
    my $tex = shift;

    $tex->end_of_TEX();

    return;
}

sub error {
    my $tex = shift;

    if ($tex->get_history() < error_message_issued) {
        $tex->set_history(error_message_issued);
    }

    $tex->print_char(".");

    $tex->show_context();

    if ($tex->get_interaction_mode() == error_stop_mode) {
        # @<Get user's advice and |return|@>;

        return;
    }

    $tex->incr_error_count();

    if ($tex->error_count() == 100) {
        $tex->print_nl("(That makes 100 errors; please try again.)");

        $tex->set_history(fatal_error_stop);

        $tex->jump_out();
    }

    $tex->put_help_message_on_transcript();

    return;
}

sub put_help_message_on_transcript {
    my $tex = shift;

    my $interaction = $tex->get_interaction_mode();

    # if ($interaction > batch_mode) {
    #     $tex->decr_selector(); # {avoid terminal output}
    # }

    if ($tex->use_err_help()) {
        $tex->print_ln();

        $tex->give_err_help();
    } else {
        for my $line ($tex->get_err_helps()) {
            $tex->print_nl($line);
        }
    }

    $tex->print_ln();

    # if ($interaction > batch_mode) {
    #     $tex->incr_selector(); # {re-enable terminal output}
    # }

    $tex->print_ln();

    return;
}

sub int_error {
    my $tex = shift;

    my $int = shift;

    $tex->print(" (");

    $tex->print_int($int);

    $tex->print_char(")");

    $tex->error();

    return;
}

sub normalize_selector {
    my $tex = shift;

    if ($tex->log_opened()) {
        $tex->set_selector(term_and_log);
    } else {
        $tex->set_selector(term_only);
    }

    if (empty($tex->get_job_name())) {
        $tex->open_log_file();
    }

    if ($tex->get_interaction_mode() == batch_mode) {
        $tex->decr_selector();
    }

    return;
}

sub succumb {
    my $tex = shift;

    if ($tex->get_interaction_mode() == error_stop_mode) {
        $tex->set_interaction_mode(scroll_mode); # {no more interaction}
    }

    if ($tex->log_opened()) {
        $tex->error();
    }

    if ($tex->is_debugging()) {
        if ($tex->get_interaction_mode() > batch_mode) {
            $tex->debug_help();
        }
    }

    $tex->set_history(fatal_error_stop);

    $tex->jump_out();

    return;
}

sub fatal_error {
    my $tex = shift;

    my $s = shift;

    $tex->normalize_selector();

    $tex->print_err("Emergency stop");

    $tex->print_err($s);

    $tex->set_help($s);

    $tex->succumb();

    croak "You shouldn't have gotten here!";
}

## This should never be needed.

sub overflow {
    my $tex = shift;

    my $s = shift;
    my $n = shift;

    $tex->normalize_selector();

    $tex->print_err("TeX capacity exceeded, sorry [");

    $tex->print($s);

    $tex->print_char("=");

    $tex->print_int($n);

    $tex->print_char("]");

    $tex->set_help("If you really absolutely need more capacity,",
                   "you can ask a wizard to enlarge me.");

    $tex->succumb();

    die "You shouldn't have gotten here!";
}

sub confusion {
    my $tex = shift;

    my $string = shift;

    $tex->normalize_selector();

    # if ($tex->get_history() < error_message_issued) {
        $tex->print_err("This can't happen (");
        $tex->print($string);
        $tex->print_char(")");

        $tex->set_help("I'm broken. Please show this to someone who can fix can fix");
    # } else {
    #     $tex->print_err("I can't go on meeting you like this");
    #
    #     $tex->set_help("One of your faux pas seems to have wounded me deeply...",
    #                    "in fact, I'm barely conscious. Please fix it and try again.");
    # }

    $tex->succumb();

    die "You shouldn't have gotten here!";
}

sub check_interrupt {
    my $tex = shift;

    if ($tex->is_OK_interrupt()) {
        $tex->pause_for_instructions();
    }

    return;
}

sub pause_for_instructions {
    my $tex = shift;

    return unless $tex->is_OK_to_interrupt();

    $tex->set_interaction_mode(error_stop_mode);

    my $selector = $tex->selector();

    if ( $selector == log_only || $selector == no_print ) {
        $tex->incr_selector();
    }

    $tex->print_err("Interruption");

    $tex->set_help("You rang?",
                   "Try to insert some instructions for me (e.g.,`I\\showlists'),",
                   "unless you just want to quit by typing `X'.");

    $tex->set_deletions_allowed(false);

    $tex->error();

    $tex->set_deletions_allowed(true);

    $tex->set_interrupt(0);

    return;
}

######################################################################
##                                                                  ##
##              [7] ARITHMETIC WITH SCALED DIMENSIONS               ##
##                                                                  ##
######################################################################

## See TeX::Arithmetic

# sub print_scaled {
#     my $tex = shift;
#
#     my $scaled = shift;
#
#     $tex->print(sprint_scaled($scaled));
#
#     return;
# }

######################################################################
##                                                                  ##
##                         [8] PACKED DATA                          ##
##                                                                  ##
######################################################################

## Irrelevant.

######################################################################
##                                                                  ##
##                  [9] DYNAMIC MEMORY ALLOCATION                   ##
##                                                                  ##
######################################################################

## Irrelevant.

######################################################################
##                                                                  ##
##         [10] DATA STRUCTURES FOR BOXES AND THEIR FRIENDS         ##
##                                                                  ##
######################################################################

## Most of this section is in TeX::Nodes.

## We may not need new_spec, but if we do need it, it should probably
## be in TeX::Nodes.

sub new_spec {
    my $tex = shift;

    # @ Here is a function that returns a pointer to a copy of a glue spec.
    # The reference count in the copy is |null|, because there is assumed
    # to be exactly one reference to the new specification.
    #
    # @p function new_spec(p: pointer): pointer; {duplicates a glue specification}
    #     var q: pointer; {the new spec}
    # begin
    #     q := get_node(glue_spec_size);
    #
    #     mem[q] := mem[p];
    #
    #     glue_ref_count(q) := null;
    #
    #     width(q)   := width(p);
    #     stretch(q) := stretch(p);
    #     shrink(q)  := shrink(p);
    #
    #     new_spec := q;
    # end;
    #

    return;
}

sub new_param_glue {
    my $tex = shift;

    my $param = shift;

    my $glue_param = $tex->get_glue_parameter($param);

    return new_glue({ glue => $glue_param->get_equiv()->get_value() } );
}

# function new_skip_param(n: small_number): pointer;
#     var p: pointer; {the new node}
# begin
#     temp_ptr := new_spec(@<Current |mem| equivalent of glue parameter...@>);
#
#     p := new_glue(temp_ptr);
#
#     glue_ref_count(temp_ptr) := null;
#
#     subtype(p) := n + 1;
#
#     new_skip_param := p;
# end;

######################################################################
##                                                                  ##
##                        [11] MEMORY LAYOUT                        ##
##                                                                  ##
######################################################################

## Mostly irrelevant, but possibly need parts of
## @<Initialize table entries...@>

######################################################################
##                                                                  ##
##                      [12] DISPLAYING BOXES                       ##
##                                                                  ##
######################################################################

## Don't need most of this section since we're not building boxes.

my %show_depth_of :COUNTER(:name<show_depth>);

sub print_rule_dimen {
    my $tex = shift;

    my $scaled = shift;

    $tex->print(rule_dimen_to_string($scaled));

    return;
}

sub print_glue {
    my $tex = shift;

    my $scaled = shift;
    my $order  = shift;
    my $units = shift;

    $tex->print(glue_to_string($scaled, $order));

    if (nonempty($units)) {
        $tex->print($units);
    }

    return;
}

sub print_spec { # {prints a glue specification}
    my $tex = shift;

    my $val   = shift; # ???
    my $units = shift;

    carp "print_spec not implemented yet";

    # if (p < mem_min) or (p >= lo_mem_max) then
    #     print_char("*")
    # else
    # begin
    #     print_scaled(width(p));
    #
    #     if s <> 0 then print(s);
    #
    #     if stretch(p) <> 0 then
    #     begin
    #         print(" plus ");
    #         print_glue(stretch(p), stretch_order(p), s);
    #     end;
    #
    #     if shrink(p) <> 0 then
    #     begin
    #         print(" minus ");
    #         print_glue(shrink(p), shrink_order(p), s);
    #     end;
    # end;

    return;
}

sub show_node_list {
    my $tex = shift;

    my @nodes = @_;

    for my $node (@nodes) {
        $tex->print_ln();

        $tex->print("." x $tex->show_depth());

        if (eval { $node->is_box() }) {
            $tex->display_box($node);

            next;
        }

        if (eval { $node->is_char_node() }) {
            $tex->print("<character> ");
            $tex->print_char(chr($node->get_char_code()));

            next;
        }

        if (eval { $node->is_glue() }) {
            $tex->print_esc("glue");

            next;
        }

        if (eval { $node->is_xml_node() }) {
            $tex->print($node);

            next;
        }

        if (eval { $node->isa('TeX::Token') }) { ## Extension
            $tex->print("<token> $node");

            next;
        }

        $tex->print("Unknown node type! (" . ref($node) . ")");
    }

    return;
}

sub display_box {
    my $tex = shift;

    my $box = shift;

    if ($box->is_hbox()) {
        $tex->print_esc("h");
    } elsif ($box->is_vbox()) {
        $tex->print_esc("v");
    } else {
        $tex->print_esc("unset");
    }

    $tex->print("box(");

    # print_scaled(height(p));
    # print_char("+");
    # print_scaled(depth(p));
    # print(")x");
    # print_scaled(width(p));
    #
    # if type(p) = unset_node then
    #     @<Display special fields of the unset node |p|@>
    #     else
    #     begin
    #     @<Display the value of |glue_set(p)|@>;
    #
    # if shift_amount(p) <> 0 then
    #     begin
    #     print(", shifted ");
    # print_scaled(shift_amount(p));
    # end;
    # end;

    $tex->incr_show_depth();

    $tex->show_node_list($box->get_nodes());

    $tex->decr_show_depth();

    # node_list_display(list_ptr(p)); {recursive call}

    return;
}

sub show_box {
    my $tex = shift;

    my $box = shift;

    $tex->show_node_list($box);

    $tex->print_ln();

    return;
}

sub box {
    my $tex = shift;

    my $index = shift;

    my $box_ref = $tex->find_box_register($index);

    return ${ $box_ref }->get_equiv();
}

sub box_set {
    my $tex = shift;

    my $index    = shift;
    my $box      = shift;
    my $modifier = shift;

    my $box_ref = $tex->find_box_register($index);

    $tex->eq_define($box_ref, $box, $modifier);

    return;
}

######################################################################
##                                                                  ##
##                      [13] DESTROYING BOXES                       ##
##                                                                  ##
######################################################################

## Irrelevant

######################################################################
##                                                                  ##
##                        [14] COPYING BOXES                        ##
##                                                                  ##
######################################################################

## Irrelevant

######################################################################
##                                                                  ##
##                      [15] THE COMMAND CODES                      ##
##                                                                  ##
######################################################################

## See TeX::WEB2C.

######################################################################
##                                                                  ##
##                      [16] THE SEMANTIC NEST                      ##
##                                                                  ##
######################################################################

my %cur_list_of      :ATTR(:name<cur_list>);
my %semantic_nest_of :ARRAY(:name<semantic_nest>);

sub get_nest_ptr {
    my $tex = shift;

    return $#{ $semantic_nest_of{ident $tex} };
}

{
    package ListStateRecord;

    use TeX::Class;

    my %mode_of         :ATTR(:name<mode>);
    my %mode_line_of    :ATTR(:name<mode_line>);

    my %nodes_of        :ARRAY(:name<node>);

    my %prev_graf_of    :ATTR(:name<prev_graf>);
    my %prev_depth_of   :ATTR(:name<prev_depth>);
    my %space_factor_of :ATTR(:name<space_factor>);
    my %clang_of        :ATTR(:name<clang>);

    no warnings qw(redefine);

    sub clone {
        my $self = shift;

        my $mode_line = shift;

        my $class = ref $self;

        my $clone = $class->new({ mode            => $self->get_mode(),
                                  mode_line       => $mode_line,
                                  nodes           => [],
                                  prev_graf       => 0,
                                  prev_depth      => $self->get_prev_depth(),
                                  space_factor    => $self->get_space_factor(),
                                  clang           => $self->get_clang(),
                                });

        return $clone;
    }

    sub append_node {
        my $self = shift;

        my $node = shift;

        $self->add_node($node);

        return;
    }

    sub length {
        my $self = shift;

        return scalar @{ $nodes_of{ident $self} };
    }
}

sub init_semantic_nest {
    my $tex = shift;

    my $list = ListStateRecord->new({ mode         => vmode,
                                      mode_line    => 0,
                                      list         => [],
                                      prev_graf    => 0,
                                      prev_depth   => 0,
                                      space_factor => 0,
                                      clang        => 0,
                                    });

    $tex->set_cur_list($list);

    $tex->add_semantic_nest($list);

    return;
}

sub get_cur_mode {
    my $tex = shift;

    my $ident = ident $tex;

    return $cur_list_of{$ident}->get_mode();
}

sub set_cur_mode {
    my $tex = shift;

    my $mode = shift;

    my $ident = ident $tex;

    $cur_list_of{$ident}->set_mode($mode);

    return;
}

sub print_mode {
    my $tex = shift;

    my $m = shift;

    if ($m > 0) {
        my $type = $m % (max_command + 1);

        if ($type == 0) {
            $tex->print("vertical");
        } elsif ($type == 1) {
            $tex->print("horizontal");
        } elsif ($type == 2) {
            $tex->print("display math");
        } else {
            $tex->confusion("How can type == $type in print_mode?");
        }
    } elsif ($m == 0) {
        $tex->print("no");
    } else {
        my $type = -$m % (max_command + 1);

        if ($type == 0) {
            $tex->print("internal vertical");
        } elsif ($type == 1) {
            $tex->print("restricted horizontal");
        } elsif ($type == 2) {
            $tex->print("math");
        } else {
            $tex->confusion("How can type == $type in print_mode?");
        }
    }

    $tex->print(" mode");

    return;
}

sub push_nest {
    my $tex = shift;

    my $ident = ident $tex;

    my $prev_list = $cur_list_of{$ident};

    $tex->add_semantic_nest($prev_list);

    $cur_list_of{$ident} = $prev_list->clone($tex->input_line_no());

    return;
}

sub pop_nest {
    my $tex = shift;

    my $ident = ident $tex;

    my $cur_list = $tex->get_cur_list();

    $tex->set_cur_list($tex->pop_semantic_nest());

    return $cur_list->get_nodes();
}

sub tail_append {
    my $tex = shift;

    my $cur_list = $tex->get_cur_list();

    if (defined $cur_list) {
        for my $node (@_) {
            $cur_list->append_node($node);
        }
    } else {
        # $tex->DEBUG("Can't append nodes '@_' to null list");
    }

    return;
}

sub tail_node {
    my $tex = shift;

    my $cur_list = $tex->get_cur_list();

    if (defined $cur_list) {
        return $cur_list->get_node(-1);
    }

    return;
}

sub pop_node {
    my $tex = shift;

    my $cur_list = $tex->get_cur_list();

    if (defined $cur_list) {
        return $cur_list->pop_node();
    } else {
        # $tex->DEBUG("Can't append nodes '@_' to null list");
    }

    return;
}

######################################################################
##                                                                  ##
##                   [17] THE TABLE OF EQUIVALENTS                  ##
##                                                                  ##
######################################################################

my %IS_WHITESPACE = (" "  => 1,
                     "\n" => 1,
                     );

sub is_whitespace {
    my $tex = shift;

    my $char_code = shift;

    return $IS_WHITESPACE{chr($char_code)};
}

## Region 1a: active characters

my %active_chars_of :HASH(:name<active_char>);

## Region 1b + Region 2: single- and multiple-character control sequences

my %csnames_of :HASH(:name<csname>);

my %text_fonts_of :ARRAY(:name<text_font>); # cf. font_id_base
my %math_fonts_of :ARRAY(:name<math_font>); # cf. math_font_base

## Region 3: glue parameters

my %glue_parameters_of   :HASH(:name<glue_parameter>);
my %muglue_parameters_of :HASH(:name<muglue_parameter>);
my %skip_registers_of    :HASH(:name<skip_register>);
my %muskip_registers_of  :HASH(:name<muskip_register>);

## Region 4: halfword quantities

my %halfword_quantities_of :HASH(:name<halfword_quantity>);
my %toks_registers_of      :HASH(:name<toks_register>);
my %box_registers_of       :HASH(:name<box_register>);
my %math_font_nums_of      :HASH(:name<math_font_num>);
my %cat_codes_of           :HASH(:name<cat_code>);
my %lc_codes_of            :HASH(:name<lc_code>);
my %uc_codes_of            :HASH(:name<uc_code>);
my %sf_codes_of            :HASH(:name<sf_code>);
my %math_codes_of          :HASH(:name<math_code>);

## Extension: titlecase codes.  It's doubtful whether this will ever
## be useful, but it provides a pleasing symmetry with lc_codes and
## uc_codes.

my %tc_codes_of            :HASH(:name<tc_code>);

my %node_registers_of      :HASH(:name<node_registers>);

my %token_parameters_of :HASH(:name<token_parameter>);

## Region 5: Integer parameters

my %integer_parameters_of :HASH(:name<integer_parameter>);
my %count_registers_of    :HASH(:name<count_register>);
my %del_codes_of          :HASH(:name<del_code>);

## Region 6: dimen parameters

my %dimen_parameters_of :HASH(:name<dimen_parameter>);
my %dimen_registers_of  :HASH(:name<dimen_register>);

## Special parameters

my %special_integers_of :HASH(:name<special_integer>); # always global
my %special_dimens_of   :HASH(:name<special_dimen>);   # always global

use constant END_WRITE_TOKEN => make_csname_token("endwrite", UNIQUE_TOKEN);

## END_TEX_TOKEN is used to indicate that the current TeX run (really,
## the current invocation of main_control()) should be terminated.

use constant END_TEX_TOKEN  => make_csname_token("endTeX", UNIQUE_TOKEN);

use constant FROZEN_DONT_EXPAND_TOKEN
    => make_csname_token("notexpanded", UNIQUE_TOKEN);

use constant FROZEN_CR_TOKEN
    => make_csname_token("cr");

{
    package EQVT;

    use TeX::Class;

    my %level_of :COUNTER(:name<level>);
    my %equiv_of :ATTR(:name<equiv>);

    sub to_string :STRINGIFY {
        my $tex = shift;

        return sprintf "EQVT(level=%d, equiv=%s; ident=%s)", $tex->level(), $tex->get_equiv(), ident($tex);
    }
}

{
    package EQVT::Data;

    use TeX::Class;

    my %value_of :ATTR(:name<value>);

    sub to_string :STRINGIFY {
        my $tex = shift;

        return sprintf "EQVT::Data(value=%s)", $tex->get_value();
    }
}

sub make_eqvt( $$ ) {
    my $equiv = shift;
    my $level = shift;

    ##* TODO: Figure out what I'm doing here: special handling for
    ##* TeX::Command's?

    if (defined($equiv)) {
        if ( ref($equiv) eq '' || ref($equiv) eq 'ARRAY'|| ref($equiv) eq 'TeX::Type::GlueSpec' || ref($equiv) eq 'TeX::TokenList') {
            $equiv = EQVT::Data->new({ value => $equiv });
        }
    }

    return EQVT->new({ equiv => $equiv, level => $level });
}

sub init_eqtb {
    my $tex = shift;

    $tex->__init_eqtb_region_1_2();
    $tex->__init_eqtb_region_3();
    $tex->__init_eqtb_region_4();
    $tex->__init_eqtb_region_5();
    $tex->__init_eqtb_region_6();

    $tex->__init_special_parameters();

    $tex->__init_xml_tag_parameters();

    return;
}

FROZEN_CSNAMES: {
    my $FROZEN_RELAX;
    my $FROZEN_RELAX_TOKEN;

    sub FROZEN_RELAX()       { return $FROZEN_RELAX };
    sub FROZEN_RELAX_TOKEN() { return $FROZEN_RELAX_TOKEN };

    my $FROZEN_PAR;
    my $FROZEN_PAR_TOKEN;

    sub FROZEN_PAR()       { return $FROZEN_PAR }
    sub FROZEN_PAR_TOKEN() { return $FROZEN_PAR_TOKEN }

    my $UNDEFINED_CS;

    my $FROZEN_FI;
    my $FROZEN_END_GROUP;
    my $FROZEN_CR;
    my $FROZEN_RIGHT;
    my $FROZEN_NULL_FONT;

    sub UNDEFINED_CS() { return $UNDEFINED_CS };

    sub FROZEN_FI()        { return $FROZEN_FI };
    sub FROZEN_END_GROUP() { return $FROZEN_END_GROUP };
    sub FROZEN_CR()        { return $FROZEN_CR };
    sub FROZEN_RIGHT()     { return $FROZEN_RIGHT };
    sub FROZEN_NULL_FONT() { return $FROZEN_NULL_FONT };

    my $FROZEN_PRIMITIVE;
    my $FROZEN_PRIMITIVE_TOKEN;

    sub FROZEN_PRIMITIVE()       { return $FROZEN_PRIMITIVE }
    sub FROZEN_PRIMITIVE_TOKEN() { return $FROZEN_PRIMITIVE_TOKEN }

    my $FROZEN_END_TEMPLATE;
    my $FROZEN_END_TEMPLATE_TOKEN;

    sub FROZEN_END_TEMPLATE_TOKEN() { return $FROZEN_END_TEMPLATE_TOKEN };

    my $FROZEN_ENDV;
    my $FROZEN_ENDV_TOKEN;

    sub FROZEN_ENDV_TOKEN() { return $FROZEN_ENDV_TOKEN };

    my $FROZEN_ENDU;
    my $FROZEN_ENDU_TOKEN;

    sub FROZEN_ENDU_TOKEN() { return $FROZEN_ENDU_TOKEN };

    my $OMIT_TEMPLATE;

    sub OMIT_TEMPLATE() { return $OMIT_TEMPLATE };

    sub __init_eqtb_region_1_2 {
        my $tex = shift;

        my $ident = ident $tex;

        $UNDEFINED_CS     = $tex->load_primitive("undefined");
        $FROZEN_FI        = $tex->load_primitive("fi");
        $FROZEN_END_GROUP = make_frozen_token(endgroup => $tex->load_primitive("endgroup"));
        $FROZEN_CR        = $tex->load_primitive("cr");
        $FROZEN_RIGHT     = make_frozen_token(right => $tex->load_primitive("right"));
        $FROZEN_NULL_FONT = $tex->load_primitive("nullfont");

        $FROZEN_RELAX       = $tex->load_primitive("relax");
        $FROZEN_RELAX_TOKEN = make_frozen_token(relax => $FROZEN_RELAX);

        $FROZEN_PAR       = $tex->load_primitive("par");
        $FROZEN_PAR_TOKEN = make_frozen_token(par => $FROZEN_PAR);

        my $pdfprimitive = $tex->load_primitive("pdfprimitive");

        $FROZEN_PRIMITIVE = $pdfprimitive->clone();
        $FROZEN_PRIMITIVE->set_subtype(1);
        $FROZEN_PRIMITIVE_TOKEN = make_frozen_token(pdfprimitive => $FROZEN_PRIMITIVE);

        $FROZEN_END_TEMPLATE = $tex->load_primitive("endtemplate");
        $FROZEN_END_TEMPLATE_TOKEN = make_frozen_token(endtemplate =>
                                                       $FROZEN_END_TEMPLATE);

        $FROZEN_ENDV = $tex->load_primitive("endv");
        $FROZEN_ENDV_TOKEN = make_frozen_token(endtemplate => $FROZEN_ENDV);

        $FROZEN_ENDU = $tex->load_primitive("endutemplate");
        $FROZEN_ENDU_TOKEN = make_frozen_token(endutemplate => $FROZEN_ENDU);

        $OMIT_TEMPLATE = TeX::TokenList->new({ tokens => [ $FROZEN_END_TEMPLATE_TOKEN ] });

        return;
    }
}

sub __list_glue_parameters {
    my $tex = shift;

    return qw(line_skip baseline_skip par_skip above_display_skip
              below_display_skip above_display_short_skip
              below_display_short_skip left_skip right_skip top_skip
              split_top_skip tab_skip space_skip xspace_skip
              par_fill_skip);
}

sub __list_muglue_parameters {
    my $tex = shift;

    return qw(thin_mu_skip med_mu_skip thick_mu_skip);
}

sub __init_eqtb_region_3 {
    my $tex = shift;

    my $ident = ident $tex;

    my %glue_param;

    foreach my $param ($tex->__list_glue_parameters()) {
        my $zero_glue = make_glue_spec(0, 0, 0);

        $glue_param{$param} = make_eqvt($zero_glue, level_one);

        (my $csname = $param) =~ s/_//g;

        my $glue_param = make_glue_parameter($csname, \$glue_param{$param});

        if ($param ne 'tab_skip') {
            $tex->set_primitive($csname => $glue_param);
            $tex->define_csname($csname => $glue_param);
        }
    }

    $glue_parameters_of{$ident} = \%glue_param;

    my %muglue_param;

    foreach my $param ($tex->__list_muglue_parameters()) {
        $muglue_param{$param} = make_eqvt(0, level_one);

        (my $csname = $param) =~ s/_//g;

        my $muglue_param = make_muglue_parameter($csname, \$muglue_param{$param});

        $tex->set_primitive($csname => $muglue_param);
        $tex->define_csname($csname => $muglue_param);
    }

    $muglue_parameters_of{$ident} = \%muglue_param;

    return;
}

sub __list_token_parameters {
    my $tex = shift;

    my @toks = qw(output every_par every_math every_display every_hbox
                  every_vbox every_job every_cr err_help);

    push @toks, qw(every_eof); # eTeX

    push @toks, qw(pdf_page_attr pdf_page_resources pdf_pages_attr
                   pdf_pk_mode);

    push @toks, qw(after_par);

    return @toks;
}

sub __list_node_registers {
    my $tex = shift;

    return qw(end_math_list);
}

sub __init_eqtb_region_4 {
    my $tex = shift;

    my $ident = ident $tex;

    my %token_param;

    foreach my $param ($tex->__list_token_parameters()) {
        $token_param{$param} = make_eqvt(new_token_list(), level_one);

        (my $csname = $param) =~ s/_//g;

        my $param = make_toks_parameter($csname, \$token_param{$param});

        $tex->set_primitive($csname => $param);
        $tex->define_csname($csname => $param);
    }

    $token_parameters_of{$ident} = \%token_param;

    my %node_register;

    foreach my $param ($tex->__list_node_registers()) {
        $node_register{$param} = make_eqvt(undef, level_one);
    }

    $node_registers_of{$ident} = \%node_register;

    my %halfwords = (
        par_shape_loc => make_eqvt(undef, level_one),
        cur_font_loc  => make_eqvt(undef, level_one),
        );

    $halfword_quantities_of{$ident} = \%halfwords;

    $tex->initialize_char_codes(first_text_char..last_text_char);

    $tex->set_catcode(carriage_return, CATCODE_END_OF_LINE);
    $tex->set_catcode(ord(" "),        CATCODE_SPACE);
    $tex->set_catcode(ord("\\"),       CATCODE_ESCAPE);
    $tex->set_catcode(ord("%"),        CATCODE_COMMENT);
    $tex->set_catcode(invalid_code,    CATCODE_INVALID);
    $tex->set_catcode(null_code,       CATCODE_IGNORED);

    foreach my $char_code ( ord("0") .. ord("9") ) {
        $tex->set_mathcode($char_code, $char_code + var_code);
    }

    my $A_to_a = ord("a") - ord("A");

    foreach my $char_code ( ord("A") .. ord("Z") ) {
        $tex->set_mathcode($char_code, $char_code + var_code + 0x100);

        $tex->set_mathcode($char_code + $A_to_a, $char_code + $A_to_a + var_code + 0x100);
    }

    return;
}

## initialize_char_codes:
##
## Guess reasonable values of catcode, sfcode, lccode, uccode, and
## tccode based on Unicode General_Category, Simple_Uppercase_Mapping,
## Simple_Lowercase_Mapping, and Simple_Titlecase_Mapping properties.
##
## Initialize mathcode and delcode to dummy values, because we don't
## really care about them.

sub initialize_char_codes {
    my $tex = shift;

    my @usvs = @_;

    my $ident = ident $tex;

    my $cat_codes  = $cat_codes_of{$ident};
    my $lc_codes   = $lc_codes_of{$ident};
    my $uc_codes   = $uc_codes_of{$ident};
    my $tc_codes   = $tc_codes_of{$ident};
    my $sf_codes   = $sf_codes_of{$ident};
    my $math_codes = $math_codes_of{$ident};
    my $del_codes  = $del_codes_of{$ident};

    for my $usv (@usvs) {
        next if exists $cat_codes->{$usv};

        $tex->eq_define(\$math_codes->{$usv}, $usv, MODIFIER_GLOBAL);
        $tex->eq_define(\$del_codes->{$usv},    -1, MODIFIER_GLOBAL);

        # $tex->DEBUG(sprintf "*** initialize_char_codes: usv = 0x%04X\n", $usv);

        my $charinfo = charinfo($usv);

        my $category = $charinfo->{category};

        if ($category =~ m{^L[ltu]}) {
            my $lower_usv = 0;
            my $upper_usv = 0;
            my $title_usv = 0;

            if ($category eq 'Ll') {
                $lower_usv = $usv;

                if (nonempty(my $upper = $charinfo->{upper})) {
                    $upper_usv = hex($upper);
                }

                if (nonempty(my $title = $charinfo->{title})) {
                    $title_usv = hex($title);
                }
            }
            elsif ($category eq 'Lu') {
                if (nonempty(my $lower = $charinfo->{lower})) {
                    $lower_usv = hex($lower);
                }

                $upper_usv = $usv;

                if (nonempty(my $title = $charinfo->{title})) {
                    $title_usv = hex($title);
                }
            }
            elsif ($category eq 'Lt') {
                if (nonempty(my $lower = $charinfo->{lower})) {
                    $lower_usv = hex($lower);
                }

                if (nonempty(my $upper = $charinfo->{upper})) {
                    $upper_usv = hex($upper);
                }

                $title_usv = $usv;
            }

            ## Don't override pre-existing character codes for
            ## associated characters.  Otherwise, for example, a use
            ## of U+0131 LATIN SMALL LETTER DOTLESS I would cause
            ## \lccode`\I to be reset from `\i to `\ı and hilarity
            ## will ensue.

            if ($lower_usv > 0 && ! defined $cat_codes->{$lower_usv}) {
                $tex->eq_define(\$cat_codes->{$lower_usv}, CATCODE_LETTER, MODIFIER_GLOBAL);
                $tex->eq_define(\$sf_codes->{$lower_usv},           1000, MODIFIER_GLOBAL);

                $tex->eq_define(\$lc_codes->{$lower_usv}, $lower_usv, MODIFIER_GLOBAL);
                $tex->eq_define(\$uc_codes->{$lower_usv}, $upper_usv, MODIFIER_GLOBAL);
                $tex->eq_define(\$tc_codes->{$lower_usv}, $title_usv, MODIFIER_GLOBAL);
            }

            if ($upper_usv > 0 && ! defined $cat_codes->{$upper_usv}) {
                $tex->eq_define(\$cat_codes->{$upper_usv}, CATCODE_LETTER, MODIFIER_GLOBAL);
                $tex->eq_define(\$sf_codes->{$upper_usv},            999, MODIFIER_GLOBAL);

                $tex->eq_define(\$lc_codes->{$upper_usv}, $lower_usv, MODIFIER_GLOBAL);
                $tex->eq_define(\$uc_codes->{$upper_usv}, $upper_usv, MODIFIER_GLOBAL);
                $tex->eq_define(\$tc_codes->{$upper_usv}, $title_usv, MODIFIER_GLOBAL);
            }

            if ($title_usv > 0 && ! defined $cat_codes->{$title_usv}) {
                $tex->eq_define(\$cat_codes->{$title_usv}, CATCODE_LETTER, MODIFIER_GLOBAL);
                $tex->eq_define(\$sf_codes->{$title_usv},            999, MODIFIER_GLOBAL);

                $tex->eq_define(\$lc_codes->{$title_usv}, $lower_usv, MODIFIER_GLOBAL);
                $tex->eq_define(\$uc_codes->{$title_usv}, $upper_usv, MODIFIER_GLOBAL);
                $tex->eq_define(\$tc_codes->{$title_usv}, $title_usv, MODIFIER_GLOBAL);
            }

            next;
        }

        $tex->eq_define(\$lc_codes->{$usv}, 0, MODIFIER_GLOBAL);
        $tex->eq_define(\$uc_codes->{$usv}, 0, MODIFIER_GLOBAL);
        $tex->eq_define(\$tc_codes->{$usv}, 0, MODIFIER_GLOBAL);

        my $cat_code = CATCODE_OTHER;
        my $sf_code  = 1000;

        if ($category =~ m{C[cfsn]}) {
            $cat_code = CATCODE_IGNORED;
            $sf_code  = 0;
        }
        elsif ($category =~ m{^L[mo]}) {
            $cat_code = CATCODE_LETTER;
            $sf_code  = 0 if $category eq 'Lm';
        }
        elsif ($category =~ m{^M}) {
            $sf_code = 0;
        }
        # elsif ($category =~ m{^N}) {
        #     # no-op
        # }
        elsif ($category =~ m{^P[ef]}) {
            $sf_code = 0;
        }
        # elsif ($category =~ m{^S}) {
        #     # no-op
        # }
        elsif ($category =~ m{^Z}) {

            # These are Unicode characters with category White_Space.
            # We can't just map them to CATCODE_SPACE because we
            # (probably) don't want them disappearing from input
            # files, but we need to be able to identify and remove
            # them in __unskip().  For now, we'll handle this outside
            # of the publicly visible interface; the alternative would
            # be to introduce a new catcode (CATCODE_SPACE_OTHER?) for
            # these.

            $IS_WHITESPACE{chr($usv)} = 1;
        }

        $tex->eq_define(\$cat_codes->{$usv}, $cat_code, MODIFIER_GLOBAL);
        $tex->eq_define(\$sf_codes->{$usv}, $sf_code,  MODIFIER_GLOBAL);
    }

    return;
}

sub show_char_info {
    my $tex = shift;

    my $usv = shift;

    $tex->print_ln();

    my $file_name = $tex->get_file_name() || '<undef>';
    my $line_no   = $tex->input_line_no() || '<undef>';

    $tex->print_nl("*** charinfo on line $line_no of $file_name");

    $tex->print_nl(sprintf "***      usv = 0x%04X (%s)", $usv, chr($usv));
    $tex->print_nl(sprintf "***  catcode = %d", $tex->get_catcode($usv));

    if ((my $code = $tex->get_uccode($usv)) == 0) {
        $tex->print_nl('***   uccode = 0');
    } else {
        $tex->print_nl(sprintf '***   uccode = 0x%04X (%s)', $code, chr($code));
    }

    if ((my $code = $tex->get_lccode($usv)) == 0) {
        $tex->print_nl('***   lccode = 0');
    } else {
        $tex->print_nl(sprintf '***   lccode = 0x%04X (%s)', $code, chr($code));
    }

    if ((my $code = $tex->get_tccode($usv)) == 0) {
        $tex->print_nl('***   tccode = 0');
    } else {
        $tex->print_nl(sprintf '***   tccode = 0x%04X (%s)', $code, chr($code));
    }

    $tex->print_nl(sprintf "***   sfcode = %d", $tex->get_sfcode($usv));

    if ((my $code = $tex->get_mathcode($usv)) == -1) {
        $tex->print_nl(sprintf "*** mathcode = -1");
    } else {
        $tex->print_nl(sprintf "*** mathcode = 0x%06X", $code);
    }

    if ((my $code = $tex->get_delcode($usv)) == -1) {
        $tex->print_nl(sprintf "***  delcode = -1");
    } else {
        $tex->print_nl(sprintf "***  delcode = 0x%06X", $code);
    }

    $tex->print_ln();

    return;
}

sub __list_integer_parameters {
    my $tex = shift;

    my @params = qw(adj_demerits bin_op_penalty broken_penalty club_penalty
                    cur_fam day default_hyphen_char default_skew_char
                    delimiter_factor display_widow_penalty
                    double_hyphen_demerits end_line_char error_context_lines
                    escape_char ex_hyphen_penalty final_hyphen_demerits
                    floating_penalty global_defs hang_after hbadness
                    holding_inserts hyphen_penalty inter_line_penalty
                    language left_hyphen_min line_penalty looseness mag
                    max_dead_cycles month new_line_char output_penalty
                    pausing post_display_penalty pre_display_penalty
                    pretolerance rel_penalty right_hyphen_min
                    show_box_breadth show_box_depth time tolerance
                    tracing_commands tracing_lost_chars tracing_macros
                    tracing_online tracing_output tracing_pages
                    tracing_paragraphs tracing_restores tracing_stats
                    uc_hyph vbadness widow_penalty year
        );

    ## eTeX:

    push @params, qw(TeXXeTstate last_line_fit pre_display_direction
                     saving_hyph_codes saving_vdiscards
                     tracing_assigns tracing_groups tracing_ifs
                     tracing_nesting tracing_scan_tokens);

    ## pdfTeX

    push @params, qw(pdf_adjust_interword_glue pdf_adjust_spacing
                     pdf_append_kern pdf_compress_level
                     pdf_decimal_digits pdf_draftmode
                     pdf_force_pagebox pdf_gamma pdf_gen_tounicode
                     pdf_image_apply_gamma pdf_image_gamma
                     pdf_image_hicolor pdf_image_resolution
                     pdf_inclusion_copy_fonts pdf_inclusion_errorlevel
                     pdf_minor_version pdf_move_chars
                     pdf_objcompresslevel
                     pdf_option_always_use_pdfpagebox
                     pdf_option_pdf_inclusion_errorlevel
                     pdf_option_pdf_minor_version pdf_output pdf_pagebox
                     pdf_pk_resolution pdf_prepend_kern
                     pdf_protrude_chars pdf_suppress_warning_dup_dest
                     pdf_suppress_warning_dup_map
                     pdf_suppress_warning_page_group
                     pdf_info_omit_date
                     pdf_suppress_ptex_info
                     pdf_tracing_fonts
                     pdf_unique_resname);

    push @params, qw(synctex); # syncTeX

    push @params, qw(XeTeXversion);

    push @params, qw(noligs); # LuaTeX

    # TeXML extensions

    push @params, qw(tracing_input
                     TeXML_debug_output TeXML_SVG_mag);

    return @params;
}

sub __init_eqtb_region_5 {
    my $tex = shift;

    my $ident = ident $tex;

    my %integer_param;

    foreach my $param ($tex->__list_integer_parameters()) {
        $integer_param{$param} = make_eqvt(0, level_one);

        (my $csname = $param) =~ s/_//g;

        $csname = 'fam' if $csname eq 'curfam';

        my $int_param = make_integer_parameter($csname,
                                               \$integer_param{$param});

        $tex->set_primitive($csname => $int_param);
        $tex->define_csname($csname => $int_param);
    }

    $integer_parameters_of{$ident} = \%integer_param;

    $tex->set_mag(1000);
    $tex->set_tolerance(10000);
    $tex->set_hang_after(1);
    $tex->set_max_dead_cycles(25);
    $tex->set_escape_char(ord('\\'));
    $tex->set_end_line_char(carriage_return);

    $tex->set_TeXML_SVG_mag(1000);

    for my $k (0..255) {
        $tex->set_del_code($k, make_eqvt(-1, level_one));
    }

    $tex->set_del_code(ord(".") => make_eqvt(0, level_one));

    return;
}

sub __list_dimen_parameters {
    my $tex = shift;

    my @dimens = qw(box_max_depth delimiter_shortfall display_indent
                    display_width emergency_stretch h_offset hang_indent
                    hfuzz hsize line_skip_limit math_surround max_depth
                    null_delimiter_space overfull_rule par_indent
                    pre_display_size script_space split_max_depth v_offset
                    vfuzz vsize);

    ## pdfTeX

    push @dimens, qw(pdf_dest_margin pdf_each_line_depth
                     pdf_each_line_height pdf_first_line_height
                     pdf_h_origin pdf_ignored_dimen
                     pdf_last_line_depth pdf_link_margin
                     pdf_page_height pdf_page_width pdf_px_dimen
                     pdf_thread_margin pdf_v_origin);

    ## TeXML extensions

    push @dimens, qw(TeXML_SVG_paperwidth);

    return @dimens;
}

sub __init_eqtb_region_6 {
    my $tex = shift;

    my $ident = ident $tex;

    my %dimen_param;

    foreach my $param ($tex->__list_dimen_parameters()) {
        $dimen_param{$param} = make_eqvt(0, level_one);

        (my $csname = $param) =~ s/_//g;

        my $dimen_param = make_dimen_parameter($csname,
                                               \$dimen_param{$param});

        $tex->set_primitive($csname => $dimen_param);
        $tex->define_csname($csname => $dimen_param);
    }

    $dimen_parameters_of{$ident} = \%dimen_param;

    $tex->set_TeXML_SVG_paperwidth(40 * 72.27 * sp_per_pt);

    return;
}

sub __list_special_integers {
    my $tex = shift;

    my @params = qw(deadcycles insertpenalties prevgraf spacefactor);

    ## TeXML extensions

    push @params, qw(alignrowno aligncolno alignspanno);

    return @params;
}

sub __list_special_dimens {
    my $tex = shift;

    return qw(prevdepth pagegoal pagetotal pagestretch pagefilstretch
              pagefillstretch pagefilllstretch pageshrink pagedepth);
}

sub __init_special_parameters {
    my $tex = shift;

    my $ident = ident $tex;

    my %special_integers;

    for my $csname ($tex->__list_special_integers()) {
        $special_integers{$csname} = EQVT::Data->new({ value => 0 });

        my $param = make_integer_parameter($csname, $special_integers{$csname});

        $tex->set_primitive($csname => $param);
        $tex->define_csname($csname => $param);
    }

    $special_integers_of{$ident} = \%special_integers;

    my %special_dimens;

    for my $csname ($tex->__list_special_dimens()) {
        $special_dimens{$csname} = EQVT::Data->new({ value => 0 });

        my $param = make_dimen_parameter($csname, $special_dimens{$csname});

        $tex->set_primitive($csname => $param);
        $tex->define_csname($csname => $param);
    }

    $special_dimens_of{$ident} = \%special_dimens;

    return;
}

# <Character |s| is the current new-line character>

sub is_new_line {
    my $tex = shift;

    my $char_code = shift;

    return $char_code == $tex->new_line_char();
}

sub fix_date_and_time {
    my $tex = shift;

    my @time = localtime(time);

    $tex->set_time( 60 * $time[2] + $time[1] );

    $tex->set_day( $time[3] );

    $tex->set_month( $time[4] + 1 );

    $tex->set_year( $time[5] + 1900 );

    return;
}

sub begin_diagnostic {
    my $tex = shift;

    my $selector = $tex->selector();

    $tex->set_old_setting($selector);

    if ($tex->tracing_online() <= 0 && $selector == term_and_log) {
        $tex->decr_selector();

        if ($tex->get_history() == spotless) {
            $tex->set_history(warning_issued);
        }
    }

    return;
}

sub end_diagnostic {
    my $tex = shift;

    my $blank_line = shift;

    $tex->print_nl("");

    if ($blank_line) {
        $tex->print_ln();
    }

    $tex->set_selector($tex->old_setting());

    return;
}

sub undefined {
    my $tex = shift;

    my $cur_tok = shift;

    $tex->print_err("Undefined control sequence '$cur_tok'");

    $tex->set_help("The control sequence at the end of the top line",
                   "of your error message was never \\def'ed. If you have",
                   "misspelled it (e.g., `\\hobx'), type `I' and the correct",
                   "spelling (e.g., `I\\hbox'). Otherwise just continue,",
                   "and I'll forget about whatever was undefined.");

    $tex->error();

    return;
}

######################################################################
##                                                                  ##
##                       [18] THE HASH TABLE                        ##
##                                                                  ##
######################################################################

my %primitives_of :HASH(:name<primitive>);

my %no_new_control_sequence :BOOLEAN(:name<no_new_control_sequence> :default<true>);

## This section is mostly irrelevant, but we might want to implement
## some version of print_cs and sprint_cs.

sub load_primitive( $;$ ) {
    my $tex = shift;

    my $name       = shift;
    my $class_name = shift;

    my $primitive = $tex->get_primitive($name);

    if (! defined $primitive) {
        $class_name = $name unless defined $class_name;

        my @candidates;

        if (defined $class_name) {
            if ($class_name =~ m{::}) {
                @candidates = ($class_name);
            } else {
                @candidates = ("TeX::Primitive::$class_name");

                for my $engine (qw(Extension eTeX pdfTeX XeTeX)) {
                    push @candidates, "TeX::Primitive::${engine}::$class_name"
                }
            }
        }

        for my $class (@candidates) {
            if (eval "require $class") {
                $primitive = $class->new({ name => $name });

                $tex->set_primitive($name, $primitive);

                last;
            }
        }

        die "Could not load primitive '$class_name'\n" unless defined $primitive;
    }

    return $primitive;
}

sub primitive {
    my $tex = shift;

    my $csname = shift;
    my $class  = shift || $csname;

    my $cmd = $tex->load_primitive($csname, $class);

    $tex->define_csname($csname, $cmd);

    return;
}

######################################################################
##                                                                  ##
##              [19] SAVING AND RESTORING EQUIVALENTS               ##
##                                                                  ##
######################################################################

my %save_stack_of :ARRAY(:name<save_stack> :push<__push_save_stack> :pop<__pop_save_stack>);

my %cur_level_of     :COUNTER(:name<cur_level>);
my %cur_group_of     :COUNTER(:name<cur_group>);
my %cur_boundary_of  :COUNTER(:name<cur_boundary>);

{
    package SaveRecord;

    use TeX::Class;

    use TeX::WEB2C qw(:save_stack_codes group_type);

    my %type_of  :ATTR(:name<type>);
    my %level_of :ATTR(:name<level>);
    my %index_of :ATTR(:name<index>);
    my %line_of  :ATTR(:name<line> :default<-1>);

    my %saved_eqvt_of :ATTR(:name<saved_eqvt>);

    sub to_string {
        my $self = shift;

        my $type  = $self->get_type();
        my $level = $self->get_level();
        my $index = $self->get_index();

        if ($type == restore_old_value) {
            return "{ restore_old_value: level = $level }";
        } elsif ($type == restore_zero) {
            return "{ restore_zero }";
        } elsif ($type == insert_token) {
            return "{ insert_token: $index }";
        } elsif ($type == level_boundary) {
            return sprintf("{ level_boundary: group = %s, prev_boundary = %d }",
                           group_type($level), $index);
        } else {
            return "{ SaveRecord: unknown type $type }";
        }
    }
}

sub push_save_stack {
    my $tex = shift;

    my $value = shift;

    $tex->__push_save_stack($value);

    if ($tex->tracing_groups() > 1) {
        my $save_ptr = $tex->save_ptr();

        $value = $value->to_string() if eval { $value->isa("SaveRecord") };

        $tex->DEBUG("push_save_stack:");
        $tex->DEBUG("  save_stack($save_ptr) = $value");
    }

    return;
}

sub pop_save_stack {
    my $tex = shift;

    my $save_ptr = $tex->save_ptr();

    my $value = $tex->__pop_save_stack();

    if ($tex->tracing_groups() > 1) {
        my $string = eval { $value->isa("SaveRecord") } ? $value->to_string() : $value;

        $tex->DEBUG("pop_save_stack:");
        $tex->DEBUG("  save_stack($save_ptr) = $string");
    }

    return $value;
}

sub init_save_stack {
    my $tex = shift;

    $tex->set_cur_level(level_one);
    $tex->set_cur_group(bottom_level);
    $tex->set_cur_boundary(-1);

    return;
}

sub save_ptr {
    my $tex = shift;

    my $save_stack = $save_stack_of{ident $tex};

    return scalar @{ $save_stack } - 1;
}

sub new_save_level {
    my $tex = shift;

    my $group_code = shift;

    if ($tex->tracing_groups() > 1) {
        $tex->print_ln();
        # $tex->DEBUG("entering new_save_level: group_code = " . group_type($group_code));

        $tex->show_save_stack();
    }

    my $line_no = $tex->input_line_no();

    my $save_record = SaveRecord->new({ type  => level_boundary,
                                        level => $tex->cur_group(),
                                        index => $tex->cur_boundary(),
                                        line  => $line_no });

    $tex->push_save_stack($save_record);

    my $save_ptr = $tex->save_ptr();

    $tex->set_cur_boundary($save_ptr);

    $tex->set_cur_group($group_code);

    if ($tex->tracing_groups > 0) {
        $tex->group_trace(false, $group_code, $line_no);
    }

    $tex->incr_cur_level();

    if ($tex->tracing_groups() > 1) {
        $tex->DEBUG("Updating save_stack:");

        # $tex->DEBUG(" *save_stack($save_ptr) = " . $save_record->to_string());

        $tex->DEBUG("  cur_level = " . $tex->cur_level());
        $tex->DEBUG("  cur_group = " . group_type($tex->cur_group()));
        $tex->DEBUG("  cur_boundary = " . $tex->cur_boundary());

        $tex->DEBUG("exiting new_save_level");

        $tex->print_ln();
    }

    return;
}

sub off_save {
    my $tex = shift;

    my $cur_tok = shift;

    my $context = shift || '<unknown>';

    $tex->print_err("Bad grouping ($context)");
    $tex->print_nl();

    my $cur_group = $tex->cur_group();

    if ($cur_group == bottom_level) {
        my $cur_cmd = $tex->get_meaning($cur_tok);

        $tex->print_err("Extra ");
        $tex->print_cmd_chr($cur_cmd);

        $tex->set_help("Things are pretty mixed up, but I think the worst is over.");

        $tex->error();
    } else {
        # $tex->back_input($cur_tok);

        $tex->print_err("Missing ");

        my $insert = new_token_list();

        if ($cur_group == semi_simple_group) {
            $insert->push(FROZEN_END_GROUP);

            $tex->print_esc("endgroup");
        }
        elsif ($cur_group == math_shift_group) {
            $insert->push(MATH_SHIFT_TOKEN);

            $tex->print_char("\$");
        }
        elsif ($cur_group == math_left_group) {
            $insert->push(FROZEN_RIGHT);
            $insert->push(point_token);

            $tex->print_esc("right.");
        }
        else {
            $insert->push(END_GROUP);

            $tex->print_char("}");
        }

        $tex->print(" inserted");

        $insert->push($cur_tok);

        $tex->ins_list($insert);

        # $tex->DEBUG("off_save: Inserting '$insert'");

        $tex->set_help("I've inserted something that you may have forgotten.",
                       "(See the <inserted text> above.)",
                       "With luck, this will get me unwedged. But if you",
                       "really didn't forget anything, try typing `2' now; then",
                       "my insertion and my current dilemma will both disappear.");

        $tex->error();
    }

    return;
}

sub eq_save {
    my $tex = shift;

    my $eqvt_ptr = shift;

    my $eqvt = $$eqvt_ptr;

    my $eqvt_level = $eqvt->level();

    my $save_record = SaveRecord->new({ type  => restore_old_value,
                                        level => $eqvt_level,
                                        index => $eqvt_ptr });

    if ($eqvt_level == level_zero) {
        $save_record->set_type(restore_zero);
    } else {
        $save_record->set_saved_eqvt($eqvt);
    }

    $tex->push_save_stack($save_record);

    return;
}

## Note that this unifies eq_define and eq_word_define

sub eq_define {
    my $tex = shift;

    my $eqvt_ptr = shift;
    my $equiv    = shift;

    if (! defined $eqvt_ptr) {
        croak "eq_defined: undefined eqvt_ptr";
    }

    my $modifier = shift || 0;

    my $global = $modifier & MODIFIER_GLOBAL;

    my $level = $global ? level_one : $tex->cur_level();

    my $eqvt = $$eqvt_ptr;

    ## Is this strictly accurate if we're not defining a control
    ## sequence?  Maybe.  Hmm.

    if (! defined($eqvt)) {
        $$eqvt_ptr = make_eqvt(UNDEFINED_CS, level_one);

        $eqvt = $$eqvt_ptr;
    }

    if ($eqvt->level() == $level) {
        ## no-op
    } elsif ($level > level_one) {
        $tex->eq_save($eqvt_ptr);
    }

    $$eqvt_ptr = make_eqvt($equiv, $level);

    return;
}

sub geq_define {
    my $tex = shift;

    my $eqvt_ptr = shift;
    my $equiv    = shift;

    $tex->eq_define($eqvt_ptr, $equiv, MODIFIER_GLOBAL);

    return;
}

sub define {
    my $tex = shift;

    my $token    = shift;
    my $command  = shift;
    my $modifier = shift;

    if ($token == CATCODE_ACTIVE) {
        $tex->define_active_char($token->get_char(), $command, $modifier);
    } elsif ($token == CATCODE_CSNAME) {
        $tex->define_csname($token->get_csname(), $command, $modifier);
    } else {
        $tex->print_err("Missing control sequence inserted");

        $tex->set_help("Please don't say `\\def cs{...}', say `\\def\\cs{...}'.",
                       "I'm ignoring this definition.");

        $tex->error();
    }

    return;
}

sub save_for_after {
    my $tex = shift;

    my $token = shift;

    my $save_record = SaveRecord->new({ type  => insert_token,
                                        level => level_zero,
                                        index => $token });

    $tex->push_save_stack($save_record);

    return;
}

sub unsave {
    my $tex = shift;

    my $tracing_groups = $tex->tracing_groups();

    if ($tracing_groups > 1) {
        $tex->show_save_stack("entering unsave");
    }

    my $group_type;
    my $line_no;

    if ($tex->cur_level() > level_one) {
        $tex->decr_cur_level();

        ## Check if it's defined so that a raw box-related value of 0
        ## on the stack doesn't abort prematurely.  (Such a value
        ## should never be encountered here, but bugs do happen, and
        ## failure to check for defined values instead of true values
        ## hid a bug for a while.)

        while (defined(my $record = $tex->pop_save_stack())) {
            if ($tex->tracing_groups() > 1) {
                my $string = $record->to_string();
                # $tex->DEBUG("unsave: popping $string");
            }

            if (! ref($record)) {
                croak "'$record' is not a SaveRecord";
            }

            if ($record->get_type() == level_boundary) {
                $group_type = $tex->cur_group();
                $line_no    = $record->get_line();

                $tex->set_cur_group($record->get_level());
                $tex->set_cur_boundary($record->get_index());

                last;
            }

            my $eqvt_ptr  = $record->get_index();
            my $save_type = $record->get_type();

            if ($save_type == insert_token) {
                $tex->back_input($eqvt_ptr);
            } else {
                my $saved_eqvt;

                if ($save_type == restore_old_value) {
                    $saved_eqvt = $record->get_saved_eqvt();
                } else { ## restore_zero
                    $saved_eqvt = UNDEFINED_CS;
                }

                if ( ${ $eqvt_ptr }->level() != level_one) {
                    ${ $eqvt_ptr } = $saved_eqvt;
                }
            }
        }
    } else {
        $tex->confusion("curlevel");
    }

    if ($tracing_groups > 1) {
        $tex->DEBUG("exiting unsave");

        $tex->DEBUG("  new_level = " . $tex->cur_level());
        $tex->DEBUG("  new_group = " . group_type($tex->cur_group()));
        $tex->DEBUG("  new_boundary = " . $tex->cur_boundary());

        $tex->print_ln();
    }

    if ($tracing_groups > 0) {
        $tex->group_trace(true, $group_type, $line_no);
    }

    return;
}

sub show_save_stack {
    my $tex = shift;

    my $label = shift;

    my $cur_boundary = $tex->cur_boundary();

    if (nonempty($label)) {
        $tex->print_ln();

        # $tex->DEBUG($label);
    }

    # $tex->DEBUG("  save_ptr = " . $tex->save_ptr());

    # $tex->DEBUG("  cur_level = " . $tex->cur_level());
    # $tex->DEBUG("  cur_group = " . group_type($tex->cur_group()));
    # $tex->DEBUG("  cur_boundary = " . $cur_boundary);

    my @stack = $tex->get_save_stacks();

    # $tex->DEBUG("save stack:");

    for (my $i = 0; $i < @stack; $i++) {
        my $record = $stack[$i];

        $record = $record->to_string() if eval { $record->isa("SaveRecord") };

        # if ($i == $cur_boundary) {
        #     $tex->DEBUG(" *save_stack($i) = $record");
        # } else {
        #     $tex->DEBUG("  save_stack($i) = $record");
        # }
    }

    # $tex->DEBUG("END save_stack $label");

    return;
 }

######################################################################
##                                                                  ##
##                         [20] TOKEN LISTS                         ##
##                                                                  ##
######################################################################

sub set_toks_list {
    my $tex = shift;

    my $type = shift;
    my $token_list = shift;

    my $ident = ident $tex;

    if (! exists $token_parameters_of{$ident}->{$type}) {
        $tex->print_err("set_toks_list: Unknown token list '$type'");

        $tex->set_help("I'm going to ignore this.");

        $tex->error();

        return;
    }

    if ($token_list->isa("TeX::Token")) {
        $token_list = TeX::TokenList->new({ tokens => [ $token_list ] });
    }

    $tex->eq_define(\$token_parameters_of{$ident}->{$type}, $token_list);

    return;
}

sub get_toks_list {
    my $tex = shift;

    my $name = shift;

    my $ident = ident $tex;

    if (exists $token_parameters_of{$ident}->{$name}) {
        my $eqvt = $token_parameters_of{$ident}->{$name};

        my $tokens_r = $eqvt->get_equiv();

        return unless defined $tokens_r;

        return if eval { $tokens_r->isa("TeX::Primitive::undefined") };

        return TeX::TokenList->new({ tokens => $tokens_r->get_value() });
    }

    if (defined(my $eqvt = $tex->get_csname($name))) {
        my $meaning = $eqvt->get_equiv();

        if (eval { $meaning->isa("TeX::Command::Executable::Readable") }) {
            my $level = $meaning->get_level();

            my $value = $meaning->read_value($tex);

            if ($level == tok_val) {
                return TeX::TokenList->new({ tokens => $value });
            }
        }
    }

    $tex->print_err("get_toks_list: Unknown token list '$name'");

    $tex->set_help("I'm going to ignore this.");

    $tex->error();

    return;
}

sub show_token_list {
    my $tex = shift;

    my $token_list = shift;
    my $magic_index = shift;
    my $limit       = shift;

    my @tokens;

    if (eval { $token_list->isa("TeX::TokenList") }) {
        @tokens = @{ $token_list };
    } else {
        @tokens = ($token_list);
    }

    for (my $i = 0; $i < @tokens && $i < $limit; $i++) {
        my $token = $tokens[$i];

        ## This shouldn't happen, but it does.  Why?

        if (! defined $token) {
            $tex->print_esc("<UNDEFINED>");
            next;
        }

        my $catcode = $token->get_catcode();

        if ($i == $magic_index) {
            # @<Do magic computation@>
        }

        if ($catcode == CATCODE_CSNAME) {
            my $csname = $token->get_csname();

            if (length($csname) == 0) {
                $tex->print_esc("csname");
                $tex->print_esc("endcsname");

                next;
            }

            $tex->print_esc($csname);

            unless (length($csname) == 1 &&
                    $tex->get_catcode(ord($csname)) != CATCODE_LETTER) {
                $tex->print_char(" ");
            }

            next;
        }

        if ($catcode == CATCODE_ANONYMOUS) {
            my $csname = $token->get_frozen_name();

            if (defined($csname) && length($csname) > 0) {
                $tex->print_esc($csname);

                unless (length($csname) == 1 &&
                        $tex->get_catcode(ord($csname)) != CATCODE_LETTER) {
                    $tex->print_char(" ");
                }
            } else {
                $tex->print_esc("ANONYMOUS_TOKEN");
            }

            next;
        }

        my $char = $token->get_char();

        if ($catcode == CATCODE_PARAMETER) {
            $tex->print($char);
            $tex->print($char);

            next;
        }

        if ($catcode == CATCODE_PARAM_REF) {
            $tex->print('#');

            my $param_no = $token->get_param_no();

            if ($param_no <= 9) {
                $tex->print($param_no);
            } else {
                $tex->print_char("!");
                return;
            }

            next;
        }

        $tex->print($char);
    }

    if (@tokens > $limit) {
        $tex->print_esc("ETC.");
    }

    return;
}

sub token_show {
    my $tex = shift;

    my $token_list = shift;

    return unless defined $token_list;

    return unless $token_list->length();

    $tex->show_token_list($token_list, -1, 10000000);

    return;
}

sub print_meaning {
    my $tex = shift;

    my $cur_cmd = shift;

    $tex->print_cmd_chr($cur_cmd);

    if (eval { $cur_cmd->isa("TeX::Primitive::Macro") }) {
        $tex->print_char(":");
        #$tex->print_ln();

        $tex->token_show($cur_cmd->get_parameter_text());
        $tex->print("->");
        $tex->token_show($cur_cmd->get_replacement_text());
    }
    elsif (eval { $cur_cmd->isa("TeX::Primitive::TopBotMark") }) {
        $tex->print_char(":");
        #$tex->print_ln();
        $tex->token_show($tex->get_cur_mark($cur_cmd->mark_code()));
    }

    return;
}

######################################################################
##                                                                  ##
##           [21] INTRODUCTION TO THE SYNTACTIC ROUTINES            ##
##                                                                  ##
######################################################################

sub print_cmd_chr {
    my $tex = shift;

    my $cur_cmd = shift;

    if (eval { $cur_cmd->isa("TeX::Token") }) {
        my $catcode = $cur_cmd->get_catcode();

        my $char = $cur_cmd->get_char();

        if ($catcode == left_brace) {
            $tex->print("begin-group character $char");
        } elsif ($catcode == right_brace) {
            $tex->print("end-group character $char");
        } elsif ($catcode == math_shift) {
            $tex->print("math shift character $char");
        } elsif ($catcode == tab_mark) {
            $tex->print("alignment tab character $char");
        } elsif ($catcode == mac_param) {
            $tex->print("macro parameter character $char");
        } elsif ($catcode == sup_mark) {
            $tex->print("superscript character $char");
        } elsif ($catcode == sub_mark) {
            $tex->print("subscript character $char");
        }
        # elsif ($catcode == endv) {
        #     $tex->print("end of alignment template");
        # }
        elsif ($catcode == spacer) {
            $tex->print("blank space $char");
        } elsif ($catcode == letter) {
            $tex->print("the letter $char");
        } elsif ($catcode == other_char) {
            $tex->print("the character $char");
        } else {
            $tex->print("UNKNOWN CHARACTER (wtf?)");
        }

        return;
    }

    $cur_cmd->print_cmd_chr($tex);

    return;
}

######################################################################
##                                                                  ##
##                   [22] INPUT STACKS AND STATES                   ##
##                                                                  ##
######################################################################

{
    package InStateRecord;

    use TeX::Class;

    use TeX::Constants qw(:file_types);

    my %lexer_state_of :COUNTER(:name<lexer_state> :default(-1));

    my %chars_of       :ARRAY(:name<char>);
    my %line_no_of     :COUNTER(:name<line_no> :default(-1));
    my %char_no_of     :COUNTER(:name<char_no> :default(-1));
    my %file_name_of   :ATTR(:name<file_name>);
    my %file_handle_of :ATTR(:name<file_handle>);
    my %file_type_of   :COUNTER(:name<file_type> :default<terminal>);
    my %eof_hook_of    :ATTR(:name<eof_hook>);

    my %token_list_of  :ATTR(:name<token_list>    :type<TeX::TokenList>);
    my %token_type_of  :COUNTER(:name<token_type> :default<-1>);

    sub to_string :STRINGIFY {
        my $self = shift;

        if ((my $type = $self->token_type()) > -1) {
            return "<token list $type> = {" . $self->get_token_list() . "}";
        } elsif (defined (my $file_name = $self->get_file_name())) {
            return $self->get_file_name();
        } else {
            return "<>";
        }
    }
}

my %input_stack_of :ARRAY(:name<input_stack> :type<InStateRecord>);

my %align_state_of :COUNTER(:name<align_state> :default<ALIGN_NO_COLUMN>);

my %open_parens_of :COUNTER(:name<open_parens>);

my %scanner_status_of :COUNTER(:name<scanner_status> :default<normal>);

##  cur_input (the currently active InStateRecord):
my %lexer_state_of :COUNTER(:name<lexer_state> :default(-1)); # state in tex.web

my %chars_of       :ARRAY(:name<char>);
my %line_no_of     :COUNTER(:name<input_line_no> :default(-1));
my %char_no_of     :COUNTER(:name<input_char_no> :default(-1));
my %file_name_of   :ATTR(:name<file_name>);
my %file_handle_of :ATTR(:name<cur_file>);
my %file_type_of   :COUNTER(:name<file_type> :default<terminal>);
my %eof_hook_of    :ATTR(:name<eof_hook>);

my %token_list_of :ATTR(:name<token_list> :type<TeX::TokenList>);
my %token_type_of :COUNTER(:name<token_type> :default<-1>);

sub runaway {
    my $tex = shift;

    my $token_list = shift;

    my $scanner_status = $tex->scanner_status();

    if ($scanner_status > skipping) {
        $tex->print_nl("Runaway ");

        if    ($scanner_status == defining) {
            $tex->print("definition");
        }
        elsif ($scanner_status == matching) {
            $tex->print("argument");
        }
        elsif ($scanner_status == aligning) {
            $tex->print("preamble");
        }
        elsif ($scanner_status == absorbing) {
            $tex->print("text");
        }
        else {
            $tex->fatal_error("Impossible scanner_status $scanner_status!");
        }

        $tex->print_char("?");
        $tex->print_ln;

        # $tex->show_token_list($token_list, null, error_line - 10);
    }

    return;
}

## This is a very barebones implementation that only displays the
## current line from the current input file.  It could use some work.

sub show_context {
    my $tex = shift;

    my $file_name   = $tex->get_file_name() || "<unknown>";
    my $line_number = $tex->input_line_no();

    my $prefix = "$file_name, l. $line_number> ";

    $tex->print_nl($prefix);

    my $length = length($prefix);

    my $current_line = $tex->get_context_line();

    $current_line =~ s{\r\z}{};

    my $current_char = min($tex->input_char_no(), length($current_line));

    $current_char = 0 if $current_char < 0;

    my $pre  = substr($current_line, 0, $current_char);
    my $post = substr($current_line, $current_char);

    $tex->print($pre);

    $tex->print_nl(" " x $length);
    $tex->print(" " x $current_char);
    $tex->print($post);

    $tex->print_ln();
    $tex->print_ln();

    return;
}

######################################################################
##                                                                  ##
##                [23] MAINTAINING THE INPUT STACKS                 ##
##                                                                  ##
######################################################################

sub push_input {
    my $tex = shift;

    my $saved = InStateRecord->new({
        lexer_state => $tex->lexer_state(),
        line_no     => $tex->input_line_no(),
        char_no     => $tex->input_char_no(),
        file_name   => $tex->get_file_name(),
        file_handle => $tex->get_cur_file(),
        file_type   => $tex->file_type(),
        eof_hook    => $tex->get_eof_hook(),
        token_list  => $tex->get_token_list(),
        token_type  => $tex->token_type(),
                                   });

    $saved->push_char($tex->get_chars());

    $tex->push_input_stack($saved);

    return;
}

sub pop_input {
    my $tex = shift;

    my $prev_state = $tex->pop_input_stack();

    # Now restore the previous state:

    my $prev_lexer_state = $prev_state->lexer_state();

    $tex->set_lexer_state($prev_lexer_state);

    # if ($prev_lexer_state == token_list) {
        $tex->set_token_list($prev_state->get_token_list());
        $tex->set_token_type($prev_state->token_type());
    # } else {
        $tex->delete_chars(); # should already be empty, but just in case

        $tex->push_char($prev_state->get_chars());

        $tex->set_input_line_no($prev_state->line_no());
        $tex->set_input_char_no($prev_state->char_no());
        $tex->set_file_name($prev_state->get_file_name());
        $tex->set_cur_file($prev_state->get_file_handle());
        $tex->set_file_type($prev_state->file_type());
        $tex->set_eof_hook($prev_state->get_eof_hook());
    # }

    return;
}

sub back_list {
    my $tex = shift;

    my $token_list = shift;

    ## TBD: This shouldn't be necessary!  Need to review align_state.

    for my $token ($token_list->get_tokens()) {
        if ($token == CATCODE_BEGIN_GROUP) {
            $tex->decr_align_state();
        } elsif ($token == CATCODE_END_GROUP) {
            $tex->incr_align_state();
        }
    }

    return $tex->begin_token_list($token_list, backed_up);
}

sub ins_list {
    my $tex = shift;

    my $token_list = shift;

    return $tex->begin_token_list($token_list, inserted);
}

sub back_input {
    my $tex = shift;

    my $token = shift;

    while ( ($tex->lexer_state() == token_list) &&
            ($tex->get_token_list()->length() == 0) &&
            ($tex->token_type() != v_template) ) {
        $tex->end_token_list; # {conserve stack space}???
    }

    my $catcode = $token->get_catcode();

    if ($catcode == CATCODE_BEGIN_GROUP) {
        $tex->decr_align_state();
    } elsif ($catcode == CATCODE_END_GROUP) {
        $tex->incr_align_state();
    }

    $tex->push_input();

    my $token_list = TeX::TokenList->new({ tokens => [ $token ] });

    $tex->set_lexer_state(token_list);
    $tex->set_token_list($token_list);
    $tex->set_token_type(backed_up);

    return;
}

## See %TeX::WEB2C::TOKEN_TYPES

my @TOKEN_LIST_TYPE = qw(parameter u_template v_template backed_up
                         inserted macro output everypar afterpar
                         everymath
                         everydisplay everyhbox everyvbox everyjob
                         everycr mark write);

sub begin_token_list {
    my $tex = shift;

    my $token_list = shift;

    croak unless defined $token_list && ref($token_list);

    my $copy = TeX::TokenList->new({ tokens => [ $token_list->get_tokens() ] });

    my $token_type = shift;

    if ($token_type !~ m{\A \d+ \z}smx) {
        confess "begin_token_list called without valid token_type";
    }

    $tex->push_input();

    $tex->set_lexer_state(token_list);
    $tex->set_token_list($copy);
    $tex->set_token_type($token_type);

    if ($token_type > macro) {
        if ($tex->tracing_macros() & TRACING_MACRO_TOKS) {
            $tex->begin_diagnostic();

            $tex->print_nl("");
            $tex->print_esc($TOKEN_LIST_TYPE[$token_type]);
            $tex->print("->");
            $tex->token_show($token_list);

            $tex->end_diagnostic(false);
        }
    }

    return;
}

sub end_token_list { # {leave a token-list input level}
    my $tex = shift;

    if ($tex->token_type() == u_template) {
        if ($tex->align_state() > ALIGN_FLAG) {
            $tex->set_align_state(ALIGN_COLUMN_BOUNDARY);
        } else {
            $tex->fatal_error("(interwoven alignment preambles are not allowed)");
        }
    }

    $tex->pop_input();

    $tex->check_interrupt();

    return;
}

sub back_error {
    my $tex = shift;

    my $token = shift;

    $tex->set_OK_to_interrupt(false);

    $tex->back_input($token);

    $tex->set_OK_to_interrupt(true);

    $tex->error();

    return;
}

sub ins_error {
    my $tex = shift;

    my $token = shift;

    $tex->set_OK_to_interrupt(false);

    $tex->back_input($token);

    $tex->set_token_type(inserted);

    $tex->set_OK_to_interrupt(true);

    $tex->error();

    return;
}

sub begin_file_reading {
    my $tex = shift;

    $tex->push_input();

    $tex->set_lexer_state(mid_line);

    $tex->delete_chars();
    $tex->set_input_line_no(-1);
    $tex->set_input_char_no(-1);
    $tex->delete_file_name();
    $tex->delete_cur_file();
    $tex->set_file_type(terminal);

    return;
}

sub begin_string_reading {
    my $tex = shift;

    my $string = shift;

    $tex->begin_file_reading();

    $tex->set_eof_hook(
        sub {
            my $tex = shift;

            $tex->back_input(END_TEX_TOKEN);

            return;
        });

    my $fh = $tex->a_open_in(\$string);

    $tex->set_file_name('<string>');
    $tex->set_file_type(string_input);
    $tex->set_cur_file($fh);

    $tex->set_lexer_state(new_line);

    $tex->set_input_line_no(1);

    $tex->input_ln($fh);

    $tex->firm_up_the_line();

    return;
}

sub end_file_reading {
    my $tex = shift;

    my $eof_hook = $tex->get_eof_hook();

    if ($tex->file_type() >= input_file) {
        my $fh = $tex->get_cur_file();

        close($fh); # {forget it}
    }

    $tex->pop_input();

    if (defined($eof_hook)) {
        $eof_hook->($tex);
    }

    return;
}

sub clear_for_error_prompt {
    my $tex = shift;

    while ( ($tex->lexer_state() != token_list) &&
            ($tex->file_type() == terminal) &&
            defined($tex->get_input_stack(0)) &&
            ($tex->get_token_list()->length() == 0) ) {
        $tex->end_file_reading();
    }

    $tex->print_ln();

    $tex->clear_terminal();

    return
}

######################################################################
##                                                                  ##
##                   [24] GETTING THE NEXT TOKEN                    ##
##                                                                  ##
######################################################################

my %force_eof_of :BOOLEAN(:name<force_eof> :default<false>);

use constant PAR_TOKEN   => make_csname_token('par');

sub maybe_check_outer_validity {
    my $tex = shift;

    my $cur_tok = shift;

    my $cur_cmd = $tex->get_meaning($cur_tok);

    if (eval { $cur_cmd->isa("TeX::Primitive::Macro") }) {
        if ($cur_cmd->is_outer()) {
            $tex->check_outer_validity($cur_tok);
        }
    }

    return;
}

sub check_outer_validity {
    my $tex = shift;

    my $cur_tok = shift;

    return;
}

sub peek_next_token {
    my $tex = shift;

    my $next_token = $tex->get_next();

    $tex->back_input($next_token);

    return $next_token;
}

##BUG: NOT RIGHT OF AT END OF LINE

sub peek_next_char {
    my $tex = shift;

    my $next_char = $tex->get_char(0);

    return $next_char;
}

# Cf. ends_align_template()

sub ends_align_entry {
    my $tex = shift;

    my $cur_tok = shift;

    return unless $tex->align_state() == ALIGN_COLUMN_BOUNDARY;

    my $cur_cmd = $tex->get_meaning($cur_tok);

    return unless defined $cur_cmd;

    return ($cur_tok == CATCODE_ALIGNMENT
            || eval { $cur_cmd->isa("TeX::Primitive::cr") }
            || eval { $cur_cmd->isa("TeX::Primitive::span") });
}

sub get_next {
    my $tex = shift;

    my $cur_tok;

    if ($tex->lexer_state() == token_list) {
        $cur_tok = $tex->get_next_from_token_list();
    } else {
        $cur_tok = $tex->get_next_from_file();
    }

    # @<If an alignment entry has just ended, take appropriate action@>;

    if ($tex->ends_align_entry($cur_tok)) {
        $tex->insert_v_template($cur_tok);

        return $tex->get_next();
    }

    if ($tex->tracing_input()) {
        my $prefix;

        if ($tex->lexer_state() == token_list) {
            $prefix = 'token list> ';
        } else {
            my $file_name   = $tex->get_file_name() || "<unknown>";
            my $line_number = $tex->input_line_no();

            $prefix = "$file_name, l. $line_number> ";
        }

        $tex->begin_diagnostic();

        $tex->print_nl("");

        my $catcode = $cur_tok->get_catcode();

        $tex->print("get_next: $prefix $cur_tok ($catcode)");

        $tex->end_diagnostic(false);
    }

    return $cur_tok;
}

sub get_next_careful {
    my $tex = shift;

    my $save_scanner_status = $tex->scanner_status();

    $tex->set_scanner_status(normal);

    my $token = $tex->get_next();

    $tex->set_scanner_status($save_scanner_status);

    return $token;
}

sub get_token {
    my $tex = shift;

    $tex->set_no_new_control_sequence(false);

    my $token = $tex->get_next();

    $tex->set_no_new_control_sequence(true);

    return $token;
}

sub get_token_careful {
    my $tex = shift;

    my $save_scanner_status = $tex->scanner_status();

    $tex->set_scanner_status(normal);

    my $token = $tex->get_token();

    $tex->set_scanner_status($save_scanner_status);

    return $token;
}

# Unicode: Should we allow EOL chars > 255?

sub end_line_char_inactive {
    my $tex = shift;

    my $eol = $tex->end_line_char();

    return $eol < 0 || $eol > 255 || $tex->file_type() == string_input;
}

sub get_next_from_file {
    my $tex = shift;

  switch:
    while (1) {
        my ($char, $catcode) = $tex->get_next_char();

        if (! defined $char) {
            $tex->set_lexer_state(new_line);

            my $cur_file_type = $tex->file_type();

            if ($cur_file_type >= anonymous_file) {
                $tex->incr_input_line_no();

                if (! $tex->is_force_eof()) {
                    if ($tex->input_ln($tex->get_cur_file())) {
                        # {not end of file}

                        $tex->firm_up_the_line();
                    } else {
                        $tex->set_force_eof(true);
                    }
                }

                if ($tex->is_force_eof()) {
                    if ($cur_file_type < string_input) {
                        $tex->print_char(")");
                        $tex->decr_open_parens();
                        $tex->update_terminal(); # {show user that file has been read}
                    }

                    $tex->set_force_eof(false);

                    $tex->end_file_reading(); # {resume previous level}

                    $tex->check_outer_validity();

                    return $tex->get_next(); # goto restart;
                }

                if (! $tex->end_line_char_inactive()) {
                    $tex->push_char(chr($tex->end_line_char));
                }
            } else {
                if ($tex->file_type != terminal) {
                    # {\.{\\read} line has ended}

                    return;
                }

                if (@{ $tex->get_input_stacks() } > 0){
                    # {text was inserted during error recovery}

                    $tex->end_file_reading();

                    # {resume previous level}
                    return $tex->get_next(); # goto restart;
                }

                if ($tex->selector() < log_only) {
                    $tex->open_log_file();
                }

                if ($tex->get_interaction_mode() > nonstop_mode) {
                    # if limit = start then {previous line was empty}
                    $tex->print_nl("(Please type a command or say `\\end')");

                    $tex->print_ln();

                    $tex->prompt_input("*");

                    if (! $tex->end_line_char_inactive()) {
                        $tex->push_char(chr($tex->end_line_char));
                    }
                } else {
                    $tex->fatal_error("*** (job aborted, no legal \\end found)");

                    # nonstop mode, which is intended for overnight
                    # batch processing, never waits for on-line input}
                }
            }

            $tex->check_interrupt();

            redo;
        }

      reswitch:

        redo if $catcode == CATCODE_IGNORED;

        if ($catcode == CATCODE_ESCAPE) {
            return $tex->scan_control_sequence($char);
        }

        if ($catcode == CATCODE_ACTIVE) {
            return $tex->process_active_character($char);
        }

        if ($catcode == CATCODE_INVALID) {
            $tex->print_err("Text line contains an invalid character");

            $tex->set_help("A funny symbol that I can't read has just been input.",
                           "Continue, and I'll forget that it ever happened.");

            $tex->set_deletions_allowed(false);

            $tex->error();

            $tex->set_deletions_allowed(true);

            return $tex->get_next(); # goto restart;
        }

        if ($catcode == CATCODE_END_OF_LINE) {
            if (my $token = $tex->finish_line($char)) {
                return $token;
            }

            redo;
        }

        if ($catcode == CATCODE_SPACE) {
            if (my $token = $tex->process_space($char)) {
                return $token;
            }

            redo;
        }

        if ($catcode == CATCODE_COMMENT) {
            $tex->flush_line_buffer();

            redo;
        }

        if ($catcode == CATCODE_BEGIN_GROUP) {
            $tex->incr_align_state();

            ## FALL THROUGH
        }

        if ($catcode == CATCODE_END_GROUP) {
            $tex->decr_align_state();

            ## FALL THROUGH
        }

        $tex->set_lexer_state(mid_line);

        return make_character_token($char, $catcode);
    }

    return;
}

sub get_next_char {
    my $tex = shift;

    my $char = $tex->shift_char();

    return unless defined $char;

    my $catcode = $tex->get_catcode(ord($char));

    if ($catcode == CATCODE_SUPERSCRIPT) {
        my $next_char = $tex->peek_next_char();

        if (defined($next_char) && $next_char eq $char) {
            $tex->get_next_char();

            my $c = $tex->peek_next_char();

            if (defined($c) && ord($c) < 0200) {
                # {yes we have an expanded char}

                $tex->get_next_char();

                if (is_hex($c)) {
                    my $cc = $tex->peek_next_char();

                    if (defined($cc) && is_hex($cc)) {
                        $tex->get_next_char();

                        $char = chr(hex("$c$cc"));
                    }
                } elsif ($c =~ /[\x00-\x3F]/) {
                    $char = chr(ord($c) + 64);
                } else {
                    $char = chr(ord($c) - 64);
                }
            }
        }
    }

    return wantarray ? ($char, $tex->get_catcode(ord($char))) : $char;
}

sub scan_control_sequence {
    my $tex = shift;

    my $char = shift;

    my $control_name = "";

    my ($first_char, $first_catcode) = $tex->get_next_char();

    if (defined($first_char)) {
        $control_name = $first_char;

        if ($first_catcode == CATCODE_LETTER) {
            my ($next_char, $next_catcode) = $tex->get_next_char();

            while (1) {
                last unless defined $next_char;

                if ($next_catcode == CATCODE_LETTER) {
                    $control_name .= $next_char;
                } else {
                    $tex->unshift_char($next_char);

                    last;
                }

                ($next_char, $next_catcode) = $tex->get_next_char();
            }

            $tex->set_lexer_state(skip_blanks);
        } else {
            if ($first_catcode == CATCODE_SPACE) {
                $tex->set_lexer_state(skip_blanks);
            } else {
                $tex->set_lexer_state(mid_line);
            }
        }
    }

    my $cur_tok = make_csname_token($control_name);

    # if (! $tex->no_new_control_sequence()) {
        if (! defined($tex->get_meaning($cur_tok))) {
            $tex->define_csname($control_name => UNDEFINED_CS);
        }
    # }

    $tex->maybe_check_outer_validity($cur_tok);

    return $cur_tok;
}

sub process_active_character {
    my $tex = shift;

    my $cur_chr = shift;

    my $cur_tok = make_character_token($cur_chr, CATCODE_ACTIVE);

    $tex->maybe_check_outer_validity($cur_tok);

    return $cur_tok;
}

sub flush_line_buffer {
    my $tex = shift;

    $tex->delete_chars();

    return;
}

sub finish_line {
    my $tex = shift;
    my $char = shift;

    $tex->flush_line_buffer();

    my $state = $tex->lexer_state();

    my $cur_tok;

    if ($state == new_line) {
        $cur_tok = PAR_TOKEN;

        $tex->maybe_check_outer_validity($cur_tok);
    } elsif ($state == mid_line) {
        $cur_tok = SPACE_TOKEN;
    } elsif ($state == skip_blanks) {
        # no-op
    } else {
        die "Invalid lexer state: $state";
    }

    return $cur_tok;
}

sub process_space {
    my $tex = shift;

    my $char = shift;

    my $cur_tok;

    my $state = $tex->lexer_state();

    if ($state == new_line || $state == skip_blanks) {
        # no-op
    } elsif ($state == mid_line) {
        $tex->set_lexer_state(skip_blanks);

        return SPACE_TOKEN;
    } else {
        die "Invalid lexer state '$state'";
    }
}

## Not sure we need this.

sub firm_up_the_line {
    my $tex = shift;

    return;
}

sub get_next_from_token_list {
    my $tex = shift;

    while (1) {
        ##???
        my $token_list = $tex->get_token_list();

        if (defined $token_list && defined(my $cur_tok = $token_list->shift())) {
            my $cur_cat = $cur_tok->get_catcode();

            if ($cur_cat == CATCODE_CSNAME) {
                my $cur_cmd = $tex->get_meaning($cur_tok);

                ## Should we be checking the unexpanded macro here?

                if (eval { $cur_cmd->isa("TeX::Primitive::Macro") }) {
                    if ($cur_cmd->is_outer()) {
                        $tex->check_outer_validity($cur_tok);
                    }
                }
            } else {
                if ($cur_cat == CATCODE_BEGIN_GROUP) {
                    $tex->incr_align_state();
                } elsif ($cur_cat == CATCODE_END_GROUP) {
                    $tex->decr_align_state();
                } elsif ($cur_cat == CATCODE_PARAMETER) {
                    # NOT USED
                    # @<Insert macro parameter and |goto restart|@>;
                }
            }

            return $cur_tok;
        }

        $tex->end_token_list();

        ## The following line slightly optimizes the common case of
        ## popping from one token list to another token list.  In the
        ## absence of this line, deeply nested macro calls can cause
        ## get_next() and get_next_from_token_list() to recurse
        ## deeply, which can cause perl to issue a "Deep recursion on
        ## subroutine" warning.  The warning could be suppressed with
        ## a "no warnings qw(recursion)" pragma here and in
        ## get_next(), but this feels cleaner and less likely to
        ## suppress a valid warning.

        next if $tex->lexer_state() == token_list;

        return $tex->get_next(); # goto restart; {resume previous level}
    }

    ## NEVER GET HERE
}

######################################################################
##                                                                  ##
##                  [25] EXPANDING THE NEXT TOKEN                   ##
##                                                                  ##
######################################################################

sub do_csname { # @<Manufacture a control sequence name@>
    my $tex = shift;

    my $cur_tok = shift;

    my $csname = "";

    my $token;

    while ($token = $tex->get_x_token()) {
        last if $token->get_catcode() > CATCODE_OTHER;

        $csname .= $token->get_datum();
    }

    my $cur_cmd = $tex->get_meaning($token);

    if (! eval { $cur_cmd->isa("TeX::Primitive::endcsname") }) {
        $tex->print_err("Missing ");
        $tex->print_esc("endcsname");
        $tex->print(" inserted");

        $tex->set_help("The control sequence marked <to be read again> should",
                       "not appear between \\csname and \\endcsname.");

        $tex->back_error($token);
    }

    my $new_tok = make_csname_token($csname);

    if (! $tex->no_new_control_sequence()) { ## ???
        my $meaning = $tex->get_meaning($new_tok);

        if ( (! defined($meaning)) || ident($meaning) == ident(UNDEFINED_CS) ) {
            $tex->define_csname($csname => FROZEN_RELAX);
        }
    }

    return $new_tok;
}

## I don't expect to use this, but here it is.
my %cur_mark_of :ARRAY(:name<cur_mark> :type<TeX::TokenList>);

sub insert_relax {
    my $tex = shift;

    my $cur_tok = shift;

    $tex->back_input($cur_tok);

    $tex->back_input(FROZEN_RELAX_TOKEN);

    $tex->set_token_type(inserted);

    return;
}

sub get_x_token {
    my $tex = shift;

    while (1) {
        my $cur_tok = $tex->get_next();

        ## TeX might start reading input from stdin at this point, but
        ## we might want to just exit.

        return unless defined $cur_tok;

        ## TBD: this implementation of \noexpand is broken...or is it?

        if (ident($cur_tok) == ident(FROZEN_DONT_EXPAND_TOKEN)) {
            return $tex->get_next();
        }

        if (ident($cur_tok) == ident(FROZEN_END_TEMPLATE_TOKEN)) {
            return FROZEN_ENDV_TOKEN;
        }

        if (my $cur_cmd = $tex->get_expandable_meaning($cur_tok)) {
            $cur_cmd->expand($tex, $cur_tok);
        } else {
            return $cur_tok;
        }
    }

    # NEVER GET HERE
}

## This reads as much of the parameter_text as possible, but if it
## can't read the entire parameter_text, it returns an empty list and
## loses any tokens that it has already read.  It might be useful to
## have a version that returns the input buffer to it's original state
## if it can't read the entire expected text.

# *read_macro_parameters = \&scan_macro_parameters;

sub scan_macro_parameters {
    my $tex = shift;

    $tex->set_scanner_status(matching);

    my $cur_tok    = shift;
    my $param_text = shift;
    my $failure_ok = shift;

    $failure_ok = 0 unless defined $failure_ok;
    $cur_tok ||= '<undef>';

    my @parameter_text = @{ $param_text };

    my $scanned = new_token_list();

    my @parameters = (undef);

    while (my $token = shift @parameter_text) {
        if ($token->is_param_ref()) {
            my @delimiter;

            while (my $next = $parameter_text[0]) {
                last if $next->is_param_ref();

                push @delimiter, $next;

                shift @parameter_text;
            }

            my $arg;

            if (@delimiter) {
                $arg = $tex->scan_delimited_parameter(@delimiter);
            } else {
                $arg = $tex->read_undelimited_parameter();
            }

            push @parameters, $arg;

            ## BUG: Won't preserve outer { and }
            $scanned->push($arg, @delimiter);
        } elsif (! $tex->require_token($token)) {
            if ($failure_ok) {
                $tex->back_list($scanned);

                return;
            } else {
                $tex->print_err("Use of ");
                $tex->print($cur_tok);
                $tex->print(" doesn't match its definition");

                $tex->set_help("If you say, e.g., `\\def\\a1{...}', then you must always",
                               "put `1' after `\\a', since control sequence names are",
                               "made up of letters only. The macro here has not been",
                               "followed by the required stuff, so I'm ignoring it.");

                $tex->error();
            }

            last;
        }
    }

    return @parameters;
}

## Scan a single parameter, delimited by a sequence of one or more
## tokens.

sub scan_delimited_parameter {
    my $tex   = shift;
    my @delim = @_; # a non-empty list of non-parameter tokens,
                    # aka the delimiter

    croak "Empty limit in scan_delimited_parameter()" if @delim == 0;

    ## Consider the following macro and its expansions:
    ##
    ##     \def\A#1\B{}
    ##     \A X\B     % #1<-X
    ##     \A {X}\B   % #1<-X
    ##     \A {X}Y\B  % #1<-{X}Y
    ##
    ## Lines 2 and 3 illustrate why balanced text has to be handled
    ## delicately.  When we encounter a begin_group token, we save the
    ## associated balanced text inside @defer until we see the
    ## following token and can decide whether or not the keep the
    ## enclosing braces.

    my @parameter;

    my @defer; # a balanced group

  OUTER:
    while (my $token = $tex->get_next()) {
        ## CASE 1: A begin_group token.  Scan balanced text and save
        ## it (along with its begin_group and end_group tokens) until
        ## we see the next token, at which point we can decide whether
        ## to keep the begin_group and end_group tokens.

        if ($token == CATCODE_BEGIN_GROUP) {
            ## Special case: If the delimiter begins with a
            ## begin_group token (e.g., \def\X#1#{}), it cannot
            ## contain any other tokens, so we stop now.

            if ($token == $delim[0]) {
                $tex->decr_align_state();
                last;
            }

            ## If there are any deferred tokens, push them out now,
            ## keeping the braces.

            push @parameter, @defer;

            ## And start a new list of deferred tokens with the
            ## current balanced text.

            @defer = ($token);

            push @defer, @{ $tex->read_balanced_text() };

            my $close_brace = $tex->get_next();

            ## read_balanced_text() either eats up all of the input or
            ## it leaves a closing brace in the input stream, so we
            ## only need to check whether there is a token left.

            if (! defined($close_brace)) {
                $tex->premature_end_error();
            }

            push @defer, $close_brace;

            next OUTER;
        }

        ## CASE 2: Not a begin_group

        ## Use a TokenList for back_list() below.

        my $partial_delim = new_token_list();

      INNER:
        while (1) {
            if ($token == CATCODE_BEGIN_GROUP) {
                $tex->back_input($token);

                push @parameter, $partial_delim->get_tokens();

                last;
            }

            ## First, check to see if we've reached the end of the
            ## parameter text.

            my @target = @delim;

            while ($token == $target[0]) {
                $partial_delim->push($token);

                shift @target;

                last if @target == 0; # Successful match

                $token = $tex->get_next();

                if ($token == CATCODE_BEGIN_GROUP) {
                    next INNER;
                }
            }

            if (@target == 0) { # End of parameter text
                if (@defer) {
                    if (@parameter == 0) { # @defer is the whole parameter
                        shift @defer;      # strip braces
                        pop @defer;
                    }

                    push @parameter, @defer;
                }

                last OUTER;
            }

            ## Still in the middle of the parameter text.

            if (@defer) {
                push @parameter, @defer;
                @defer = ();
            }

            if ($partial_delim->length() == 0) {
                push @parameter, $token;

                $token = $tex->get_next();

                if ($token == CATCODE_BEGIN_GROUP) {
                    $tex->back_input($token);

                    last;
                }
            } else { # FAILED match
                $tex->back_input($token);

                push @parameter, $partial_delim->shift();

                $tex->back_list($partial_delim);

                $partial_delim->clear();

                $token = $tex->get_next();
            }
        }
    }

    if (! defined($tex->peek_next_token())) {
        $tex->premature_end_error();
    }

    return TeX::TokenList->new({ tokens => \@parameter });
}

######################################################################
##                                                                  ##
##                   BASIC SCANNING ROUTINES [26]                   ##
##                                                                  ##
######################################################################

sub scan_left_brace {
    my $tex = shift;

    my $token = $tex->get_next_non_blank_non_relax_non_call_token();

    my $cur_cmd = $tex->get_meaning($token);

    if ($cur_cmd != CATCODE_BEGIN_GROUP) {
        $tex->print_err("Missing { inserted");

        $tex->set_help("A left brace was mandatory here, so I've put one in.",
                        "You might want to delete and/or insert some corrections",
                        "so that I will find a matching right brace soon.",
                        "(If you're confused by all this, try typing `I}' now.)");

        $tex->back_error($token);

        $tex->incr_align_state();
    }

    return;
}

sub get_next_non_blank_non_relax_non_call_token {
    my $tex = shift;

    while (1) {
        my $token = $tex->get_x_token();

        next if $token == CATCODE_SPACE; #*?

        if ($token->is_definable) {
            my $cur_cmd = $tex->get_meaning($token);

            next if ident($cur_cmd) == ident(FROZEN_RELAX);
        }

        return $token;
    }

    return;
}

sub scan_optional_equals {
    my $tex = shift;

    my $token = $tex->get_next_non_blank_non_call_token();

    unless ($token == $TOKEN_EQUAL) {
        $tex->back_input($token);
    }

    return;
}

sub get_next_non_blank_non_call_token {
    my $tex = shift;

    while (1) {
        my $token = $tex->get_x_token();

        next if $tex->is_space_token($token);

        return $token;
    }

    return;
}

sub peek_next_non_blank_non_call_token {
    my $tex = shift;

    my $token = $tex->get_next_non_blank_non_call_token();

    if (defined($token)) {
        $tex->back_input($token);
    }

    return $token;
}

sub ignorespaces {
    my $tex = shift;

    my $next_token = $tex->get_next_non_blank_non_call_token();

    $tex->back_input($next_token) if defined $next_token;

    return;
}

sub scan_keyword {
    my $tex = shift;

    my $s = shift;

    my $scanned = new_token_list();

    my $match = true;

    my @chars = split '', $s;

    for my $char (split '', $s) {
        my $token = $tex->get_x_token();

        $scanned->push($token);

        if ($token < CATCODE_ACTIVE) {
            my $this_char = $token->get_char();

            if (lc($this_char) ne lc($char)) {
                $match = false;

                last;
            }
        } elsif (! $tex->is_space_token($token) || $scanned->length() > 0) {
            $match = false;

            last;
        }
    }

    if (! $match) {
        $tex->back_list($scanned);
    }

    return $match;
}

sub mu_error {
    my $tex = shift;

    $tex->print_err("Incompatible glue units");

    $tex->set_help("I'm going to assume that 1mu=1pt when they're mixed.");

    $tex->error();

    return;
}

##*TODO: This is incomplete.

sub scan_something_internal {
    my $tex = shift;

    my $level  = shift;
    my $negate = shift;

    my $cur_tok = $tex->get_next(); ## Assume already expanded by caller.

    my $cur_cmd = $tex->get_meaning($cur_tok);

    my $cur_val = 0;
    my $cur_val_level;

    if (eval { $cur_cmd->isa("TeX::Command::Executable::Readable") }) {
        $cur_val       = $cur_cmd->read_value($tex, $cur_tok);
        $cur_val_level = $cur_cmd->get_level();
    } else {
        $tex->print_err("You can't use `");
        $tex->print_cmd_chr($cur_cmd);
        $tex->print("' after ");
        $tex->print_esc("the");

        $tex->set_help("I'm forgetting what you said and using zero instead.");

        $tex->error();

        if ($level != tok_val) {
            $cur_val_level = dimen_val;
        } else {
            $cur_val_level = int_val;
        }
    }

    while ($cur_val_level > $level) {
        if ($cur_val_level == glue_val) {
            ##???
            if (UNIVERSAL::can($cur_val, "get_width")) {
                $cur_val = $cur_val->get_width();
            } else {
                $cur_val = 0;
            }
        } elsif ($cur_val_level == mu_val) {
            $tex->mu_error();
        }

        $cur_val_level--;
    }

    if ($negate) {
        if ($cur_val_level >= glue_val) {
            $cur_val->set_width  (- $cur_val->get_width());
            $cur_val->set_stretch(- $cur_val->get_stretch());
            $cur_val->set_shrink (- $cur_val->get_shrink());
        } else {
            $cur_val = -$cur_val;
        }
    }

    return wantarray ? ($cur_val, $cur_val_level) : $cur_val;
}

sub scan_eight_bit_int {
    my $tex = shift;

    my $cur_val = $tex->scan_int();

    if ($cur_val < 0 || $cur_val > 255) {
        $tex->print_err("Bad register code");

        $tex->set_help("A register number must be between 0 and 255.",
                        "I changed this one to zero.");

        $tex->int_error($cur_val);

        $cur_val = 0;
    }

    return $cur_val;
}

## Allow Unicode.  Cf. XeTeX scan_usv_num()

sub scan_char_num {
    my $tex = shift;

    my $cur_val = $tex->scan_int();

    # if ($cur_val < first_text_char || $cur_val > last_text_char) {
    #     $tex->print_err("Bad character code");
    #
    #     $tex->set_help("A character number must be between 0 and 255.",
    #                     "I changed this one to zero.");
    #
    #     $tex->int_error($cur_val);
    #
    #     $cur_val = 0;
    # }

    if ($cur_val < first_unicode_char || $cur_val > last_unicode_char) {
        $tex->print_err("Bad character code");

        $tex->set_help("A character number must be between 0 and 2^{31} - 1.",
                        "I changed this one to zero.");

        $tex->int_error($cur_val);

        $cur_val = 0;
    }

    return $cur_val;
}

sub scan_math_class_int {
    my $tex = shift;

    my $cur_val = $tex->scan_int();

    if ( $cur_val < 0 || $cur_val > 7 ) {
        $tex->print_err("Bad math class");

        $tex->set_help("Since I expected to read a number between 0 and 7,",
                       "I changed this one to zero.");

        $tex->int_error($cur_val);

      $cur_val = 0;
    }

    return $cur_val;
}

sub scan_math_fam_int {
    my $tex = shift;

    my $cur_val = $tex->scan_int();

    if ( $cur_val <0 || $cur_val > number_math_families - 1 ) {
        $tex->print_err("Bad math family");

        $tex->set_help("Since I expected to read a number between 0 and 255,",
                       "I changed this one to zero.");

        $tex->int_error($cur_val);

        $cur_val = 0;
    }

    return $cur_val;
}

sub scan_four_bit_int {
    my $tex = shift;

    my $cur_val = $tex->scan_int();

    if ($cur_val < 0 || $cur_val > 15) {
        $tex->print_err("Bad number");

        $tex->set_help("Since I expected to read a number between 0 and 15,",
                        "I changed this one to zero.");

        $tex->int_error($cur_val);

        $cur_val = 0;
    }

    return $cur_val;
}

sub scan_fifteen_bit_int {
    my $tex = shift;

    my $cur_val = $tex->scan_int();

    if ($cur_val < 0 || $cur_val > 077777) {
        $tex->print_err("Bad mathchar");

        $tex->set_help("A mathchar number must be between 0 and 32767.",
                        "I changed this one to zero.");

        $tex->int_error($cur_val);

        $cur_val = 0;
    }

    return $cur_val;
}

sub scan_twenty_seven_bit_int {
    my $tex = shift;

    my $cur_val = $tex->scan_int();

    if ($cur_val < 0 || $cur_val > 0777777777) {
        $tex->print_err("Bad delimiter code");

        $tex->set_help("A numeric delimiter code must be between 0 and 2^{27} - 1.",
                        "I changed this one to zero.");

        $tex->int_error($cur_val);

        $cur_val = 0;
    }

    return $cur_val;
}

sub scan_int {
    my $tex = shift;

    my $sign = $tex->scan_optional_signs();

    my $cur_val       =  0;
    my $cur_val_level = -1;
    my $radix         =  0;

    my $next_token = $tex->peek_next_token();

    if ($next_token == alpha_token) {
        $tex->get_next();

        $cur_val = $tex->scan_alphabetic_character_code();
    } else {
        my $next_cmd = $tex->get_meaning($next_token);

        if (eval { $next_cmd->isa("TeX::Command::Executable::Readable") }) {
            ($cur_val, $cur_val_level) = $tex->scan_something_internal(int_val, false);
        } else {
            ($cur_val, $radix) = $tex->scan_numeric_constant();
        }
    }

    $cur_val *= $sign;

    return wantarray ? ($cur_val, $radix, $cur_val_level) : $cur_val;
}

sub scan_optional_signs {
    my $tex = shift;

    my $sign = 1;

    while (my $token = $tex->get_next_non_blank_non_call_token()) {
        next if $token == $TOKEN_PLUS;

        if ($token == $TOKEN_MINUS) {
            $sign *= -1;

            next;
        }

        $tex->back_input($token);

        last;
    }

    return $sign;
}

sub scan_alphabetic_character_code {
    my $tex = shift;

    my $cur_val = 0;

    my $cur_tok = $tex->get_next();

    if (! defined($cur_tok)) {
        croak "End of input while looking for alphabetic constant";
    }

    if ($cur_tok < CATCODE_CSNAME) {
        $cur_val = ord($cur_tok->get_char());

        if ($cur_tok == right_brace) {
            $tex->incr_align_state();
        } elsif ($cur_tok == left_brace) {
            $tex->decr_align_state();
        }
    } else {
        my $csname = $cur_tok->get_csname();

        if (length($csname) > 1) {
            $tex->print_err("Improper alphabetic constant (`\\$csname)");

            $tex->set_help("A one-character control sequence belongs after a ` mark.",
                            "So I'm essentially inserting \\0 here.");

            $cur_val = ord("0");

            $tex->back_error($cur_tok);
        } else {
            $cur_val = ord($csname);

            $tex->scan_optional_space();
        }
    }

    return $cur_val;
}

sub scan_optional_space() {
    my $tex = shift;

    my $cur_tok = $tex->get_x_token();

    my $cur_cmd = $tex->get_meaning($cur_tok);

    if ($cur_cmd != spacer) {
        $tex->back_input($cur_tok);
    }

    return;
}

sub scan_numeric_constant {
    my $tex = shift;

    my $cur_val;
    my $radix = 0;

    my $cur_tok = $tex->get_next(); ## Assume already expanded by caller.

    # if (! defined($cur_tok)) {
    #     croak "End of input while reading integer literal";
    # }

    if ($cur_tok == octal_token) {
        $radix = 8;

        $cur_val = $tex->scan_octal_integer();
    } elsif ($cur_tok == hex_token) {
        $radix = 16;

        $cur_val = $tex->scan_hexadecimal_integer();
    } elsif ($tex->is_digit($cur_tok)) {
        $tex->back_input($cur_tok);

        $radix = 10;

        $cur_val = $tex->scan_decimal_integer();
    }

    if (! defined $cur_val) {
        $tex->missing_number_error($cur_tok);

        $cur_val = 0;
    }

    return wantarray ? ($cur_val, $radix) : $cur_val;
}

sub scan_octal_integer {
    my $tex = shift;

    my $number = "";

    while (my $token = $tex->get_x_token()) {
        if ($tex->is_octal_digit($token)) {
            $number .= $token;

            next;
        }

        $tex->back_input($token) unless $tex->is_space_token($token);

        last;
    }

    return unless length($number);

    return oct($number);
}

sub scan_hexadecimal_integer {
    my $tex = shift;

    my $number = "";

    while (my $token = $tex->get_x_token()) {
        if ($tex->is_hex_digit($token)) {
            $number .= $token;

            next;
        }

        $tex->back_input($token) unless $tex->is_space_token($token);

        last;
    }

    return unless length($number);

    return hex($number);
}

sub scan_decimal_integer {
    my $tex = shift;

    my $number = "";

    while (my $token = $tex->get_x_token()) {
        if ($tex->is_digit($token)) {
            $number .= $token;

            next;
        }

        if (! $tex->is_space_token($token)) {
            $tex->back_input($token);
        }

        last;
    }

    return unless length($number);

    return $number + 0;
}

sub is_digit {
    my $tex = shift;
    my $token = shift;

    return $token == CATCODE_OTHER && $token =~ /^\d$/;
}

sub is_octal_digit {
    my $tex = shift;
    my $token = shift;

    return $token == CATCODE_OTHER && $token =~ /^[0-7]$/;
}

sub is_hex_digit {
    my $tex = shift;
    my $token = shift;

    return 1 if $tex->is_digit($token);

    return unless $token == CATCODE_LETTER || $token == CATCODE_OTHER;

    ## Case sensitive!!

    return $token =~ /^[A-F]$/;
}

sub is_implicit_space {
    my $tex = shift;
    my $token = shift;

    my $meaning = $tex->get_meaning($token);

    if (eval { $meaning->isa("TeX::Token") }) {
        return $meaning == CATCODE_SPACE;
    }

    return;
}

sub is_space_token {
    my $tex = shift;
    my $token = shift;

    return unless defined $token;

    return $token == CATCODE_SPACE || $tex->is_implicit_space($token);
}

sub scan_dimen {
    my $tex = shift;

    my $mu       = shift;
    my $inf      = shift;
    my $shortcut = shift;

    my $cur_val = 0;
    my $f       = 0; # numerator of a fraction whose denominator is $2^{16}$
    my $cur_val_level = -1;

    my $arith_error = false;
    my $cur_order   = normal;
    my $sign        = false;

    if (! $shortcut) {
        $sign = $tex->scan_optional_signs(); # expands tokens

        my $cur_tok = $tex->peek_next_token();
        my $cur_cmd = $tex->get_meaning($cur_tok);

        if (eval { $cur_cmd->isa("TeX::Command::Executable::Readable") }) {
            if ($mu) {
                ($cur_val, $cur_val_level) = $tex->scan_something_internal(mu_val, false);

                if ($cur_val->isa("TeX::Type::GlueSpec")) {
                    $cur_val = $cur_val->get_width();
                }

                if ($cur_val_level == mu_val) {
                    goto attach_sign;
                }

                if ($cur_val_level != int_val) {
                    $tex->mu_error();
                }
            } else {
                ($cur_val, $cur_val_level) = $tex->scan_something_internal(dimen_val, false);

                if ($cur_val_level == dimen_val) {
                    goto attach_sign;
                }
            }
        } else {
            my $radix = 0;

            if ($cur_tok == continental_point_token) {
                $cur_tok = point_token;
            }

            if ($cur_tok == point_token) {
                $radix   = 10;
                $cur_val = 0;
            } else {
                ($cur_val, $radix) = $tex->scan_int();
            }

            $cur_tok = $tex->peek_next_token();

            if ($cur_tok == continental_point_token) {
                $cur_tok = point_token;
            }

            if ($radix == 10 && $cur_tok == point_token) {
                $f = $tex->scan_decimal_fraction();
            }
        }
    }

    if ($cur_val < 0) { # in this case $f == 0
        $sign = ! $sign;

        $cur_val = -$cur_val;  # Because we're going to negate later.  Or not.
    }

    if ($inf) {
        if ($tex->scan_keyword("fil")) {
            $cur_order = fil;

            while ($tex->scan_keyword("l")) {
                if ($cur_order == filll) {
                    $tex->print_err("Illegal unit of measure (");
                    $tex->print("replaced by filll)");
                    $tex->set_help("I dddon't go any higher than filll.");
                    $tex->error();
                } else {
                    $cur_order++;
                }
            }

            goto attach_fraction;
        }
    }

    {
        my $v = 0;

        my $next_tok = $tex->peek_next_non_blank_non_call_token();
        my $next_cmd = $tex->get_meaning($next_tok);

        if (eval { $next_cmd->isa("TeX::Command::Executable::Readable") }) {
            if ($mu) {
                ($v, $cur_val_level) = $tex->scan_something_internal(mu_val, false);

                if ($cur_val_level >= glue_val) {
                    $v = $v->get_width();
                }

                if ($cur_val_level != mu_val) {
                    $tex->mu_error();
                }
            } else {
                $v = $tex->scan_something_internal(dimen_val, false);
            }

            goto found;
        }

        if ($mu) {
            goto not_found;
        }

        if ($tex->scan_keyword("em")) {
            $v = 10 * unity; #  (@<The em width for |cur_font|@>)
        } elsif ($tex->scan_keyword("ex")) {
            $v = 5 * unity; # (@<The x-height for |cur_font|@>)
        } else {
            goto not_found;
        }

        $tex->scan_optional_space();

      found:
        $cur_val = nx_plus_y($cur_val, $v, xn_over_d($v, $f, 0200000));

        goto attach_sign;
    }

  not_found:
    if ($mu) {
        if ($tex->scan_keyword("mu")) {
            goto attach_fraction;
        } else {
            $tex->print_err("Illegal unit of measure (");
            $tex->print("mu inserted)");

            $tex->set_help("The unit of measurement in math glue must be mu.",
                            "To recover gracefully from this error, it's best to",
                            "delete the erroneous units; e.g., type `2' to delete",
                            "two letters. (See Chapter 27 of The TeXbook.)");

            $tex->error();

            goto attach_fraction;
        }
    }

    if ($tex->scan_keyword("true")) {
        # @<Adjust \(f)for the magnification ratio@>;
    }

    if ($tex->scan_keyword("pt")) {
        goto attach_fraction; # the easy case
    }

    # @<Scan for \(a)all other units and adjust |cur_val| and |f| accordingly;
    #   |goto done| in the case of scaled points@>;

    {
        my $num;
        my $den;

        if    ($tex->scan_keyword("in")) { $num =  7227; $den =  100; }
        elsif ($tex->scan_keyword("pc")) { $num =    12; $den =    1; }
        elsif ($tex->scan_keyword("cm")) { $num =  7227; $den =  254; }
        elsif ($tex->scan_keyword("mm")) { $num =  7227; $den = 2540; }
        elsif ($tex->scan_keyword("bp")) { $num =  7227; $den = 7200; }
        elsif ($tex->scan_keyword("dd")) { $num =  1238; $den = 1157; }
        elsif ($tex->scan_keyword("nd")) { $num =   685; $den =  642; } #pdfTeX
        elsif ($tex->scan_keyword("cc")) { $num = 14856; $den = 1157; }
        elsif ($tex->scan_keyword("nc")) { $num =  1370; $den =  107; } #pdfTeX
        elsif ($tex->scan_keyword("sp")) { goto done }

        if (defined $num) {
            use integer;

            ($cur_val, my $remainder) = xn_over_d($cur_val, $num, $den);

            $f = ($num * $f + 0200000 * $remainder) / $den;

            $cur_val = $cur_val + ($f / 0200000);

            $f = $f % 0200000;
        } else {
            $tex->print_err("Illegal unit of measure (");
            $tex->print("pt inserted)");

            $tex->set_help("Dimensions can be in units of em, ex, in, pt, pc,",
                            "cm, mm, dd, nd, cc, nc, bp, or sp; but yours is a new one!",
                            "I'll assume that you meant to say pt, for printer's points.",
                            "To recover gracefully from this error, it's best to",
                            "delete the erroneous units; e.g., type `2' to delete",
                            "two letters. (See Chapter 27 of The TeXbook.)");

            $tex->error();

            # goto done2;
        }
    }

  attach_fraction:
    if ($cur_val >= 040000) {
        $arith_error = true;
    } else {
        $cur_val = $cur_val * unity + $f;
    }

  done:
    $tex->scan_optional_space();

  attach_sign:
    if ($arith_error || abs($cur_val) >= 010000000000) {
        $tex->print_err("Dimension too large");

        $tex->set_help("I can't work with sizes bigger than about 19 feet.",
                        "Continue and I'll use the largest value I can.");

        $tex->error();

        $cur_val = max_dimen;

        # $arith_error = false;
    }

    $cur_val *= $sign;

    return wantarray ? ($cur_val, $cur_order) : $cur_val;
}

sub scan_decimal_fraction {
    my $tex = shift;

    my @digits;

    $tex->get_next(); # {|point_token| is being re-scanned}

    while (my $token = $tex->get_x_token()) {
        if ($tex->is_digit($token)) {
            push @digits, $token->get_char();

            next;
        }

        $tex->back_input($token) unless $tex->is_space_token($token);

        last;
    }

    return round_decimals(@digits);
}

sub scan_normal_dimen {
    my $tex = shift;

    return $tex->scan_dimen(0, 0, 0);
}

sub scan_glue {
    my $tex = shift;

    my $level = shift;

    my $mu = $level == mu_val;

    my $sign = $tex->scan_optional_signs();

    my $next_tok = $tex->peek_next_token();
    my $next_cmd = $tex->get_meaning($next_tok);

    my $cur_val;
    my $cur_val_level;

    if (eval { $next_cmd->isa("TeX::Command::Executable::Readable") }) {
        ($cur_val, $cur_val_level) = $tex->scan_something_internal($level, $sign == -1);

        if ($cur_val_level >= glue_val) {
            if ($cur_val_level != $level) {
                $tex->mu_error();
            }

            return $cur_val;
        }

        if ($cur_val_level == int_val) {
            $tex->print_err("Can't convert an integer to glue yet.");
            $tex->error();
            ## $cur_val = $tex->scan_dimen($mu, false, true);
        } elsif ($level == mu_val) {
            $tex->mu_error();
        }
    } else {
        $cur_val = $tex->scan_dimen($mu, false, false);

        $cur_val *= $sign;
    }

    $cur_val = TeX::Type::GlueSpec->new( { width => $cur_val });

    if ($tex->scan_keyword("plus")) {
        my ($stretch, $stretch_order) = $tex->scan_dimen($mu, true, false);

        $cur_val->set_stretch($stretch);
        $cur_val->set_stretch_order($stretch_order);
    }

    if ($tex->scan_keyword("minus")) {
        my ($shrink, $shrink_order) = $tex->scan_dimen($mu, true, false);

        $cur_val->set_shrink($shrink);
        $cur_val->set_shrink_order($shrink_order);
    }

    return $cur_val;
}

sub missing_number_error {
    my $tex = shift;

    my $cur_tok = shift;

    $tex->print_err("Missing number, treated as zero");

    $tex->set_help("A number should have been here; I inserted `0'.",
                   "(If you can't figure out why I needed to see a number,",
                   "look up `weird error' in the index to The TeXbook.)");

    $tex->back_error($cur_tok);

   return;
}

sub get_maybe_expanded_token {
    my $tex = shift;

    my $expanded = shift;

    if ($expanded) {
        return $tex->get_x_token();
    }

    return $tex->get_next();
}

##  Assumes the { has already been consumed.  Leaves the closing } to
##  be read again.

sub read_balanced_text {
    my $tex = shift;

    my $macro_def = shift;
    my $expand    = shift;

    my @balanced;

    my $level = 0;

    while (my $token = $tex->get_maybe_expanded_token($expand)) {
        if ($token == CATCODE_END_GROUP) {
            if ($level == 0) {
                $tex->back_input($token);

                last;
            }

            $level--;
        } elsif ($token == CATCODE_BEGIN_GROUP) {
            $level++;
        }

        if ($token == CATCODE_PARAMETER && $macro_def) {
            my $next = $tex->get_next();

            if (! defined($next)) {
                croak "End of input while reading balanced text";
            }

            if ($next == CATCODE_PARAMETER) {
                push @balanced, $next;
            } elsif ($next == CATCODE_OTHER && $next =~ /[1-9]/) {
                push @balanced, make_param_ref_token($next->get_datum());
            } else {
                $tex->print_err("You can't use the macro parameter $token before $next");
                $tex->error();
            }

            next;
        }

        push @balanced, $token;
    }

    return TeX::TokenList->new({ tokens => \@balanced });
}

sub read_parameter_text {
    my $tex = shift;

    my @parameter_text;

    my $max_arg = 0;

    while (my $token = $tex->get_next()) {
        last if $token == CATCODE_BEGIN_GROUP;

        if ($token == CATCODE_END_GROUP) {
            $tex->print_err("Illegal end of group $token in parameter text ",
                             "on line ",
                             $tex->input_line_no(),
                             " of ",
                             $tex->get_file_name());

            $tex->error();
        }

        if ($token == CATCODE_PARAMETER) {
            my $next_token = $tex->get_next();

            if (! defined($next_token)) {
                $tex->fatal_error("End of input while reading parameter text");
            }

            if ($next_token == CATCODE_BEGIN_GROUP) {
                push @parameter_text, $next_token;

                last;
            }

            my $char = $next_token->get_char();

            if ($next_token == CATCODE_OTHER && $max_arg == 9) {
                $tex->print_err("You already have nine parameters");

                $tex->set_help("I'm going to ignore the # sign you just used.");

                $tex->error();
            } elsif ($next_token == CATCODE_OTHER && $char == ++$max_arg) {
                push @parameter_text, make_param_ref_token($char);
            } else {
                $tex->print_err("Parameters must be numbered consecutively");

                $tex->set_help("I've inserted the digit you should have used after the #.",
                               "Type `1' to delete what you did use.");

                $tex->back_error($next_token);
            }

            next;
        }

        push @parameter_text, $token;
    }

    return TeX::TokenList->new({ tokens => \@parameter_text });
}

sub require_token {
    my $tex = shift;

    my $token = shift;

    my $next = $tex->get_next();

    return unless defined $next;

    return 1 if $token == $next;

    # $tex->fatal_error("Expected '$token' while scanning parameter text but found '$next'\n");

    $tex->back_input($next);

    return;
}

sub read_undelimited_parameter {
    my $tex = shift;

    my $expanded = shift;

    my $token = $tex->get_next();

    if (! defined($token)) {
        croak "End of input while reading undelimited parameter";
    }

    while ($token == CATCODE_SPACE) {
        $token = $tex->get_next();
    }

    if (! defined($token)) {
        croak "End of input while reading undelimited parameter";
    }

    my $token_list = new_token_list();

    if ($token == CATCODE_BEGIN_GROUP) {
        $token_list = $tex->read_balanced_text(false, $expanded);

        $tex->get_next();
    } else {
        $token_list->push($token);
    }

    return $token_list;
}

sub premature_end_error {
    my $tex = shift;

    $tex->print_err("File ended while scanning macro argument");

    $tex->set_help("I suspect you have forgotten a `}', causing me",
                   "to read past where you wanted me to stop.",
                   "I'll try to recover; but if the error is serious,",
                   "you'd better type `E' or `X' now and fix your file.");

    $tex->error();

    return;
}

sub scan_rule_spec {
    my $tex = shift;

    my $rule = new_rule();

    my $default_rule = 26214; # {0.4\thinspace pt}

    if ($tex->is_vmode()) {
        $rule->set_height($default_rule);
        $rule->set_depth(0);
    } else {
        $rule->set_width($default_rule);
    }

    while (1) {
        if ($tex->scan_keyword("width")) {
            $rule->set_width(scalar $tex->scan_normal_dimen());

            next;
        }

        if ($tex->scan_keyword("height")) {
            $rule->set_height(scalar $tex->scan_normal_dimen());

            next;
        }

        if ($tex->scan_keyword("depth")) {
            $rule->set_depth(scalar $tex->scan_normal_dimen());

            next;
        }

        last;
    }

    return $rule;
}

######################################################################
##                                                                  ##
##                    [27] BUILDING TOKEN LISTS                     ##
##                                                                  ##
######################################################################

my %read_file_of :ARRAY(:name<read_file> :type<InStateRecord>);
my %read_open_of :ARRAY(:name<read_open> :default_value<closed>);

my %long_state_of :COUNTER(:name<long_state> :default<long_call>);

sub str_toks {
    my $tex   = shift;
    my $string = shift;

    return unless defined $string;

    my @tokens;

    for my $char (split //, $string) {
        my $token = make_character_token($char,
                                         $char eq ' ' ? CATCODE_SPACE :
                                                        CATCODE_OTHER);

        push @tokens, $token;
    }

    return TeX::TokenList->new({ tokens => \@tokens });
}

sub openin {
    my $tex = shift;

    my $fileno    = shift;
    my $file_name = shift;

    ##* CHECK WEB2C

    # if ($file_name !~ m{\.}) {
    #     $file_name .= ".tex";
    # }

    my $path = $tex->find_file_path($file_name);

    if (defined $path) {
        if (my $fh = $tex->a_open_in($path)) {
            my $record = InStateRecord->new({ file_name => $path,
                                              file_handle => $fh,
                                              file_type   => openin_file,
                                            });

            $tex->set_read_file($fileno, $record);
            $tex->set_read_open($fileno, just_open);
        }
    }

    return;
}

sub closein {
    my $tex = shift;

    my $fileno = shift;

    if ($tex->get_read_open($fileno) != closed) {
        my $input_record = $tex->get_read_file($fileno);

        my $fh = $input_record->get_file_handle();

        close($fh);

        # $tex->set_read_file($fileno, undef);
        $tex->set_read_open($fileno, closed);
    }

    return;
}

sub the_toks {
    my $tex = shift;

    my $cur_tok = shift;

    my $token = $tex->get_x_token();

    if (defined(my $meaning = $tex->get_meaning($token))) {
        if (eval { $meaning->isa("TeX::Command::Executable::Readable") }) {
            my $level = $meaning->get_level();

            my $value = $meaning->read_value($tex, $cur_tok);

            if ($level == int_val) {
                ## FALL THROUGH
            }
            elsif ($level == dimen_val) {
                $value = sprint_scaled($value) . "pt";
            }
            elsif ($level == glue_val) {
                $value = sprint_spec($value, "pt");
            }
            elsif ($level == mu_val) {
                $value = sprint_spec($value, "mu");
            }
            # elsif ($level == ident_val) {
            # }
            elsif ($level == tok_val) {
                return TeX::TokenList->new({ tokens => $value });
            }
            elsif ($level == xml_tag_val) {
                ## FALL THROUGH
            }
            else {
                $tex->print_err("Unknown or unimplemented scan_type in \\the: $level");
                $tex->error();
            }

            return $tex->str_toks($value);
        } else {
            $tex->print_err("You can't use `$token' after \\the");
            $tex->error();
        }
    } else {
        $tex->print_err("Undefined csname: ", $token->get_datum());
        $tex->error();
    }

    ## never get here
}

sub conv_toks {
    my $tex = shift;

    my $string = shift;

    $tex->ins_list($tex->str_toks($string));

    return;
}

sub scan_toks {
    my $tex = shift;

    my $macro_def = shift;
    my $xpand     = shift;

    if ($macro_def) {
        $tex->set_scanner_status(defining);
    } else {
        $tex->set_scanner_status(absorbing);
    }

    if ($macro_def) {
        # We don't use scan_toks to read the parameter text.

        # @<Scan and build the parameter part of the macro definition@>
    } else {
        $tex->scan_left_brace(); # {remove the compulsory left brace}
    }

    my $token_list = new_token_list();

    my $unbalance = 1;

    my $cur_tok;

    while (1) {
        if ($xpand) {
            while (1) {
                $cur_tok = $tex->get_next();

               ## ????
                if (ident($cur_tok) == ident(FROZEN_DONT_EXPAND_TOKEN)) {
                    $cur_tok = $tex->get_next();

                    last;
                } else {
                    my $cur_cmd = $tex->get_expandable_meaning($cur_tok);

                    last unless defined $cur_cmd; # UNEXPANDABLE

                    if (eval { $cur_cmd->isa("TeX::Primitive::the") }) {
                        $token_list->push($tex->the_toks($cur_tok));
                    } else {
                        $cur_cmd->expand($tex, $cur_tok);
                    }
                }
            }
        } else {
            $cur_tok = $tex->get_next();
        }

        if ($cur_tok == CATCODE_BEGIN_GROUP) {
            $unbalance++;
        } elsif ($cur_tok == CATCODE_END_GROUP) {
            $unbalance--;

            last if $unbalance == 0;
        } elsif ($macro_def && $cur_tok == CATCODE_PARAMETER) {
            my $next = $xpand ? $tex->get_x_token() : $tex->get_next();

            if ($next == CATCODE_PARAMETER) {
                $cur_tok = $next;
            }
            elsif ($next == CATCODE_OTHER && $next->get_char() =~ m/^[0-9]$/) {
                $cur_tok = make_param_ref_token($next->get_char());
            }
            else {
                $tex->print_err("Illegal parameter number in definition of ");
                $tex->print($cur_tok);

                $tex->set_help("You meant to type ## instead of #, right?",
                               "Or maybe a } was forgotten somewhere earlier, and things",
                               "are all screwed up? I'm going to assume that you meant ##.");

                $tex->back_error($next);
            }
        }

        $token_list->push($cur_tok);
    }

    $tex->set_scanner_status(normal);

    return $token_list;
}

sub read_toks {
    my $tex = shift;

    my $fileno  = shift;
    my $cur_tok = shift;

    $tex->set_scanner_status(defining);
    # $tex->set_warning_index($cur_tok);

    my $m = $fileno;

    if ( $fileno < 0 || $fileno > 15 ) {
        $m = 16;
    }

    my $saved_align = $tex->align_state();

    $tex->set_align_state(ALIGN_NO_COLUMN); # {disable tab marks, etc.}

    my $token_list = new_token_list();

    do {
        $tex->begin_file_reading();

        if ($tex->get_read_open($m) == closed) {
            # @<Input for \.{\\read} from the terminal@>

            if ($tex->get_interaction_mode() > nonstop_mode) {
                if ($fileno < 0) {
                    $tex->prompt_input("");
                } else {
                    $tex->wake_up_terminal();
                    $tex->print_ln();
                    $tex->print($cur_tok);
                    $tex->prompt_input("=");
                    $fileno = -1;
                }
            } else {
                $tex->fatal_error("*** (cannot \\read from terminal in nonstop modes)");
            }
        } else {
            my $in_record = $tex->get_read_file($fileno);

            $tex->set_input_line_no($in_record->line_no());
            $tex->set_input_char_no($in_record->char_no());
            $tex->set_file_name($in_record->get_file_name());
            $tex->set_cur_file($in_record->get_file_handle());
            $tex->set_file_type($in_record->file_type());

            my $fh = $tex->get_cur_file();

            if ($tex->get_read_open($m) == just_open) {
                # @<Input the first line of |read_file[m]|@>

                if ($tex->input_ln($fh)) {
                    $tex->set_read_open($m, normal);
                } else {
                    $tex->closein($fh);
                    $tex->set_read_open($m, closed);
                }
            } else {
                # @<Input the next line of |read_file[m]|@>;

                if (! $tex->input_ln($fh)) {
                    $tex->closein($m);
                    $tex->set_read_open($m, closed);

                    if ($tex->align_state() != ALIGN_NO_COLUMN) {
                        $tex->runaway();

                        $tex->print_err("File ended within ");
                        $tex->print_esc("read");

                        $tex->set_help("This \\read has unbalanced braces.");

                        $tex->set_align_state(ALIGN_NO_COLUMN);

                        $tex->error();
                    }
                }
            }
        }

        if (! $tex->end_line_char_inactive()) {
            $tex->push_char(chr($tex->end_line_char));
        }

        $tex->set_lexer_state(new_line);

        while (my $token = $tex->get_next()) {
            $token_list->push($token);

            if ($tex->align_state() < ALIGN_NO_COLUMN) {
                # {unmatched `\.\}' aborts the line}

                $tex->delete_chars();

                $tex->set_align_state(ALIGN_NO_COLUMN);

                last;
            }
        }

        $tex->end_file_reading();
    } until $tex->align_state() == ALIGN_NO_COLUMN;

    $tex->set_scanner_status(normal);
    $tex->set_align_state($saved_align);

    return $token_list;
}

sub do_end {
    my $tex = shift;

    $tex->back_input(END_TEX_TOKEN);

    return;
}

sub tokenize {
    my $tex = shift;

    my $string = shift;

    $tex->begin_string_reading($string);

    my $token_list = new_token_list();

    while (my $token = $tex->get_next()) {
        last if ident($token) == ident(END_TEX_TOKEN);

        $token_list->push($token);
    }

    return $token_list;
}

######################################################################
##                                                                  ##
##                   [28] CONDITIONAL PROCESSING                    ##
##                                                                  ##
######################################################################

my %cond_ptr_of   :ATTR(:name<cond_ptr> :type<CondStateRecord>);
my %if_limit_of   :COUNTER(:name<if_limit>  :default<normal>);
my %if_line_of    :COUNTER(:name<if_line>   :default<0>);
my %skip_line_of  :COUNTER(:name<skip_line> :default<0>);

{
    package CondStateRecord;

    use TeX::Class;

    my %if_limit_of   :COUNTER(:name<if_limit>);
    my %if_line_of    :COUNTER(:name<if_line>);

    my %link_of       :ATTR(:name<link> :type<CondStateRecord>);
}

sub pass_text {
    my $tex = shift;

    my $save_scanner_status = $tex->scanner_status();

    $tex->set_scanner_status(skipping);

    $tex->set_skip_line($tex->input_line_no());

    my $level = 0;

    while (my $next_token = $tex->get_next()) {
        my $cur_cmd = $tex->get_meaning($next_token);

        if (eval { $cur_cmd->isa("TeX::Primitive::Fi") }) {
            if ($level == 0) {
                $tex->set_scanner_status($save_scanner_status);

                return $cur_cmd;
            }

            if (eval { $cur_cmd->isa("TeX::Primitive::fi") }) {
                $level--;
            }
        } else {
            if (eval { $cur_cmd->isa("TeX::Primitive::If") }) {
                $level++;
            }
        }
    }

    $tex->confusion("fi");

    return;
}

sub push_cond_stack {
    my $tex = shift;

    my $cur_if = shift;

    my $p = CondStateRecord->new({ if_limit => $tex->if_limit(),
                                   if_line  => $tex->if_line(),
                                   link     => $tex->get_cond_ptr(),
                                 });

    $tex->set_cond_ptr($p);

    $tex->set_if_limit(if_code);
    $tex->set_if_line($tex->input_line_no());

    return;
}

sub pop_cond_stack {
    my $tex = shift;

    my $p = $tex->get_cond_ptr();

    $tex->set_if_limit($p->if_limit());
    $tex->set_if_line($p->if_line());

    $tex->set_cond_ptr($p->get_link());

    return;
}

sub change_if_limit {
    my $tex = shift;

    my $l = shift; # new if_level
    my $p = shift; # cond_ptr index

    my $q = $tex->get_cond_ptr();

    if ($p == $q) {
        $tex->set_if_limit($l); # {that's the easy case}
    } else {
        while (1) {
            if (! defined $q) {
                $tex->confusion("if");
            }

            if ($q->get_link() == $p) {
                $q->set_if_limit($l);

                return;
            }

            $q = $q->get_link();
        }
    }

    return;
}

sub conditional {
    my $tex = shift;

    my $bool = shift;

    my $save_cond_ptr = $tex->get_cond_ptr();

    if ($tex->tracing_commands() > 1) {
        $tex->begin_diagnostic();

        if ($bool) {
            $tex->print("{true}");
        } else {
            $tex->print("{false}");
        }

        $tex->end_diagnostic(false);
    }

    # Done in subclasses:
    # @<Either process \ifcase or set b to the value of a boolean condition>;

    if ($bool) {
        $tex->change_if_limit(else_code, $save_cond_ptr);

        return;
    }

    my $cur_cmd;

    while (1) {
        $cur_cmd = $tex->pass_text();

        if ($tex->get_cond_ptr() == $save_cond_ptr) {
            if (! eval { $cur_cmd->isa("TeX::Primitive::or") }) {
                last;
            }

            $tex->print_err("Extra ");
            $tex->print_esc("or");

            $tex->set_help("I'm ignoring this; it doesn't match any \\if.");

            $tex->error();
        } elsif (eval { $cur_cmd->isa("TeX::Primitive::fi") }) {
            $tex->pop_cond_stack();
        }
    }

    if (eval { $cur_cmd->isa("TeX::Primitive::fi") }) {
        $tex->pop_cond_stack();
    } else {
        $tex->set_if_limit(fi_code); # {wait for \fi}
    }

    return;
}

sub get_x_token_or_active_char( $ ) {
    my $tex = shift;

    my $token = $tex->get_x_token();

    ## FIXME

    my $meaning = $tex->get_meaning($token);

    if (eval { $meaning->isa("TeX::Token") }) {
        $token = $meaning;
    }

    return $token;
}

sub scan_comparison_operator {
    my $tex = shift;

    my $cur_tok = shift;

    my $op_token = $tex->get_next_non_blank_non_call_token();

    if ($op_token->get_catcode() == CATCODE_OTHER) {
        my $op = $op_token->get_char();

        if ( $op eq '<' || $op eq '=' || $op eq '>' ) {
            return $op;
        }
    }

    $tex->print_err("Missing = inserted for $cur_tok");

    $tex->set_help("I was expecting to see `<', `=', or `>'. Didn't.");

    return '=';
}

sub end_conditional {
    my $tex = shift;

    my $cur_tok = shift;
    my $cur_cmd = shift;

    if ($cur_cmd->fi_code() > $tex->if_limit()) {
        if ($tex->if_limit() == if_code) {
            $tex->insert_relax($cur_tok); # {condition not yet evaluated}
        } else {
            $tex->print_err("Extra ");
            $tex->print_cmd_chr($cur_cmd);

            $tex->set_help("I'm ignoring this; it doesn't match any \\if.");

            $tex->error();
        }
    } else {
        while (! eval { $cur_cmd->isa("TeX::Primitive::fi") }) {
            $cur_cmd = $tex->pass_text(); # {skip to \.{\\fi}}
        }

        $tex->pop_cond_stack();
    }

    return;
}

sub do_conditional_comparison {
    my $tex = shift;

    my $cur_tok = shift;

    my $val_a = shift;
    my $op    = shift;
    my $val_b = shift;

    my $bool;

    if ($op eq '<') {
        $bool = $val_a < $val_b;
    } elsif ($op eq '=') {
        $bool = $val_a == $val_b;
    } elsif ($op eq '>') {
        $bool = $val_a > $val_b;
    } else {
        $tex->confusion("op = '$op'");
    }

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->print("$val_a $op $val_b => ", $bool ? 'TRUE' : 'FALSE');

        $tex->end_diagnostic(true);
    }

    return $bool;
}

######################################################################
##                                                                  ##
##                         [29] FILE NAMES                          ##
##                                                                  ##
######################################################################

my %job_name_of :ATTR(:name<job_name> :default<"">);

my %output_stack_of :ARRAY(:name<output_stack>);

my %output_handle_of :ATTR(:name<output_handle>); # replaces dvi_file

my %output_module_of :ATTR(:name<output_module> :get<*custom*> :default<"TeX::Output::XML">);

my %output_file_name_of :ATTR(:name<output_file_name>);
my %output_ext_of  :ATTR(:name<output_ext> :default<"xml">);

my %log_name_of :ATTR(:name<log_name>);
my %log_ext_of  :ATTR(:name<log_ext> :default<"log">);

my %xml_public_id_of :ATTR(:name<xml_public_id> :default<"-//W3C//DTD XHTML 1.0 Strict//EN">);
my %xml_system_id_of :ATTR(:name<xml_system_id> :default<"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">);

my %xml_doc_root_of :ATTR(:name<xml_doc_root> :default<"article">);

my %xsl_file_of :ATTR(:name<xsl_file>);

my %initialized_of :BOOLEAN(:name<initialized> :default<false>);

my %use_mathjax_of :BOOLEAN(:name<use_mathjax> :default<false>);

{
    package OutputRecord;

    use TeX::Class;

    my %handle_of    :ATTR(:name<handle>);
    my %module_of    :ATTR(:name<module>);
    my %file_name_of :ATTR(:name<file_name>);
    my %ext_of       :ATTR(:name<ext>);

    sub to_string :STRINGIFY {
        my $self = shift;

        return sprintf("handle = %s; module = %s; file_name = %s; ext = %s",
                       $self->get_handle() || '<undef>',
                       $self->get_module() || '<undef>',
                       $self->get_file_name() || '<undef>',
                       $self->get_ext() || '<undef>');
    }
}

sub load_output_module {
    my $tex = shift;

    my $class = shift;

    if (! eval "require $class") {
        die "Could not load output class '$class': $@\n";
    }

    return;
}

sub get_output_module {
    my $tex = shift;

    my $class = $output_module_of{ident $tex};

    $class = "TeX::Output::XML" if empty($class);

    $tex->load_output_module($class);

    return $class;
}

## output_opened() and ensure_output_open() replace dvi_opened() and
## ensure_dvi_open().

sub output_opened {
    my $tex = shift;

    return defined $tex->get_output_handle();
}

sub ensure_output_open {
    my $tex = shift;

    return if $tex->output_opened();

    if (! $tex->log_opened()) {
        $tex->open_log_file();
    }

    my $job_name = $tex->get_job_name();

    my $ext = $tex->get_output_ext();

    my $output_file_name = "$job_name.$ext";

    if ($tex->nofiles()) {
        $output_file_name = DEV_NULL;
    }

    $tex->set_output_file_name($output_file_name);

    my $output_module = $tex->get_output_module();

    my $handle = $output_module->new({ tex_engine => $tex });

    eval { $handle->open_document() };

    ## Might want to do something more elaborate here.  Otherwise,
    ## delete the following

    if ($@) { die $@ };

    $tex->set_output_handle($handle);

    return;
}

sub log_opened {
    my $tex = shift;

    return defined $tex->get_log_file();
}

sub open_log_file {
    my $tex = shift;

    my $prev_selector = $tex->selector();

    my $log_name;

    if ($tex->nofiles()) {
        $log_name = DEV_NULL;
    } else {
        my $job_name = $tex->get_job_name();

        if (empty($job_name)) {
            $tex->set_job_name($job_name = "texput");
        }

        my $ext = $tex->get_log_ext();

        $log_name = "$job_name.$ext";
    }

    ## NEEDS IMPROVEMENT

    my $fh = $tex->a_open_out($log_name) or do {
        die "Can't open log file $log_name: $!\n";

        # @<Try to get a different log file name@>;
    };

    $tex->set_log_name($log_name);
    $tex->set_log_file($fh);

    $tex->set_selector(log_only);

    $tex->print_banner();

    ##* input_stack[input_ptr] := cur_input; {make sure bottom level is in memory}

    $tex->print_nl("**");

    ##* l := input_stack[0].limit_field; {last position of first line}

    ##* if buffer[l] = end_line_char then decr(l);

    ##* for k := 1 to l do print(buffer[k]);

    $tex->print_ln();

    $tex->set_selector($prev_selector + 2); # |log_only| or |term_and_log|

    return;
}

sub print_banner {
    my $tex = shift;

    $tex->wlog(BANNER);

    # $tex->slow_print($tex->format_ident());

    $tex->print("  ");

    my $time = localtime();

    $tex->print($time);

    return;
}

sub more_name {
    my $tex = shift;

    my $token = shift;

    return if $token > CATCODE_OTHER;

    return if $token->get_char() eq " ";

    return 1;
}

sub scan_file_name {
    my $tex = shift;

    my $token = $tex->get_next_non_blank_non_call_token();

    my $file_name;

    while ($tex->more_name($token)) {
        $file_name .= $token->get_char();

        $token = $tex->get_x_token();
    }

    if ($token->get_catcode() != CATCODE_SPACE) {
        $tex->back_input($token);
    }

    return $file_name;
}

sub prompt_file_name {
    my $tex = shift;

    my $s = shift;
    my $ext = shift;

    my $prev_filename = shift;

    if ($tex->get_interaction_mode() == scroll_mode) {
        $tex->wake_up_terminal();
    }

    if ($s eq "input file name") {
        $tex->print_err("I can't find file `");
    } else {
        $tex->print_err("I can't write on file `");
    }

    $tex->slow_print($prev_filename);
    $tex->print("'.");

    if ($ext eq ".tex") {
        $tex->show_context();
    }

    $tex->print_nl("Please type another ");
    $tex->print($s);

    if ($tex->get_interaction_mode() < scroll_mode) {
        $tex->fatal_error("*** (job aborted, file error in nonstop mode)");
    }

    $tex->clear_terminal();
    $tex->prompt_input(": ");

    my $file_name;

    my $char = $tex->shift_char();

    while ($char eq ' ' && defined($char = $tex->shift_char())) {}

    while (defined($char) && $char ne ' ') {
        $file_name .= $char;

        $char = $tex->shift_char();
    }

    $file_name .= $ext unless $file_name =~ m{\..* \z}smx;

    return $file_name;
}

sub find_file_path {
    my $tex = shift;

    my $file_name = shift;

    return $file_name if -e $file_name;

    my $path = kpse_lookup($file_name);

    if (empty($path)) {
        $path = kpse_lookup("$file_name.tex");
    }

    if (empty($path)) {
        my $dir = dirname($tex->get_job_name());

        for my $f ($file_name, "$file_name.tex") {
            if (-e "$dir/$f") {
                $path = "$dir/$f";

                last;
            }
        }
    }

    return $path;
}

sub start_input {
    my $tex = shift;

    my $file_spec = shift;
    my $fh        = shift;

    if (empty($file_spec)) {
        $file_spec = $tex->scan_file_name();

        undef $fh;  ## just in case
    }

    my $path;
    my $file_type;

    while (1) {
        $tex->begin_file_reading();

        if (defined $fh) {
            $path = $file_spec;

            $file_type = anonymous_file;

            last;
        } else {
            $path = $tex->find_file_path($file_spec);

            if (defined $path && ($fh = $tex->a_open_in($path))) {
                $file_type = input_file;

                last;
            }
        }

        $tex->end_file_reading();

        $file_spec = $tex->prompt_file_name("input file name", ".tex", $file_spec);
    }

    $tex->set_file_name($path);
    $tex->set_file_type($file_type);
    $tex->set_cur_file($fh);

    if (empty($tex->get_job_name()) && $file_type != anonymous_file) {
        my ($cur_name, $head, $cur_ext) = fileparse($path, qr/\.[^.]*$/);

        my $job_name = $cur_name;

        # if (nonempty($path) && $path ne "./") {
        #     $job_name = $path . $job_name;
        # }

        $tex->set_job_name($job_name);

        $tex->open_log_file();

        if ($tex->do_svg() && ! defined $tex->get_svg_agent()) {
            my $svg_agent = TeX::Utils::SVG->new({ base_file => $path,
                                                   interpreter => $tex,
                                                   debug => $tex->is_debugging(),
                                                   use_xetex => $tex->use_xetex(),
                                                 });

            $tex->set_svg_agent($svg_agent);
        }
    }

    if ( $tex->term_offset() + length($path) > $tex->max_print_line() - 2 ) {
        $tex->print_ln();
    } elsif ( $tex->term_offset() > 0 || $tex->file_offset() > 0 ) {
        $tex->print_char(" ");
    }

    $tex->print_char("(");
    $tex->incr_open_parens();
    $tex->slow_print($path);
    # $tex->print_char(" ");
    $tex->update_terminal();

    if (! $tex->is_initialized()) {
        $tex->INITIALIZE();
    }

    $tex->set_lexer_state(new_line);

    $tex->set_input_line_no(1);

    $tex->input_ln($fh);

    $tex->firm_up_the_line();

    if (! $tex->end_line_char_inactive()) {
        $tex->push_char(chr($tex->end_line_char));
    }

    return;
}

sub push_output {
    my $tex = shift;

    $tex->end_par();

    my $saved = OutputRecord->new({ handle    => $tex->get_output_handle(),
                                    module    => $tex->get_output_module(),
                                    file_name => $tex->get_output_file_name(),
                                    ext       => $tex->get_output_ext(),
                                  });

    $tex->push_output_stack($saved);

    my $output_module = shift || $tex->get_output_module();

    $tex->load_output_module($output_module);

    my $handle = $output_module->new({ tex_engine => $tex });

    eval { $handle->open_document() };

    ## Might want to do something more elaborate here.  Otherwise,
    ## delete the following

    if ($@) { die $@ };

    $tex->set_output_handle($handle);
    $tex->set_output_module($output_module);

    return;
}

sub pop_output {
    my $tex = shift;

    my $current = $tex->get_output_handle();

    if (defined $current) {
        $current->close_document();
    } else {
        $tex->fatal_error("No current output handle in pop_output!");
    }

    if (defined(my $top = $tex->pop_output_stack())) {
        $tex->set_output_handle($top->get_handle());
        $tex->set_output_module($top->get_module());
        $tex->set_output_file_name($top->get_file_name());
        $tex->set_output_ext($top->get_ext());
    }

    return $current;
}

######################################################################
##                                                                  ##
##                      [30] FONT METRIC DATA                       ##
##                                                                  ##
######################################################################

## See TeX::TFM::File

sub scan_font_ident {
    my $tex = shift;

    my $cur_tok = $tex->get_next_non_blank_non_call_token();

    my $cur_cmd = $tex->get_meaning($cur_tok);

    my $font;

    if (eval { $cur_cmd->isa("TeX::Primitive::font") }) {
        $font = $tex->get_cur_font();
    } elsif (eval { $cur_cmd->isa("TeX::Primitive::SetFont") }) {
        $font = $cur_cmd->get_font();
    } elsif (eval { $cur_cmd->isa("TeX::Primitive::DefFamily") }) {
        my $size = $cur_cmd->get_size();

        my $family_no = $tex->scan_four_bit_int();

        $font = $tex->get_math_font($size, $family_no);
    } else {
        $tex->print_err("Missing font identifier");

        $tex->set_help("I was looking for a control sequence whose",
                        "current meaning has been defined by \\font.");

        $tex->back_error($cur_tok);;

        # $font = null_font;
    }

    return $font;
}

######################################################################
##                                                                  ##
##               [31] DEVICE-INDEPENDENT FILE FORMAT                ##
##                                                                  ##
######################################################################

## See TeX::DVI::File

######################################################################
##                                                                  ##
##                     [32] SHIPPING PAGES OUT                      ##
##                                                                  ##
######################################################################

## hlist_out() and vlist_out() have been moved to the TeX::Output::XXX
## object.

sub ship_out {
    my $tex = shift;

    my $box = shift;

    if ($tex->tracing_output() > 0) {
        $tex->print_nl("");
        $tex->print_ln();
        $tex->print("Completed box being shipped out");
    }

    # if ($tex->term_offset() > $tex->max_print_line() - 9) {
    #     $tex->print_ln();
    # } elsif ($tex->term_offset() > 0 || $tex->file_offset() > 0) {
    #     $tex->print_char(" ");
    # }

    $tex->update_terminal();

    if ($tex->tracing_output() > 0) {
        $tex->begin_diagnostic();

        $tex->show_box($box);

        $tex->end_diagnostic(true)
    }

    $tex->ensure_output_open();

    my $fh = $tex->get_output_handle();

    if ($box->is_vbox()) {
        $fh->vlist_out($box);
    } else {
        $fh->hlist_out($box);
    }

    $tex->set_deadcycles(0);

    $tex->update_terminal();

    return;
}

## finish_output_file() replaces finish_dvi_file()

sub finish_output_file {
    my $tex = shift;

    my $fh = $tex->get_output_handle();

    return unless defined $fh;

    my $dom = $fh->close_document();

    if (nonempty(my $output_file_name = $tex->get_output_file_name())) {
        if ($output_file_name ne DEV_NULL) {
            my $state = $dom->toFile($output_file_name, 1) if defined $dom;
        }
    }

    $tex->delete_output_handle();

    return;
}

######################################################################
##                                                                  ##
##                          [33] PACKAGING                          ##
##                                                                  ##
######################################################################

my %last_badness_of :COUNTER(:name<last_badness> :default<0>);

sub scan_spec {
    my $tex = shift;

    my $group_code  = shift;
    my $three_codes = shift;

    if ($tex->tracing_groups() > 1) {
        $tex->show_save_stack("scan_spec: group_type = " . group_type($group_code) . "; three_codes = $three_codes");
    }

    my $saved_context;

    if ($three_codes) {
        $saved_context = $tex->pop_save_stack();
    }

    my $spec_code;
    my $cur_val;

    if ($tex->scan_keyword("to")) {
        $spec_code = exactly;
    } elsif ($tex->scan_keyword("spread")) {
        $spec_code = additional;
    } else {
        $spec_code = additional;

        $cur_val = 0;
    }

    if (! defined $cur_val) {
        $cur_val = $tex->scan_normal_dimen();
    }

    if ($three_codes) {
        $tex->push_save_stack($saved_context);
    }

    $tex->push_save_stack($spec_code);
    $tex->push_save_stack($cur_val);

    $tex->new_save_level($group_code);

    $tex->scan_left_brace();

    return;
}

sub hpack {
    my $tex = shift;

    my $node_list = shift;

    # my $width     = shift;
    # my $spec_code = shift;

    my $hbox = new_null_box();

    $hbox->push_node(@{ $node_list });

    return $hbox;
}

sub vpack {
    my $tex = shift;

    return $tex->vpackage(@_, max_dimen);
}

sub vpackage {
    my $tex = shift;

    my $node_list = shift;
    my $height    = shift;
    my $spec_code = shift;

    ## TBD: Shouldn't this be a VlistNode?

    my $vbox = new_null_vbox();

    $vbox->push_node(@{ $node_list });

    return $vbox;
}

######################################################################
##                                                                  ##
##                [34] DATA STRUCTURES FOR MATH MODE                ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                  [35] SUBROUTINES FOR MATH MODE                  ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                  [36] TYPESETTING MATH FORMULAS                  ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                          [37] ALIGNMENT                          ##
##                                                                  ##
######################################################################

my %align_stack_of   :ARRAY(:name<align_stack>  :type<Alignment>);
my %cur_alignment_of :ATTR(:name<cur_alignment> :type<Alignment>);

{
    package SpanRecord;

    use TeX::Class;

    ## Tag each SpanRecord with a unique id for use by
    ## update_span_records() and for debugging purposes (to_string).

    my $ID = 0;

    my %id_of :COUNTER(:name<id>);

    sub BUILD {
        my ($self, $obj_ID, $arg_ref) = @_;

        $self->set_id($ID++);

        return;
    }

    # state = 0 : This is a new span record.  Output colspan and
    #             rowspan attributes if needed.
    # state = 1 : This is an active span record.  Output hidden cell.
    # state = 2 : This record is defunct.  Replace it.

    my %state_of :COUNTER(:name<state>);

    my %num_rows_of :COUNTER(:name<num_rows>);
    my %num_cols_of :COUNTER(:name<num_cols>);

    my %top_row_of :COUNTER(:name<top_row>);

    my %span_cols_of :COUNTER(:name<span_cols>); # For \span

    sub is_new {
        my $self = shift;

        return $self->state() == 0;
    }

    sub is_exhausted {
        my $self = shift;

        return $self->state() == 2;
    }

    sub to_string :STRINGIFY {
        my $self = shift;

        my $id       = $self->id();
        my $state    = $self->state();
        my $num_rows = $self->num_rows();
        my $num_cols = $self->num_cols();

        return sprintf qq{SpanRecord[%2d](state = %d, rows = %d, cols = %d)}, $id, $state, $num_rows, $num_cols;
    }
}

{
    package Alignment;

    use TeX::Constants qw(:booleans);

    use TeX::Class;

    use TeX::Utils::Misc;

    my %cols_of :ARRAY(:name<col> :type<AlignRecord>);

    my %col_ptr_of  :COUNTER(:name<col_ptr>  :default<0>);
    my %loop_ptr_of :COUNTER(:name<loop_ptr> :default<-1>);

    my %span_records_of :ARRAY(:name<span_record>); # indexed by col_ptr

    my %top_row_of :ARRAY(:name<col_top_row> :get<*custom*> :set<*custom*>);

    sub START {
        my ($tex, $ident, $arg_ref) = @_;

        $top_row_of{$ident} = [ ];

        return;
    }

    sub top_row {
        my $self = shift;

        my $row = shift;
        my $col = shift;

        my $ident = ident $self;

        my $rows = $top_row_of{$ident};

        if (! defined $rows->[$row]) {
            $rows->[$row] = [];
        }

        if (! defined $rows->[$row]->[$col]) {
            $rows->[$row]->[$col] = $row;
        }

        return $rows->[$row]->[$col];
    }

    sub set_top_row {
        my $self = shift;

        my $row = shift;
        my $col = shift;

        my $top_row = shift;

        $self->top_row($row, $col);

        my $ident = ident $self;

        return $top_row_of{$ident}->[$row]->[$col] = $top_row;
    }

    sub cur_col {
        my $self = shift;

        my $ptr = $self->col_ptr();

        if ($ptr > -1) {
            return $self->get_col($ptr);
        }

        return;
    }

    sub new_span_record( $$ ) {
        my $num_rows = shift;
        my $num_cols = shift;

        return SpanRecord->new({ state    => 0,
                                 num_cols => $num_cols,
                                 num_rows => $num_rows,
                                 cur_col  => 1 });
    }

    sub cur_span_record {
        my $self = shift;

        my $ptr = $self->col_ptr();

        return new_span_record(0, 0) unless $ptr > -1; ## SHOULDN'T HAPPEN

        my $span_record = $self->get_span_record($ptr);

        if (! defined $span_record || $span_record->is_exhausted()) {
            $span_record = new_span_record(1, 1);

            $self->set_span_record($ptr, $span_record);
        }

        return $span_record;
    }

    sub init_span_record {
        my $self = shift;

        my $num_rows = shift;
        my $num_cols = shift;

        my $ptr = $self->col_ptr();

        ## TODO: Should throw an error if this appears to be
        ## overlapping an existing non-default span_record.

        my $span_record = $self->cur_span_record();

        $span_record->set_num_rows($num_rows);
        $span_record->set_num_cols($num_cols);
        $span_record->set_state(0);

        for (my $i = $ptr + 1; $i < $ptr + $num_cols; $i++) {
            $self->set_span_record($i, $span_record);
        }

        return;
    }

    sub update_span_records {
        my $self = shift;

        my $tex = shift;

        my @span_records = @{ $span_records_of{ident $self} };

        my @already_updated;

        for (my $col_ptr = 0; $col_ptr < @span_records; $col_ptr++) {
            my $span_record = $span_records[$col_ptr];

            next unless defined $span_record;

            next if $already_updated[$span_record->id()];

            if ($span_record->num_rows() == 1) {
                $span_record->set_state(2);
            } else {
                $span_record->set_state(1);

                $span_record->decr_num_rows();
            }

            $already_updated[$span_record->id()] = 1;
        }
    }

    sub next_col {
        my $self = shift;

        my $next_ptr = $self->col_ptr() + 1;

        my $next_col = $self->get_col($next_ptr);

        if (! defined $next_col) {
            if (defined(my $loop_ptr = $self->loop_ptr())) {
                $next_col = $self->get_col($loop_ptr);

                $self->push_col($next_col);

                $self->incr_loop_ptr();
            }
        }

        return $next_col;
    }

    sub debug_show {
        my $self = shift;

        my $tex = shift;

        my $context = shift || '<unknown>';

        $tex->begin_diagnostic();

        $tex->print_nl("# Alignment preamble ($context)");

        my $num_cols = $self->num_cols();

        for (my $i = 0; $i < $num_cols; $i++) {
            my $col = $self->get_col($i);

            $tex->print_nl("# col $i");
            $tex->print_nl("#     u = '");
            $tex->token_show($col->get_u_part());
            $tex->print("'");

            $tex->print_nl("#     v = '");
            $tex->token_show($col->get_v_part());
            $tex->print("'");
        }

        $tex->end_diagnostic(true);

        return;
    }

    my %row_css_properties_of :HASH(:name<row_property> :gethash<get_row_properties> :deletehash<delete_row_properties> :sethash<set_row_properties>);

    my %col_css_properties_of :ARRAY(:name<col_property> :getarray<get_col_properties> :deletearray<delete_col_properties>);

    sub set_column_property {
        my $self = shift;

        my $col_no   = shift;
        my $property = shift;
        my $value    = shift;

        next if empty($property);

        my $properties = $self->get_col_property($col_no);

        $properties ||= {};

        if (empty($value)) {
            delete $properties->{$property};
        } else {
            $properties->{$property} = $value;
        }

        $self->set_col_property($col_no, $properties);

        return;
    };
}

{
    package AlignRecord;

    use TeX::Class;

    my %u_part_of :ATTR(:name<u_part> :type<TeX::TokenList>);
    my %v_part_of :ATTR(:name<v_part> :type<TeX::TokenList>);

    # extra_info will hold either the first token of the column (as
    # set by init_col and checked by insert_v_template) or the token
    # that ends the column (set by insert_v_template and checked by
    # fin_col).

    my %extra_info_of :ATTR(:name<extra_info>);
}

sub push_alignment {
    my $tex = shift;

    if (defined(my $align = $tex->get_cur_alignment())) {
        $tex->push_align_stack($align);
    }

    return;
}

sub pop_alignment {
    my $tex = shift;

    my $prev_align = $tex->get_cur_alignment();

    if (defined(my $align = $tex->pop_align_stack())) {
        $tex->set_cur_alignment($align);
    }

    return $prev_align;
}

sub incr_alignspanno {
    my $tex = shift;

    $tex->set_alignspanno($tex->alignspanno() + 1);

    return;
}

sub incr_aligncolno {
    my $tex = shift;

    $tex->set_aligncolno($tex->aligncolno() + 1);

    return;
}

sub incr_alignrowno {
    my $tex = shift;

    $tex->set_alignrowno($tex->alignrowno() + 1);

    return;
}

sub init_align {
    my $tex = shift;

    my $cur_cmd = shift;

    $tex->push_alignment();

    $tex->set_align_state(ALIGN_PREAMBLE);

    $tex->check_for_improper_math_align();

    $tex->push_nest(); # {enter a new semantic level}

    {
        my $cur_mode = $tex->get_cur_mode();

        if ($cur_mode == mmode) {
            $tex->set_cur_mode(- vmode);
        } elsif ($cur_mode > 0) {
            $tex->set_cur_mode(-$cur_mode);
        }
    }

    $tex->scan_spec(align_group, false);

    my $align = $tex->scan_align_preamble();

    $tex->set_cur_alignment($align);

    $tex->new_save_level(align_group);

    $tex->set_alignrowno(0);

    $tex->begin_token_list($tex->get_toks_list('every_cr'), every_cr_text);

    $tex->align_peek($align); # look for \noalign or \omit and then init_row()

    return;
}

sub init_span_record {
    my $tex = shift;

    my $num_rows = shift;
    my $num_cols = shift;

    my $cur_align = $tex->get_cur_alignment();

    if (! defined $cur_align) {
        $tex->print_err("You can't use \\TeXMLrowspan outside of an alignment");

        $tex->set_help("Really, mate, you can't.");

        $tex->error();

        return;
    }

    $cur_align->init_span_record($num_rows, $num_cols);

    return;
}

sub check_for_improper_math_align {
    my $tex = shift;

    return;
}

sub get_preamble_token {
    my $tex = shift;

  restart:
    my $cur_tok = $tex->get_token();

    my $cur_cmd = $tex->get_meaning($cur_tok);

    while (eval { $cur_cmd->isa("TeX::Primitive::span") }) {
        $cur_tok = $tex->get_token(); # {this token will be expanded once}

        $cur_cmd = $tex->get_meaning($cur_tok);

        if (eval { $cur_cmd->isa('TeX::Command::Expandable') }) {
            $cur_cmd->expand($tex, $cur_tok);

            $cur_tok = $tex->get_token();
            $cur_cmd = $tex->get_meaning($cur_tok);
        }
    }

    if (ident($cur_tok) == ident(FROZEN_END_TEMPLATE_TOKEN)) {
        $tex->fatal_error("(interwoven alignment preambles are not allowed)");
    }

    if (eval { $cur_cmd->isa("TeX::Primitive::tabskip") }) {
        $cur_cmd->execute($tex, $cur_tok);

        goto restart;
    }

    return $cur_tok;
}

sub scan_align_preamble {
    my $tex = shift;

    my $cur_cmd; # left_brace

    my $align = Alignment->new();

    # cur_align := align_head;
    # cur_loop  := null;

    $tex->set_scanner_status(aligning);

    $tex->set_align_state(ALIGN_PREAMBLE);

    # {at this point, |cur_cmd = left_brace|}

    while (1) {
        last if eval { $cur_cmd->isa("TeX::Primitive::cr") };

        # @<Scan preamble text until |cur_cmd| is |tab_mark| or
        #   |car_ret|, looking for changes in the tabskip glue; append
        #   an alignrecord to the preamble list@>;

        my $cur_col = AlignRecord->new();

        $tex->scan_u_template($align, $cur_col);

        $cur_cmd = $tex->scan_v_template($align, $cur_col);

        $align->push_col($cur_col);
    }

    $tex->set_scanner_status(normal);

    return $align;
}

# Cf. ends_align_entry()

sub ends_align_template {
    my $tex = shift;

    my $cur_cmd = shift;

    return unless $tex->align_state() == ALIGN_PREAMBLE;

    return ($cur_cmd == CATCODE_ALIGNMENT
            || eval { $cur_cmd->isa("TeX::Primitive::cr") }
            || eval { $cur_cmd->isa("TeX::Primitive::span") });
}

sub scan_u_template {
    my $tex = shift;

    my $align  = shift;
    my $cur_col = shift;

    my $u = new_token_list();

    while (1) {
        my $cur_tok = $tex->get_preamble_token();

        my $cur_cmd = $tex->get_meaning($cur_tok);

        last if $cur_cmd == CATCODE_PARAMETER;

        if ($tex->ends_align_template($cur_cmd)) {
            if ($cur_cmd == CATCODE_ALIGNMENT && $u->length() == 0 && $align->loop_ptr() == -1) {
                $align->set_loop_ptr($align->num_cols());
            } else {
                $tex->print_err("Missing # inserted in alignment preamble");

                $tex->set_help("There should be exactly one # between &'s, when an",
                               "\\halign or \\valign is being set up. In this case you had",
                               "none, so I've put one in; maybe that will work.");

                $tex->back_error($cur_tok);

                last;
            }
        } elsif (! ($tex->is_space_token($cur_tok) && $u->length() == 0) ) {
            $u->push($cur_tok);
        }
    }

    $u->push(FROZEN_ENDU_TOKEN);

    $cur_col->set_u_part($u);

    return;
}

sub scan_v_template {
    my $tex = shift;

    my $align = shift;
    my $cur_col  = shift;

    my $v = new_token_list();

    my $cur_cmd;

    while (1) {
        my $cur_tok = $tex->get_preamble_token();

        $cur_cmd = $tex->get_meaning($cur_tok);;

        last if $tex->ends_align_template($cur_cmd);

        if ($cur_cmd == CATCODE_PARAMETER) {
            $tex->print_err("Only one # is allowed per tab");

            $tex->set_help("There should be exactly one # between &'s, when an",
                           "\\halign or \\valign is being set up. In this case you had",
                           "more than one, so I'm ignoring all but the first.");

            $tex->error();

            next;
        }

        $v->push($cur_tok);
    }

    $v->push(FROZEN_END_TEMPLATE_TOKEN);

    $cur_col->set_v_part($v);

    return $cur_cmd;
}

sub align_peek {
    my $tex = shift;

    my $align = shift;

  restart:
    $tex->set_align_state(ALIGN_NO_COLUMN);

    my $cur_tok = $tex->get_next_non_blank_non_call_token();

    my $cur_cmd = $tex->get_meaning($cur_tok);

    if (eval { $cur_cmd->isa("TeX::Primitive::noalign") }) {
        $tex->scan_left_brace();

        $tex->new_save_level(no_align_group);

        if ($tex->get_cur_mode() == - vmode) {
            $tex->normal_paragraph();
        }
    } elsif ($cur_cmd == CATCODE_END_GROUP) {
        $tex->fin_align($align);
    } elsif (eval { $cur_cmd->isa("TeX::Primitive::crcr") }) {
        goto restart; # {ignore \crcr}
    } else {
        $tex->init_row($align); # {start a new row}

        # {start a new column and replace what we peeked at}
        $tex->init_col($align, $cur_tok, $cur_cmd);
    }

    return;
}

sub init_row {
    my $tex = shift;

    my $align = shift;

    $tex->push_nest();

    my $mode = (- hmode - vmode) - $tex->get_cur_mode();

    $tex->set_cur_mode($mode);

    if ($mode == - hmode) {
        $tex->set_spacefactor(0);
    } else {
        # prev_depth := 0;
    }

    $align->set_col_ptr(0);

    $tex->incr_alignrowno();

    $tex->set_alignspanno(1);
    $tex->set_aligncolno(1);

    $tex->init_span($align);

    return;
}

sub init_span {
    my $tex = shift;

    my $align = shift;

    $tex->push_nest();

    if ($tex->is_hmode()) {
        $tex->set_spacefactor(1000);
    } else {
        # prev_depth := ignore_depth;

        $tex->normal_paragraph();
    }

    return;
}

sub init_col {
    my $tex = shift;

    my $align = shift;

    my $cur_tok = shift;
    my $cur_cmd = shift;

    my $cur_col = $align->cur_col();

    $cur_col->set_extra_info($cur_cmd);

    if (eval { $cur_cmd->isa("TeX::Primitive::omit") }) {
        $tex->set_align_state(ALIGN_COLUMN_BOUNDARY);
    } else {
        $tex->back_input($cur_tok);

        $tex->begin_token_list($cur_col->get_u_part(), u_template);

        # {now |align_state = ALIGN_NO_COLUMN|}
    }

    return;
}

sub insert_v_template {
    my $tex = shift;

    my $cur_tok = shift;

    my $align = $tex->get_cur_alignment();

    ##*???

    my $cur_col = defined $align ? $align->cur_col() : undef;

    if ( $tex->scanner_status() == aligning || ! defined $cur_col ) {
        $tex->fatal_error("(interwoven alignment preambles are not allowed)");
    }

    my $cur_cmd = $cur_col->get_extra_info();

    $cur_col->set_extra_info($tex->get_meaning($cur_tok));

    if (eval { $cur_cmd->isa("TeX::Primitive::omit") }) {
        $tex->begin_token_list(OMIT_TEMPLATE, v_template);
    } else {
        $tex->begin_token_list($cur_col->get_v_part(), v_template);
    }

    $tex->set_align_state(ALIGN_NO_COLUMN);

    return;
}

## These are needed (for now) to simplify colspan and rowspan
## calculations.  These cells will be removed by
## TeX::Output::XML::normalize_tables

sub __add_hidden_cell {
    my $tex = shift;

    my $top_row = shift;

    my $col_tag = $tex->xml_table_col_tag();

    my $hidden = new_null_box(new_xml_open_node($col_tag, { hidden => "hidden" }),
                              new_xml_close_node($col_tag));

    my $cur_align = $tex->get_cur_alignment();

    $cur_align->set_top_row($tex->alignrowno(), $tex->aligncolno(), $top_row);

    $tex->incr_aligncolno();

    return;
}

sub fin_col {
    my $tex = shift;

    my $align = $tex->get_cur_alignment(); # Alignment

    my $cur_col = defined $align ? $align->cur_col() : undef; # AlignRecord

    $tex->confusion("endv") unless defined $cur_col;

    if ($tex->align_state() < ALIGN_FLAG) {
        $tex->fatal_error("(interwoven alignment preambles are not allowed)");
    }

    my $next_cmd = $cur_col->get_extra_info();

    my $next_col = $align->next_col();

    if (! (defined($next_col) || $next_cmd->("TeX::Primitive::cr")) ) {
        $tex->print_err("Extra alignment tab has been changed to ");

        $tex->print_esc("cr");

        $tex->set_help("You have given more \\span or & marks than there were",
                       "in the preamble to the \\halign or \\valign now in progress.",
                       "So I'll assume that you meant to type \\cr instead.");

        $next_cmd = FROZEN_CR;

        $cur_col->set_extra_info($next_cmd);

        $tex->error();
    }

    my $span_record = $align->cur_span_record();

    if (eval { $next_cmd->isa("TeX::Primitive::span") }) {
        $span_record->incr_num_cols();

        $span_record->incr_span_cols();

        $align->set_span_record($align->col_ptr() + 1, $span_record);
    } else {
        $tex->unsave();

        $tex->new_save_level(align_group);

        my $head = $tex->pop_nest();

        ## Don't care about mode, so just use a HListNode.

        my $cur_cell = $tex->hpack($head, natural);

        my $col_tag = $tex->xml_table_col_tag();

        my $num_rows = $span_record->num_rows();
        my $num_cols = $span_record->num_cols();

        if ($span_record->is_new()) {
            $span_record->set_top_row($tex->alignrowno());

            if (nonempty($col_tag)) {
                my %atts;

                ## TBD: colspan=0 and rowspan=0 have special meanings
                ## in HTML (but might not be widely supported?) so
                ## maybe we need to support them.

                if ($num_rows > 0) {
                    if ($num_rows > 1) {
                        $atts{rowspan} = $num_rows;
                    }

                    if ($num_cols > 1) {
                        $atts{colspan} = $num_cols;
                    }
                }

                my $col_no = $tex->aligncolno();

                my $props = $align->get_col_property($col_no);

                $align->set_col_property($col_no, {});

                $cur_cell->unshift_node(new_xml_open_node($col_tag,
                                                          \%atts,
                                                          $props,
                                       ));

                $cur_cell->push_node(new_xml_close_node($col_tag));
            }

            $tex->tail_append($cur_cell);

            $tex->incr_aligncolno();

            for (1..$span_record->span_cols()) {
                if (nonempty($col_tag)) {
                    $tex->__add_hidden_cell($span_record->top_row());
                }
            }

            $span_record->set_state(1);
        } else {
            if (nonempty($col_tag)) {
                $tex->__add_hidden_cell($span_record->top_row());
            }

            if ($cur_cell->is_visible()) {
                my $row_no = $tex->alignrowno();
                my $col_no = $tex->aligncolno();

                $tex->print_err("Possible lost material in row $row_no, col $col_no: '$cur_cell'");

                $tex->set_help("We're in the middle of a row span here.");

                $tex->error();
            }
        }

        if (eval { $next_cmd->isa("TeX::Primitive::cr") }) {
            return true;
        }

        # $align->incr_col_ptr();

        $tex->init_span($align);

        $tex->incr_alignspanno();
    }

    $tex->set_align_state(ALIGN_NO_COLUMN);

    my $cur_tok = $tex->get_next_non_blank_non_call_token();
    my $cur_cmd = $tex->get_meaning($cur_tok);

    $align->incr_col_ptr();

    $tex->init_col($align, $cur_tok, $cur_cmd);

    return;
}

sub end_u_template {
    my $tex = shift;

    $tex->tail_append(new_end_u_template_node());

    return;
}

# padding-bottom can't be applied to <tr>, so it must be moved to
# enclosed <td>s

# background-color (set by colortbl's \rowcolor command) needs to move
# from the row to the end of the u template so that it overrides
# \columncolor but can be overriden by \cellcolor.

my @MOVABLE_CSS_PROPERTIES = qw(color background-color padding-bottom);

sub fin_row {
    my $tex = shift;

    my $align = $tex->get_cur_alignment();

    my %props = %{ $align->delete_row_properties() };

    my %movable;

    # cackle
    @movable{@MOVABLE_CSS_PROPERTIES} = delete @props{@MOVABLE_CSS_PROPERTIES};

    my @row;

    for my $cell ($tex->pop_nest()) {
        my @old = $cell->get_nodes();

        my @new;

        for my $node (@old) {
            if ($node->is_u_template_marker()) {
                while (my ($k, $v) = each %movable) {
                    if (nonempty($k) && nonempty($v)) {
                        push @new, new_css_property_node($k, $v);
                    }
                }

                next;
            }

            push @new, $node;
        }

        push @row, new_null_box(@new);
    }

    my $row_tag = $tex->xml_table_row_tag();

    unshift @row, new_xml_open_node($row_tag, undef, \%props);
    push    @row, new_xml_close_node($row_tag);

    my $cur_row = new_null_box(@row);

    $tex->tail_append($cur_row);

    if (! $tex->is_hmode()) {
        $tex->set_spacefactor(1000);
    }

    # Hmm
    $tex->begin_token_list($tex->get_toks_list('every_cr'), every_cr_text);

    $align->update_span_records($tex);

    $tex->align_peek($align);

    return;
}

my %FINAL_ROW_PROPERTY_SWAP = ('border-top'  => 'border-bottom',
                               'padding-top' => 'padding-bottom',
    );

sub fin_align {
    my $tex = shift;

    if ($tex->cur_group() != align_group) {
        $tex->confusion("align1");
    }

    $tex->unsave(); # {that |align_group| was for individual entries}

    if ($tex->cur_group() != align_group) {
        $tex->confusion("align0");
    }

    $tex->unsave(); # {that |align_group| was for the whole alignment}

    ## Pop the unused spec_code and height/width params from scan_spec()

    $tex->pop_save_stack();
    $tex->pop_save_stack();

    my $align = $tex->pop_alignment();

    # @<Insert the current list into its environment@>;

    ##*???

    if ($tex->is_mmode()) {
        $tex->finish_align_in_display();
    } else {
        my @rows = $tex->pop_nest();

        my $final_row = $rows[-1];

        ## TBD: This might not be an hlist: Check for things like \noalign{\smallskip}, etc.

        my $final_row_open = $final_row->get_node(0);

        if (defined(my $props = $align->delete_row_properties())) {
            while (my ($k, $v) = each %{ $props }) {
                $k = $FINAL_ROW_PROPERTY_SWAP{$k} || $k;

                $final_row_open->set_property($k, $v);
            }
        }

        my @col_properties = $align->get_col_properties();

        for (my $i = 1; $i < $final_row->num_nodes() - 1; $i++) {
            my $col_tag = $final_row->get_node($i)->get_node(0);

            if (defined(my $p = $col_properties[$i])) {
                while (my ($k, $v) = each %{ $p }) {
                    $k = $FINAL_ROW_PROPERTY_SWAP{$k} || $k;

                    $col_tag->set_property($k, $v);
                }
            }
        }

        if (nonempty(my $table_tag = $tex->xml_table_tag())) {
            unshift @rows, new_xml_open_node($table_tag);
            push    @rows, new_xml_close_node($table_tag);
        }

        $tex->tail_append(@rows);

        if ($tex->is_vmode()) {
            $tex->build_page();
        }
    }

    return;
}

sub finish_align_in_display {
    my $tex = shift;

    $tex->do_assignments();

    my $head = $tex->pop_nest();

    $tex->tail_append(@{ $head });

    return;
}

######################################################################
##                                                                  ##
##         [38] BREAKING PARAGRAPHS INTO LINES (NOT REALLY)         ##
##                                                                  ##
######################################################################

my %output_line_length_of :COUNTER(:name<output_line_length> :default<72>);

sub __unskip {
    my @nodes = @_;

    my @prefix;

    while (@nodes) {
#        if (! defined $nodes[0]) {
#            shift @nodes;
#            next;
#        }

        if ($nodes[0]->is_xml_attribute_node()) {
            push @prefix, shift @nodes;
        } elsif ($IS_WHITESPACE{$nodes[0]}) {
            shift @nodes;
        } else {
            last;
        }
    }

    my @suffix;

    while (@nodes) {
        if ($nodes[-1]->is_xml_attribute_node()) {
            unshift @suffix, pop @nodes;
        } elsif ($IS_WHITESPACE{$nodes[-1]}) {
            pop @nodes;
        } else {
            last;
        }
    }

    return (@prefix, @nodes, @suffix);
}

## This takes care of the two cases we've encountered so far.  A more
## general solution would require us to classify all nodes according
## to whether they count as content or not.

sub __is_empty_par {
    my @nodes = @_;

    return 1 if @nodes == 0;

    return @nodes == 1 && $nodes[0]->is_xml_attribute_node();

    # This is too strict since it weeds out "paragraphs" consisting
    # solely of XML tag nodes.  See note in TeX::Node::HListNode::is_visible.

    # return none { $_->is_visible() } @nodes;
}

sub line_break {
    my $tex = shift;

    my $widow_penalty = shift;

    my @cur_list = __unskip($tex->pop_nest());

    return if __is_empty_par(@cur_list);

    my $hbox = new_null_box();

    my $max_length = -1;

    if ($max_length < 1) {
        $hbox->push_node(@cur_list);
    } else {
        my $cur_length = 0;

        my @line;

        while (defined(my $node = shift @cur_list)) {
            if ($node eq "\n") {
                my $line = new_null_box();

                $line->push_node(__unskip(@line));

                $hbox->push_node($line);

                $hbox->push_node(new_unicode_string("\n"));

                @line = ();

                $cur_length = 0;

                next;
            }

            my $node_width = length("$node");

            if ($cur_length + $node_width > $max_length && $node eq " ") {
                my $tail = $line[-1];

                my $line = new_null_box;

                $line->push_node(__unskip(@line));

                $hbox->push_node($line);

                $hbox->push_node(new_unicode_string("\n"));

                @line = ();

                $cur_length = 0;
            } else {
                push @line, $node;

                $cur_length += $node_width;
            }
        }

        if (@line) {
            my $line = new_null_box;

            $line->push_node(__unskip(@line));

            $line->push_node(new_unicode_string("\n"));

            $hbox->push_node($line);
        }

        #$hbox->push_node(new_unicode_string("\n"));
    }

    # $hbox->get_node(-1)->pop_node(); # Drop the trailing newline.

    my $qName = $tex->this_xml_par_tag();

    if (empty($qName)) {
        $qName = $tex->xml_par_tag();
    }

    if (nonempty($qName)) {
        if (nonempty(my $class = $tex->this_xml_par_class())) {
            $hbox->unshift_node(make_xml_class_node(XML_SET_CLASSES, $class));
        }

        $hbox->unshift_node(new_xml_open_node($qName));

        $hbox->push_node(new_xml_close_node($qName));
    }

    $tex->tail_append($hbox);

    return;
}

######################################################################
##                                                                  ##
##          [39] BREAKING PARAGRAPHS INTO LINES, CONTINUED          ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                       [40] PRE-HYPHENATION                       ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                      [41] POST-HYPHENATION                       ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                  [42] HYPHENATION (NOT REALLY)                   ##
##                                                                  ##
######################################################################

sub set_cur_lang {
    my $tex = shift;

    my $ident = ident $tex;

    my $language = $tex->language();

    if ($language < 0 || $language > 255) {
        $language = 0;
    }

    return $cur_lang_of{$ident} = $language;
}

######################################################################
##                                                                  ##
##             [43] INITIALIZING THE HYPHENATION TABLES             ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##             [44] BREAKING VERTICAL LISTS INTO PAGES              ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                      [45] THE PAGE BUILDER                       ##
##                                                                  ##
######################################################################

sub build_page {
    my $tex = shift;

    my $bottom_list = $tex->get_semantic_nest(0);

    my @contributions = $bottom_list->get_nodes();

    $tex->push_cur_page(@contributions);

    $bottom_list->delete_nodes();

    $tex->fire_up();

    return;
}

sub fire_up {
    my $tex = shift;

    my @page = $tex->get_cur_pages();

    ##* I suspect the following won't be necessary once I sort modes out.

    return unless @page;

    my $vbox = new_null_vbox();

    $vbox->push_node(@page);

    $tex->ship_out($vbox);

    $tex->delete_cur_pages();

    return;
}

######################################################################
##                                                                  ##
##                     [46] THE CHIEF EXECUTIVE                     ##
##                                                                  ##
######################################################################

##*FIXME: Hard-coded CMR ligatures.

my %CMR_LIGATURE = ( "-"        => { "-" => "\x{2013}" },
                     "\x{2013}" => { "-" => "\x{2014}" },
                     "!"        => { "`" => "\x{00A1}" },
                     "?"        => { "`" => "\x{00BF}" },
                     '`'        => "\x{2018}",
                     "'"        => "\x{2019}",
                     "\x{2018}" => { "`" => "\x{201C}" },
                     "\x{2019}" => { "'" => "\x{201D}" },
                     # "`"        => { "`" => "\x{201C}" },
                     # "'"        => { "'" => "\x{201D}" },
                     '"'        => "\x{201D}",
    );

sub main_control {
    my $tex = shift;

    while (my $cur_tok = $tex->get_x_token()) {
        ## END_TEX_TOKEN terminates the current instance of
        ## main_control().  Normally, this will be the main invocation
        ## in TeX(), but it could be an invocation from process_file()
        ## and process_string().

        if (ident($cur_tok) == ident(END_TEX_TOKEN)) {
            return;
        }

        my $cur_cat = $cur_tok->get_catcode();

        if ($cur_cat == CATCODE_LETTER || $cur_cat == CATCODE_OTHER) {
            if ($tex->is_vmode()) {
                $tex->back_input($cur_tok);

                $tex->new_graf();

                next;
            }

            my $char = $tex->maybe_do_ligature($cur_tok);

            $tex->append_char(ord($char));

            next;
        }

        ## In TeX, spaces are ignored in math mode, but we preserve
        ## them for readability.  We still ignore them in vertical
        ## mode, though.

        if ($cur_cat == CATCODE_SPACE) {
            if ($tex->is_hmode() || $tex->is_mmode()) {
                $tex->append_normal_space();
            }

            next;
        }

        if (   $cur_cat == CATCODE_CSNAME
            || $cur_cat == CATCODE_ACTIVE
            || $cur_cat == CATCODE_ANONYMOUS) {
            my $cur_cmd = $tex->get_meaning($cur_tok);

            use Scalar::Util qw(reftype);

            # TRACE "ref($cur_cmd) = ", ref($cur_cmd), " :: ", reftype($cur_cmd), "\n";

            if (! defined $cur_cmd) {
                $tex->handle_undefined_command($cur_tok, '<undef>');
            } elsif (eval { $cur_cmd->isa("TeX::Token") }) {
                $tex->back_input($cur_cmd);
            } elsif (reftype($cur_cmd) eq 'CODE')  {
                $cur_cmd->($tex, $cur_tok);
            } elsif (eval { $cur_cmd->isa("TeX::Command::Prefixed") }) {
                $tex->prefixed_command($cur_cmd, $cur_tok);
            } elsif (eval { $cur_cmd->isa("TeX::Command") }) {
                $cur_cmd->execute($tex, $cur_tok);
            }
            else {
                $tex->handle_undefined_command($cur_tok, $cur_cmd);
            }

            next;
        }

        if ($cur_cat == CATCODE_BEGIN_GROUP) {
            $tex->new_save_level(simple_group);

            if ($tex->is_mmode()) {
                $tex->append_char(ord($cur_tok->get_char()));
            }

            next;
        }

        if ($cur_cat == CATCODE_END_GROUP) {
            $tex->handle_right_brace($cur_tok);

            next;
        }

        if ($cur_cat == CATCODE_MATH_SHIFT) {
            if ($tex->is_vmode()) {
                $tex->back_input($cur_tok);

                $tex->new_graf();

                next;
            }

            if ($tex->is_hmode()) {
                $tex->init_math();
            } elsif ($tex->is_mmode()) {
                my $cur_group = $tex->cur_group();

                if ($cur_group == math_shift_group) {
                    $tex->after_math();
                } else {
                    $tex->off_save($cur_tok,
                                   "main_control math_shift (cur_group = " . group_type($cur_group) . ")");
                }
            }
        }

        if ($cur_cat == CATCODE_ALIGNMENT) {
            # $tex->align_error($cur_tok);

            $tex->append_char(ord($cur_tok->get_char()));

            next;
        }

        if ($cur_cat == CATCODE_PARAMETER) {
            $tex->append_char(ord($cur_tok->get_char()));

            next;
        }

        if ($cur_cat == CATCODE_SUPERSCRIPT) {
            $tex->append_char(ord($cur_tok->get_char()));

            next;
        }

        if ($cur_cat == CATCODE_SUBSCRIPT) {
            $tex->append_char(ord($cur_tok->get_char()));

            next;
        }
    }

    return;
}

sub handle_undefined_command {
    my $tex = shift;

    my $cur_tok = shift;
    my $cur_cmd = shift || '<undef>';

    $tex->print_err("Don't know how to execute '$cur_tok' ($cur_cmd)");

    $tex->set_help("Don't know how to execute '$cur_tok' ($cur_cmd)");

    $tex->error();

    return;
}

sub adjust_space_factor {
    my $tex = shift;

    my $char_code = shift;

    my $this_char = chr($char_code);

    my $current = $tex->spacefactor();

    my $main_s = $tex->get_sfcode($char_code);

    if ($main_s == 1000) {
        $current = 1000;
    } elsif ($main_s < 1000) {
        if ($main_s > 0) {
            $current = $main_s;
        }
    } elsif ($current < 1000) {
        $current = 1000;
    } else {
        $current = $main_s;
    }

    $tex->set_spacefactor($current);

    return;
}

sub maybe_do_ligature( $ ) {
    my $tex = shift;

    my $token = shift;

    my $char = $token->get_char();

    return $char if $tex->noligs();

    return $char if $tex->is_mmode();

    while(1) {
        my $lig_spec = $CMR_LIGATURE{$char};

        last unless defined $lig_spec;

        if (! ref $lig_spec) {
            $char = $lig_spec;

            next;
        }

        my $next_token = $tex->get_x_token();

        last unless defined $next_token;

        if ($next_token == CATCODE_LETTER || $next_token == CATCODE_OTHER) {
            my $next_char = $next_token->get_char();

            if (defined(my $ligature = $lig_spec->{$next_char})) {
                $char = $ligature;

                next;
            }
        }

        $tex->back_input($next_token);

        last;
    }

    return $char;
}

sub insert_dollar_sign {
    my $tex = shift;

    my $token = shift;

    $tex->back_input($token);

    $tex->print_err("Missing \$ inserted");

    $tex->set_help("I've inserted a begin-math/end-math symbol since I think",
                    "you left one out. Proceed, with fingers crossed.");

    $tex->ins_error(MATH_SHIFT_TOKEN);

    return;
}

sub you_cant {
    my $tex = shift;

    my $cur_cmd = shift;

    $tex->print_err("You can't use `");
    $tex->print_cmd_chr($cur_cmd);
    $tex->print("' in ");
    $tex->print_mode($tex->get_cur_mode());

    return;
}

sub report_illegal_case {
    my $tex = shift;

    my $cur_cmd = shift;

    $tex->you_cant($cur_cmd);

    $tex->set_help("Sorry, but I'm not programmed to handle this case;",
                   "I'll just pretend that you didn't ask for it.",
                   "If you're in the wrong mode, you might be able to",
                   "return to the right one by typing `I}' or `I\$' or `I\\par'.");

    $tex->error();

    return;
}

sub privileged {
    my $tex = shift;

    my $cur_cmd = shift;

    if ($tex->get_cur_mode() > 0) {
        return true;
    }

    $tex->report_illegal_case($cur_cmd);

    return;
}

sub its_all_over {
    my $tex = shift;

    #* lots of stuff to be implemented. (???)

    return 1;
}

sub append_char {
    my $tex = shift;
    my $char_code = shift;

    $tex->adjust_space_factor($char_code);

    my $encoding = shift || $tex->get_encoding();

    $tex->tail_append(new_unicode_character($char_code, $encoding));

    return;
}

my $UNICODE_SPACE_CHAR = new_character(DEFAULT_CHARACTER_ENCODING, ord(' '));

sub append_normal_space {
    my $tex = shift;

    $tex->tail_append($UNICODE_SPACE_CHAR);

    return;
}

######################################################################
##                                                                  ##
##                  [47] BUILDING BOXES AND LISTS                   ##
##                                                                  ##
######################################################################

my %cur_box_of :ATTR(:name<cur_box>);

sub handle_right_brace {
    my $tex = shift;

    my $cur_tok = shift;

    my $cur_group = $tex->cur_group();

    if ($cur_group == simple_group) {
        $tex->unsave();

        if ($tex->is_mmode()) {
            $tex->append_char(ord('}'));
        }
    }
    elsif ($cur_group == bottom_level) {
        $tex->print_err("Too many }'s");

        $tex->set_help("You've closed more groups than you opened.",
                       "Such booboos are generally harmless, so keep going.");

        $tex->error();
    }
    elsif ($cur_group >= semi_simple_group && $cur_group < math_left_group) {
        $tex->extra_right_brace();
    }
    elsif ($cur_group == hbox_group) {
        $tex->package(0);
    }
    elsif ($cur_group == adjusted_hbox_group) {
        # adjust_tail := adjust_head;

        $tex->package(0);
    }
    elsif ($cur_group == vbox_group) {
        $tex->end_graf();

        $tex->package(0);
    }
    elsif ($cur_group == vtop_group) {
        $tex->end_graf();

        $tex->package(vtop_code);
    }
    # elsif ($cur_group == insert_group) {
    #     end_graf;
    #     q := split_top_skip;
    #     add_glue_ref(q);
    #     d := split_max_depth;
    #     f := floating_penalty;
    #     unsave;
    #     decr(save_ptr);
    #
    #     {now |saved(0)| is the insertion number, or 255 for |vadjust|}
    #
    #     p := vpack(link(head), natural);
    #     pop_nest;
    #
    #     if saved(0) < 255 then
    #     begin
    #         tail_append(get_node(ins_node_size));
    #
    #         type(tail)    := ins_node;
    #         subtype(tail) := qi(saved(0));
    #
    #         height(tail)        := height(p) + depth(p);
    #         depth(tail)         := d;
    #         ins_ptr(tail)       := list_ptr(p);
    #         split_top_ptr(tail) := q;
    #         float_cost(tail)    := f;
    #     end
    #     else
    #     begin
    #         tail_append(get_node(small_node_size));
    #
    #         type(tail)    := adjust_node;
    #         subtype(tail) := 0; {the |subtype| is not used}
    #
    #         adjust_ptr(tail) := list_ptr(p);
    #
    #         delete_glue_ref(q);
    #     end;
    #
    #     free_node(p, box_node_size);
    #
    #     if nest_ptr = 0 then build_page;
    # }
    # elsif ($cur_group == output_group) {
    #     @<Resume the page builder...@>;
    # }
    # elsif ($cur_group == disc_group) {
    #     $tex->build_discretionary();
    # }
    elsif ($cur_group == align_group) {
        $tex->back_input($cur_tok);

        $tex->print_err("Missing ");
        $tex->print_esc("cr");
        $tex->print(" inserted");

        $tex->set_help("I'm guessing that you meant to end an alignment here.");

        $tex->ins_error(FROZEN_CR_TOKEN);
    }
    elsif ($cur_group == no_align_group) {
        $tex->end_graf;

        $tex->unsave();

        my $align = $tex->get_cur_alignment();

        $tex->align_peek($align);
    }
    elsif ($cur_group == vcenter_group) {
        $tex->end_graf();

        $tex->unsave();

        my $height      = $tex->pop_save_stack();
        my $spec_code   = $tex->pop_save_stack();

        my $head = $tex->pop_nest();

        my $cur_box = $tex->vpack($head, $height, $spec_code);

        $tex->tail_append($cur_box);

        # tail_append(new_noad);
        #
        # type(tail) := vcenter_noad;
        # math_type(nucleus(tail)) := sub_box;
        # info(nucleus(tail)) := p;
    }
    # elsif ($cur_group == math_choice_group) {
    #     $tex->build_choices();
    # }
    # elsif ($cur_group == math_group) {
    #     unsave;
    #
    #     decr(save_ptr);
    #
    #     math_type(saved(0)) := sub_mlist;
    #     p := fin_mlist(null);
    #     info(saved(0)) := p;
    #
    #     if p <> null then if link(p) = null then
    #         if type(p) = ord_noad then
    #         begin
    #             if math_type(subscr(p)) = empty then
    #                 if math_type(supscr(p)) = empty then
    #                 begin
    #                     mem[saved(0)].hh := mem[nucleus(p)].hh;
    #                     free_node(p, noad_size);
    #                 end;
    #         end
    #         else if type(p) = accent_noad then
    #             if saved(0) = nucleus(tail) then
    #                 if type(tail) = ord_noad then
    #                     @<Replace the tail of the list by |p|@>;
    # }
    else {
        $tex->confusion("rightbrace");
    }

    return;
}

sub extra_right_brace {
    my $tex = shift;

    my $cur_group = $tex->cur_group();

    $tex->print_err("Extra }, or forgotten ");

    if ($cur_group == semi_simple_group) {
        $tex->print_esc("endgroup");
    } elsif ($cur_group == math_shift_group) {
        $tex->print_char("\$");
    } elsif ($cur_group == math_left_group) {
        $tex->print_esc("right");
    }

    $tex->set_help("I've deleted a group-closing symbol because it seems to be",
                   "spurious, as in `\$x}\$'. But perhaps the } is legitimate and",
                   "you forgot something else, as in `\\hbox{\$x}'. In such cases",
                   "the way to recover is to insert both the forgotten and the",
                   "deleted material, e.g., by typing `I\$}'.");

    $tex->error();

    $tex->incr_align_state();

    return;
}

sub normal_paragraph {
    my $tex = shift;

    if ($tex->looseness() != 0) {
        $tex->set_looseness(0);
    }

    if ($tex->hang_indent() != 0) {
        $tex->set_hang_indent(0);
    }

    if ($tex->hang_after() != 1) {
        $tex->set_hang_after(1);
    }

    $tex->set_this_xml_par_tag("");
    $tex->set_this_xml_par_class("");

    #* if par_shape_ptr <> null then eq_define(par_shape_loc, shape_ref, null);

    return;
}

sub box_end {
    my $tex = shift;

    my $box_context = shift || 0; ##* TODO: why is this sometimes null?

    my $cur_box = $tex->get_cur_box();

    # $tex->DEBUG("box_context = $box_context; cur_box = $cur_box");

    if ($box_context < box_flag) {
        # @<Append box |cur_box| to the current list, shifted by |box_context|@>

        $tex->tail_append($cur_box);

        if ($tex->is_hmode()) {
            $tex->set_spacefactor(1000);
        }
    }
    elsif ($box_context < ship_out_flag) {
        my $n = $box_context - box_flag;

        my $modifier = $n > 255;

        $n -= 256 if $n > 255;

        $tex->box_set($n, $cur_box, $modifier);

        $tex->delete_cur_box();
    }
    elsif (defined $cur_box) {
        if ($box_context > ship_out_flag) {
            # @<Append a new leader node that uses |cur_box|@>
        }

        $tex->delete_cur_box();
    }
    else {
        $tex->ship_out($cur_box);
    }

    return;
}

sub begin_box {
    my $tex = shift;

    my $box_context = shift;
    my $cur_cmd     = shift;

    $cur_cmd->scan_box($tex, $box_context);

    return;
}

sub scan_box {
    my $tex = shift;

    my $box_context = shift;

    my $cur_tok = $tex->get_next_non_blank_non_relax_non_call_token();

    my $cur_cmd = $tex->get_meaning($cur_tok);

    if (eval { $cur_cmd->isa("TeX::Primitive::MakeBox") }) {
        $tex->begin_box($box_context, $cur_cmd);
    } elsif ($box_context >= leader_flag
             && eval { $cur_cmd->isa("TeX::Primitive::Rule") }) {
        my $cur_box = $tex->scan_rule_spec();

        $tex->set_cur_box($cur_box);

        $tex->box_end($box_context);
    } else {
        $tex->no_box_error($cur_tok);
    }
}

sub no_box_error {
    my $tex = shift;

    my $cur_tok = shift;

    $tex->print_err("A <box> was supposed to be here");

    $tex->set_help("I was expecting to see \\hbox or \\vbox or \\copy or \\box or",
                   "something like that. So you might find something missing in",
                   "your output. But keep trying; you can fix this later.");

    $tex->back_error($cur_tok);

    return;
}

sub package {
    my $tex = shift;

    my $c = shift;

    my $d = $tex->box_max_depth();

    $tex->unsave();

    my $width       = $tex->pop_save_stack();
    my $spec_code   = $tex->pop_save_stack();
    my $box_context = $tex->pop_save_stack();

    my $cur_box;

    my $head = $tex->pop_nest();

    if ($tex->is_hmode()) {
        $cur_box = $tex->hpack($head, $width, $spec_code);
    } else {
        $cur_box = $tex->vpackage($head, $width, $spec_code, $d);

        if ($c == vtop_code) {
            # @<Readjust the height and depth of |cur_box|, for \.{\\vtop}@>;
        }
    }

    $tex->set_cur_box($cur_box);

    $tex->box_end($box_context);

    return;
}

## Note that the valence of the argument has been reversed with
## respect to tex.web's new_graf().  This reflects the fact that
## invoking new_graf() with indentation suppressed is the exception.

sub new_graf {
    my $tex = shift;

    my $unindented = shift;

    my $cur_list = $tex->get_cur_list();

    $cur_list->set_prev_graf(0);

    if ($cur_list->get_mode() == vmode || $cur_list->length() > 0) {
        $tex->tail_append($tex->new_param_glue("par_skip"));
    }

    $tex->push_nest();

    $cur_list = $tex->get_cur_list();

    $cur_list->set_mode(hmode);
    $tex->set_spacefactor(1000);

    my $cur_lang = $tex->set_cur_lang();

    $cur_list->set_clang($cur_lang);

    ## ewww

    my $prev_graf = (norm_min($tex->left_hyphen_min()) * 0100 +
                     norm_min($tex->right_hyphen_min())) * 0200000
                     + $cur_lang;

    $cur_list->set_prev_graf($prev_graf);

    if (! $unindented) {
        #* tail := new_null_box;
        #* link(head) := tail;
        #* width(tail) := par_indent;
    }

    $tex->begin_token_list($tex->get_toks_list('every_par'), every_par_text);

    if ($tex->get_nest_ptr() == 1) {
        $tex->build_page(); # {put |par_skip| glue on current page}
    }

    return;
}

sub head_for_vmode {
    my $tex = shift;

    my $cur_tok = shift;

    my $cur_cmd = $tex->get_meaning($cur_tok);

    my $cur_list = $tex->get_cur_list();

    if ($cur_list->get_mode() < 0) {
        if (eval { $cur_cmd->isa("TeX::Primitive::hrule") }) {
            $tex->print_err("You can't use `");
            $tex->print_esc("hrule");
            $tex->print("' here except with leaders");

            $tex->set_help("To put a horizontal rule in an hbox or an alignment,",
                            "you should use \\leaders or \\hrulefill (see The TeXbook).");

            $tex->error();
        } else {
            $tex->off_save($cur_tok, "head_for_vmode");
        }
    } else {
        $tex->back_input($cur_tok);

        $tex->back_input(FROZEN_PAR_TOKEN);
        $tex->set_token_type(inserted);
    }

    return;
}

sub end_graf {
    my $tex = shift;

    my $cur_list = $tex->get_cur_list();

    if ($cur_list->get_mode() == hmode) {
        # if (__is_empty_par($cur_list->get_nodes())) {
        #     $tex->pop_nest(); # {null paragraphs are ignored}
        # } else {
            $tex->line_break($tex->widow_penalty());
        # }

        $tex->begin_token_list($tex->get_toks_list('after_par'),
                               after_par_text);

        $tex->normal_paragraph();

        $tex->set_error_count(0);
    }

    return;
}

sub unpackage {
    my $tex = shift;

    my $box_code = shift;

    my $index = $tex->scan_eight_bit_int();

    my $box = $tex->box($index);

    return unless defined $box;

    my $mode = abs($tex->get_cur_mode());

    if (    $mode == mmode
         || ( $mode == vmode && ! $box->is_vbox())
         || ( $mode == hmode && ! $box->is_hbox()) ) {
        $tex->print_err("Incompatible list can't be unboxed");

        $tex->set_help("Sorry, Pandora. (You sneaky devil.)",
                       "I refuse to unbox an \\hbox in vertical mode or vice versa.",
                       "And I can't open any boxes in math mode.");

        $tex->error();

        return;
    }

    $tex->tail_append($box->get_nodes());

    if ($box_code == box_code) {
        $tex->box_set($index, undef);
    }

    return;
}

sub make_accent {
    my $tex = shift;

    my $accent_code = $tex->scan_char_num();

    my $unicode_accent = decode_character($tex->get_encoding(), $accent_code);

    $tex->do_assignments();

    my $base_char = $tex->get_x_token(); #*

    my ($combined, $error) = apply_accent($unicode_accent, $base_char);

    if (defined $error) {
        $tex->print_err(sprintf(qq{Error processing \\accent"%04X (%s)},
                                $accent_code,
                                $error));

        $tex->error();
    }

    if (! defined $combined) {
        $tex->print_err(sprintf(qq{Can't apply \\accent"%04X to $base_char},
                                $accent_code));

        $tex->error();
    } else {
        my $char_code = ord($combined);

        ## This might be the first time we've encountered this composite character.

        $tex->initialize_char_codes($char_code);

        $tex->tail_append(new_unicode_character($char_code));

        $tex->adjust_space_factor($char_code); # NB: Always 1000 in tex.web
    }

    return;
}

sub align_error {
    my $tex = shift;

    my $cur_tok = shift;

    if (abs($tex->align_state()) > 2) {
        my $cur_cmd = $tex->get_meaning($cur_tok);

        $tex->print_err("Misplaced ");
        $tex->print_cmd_chr($cur_cmd);

        if ($cur_tok == TAB_TOKEN) {
            $tex->set_help("I can't figure out why you would want to use a tab mark",
                           "here. If you just want an ampersand, the remedy is",
                           "simple: Just type `I\&' now. But if some right brace",
                           "up above has ended a previous alignment prematurely,",
                           "you're probably due for more error messages, and you",
                            "might try typing `S' now just to see what is salvageable.");
        } else {
            $tex->set_help("I can't figure out why you would want to use a tab mark",
                           "or \\cr or \\span just now. If something like a right brace",
                           "up above has ended a previous alignment prematurely,",
                           "you're probably due for more error messages, and you",
                           "might try typing `S' now just to see what is salvageable.");
        }

        $tex->error();
    } else {
        $tex->back_input($cur_tok);

        if ($tex->align_state() < ALIGN_COLUMN_BOUNDARY) {
            $tex->print_err("Missing { inserted (align_state = ", $tex->align_state(), ")");

            $tex->incr_align_state();

            $cur_tok = BEGIN_GROUP
        } else {
            $tex->print_err("Missing } inserted (align_state = ", $tex->align_state(), ")");

            $tex->decr_align_state();

            $cur_tok = END_GROUP;
        }

        $tex->set_help("I've put in what seems to be necessary to fix",
                       "the current column of the current alignment.",
                       "Try to go on, since this might almost work.");

        $tex->ins_error($cur_tok);
    }

    return;
}

######################################################################
##                                                                  ##
##                     [48] BUILDING MATH LISTS                     ##
##                                                                  ##
######################################################################

sub push_math {
    my $tex = shift;

    my $group_code = shift;

    $tex->push_nest();

    $tex->set_cur_mode(- mmode);

    $tex->new_save_level($group_code);

    return;
}

sub init_math {
    my $tex = shift;

    my $token = $tex->get_next();

    if ($token == CATCODE_MATH_SHIFT && $tex->get_cur_mode() > 0) {
        $tex->enter_display_math_mode();
    } else {
        $tex->back_input($token);

        $tex->enter_ordinary_math_mode();
    }

    return;
}

sub enter_ordinary_math_mode {
    my $tex = shift;

    $tex->push_math(math_shift_group);

    $tex->set_cur_fam(-1);

    ## TODO: This doesn't work yet because of LaTeX \frozen@everymath hack.

    $tex->begin_token_list($tex->get_toks_list('every_math'), every_math_text);

    return;
}

sub enter_display_math_mode {
    my $tex = shift;

    my $w = - max_dimen;

    my $cur_list = $tex->get_cur_list();

    ## This caused trouble for
    ## TeX::Interpreter::LaTeX::copy_math_environment().  Need to
    ## think about re-enabling it.

    ##*? if ($cur_list->length() == 0) {
    ##*?     # "\noindent$$" or "$$ $$"
    ##*?     $tex->pop_nest();
    ##*?
    ##*?     $w = - max_dimen;
    ##*? } else {
    ##*?     $tex->line_break($tex->display_widow_penalty());
    ##*? }

    if ($cur_list->length() > 0) {
        $tex->line_break($tex->display_widow_penalty());
    }

    my $l = $tex->hsize();
    my $s = 0;

    $tex->push_math(math_shift_group);

    $tex->set_cur_mode(mmode);

    $tex->set_cur_fam(-1);
    $tex->set_pre_display_size($w);
    $tex->set_pre_display_size($l);
    $tex->set_pre_display_size($s);

    ## TODO: This doesn't work yet because of LaTeX \frozen@everydisplay hack.

    $tex->begin_token_list($tex->get_toks_list('every_display'), every_display_text);

    if ($tex->get_nest_ptr() == 1) {
        $tex->build_page();
    }

    return;
}

sub scan_math {
    my $tex = shift;

    my $pointer = shift;

    return;
}

sub set_math_char {
    my $tex = shift;

    my $pointer = shift;

    return;
}

sub math_limit_switch {
    my $tex = shift;

    return;
}

sub scan_delimiter {
    my $tex = shift;

    my $boolean = shift;

    my $cur_val;

    if ($boolean) {
        $cur_val = $tex->scan_twenty_seven_bit_int();
    } else {
        my $cur_tok = $tex->get_next_non_blank_non_relax_non_call_token();

        my $catcode = $cur_tok->get_catcode();

        if ($catcode == CATCODE_LETTER || $catcode == CATCODE_OTHER) {
            $cur_val = $tex->get_delcode(ord($cur_tok->get_datum()));
        } else {
            my $cur_cmd = $tex->get_meaning($cur_tok);

            if ($cur_cmd->isa("TeX::Primitive::delimiter")) {
                $cur_val = $tex->scan_twenty_seven_bit_int();
            } else {
                $cur_val = -1;
            }
        }

        # if ($cur_val < 0) {
        #     $tex->print_err("Missing delimiter (. inserted)");
        #
        #     $tex->set_help("I was expecting to see something like `(' or `\{' or",
        #                    "`\}' here. If you typed, e.g., `{' instead of `\{', you",
        #                    "should probably delete the `{' by typing `1' now, so that",
        #                    "braces don't get unbalanced. Otherwise just proceed.",
        #                    "Acceptable delimiters are characters whose \\delcode is",
        #                    "nonnegative, or you can use `\\delimiter <delimiter code>'.");
        #
        #     $tex->back_error($cur_tok);
        #
        #     $cur_val = 0;
        # }
    }

    return $cur_val;
}

sub math_radical {
    my $tex = shift;

    return;
}

sub math_ac {
    my $tex = shift;

    # tail_append(get_node(accent_noad_size));
    #
    # type(tail) := accent_noad;
    # subtype(tail) := normal;
    #
    # mem[nucleus(tail)].hh := empty_field;
    # mem[subscr(tail)].hh  := empty_field;
    # mem[supscr(tail)].hh  := empty_field;
    #
    # math_type(accent_chr(tail)) := math_char;
    #
    # scan_fifteen_bit_int;
    #
    # character(accent_chr(tail)) := qi(cur_val mod 256);
    #
    # if (cur_val >= var_code) and fam_in_range then
    #     fam(accent_chr(tail)) := cur_fam
    # else
    #     fam(accent_chr(tail)) := (cur_val div 256) mod 16;
    #
    # scan_math(nucleus(tail));

    return;
}

sub append_choices {
    my $tex = shift;

    return;
}

sub build_choices {
    my $tex = shift;

    return;
}

sub sub_sup {
    my $tex = shift;

    return;
}

sub fin_mlist {
    my $tex = shift;

    my $mlist = $tex->get_cur_list();

    $tex->pop_nest();

    return $mlist;
}

sub open_math_mode {
    my $tex = shift;

    my $is_inline = shift;

    my $qName = $is_inline ? $tex->inline_math_tag()
                           : $tex->display_math_tag();

    $tex->tail_append(TeX::Node::MathOpenNode->new({
        qName  => $qName,
        inline => $is_inline,
        inner_tag => $tex->tex_math_tag(),
                                                   }));

    return;
}

sub close_math_mode {
    my $tex = shift;

    my $is_inline = shift;

    my $qName = $is_inline ? $tex->inline_math_tag()
                           : $tex->display_math_tag();

    $tex->tail_append(TeX::Node::MathCloseNode->new({
        qName  => $qName,
        inline => $is_inline,
        inner_tag => $tex->tex_math_tag(),
                                                   }));

    return;
}

use constant XML_OPEN_ROMAN  => new_xml_open_node('roman');
use constant XML_CLOSE_ROMAN => new_xml_close_node('roman');

use constant XML_OPEN_SMALLCAPS  => new_xml_open_node('sc');
use constant XML_CLOSE_SMALLCAPS => new_xml_close_node('sc');

use constant EMPTY_MATH_NODE => new_unicode_string("");

sub __math_to_text {
    my $tex = shift;

    my @nodes = @_;

    my $text = nodes_to_string(@_);

    # ## Delete "$ $", etc.
    return (EMPTY_MATH_NODE) if empty $text;

    if ($text eq q{\mathinner {\ldotp \ldotp \ldotp }}) {
        return (new_unicode_string("\x{2026}"));
    }

    if ($text eq q{\bullet }) {
        return (new_unicode_string("\x{2022}"));
    }

    if ($text eq q{\langle }) {
        return (new_unicode_string("\x{2039}"));
    }

    if ($text eq q{\rangle }) {
        return (new_unicode_string("\x{203A}"));
    }

    if ($text eq q{\colon }) {
        return (new_unicode_string(":"));
    }

    if ($text eq q{\!}) {
        return (new_unicode_string("\x{2009}"));
    }

    ## NB: Leave $1$, etc., alone, to avoid font inconsistencies.

    if ($text =~ m{\A ( \[ | \] | [().,:;!?] ) \z}smx) {
        return (XML_OPEN_ROMAN, @nodes, XML_CLOSE_ROMAN);
    }

    # We want to unwrap things like this:
    #
    #     $\text{\eqref{key}}$.
    #     $\eqref{key}$.
    #     $\text{\ref{key}}$.
    #     $\ref{key}$.
    #
    # but not, e.g.,
    #
    #     $\ref{a}\rightarrow\ref{b}$
    #
    # This is still not perfect, but I think it handles all the cases
    # we've encountered so far.  Anything more complicated than this
    # should probably be recoded.
    #
    # Examples would bet monstrosities like the following.
    #
    #     $\text{\ref{a}}, \text{\ref{b}}$
    #     $\text{\ref{a}, \ref{b}}$

    if ($text =~ m{\A (?:<text>)? (?:<x>\(</x>)? <xref> (.*?) </xref> (?:<x>\)</x>)? (?:</text>)?\z}smx) {
        my $middle = $1;

        return @nodes unless $middle =~ m{<xref>};
    }

    if ($text =~ m{\A \\mathsc\{ ([^{}]*) \} \z}smx) {
        ## TBD: Need a better way of doing this sort of thing.

        ## This is not in the best taste.  What if, for example, we
        ## want to generate something other than <sc>?

        splice @nodes,  0, 8, XML_OPEN_SMALLCAPS;

        splice @nodes, -1, 1, XML_CLOSE_SMALLCAPS;

        return @nodes;
    }

    return;
}

sub after_math {
    my $tex = shift;

    my $math_mode = $tex->get_cur_mode();

    my $leqno = false;

    if (defined(my $saved_node = $tex->get_node_register('end_math_list'))) {
        $tex->tail_append($saved_node);
    }

    my $p = $tex->fin_mlist();

    my @mlist = $p->get_nodes();

    if ($math_mode < 0) {
        if (my @text = $tex->__math_to_text(@mlist)) {
            $tex->unsave();

            return if @text == 1 && ident($text[0]) == ident(EMPTY_MATH_NODE);

            $tex->tail_append(@text);

            return;
        }
    }

    my $a;

    my $cur_mode = $tex->get_cur_mode();

    if ($cur_mode == -$math_mode) { # end of equation number
        #* put equation number in $a
    } else {
        $a = undef;
    }

    if ($math_mode < 0) { # inline
        $tex->unsave();

        $tex->open_math_mode(1);
    } else { # displayed
        if (! defined $a) {
            $tex->check_that_math_shift_follows();
        }

        $tex->open_math_mode(0);

        $tex->unsave(); ## where is this in tex.web???
    }

    my $box = new_null_box();

    $box->push_node(@mlist);

    $tex->tail_append($box);

    if ($math_mode < 0) {
        $tex->close_math_mode(1);
    } else {
        $tex->close_math_mode(0);
    }

    $tex->set_spacefactor(1000);

    return;
}

sub check_that_math_shift_follows {
    my $tex = shift;

    my $next = $tex->get_x_token();

    if ($next != CATCODE_MATH_SHIFT) {
        $tex->print_err("Display math should end with \$\$, not '$next'");

        $tex->set_help("The `\$' that I just saw supposedly matches a previous `\$\$'.",
                        "So I shall assume that you typed `\$\$' both times.");

        $tex->back_error($next);
    }

    return;
}

######################################################################
##                                                                  ##
##                 [49] MODE-INDEPENDENT PROCESSING                 ##
##                                                                  ##
######################################################################

my %after_token_of :ATTR(:name<after_token>);

my %long_help_seen_of :BOOLEAN(:name<long_help_seen> :get<long_help_seen> :default<false>);

sub insert_after_token {
    my $tex = shift;

    if (defined(my $after_token = $tex->get_after_token())) {
        $tex->back_input($after_token);

        $tex->delete_after_token();
    }

    return;
}

sub prefixed_command {
    my $tex = shift;

    my $cur_cmd = shift;
    my $cur_tok = shift;

    my $prefix = 0;

    while (eval { $cur_cmd->isa("TeX::Primitive::Prefix") }) {
        $prefix |= $cur_cmd->get_mask();

        $cur_tok = $tex->get_next_non_blank_non_relax_non_call_token();

        if ($cur_tok->is_definable()) {
            $cur_cmd = $tex->get_meaning($cur_tok);
        } else {
            $cur_cmd = undef;
        }
    }

    unless (eval { $cur_cmd->isa("TeX::Command::Executable::Assignment") }) {
        $tex->print_err("You can't use a prefix with `");

        $tex->print_cmd_chr($cur_cmd);

        $tex->print_char("'");

        $tex->set_help("I'll pretend you didn't say \\long or \\outer or \\global.");

        $tex->back_error($cur_tok);

        return;
    }

    if (($prefix & ~MODIFIER_GLOBAL) && ! eval { $cur_cmd->isa("TeX::Primitive::def") }) {
        $tex->print_err("You can't use `");

        $tex->print_esc('long');

        $tex->print("' or `");

        $tex->print_esc('outer');

        $tex->print("' with `");

        $tex->print_cmd_chr($cur_cmd);

        $tex->print_char("'");

        $tex->set_help("I'll pretend you didn't say \\long or \\outer here.");

        $tex->error();
    }

    my $global_defs = $tex->global_defs();

    if ($global_defs < 0) {
        $prefix &= ~MODIFIER_GLOBAL;
    } elsif ($global_defs > 0) {
        $prefix |= MODIFIER_GLOBAL;
    }

    if (eval { $cur_cmd->isa("TeX::Command::Executable::Assignment") }) {
        $cur_cmd->execute($tex, $cur_tok, $prefix);
    } else {
        $tex->confusion("prefix");
    }

    $tex->insert_after_token();

    return;
}

# Get a "redefinable" token, but note that the test for definability
# has been moved to define(), so this is basically just
# get_next_non_space_token().

sub get_r_token {
    my $tex = shift;

    my $token = $tex->get_next();

    while ($token == CATCODE_SPACE) {
        $token = $tex->get_next();
    }

    return $token;
}

sub new_font {
    my $tex = shift;

    my $prefix = shift;

    if (! $tex->log_opened()) {
        $tex->open_log_file();
    }

    my $r_token = $tex->get_r_token();

    $tex->define($r_token, FROZEN_RELAX, $prefix);

    $tex->scan_optional_equals();

    my $font_file_name = $tex->scan_file_name();

    my $font_size = $tex->scan_font_size();

    # @<If this font has already been loaded, set |f| to the internal
    #   font number and |goto common_ending|@>;
    #
    # f := read_font_info(u, cur_name, cur_area, s);

#  common_ending:
    # equiv(u) := f;
    # eqtb[font_id_base + f] := eqtb[u];
    # font_id_text(f) := t;

    return;
}

sub scan_font_size {
    my $tex = shift;

    my $size = -1000;

    if ($tex->scan_keyword("at")) {
        $size = $tex->scan_normal_dimen();

        if ($size <= 0 || $size >= 01000000000) {
            $tex->print_err("Improper `at' size (");
            $tex->print(sprint_scaled($size));
            $tex->print("pt), replaced by 10pt");

            $tex->set_help("I can only handle fonts at positive sizes that are",
                           "less than 2048pt, so I've changed what you said to 10pt.");

            $tex->error();

            $size = 10 * unity;
        }
    } elsif ($tex->scan_keyword("scaled")) {
        $size = $tex->scan_int();

        if ( $size <= 0 || $size > 32768 ) {
            $tex->print_err("Illegal magnification has been changed to 1000");

            $tex->set_help("The magnification ratio must be between 1 and 32768.");

            $tex->int_error($size);

            $size = -1000;
        } else {
            $size = -$size;
        }
    }

    return $size;
}

sub do_assignments {
    my $tex = shift;

    my $cur_tok = $tex->get_next_non_blank_non_relax_non_call_token();

    if (! $cur_tok->is_definable()) {
        $tex->back_input($cur_tok);

        return;
    }

    my $cur_cmd = $tex->get_meaning($cur_tok);

    if (! eval { $cur_cmd->isa("TeX::Command::Executable::Assignment") }) {
        $tex->back_input($cur_tok);

        return;
    }

    $tex->set_set_box_allowed(0);

    $tex->prefixed_command($cur_cmd, $cur_tok);

    $tex->set_set_box_allowed(1);

    return;
}

sub issue_message {
    my $tex = shift;

    my $c = shift;

    my $s = $tex->scan_toks(false, true);

    if ($c == 0) {
        if ($tex->term_offset() + length($s) > $tex->max_print_line() - 2) {
            $tex->print_ln();
        } elsif ( $tex->term_offset() > 0 || $tex->file_offset() > 0 ) {
            $tex->print_char(" ");
        }

        $tex->slow_print($s);

        $tex->update_terminal();
    } else {
        $tex->print_err("");

        $tex->slow_print($s);

        if ( @{ $tex->get_err_helps() } ) {
            $tex->set_use_err_help(true);
        } elsif ($tex->long_help_seen()) {
            $tex->set_help("(That was another \errmessage.)")
        } else {
            if ($tex->get_interaction_mode() < error_stop_mode) {
                $tex->set_long_help_seen(true);
            }

            $tex->set_help("This error message was generated by an \\errmessage",
                           "command, so I can't give any explicit help.",
                           "Pretend that you're Hercule Poirot: Examine all clues,",
                           "and deduce the truth by order and method.");
    }

        $tex->error();

        $tex->set_use_err_help(false);
    }

    return;
}

## This isn't quite right because the lines should actually be token
## lists and we should use token_show(), but it's probably close
## enough.

sub give_err_help {
    my $tex = shift;

    $tex->print_ln();

    for my $line ($tex->get_err_helps()) {
        $tex->print($line);
    }

    return;
}

sub shift_case {
    my $tex = shift;

    my $case = shift;

    my $token_list = $tex->scan_toks(false, false);

    my $ident = ident $tex;

    my $table = $case == 0 ? $lc_codes_of{$ident} :
                $case == 1 ? $uc_codes_of{$ident} : $tc_codes_of{$ident};

    my $shifted_list = new_token_list();

    for my $token (@{ $token_list }) {
        my $catcode = $token->get_catcode();

        if ($catcode < CATCODE_CSNAME) {
            my $char = $token->get_char();

            my $char_code = ord($char);

            my $shifted = $table->{$char_code};

            if (! defined $shifted) {
                $tex->initialize_char_codes($char_code);

                $shifted = $table->{$char_code};
            }

            my $shifted_ord = $shifted->get_equiv()->get_value();

            if ($shifted_ord != 0) {
                my $shifted_char = chr($shifted_ord);

                $token = make_character_token($shifted_char, $catcode);
            }
        }

        $shifted_list->push($token);
    }

    $tex->back_list($shifted_list);

    return;
}

######################################################################
##                                                                  ##
##              [50] DUMPING AND UNDUMPING THE TABLES               ##
##                                                                  ##
######################################################################

my %format_ident_of :ATTR(:name<format_ident>);

sub load_fmt_file {
    my $tex = shift;

    my $fmt_file = shift;

    $fmt_file .= ".fmt" unless $fmt_file =~ m{\.fmt\z};

    my $start_time = time();

    local $ENV{engine} = "/";

    my $path = $fmt_file;

    if (! -e $path) {
        $path = kpse_lookup($fmt_file);

        if (empty($path)) {
            $path = kpse_lookup("$fmt_file.fmt");
        }
    }

    if (empty($path)) {
        $tex->fatal_error("Can't find fmt file $fmt_file!");
    }

    if ( $tex->term_offset() + length($path) > $tex->max_print_line() - 2 ) {
        $tex->print_ln();
    } elsif ( $tex->term_offset() > 0 || $tex->file_offset() > 0 ) {
        $tex->print_char(" ");
    }

    $tex->print_char("(");
    $tex->incr_open_parens();
    $tex->slow_print($path);
    # $tex->print_char(" ");
    $tex->update_terminal();

    my $fmt = TeX::FMT::File->new({ file_name => $path, debug_mode => 0 });

    $fmt->open('r');

    $fmt->load_through_eqtb();

    $tex->undump_eqtb($fmt);

    $tex->set_fmt_file($path);

    $tex->print_char(")");
    $tex->decr_open_parens();
    $tex->update_terminal();

    if ($tex->is_profiling()) {
        my $elapsed = time() - $start_time;

        $tex->__DEBUG("load_fmt_file($path): $elapsed seconds\n");
    }

    return;
}

sub undump_eqtb {
    my $tex = shift;

    my $fmt = shift;

    my $params = $fmt->get_params();
    my $eqtb   = $fmt->get_eqtb();
    my $mem    = $fmt->get_mem();

    ## REGION 1

    for my $eqtb_ptr ($params->active_base() .. $params->single_base() - 1) {
        my $meaning = $tex->extract_meaning($fmt, $eqtb_ptr);

        next unless defined $meaning;

        my $char_code = $eqtb_ptr - $params->active_base();

        my $char = chr($char_code);

        $tex->define_active_char($char, $meaning);
    }

    for my $eqtb_ptr ($params->single_base() .. $params->null_cs() - 1) {
        my $meaning = $tex->extract_meaning($fmt, $eqtb_ptr);

        next unless defined $meaning;

        my $char_code = $eqtb_ptr - $params->single_base();

        my $csname = chr($char_code);

        $tex->define_csname($csname, $meaning);
    }

    ## REGION 2

    my $hash = $fmt->get_hash();
    my $eqtb_size = $fmt->get_eqtb_size();

    for my $eqtb_ptr ($params->hash_base() .. $params->frozen_control_sequence() - 1,
                      $eqtb_size + 1 .. $eqtb_size + $fmt->get_hash_high()) {
        my $string_no = $hash->get_text($eqtb_ptr);

        next unless defined $string_no;

        my $csname = $fmt->get_string($string_no);

        my $meaning = $tex->extract_meaning($fmt, $eqtb_ptr, $csname);

        next unless defined $meaning;

        $tex->define_csname($csname, $meaning);
    }

    ## REGION 3

    my $glue_base = $params->glue_base();

    foreach my $param ($tex->__list_glue_parameters()) {
        my $equiv_code = $params->get_parameter_raw("${param}_code");

        next unless defined $equiv_code;

        my $ptr = $eqtb->get_word($glue_base + $equiv_code)->get_equiv();

        my $value = $mem->get_glue($ptr);

        $tex->get_glue_parameter($param)->get_equiv()->set_value($value);
    }

    my $skip_base = $params->skip_base();

    for my $index (0..$params->number_regs() - 1) {
        my $ptr = $eqtb->get_word($skip_base + $index)->get_equiv();

        my $value = $mem->get_glue($ptr);

        my $eqvt_ptr = $tex->find_skip_register($index);

        ${ $eqvt_ptr }->get_equiv()->set_value($value);
    }

    ## REGION 4

    my $cat_base  = $params->cat_code_base();
    my $lc_base   = $params->lc_code_base();
    my $uc_base   = $params->uc_code_base();
    my $sf_base   = $params->sf_code_base();
    my $math_base = $params->math_code_base();

    my $last_char_code = $params->last_text_char();

    ## Ignore the high-bit codes because we want to treat them as
    ## Unicode characters (sort of -- we're going to decide with to do
    ## with non-OT1 documents).

    $last_char_code = 127 if $last_char_code > 127;

    for my $char_code ($params->first_text_char() .. $last_char_code) {
        # $tex->initialize_char_codes($char_code);

        my $catcode  = $eqtb->get_word($cat_base  + $char_code)->get_equiv();
        my $lccode   = $eqtb->get_word($lc_base   + $char_code)->get_equiv();
        my $uccode   = $eqtb->get_word($uc_base   + $char_code)->get_equiv();
        my $sfcode   = $eqtb->get_word($sf_base   + $char_code)->get_equiv();
        my $mathcode = $eqtb->get_word($math_base + $char_code)->get_equiv();

        $tex->set_catcode($char_code,  $catcode);
        $tex->set_lccode($char_code,   $lccode);
        $tex->set_uccode($char_code,   $uccode);
        $tex->set_sfcode($char_code,   $sfcode);
        $tex->set_mathcode($char_code, $mathcode);
    }

    ## REGION 5

    my $int_base = $params->int_base();

    foreach my $param ($tex->__list_integer_parameters()) {
        my $equiv_code = $params->get_parameter_raw("${param}_code");

        next unless defined $equiv_code;

        my $value = $eqtb->get_word($int_base + $equiv_code)->get_equiv();

        $tex->get_integer_parameter($param)->get_equiv()->set_value($value);
    }

    my $count_base = $params->count_base();

    for my $index (0..$params->number_regs() - 1) {
        my $value = $eqtb->get_word($count_base + $index)->get_equiv();

        my $eqvt_ptr = $tex->find_count_register($index);

        ${ $eqvt_ptr }->get_equiv()->set_value($value);
    }

    ## REGION 6

    my $scaled_base = $params->scaled_base();

    for my $index (0..$params->number_regs() - 1) {
        my $value = $eqtb->get_word($scaled_base + $index)->get_equiv();

        my $eqvt_ptr = $tex->find_dimen_register($index);

        ${ $eqvt_ptr }->get_equiv()->set_value($value);
    }

    return;
}

my %REGISTER = (count  => int_val,
                dimen  => dimen_val,
                muskip => mu_val,
                skip   => glue_val,
                toks   => tok_val);

my %CHARACTER = (left_brace  => CATCODE_BEGIN_GROUP,
                 right_brace => CATCODE_END_GROUP,
                 math_shift  => CATCODE_MATH_SHIFT,
                 tab_mark    => CATCODE_ALIGNMENT,
                 mac_param   => CATCODE_PARAMETER,
                 sup_mark    => CATCODE_SUPERSCRIPT,
                 sub_mark    => CATCODE_SUBSCRIPT,
                 spacer      => CATCODE_SPACE,
                 letter      => CATCODE_LETTER,
                 other_char  => CATCODE_OTHER,
    );

my %MACRO = (call            => 0,
             long_call       => MODIFIER_LONG,
             outer_call      => MODIFIER_OUTER,
             long_outer_call => MODIFIER_LONG | MODIFIER_OUTER,
    );

sub extract_meaning {
    my $tex = shift;

    my $fmt      = shift;
    my $eqtb_ptr = shift;

    my $csname = shift;

    my $params = $fmt->get_params();
    my $eqtb   = $fmt->get_eqtb();

    my $eqtb_entry = $eqtb->get_word($eqtb_ptr);

    my $eq_level = $eqtb_entry->get_eq_level();
    my $eq_type  = $eqtb_entry->get_eq_type();
    my $equiv    = $eqtb_entry->get_equiv();

    my ($type, $subtype) = $params->interpret_cmd_chr($eq_type, $equiv);

    # printf STDERR "*** extract_meaning: type = '%s'; subtype = '%s'\n",
    # $type || "<undef>", $subtype || "<undef>";

    return unless defined $type;

    return if $type eq 'UNKNOWN';

    if (defined(my $cat_code = $CHARACTER{$type})) {
        return make_character_token(chr($equiv), $cat_code);
    }

    if (defined (my $level = $REGISTER{$type}) && defined $subtype) {
        return TeX::Primitive::Register->new({ level => $level,
                                               index => $subtype });
    }

    if ($type eq 'char' && defined $subtype) {
        return TeX::Primitive::CharGiven->new({ value => $subtype });
    }

    if ($type eq 'mathchar' && defined $subtype) {
        return make_math_given($subtype);
    }

    if ($type =~ m{\A assign_(dimen|glue|int|toks|) \z}smx) {
        if (defined(my $eqvt = $tex->get_csname($subtype))) {
            return $eqvt->get_equiv();
        }
    }

    if ($type eq 'set_font' && defined $subtype) {
        return TeX::Primitive::SetFont->new({ font => $subtype });
    }

    if (defined(my $flags = $MACRO{$type})) {
        return $tex->extract_macro($fmt, $flags, $equiv);
    }

    if (defined(my $primitive = $tex->get_primitive($type))) {
        return $primitive;
    }

    my $meaning = eval { $tex->load_primitive($type) };

    return $meaning unless $@;

    {
        my $csname  = $csname  || '<undef>';
        my $type    = $type    || '<undef>';
        my $subtype = $subtype || '<undef>';

        $tex->print_err("Can't find definition for '$csname' [$type, $subtype]");
    }

    return;
}

sub extract_macro {
    my $tex = shift;

    my $fmt         = shift;
    my $flags       = shift;
    my $ref_cnt_ptr = shift;

    my $macro = TeX::Primitive::Macro->new({
        outer     => $flags & MODIFIER_OUTER,
        long      => $flags & MODIFIER_LONG,
        protected => $flags & MODIFIER_PROTECTED,
                                           });

    my $params = $fmt->get_params();
    my $mem    = $fmt->get_mem();

    my $null_ptr = $params->null();

    my $token_list = new_token_list();

    my $param_no = 0;

    for (my $ptr = $mem->get_link($ref_cnt_ptr);
         $ptr != $null_ptr;
         $ptr = $mem->get_link($ptr)) {
        my $token = $tex->extract_token($fmt, $ptr);

        if ($token == $params->end_match()) {
            $macro->set_parameter_text($token_list);

            $token_list = new_token_list();

            next;
        }
        elsif ($token == CATCODE_PARAMETER && $token eq '!') { ## BUG: What if \catcode`\! == CATCODE_PARAMETER
            $token = make_param_ref_token(++$param_no);
        }

        $token_list->push($token);
    }

    $macro->set_replacement_text($token_list);

    return $macro;
}

sub extract_token {
    my $tex = shift;

    my $fmt = shift;
    my $mem_ptr = shift;

    my $params = $fmt->get_params();

    my $info = $fmt->get_mem()->get_info($mem_ptr);

    if ($info >= cs_token_flag) {
        my $eqtb_ptr = $info - cs_token_flag;

        if ($eqtb_ptr < $params->active_base()) {
            return make_csname_token("IMPOSSIBLE");
        }
        elsif ($eqtb_ptr < $params->single_base()) {
            return make_character_token(chr($eqtb_ptr), CATCODE_ACTIVE);
        }
        elsif ($eqtb_ptr < $params->null_cs()) {
            return make_csname_token(chr($eqtb_ptr - $params->single_base()));
        }
        else {
            my $string_no = $fmt->get_hash()->get_text($eqtb_ptr);

            my $csname = defined $string_no ? $fmt->get_string($string_no)
                                            : "UNKNOWN";

            return make_csname_token($csname);
        }
    } else {
        use integer;

        my $char_code = $info % 0400;
        my $cat_code  = $info / 0400;

        if ($cat_code == $params->out_param()) { # 5
            return make_param_ref_token(chr(ord("0") + $char_code));
        }
        elsif ($cat_code == $params->match()) { # 13
            ## BUG: What if \catcode`\! == CATCODE_PARAMETER
            return make_character_token("!", CATCODE_PARAMETER); # 6
        }
        else {
            return make_character_token(chr($char_code), $cat_code);
        }
    }

    ## NEVER GET HERE

    return;
}

sub __show_macro {
    my $macro = shift;

    my $param_text = $macro->get_parameter_text();
    my $macro_text = $macro->get_replacement_text();

    if (defined $param_text) {
        print $param_text;
    }

    print "->";

    print $macro_text;

    return;
}

sub list_macros {
    my $tex = shift;

    my $active_chars = $tex->get_active_chars();

    while (my ($char, $eqvt) = each %{ $active_chars }) {
        my $meaning = $eqvt->get_equiv();

        if (defined $meaning) {
            $tex->print_ln();
            $tex->print_char($char);
            $tex->print(": ");
            $tex->print_meaning($meaning);
            $tex->print_ln();
        }
    }

    my $csnames = $tex->get_csnames();

    while (my ($csname, $eqvt) = each %{ $csnames }) {
        my $meaning = $eqvt->get_equiv();

        if (defined $meaning) {
            $tex->print_ln();
            $tex->print_esc($csname);
            $tex->print(": ");
            $tex->print_meaning($meaning);
            $tex->print_ln();
        }
    }

    return;
}

######################################################################
##                                                                  ##
##                      [51] THE MAIN PROGRAM                       ##
##                                                                  ##
######################################################################

sub __list_primitives {
    my $tex = shift;

    my @primitives = qw(above abovewithdelims accent advance
                        afterassignment aftergroup atop atopwithdelims
                        badness batchmode begingroup botmark box
                        catcode char chardef cleaders closein closeout
                        copy count countdef cr crcr csname delcode
                        delimiter dimen dimendef discretionary
                        displaylimits displaystyle divide dp dump else
                        end endcsname endgroup endinput eqno
                        errmessage errorstopmode expandafter fi
                        firstmark font fontdimen fontname futurelet
                        halign hbox hfil hfill hfilneg hrule hskip hss
                        ht hyphenation hyphenchar if ifcase ifcat
                        ifdim ifeof iffalse ifhbox ifhmode ifinner
                        ifmmode ifnum ifodd iftrue ifvbox ifvoid ifx
                        ignorespaces immediate indent input
                        inputlineno insert jobname kern lastbox
                        lastkern lastpenalty lastskip lccode leaders
                        left leqno let limits lower lowercase mark
                        mathaccent mathbin mathchar mathchardef
                        mathchoice mathclose mathcode mathinner mathop
                        mathopen mathord mathpunct mathrel meaning
                        message mkern moveleft moveright mskip
                        multiply muskip muskipdef noalign noboundary
                        noexpand noindent nolimits nonscript
                        nonstopmode nullfont number omit openin
                        openout or over overline overwithdelims par
                        parshape patterns penalty radical raise read
                        relax right romannumeral scriptfont
                        scriptscriptfont scriptscriptstyle scriptstyle
                        scrollmode setbox setlanguage sfcode shipout
                        show showbox showlists showthe skewchar skip
                        skipdef span special splitbotmark
                        splitfirstmark string tabskip textfont
                        textstyle the toks toksdef topmark uccode
                        underline unhbox unhcopy unkern unpenalty
                        unskip unvbox unvcopy uppercase vadjust valign
                        vbox vcenter vfil vfill vfilneg vrule vskip
                        vsplit vss vss vtop wd write xleaders);

    ## \titlecase is much less useful than it seems.
    push @primitives, qw(tccode titlecase boxtostring endutemplate);

    push @primitives, qw(XeTeXmathcode);

    ## eTeX extensions
    push @primitives, qw(detokenize ifcsname expanded unexpanded);

    return @primitives;
}

my %DEFS = (def  => 0,
            gdef => MODIFIER_GLOBAL,
            edef => MODIFIER_EXPAND,
            xdef => MODIFIER_GLOBAL | MODIFIER_EXPAND,
    );

my %PREFIXES = (long      => MODIFIER_LONG,
                outer     => MODIFIER_OUTER,
                global    => MODIFIER_GLOBAL,
                protected => MODIFIER_PROTECTED,
    );

sub init_prim {
    my $tex = shift;

    $tex->primitive(ifTeXML => "iftrue");

    ## Run-of-the-mill primitives

    $tex->primitive($_) for $tex->__list_primitives();

    ## Primitives with non-alphanumeric names.

    $tex->primitive(" " => "ex_space");
    $tex->primitive("-" => "discretionary_hyphen");
    $tex->primitive("/" => "ital_corr");

    while (my ($def, $modifier) = each %DEFS) {
        my $cmd = TeX::Primitive::def->new({ modifier => $modifier });

        $tex->set_primitive($def => $cmd);
        $tex->define_csname($def => $cmd);
    }

    while (my ($prefix, $mask) = each %PREFIXES) {
        my $cmd = TeX::Primitive::Prefix->new({ name => $prefix,
                                                mask => $mask });

        $tex->set_primitive($prefix => $cmd);
        $tex->define_csname($prefix => $cmd);
    }

    ## Extensions

    $tex->install_misc_extensions();

    $tex->install_xml_extensions();

    $tex->install_svg_extensions();

    return;
}

sub initialize_output_routines {
    my $tex = shift;

    if ($tex->is_unicode_output()) {
        binmode(*STDOUT, ":utf8");
        binmode(*STDERR, ":utf8");
    }

    $tex->wterm(BANNER);

    if (empty(my $format_ident = $tex->get_format_ident())) {
        $tex->wterm_ln(' (no format preloaded)');
    } else {
        $tex->slow_print($format_ident);
        $tex->print_ln();
    }

    $tex->update_terminal();

    return;
}

## Need to allow a filehandle to be passed in.  Also need to be able
## to take the TeX document as a string.

sub TeX {
    my $tex = shift;

    my $file_name = shift;

    # {in case we quit during initialization}
    $tex->set_history(fatal_error_stop);

    $tex->initialize_output_routines();

    $tex->fix_date_and_time();

    # $tex->compute_magic_offset();

    $tex->initialize_print_selector();

    $tex->start_input($file_name);

    $tex->set_history(spotless); # {ready to go!}

    $tex->main_control(); # {come to life}

    $tex->final_cleanup(); # {prepare for death}

    $tex->end_of_TEX();

    return;
}

sub end_of_TEX {
    my $tex = shift;

    $tex->close_files_and_terminate();

    # exit;

    return;
}

sub close_files_and_terminate {
    my $tex = shift;

    $tex->finish_extensions();

    # stat if tracing_stats > 0 then @<Output statistics about this job@>; stats

    $tex->finish_output_file();

    if ($tex->log_opened()) {
        $tex->wlog_cr();

        my $log_file = $tex->get_log_file();

        close($log_file);

        $tex->set_log_file(undef);

        my $selector = $tex->selector() - 2;

        $tex->set_selector($selector);

        if ($selector == term_only) {
            $tex->print_nl("Transcript written on ");
            $tex->slow_print($tex->get_log_name());
            $tex->print_char(".");
            $tex->print_ln(); # Where is this in tex.web?
        }
    }

    STDOUT->flush();
    STDERR->flush();

    return;
}

sub final_cleanup {
    my $tex = shift;

    # my $c = cur_chr;
    #
    # if job_name = 0 then open_log_file;
    #
    # while input_ptr > 0 do
    #     if state = token_list then end_token_list else end_file_reading;

    my $open_parens = $tex->open_parens();

    while ($open_parens > 0) {
        $tex->print(" )");

        $open_parens--;
    }

    $tex->print_ln();

    $tex->set_open_parens(0);

    if ( (my $cur_level = $tex->cur_level()) > level_one ) {
        $tex->print_nl("(");
        $tex->print_esc("end occurred ");
        $tex->print("inside a group at level ");
        $tex->print_int($cur_level - level_one);
        $tex->print_char(")");
    }

    # while cond_ptr <> null do
    # begin
    #     print_nl("(");
    #     print_esc("end occurred ");
    #     print("when ");
    #     print_cmd_chr(if_test, cur_if);
    #
    #     if if_line <> 0 then
    #     begin
    #         print(" on line ");
    #         print_int(if_line);
    #     end;
    #
    #     print(" was incomplete)");
    #
    #     if_line := if_line_field(cond_ptr);
    #
    #     cur_if := subtype(cond_ptr);
    #
    #     temp_ptr := cond_ptr;
    #     cond_ptr := link(cond_ptr);
    #
    #     free_node(temp_ptr, if_node_size);
    # end;
    #
    # if history <> spotless then
    #     if ((history = warning_issued) or (interaction < error_stop_mode)) then
    #         if selector = term_and_log then
    #         begin
    #             selector := term_only;
    #             print_nl("(see the transcript file for additional information)");
    #
    #             selector := term_and_log;
    #         end;
    #
    # if c = 1 then
    # begin
    #     init
    #         for c := top_mark_code to split_bot_mark_code do
    #             if cur_mark[c] <> null then delete_token_ref(cur_mark[c]);
    #
    #         store_fmt_file;
    #
    #         return;
    #     tini
    #
    #     print_nl("(\dump is performed only by INITEX)");
    #     return;
    #
    # end;

    return;
}

######################################################################
##                                                                  ##
##                  SPECIAL RECURSIVE MAIN_LOOP'S                   ##
##                                                                  ##
######################################################################

## These are used by perl code that needs to process some TeX input
## and then take control back.

sub process_file {
    my $tex = shift;

    my $file_spec = shift;
    my $fh        = shift;

    my $start_time = time();

    $tex->start_input($file_spec, $fh);

    $tex->set_eof_hook(
        sub {
            my $tex = shift;

            $tex->back_input(END_TEX_TOKEN);

            return;
        });

    $tex->main_control();

    # my $elapsed = time() - $start_time;
    # $tex->DEBUG("process_file($file_spec): $elapsed seconds\n");

    return;
}

sub process_string {
    my $tex = shift;

    my $string = shift;

    return unless defined $string;

    $tex->begin_string_reading($string);

    $tex->main_control();

    return;
}

######################################################################
##                                                                  ##
##                      ALTERNATE ENTRY POINTS                      ##
##                                                                  ##
######################################################################

## These are alternates to TeX().

## These should probably be replaced by \hbox and \boxtostring.

sub convert_token_list {
    my $tex = shift;

    my $token_list = shift;
    my $par_tags   = shift;

    if (! defined $token_list) {
        $token_list = $tex->read_undelimited_parameter();
    }

    $token_list->push(END_TEX_TOKEN); ## BLEAH: modifies caller's copy

    $tex->push_output("TeX::Output::XML::Fragment");

    $tex->begingroup();

    $tex->set_toks_list('every_par', new_token_list());

    if ($par_tags) {
        $tex->set_xml_par_tag("p");
    } else {
        $tex->set_xml_par_tag("");
    }

    ## Should we have a dedicated token_type for this?
    $tex->begin_token_list($token_list, inserted);

    $tex->set_history(spotless); # {ready to go!}

    $tex->new_graf();

    $tex->main_control();

    $tex->end_par();

    $tex->endgroup();

    $token_list->pop(); # remove END_TEX_TOKEN

    my $handle = $tex->pop_output();

    my $dom = $handle->close_document();

    return $dom;

    # return $dom->toString();
}

sub convert_fragment {
    my $tex = shift;

    my $string   = shift;
    my $par_tags = shift;

    $tex->push_output("TeX::Output::XML::Fragment");

    $tex->begingroup();

    $tex->set_toks_list('every_par', new_token_list());

    if ($par_tags) {
        $tex->set_xml_par_tag("p");
    } else {
        $tex->set_xml_par_tag("");
    }

    $tex->begin_string_reading($string);

    $tex->set_history(spotless); # {ready to go!}

    $tex->new_graf();

    $tex->main_control();

    $tex->end_par();

    $tex->endgroup();

    my $handle = $tex->pop_output();

    my $dom = $handle->close_document();

    return $dom;
}

######################################################################
##                                                                  ##
##                          [52] DEBUGGING                          ##
##                                                                  ##
######################################################################

sub debug_help {
    my $tex = shift;

#     loop begin
#         wake_up_terminal;
#         print_nl("debug # (-1 to exit):");
#         update_terminal;
#
#         read(term_in, m);
#
#         if m < 0 then
#             return
#         else if m = 0 then
#         begin
#             goto breakpoint;        {go to every label at least once}
#             breakpoint: m := 0;     @{'BREAKPOINT'@}
#         end
#         else
#         begin
#             read(term_in, n);
#
#             case m of
#                 @<Numbered cases for |debug_help|@>
#
#                 othercases print("?")
#             endcases;
#         end;
#     end;
#
#   exit:
# end;

    return;
}

######################################################################
##                                                                  ##
##                         [53] EXTENSIONS                          ##
##                                                                  ##
######################################################################

my %write_file_of :ARRAY(:name<write_file>);
my %write_open_of :ARRAY(:name<write_open> :get<__get_write_open> :default_value<false>);
my %write_path_of :ARRAY(:name<write_path>);

sub get_write_open {
    my $tex = shift;

    my $fileno = shift;

    return if $fileno < 0;

    return $tex->__get_write_open($fileno);
}

sub do_file_output {
    my $tex = shift;

    my $node = shift;

    my $fileno = $node->fileno();

    if (eval { $node->is_write_node() }) {
        $tex->write_out($node);

        return;
    }

    if ($tex->get_write_open($fileno)) {
        close($tex->get_write_file($fileno));
    }

    if (eval { $node->is_close_node() }) {
        $tex->set_write_open($fileno, false);
        $tex->set_write_file($fileno, undef);
        $tex->set_write_path($fileno, undef);
    }
    elsif ($fileno < 16) {
        my $file_name = $node->get_filename();

        my $mode = $tex->is_unicode_input() ? ">:utf8" : ">";

        if (! (my $fh = $tex->a_open_out($file_name))) {
            $tex->print_nl("I can't open file `$file_name' for writing");
            $tex->error();
        } else {
            $tex->set_write_file($fileno, $fh);
            $tex->set_write_open($fileno, true);
            $tex->set_write_path($fileno, $file_name);
        }
    }

    return;
}

sub write_out {
    my $tex = shift;

    my $node = shift;

    my $old_setting = $tex->selector();

    my $fileno = $node->fileno();

    ## Note that the token list has to be expanded *before* the
    ## selector is adjusted in case the expansion causes output (for
    ## example, if \tracingmacros is non-zero).

    my $token_list = $node->get_token_list();

    my $expanded = $tex->expand_token_list($token_list);

    if ($tex->get_write_open($fileno)) {
        $tex->set_selector($fileno);
    } else {
        if ( $fileno == 17 && $old_setting == term_and_log) {
            $tex->set_selector(log_only);
        }

        $tex->print_nl("");
    }

    $tex->token_show($expanded);

    $tex->print_ln();

    $tex->set_selector($old_setting);

    return;
}

sub finish_extensions {
    my $tex = shift;

    # ACK
    for my $fileno (0..15) {
        if ($tex->get_write_open($fileno)) {
            close($tex->get_write_file($fileno));
        }
    }

    return;
}

######################################################################
##                                                                  ##
##                      [53A] ETEX EXTENSIONS                       ##
##                                                                  ##
######################################################################

sub print_group {
    my $tex = shift;

    my $leaving    = shift;
    my $group_type = shift;
    my $line_no    = shift;

    $tex->print(group_type($group_type));

    return if $group_type == bottom_level;

    my $cur_level = $tex->cur_level();

    $tex->print(" group (level $cur_level)");

    if ($line_no > 0) {
        if ($leaving) {
            $tex->print(" entered at line ");
        } else {
            $tex->print(" at line ");
        }

        $tex->print_int($line_no);
    }

    return;
}

sub group_trace {
    my $tex = shift;

    my $leaving    = shift;
    my $group_type = shift;
    my $line_no    = shift;

    $tex->begin_diagnostic();

    $tex->print_char("{");

    if ($leaving) {
        $tex->print("leaving ");
    } else {
        $tex->print("entering ");
    }

    $tex->print_group($leaving, $group_type, $line_no);

    $tex->print_char("}");

    $tex->end_diagnostic(false);

    return;
}

sub scan_general_text {
    my $tex = shift;

    return $tex->scan_toks(false, false);
}

sub scan_pdf_ext_toks {
    my $tex = shift;

    return $tex->scan_toks(false, true);
}

######################################################################
##                                                                  ##
##                     MISCELLANEOUS EXTENSIONS                     ##
##                                                                  ##
######################################################################

my @EXTENSIONS = qw(leavevmode UCSchar UCSchardef ifMathJaxMacro TeXMLrowspan TeXMLtoprow);

sub load_extension( $;$ ) {
    my $tex = shift;

    my $name  = shift;
    my $class = shift;

    return $tex->load_primitive($name, $class);
}

sub install_misc_extensions {
    my $tex = shift;

    for my $extension (@EXTENSIONS) {
        $tex->define_csname($extension => $tex->load_extension($extension));
    }

    return;
}

######################################################################
##                                                                  ##
##                          XML EXTENSIONS                          ##
##                                                                  ##
######################################################################

my %xml_tag_parameters_of :HASH(:name<xml_tag_parameter>);

my %xml_stack_of :ARRAY(:name<xml_stack>);

sub __list_xml_extensions {
    my $tex = shift;

    return qw(addCSSrule
              setColumnCSSproperty
              setRowCSSproperty
              setCSSproperty
              addXMLclass
              addXMLcomment
              deleteXMLclass
              endXMLelement
              ifinXMLelement
              importXMLfragment
              setXMLattribute setXMLclass setXMLdoctype setXMLroot
              setXSLfile
              startXMLelement);
}

sub install_xml_extensions {
    my $tex = shift;

    for my $extension ($tex->__list_xml_extensions()) {
        $tex->define_csname($extension => $tex->load_extension($extension));
    }

    return;
}

sub __list_xml_tag_parameters {
    my $tex = shift;

    my @params = qw(this_xml_par_class this_xml_par_tag xml_par_tag
                    xml_table_tag xml_table_col_tag xml_table_row_tag
                    inline_math_tag display_math_tag tex_math_tag);

    # This isn't an XML tag, but pretending it is means we don't have
    # to invent a new category for it.  Alternatively, we could rename
    # the xml_tag_val to something else, like string_tag_val.

    push @params, qw(TeXML_SVG_dir);

    return @params;
}

sub __init_xml_tag_parameters {
    my $tex = shift;

    my $ident = ident $tex;

    my %xml_tag_param;

    foreach my $param ($tex->__list_xml_tag_parameters()) {
        $xml_tag_param{$param} = make_eqvt(0, level_one);

        (my $csname = $param) =~ s/_//g;

        my $param = make_xml_tag_parameter($csname, \$xml_tag_param{$param});

        $tex->set_primitive($csname => $param);
        $tex->define_csname($csname => $param);
    }

    $xml_tag_parameters_of{$ident} = \%xml_tag_param;

    $tex->set_xml_par_tag("p");
    $tex->set_this_xml_par_tag("");
    $tex->set_this_xml_par_class("");

    $tex->set_xml_table_tag("table");
    $tex->set_xml_table_row_tag("tr");
    $tex->set_xml_table_col_tag("td");

    $tex->set_inline_math_tag('inline-formula');
    $tex->set_display_math_tag('disp-formula');
    $tex->set_tex_math_tag('tex-math');

    $tex->set_TeXML_SVG_dir("Images");

    return;
}

sub start_xml_element {
    my $tex = shift;

    my $qName = shift;
    my $atts  = shift;

    $tex->push_xml_stack($qName);

    $tex->tail_append(new_xml_open_node($qName, $atts));

    return;
}

sub end_xml_element {
    my $tex = shift;

    my $qName = shift;

    $tex->tail_append(new_xml_close_node($qName));

    my $popped_qName = $tex->pop_xml_stack();

    if ($popped_qName ne $qName) {
        $tex->print_err("Expected </$popped_qName> but got </$qName>");

        $tex->set_help("You're on your own");

        $tex->error();
    }

    return;
}

sub set_xml_attribute {
    my $tex = shift;

    my $qName  = shift;
    my $value = shift;

    $tex->tail_append(new_xml_attribute_node($qName, $value));

    return;
}

sub set_css_property {
    my $tex = shift;

    my $property = shift;
    my $value    = shift;

    $tex->tail_append(new_css_property_node($property, $value));

    return;
}

sub set_row_css_property {
    my $tex = shift;

    my $property = shift;
    my $value    = shift;

    return if empty($property);

    my $align = $tex->get_cur_alignment();

    if (empty($value)) {
        $align->delete_row_property($property);
    } else {
        $align->set_row_property($property, $value);
    }

    return;
}

sub set_column_css_property {
    my $tex = shift;

    my $col_no   = shift;
    my $property = shift;
    my $value    = shift;

    return if empty($property);

    my $align = $tex->get_cur_alignment();

    $align->set_column_property($col_no, $property, $value);

    return;
}

sub add_xml_comment {
    my $tex = shift;

    my $comment = shift;

    $tex->tail_append(TeX::Node::XmlComment->new({ comment => $comment }));

    return;
}

sub modify_xml_class {
    my $tex = shift;

    my $opcode = shift;
    my $value  = shift;

    $tex->tail_append(make_xml_class_node($opcode, $value));

    return;
}

sub import_xml_fragment {
    my $tex = shift;

    my $xml_file = shift;
    my $xpath    = shift;

    $tex->tail_append(TeX::Node::XmlImportNode->new({ xml_file => $xml_file,
                                                      xpath    => $xpath,
                                                   }));

    return;
}

######################################################################
##                                                                  ##
##                          CSS EXTENSIONS                          ##
##                                                                  ##
######################################################################

my %css_rules_of :ARRAY(:name<css_rule>);

my %css_classes_of   :HASH(:name<css_class> :gethash<get_css_classes> :sethash<set_css_classes>);

my %css_class_ctr_of :HASH(:name<css_class_ctr>);

sub __make_class_name :PRIVATE {
    my $tex = shift;

    my $ident = ident $tex;

    my $property = shift;
    my $value    = shift;

    my $prefix = join "", map { substr($_, 0, 1) } split /-/, $property;

    if ($value =~ m{^[a-z]}i) {
        $prefix .= join "", map { substr($_, 0, 1) } split / /, $value;
    }

    $css_class_ctr_of{$ident}->{$prefix} ||= 0;

    my $gen = $css_class_ctr_of{$ident}->{$prefix}++;

    $gen = "" if $gen == 0;

    my $css_class = "${prefix}${gen}";

    return "texml-$css_class";
}

sub find_css_class {
    my $tex = shift;

    my $property = shift;
    my $value    = shift;

    my $key = qq{${property}: $value};

    my $css_class = $tex->get_css_class($key);

    return $css_class if nonempty($css_class);

    $css_class = $tex->__make_class_name($property, $value);

    $tex->add_css_rule([ ".$css_class", $key ]);

    $tex->set_css_class($key, $css_class);

    return $css_class;
}

######################################################################
##                                                                  ##
##                           DEFINITIONS                            ##
##                                                                  ##
######################################################################

sub define_csname {
    my $tex = shift;

    my $csname   = shift;
    my $command  = shift;
    my $modifier = shift;

    $tex->eq_define(\$csnames_of{ident $tex}->{$csname}, $command, $modifier);

    return;
}

sub let_csname {
    my $tex = shift;

    my $dst_csname = shift;
    my $src_csname = shift;

    my $modifier = shift;

    my $eqvt = $tex->get_csname($src_csname);

    my $equiv;

    if (defined $eqvt) {
        $equiv = $eqvt->get_equiv();
    } else {
        $equiv = UNDEFINED_CS;
    }

    my $eqvt_ptr = \$csnames_of{ident $tex}->{$dst_csname};

    $tex->eq_define($eqvt_ptr, $equiv, $modifier);

    return;
}

sub define_pseudo_macro {
    my $tex = shift;

    my $csname   = shift;
    my $code     = shift;
    my $modifier = shift;

    $tex->define_csname($csname, make_anonymous_macro($code), $modifier);

    return;
}

sub define_active_char {
    my $tex = shift;

    my $char     = shift;
    my $command  = shift;
    my $modifier = shift;

    $tex->eq_define(\$active_chars_of{ident $tex}->{$char}, $command, $modifier);

    return;
}

sub define_macro {
    my $tex = shift;

    my $csname    = shift;
    my $raw_param = shift;
    my $raw_macro = shift;
    my $modifier  = shift || 0;

    my $r_token;

    if (ref($csname)) {
        if ($csname->isa("TeX::Token")) {
            if ($csname == CATCODE_CSNAME || $csname == CATCODE_ACTIVE) {
                $r_token = $csname;
            };
        }

        if (! defined $r_token) {
            $tex->print_err("define_macro: Can't define '$csname'");
            $tex->error();
        }
    } else {
        $r_token = make_csname_token($csname);
    }

    my $param_text = EMPTY_TOKEN_LIST; # $tex->tokenize($raw_param);

    if (nonempty($raw_param)) {
        $tex->print_err("define_macro: Parameter text not supported yet");

        $tex->error();
    }

    my $macro_text = $tex->tokenize($raw_macro);

    my $macro =
        TeX::Primitive::Macro->new({ parameter_text   => $param_text,
                                     replacement_text => $macro_text,
                                     outer => $modifier & MODIFIER_OUTER,
                                     long  => $modifier & MODIFIER_LONG,
                                   });

    $tex->define($r_token, $macro, $modifier);

    return;
}

sub define_simple_macro {
    my $tex = shift;

    my $csname    = shift;
    my $raw_macro = shift;
    my $modifier  = shift;

    $tex->define_macro($csname, "", $raw_macro, $modifier);

    return;
}

sub get_meaning {
    my $tex = shift;

    my $token = shift;

    my $catcode = $token->get_catcode();

    my $datum = $token->get_datum();

    if ($catcode == CATCODE_ANONYMOUS) {
        return $datum;
    }

    my $eqvt;

    if ($catcode == CATCODE_ACTIVE) {
        $eqvt = $tex->get_active_char($datum);
    } elsif ($catcode == CATCODE_CSNAME) {
        $eqvt = $tex->get_csname($datum);
    } else {
        return $token;
    }

    return unless defined $eqvt;

    return $eqvt->get_equiv();
}

sub get_expandable_meaning {
    my $tex = shift;

    my $token = shift;

    my $cur_cmd = $tex->get_meaning($token);

    return $cur_cmd if eval { $cur_cmd->isa('TeX::Command::Expandable') };

    return;
}

sub get_macro_expansion_text {
    my $tex = shift;

    my $csname = shift;

    $csname = $csname->get_csname() if eval { $csname->isa("TeX::Token") };

    my $eqvt = $tex->get_csname($csname);

    return unless defined $eqvt;

    my $meaning = $eqvt->get_equiv();

    return unless eval { $meaning->isa("TeX::Primitive::Macro") };

    return $meaning->get_replacement_text();
}

sub expansion_of {
    my $tex = shift;

    my $csname = shift;

    return $tex->get_macro_expansion_text($csname);
}

sub is_defined {
    my $tex = shift;

    my $token = shift;

    return unless $token->is_definable();

    my $meaning = $tex->get_meaning($token);

    return unless defined $meaning;

    return ident($meaning) != ident(UNDEFINED_CS);
}

######################################################################
##                                                                  ##
##                            REGISTERS                             ##
##                                                                  ##
######################################################################

sub set_encoding {
    my $tex = shift;

    my $new_encoding = shift;

    $tex->eq_define(\$cur_enc_of{ident $tex}, $new_encoding);

    return;
}

sub get_encoding {
    my $tex = shift;

    my $eqvt = $cur_enc_of{ident $tex};

    return $eqvt->get_equiv()->get_value();
}

sub find_box_register {
    my $tex = shift;

    my $index = shift;

    my $registers = $box_registers_of{ident $tex};

    if (! exists $registers->{$index}) {
        $registers->{$index} = make_eqvt(undef, level_one);
    }

    return \$registers->{$index};
}

sub find_count_register {
    my $tex = shift;

    my $index = shift;

    my $registers = $count_registers_of{ident $tex};

    if (! exists $registers->{$index}) {
        $registers->{$index} = make_eqvt(0, level_one);
    }

    return \$registers->{$index};
}

sub find_dimen_register {
    my $tex = shift;

    my $index = shift;

    my $registers = $dimen_registers_of{ident $tex};

    if (! exists $registers->{$index}) {
        $registers->{$index} = make_eqvt(0, level_one);
    }

    return \$registers->{$index};
}

sub find_muskip_register {
    my $tex = shift;

    my $index = shift;

    my $registers = $muskip_registers_of{ident $tex};

    if (! exists $registers->{$index}) {
        $registers->{$index} = make_eqvt(0, level_one);
    }

    return \$registers->{$index};
}

sub find_skip_register {
    my $tex = shift;

    my $index = shift;

    my $registers = $skip_registers_of{ident $tex};

    if (! exists $registers->{$index}) {
        my $glue = TeX::Type::GlueSpec->new();

        $registers->{$index} = make_eqvt($glue, level_one);
    }

    return \$registers->{$index};
}

sub find_toks_register {
    my $tex = shift;

    my $index = shift;

    my $registers = $toks_registers_of{ident $tex};

    if (! exists $registers->{$index}) {
        $registers->{$index} = make_eqvt(new_token_list(), level_one);
    }

    return \$registers->{$index};
}

######################################################################
##                                                                  ##
##                              MODES                               ##
##                                                                  ##
######################################################################

sub is_inner {
    my $tex = shift;

    return $tex->get_cur_mode() < 0;
}

sub is_vmode {
    my $tex = shift;

    return abs($tex->get_cur_mode()) == vmode;
}

sub is_hmode {
    my $tex = shift;

    return abs($tex->get_cur_mode()) == hmode;
}

sub is_mmode {
    my $tex = shift;

    return abs($tex->get_cur_mode()) == mmode;
}

######################################################################
##                                                                  ##
##                         CHARACTER CODES                          ##
##                  cat, lc, uc, tc, sf, math, del                  ##
##                                                                  ##
######################################################################

sub get_character_code {
    my $tex = shift;

    my $table = shift;

    my $char_code = shift;

    my $code = $table->{$char_code};

    # get_sfcode() is called for every output character, but timing
    # tests suggest that this test has negligible affect on the
    # running time.

    if (! defined $code) {
        $tex->initialize_char_codes($char_code);

        $code = $table->{$char_code};
    }

    return $code->get_equiv()->get_value();
}

sub set_character_code {
    my $tex = shift;

    my $table = shift;

    my $char_code = shift;
    my $new_code  = shift;
    my $modifier  = shift;

    if (! defined $table->{$char_code}) {
        $tex->initialize_char_codes($char_code);
    }

    my $eqvt_ptr = \$table->{$char_code};

    $tex->eq_define($eqvt_ptr, $new_code, $modifier);

    return;
}

## NB: These accessors assume that they are passed valid values.
## Checking for invalid codes is done by the implementation of the
## corresponding primitives.

sub get_catcode {
    my $tex = shift;

    my $char_code = shift;

    my $table = $cat_codes_of{ident $tex};

    return $tex->get_character_code($table, $char_code);
}

sub set_catcode {
    my $tex = shift;

    my $char_code = shift;
    my $cat_code  = shift;
    my $modifier  = shift;

    my $table = $cat_codes_of{ident $tex};

    return $tex->set_character_code($table, $char_code, $cat_code, $modifier);
}

sub get_lccode {
    my $tex = shift;

    my $char_code = shift;

    my $table = $lc_codes_of{ident $tex};

    return $tex->get_character_code($table, $char_code);
}

sub set_lccode {
    my $tex = shift;

    my $char_code = shift;
    my $lc_code   = shift;
    my $modifier  = shift;

    my $table = $lc_codes_of{ident $tex};

    $tex->set_character_code($table, $char_code, $lc_code, $modifier);

    return;
}

sub get_uccode {
    my $tex = shift;

    my $char_code = shift;

    my $table = $uc_codes_of{ident $tex};

    return $tex->get_character_code($table, $char_code);
}

sub set_uccode {
    my $tex = shift;

    my $char_code = shift;
    my $uc_code   = shift;
    my $modifier  = shift;

    my $table = $uc_codes_of{ident $tex};

    return $tex->set_character_code($table, $char_code, $uc_code, $modifier);
}

sub get_tccode {
    my $tex = shift;

    my $char_code = shift;

    my $table = $tc_codes_of{ident $tex};

    return $tex->get_character_code($table, $char_code);
}

sub set_tccode {
    my $tex = shift;

    my $char_code = shift;
    my $tc_code   = shift;
    my $modifier  = shift;

    my $table = $tc_codes_of{ident $tex};

    return $tex->set_character_code($table, $char_code, $tc_code, $modifier);
}

sub get_sfcode {
    my $tex = shift;

    my $char_code = shift;

    my $table = $sf_codes_of{ident $tex};

    return $tex->get_character_code($table, $char_code);
}

sub set_sfcode {
    my $tex = shift;

    my $char_code = shift;
    my $sf_code   = shift;
    my $modifier  = shift;

    my $table = $sf_codes_of{ident $tex};

    return $tex->set_character_code($table, $char_code, $sf_code, $modifier);
}

sub get_mathcode {
    my $tex = shift;

    my $char_code = shift;

    my $table = $math_codes_of{ident $tex};

    return $tex->get_character_code($table, $char_code);
}

sub set_mathcode {
    my $tex = shift;

    my $char_code = shift;
    my $math_code = shift;
    my $modifier  = shift;

    my $table = $math_codes_of{ident $tex};

    return $tex->set_character_code($table, $char_code, $math_code, $modifier);
}

sub get_delcode {
    my $tex = shift;

    my $char_code = shift;

    my $table = $del_codes_of{ident $tex};

    return $tex->get_character_code($table, $char_code);
}

sub set_delcode {
    my $tex = shift;

    my $char_code = shift;
    my $del_code  = shift;
    my $modifier  = shift;

    my $table = $del_codes_of{ident $tex};

    return $tex->set_character_code($table, $char_code, $del_code, $modifier);
}

######################################################################
##                                                                  ##
##                          NODE REGISTERS                          ##
##                                                                  ##
######################################################################

sub set_node_register {
    my $tex = shift;

    my $type = shift;
    my $node = shift;

    my $ident = ident $tex;

    if (! exists $node_registers_of{$ident}->{$type}) {
        $tex->print_err("set_node_register: Unknown node register '$type'");

        $tex->set_help("I'm going to ignore this.");

        $tex->error();

        return;
    }

    if (! $node->isa("TeX::Node::AbstractNode")) {
        $tex->print_err("set_node_register: Not a node: '$node'");

        $tex->set_help("I'm going to ignore this.");

        $tex->error();

        return;
    }

    $tex->eq_define(\$node_registers_of{$ident}->{$type}, $node);

    return;
}

sub get_node_register {
    my $tex = shift;

    my $name = shift;

    my $ident = ident $tex;

    if (exists $node_registers_of{$ident}->{$name}) {
        my $eqvt = $node_registers_of{$ident}->{$name};

        my $node_r = $eqvt->get_equiv();

        return unless defined $node_r;

        return if eval { $node_r->isa("TeX::Primitive::undefined") };

        return $node_r; # ->get_value(); # NEED TO RETURN CLONE?
    }

    $tex->print_err("get_node_register: Unknown node register '$name'");

    $tex->set_help("I'm going to ignore this.");

    $tex->error();

    return;
}

######################################################################
##                                                                  ##
##                     MISCELLANEOUS EXTENSIONS                     ##
##                                                                  ##
######################################################################

sub get_current_nodes {
    my $tex = shift;

    return $tex->get_cur_list()->get_nodes();
}

sub end_par {
    my $tex = shift;

    if ($tex->is_vmode()) {
        $tex->normal_paragraph();

        if ($tex->get_cur_mode() > 0) {
            $tex->build_page();
        }
    } elsif ($tex->is_hmode()) {
        # if align_state < ALIGN_COLUMN_BOUNDARY then off_save;
        # {this tries to recover from an alignment that didn't end properly}

        $tex->end_graf();

        if ($tex->is_vmode()) {
            $tex->build_page();
        }
    } elsif ($tex->is_mmode()) {
        $tex->error("Missing \$ inserted");
        $tex->back_input(MATH_SHIFT_TOKEN);
    } else {
        $tex->confusion("No mode!");
    }

    return;
}

sub begingroup {
    my $tex = shift;

    $tex->new_save_level(semi_simple_group);

    return;
}

sub endgroup {
    my $tex = shift;

    my $cur_group = $tex->cur_group();

    if ($cur_group == semi_simple_group) {
        $tex->unsave();
    } else {
        $tex->off_save(undef, "endgroup (cur_group = " . group_type($cur_group) . ")");
    }

    return;
}

# ## TODO: Compare with @<Expand macros in the token list and...@> and
# ## see what else is needed

sub expand_token_list {
    my $tex = shift;

    my $token_list = shift;

    my $end = new_token_list();

    $end->push(END_GROUP);
    $end->push(END_WRITE_TOKEN);

    $tex->ins_list($end);

    $tex->begin_token_list($token_list, write_text);

    my $start = new_token_list();

    $start->push(BEGIN_GROUP);

    $tex->ins_list($start);

    # now we're ready to scan `{<token list>} \endwrite'

    my $old_mode = $tex->get_cur_mode();

    $tex->set_cur_mode(0);

    # {disable \.{\\prevdepth}, \.{\\spacefactor}, \.{\\lastskip}, \.{\\prevgraf}}

    # cur_cs := write_loc;

    my $expanded = $tex->scan_toks(false, true); # {expand macros, etc.}

    my $cur_tok = $tex->get_next();

    if (ident($cur_tok) != ident(END_WRITE_TOKEN)) {
        $tex->print_err("Unbalanced write command");

        $tex->set_help("On this page there's a \\write with fewer real {'s than }'s.",
                       "I can't handle that very well; good luck.");

        $tex->error();

        do {
            $cur_tok = $tex->get_next;
        } until $cur_tok == END_WRITE_TOKEN;
    }

    $tex->set_cur_mode($old_mode);

    $tex->end_token_list(); # {conserve stack space}

    return $expanded;
}

######################################################################
##                                                                  ##
##                          LATEX SUPPORT                           ##
##                                                                  ##
######################################################################

## Why isn't this in TeX::Interpreter::LaTeX?

######################################################################
##                                                                  ##
##                          SVG GENERATION                          ##
##                                                                  ##
######################################################################

my %do_svg_of :BOOLEAN(:name<do_svg> :default<1>);

my %use_xetex_of :BOOLEAN(:name<use_xetex> :default<0>);

my %svg_agent_of :ATTR(:name<svg_agent>);

sub __list_svg_extensions {
    my $tex = shift;

    return qw(TeXMLGenerateSVG);
}

sub install_svg_extensions {
    my $tex = shift;

    for my $extension ($tex->__list_svg_extensions()) {
        $tex->define_csname($extension => $tex->load_extension($extension));
    }

    for my $ext (qw(TeXMLlastSVGfile TeXMLlastSVGwidth TeXMLlastSVGheight)) {
        $tex->define_simple_macro($ext => "");
    }

    return;
}

######################################################################
##                                                                  ##
##                   DYNAMIC PERL MODULE LOADING                    ##
##                                                                  ##
######################################################################

my %module_list_of :HASH(:name<module_list>);

sub load_module { # Used by load_fmt() and do_load_if_module_exists()
    my $tex = shift;

    my $module = shift;

    (my $module_file = $module) =~ s{::}{/}g;

    $module_file .= ".pm";

    if (exists $INC{$module_file}) {
        return $INC{$module_file} ? ALREADY_LOADED : LOAD_FAILED;
    }

    eval { require $module_file };

    if ($@) {
        if ($@ !~ m/^Can\'t locate \Q$module_file\E/) {
            $tex->fatal_error($@);
        }

        return LOAD_FAILED;
    }

    return LOAD_SUCCESS;
}

sub load_format {
    my $tex = shift;

    my $fmt = shift;

    my $class = __PACKAGE__ . "::FMT::$fmt";

    my $start_time = time();

    my $status = $tex->load_module($class);

    if ($status) {
        eval { $class->install($tex) };

        if ($@) {
            $tex->fatal_error("Can't install macro class $class: $@");
        }

        if ($tex->is_profiling()) {
            my $elapsed = time() - $start_time;
            $tex->__DEBUG("$class->install(): $elapsed seconds\n");
        }
     } else {
        $tex->fatal_error("Can't load format '$fmt'");
    }

    return;
}

sub read_package_data( $ ) {
    my $tex = shift;

    my $package = caller;

    my $stash = eval { no strict 'refs'; *{ "${package}::" } };

    my $data_handle = *{ $stash->{DATA} }{IO};

    my $position = tell($data_handle);

    my $at_cat = $tex->get_catcode(ord('@'));

    $tex->set_catcode(ord('@'), CATCODE_LETTER);

    $tex->process_file($package, $data_handle);

    $tex->set_catcode(ord('@'), $at_cat);

    seek($data_handle, $position, SEEK_SET);

    return;
}

######################################################################
##                                                                  ##
##                      LOADING LATEX MODULES                       ##
##                                                                  ##
######################################################################

# sub core_load_notification {
#     my $tex = shift;
#
#     my $name    = shift;
#     my @options = @_;
#
#     # $name =~ s{^.*::}{};
#
#     # $tex->print_nl("Loading core macros '$name'");
#
#     # if (@options) {
#     #     $tex->print(" with options @options");
#     # }
#
#     # $tex->print_ln();
#
#     return;
# }

sub class_load_notification {
    my $tex = shift;

    my $class_name = caller;
    my @options    = @_;

    # $class_name =~ s{^.*::}{};
    #
    # $tex->print_nl("Loading document class '$class_name'");
    #
    # if (@options) {
    #     $tex->print(" with options @options");
    # }
    #
    # $tex->print_ln();

    return;
}

sub package_load_notification {
    my $tex = shift;

    my $package_name = caller;

    $package_name =~ s{^.*::}{};

    $tex->print_nl("Loading package '$package_name'");

    $tex->print_ln();

    return;
}

######################################################################
##                                                                  ##
##                         AUTOMETHOD MAGIC                         ##
##                                                                  ##
######################################################################

## For each integer parameter, dimen parameter and glue parameter
## "FOO", we define methods
##
##     set_FOO() to write FOO
##
## and
##
##     FOO() to read FOO
##
## Currently the set_* methods do no type checking.  That should be fixed.

sub AUTOMETHOD {
    my ($tex, $ident, @args) = @_;

    my $subname = $_;   # Requested subroutine name is passed via $_

    if ($subname =~ s/^set_//) {
        if (defined(my $eqvt = $tex->get_special_integer($subname))) {
            return sub {
                $eqvt->set_value($args[0]);
            };
        }

        if (defined(my $eqvt = $tex->get_special_dimen($subname))) {
            return sub {
                $eqvt->set_value($args[0]);
            };
        }

        if (exists $integer_parameters_of{$ident}->{$subname}) {
            return sub {
                my $eqvt_ptr = \$integer_parameters_of{$ident}->{$subname};

                $tex->eq_define($eqvt_ptr, $args[0], $args[1]);
            };
        }

        if (exists $dimen_parameters_of{$ident}->{$subname}) {
            return sub {
                my $eqvt_ptr = \$dimen_parameters_of{$ident}->{$subname};

                $tex->eq_define($eqvt_ptr, $args[0], $args[1]);
            };
        }

        if (exists $glue_parameters_of{$ident}->{$subname}) {
            return sub {
                my $eqvt_ptr = \$glue_parameters_of{$ident}->{$subname};

                $tex->eq_define($eqvt_ptr, $args[0], $args[1]);
            };
        }

        if (exists $xml_tag_parameters_of{$ident}->{$subname}) {
            return sub {
                my $eqvt_ptr = \$xml_tag_parameters_of{$ident}->{$subname};

                $tex->eq_define($eqvt_ptr, $args[0], $args[1]);
            };
        }
    } else {
        if (defined(my $eqvt = $tex->get_special_integer($subname))) {
            return sub {
                return $eqvt->get_value();
            };
        }

        if (defined(my $eqvt = $tex->get_special_dimen($subname))) {
            return sub {
                return $eqvt->get_value();
            };
        }

        if (defined(my $eqvt = $tex->get_integer_parameter($subname))) {
            return sub {
                return $eqvt->get_equiv()->get_value();
            };
        }

        if (defined (my $eqvt = $tex->get_dimen_parameter($subname))) {
            return sub {
                return $eqvt->get_equiv()->get_value();
            };
        }

        if (defined (my $eqvt = $tex->get_glue_parameter($subname))) {
            return sub {
                return $eqvt->get_equiv()->get_value();
            };
        }

        if (defined (my $eqvt = $tex->get_xml_tag_parameter($subname))) {
            return sub {
                my $equiv = $eqvt->get_equiv();

                if (defined $equiv) {
                    return $equiv->get_value();
                }

                return;
            };
        }
    }

    if (defined(my $eqvt = $tex->get_csname($subname))) {
        return sub {
            make_anonymous_token($eqvt);
        };
    }

    return;
}

1;

__END__
#     /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#      * XML initialization
#      *
#      * These should really be disabled when nts.output.format != xml
#      */
#
#     private final XmlStringParam
#         xml_par_tag   = new XmlStringParam("XMLpartag", XML.DEFAULT_PAR_TAG),
#         xml_table_tag = new XmlStringParam("XMLtabletag", XML.DEFAULT_TABLE_TAG),
#         xml_row_tag   = new XmlStringParam("XMLrowtag", XML.DEFAULT_ROW_TAG),
#         xml_cell_tag  = new XmlStringParam("XMLcelltag", XML.DEFAULT_CELL_TAG),
#         xml_encoding  = new XmlPrologParam("XMLencoding", XML.DEFAULT_ENCODING),
#         xml_namespace = new XmlPrologParam("XMLnamespace");
#
#     private XmlOpenPrim  xml_open_prim  = new XmlOpenPrim("startXMLelement");
#     private XmlClosePrim xml_close_prim = new XmlClosePrim("endXMLelement");
#
#     public void startXMLelement(Builder bld, String qName) {
#         xml_open_prim.exec(bld, qName);
#     }
#
#     public void endXMLelement(Builder bld, String qName) {
#         xml_close_prim.exec(bld, qName);
#     }
#
#     {
#       debugMessage("Primitives.<init(9)>");
#
#         def(new IfXMLPrim("ifXMLoutput"));
#
#         def(new XmlDocTypePrim("XMLdoctype"));
#         def(xml_encoding);
#         def(xml_par_tag);
#         def(xml_table_tag);
#         def(xml_row_tag);
#         def(xml_cell_tag);
#         def(xml_namespace);
#
#         def(xml_open_prim);
#         def(xml_close_prim);
#         def(new XmlAttributePrim("addXMLattribute"));
#
#         def(new XmlStartCDATAPrim("startXMLcdata"));
#         def(new XmlEndCDATAPrim("endXMLcdata"));
#
#         def(new XmlCommentPrim("XMLcomment"));
#         def(new XmlDeclarationPrim("XMLdeclaration"));
#         def(new XmlPIPrim("XMLpi"));
#         def(new XmlReferencePrim("XMLreference"));
#     }
