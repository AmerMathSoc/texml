%%
%% This is file `scrjrnl.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% scrjrnl.dtx  (with options: `package')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2011-2012 by Raphaël Pinson <raphink@gmail.com>
%% --------------------------------------------------------------------------
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{scrjrnl}
    [2012/09/24 0.1 A class to typeset diaries or journals]
%% Index by day
%% Get the date for the recorded day
%% Go through index items
%% Patch imakeidx to map journal entry instead of page
\ProvidesClass{scrjrnl}
\DeclareOption{scrartcl}{\def\jrnl@class{scrartcl}}
\DeclareOption{scrreprt}{\def\jrnl@class{scrreprt}}
\DeclareOption{scrbook}{\def\jrnl@class{scrbook}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\jrnl@class}}
\ExecuteOptions{scrbook}
\newif\if@jrnl@monthpages
\DeclareOption{monthpages}{\@jrnl@monthpagestrue}
\newif\if@jrnl@fancytabs
\DeclareOption{fancytabs}{\@jrnl@fancytabstrue}
\newif\if@jrnl@cleardaypages
\DeclareOption{cleardaypages}{\@jrnl@cleardaypagestrue}
\ProcessOptions\relax
\LoadClass{\jrnl@class}
\RequirePackage{titlesec}
\AfterPackage!{babel}{\RequirePackage{datetime}}
\newcommand\jrnlformatdate\formatdateny
\newcommand\jrnlformatindexdate\formatdateny
\def\formatdateny{\csname noyear\languagename\expandafter\endcsname\formatdate}

\def\noyearenglish#1, \the\@year{#1}
\let\noyearamerican\noyearenglish
\let\noyearbritish\noyearenglish
\def\noyearfrench#1\space\number\@year{#1}
\let\noyeargerman\noyearfrench
\let\noyearaustrian\noyeargerman
\let\noyearswedish\noyearfrench
\let\noyearbreton\noyearfrench
\def\noyearrussian#1\ \number\@year~\cyrg.{#1}
\def\noyearspanish#1\ de~\number\@year{#1}
\let\noyearcatalan\noyearspanish
\def\noyearbasque#1\number\@year.eko\space{#1}
\newlength{\jrnldaysepskip}
\setlength{\jrnldaysepskip}{0pt}
\newlength{\jrnldayafterskip}
\setlength{\jrnldayafterskip}{2\baselineskip}
%%\if@jrnl@fancytabs
\RequirePackage{fancytabs}[2012/09/24]
%%\fi
\newcommand{\jrnl@monthname}[1]{\monthname[#1]}
\newcommand{\jrnl@curmonth}{\jrnl@monthname{\thejrnlmonth}}
\newcounter{jrnlstartchapter}
\newcounter{jrnlday}
\newcounter{jrnlmonth}
\newcounter{jrnlyear}
\newcounter{jrnltotalday}
\newcommand{\HTMLchapHook}[1]{}
\newcommand{\HTMLsecHook}[2]{}
\newcounter{jrnlmonthstartday}
\define@key{jrnlmonth}{month}{\setcounter{jrnlmonth}{#1}\addtocounter{jrnlmonth}{-1}}
\define@key{jrnlmonth}{startday}{\setcounter{jrnlmonthstartday}{#1}\addtocounter{jrnlmonthstartday}{-1}}

\newcommand{\jrnlmonth}[1][]{%
  % Use \thejrnlstatday if first month of journal
  \setcounter{jrnlmonthstartday}{\thejrnlstartday}%
  \setcounter{jrnlstartday}{0}%
  \setkeys{jrnlmonth}{#1}%
  \stepcounter{jrnlmonth}%
  \HTMLchapHook{\jrnl@curmonth}%
  \if@jrnl@monthpages
    \chapter{\jrnl@curmonth}%
    \cleardoublepage%
  \else
    \refstepcounter{chapter}%
    \@maybeautodot\thechapter
    \addchaptertocentry{\thechapter}{\jrnl@curmonth}%
  \fi
  \setcounter{jrnlday}{\thejrnlmonthstartday}%
}
\newcommand{\jrnl@pagedate}{%
  \jrnlformatdate{\thejrnlday}{\thejrnlmonth}{\thejrnlyear}%
}
\define@key{jrnlday}{day}{\setcounter{jrnlday}{#1}\addtocounter{jrnlday}{-1}}
\define@key{jrnlday}{ante}{\def\jrnlday@ante{#1}}
\define@key{jrnlday}{post}{\def\jrnlday@post{#1}}

\newcommand{\jrnlday}[2][]{%
  \def\jrnlday@ante{}%
  \def\jrnlday@post{}%
  \setkeys{jrnlday}{#1}%
  \stepcounter{jrnlday}%
  \stepcounter{jrnltotalday}%
  \if@jrnl@cleardaypages
  \cleardoublepage
  \fi
  \newpage\section{#2}%
  % TODO: provide index macros to be used with jrnlpagedate\thepage
  \expandafter\xdef\csname jrnldaydate\thejrnltotalday\endcsname{%
    \noexpand\jrnlformatindexdate{\thejrnlday}{\thejrnlmonth}{\thejrnlyear}%
}%
  \HTMLsecHook{\jrnlday@ante\jrnlformatdate{\thejrnlday}{\thejrnlmonth}{\thejrnlyear}\jrnlday@post}{#2}%
}
\newcommand\dayheadfont{}
\newcommand\monthheadfont{}
\newcommand\jrnl@titlestrut{\vrule height 25pt width0pt\relax}
\newcommand{\jrnl@secstyle}{\filcenter\dayheadfont\huge}
\newcommand{\jrnl@seclblstyle}{\raggedright\normalfont\scshape\Large}
\newcommand{\jrnl@seclbl}{\jrnl@seclblstyle\jrnlday@ante\jrnl@pagedate\jrnlday@post\\}

\newcommand{\jrnl@chapstyle}{\filcenter\monthheadfont\Huge\textsc}
\newcounter{jrnlstartmonth}
\newcounter{jrnlstartday}
\define@key{jrnl}{startmonth}{\setcounter{jrnlstartmonth}{#1}\addtocounter{jrnlstartmonth}{-1}}
\define@key{jrnl}{startday}{\setcounter{jrnlstartday}{#1}\addtocounter{jrnlstartday}{-1}}
\newlength{\jrnl@bleed}
\define@key{jrnl}{bleed}{\setlength{\jrnl@bleed}{#1}}

\newenvironment{journal}[1][]%
{%
\setcounter{jrnlstartmonth}{0}%
\setcounter{jrnlstartday}{0}%
\setkeys{jrnl}{#1}%
\setcounter{jrnlstartchapter}{\thechapter}
\addtocounter{jrnlmonth}{\thejrnlstartmonth}

\titleformat{\chapter}[block]
  {\vfill}
  {}{0pt}
  {\jrnl@chapstyle}
  [\vfill\vfill]

\if@jrnl@fancytabs
  % We know \paperheight and bleed
  % Calculation base:
  % 6*fancytabsHeight+2*fancytabsTop+5*fancytabsGap = paperheight
  % fancytabsHeight = 10*fancytabsGap
  % fancytabsTop = 5*fancytabsGap + 2*bleed

  % Calculate \calcfancytabsGap as (\the\paperheight-2*bleed)/75
  \newlength{\calcfancytabsGap}
  \pgfmathsetlength{\calcfancytabsGap}{\the\paperheight-2*\the\jrnl@bleed)/75}
  \fancytabsGap{\the\calcfancytabsGap}

  % Calculate \calcfancytabsHeight as 10*\calcfancytabsGap
  \newlength{\calcfancytabsHeight}
  \pgfmathsetlength{\calcfancytabsHeight}{10*\calcfancytabsGap}
  \fancytabsHeight{\the\calcfancytabsHeight}

  % Calculate \calcfancytabsTop as (5*\calcfancytabsGap+2\jrnl@bleed)
  \newlength{\calcfancytabsTop}
  \pgfmathsetlength{\calcfancytabsTop}{5*\calcfancytabsGap+2*\the\jrnl@bleed}
  \fancytabsTop{\the\calcfancytabsTop}

  % Calculate \fancytabsWidth, without bleed
  \newlength{\calcfancytabsWidth}
  \pgfmathsetlength{\calcfancytabsWidth}{\the\paperwidth/12}

  % Calculate \fancytabsWidthBleed, with bleed
  \newlength{\calcfancytabsWidthBleed}
  \pgfmathsetlength{\calcfancytabsWidthBleed}{\the\calcfancytabsWidth+\the\jrnl@bleed}
  \fancytabsWidth{\the\calcfancytabsWidthBleed}

  \fancytabsTextVPos{0.5}
  % Put text more inside
  % \fancytabsTextHPos = (\fancytabsWidth/2)/\fancytabsWidthBleed
  \pgfmathsetmacro{\calcfancytabsTextHPos}{(\the\calcfancytabsWidth/2)/(\the\calcfancytabsWidthBleed)}
  \fancytabsTextHPos{\calcfancytabsTextHPos}

  \newcommand{\jrnl@fancytab}{%
    \ifthenelse{\isodd{\thepage}}%
      {\fancytab{\jrnl@curmonth}{\thejrnlmonth}}%
      {}%
  }
\else
  \newcommand{\jrnl@fancytab}{}%
\fi

\titleformat{\section}[display]
  {\jrnl@secstyle} % format
  {\jrnl@seclbl} % label
  {\jrnldaysepskip} %sep
  {\jrnl@fancytab%
   \jrnl@titlestrut\filcenter} %before
  [\vspace{\jrnldayafterskip}] %after

\titlespacing{\section}{0pt}{*}{-3pt}

} % end of \begin{devotional}
{} % end of \end{devotional}
\endinput
%%
%% End of file `scrjrnl.cls'.
