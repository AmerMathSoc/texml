package TeX::Interpreter::LaTeX::Package::Listings;

use utf8;

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

my sub do_lstlisting;
my sub do_lstset;
my sub do_lstdefinelanguage;
my sub do_lstdefinestyle;

# TBD: my sub do_lstinline;
# TBD: my sub do_lstinputlisting;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_csname('lstlisting@' => \&do_lstlisting);

    $tex->define_csname('lstset' => \&do_lstset);

    $tex->define_csname('lstdefinelanguage' => \&do_lstdefinelanguage);
    $tex->define_csname('lstdefinestyle'    => \&do_lstdefinestyle);

    $tex->define_csname(TeXML_listing_default => [
                            [ gobble          => 0 ],
                            [ texcl           => 'false' ],
                            [ mathescape      => 'false' ],
                            [ sensitive       => 'true' ],
                            [ numbers         => 'none' ],
                            [ stepnumber      => 1 ],
                            [ firstnumber     => 1 ],
                            [ numberfirstline => 'false' ],
                        ]);

    return;
}

######################################################################
##                                                                  ##
##                            GRUNT WORK                            ##
##                                                                  ##
######################################################################

my $BALANCED_TEXT = qr{ # Adapted from perlre man page
    (             # paren group 1 (full string)
        \{
            (     # paren group 2 (contents of braces)
            (?:
                (?> \\[{}] )
               |
                (?> [^{}] )    # Non-parens without backtracking
               |
                (?1)            # Recurse to start of paren group 1
            )*
            )
        \}
    )
}smx;

my sub parse_key_pairs {
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

            if ($raw =~ s{\A,}{}smx) {
                $value = 'true';
            }
            elsif ($raw =~ s{\A$BALANCED_TEXT\s*,\s*}{}smx) {
                $value = trim($2);
            }
            elsif ($raw =~ s{\A([^,]+),\s*}{}smx) {
                $value = trim($1);
            }
            else {
                $tex->error_message(qq{Bad key-pair input [$raw]});

                last;
            }

            push @key_pairs, [ $key, $value ];
        };
    }

    return \@key_pairs;
}

my sub read_key_pairs {
    my $tex = shift;

    ## Quick and dirty.  Maybe too quick and dirty.

    my $raw = $tex->read_undelimited_parameter();

    return parse_key_pairs($tex, $raw);
}

my sub parse_boolean {
    my $bool = shift;

    return defined $bool && $bool =~ m{\At}i;
}

my sub make_delim_parser {
    my $tex      = shift;
    my $string_r = shift;

    return sub {
        my $delim;

        if ($string_r->$* =~ s{\A$BALANCED_TEXT}{}) {
            $delim = $2;

            $delim =~ s{\\([{}#$%])}{$1}g;
        } elsif ($string_r->$* =~ s{\A\\(.)}{}) {
            $delim = $1;
        } elsif ($string_r->$* =~ s{\A(.)}{}) {
            $delim = $1;
        } else {
            $tex->error_message(qq{Empty delimiter});

            return;
        }

        $delim = trim($delim);

        my $initial = substr($delim, 0, 1);

        return ( quotemeta($delim), quotemeta($initial) );
    };
}

my sub compile_string_rx {
    my $tex  = shift;
    my $spec = shift;

    my $parser = make_delim_parser($tex, \$spec);

    if ($spec =~ s{\A\[(.+?)\]}{}) {
        my $type = $1;

        my ($delim) = $parser->();

        my $re;

        if ($type eq 'b') {
            $re = qq{$delim (?: \\\\$delim | [^$delim] )* $delim};
        }
        elsif ($type eq 'd' || $type eq 'm') {
            if ($type eq 'm') {
                $tex->error_message(qq{Replacing unsupported type-$type string by by type-d});
            }

            $re = qq{$delim (?: ${delim}{2} | [^$delim] )* $delim};
        }
        elsif ($type eq 'bd') {
            $re = qq{$delim (?: \\\\$delim | ${delim}{2} | [^$delim] )* $delim};
        }
        #
        # We can't implement m-type strings with the current
        # architecture; since we remove input as we consume it, we
        # can't look behind.
        #
        # elsif ($type eq 'm') {
        #     $re = qq{(*nlb:[a-zA-z])$delim (?: ${delim}{2} | [^$delim] )* $delim};
        # }
        elsif ($type eq 's') {
            my ($delim2) = $parser->();

            $re = qq{$delim (?:.*?) $delim2};
        }
        else {
            $tex->error_message(qq{Invalid type '$type'});

            return;
        }

        return qr{$re}smx;
    } else {
        $tex->error_message({Invalid spec '$spec'});

        return;
    }

    return;
}

my sub compile_comment_rx {
    my $tex  = shift;
    my $spec = shift;

    my $parser = make_delim_parser($tex, \$spec);

    if ($spec =~ s{\A\[(.+?)\]}{}) {
        my $type = $1;

        my ($ldelim, $init) = $parser->();

        my $re;

        if ($type eq 'l') {
            $re = qq{(?<ldelim>$ldelim)(?<comment>.*)};
        }
        elsif ($type eq 's') {
            my ($rdelim) = $parser->();

            # $re = qq{(?<ldelim>$ldelim) (?<comment>.*?) (?<rdelim>$rdelim)};

            $re = qq{$ldelim .*? $rdelim};
        }
        elsif ($type eq 'n') {
            my ($rdelim, $init2) = $parser->();

            # $re = qq{ (
            #             (?<ldelim>$ldelim)
            #             (?<comment> (?: (?>[^$init$init2]) | (?-3) )* )
            #             (?<rdelim>$rdelim)
            #           ) };

            $re = qq{ ( $ldelim (?: (?>[^$init$init2]) | (?-1) )* $rdelim ) };
        }
        # elsif ($type eq 'f') {
        #     😖
        # }
        else {
            $tex->error_message(qq{Invalid comment type '$type'});

            return;
        }

        return qr{$re}smx;
    } else {
        $tex->error_message(qq{Invalid comment spec '$spec'});

        return;
    }

    return;
}

my sub compile_parser {
    my $tex   = shift;
    my $style = shift;

    my %re;

    my $mod = '';

    $mod = '(?i)' if parse_boolean($style->{sensitive} // 'true');

    my $raw_identifier = qr{[a-z_][a-z0-9_]*}i;

    my @math;

    if (parse_boolean($style->{mathescape})) {
        my $re = qr{\$.*?\$};

        push @math, $re;

        $re{math} = $re;
    }

    my @other_keywords;

    if (defined (my $okws = $style->{otherkeywords})) {
        @other_keywords = map { quotemeta } $okws->@*;

        my $re = sprintf qq{${mod}(?:%s)}, join("|", @other_keywords);

        $re{other_keyword} = qr{$re};
    }

    my @keywords;

    if (defined (my $kws = $style->{keywords})) {
        @keywords = map { quotemeta } $kws->@*;

        my $re = sprintf qq{${mod}(?:%s)}, join("|", @keywords);

        $re{keyword} = qr{$re};
    }

    {
        my $re = sprintf qq{${mod}(?:%s)}, join("|", @other_keywords, @keywords, $raw_identifier);

        $re{identifier} = qr{$re};
    }

    my @strings;

    if (defined (my $strings = $style->{string})) {
        @strings = map { compile_string_rx($tex, $_) } $strings->@*;

        my $re = sprintf qq{(?:%s)}, join("|", @strings);

        $re{string} = qr{$re};
    }

    my @comments;

    if (defined (my $comments = $style->{comment})) {
        @comments = map { compile_comment_rx($tex, $_) } $comments->@*;

        my $re = sprintf qq{(?:%s)}, join("|", @comments);

        $re{comment} = qr{$re};
    }

    my @tokens = (@comments, @strings,
                  @math,
                  @other_keywords, @keywords,
                  $raw_identifier);

    my $re = sprintf qq{(?:%s)}, join("|", @tokens);

    $re{token} = qr{$re};

    return \%re;
}

my sub id {
    my $tex = shift;

    my $type = shift;
    my $token = shift;

    # $tex->__DEBUG(qq{[$type, "$token"]});

    return;
}

my sub verbatim {
    my $s = shift;

    $s =~ s{([{}\\\$ ])}{\\$1}g;

    return $s;
}

my sub apply_style {
    my $in    = shift;
    my $style = shift;

    my $out = verbatim($in);

    if (defined $style) {
        return qq{{${style}{$out}}};
    }

    return $out;
}

my sub annotate_line {
    my $tex   = shift;
    my $style = shift;
    my $re    = shift;
    my $in    = shift;

    if (defined(my $gobble = $style->{gobble})) {
        if ($gobble =~ m{\A\d+\z} && $gobble > 0) {
            substr($in, 0, $gobble) = '';
        }
    }

    my $token_rx   = $re->{token};

    my $id_rx      = $re->{identifier};
    my $kwd_rx     = $re->{keyword};
    my $okwd_rx    = $re->{other_keyword};

    my $string_rx  = $re->{string};
    my $comment_rx = $re->{comment};

    my $math_rx    = $re->{math};

    my $basic_style   = $style->{basicstyle};
    my $kwd_style     = $style->{keywordstyle};
    my $id_style      = $style->{identifierstyle};
    my $comment_style = $style->{commentstyle};
    my $string_style  = $style->{stringstyle};

    my $texcl      = parse_boolean($style->{texcl});
    my $mathescape = parse_boolean($style->{mathescape});

    my $out;

    while(length($in)) {
        $in =~ s{^(.*?)($token_rx)}{} and do {
            my $pre   = $1;
            my $token = $2;

            if (length $pre) {
                id($tex, interstitial => $pre);

                $out .= apply_style($pre);
            }

            my $style;

            if (defined $math_rx && $token =~ m{\A$math_rx\z}) {
                id($tex, math => $token);

                $out .= $token;

                next;
            } elsif (defined $string_rx && $token =~ m{\A$string_rx\z}) {
                id($tex, string => $token);

                $style = $string_style;
            } elsif (defined $comment_rx && $token =~ qr{\A$comment_rx\z}) {
                $style = $comment_style;

                id($tex, comment => $token);

                if ($texcl && defined $+{ldelim}) {
                    if (defined (my $ldelim = $+{ldelim})) {
                        $out .= apply_style($ldelim, $style);
                    }

                    if (defined (my $comment = $+{comment})) {
                        $out .= $comment;
                    }

                    if (defined (my $rdelim = $+{rdelim})) {
                        $out .= apply_style($rdelim, $style);
                    }

                    next;
                }
                elsif (defined $math_rx) {
                    while (length($token)) {
                        $token =~ s{\A(.*?)($math_rx)}{}smx and do {
                            my $pre  = $1;
                            my $math = $2;

                            if (length($pre)) {
                                $out .= apply_style($pre, $style);
                            }

                            $out .= $math;

                            next;
                        };

                        $out .= apply_style($token, $style);

                        last;
                    }

                    next;
                }
                else {
                    $style = $comment_style;
                }
            } elsif ($token =~ m{\A$id_rx\z}) {
                if (defined $kwd_rx && $token =~ m{\A$kwd_rx\z}) {
                    id($tex, keyword => $token);

                    $style = $kwd_style;
                }
                elsif (defined $okwd_rx && $token =~ m{\A$okwd_rx\z}) {
                    id($tex, other_keyword => $token);

                    $style = $kwd_style;
                }
                else {
                    id($tex, identifier => $token);

                    $style = $id_style;
                }
            } else {
                id($tex, wtf => $token);
            }

            $out .= apply_style($token, $style);

            next;
        };

        if (length $in) {
            id($tex, trailing => $in);

            $out .= apply_style($in);
        }

        last;
    }

    return $out;
}

my sub output_lines {
    my $tex   = shift;
    my $style = shift;

    my @lines = @_;

    my $re = compile_parser($tex, $style);

    # while (my ($k, $v) = each $re->%*) {
        # $tex->__DEBUG("re($k) => $v");
    # }

    my $first_no = ($style->{firstnumber} // 1);

    my $numbered = ($style->{numbers} // 'n') =~ m{^[lr]};

    my $step = $style->{stepnumber} // 1;

    my $number_first = parse_boolean($style->{numberfirstline});

    my $modulus = $first_no == 1 ? 1 : 0;

    my $line_no = $first_no - 1;

    for my $line (@lines) {
        # return unless defined $line;

        $line_no++;

        $tex->start_xml_element('texml:line');

        if ($numbered && $step != 0) {
            my $number_this_line = $step == 1;

            if (! $number_this_line) {
                if ($line_no == $first_no && $number_first) {
                    $number_this_line = 1;
                } else {
                    if ($first_no == 1) {
                        $number_this_line = ($line_no % $step == 1);
                    } else {
                        $number_this_line = ($line_no % $step == 0);
                    }
                }
            }

            if ($number_this_line) {
                $tex->set_xml_attribute(lineno => $line_no);
            }
        }

        my $annotated = annotate_line($tex, $style, $re, $line);

        $tex->process_string($annotated);

        $tex->end_xml_element('texml:line');

        $tex->par();
    }

    return;
}

my sub split_list {
    my $list = shift;

    return map { trim($_) } split /\s*,\s*/, trim($list);
}

my sub compile_listings_style {
    my $tex = shift;
    my $opt = shift;

    my %style;

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

    $tex->set_xml_attribute(numbers => $style->{numbers});
    $tex->set_xml_attribute(frame => $style->{frame});

    $tex->ignorespaces();

    my @lines;

    $tex->begingroup();

    $tex->set_catcode(ord(' '), CATCODE_ACTIVE);
    $tex->set_catcode(carriage_return, CATCODE_ACTIVE);

#    $tex->set_catcode(ord('$'), CATCODE_OTHER);

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

    $tex->define_csname(TeXML_listing_default => \@pairs);

    return;
}

sub do_lstdefinelanguage {
    my $tex   = shift;
    my $token = shift;

    my $dialect = $tex->scan_optional_argument() // '';

    my $lang_name = $tex->read_undelimited_parameter();

    if (nonempty $dialect) {
        $lang_name = qq{[$dialect]$lang_name};
    }

    my $key_pairs = read_key_pairs($tex);

    $tex->define_csname(qq{TeXML_listing_language_\L$lang_name\Q}, $key_pairs);

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
    \startXMLelement{fig}\par
    \setXMLattribute{specific-use}{lstlisting}%
    \setXMLattribute{content-type}{code}%
    \startXMLelement{texml:lstlisting}\par
    \xmlpartag{}%
    \fontencoding{UCS}\selectfont
    \UCSchardef\\"005C
    \lstlisting@
}{%
    \par
    \endXMLelement{texml:lstlisting}\par
    \endXMLelement{fig}\par
}

% TODO:
%     \lstinline
%     \lstinputlisting

\endinput

__END__

As embodied in annotate_line(), the listings.sty package recognizes 4
types of distinguished content that can be styled independently:

1. identifiers
2. keywords
3. comments
4. strings

The simplest versions of these are mostly implemented by texml.

In addition, there is a 'basicstyle' that applies to the entire
listing that I have not yet implemented, partly because getting it to
work correctly with the individual styles will require resolution of
texml #196.

Currently the individual styles are implemented by adding the
appropriate font and styled-content tags directly to the output.  An
alternative would be to mark the content with bespoke tags (<lst:id>,
<lst:kwd>, <lst:comment>, <lst:string>) and generate CSS to style
those, if that would provide any benefits.

The numbers, firstnumber, stepnumber, and numberfirstline option are
implemented, *BUT* in a way that is not entirely compatible with
listings.sty.  This is because the listings.sty implementation is at
present extremely inconsistent and buggy.  If we encounter any use
cases that rely upon the buggy behaviour, we'll deal with it then.

The numbers parameter can be one of three values: none, left, or
right.

The listings package has an impressive number of customizable
parameters, many of which are mercifully irrelevant for our purposes,
but there are a number that we should do something with.

Notably, there are a bunch of parameters controlling frames that we
should figure out how to handle.  For now I just pass the value of
frame as an attribute.

Here's the full list, but I think
the only essential ones are frame and the colors.

    frame=<none|leftline|topline|bottomline|lines|single|shadowbox>
    frame=<subset of trblTRBL>

    frameround=<t|f><t|f><t|f><t|f>     # rounded corners

    backgroundcolor
    rulecolor
    fillcolor
    rulesepcolor

    framesep=<dimen>
    rulesep=<dimen>
    framerule=<dimen>

    framexleftmargin=<dimen>
    framexrightmargin=<dimen>
    framextopmargin=<dimen>
    framexbottommargin=<dimen>

There are also a bunch of other options I need to implement.
