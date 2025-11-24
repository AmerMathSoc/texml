%
% $Id: FUpowerdot.cls 232 2009-05-17 22:05:21Z herbert $
%
%%
%% Praesentationen mit LaTeX
%%
%% Copyright (C) 2009 Herbert Voss <hvoss@tug.org>
%%
%% It may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%%
%% See http://www.latex-project.org/lppl.txt for details.
%%
%
\ProvidesClass{FUpowerdot}[2009/05/22 v0.01 Vorlage Freie Universitaet Berlin (hv)]
%
\PassOptionsToPackage{ngerman}{babel}
\PassOptionsToPackage{table}{xcolor}
\PassOptionsToPackage{dvips,bookmarks,colorlinks}{hyperref}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{powerdot}}
\ProcessOptions\relax
\LoadClass{powerdot}
\RequirePackage[T1]{fontenc}
\RequirePackage{babel}
\RequirePackage{pifont}
\RequirePackage{breakurl}
\RequirePackage{graphicx}
\RequirePackage{calc}
\RequirePackage{tabularx}
\RequirePackage[scaled]{helvet}
\RequirePackage[newcommands]{ragged2e}
%
\definecolor{FUblue}{RGB}{0,51,102}
\definecolor{FUgreen}{RGB}{153,204,0}
\definecolor{FUred}{RGB}{204,0,0}
\definecolor{FUorange}{RGB}{255,153,51}
\definecolor{FUgray}{gray}{0.6}
%
\makeatletter
\newlength\FU@left\setlength\FU@left{15pt}
\newlength\FU@right\setlength\FU@right{\slidewidth}
\addtolength\FU@right{-\FU@left}
\newlength\FU@image@width\setlength\FU@image@width{\slidewidth}
\newlength\FU@textwidth\setlength\FU@textwidth{\slidewidth}
\addtolength\FU@textwidth{-2\FU@left}
\newlength\FU@image@height\setlength\FU@image@height{2.5cm}
\newlength\FU@rule\setlength\FU@rule{0.6pt}
\newsavebox\FU@box
%
\let\inst\textsuperscript

\newcommand\framelogo[1]{\def\insertframelogo{#1}}
\framelogo{\includegraphics[height=1cm]{FULogo}}%

\newcommand\titlelogo[1]{\def\inserttitlelogo{#1}\savebox\FU@box{#1}%
%  \global\setlength\FU@image@width{\FU@textwidth}\global\addtolength\FU@image@width{-\wd\FU@box}}
  \setlength\FU@image@width{\FU@textwidth}\addtolength\FU@image@width{-\wd\FU@box}}
\titlelogo{\includegraphics[height=\FU@image@height]{FUbib}}%
\pdsetup{logohook=rt,logopos={\FU@right,0.99\slideheight},logocmd={\insertframelogo}}

\newcommand\fachbereich[1]{\def\insertfachbereich{#1}}
\fachbereich{}%
\newcommand\subtitle[1]{\def\insertsubtitle{#1}}
\title{}%
\subtitle{}%
\newcommand\institute[1]{\def\insertinstitute{#1}}
\institute{}%

\pddefinetemplate{titleslide}{
  textpos={\FU@left,.5\slideheight},
  textwidth=\FU@textwidth,
  titlefont=\bfseries\Large\raggedright\color{FUgray},
  textfont=\raggedright\color{FUblue},
  ifsetup=landscape,textheight=.67\slideheight,
  ifsetup=portrait,textheight=.55\slideheight
}{%
  \begingroup\fboxsep=0pt%
  \rput[tl](\FU@left,0.875\slideheight){%
    \colorbox{FUgray}{\makebox[\slidewidth-30pt][l]{\rule{0pt}{\FU@image@height}%
      \inserttitlelogo\inserttitlegraphic}}}\endgroup%
}
\newcommand\titlegraphic[2][]{%
  \edef\inserttitlegraphic{%
      \ifx\relax#2\relax\else
        \noexpand\includegraphics[keepaspectratio=false,height=\FU@image@height,width=\FU@image@width,#1]{#2}%
      \fi}%
}%
\titlegraphic{}

\pddefinetemplate{basic}{%
  titlefont=\bfseries\LARGE\color{FUgray},
  lfpos={\FU@left,.015\slideheight},
  rfpos={\FU@right,.015\slideheight},
  rffont=\tiny\color{FUblue},
  lffont=\tiny\color{FUblue},
  iacolor=FUblue!20!white,
  textfont=\color{black},
  lfpos={\FU@left,.015\slideheight},
  rfpos={\FU@right,.015\slideheight},
  textheight=.82\slideheight,
  titlepos={\FU@left,.94\slideheight},
  titlewidth=.7\slidewidth,
}{\psline[linecolor=FUblue,linewidth=0.7pt](0,2.5ex)(\slidewidth,2.5ex)
  \psline[linecolor=FUblue,linewidth=0.7pt](0,0.88\slideheight)(\slidewidth,0.88\slideheight)
}

\pddefinetemplate[basic]{slide}{
  textpos={\FU@left,.87\slideheight},
  textwidth=\FU@textwidth,
}{}

\pddefinetemplate[basic]{wideslide}{%
  textpos={\FU@left,.87\slideheight},
  textwidth=\FU@textwidth,
}{}

\pddefinetemplate[slide]{sectionslide}{%
  titlehook=c,
  titlefont=\bfseries\LARGE\centering\color{FUred},
  titlewidth=0.9\FU@textwidth,
  titlepos={.5\slidewidth,.6\slideheight},
}{}
\pddefinetemplate[wideslide]{sectionwideslide}{%
  titlehook=c,
  titlefont=\bfseries\LARGE\centering,
  titlepos={.5\slidewidth,.6\slideheight},
  titlewidth=.9\FU@textwidth
}{}
\setkeys[pd]{section}{sectemp=sectionslide,widesectemp=sectionwideslide}

\def\labelitemi{\footnotesize\ding{110}}
\def\labelitemii{\small\ding{117}}
\def\labelitemiii{\tiny\ding{110}}
\def\labelitemiv{\tiny\ding{117}}

\pdsetup{list={labelsep=1em,leftmargin=*,itemsep=0pt,topsep=5pt,parsep=0pt},
         lf={\tiny\color{FUblue}\insertfachbereich, \@title, \@date}}

\def\pd@maketitle[#1]{%
  \begin{titleslide}[#1,toc=,bm=,trans=Replace]{}%
    \let\footnote\thanks
    \def\thefootnote{\@fnsymbol\c@footnote}%
    {\pd@@titlefont\@title}\par\medskip
    {\bfseries\normalsize\raggedright\insertsubtitle}\par
    \vskip2em\pd@@textfont
    \begin{tabularx}{\pd@@textwidth}{@{} >{\pd@@textfont}X @{}}%
        \@author\\
        \tiny\insertinstitute
     \end{tabularx}\par
      \vskip1.5em{\pd@@textfont\small\@date}\par
    \small\@thanks
    \vfil\null
  \end{titleslide}%
  \c@footnote\z@
}
\renewcommand\familydefault{\sfdefault}
\makeatother

\endinput

