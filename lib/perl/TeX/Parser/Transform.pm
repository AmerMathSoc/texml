package TeX::Parser::Transform;

use strict;
use warnings;

use version; our $VERSION = qv '0.15.0';

use PTG::Class;

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %parser_class_of :ATTR(:name<parser_class> :type <TeX::Parser> :default<"TeX::Parser::LaTeX">);

my %source_file_of   :ATTR(:name<source_file>);

my %output_file_of   :ATTR(:name<output_file>);
my %output_line_of   :COUNTER(:name<output_line> :default<1>);

my %parser_of    :ATTR(:name<parser>    :type<TeX::Parser>);
my %tokenizer_of :ATTR(:name<tokenizer> :type<TeX::Parser>);

my %fh_out_of   :ATTR(:name<fh_out>);

## Depth of \input nesting.

my %depth_of    :COUNTER(:name<depth>);

my %in_comment  :BOOLEAN(:name<in_comment>);
my %in_math     :BOOLEAN(:name<in_math>);
my %in_display  :BOOLEAN(:name<in_display>);
my %blank_line  :BOOLEAN(:name<blank_line> :default<1>);
my %in_preamble :BOOLEAN(:name<in_preamble> :get<in_preamble> :default<1>);

my %gobbling    :BOOLEAN(:name<gobbling> :get<gobbling> :default<0>);

my %num_eols_of :COUNTER(:name<num_eols> :default<0>);

my %prefix_of         :ATTR(:name<prefix>);
my %comment_prefix_of :ATTR(:name<comment_prefix>);

my %deferred_of :ATTR(:name<deferred> :type<TeX::Token>);
my %prev_of     :ATTR(:name<prev>     :type<TeX::Token>);

my %properties_of :HASH(:name<property>);

######################################################################
##                                                                  ##
##                             IMPORTS                              ##
##                                                                  ##
######################################################################

use Carp;

use PTG::Utils::String qw(trim);

use TeX::Token qw(:factories :constants);

use TeX::Token::Constants qw(:all);

use TeX::WEB2C qw(:catcodes);

######################################################################
##                                                                  ##
##                        PACKAGE CONSTANTS                         ##
##                                                                  ##
######################################################################

## Assume that line endings in the file have already been normalized
## to standard Unix line feeds.

use constant LINE_FEED => "\n";

use constant EOL => make_character_token(LINE_FEED, CATCODE_END_OF_LINE);

use constant DEFAULT_COMMENT_PREFIX => make_comment_token("%* ");

use constant MAX_EOLS => 2;

######################################################################
##                                                                  ##
##                           CONSTRUCTORS                           ##
##                                                                  ##
######################################################################

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my $comment_prefix = exists $arg_ref->{comment_prefix} ? $arg_ref->{comment_prefix}
                                                           : "%* ";

    $self->set_comment_prefix(make_comment_token($comment_prefix, UNIQUE_TOKEN));
    return;
}

sub START {
    my ($self, $ident, $arg_ref) = @_;

    my $source_file = $self->get_source_file();

    my $parser_class = $self->get_parser_class();

    ## Note use of Unix's LF for line endings rather than TeX's
    ## default CR.

    unless (eval "require $parser_class") {
        croak "Can't load parser $parser_class";
    }

    my $tokenizer = $parser_class->new({
        end_line_char    => -1, # ord(LINE_FEED),
        verbatim_eol     => 1,
        verbatim_comment => 1,
        verbatim_space   => 1,
                                       });

    $self->set_tokenizer($tokenizer);

    my $parser = $parser_class->new({ source_file      => $source_file,
                                      end_line_char    => ord(LINE_FEED),
                                      verbatim_eol     => 1,
                                      verbatim_comment => 1,
                                      verbatim_space   => 1,
                                      filtering        => 0
                                    });

    $parser->delete_handler('begin');
    $parser->delete_handler('end');

    $parser->set_handler(begin => make_begin_handler($self));

    $parser->set_handler(makeatletter => make_makeatletter_handler($self));
    $parser->set_handler(makeatother  => make_makeatother_handler($self));

    $self->set_parser($parser);

    my $out_file = $arg_ref->{output_file};

    unless (defined $out_file && $out_file =~ m{\S}) {
        croak "Can't create a ", __PACKAGE__, " without an output file";
    }

    open(my $fh, ">", $out_file) or croak "Can't open '$out_file': $!\n";

    $self->set_fh_out($fh);

    ## Turn off ^^ shortcut and hope the author hasn't done anything
    ## too clever.

    $parser->set_catcode(ord('^'), CATCODE_OTHER);

    ## Similarly, treat CR as a regular character instead of an
    ## end-of-line.

    $parser->set_catcode(ord("\r"), CATCODE_OTHER);

    ## We could OTHERize most other special characters, but it
    ## shouldn't matter.

    $parser->set_default_handler(make_default_handler($self));

    return;
}

######################################################################
##                                                                  ##
##                             HANDLERS                             ##
##                                                                  ##
######################################################################

sub make_default_handler( $ ) {
    my $xform = shift;

    return sub {
        my $parser = shift;
        my $token = shift;

        $xform->write($token);

        return;
    };
}

sub make_makeatletter_handler( $ ) {
    my $xform = shift;

    return sub {
        my $parser = shift;
        my $csname = shift;

        $xform->write($csname);

        $parser->set_catcode(ord('@'), CATCODE_LETTER);

        return;
    };
}

sub make_makeatother_handler( $ ) {
    my $xform = shift;

    return sub {
        my $parser = shift;
        my $csname = shift;

        $xform->write($csname);

        $parser->set_catcode(ord('@'), CATCODE_OTHER);

        return;
    };
}

sub make_begin_handler( $ ) {
    my $xform = shift;

    return sub {
        my $parser = shift;
        my $token  = shift;

        $xform->write($token);

        my $next = $parser->peek_next_token();

        if ($next == CATCODE_BEGIN_GROUP) {
            my $env_name = trim($parser->read_undelimited_parameter());

            $xform->write(BEGIN_GROUP);
            $xform->write_string($env_name);
            $xform->write(END_GROUP);

            if ($env_name eq 'document') {
                $parser->set_verbatim_space(1);

                $xform->set_in_preamble(0);
            }
        }

        return;
    };
}

######################################################################
##                                                                  ##
##                            AUTOMETHOD                            ##
##                                                                  ##
######################################################################

sub AUTOMETHOD {
    my ($self, $obj_ID, @other_args) = @_;

    my $parser = $self->get_parser();

    my $method_name = $_;

    if ($parser->can($method_name)) {
        return sub {
            return $parser->$method_name(@other_args);
        };
    }

    return;   # The call is declined by not returning a sub ref
}

######################################################################
##                                                                  ##
##                            UTILITIES                             ##
##                                                                  ##
######################################################################

sub __num_final_eols( $ ) {
    my $string = shift;

    my $num_eols = 0;

    local $/ = LINE_FEED; # Paranoia!

    $num_eols++ while chomp($string);

    return $num_eols;
}

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub position {
    my $self = shift;

    my $in_line  = $self->get_line_no();
    my $out_line = $self->output_line();

    return "$in_line => $out_line";
}

sub close {
    my $self = shift;

    my $fh = $self->get_fh_out();

    close($fh) if defined $fh;

    return;
}

sub beginning_of_line {
    my $self = shift;

    return $self->is_blank_line();
}

sub newline {
    my $self = shift;

    if (! $self->beginning_of_line()) {
        $self->write(EOL);
    }

    return;
}

sub newpar {
    my $self = shift;

    $self->write(EOL);
    $self->write(EOL);

    return;
}

sub skip_newline {
    my $self = shift;

    my $parser = $self->get_parser();

    my $next_token = $parser->peek_next_token();

    if ($next_token == CATCODE_END_OF_LINE) {
        $parser->consume_next_token();
    }

    return;
}

## Add a newline if one is needed, but don't double newlines.

sub ensure_newline {
    my $self = shift;

    if (! $self->is_blank_line()) {
        $self->skip_newline();

        $self->newline();
    }

    return;
}

sub skip_comment {
    my $self = shift;

    my $parser = $self->get_parser();

    my $next_token = $parser->peek_next_token();

    if ($next_token == CATCODE_COMMENT) {
        $parser->consume_next_token();
    }

    return;
}

sub begin_comment {
    my $self = shift;

    return if $self->is_in_comment();

    $self->newline();

    $self->set_in_comment(1);

    my $prefix = $self->get_comment_prefix();

    $self->set_prefix($prefix);

    $self->write($prefix);

    return;
}

sub end_comment {
    my $self = shift;

    return unless $self->is_in_comment();

    $self->delete_prefix();

    $self->set_in_comment(0);

    my $next = $self->peek_next_token();

    if (! ($next == CATCODE_END_OF_LINE)) {
        $self->write(EOL);
    }

    return;
}

sub write_token_list {
    my $self = shift;

    my $token_list = shift;

    my $num_tokens = $token_list->length();

    ## Push the tokens into the token input buffer so that
    ## peek_next_token() will work.

    $self->unget_tokens($token_list->get_tokens());

    ## But we don't want these tokens to go through the main loop
    ## again, so pop them one by one and output them.

    for (1..$num_tokens) {
        my $token = $self->get_next_token();

        $self->write($token);
    }

    return;
}

sub write {
    my $self = shift;
    my $token = shift;

    return if $self->gobbling();

    my $immediate = shift;

    my $fh = $self->get_fh_out();

    if (defined(my $deferred = $self->get_deferred())) {
        $self->delete_deferred();

        $self->write($deferred, 1);
    }

    if ($token == CATCODE_CSNAME) {
        $self->set_blank_line(0);
        $self->set_num_eols(0);

        my $csname = $token->get_csname();

        if ($csname eq LINE_FEED) {
            $self->incr_num_eols();
            $self->set_blank_line(1);
        }

        # Write the control sequence without a following space

        print { $fh } qq{\\$csname};

        $self->set_prev($token);

        # But if control sequence is a control word and the
        # following character is a letter, add a space.

        if ($csname =~ m{[a-z]\z}i) {
            ## This isn't really right, since the next token in the
            ## input buffer might not be the next token we're going to
            ## write out.  Maybe these should be deferred?

            if (defined(my $next = $self->peek_next_token())) {
                if ($next == CATCODE_LETTER) {
                    print { $fh } " ";
                }
            }
        }
    } else {
        if ($token == CATCODE_END_OF_LINE) {
            if ($self->num_eols() < MAX_EOLS) {
                unless ($self->output_line() == 1 && $self->beginning_of_line()) {
                    print { $fh } $token;

                    $self->incr_output_line();

                    $self->set_prev($token);

                    $self->incr_num_eols();
                    $self->set_blank_line(1);

                    if (defined(my $prefix = $self->get_prefix())) {
                        $self->write($prefix);

                        $self->set_num_eols(0);
                        $self->set_blank_line(0);
                    }
                }
            }
        } else {
            my $defer = 0;

            ## Defer the output of any BEGIN_GROUP tokens that are not
            ## part of a comment and do not occur directly after a
            ## control sequence.  This is a first rough heuristic for
            ## identifying BEGIN_GROUP tokens that signal the start of
            ## simple groups such as "{\bf ...}".

            if (! $immediate && $token == BEGIN_GROUP) {
                $defer = 1;

                my $prev = $self->get_prev();

                ## We might also need to add an exception list for
                ## common macros known not to take arguments, such as
                ## \<space>.

                if (defined $prev && $prev == CATCODE_CSNAME) {
                    $defer = 0;
                } elsif ($self->is_in_comment()) {
                    $defer = 0;
                }
            }

            if ($defer) {
                $self->set_deferred($token);
            } else {
                print { $fh } $token;

                $self->set_prev($token);

                ## TeX::Lexer treats everything on the line after a
                ## comment character -- including the end_line_char -- as
                ## part of the comment.
                ##
                ## This means comments normally end in a line feed,
                ## *unless* end_line_char < 0 (cf. write_string()).
                ## So we check explicitly.

                if ($token->is_comment()) {
                    my $num_eols = __num_final_eols($token);

                    $self->set_num_eols($num_eols);

                    $self->set_blank_line($num_eols > 0);
                } else {
                    $self->set_num_eols(0);

                    if ($token != CATCODE_SPACE) {
                        $self->set_blank_line(0);
                    }
                }
            }
        }
    }

    return;
}

sub tokenize {
    my $self = shift;

    my $string = shift;

    my $tokenizer = $self->get_tokenizer();

    $tokenizer->push_input();

    $tokenizer->bind_to_string($string);

    my $token_list = TeX::TokenList->new();

    while (my $token = $tokenizer->get_next_token()) {
        $token_list->push($token);
    }

    $tokenizer->pop_input();

    return $token_list;
}

## NB: Newlines will be stripped out of the string.  Use newline() or
## newpar() instead.  Also note that the tokens produced by this
## method are *not* passed through handlers.

sub write_string {
    my $self = shift;

    my $string = shift;

    my $token_list = $self->tokenize($string);

    $self->write_token_list($token_list);

    return;
}

## WARNING: write_raw_string() should only be used as a last resort in
## very special circumstances.  In fact, right now it should only be
## used by PRD::AddMR.

sub write_raw_string {
    my $self = shift;

    return if $self->gobbling();

    my $string = shift;

    $self->set_num_eols(0);

    my $fh = $self->get_fh_out();

    print { $fh } $string;

    $self->set_num_eols(__num_final_eols($string));

    return;
}

sub transform {
    my $self = shift;

    $self->parse();

    $self->close();

    return;
}

1;

__END__
