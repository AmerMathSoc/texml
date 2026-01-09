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

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_csname('lstlisting@' => \&do_lstlisting);

    return;
}

my sub output_lines {
    my $tex  = shift;

    my @lines = @_;

    my $line_no = 0;

    for my $line (@lines) {
        return unless defined $line;

        $line_no++;

        print STDERR qq{*** line=[$line]\n};

        $line =~ s{\\}{\\textbackslash{}}g;

        $line =~ s{ }{\\space }g;

        $line =~ s{([{}])}{\\$1}g;

        print STDERR qq{*** sanitized=[$line]\n};

        #$tex->par();

        $tex->start_xml_element('line');

        $tex->set_xml_attribute(lineno => $line_no);

        $tex->process_string($line);

        $tex->end_xml_element('line');

        $tex->par();
    }

    return;
}

sub do_lstlisting {
    my $tex   = shift;
    my $token = shift;

    # $tex->__DEBUG("token=$token");

    my $opt = $tex->scan_optional_argument();

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

        if ($next == CATCODE_ACTIVE && $next eq '') {
            push @lines, $line if defined $line;

            $line = "";

            next;
        }

        $line .= $next;
    }

    $tex->endgroup();

    output_lines($tex, @lines);

    return;
}

1;

__DATA__

\ProvidesPackage{Listings}

% \LoadRawMacros

\let\lstset\@gobble

\newenvironment{lstlisting}{%
    \par
    \startXMLelement{preformat}\par
    \xmlpartag{}%
    \lstlisting@
}{%
    \par
    \endXMLelement{preformat}\par
}

\endinput

__END__
