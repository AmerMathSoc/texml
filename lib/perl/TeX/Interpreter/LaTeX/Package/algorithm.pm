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

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("algorithm", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::algorithm::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{algorithm}

%% The following declarations might be misplaced.

\@ifpackagewith{algorithm}{section}{%
    \newcounter{algorithm}[section]%
    \def\thealgorithm{\thesection.\arabic{algorithm}}%
}{%
    \newcounter{algorithm}%
}

\def\algorithmname{Algorithm}

\providecommand{\fnum@algorithm}{\fname@algorithm}

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
    \def\@captype{algorithm}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \set@float@fps@attribute{#1}%
    \addXMLid
}{%
    \endXMLelement{\jats@figure@element}%
    \par
}

\TeXMLendPackage

\endinput

__END__
