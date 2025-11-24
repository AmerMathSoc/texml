%%
%% This is file `jura.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% jura.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from jura.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file jura.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% Written by Felix Braun
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{jura}[1998/07/13 v4.3 juristische Hausarbeiten]
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{report}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{report}}
\newlength\frontwidth\newlength\ofrontmargin\newlength\efrontmargin
\DeclareOption{widefront}{\setlength{\frontwidth}{15,77cm}
\setlength{\efrontmargin}{0,75mm}\setlength{\ofrontmargin}{0,75mm}}
\DeclareOption{normalfront}{\setlength{\frontwidth}{12,2cm}
\setlength{\ofrontmargin}{4,46cm}\setlength{\efrontmargin}{-7,4mm}}
\newcommand*{\J@FootnoteSpread}{1}
\DeclareOption{tightfn}{\renewcommand*{\J@FootnoteSpread}{1}}
\DeclareOption{spacedfn}{\renewcommand*{\J@FootnoteSpread}{1.3}}
\AtEndOfClass{\setlength{\footnotesep}{\J@FootnoteSpread\footnotesep}}
\ExecuteOptions{normalfront,tightfn}
\ProcessOptions\relax
\LoadClass[a4paper,12pt]{report}
\RequirePackage{alphanum}
\setlength{\parskip}{0ex}
\setlength{\parindent}{1,3em}
\setlength{\textwidth}{12,2cm}
\setlength{\oddsidemargin}{4,46cm}
\setlength{\evensidemargin}{-7,4mm}
\setlength{\marginparwidth}{3,5cm}
\reversemarginpar
\linespread{1.3}
\setlength{\textheight}{34\baselineskip}
\setlength{\textheight}{\baselinestretch\textheight}
\setlength\topmargin{\paperheight}
\addtolength\topmargin{-2in}
\addtolength\topmargin{-\headheight}
\addtolength\topmargin{-\headsep}
\addtolength\topmargin{-\textheight}
\addtolength\topmargin{-\footskip}
\addtolength\topmargin{-\topskip}
\addtolength\topmargin{-.5\topmargin}
\@settopoint\topmargin
\long\def\@footnotetext#1{\insert\footins{%
    \linespread{\J@FootnoteSpread}\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
       \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}%
\newcommand*{\frontmatter}{\cleardoublepage\pagenumbering{Roman}%
\oddsidemargin\ofrontmargin\evensidemargin\efrontmargin%
\hsize\frontwidth\columnwidth\hsize\linewidth\hsize\textwidth\hsize}
\newcommand*{\mainmatter}{\cleardoublepage\pagenumbering{arabic}%
\hsize12,2cm\columnwidth12,2cm\linewidth12,2cm\textwidth12,2cm%
\oddsidemargin4,46cm\evensidemargin-7,4mm}
\newcommand*{\backmatter}{\clearpage}
\renewenvironment*{titlepage}{%
 \thispagestyle{empty}\setcounter{page}{1}%
 \setlength{\oddsidemargin}{0,75mm}\setlength{\parindent}{0cm}%
 \hsize15,77cm\columnwidth15,77cm\linewidth15,77cm\textwidth15,77cm}%
 {\newpage\if@twoside\thispagestyle{empty}\null\clearpage\fi}
\renewcommand{\maketitle}{\begin{titlepage}%
\let\footnotesize\small\let\footnoterule\relax\let\footnote\thanks
\begin{tabular}[t]{l}%
\@author
\end{tabular}\par%
\null\vfill
\begin{center}%
{\LARGE\@title\par}\vspace{8ex}%
{\@date\par}%
\end{center}\par
\@thanks
\vfill\vfill\null
\end{titlepage}%
\setcounter{footnote}{0}\global\let\thanks\relax
\global\let\maketitle\relax\global\let\@thanks\@empty
\global\let\@author\@empty\global\let\@date\@empty
\global\let\@title\@empty\global\let\title\relax
\global\let\author\relax\global\let\date\relax
\global\let\and\relax}
\renewcommand*{\and}{\end{tabular}\hspace{1em}\hfill%
\begin{tabular}[t]{l}}
\endinput
%%
%% End of file `jura.cls'.
