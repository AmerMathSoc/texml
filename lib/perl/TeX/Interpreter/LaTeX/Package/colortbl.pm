package TeX::Interpreter::LaTeX::Package::colortbl;

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

\ProvidesPackage{colortbl}

\RequirePackage{array}
\RequirePackage{xcolor}

\def\@gobbleopts{%
    \@ifnextchar[{\@gobble@opts@}{}%
}

\def\@gobble@opts@[#1]{\@gobble@opts@@}

\def\@gobble@opts@@{%
    \@ifnextchar[{\@gobble@opts@@i}{\ignorespaces}%
}

\def\@gobble@opts@@i[#1]{\ignorespaces}

% TBD: Colored rules

% TBD: \arrayrulecolor

% TBD: \doublerulesepcolor

% See comments in colortbl.tex

% \columncolor is only used in a >-specifier in a preamble

% \columncolor[<color model>]{<color>}[<left overhang>][<right overhang>]

\def\columncolor#1#{\TML@columncolor{#1}}

\def\TML@columncolor#1#2{%
    \begingroup
        \XC@raw@color#1{#2}%
        \ifmmode
            \string\columncolor\TML@current@color
        \else
            \setCSSproperty{background-color}{\TML@current@color}%
        \fi
    \endgroup
    \@gobbleopts
}

% TODO: \rowcolors must be used before a table starts

% \rowcolors[<commands>]{<row>}{<odd-row color>}{even-row color>}
% \rowcolors*[<commands>]{<row>}{<odd-row color>}{even-row color>}

\newcommand{\rowcolors}{\maybe@st@rred\@rowcolors}

\newcommand{\@rowcolors}[4][]{%
}

% \rowcolor must be used at the start of a row

% \rowcolor[<color model>]{<color>}[<left overhang>][<right overhang>]

\def\rowcolor#1#{%
    \noalign{\ifnum0=`}\fi
        \TML@rowcolor{#1}%
}

\def\TML@rowcolor#1#2{%
        \XC@raw@color#1{#2}%
        \ifmmode
            \string\rowcolor\TML@current@color
        \else
            \setRowCSSproperty{background-color}{\TML@current@color}%
        \fi
        \kernel@ifnextchar[\TML@gobbleopt@a\TML@rowcolor@end
}

\def\TML@gobbleopt@a[#1]{%
    \kernel@ifnextchar[\TML@gobbleopt@b\TML@rowcolor@end
}

\def\TML@gobbleopt@b[#1]{%
    \TML@rowcolor@end
}

\def\TML@rowcolor@end{%
    \ifnum0=`{\fi}%
}

% \cellcolor can appear anywhere in a cell, not just at the beginning.

% \cellcolor[<color model>]{<color>}[<left overhang>][<right overhang>]

\def\cellcolor#1#{\TML@cellcolor{#1}}

\def\TML@cellcolor#1#2{%
    \begingroup
        \XC@raw@color#1{#2}%
        \ifmmode
            \string\cellcolor\TML@current@color
        \else
            \setCSSproperty{background-color}{\TML@current@color}%
        \fi
    \endgroup
    \@gobbleopts
}

\endinput

__END__

Precedence for cell color (lowest to highest):
    tabular specifications: >{\columncolor{...}} -> u template (yay!)
    row_properties:         \insertRowProperties
    cell properties:        \cellcolor
