package TeX::Interpreter::LaTeX::Class::notices;

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

\ProvidesClass{notices}

\LoadClass{amsart}

\publinfo{noti}{}{}

\def\AMS@publname{Notices of the American Mathematical Society}

\def\AMS@pissn{0002-9920}
\def\AMS@eissn{1088-9477}

\setcounter{secnumdepth}{3}

\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{xspace}
\RequirePackage{amsthm}
\RequirePackage{subfig}
\RequirePackage{wrapfig}
\RequirePackage[table]{xcolor}

\RequirePackage[lite,nobysame]{amsrefs}

\RequirePackage{hyperams}

\def\DOI#1{\gdef\AMS@DOI{#1}\extract@manid@from@doi}

\def\extract@manid@from@doi{%
    \ifx\AMS@DOI\@empty\else
        \@xp\parse@doi@for@manid \AMS@DOI\space 10.1090/noti0\space \@nil
    \fi
}

\def\parse@doi@for@manid 10.1090/noti#1\space #2\@nil{%
    \ifnum\number0#1 = 0\else
        \gdef\AMS@manid{#1}%
    \fi
}

\newcommand{\category}[1]{%
    \gdef\@noti@category{#1}%
    \@nameuse{init@\@noti@category}%
}

\def\init@amsupdates{%
    \gdef\@noti@category{news}%
    \title{AMS Updates}%
}

\def\init@mathpeople{%
    \gdef\@noti@category{news}%
    \title{Mathematics People}%
}

\def\init@bookreview{%
    \def\author@contrib@type{reviewer}%
}

\newcommand{\noti@month@name}{%
    \relax\ifcase\AMS@issue@month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\or
    June/July\fi % Notices
}

\def\init@bookshelf{%
    % \setpermissiontext{}%
    \title{New and Noteworthy Titles on our Bookshelf}%
    \subtitle{\noti@month@name\ \AMS@issue@year}%
}

\def\init@amsbookshelf{%
    \disclaimertext{The AMS Book Program serves the mathematical community by
        publishing books that further mathematical research,
        awareness, education, and the profession while generating
        resources that support other Society programs and
        activities.  As a professional society of mathematicians
        and one of the world's leading publishers of mathematical
        literature, we publish books that meet the highest
        standards for their content and production.
        Visit \href{https://bookstore.ams.org}{\textbf{bookstore.ams.org}}
        to explore the entire collection of AMS titles.
    }
}

\newcommand{\titlepic}{\def\@titlepic}
\newcommand{\titlegraphicnote}{\def\@titlegraphicnote}

\let\@titlepic\@empty

\def\thanks{\authorbio}

\def\commbytext{\def\@commbytext}

% \def\@commbytext{Communicated by \emph{Notices} Associate Editor }
% \def\commby{\gdef\AMS@commby}

%% \def\@commbytext{Communicated by}
\def\commby#1{%
    \if###1##\else
        \gdef\AMS@commby{\emph{Notices} Associate Editor #1}%
    \fi
}

\newcommand{\disclaimertext}{%
    \gdef\@disclaimertext
}

\disclaimertext{}

% \newcommand{\notiemail}[1]{\texttt{\upshape\nolinkurl{#1}}}
\newcommand{\notiemail}[1]{\leavevmode\XMLelement{email}{\ignorespaces#1}}

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

\def\notidoi#1{\PrintDOI{10.1090/noti/#1}}

\newcommand{\authorgraphics}[1][0pt]{%
  \let\endauthorgraphics\relax%
  \par
  \begingroup
    \let\textcolor\@secondoftwo
    \@authorgraphicsi
}

\newcommand{\@authorgraphicsi}{%
    \@ifnextchar\endauthorgraphics{\@endauthorgraphics}{\@authorgraphicsii}}

\newcommand{\@authorgraphicsii}[3][]{%
    \begin{figure}
        \includegraphics[width=7pc,height=9pc]{#3}
        \caption*{#2}%
        \if###1##\else
            \thisxmlpartag{alt-text}#1\par
        \fi
    \end{figure}
    \@authorgraphicsi
}

\newcommand{\@endauthorgraphics}{\endgroup\par}

\newcommand{\featurepic}[4][]{%
    \leavevmode
    \begin{figure}[H]
        \includegraphics{#2}
        \caption{#3}
    \end{figure}
}

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
    \backmatter
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

\newenvironment{lettersignature}[2][Sincerely]{%
    \def\@receiveddate{#2}%
    \def\\{\emptyXMLelement{break}}%
    \let\par\@empty
    \@@par
    \if###1##\else#1,\\\fi
    % \startXMLelement{italic}%
    % \setXMLattribute{toggle}{yes}%
}{%
    \ifx\@receiveddate\@empty\else(Received \@receiveddate)\fi
    % \endXMLelement{italic}%
    \par
}

\newenvironment{featureditem}{%%
  \ignorespaces
  \def\lines{\def\@featureditem@lines}
  \def\@featureditem@lines{11}
  \newif\ifborder
  \borderfalse
  \let\@featureditem@border\@empty
  \def\graphic{\def\@featureditem@graphic}
  \let\@featureditem@graphic\@empty
  \def\byline{\def\@featureditem@byline}
  \let\@featureditem@byline\@empty
  \def\title{\long\def\@featureditem@title}
  \let\@featureditem@title\@empty
  \def\subtitle{\long\def\@featureditem@subtitle}
  \let\@featureditem@subtitle\@empty
  \def\authors{\long\def\@featureditem@authors}
  \let\@featureditem@authors\@empty
  \def\caption{\long\def\@featureditem@caption}
  \let\@featureditem@caption\@empty
}{%
  \ifborder
    \def\@featureditem@border{999}
    \let\@featureditem@caption\@empty
  \fi
    \protected@xdef\set@featureditem{%
      \noexpand\reviewedwork@main{\@featureditem@lines}%
                        [\@featureditem@border]%
                        {\@featureditem@graphic}%
                        {\@featureditem@byline}%
                        {\@featureditem@title}%
                        {\@featureditem@subtitle}%
                        {\@featureditem@authors}%
                        {\@featureditem@caption}%
   }%
   \set@featureditem
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
    \leavevmode
    \begin{figure}[H]
    \setXMLattribute{specific-use}{reviewedwork}%
    \if###3##\else
        \includegraphics{#3}\par
    \fi
    \par
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      SECTIONS WITH METADATA                      %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Deprecated.  See sectionWithMetadata in amscommon.pm

% \secmeta: a (not-so-)temporary solution(, apparently)

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
        \thisxmlpartag{label}\thesection\@addpunct.\par
    \fi
    \thisxmlpartag{title}#1\par
}

\endinput

__END__
