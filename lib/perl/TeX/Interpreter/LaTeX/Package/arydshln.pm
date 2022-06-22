package TeX::Interpreter::LaTeX::Package::arydshln;

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

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{arydshln}

%% Not yet implemented:
%% -- \hdashline\hdashline
%% -- \dashlinedash, \dashlinegap, etc. (optional arg to \[ch]dashline)

%% With a little work, the implementations of \hdashline and
%% \cdashline could be unified with \hline and \cline.

\def\hdashline{%
    \noalign{\ifnum0=`}\fi % I'm frankly astonished that this works.
        \futurelet\@let@token\do@hdashline
}

\def\do@hdashline{%
        \count@\alignrowno
        \ifx\@let@token\hdashline
            %% Doubled dashlines don't work this way.  If we ever need
            %% them, we will have to work harder.
            \def\current@border@style{double dashed}%
            \def\current@border@width{}%
        \else
            \def\current@border@style{dashed}%
        \fi
        \setRowCSSproperty{border-top}{\current@border@properties}%
        \ifx\@let@token\hline
            \aftergroup\@gobble
        \fi
    \ifnum0=`{\fi}%
}

\let\firsthdashline\hdashline
\let\lasthdashline\hdashline

\def\cdashline#1{%
    \noalign{\ifnum0=`}\fi
        \@ifnextchar[%]
            {\adl@cdline[#1]}%
            {\adl@cdline[#1][\dashlinedash/\dashlinegap]}%
}

\def\adl@cdline[#1-#2][#3]{%
        \def\current@border@style{dashed}%
        \count@#1
        \@tempcnta#2
        \advance\@tempcnta\@ne
        \@whilenum\count@<\@tempcnta\do{%
            \setColumnCSSproperty{\the\count@}{border-top}{\current@border@properties}%
            \advance\count@\@ne
        }%
    \ifnum0=`{\fi}
}

\endinput

__END__
