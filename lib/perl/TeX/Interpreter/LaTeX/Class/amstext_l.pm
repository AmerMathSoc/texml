package TeX::Interpreter::LaTeX::Class::amstext_l;

use v5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{amstext_l}

\LoadClass{amsbook}

\seriesinfo{gsm}{}{}

\def\AMS@publname{Pure and Applied Undergraduate Texts}

\def\AMS@pissn{1943-9334}
\def\AMS@eissn{2380-5676}

\def\AMS@series@url{https://www.ams.org/amstext/}

\newenvironment{inclusion}[1]{%
    \quotation
    \if###1##\else\textbf{#1}\par\fi
}{%
    \endquotation
}

\newenvironment{framedthm}[1]{%
    \def\@current@framed{#1}%
    \csname \@current@framed\endcsname
    % \setXMLattribute{framed}{yes}%
}{
    \csname end\@current@framed\endcsname
}

\endinput

__END__
