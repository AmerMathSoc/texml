package TeX::Interpreter::LaTeX::Package::listings;

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

\ProvidesPackage{listings}

\let\lstset\@gobble
\let\lstdefinestyle\@gobbletwo

\def\lstdefinelanguage{%
    \kernel@ifnextchar[\@lstdfnlng{\@lstdfnlng[]}%
}

\def\@lstdfnlng[#1]#2{% [dialect]{language}
    \kernel@ifnextchar[\@@lstdfnlng{\@@@lstdfnlng}%
}

\def\@@lstdfnlng[#1]#2#3{% [base dialect]{base language}{key=value list}
    \@gobbleopt
}

\def\@@@lstdfnlng#1{\@gobbleopt}

\def\lstnewenvironment#1{% <name>
    \kernel@ifnextchar[\@lstnewenv{\@lstnewenv[]}%
}

\def\@lstnewenv[#1]{% [<number>]
    \kernel@ifnextchar[\@@lstnewenv{\@@lstnewenv[]}%
}

\def\@@lstnewenv[#1]#2#3{% [opt default arg]{starting code}{ending code}
}

\DeclareSVGEnvironment*{listings}

% \DeclareSVGEnvironment*{lstlisting}

\begingroup \catcode `|=0 \catcode `[= 1
\catcode`]=2 \catcode `\{=12 \catcode `\}=12
\catcode`\\=12 |gdef|@xlstlisting#1\end{lstlisting}[#1|end[lstlisting]]
|endgroup

\def\@lstlisting#1{
    \par
    \xmlpartag{}%
    \everypar{}%
    \startXMLelement{pre}%
    \setXMLattribute{specific-use}{#1}%
    \UnicodeLineFeed
    \let\do\@makeother \dospecials
    \noligs=1
    \obeylines
}

\newcommand{\lstlisting}[1][]{%
    \@lstlisting{#1}
    \frenchspacing
    \@vobeyspaces
    \@xlstlisting
}

\let\endlstlisting\endverbatim

\endinput

__END__

\LoadRawMacros

\let\lstlisting\relax
\let\lstlisting@\relax

\lstnewenvironment{lstlisting}[2][]{%
    \par
    \startXMLelement{lstlisting}
    \lst@TestEOLChar{#2}%
    \lstset{#1}%
    \csname\@lst @SetFirstNumber\endcsname
}{%
    \csname\@lst @SaveFirstNumber\endcsname
    \endXMLelement{lstlisting}
}

\endinput
