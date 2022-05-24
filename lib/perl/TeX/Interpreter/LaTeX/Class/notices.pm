package TeX::Interpreter::LaTeX::Class::notices;

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

    $tex->class_load_notification(__PACKAGE__, @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::notices::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesClass{notices}

\LoadClass{amsart}

\setcounter{secnumdepth}{3}

\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{xspace}
\RequirePackage{amsthm}
\RequirePackage{subfig}
\RequirePackage{xcolor}

\RequirePackage[lite,nobysame]{amsrefs}

\RequirePackage{hyperref}

\def\category{\gdef\@noti@category}

\newcommand{\titlepic}{\def\@titlepic}
\newcommand{\titlegraphicnote}{\def\@titlegraphicnote}

\let\@titlepic\@empty

\def\thanks{\authorbio}

\def\commbytext{\def\@commbytext}
\def\@commbytext{Communicated by \emph{Notices} Associate Editor }

% \newcommand{\notiemail}[1]{\texttt{\upshape\nolinkurl{#1}}}
\newcommand{\notiemail}[1]{\XMLelement{email}{\ignorespaces#1}}

% Doesn't handle catcode changes

\newcommand{\notiurl}[2][\@empty]{%
    \begingroup
        \upshape\ttfamily
        \ifx\@empty#1%
            \href{https://#2}{\nolinkurl{#2}}%
        \else
            \href{https://#2}{\nolinkurl{#1}}%
        \fi
    \endgroup
}

\newcommand{\authorgraphics}[1][0pt]{%
  \let\endauthorgraphics\relax%
  \par
  \begingroup
    \let\textcolor\@secondoftwo
    \@authorgraphicsi
}

\newcommand{\@authorgraphicsi}{%
    \@ifnextchar\endauthorgraphics{\@endauthorgraphics}{\@authorgraphicsii}}

\newcommand{\@authorgraphicsii}[2]{%
    \begin{figure}
        \includegraphics[width=7pc,height=9pc]{#2}
        \caption*{#1}%
    \end{figure}
    \@authorgraphicsi
}

\newcommand{\@endauthorgraphics}{\endgroup\par}

\let\c@refhead\c@section
\def\therefhead{\thesection}

\newcommand{\refhead}{%
    \@startsection
        {refhead}%
        {10}%
        {0pt}%
        {9pt}%
        {2pt}%
        {%
            \sffamily\bfseries
            \fontsize{9}{11pt}\selectfont
            \color{Aheadcolor}%
        }%
}

\let\c@zhead\c@section
\def\thezhead{\thesection}

\def\zhead{%
    \@startsection
        {zhead}%
        {1}%
        \z@
        {17pt}%
        {12pt}%
        {%
            \normalfont\fontsize{18}{21}\selectfont
            \color{Zheadcolor}%
        }%
}

\let\c@zauthor\c@section
\def\thezauthor{\thesection}

\newcommand{\zauthor}{%
    \@startsection
        {zauthor}%
        {100}% never numbered
        {0pt}%
        {0pt}%
        {7pt}%
        {%
            \normalfont\itshape
            \fontsize{16}{18pt}\selectfont
        }%
}

\newcommand{\zthanks}[1]{%
    \begingroup
    \let\@makefnmark\relax
    \let\@thefnmark\relax
    \@footnotetext{%
        \normalfont
        \fontsize{8}{11pt}\selectfont
        \parindent\z@
        \emergencystretch0em
        \begingroup
        \itshape
        #1\@addpunct.\par
        \endgroup
    }%
    \endgroup
}

\newenvironment{PhotoCredits}[1][Credits]{%
    \par
    \refhead{#1}
}{%
    \par
}

\newenvironment{acknowledgment}[1][Acknowledgment]{%
    \def\XML@section@tag{sec}
    \section*{#1}
}{%
}

\newenvironment{intro}{%
    \section*{}
}{%
}

\def\reviewheaderskip#1{%
    \parskip#1%
    \everypar{{\setbox\z@\lastbox}\parskip\z@\everypar{}}%
}
%    \end{macrocode}
%    \end{macro}
%
%    \begin{macro}{\reviewedwork}
%    Arguments of \cs{reviewedwork}:
%\begin{verbatim}
%    #1       #2      #3      #4       #5       #6       #7
% [# LINES][BORDER?]{GRAPHIC}{BYLINE}{TITLE}{SUBTITLE}{AUTHORS}
%\end{verbatim}
%    \begin{macrocode}

\def\reviewedwork{%
  \@ifnextchar[%
    {\reviewedwork@border}
    {\reviewedwork@border[7]}%
}

\def\reviewedwork@border[#1]{%
  \@ifnextchar[%
    {\reviewedwork@main{#1}}
    {\reviewedwork@main{#1}[]}%
}

% [NUMLINES][BORDER?]{GRAPHIC}{BYLINE}{TITLE}{SUBTITLE}{AUTHORS}
%     #1      #2        #3      #4      #5      #6         #7

\def\reviewedwork@main#1[#2]#3#4#5#6#7{%
    \begin{figure}[H]
    \setXMLattribute{specific-use}{reviewedwork}%
    \if###3##\else
        \includegraphics{#3}\par
    \fi
    \xmlpartag{p}%
    \startXMLelement{caption}
        \if###5##\else
            \textbf{\emph{#5}}\par
        \fi
        \if###6##\else
            \emph{#6}\par
        \fi
        \if###7##\else
            #7\par
        \fi
        \if###4##\else
            #4\par
        \fi
    \endXMLelement{caption}
    \end{figure}
}

\def\fullcolumnad{\end{document}}

% \secmeta: a temporary solution

\newif\if@numbered

% \secmeta{section title}{author}{bio}

\newcommand{\secmeta}{\maybe@st@rred\@secmeta}

\newcommand{\@secmeta}[3]{%
    \ifst@rred
        \@numberedfalse
    \else
        \@numberedtrue
    \fi
    \section*{}
    \startXMLelement{sec-meta}\par
    \startXMLelement{contrib-group}\par
    \setXMLattribute{content-type}{authors}\par
    \startXMLelement{contrib}
    \setXMLattribute{contrib-type}{author}\par
    \thisxmlpartag{string-name}#2\par
    \thisxmlpartag{bio}#3\par
    \endXMLelement{contrib}\par
    \endXMLelement{contrib-group}\par
    \endXMLelement{sec-meta}\par
    \if@numbered
        \refstepcounter{section}
        \thisxmlpartag{label}\thesection\par
    \fi
    \thisxmlpartag{title}#1\par
}

\endinput

__END__
