package TeX::Interpreter::LaTeX::Package::Listings;

use 5.26.0;

# Copyright (C) 2026 American Mathematical Society
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

use warnings;

use TeX::Constants qw(carriage_return);

use TeX::Token qw(:catcodes);

use TeX::Utils::Misc qw(nonempty trim);

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_csname('lstlisting@' => \&do_lstlisting);

    $tex->define_csname('lstset' => \&do_lstset);

    $tex->define_csname('lstdefinelanguage' => \&do_lstdefinelanguage);
    $tex->define_csname('lstdefinestyle'    => \&do_lstdefinestyle);

    return;
}

######################################################################
##                                                                  ##
##                            GRUNT WORK                            ##
##                                                                  ##
######################################################################

sub compile_string {
    my $spec = shift;

    if ($spec =~ s{\A\[(.+?)\]}{}) {
        my $type = $1;
        my $char = $spec;

        $char =~ s{\A\{.+?\}\z}{$1};

        $char =~ s{^\\}{};

        my $re;

        if ($type eq 'b') {
            $re = qq{$char (?: \\\\$char | [^$char] )* $char};
        }
        elsif ($type eq 'd') {
            $re = qq{$char (?: ${char}{2} | [^$char] )* $char};
        }
        elsif ($type eq 'bd') {
            $re = qq{$char (?: \\\\$char | ${char}{2} | [^$char] )* $char};
        }
        else {
            die qq{Invalid type '$type'\n};
            exit 42;
        }

        return qr{$re}smx;
    } else {
        die qq{Invalid spec '$spec'\n};
        exit 42;
    }

    return;
}

sub compile_comment {
    my $spec = shift;

    if ($spec =~ m{\[l\]\{(.*?)\}}) {
        my $char = $1;

        $char =~ s{^\\}{};

        return qr{\Q$char\E.*\z}smx;
    }

    return;
}

sub compile_parser {
    my $style = shift;

    my %re;

    my $mod = '';

    if ($style->{sensitive} =~ m{^t}i) {
        $mod = '(?i)'
    }

    my $raw_identifier = qr{[a-z_][a-z0-9_]*}i;

    my @other_keywords;

    if (defined (my $okws = $style->{otherkeywords})) {
        @other_keywords = map { quotemeta } $okws->@*;

        my $re = sprintf qq{${mod}(?:%s)}, join("|", @other_keywords);

        $re{other_keyword} = qr{$re}o;
    }

    my @keywords;

    if (defined (my $kws = $style->{keywords})) {
        @keywords = map { quotemeta } $kws->@*;

        my $re = sprintf qq{${mod}(?:%s)}, join("|", @keywords);

        $re{keyword} = qr{$re}o;
    }

    {
        my $re = sprintf qq{${mod}(?:%s)}, join("|", @other_keywords, @keywords, $raw_identifier);

        $re{identifier} = qr{$re}o;
    }

    my @strings;

    if (defined (my $strings = $style->{string})) {
        @strings = map { compile_string($_) } $strings->@*;

        my $re = sprintf qq{(?:%s)}, join("|", @strings);

        $re{string} = qr{$re}o;
    }

    my @comments;

    if (defined (my $comments = $style->{comment})) {
        @comments = map { compile_comment($_) } $comments->@*;

        my $re = sprintf qq{(?:%s)}, join("|", @comments);

        $re{comment} = qr{$re}o;
    }

    my @tokens = (@comments, @strings, @other_keywords, @keywords, $raw_identifier);

    my $re = sprintf qq{(?:%s)}, join("|", @tokens);

    $re{token} = qr{$re}o;

    return \%re;
}

# sub output_filler {
#     my $filler = shift;
#
#     return unless length $filler;
#
#     $filler =~ s{ }{\\ }g;
#     $filler =~ s{\$}{\\\$}g;
#
#     $filler =~ s{\{}{\\\{}g;
#
#     return $filler;
# }

sub id {
    my $tex = shift;

    my $type = shift;
    my $token = shift;

    $tex->__DEBUG(qq{[$type, "$token"]});
}

sub apply_style {
    my $token = shift;
    my $style = shift;

    $token =~ s{\\}{\\\\}g;

    $token =~ s{ }{\\ }g;
    $token =~ s{\$}{\\\$}g;

    $token =~ s{([{}])}{\\$1}g;

    if (defined $style) {
        return qq{{${style}{$token}}};
    }

    return $token;
}

sub annotate_line {
    my $tex   = shift;
    my $style = shift;
    my $re    = shift;
    my $in    = shift;

    my $out;

    my $token_rx   = $re->{token};

    my $id_rx      = $re->{identifier};
    my $kwd_rx     = $re->{keyword};
    my $okwd_rx    = $re->{other_keyword};

    my $string_rx  = $re->{string};
    my $comment_rx = $re->{comment};

    my $basic_style   = $style->{basicstyle};
    my $kwd_style     = $style->{keywordstyle};
    my $id_style      = $style->{identifierstyle};
    my $comment_style = $style->{commentstyle};
    my $string_style  = $style->{stringstyle};

    while(length($in)) {
        $in =~ s{^(.*?)($token_rx)}{} and do {
            my $pre   = $1;
            my $token = $2;

            if (length $pre) {
                $out .= apply_style($pre);

                id($tex, interstitial => $pre);
            }

            if (defined $string_rx && $token =~ m{\A$string_rx\z}) {
                id($tex, string => $token);

                $out .= apply_style($token, $string_style);
            } elsif (defined $comment_rx && $token =~ qr{\A$comment_rx\z}) {
                id($tex, comment => $token);

                $token =~ s{([{}])}{\\$1}g;

                $out .= apply_style($token, $comment_style);
            } elsif ($token =~ m{\A$id_rx\z}) {
                if (defined $kwd_rx && $token =~ m{\A$kwd_rx\z}) {
                    id($tex, keyword => $token);

                    $out .= apply_style($token, $kwd_style);
                }
                elsif (defined $okwd_rx && $token =~ m{\A$okwd_rx\z}) {
                    id($tex, other_keyword => $token);

                    $out .= apply_style($token, $kwd_style);
                }
                else {
                    id($tex, identifier => $token);

                    $out .= apply_style($token, $id_style);
                }
            } else {
                id($tex, wtf => $token);

                $out .= $token;
            }

            next;
        };

        if (length $in) {
            $out .= apply_style($in);

            id($tex, trailing => $in);
        }

        last;
    }

    return $out;
}

sub output_lines {
    my $tex   = shift;
    my $style = shift;

    my @lines = @_;

    my $re = compile_parser($style);

    while (my ($k, $v) = each $re->%*) {
        $tex->__DEBUG("re($k) => $v");
    }

    my $line_no = 0;

    for my $line (@lines) {
        return unless defined $line;

        $tex->start_xml_element('line');

        $line_no++;

        $tex->set_xml_attribute(lineno => $line_no);

        my $annotated = annotate_line($tex, $style, $re, $line);

        $tex->process_string($annotated);

        $tex->end_xml_element('line');

        $tex->par();
    }

    return;
}

my sub split_list {
    my $list = shift;

    return map { trim($_) } split /\s*,\s*/, trim($list);
}

sub compile_listings_style {
    my $tex = shift;
    my $opt = shift;

    my %style = (sensitive => 't');

    my sub overlay;

    sub overlay {
        my $pairs = shift;

        for my $pair ($pairs->@*) {
            my ($k, $v) = $pair->@*;

            if ($k eq 'style' || $k eq 'language') {
                if (defined(my $eqvt = $tex->get_csname(qq{TeXML_listing_${k}_\L${v}\Q}))) {
                    overlay($eqvt->get_equiv()->get_value());
                }
            }
            elsif ($k =~ m{\A(keywords|comment|string)\z}) {
                $style{$k} = [ split_list($v) ];
            } elsif ($k =~ m{\Amore(keywords|comment|string)\z}) {
                push $style{$1}->@*, split_list($v);
            } elsif ($k eq 'otherkeywords') {
                $style{$k} = [ split_list($v) ];
            }
            else {
                $style{$k} = $v;
            }
        }

        return;
    }

    if (defined (my $eqvt = $tex->get_csname(q{TeXML_listing_default}))) {
        my $pairs = $eqvt->get_equiv()->get_value();

        overlay($pairs);
    }

    if (nonempty($opt)) {
        my $pairs = parse_key_pairs($tex, $opt);

        overlay($pairs);
    }

    return \%style;
}

my $BALANCED_TEXT = qr{
    (             # paren group 1 (full string)
        \{
            (     # paren group 2 (contents of braces)
            (?:
                (?> [^{}]+ )    # Non-parens without backtracking
               |
                (?1)            # Recurse to start of paren group 1
            )*
            )
        \}
    )
}smx;

sub parse_key_pairs {
    my $tex = shift;
    my $raw = shift;

    ## Quick and dirty.  Maybe too quick and dirty.

    my @key_pairs;

    return \@key_pairs unless defined $raw;

    $raw = trim($raw);

    $raw .= ',' unless $raw =~ m{,\z};

    while (nonempty($raw)) {
        $raw =~ s{^([a-z]+)[ =]*}{}ismx and do {
            my $key = $1;

            my $value;

            if ($raw =~ s{\A$BALANCED_TEXT\s*,\s*}{}smx) {
                $value = trim($2);
            } elsif ($raw =~ s{\A([^,]+),\s*}{}smx) {
                $value = trim($1);
            } else {
                die qq{Bad: [$raw]\n};
            }

            push @key_pairs, [ $key, $value ];
        };
    }

    return \@key_pairs;
}

sub read_key_pairs {
    my $tex = shift;

    ## Quick and dirty.  Maybe too quick and dirty.

    my $raw = $tex->read_undelimited_parameter();

    return parse_key_pairs($tex, $raw);
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

sub do_lstlisting {
    my $tex   = shift;
    my $token = shift;

    my $opt = $tex->scan_optional_argument();

    my $style = compile_listings_style($tex, $opt);

    # while (my ($k, $v) = each $style->%*) {
    #     $tex->__DEBUG("$k => [$v]");
    # }

    $tex->ignorespaces();

    my @lines;

    $tex->begingroup();

    $tex->set_catcode(ord(' '), CATCODE_ACTIVE);
    $tex->set_catcode(carriage_return, CATCODE_ACTIVE);

    $tex->set_catcode(ord('$'), CATCODE_OTHER);

    my $line;

    while (my $next = $tex->get_next()) {
        if ($next == CATCODE_CSNAME && $next->get_csname eq 'end') {
            if (length $line) {
                push @lines, $line;
            }

            $tex->back_input($next);

            last;
        }

        if ($next == CATCODE_ACTIVE && $next eq "\r") {
            push @lines, $line if defined $line;

            $line = "";

            next;
        }

        $line .= $next;
    }

    $tex->endgroup();

    output_lines($tex, $style, @lines);

    return;
}

sub do_lstset {
    my $tex   = shift;
    my $token = shift;

    my $new_pairs = read_key_pairs($tex);

    my @pairs;

    if (defined (my $eqvt = $tex->get_csname(q{TeXML_listing_default}))) {
        my $pairs = $eqvt->get_equiv()->get_value();

        @pairs = $pairs->@*;
    }

    push @pairs, $new_pairs->@*;

    $tex->define_csname(q{TeXML_listing_default}, \@pairs);

    return;
}

sub do_lstdefinelanguage {
    my $tex   = shift;
    my $token = shift;

    my $lang_name = lc $tex->read_undelimited_parameter();

    my $key_pairs = read_key_pairs($tex);

    $tex->define_csname(qq{TeXML_listing_language_$lang_name}, $key_pairs);

    return;
}

sub do_lstdefinestyle {
    my $tex   = shift;
    my $token = shift;

    my $style_name = lc $tex->read_undelimited_parameter();

    my $key_pairs = read_key_pairs($tex);

    $tex->define_csname(qq{TeXML_listing_style_$style_name}, $key_pairs);

    return;
}

1;

__DATA__

\ProvidesPackage{Listings}

\newenvironment{lstlisting}{%
    \par
    \startXMLelement{preformat}\par
    \xmlpartag{}%
    \fontencoding{UCS}\selectfont
    \UCSchardef\\"005C
    \lstlisting@
}{%
    \par
    \endXMLelement{preformat}\par
}

% TODO:
%     \lstinline
%     \lstinputlisting

\endinput

__END__
