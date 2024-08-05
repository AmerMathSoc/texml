package TeX::Interpreter::LaTeX::Class::mcl_l;

# Copyright (C) 2022, 2024 American Mathematical Society
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

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{mcl_l}

\LoadClass{amsbook}

\seriesinfo{mcl}{}{}

\let\dedication\relax
\let\enddedication\relax

\newenvironment{dedication}{%
    \frontmatter
    \def\\{\emptyXMLelement{break}}%
    \startXMLelement{dedication}
        \startXMLelement{book-part-meta}
            \startXMLelement{title-group}
                \thisxmlpartag{title}%
                Dedication\par
            \endXMLelement{title-group}
        \endXMLelement{book-part-meta}
        \startXMLelement{named-book-part-body}
        \par
}{%
        \par
        \endXMLelement{named-book-part-body}
    \endXMLelement{dedication}
}

\newcounter{problem}
\newcounter{solution}

\newenvironment{problem}[1][]{%
    \par
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{\@currenvir}%
    \refstepcounter{problem}%
    \thisxmlpartag{label}%
    Problem \theproblem#1\@addpunct.\par
    \ignorespaces
}{%
    \par
    \endXMLelement{statement}%
}

\newenvironment{solution}{%
    \par
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{\@currenvir}%
    \refstepcounter{solution}%
    \thisxmlpartag{label}%
    Solution \thesolution\@addpunct.\par
    \ignorespaces
}{%
    \par
    \endXMLelement{statement}
}

\newenvironment{Remark}{%
    \par
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{\@currenvir}%
    \thisxmlpartag{label}%
    Remark\@addpunct.\par
    \ignorespaces
}{%
    \par
    \endXMLelement{statement}%
}

\newcommand{\answ}[2]{
  \textbf{#1.}\enspace #2\quad
}

\newenvironment{fsl}{%
  \emph{First solution.}\enskip\ignorespaces
}{%
  \par\addvspace{\medskipamount}%
}

\newenvironment{ssl}{%
  \noindent \emph{Second solution.}\enskip\ignorespaces
}{%
  \par\addvspace{\medskipamount}%
}

\def\upstrut{\noindent\vbox to \normalbaselineskip{}}
\def\downstrut{\noindent\lower.5em\vbox{}}

\def\emdash{\unskip\textemdash\ignorespaces}

\endinput

__END__
