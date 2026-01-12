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

sub output_lines {
    my $tex   = shift;
    my $style = shift;

    my @lines = @_;

    my $line_no = 0;

    for my $line (@lines) {
        return unless defined $line;

        $line_no++;

        # $tex->__DEBUG(qq{line=[$line]\n});

        $line =~ s{\\}{\\textbackslash }g;

        $line =~ s{(*nlb:\\textbackslash) }{\\space }g;

        $line =~ s{([{}_\$^])}{\\$1}g;

        # $tex->__DEBUG(qq{sanitized=[$line]\n});

        $tex->start_xml_element('line');

        $tex->set_xml_attribute(lineno => $line_no);

        $tex->process_string($line);

        $tex->end_xml_element('line');

        $tex->par();
    }

    return;
}

sub compile_listings_style {
    my $tex = shift;
    my $opt = shift;

    my %style;

    my sub overlay;

    sub overlay {
        my $pairs = shift;

        for my $pair ($pairs->@*) {
            my ($k, $v) = $pair->@*;

            if ($k eq 'style') {
                if (defined(my $eqvt = $tex->get_csname(qq{TeXML_listing_style_$v}))) {
                    overlay($eqvt->get_equiv()->get_value());
                }
            }
            elsif ($k eq 'language') {
                if (defined(my $eqvt = $tex->get_csname(qq{TeXML_listing_lang_$v}))) {
                    overlay($eqvt->get_equiv()->get_value());
                }
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

    $tex->ignorespaces();

    my @lines;

    $tex->begingroup();

    $tex->set_catcode(ord(' '), CATCODE_ACTIVE);
    $tex->set_catcode(carriage_return, CATCODE_ACTIVE);

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

    my $key_pairs = read_key_pairs($tex);

    $tex->define_csname(q{TeXML_listing_default}, $key_pairs);

    return;
}

sub do_lstdefinelanguage {
    my $tex   = shift;
    my $token = shift;

    my $lang_name = $tex->read_undelimited_parameter();

    my $key_pairs = read_key_pairs($tex);

    $tex->define_csname(qq{TeXML_listing_lang_$lang_name}, $key_pairs);

    return;
}

sub do_lstdefinestyle {
    my $tex   = shift;
    my $token = shift;

    my $style_name = $tex->read_undelimited_parameter();

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
    \lstlisting@
}{%
    \par
    \endXMLelement{preformat}\par
}

# TODO:
#     \lstinline
#     \lstinputlisting

\endinput

__END__
