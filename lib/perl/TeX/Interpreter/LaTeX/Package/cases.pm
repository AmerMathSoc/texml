package TeX::Interpreter::LaTeX::Package::cases;

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

\ProvidesPackage{cases}%[2002/05/02 ver 2.5 ]

\RequirePackage{amsmath}

\def\tagform@numcases#1{%
    \startXMLelement{tag}%
    \setXMLattribute{parens}{yes}%
        \hbox{#1}%
    \endXMLelement{tag}%
}%

\def\texml@tab@to@tag@cases{%
    \let\reserved@a\@empty
    \ifcase\aligncolno\or
        \def\reserved@a{&&}%
    \or
        \def\reserved@a{&}%
    \fi
    \reserved@a
}

\newenvironment{numcases}[1]{%
    \st@rredfalse
    \def\@currentreftype{disp-formula}%
    $$
    \begingroup
        \advance\c@equation\@ne
        \def\@currentlabel{\p@equation\theequation}% local
        \string\begin{\@currenvir}{#1}%
    \endgroup
    \UnicodeLineFeed
    \global\@eqnswtrue
    \global\let\df@label\@empty
    \Let@
    \let\tag\tag@in@align
    \let\math@cr@@@\math@cr@@@tagged
    \def\math@cr@@@simple{\cr}%
    \let\tagform@\tagform@numcases
    \let\label\label@in@display
    \let\texml@tab@to@tag\texml@tab@to@tag@cases
    \numc@setsub
    %% See nlm.xsl
    \xmltabletag{texml_cases}%
    \halign\bgroup
            \inlinemathtag{}$##$%       % column 1
           &##%                         % column 2
           % Why did the following stop working?
           % &\xmltablecoltag{tag}##%     % column 3
           &##%                         % column 3
        \cr
}{%
        \process@amsmath@tag
        \crcr
    \egroup
    \numc@resetsub
    \string\end{\@currenvir}%
    $$
}

\let\numc@setsub\relax
\let\numc@resetsub\relax

\def\subnumcases{%
    \let\numc@setsub\cases@subeq
    \let\numc@resetsub\endcases@subeq
    \numcases
}

\let\endsubnumcases\endnumcases

\newenvironment{cases@subeq}{%
    \refstepcounter{equation}%
    \protected@edef\theparentequation{\theequation}%
    \setcounter{parentequation}{\value{equation}}%
    \setcounter{equation}{0}%
    \def\theequation{\theparentequation\alph{equation}}%
}{
    \setcounter{equation}{\value{parentequation}}%
    \ignorespacesafterend
}

\DeclareOption{subnum}{
    \let\numc@setsub\subequations 
    \let\numc@resetsub\endsubequations
}

\ProcessOptions

\endinput

__END__
