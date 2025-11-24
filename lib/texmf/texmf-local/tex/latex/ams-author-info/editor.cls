%%
%% This is file `editor.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% editor.dtx  (with options: `cls')
%% 
%% Copyright 2002, 2004, 2010-2012 American Mathematical Society.
%% 
%% American Mathematical Society
%% Technical Support
%% Publications Technical Group
%% 201 Charles Street
%% Providence, RI 02904
%% USA
%% tel: (401) 455-4080
%%      (800) 321-4267 (USA and Canada only)
%% fax: (401) 331-3842
%% email: tech-support@ams.org
%% 
%% This work may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3c of this
%% license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% We request that if you modify this file, you give the modified
%% version another name.
%% 
%% This work has the LPPL maintenance status "maintained".
%% 
%% The Current Maintainer of this work is the American Mathematical
%% Society.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{editor}[2017/06/13 v2.0 Editor's Package Class]
\providecommand\@classname{editor}
\newcommand\DelayedOption[2]{\@ifclasswith{\@classname}{#1}{#2}{}}
\newif\if@articles  \@articlestrue
\DeclareOption{articles}{}
\def\@authorfont{\scshape}
\def\@andfont{\upshape}
\DeclareOption{tocitalauth}{%
  \def\@authorfont{\itshape}%
}
\newif\if@labeledcontitems  \@labeledcontitemsfalse
\DeclareOption{labels}{%
  \@labeledcontitemstrue
}
\newdimen\@chaptersink  \@chaptersink=8pc
\DeclareOption{tocbib}{%
  \@articlesfalse
  \@chaptersink=7.5pc
  \@labeledcontitemstrue
}
\newif\if@ctrpartheads  \@ctrpartheadsfalse
\DeclareOption{ctrpartheads}{%
  \@ctrpartheadstrue
  \def\@partalignment{\centering}%
}
\newif\if@lectures  \@lecturesfalse
\DeclareOption{lectures}{%
  \@articlesfalse
  \@lecturestrue
  \@chaptersink=64pt
}
\DeclareOption{...}{}
\DeclareOption{hmath}{%
  \@articlesfalse
  \@chaptersink=7.5pc
}
\DeclareOption{final}{\overfullrule\z@ }
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions\relax
\LoadClass{amsbook}[1996/10/24]
\let\cleardouble@page\cleardoublepage
\AtBeginDocument{%
  \ifx\cleardouble@page\cleardoublepage
    \def\cleardoublepage{\clearpage{\pagestyle{empty}\cleardouble@page}}
  \fi
}
\let\editor\author
\newenvironment{shortdedication}{%
  \cleardoublepage
  \thispagestyle{empty}
  \let\@tempa\\
  \def\\{\@tempa[2pt]}%
  \vspace*{13.pc}
  \begin{center}%
}{%
  \end{center}%
  \cleardoublepage
}
\newenvironment{dedication}{%
  \cleardoublepage
  \thispagestyle{empty}
  \vspace*{13.pc}
  \parindent\z@
}{%
  \cleardoublepage
}
\newif\if@firstcontitem  \@firstcontitemtrue
\newenvironment{contentslist}{%
  \let\secdef\@gobbletwo \chapter
  \typeout{\contentsname}\@xp\chaptermark\@xp{\contentsname}%
  \@makechapterhead{\contentsname}\@afterheading
    \@contentslist@bookmark
  \parskip\z@skip
  \@firstcontitemtrue
  \@contentsdefs
  \frenchspacing \raggedright
  \hyphenpenalty\@M \exhyphenpenalty\@M
}{%
  \@wrapcontitem
  \global\@nobreakfalse % \endgroup
  \newpage
}
\let\@contentslist@bookmark\@empty
\newcommand{\contitem}{%
  \if@firstcontitem
    \global\@firstcontitemfalse
  \else
    \@wrapcontitem
  \fi
  \let\authors\@empty
  \let\@title\@empty
  \let\@contlabel\@empty
  \let\@page\@empty
  \bgroup
}
\newdimen\@clabelwidth  \@clabelwidth=\z@
\newif\if@clabelsleft  \@clabelsleftfalse
\newcommand{\widestclabel}[2][r]{%
  \ifx l#1\@clabelslefttrue \fi
  \setbox0\hbox{#2\kern.5em}%
  \global\@clabelwidth=\wd0
}
\newcommand{\@wrapcontitem}{%
  \if@csection \global\@csectionfalse
  \else \addvspace{6pt}%
  \fi
  \parindent\z@ \leftskip\z@
  \rightskip\@pnumwidth plus6em \parfillskip-\@pnumwidth
  \if@labeledcontitems
    \ifx\@empty\@contlabel
    \else
      \leftskip\@clabelwidth\relax
      \leavevmode
      \if@clabelsleft
        \kern-\@clabelwidth
        \hbox to\@clabelwidth{\@contlabel\hfil}%
      \else \llap{\hss\@contlabel\kern.5em}%
      \fi
    \fi
  \fi
  \ifx\@empty\authors
    \@title\hfill\qquad\hbox to\@pnumwidth{\@tocpagenum{\@page}}\par
  \else
    \@title\hfill\null\par
    \nobreak
    \raggedright
    \leftskip 1.5em\relax
    \if@labeledcontitems
      \ifx\@empty\@contlabel
      \else
        \advance\leftskip\@clabelwidth
      \fi
    \fi
    \advance\parfillskip\leftskip
    \andify\authors
    {\@authorfont\authors}\nobreak
    \hfil\null\penalty\z@\hfill
    \qquad\hbox to\@pnumwidth{\@tocpagenum{\@page}}\par
  \fi
  \egroup
  \allowbreak
}
\let\@contlabel\@empty
\newif\if@csection  \@csectionfalse
\def\@contentsdefs{%
    \c@tocdepth-\@Mi
  \def\part##1{%
    \if@firstcontitem
    \else \@wrapcontitem \global\@firstcontitemtrue
    \fi
    \@startsection{part}{1}%
      \z@{1.2\linespacing\@plus\linespacing}{.5\linespacing}%
      {\normalfont\bfseries\large
        \if@ctrpartheads \centering \fi
      }*{##1}%
   \@xp\partmark\@xp{\contentsname}%
   }%
  \def\contlabel##1{\gdef\@contlabel{##1}}%
  \def\title##1{\gdef\@title{\relax##1}}%
  \def\lecture##1{\gdef\@title{\textbf{\relax##1}}}%
  \renewcommand{\andify}{%
     \nxandlist{\unskip, }{\unskip{} {\@andfont and}~}%
       {\unskip, \penalty-1{\@andfont and}~}}%
  \def\author##1{%
    \ifx\@empty\authors
      \gdef\authors{##1}%
    \else
      \g@addto@macro\authors{\and##1}%
    \fi
  }%
  \def\@page{}%
  \def\page##1{\gdef\@page{##1}}%
  \def\section##1{%
    \global\@csectiontrue
    \gdef\@title{\leftskip1.5em\relax##1}%
  }%
}
\def\@makechapterhead#1{\global\topskip\@chaptersink\relax
  \begingroup
    \if@articles
      \Large
    \else
      \fontsize{\@xivpt}{18}%
    \fi
    \bfseries
    \if@lectures
      \raggedright
    \else
      \centering
    \fi
    #1\par
  \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\let\@makeschapterhead\@makechapterhead
\def\twocolchapter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}\global\@topnum\z@
  \@afterindenttrue \secdef\@twocolchapter\@stwocolchapter}
\def\@twocolchapter[#1]#2{%
  \global\topskip\@chaptersink\relax
  \chaptermark{#1}%
  \twocolumn[%
    \if@articles
      \Large
    \else
      \fontsize{\@xivpt}{18}%
    \fi
    \vskip\topskip\vskip-\baselineskip\hbox{}% adjust top space
    \bfseries\centering
    #2\par]%
  \global\topskip 34\p@ }
\def\@stwocolchapter#1{%
  \global\topskip\@chaptersink\relax
  \chaptermark{#1}%
  \twocolumn[%
    \if@articles
      \Large
    \else
      \fontsize{\@xivpt}{18}%
    \fi
    \vskip\topskip\vskip-\baselineskip\hbox{}% adjust top space
    \bfseries\centering
    #1\par]%
  \global\topskip 34\p@ }
\@ifundefined{bibdiv}{}{%
  \renewenvironment{bibdiv}{\bibsection}{\endbibsection}%
}
\newenvironment{inchapterbibliography}[1]{%
  \@xp\section\@xp*\@xp{\bibname}%
  \normalfont\footnotesize\labelsep .5em\relax
  \renewcommand\theenumiv{\arabic{enumiv}}\let\p@enumiv\@empty
  \list{\@biblabel{\theenumiv}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth \advance\leftmargin\labelsep
    \usecounter{enumiv}}%
  \sloppy \clubpenalty\@M \widowpenalty\clubpenalty
  \sfcode`\.=\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `inchapterbibliography' environment}}%
  \endlist
}
\newif\if@firstparticipant
\newenvironment{participants}{%
  \let\@secnumber\@empty
  \global\@firstparticipanttrue
  \let\chapter=\twocolchapter
  \parindent=\z@
  \hyphenpenalty=\@M
  \raggedright
  \interlinepenalty=\@M
}{%
  \onecolumn
}
\def\participant{%
  \if@firstparticipant
    \global\@firstparticipantfalse
    \def\\{\hfil\penalty-\@M}%
  \else
    \par
    \addvspace{6pt plus.5pt}%
  \fi
}
\InputIfFileExists{editor.cfg}{}{}
\endinput
%%
%% End of file `editor.cls'.
