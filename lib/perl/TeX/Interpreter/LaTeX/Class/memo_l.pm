package TeX::Interpreter::LaTeX::Class::memo_l;

use 5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{memo_l}

\LoadClass{amsbook}

\seriesinfo{memo}{}{}

\let\AMS@issue\@empty
\let\AMS@issue@year\@empty
\let\AMS@issue@month\@empty
\def\AMS@issue@day{1}

\def\issueinfo#1#2#3#4{%
    \gdef\AMS@volumeno{#1}%
    \xdef\AMS@issue{\number0#2}%
    \gdef\AMS@issue@month{}%
    \@ifnotempty{#3}{\xdef\AMS@issue@month{\TEXML@month@int{#3}}}%
    \gdef\AMS@issue@year{#4}%
}

\let\AMS@dateposted\@empty
\def\dateposted{\gdef\AMS@dateposted}

\def\format@toc@label#1#2{%
    \ignorespaces\if@AMS@tocusesnames@#1 \fi
    \ifnum\@toclevel=1\XMLelement{x}{\S}\fi
    #2\unskip\@addpunct.%
}

\endinput

__END__
