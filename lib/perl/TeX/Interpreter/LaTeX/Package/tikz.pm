package TeX::Interpreter::LaTeX::Package::tikz;

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

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{tikz}

\RequirePackage{graphicx}

\RequirePackage{pgf}

\let\tikzcdset\@gobble
\let\usetkzobj\@gobble
\let\usepgfmodule\@gobble

\newcommand{\tikz}[1][]{%
    \@ifnextchar\bgroup{\@tikz[#1]}{\@@tikz[#1]}%
}

\def\@@tikz[#1]#2;{%
    \@tikz[#1]{#2;}%
}

\newcommand{\@tikz}[2][]{%
    \TeXMLCreateSVG{\tikz[#1]{#2}}%
}

\def\tikzpicture#1\endtikzpicture{%
    \TeXMLCreateSVG{\tikzpicture#1\endtikzpicture}%
}

\DeclareSVGEnvironment*{tikzpicture}

\def\usetikzlibrary#1{}

\def\tikzstyle#1{%
    \@ifnextchar={\tikzstyle@gobble}{\@gobble}%
}

\def\tikzstyle@gobble=#1[#2]{}

\let\tikzset\@gobble
\let\entrymodifiers\@gobble

\DeclareSVGEnvironment{tikzcd}

\let\tz\relax
\let\endtz\endrelax
\DeclareSVGEnvironment{tz}

\renewcommand{\rotatebox}[3][]{%
    \TeXMLCreateSVG{\rotatebox[#1]{#2}{#3}}%
}

\endinput

__END__
