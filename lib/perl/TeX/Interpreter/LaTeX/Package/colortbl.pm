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

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("colortbl", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::colortbl::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{colortbl}

\RequirePackage{array}
\RequirePackage{xcolor}

%% Support for colortbl

%% TODO: handle third and fourth (optional) arguments for \rowcolor
%% and \cellcolor.  Do something about \columncolor.

% \columncolor[<color model>]{<color>}[<left overhang>][<right overhang>]

% \rowcolor[<color model>]{<color>}[<left overhang>][<right overhang>]

\def\rowcolor#1#{\TML@rowcolor{#1}}

\def\TML@rowcolor#1#2{%
    \begingroup
        \edef\@selector{\@thistable\space \nth@row}%
        \XC@raw@color#1{#2}%
        \addCSSclass{\@selector}{background-color: \TML@current@color;}%
    \endgroup
    \ignorespaces
}

% \cellcolor[<color model>]{<color>}[<left overhang>][<right overhang>]

\renewcommand{\cellcolor}[2][]{%
    \begingroup
        \edef\@selector{\@thistable\space \nth@row\space\nth@col{\the\aligncolno}}%
        \addCSSclass{\@selector}{background-color: \XCOLOR@SVG@color{#2};}%
    \endgroup
    \ignorespaces
}

% \color{<color>}
% \color[<model-list>]{<spec-list>}

\let\set@cell@fg@color\relax
\newcommand{\set@cell@fg@color}[2][]{%
    \begingroup
        \edef\@selector{\@thistable\space \nth@row\space\nth@col{\the\aligncolno}}%
        \addCSSclass{\@selector}{color: \XCOLOR@SVG@color{#2};}%
    \endgroup
    \ignorespaces
}

\TeXMLendPackage

\endinput

__END__
