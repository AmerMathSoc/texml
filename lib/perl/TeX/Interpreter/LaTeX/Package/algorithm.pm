package TeX::Interpreter::LaTeX::Package::algorithm;

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

\ProvidesPackage{algorithm}

\LoadRawMacros

%% The following declarations might be misplaced.

\@ifundefined{c@algorithm}{
    \@ifpackagewith{algorithm}{section}{%
        \newcounter{algorithm}[section]%
        \def\thealgorithm{\thesection.\arabic{algorithm}}%
    }{%
        \newcounter{algorithm}%
    }
}

\def\algorithmname{Algorithm}

\def\fnum@algorithm{\fname@algorithm\space\thealgorithm\XMLgeneratedText.}

\let\algorithm\relax
\let\endalgorithm\relax
\newenvironment{algorithm}[1][]{%
    \TeXMLSVGpaperwidth8in
    \let\center\@empty
    \let\endcenter\@empty
    \par
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{algorithm}%
    \let\@currentrefsubtype\@currentreftype
    \def\@captype{algorithm}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \set@float@fps@attribute{#1}%
    \addXMLid
    \setXMLattribute{content-type}{algorithm}%
}{%
    \endXMLelement{\jats@figure@element}%
    \par
}

\AtBeginDocument{%
    \@ifpackageloaded{subfig}{%
        \def\subalgorithm{%
            \def\subfloat@content@type{algorithm}%
            \subfloat
        }%
    }{}
}

\endinput

__END__
