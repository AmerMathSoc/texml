%%
%% This is file `mwrep.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mwcls.dtx  (with options: `report')
%% 
%% This is a generated file.
%% 
%% Copyright 2000-2009 by Marcin Woli\'nski <wolinski@gust.org.pl>
%% 
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.2
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{mwrep}
              [2009/09/27 v0.74
 A LaTeX document class (MW)]
\typeout{*** Beta version.  Formatting may change}
\typeout{*** in future versions of this class.}
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\ifHeadingNumbered
\ifx\l@nohyphenation\@undefined
        \newlanguage\l@nohyphenation
\fi
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{a6paper}
   {\setlength\paperheight {148mm}%
    \setlength\paperwidth  {105mm}}
\DeclareOption{b4paper}
   {\setlength\paperheight {353mm}%
    \setlength\paperwidth  {250mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{b6paper}
   {\setlength\paperheight {176mm}%
    \setlength\paperwidth  {125mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\newif\if@wide
\DeclareOption{wide}
    {\@widetrue}
\newif\if@marginparsused
\DeclareOption{withmarginpar}
    {\@marginparsusedtrue}
\DeclareOption{withoutmarginpar}
    {\@marginparsusedfalse}
\newcommand\mw@usedd{\p@=1dd
 \def\@vpt{5dd}%
 \def\@vipt{6dd}%
 \def\@viipt{7dd}%
 \def\@viiipt{8dd}%
 \def\@ixpt{9dd}%
 \def\@xpt{10dd}%
 \def\@xipt{11dd}%
 \def\@xiipt{12dd}%
 \def\@xivpt{14dd}%
 \def\@xviipt{16dd}%
 \def\@xxpt{18dd}%
 \def\@xxvpt{24dd}%
}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}\def\@basesize{10}}
\DeclareOption{10dd}{\renewcommand\@ptsize{0}\def\@basesize{10}\@usedd}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}\def\@basesize{11}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}\def\@basesize{12}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\newcommand*\sectsettings{\bfseries}
\newcommand*\titlesettings{}
\DeclareOption{rmheadings}{%
  \def\sectsettings{\rmfamily\bfseries}%
  \def\titlesettings{\rmfamily}%
  }
\DeclareOption{sfheadings}{%
  \def\sectsettings{\sffamily\bfseries}%
  \def\titlesettings{\sffamily}%
  }
\newcommand*\captionsettings{\small}
\DeclareOption{floatssmall}{%
  \def\figuresettings{\small}%
  \def\tablesettings{\small}%
  }
\DeclareOption{floatsnormalsize}{%
  \def\figuresettings{\normalsize}%
  \def\tablesettings{\normalsize}%
  }
\newif\if@authorfirst
\DeclareOption{authortitle}{\@authorfirsttrue}
\DeclareOption{titleauthor}{\@authorfirstfalse}
\DeclareOption{indentfirst}{\@afterindenttrue}
\DeclareOption{noindentfirst}{\@afterindentfalse}
\ExecuteOptions{a4paper,10pt,oneside,onecolumn,%
        final,openany,authortitle,withoutmarginpar,indentfirst,floatsnormalsize}
\ProcessOptions
\input{mw\@basesize.clo}
\def\markboth#1#2{%
  \begingroup
    \let\label\relax \let\index\relax \let\glossary\relax
    \unrestored@protected@xdef\@themark {{#1}{#2}}%
    \@temptokena \expandafter{\@themark}%
    \mark{\the\@temptokena}%
  \endgroup
  \if@nobreak\ifvmode\nobreak\fi\fi}
\def\markright#1{%
  \begingroup
    \let\label\relax \let\index\relax \let\glossary\relax
    \expandafter\@markright\@themark {#1}%
    \@temptokena \expandafter{\@themark}%
    \mark{\the\@temptokena}%
  \endgroup
  \if@nobreak\ifvmode\nobreak\fi\fi}
\def\@markright#1#2#3{\@temptokena {#1}%
  \unrestored@protected@xdef\@themark{{\the\@temptokena}{#3}}}
\def\secondarysize{\small}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{\z@}
\if@twocolumn
  \setlength\parindent{1em}
\else
  \setlength\parindent{1.5em}
\fi
\newdimen\@parindent
%%\parindent32pt % wartość testowa.  Wyrzucic!
\@parindent\parindent
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\hyphenpenalty=100
\exhyphenpenalty=10000
\widowpenalty 10000
\clubpenalty  5000
 \displaywidowpenalty 5000
\def\@fnsymbol#1{\ensuremath{\ifcase#1\or *\or **\or *{*}*
  \else\@ctrerr\fi}}
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\newcommand\hf@empty{%
  \let\@oddhead\@empty \let\@oddfoot\@empty
  \let\@evenhead\@empty \let\@evenfoot\@empty}
\newcommand\hf@plain{%
  \let\@oddhead\@empty
  \def\@oddfoot{\reset@font\hfil\thepage\hfil}%
  \let\@evenhead\@empty
  \let\@evenfoot\@oddfoot}
\newcommand\hf@outer{%
  \let\@oddhead\@empty
  \def\@oddfoot{\reset@font\hfil\thepage}%
  \let\@evenhead\@empty
  \def\@evenfoot{\reset@font\thepage\hfil}}
\newcommand\heading@font{\small\itshape}
\newcommand\hf@headings{%
  \def\@oddhead{\reset@font{\heading@font\rightmark}\hfil\thepage}%
  \let\@oddfoot\@empty
  \def\@evenhead{\reset@font\thepage\hfil\heading@font\leftmark}%
  \let\@evenfoot\@empty
  }
\newcommand\hf@uheadings{%
  \def\@oddhead{\vtop{%
      \hb@xt@\textwidth{%
        \reset@font{\heading@font\rightmark}\hfil\thepage\strut}%
      \vskip2pt\hrule\vskip-2.4pt}}%
  \let\@oddfoot\@empty
  \def\@evenhead{\vtop{%
      \hb@xt@\textwidth{%
        \reset@font\strut\thepage\hfil\heading@font\leftmark}%
      \vskip2pt\hrule\vskip-2.4pt}}%
  \let\@evenfoot\@empty
  }
\def\ps@empty{%
  \let\@mkboth\@gobbletwo
  \let\ps@normal\hf@empty
  \let\ps@opening\hf@empty
  \let\ps@closing\hf@empty
  \let\ps@blank\hf@empty
  \ps@normal}
\def\ps@plain{%
  \let\@mkboth\@gobbletwo
  \let\ps@normal\hf@plain
  \let\ps@opening\hf@plain
  \let\ps@closing\hf@empty
  \let\ps@blank\hf@empty
  \ps@normal}
\def\ps@outer{%
  \let\@mkboth\@gobbletwo
  \let\ps@normal\hf@outer
  \let\ps@opening\hf@outer
  \let\ps@closing\hf@empty
  \let\ps@blank\hf@empty
  \ps@normal}
\if@twoside
  \def\ps@headings{%
    \let\@mkboth\markboth
    \let\ps@normal\hf@headings
    \let\ps@opening\hf@empty
    \let\ps@closing\hf@headings
    \let\ps@blank\hf@empty
    \ps@normal
    \def\chaptermark##1{%
      \markboth{%
        \ifHeadingNumbered
            \thechapter.\enspace
        \fi
        ##1}{}}%
    \def\sectionmark##1{%
      \markright{%
        \ifHeadingNumbered \thesection.\enspace \fi
        ##1}}}
\else
  \def\ps@headings{%
    \let\@mkboth\markboth
    \let\ps@normal\hf@headings
    \let\ps@opening\hf@empty
    \let\ps@closing\hf@headings
    \let\ps@blank\hf@empty
    \ps@normal
    \def\chaptermark##1{%
      \markright{%
        \ifHeadingNumbered
            \thechapter.\enspace
        \fi
        ##1}}}
\fi
\def\ps@myheadings{%
    \let\ps@normal\hf@headings
    \let\ps@opening\hf@empty
    \let\ps@closing\hf@headings
    \let\ps@blank\hf@empty
    \ps@normal
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
\if@twoside
  \def\ps@uheadings{%
    \let\@mkboth\markboth
    \let\ps@normal\hf@uheadings
    \let\ps@opening\hf@empty
    \let\ps@closing\hf@uheadings
    \let\ps@blank\hf@empty
    \ps@normal
    \def\chaptermark##1{%
      \markboth{%
        \ifHeadingNumbered
            \thechapter.\enspace
        \fi
        ##1}{}}%
    \def\sectionmark##1{%
      \markright{%
        \ifHeadingNumbered \thesection.\enspace \fi
        ##1}}}
\else
  \def\ps@uheadings{%
    \let\@mkboth\markboth
    \let\ps@normal\hf@uheadings
    \let\ps@opening\hf@empty
    \let\ps@closing\hf@uheadings
    \let\ps@blank\hf@empty
    \ps@normal
    \def\chaptermark##1{%
      \markright{%
        \ifHeadingNumbered
            \thechapter.\enspace
        \fi
        ##1}}}
\fi
\def\ps@myuheadings{%
    \let\ps@normal\hf@uheadings
    \let\ps@opening\hf@empty
    \let\ps@closing\hf@uheadings
    \let\ps@blank\hf@empty
    \ps@normal
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
\let\@date\@empty
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfill
  \begin{center}%
  \titlesettings
  {\large
    \if@authorfirst\else
    {\LARGE \@title \par}%
    \vskip6ex \fi
      {\normalsize
      \begin{tabular}[t]{c}%
        \Large\strut\@author
      \end{tabular}\par}%
    \if@authorfirst
        \vskip6ex
    {\LARGE \@title \par}\fi
  }%
  \end{center}\par
  \vfill\vfill
  {\centering\normalsize \@date \par}
  \@thanks
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\and{\\\Large\strut}
\else
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \long\def\@makefntext##1{
        \parindent\@parindent
        \@textsuperscript{\normalfont\@thefnmark}\enspace##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{opening}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2\baselineskip
  \begin{center}%
  \let \footnote \thanks
    \titlesettings\large
    \if@authorfirst\else
    {\LARGE \@title \par}%
    \vskip\baselineskip \fi
    {\normalsize
      \begin{tabular}[t]{c}%
        \large\strut\@author
      \end{tabular}\par}%
    \if@authorfirst
      \vskip\baselineskip
    {\LARGE \@title \par}\fi
    \ifx\@date\@empty\else
    \vskip \baselineskip
    {\normalsize\@date}\fi
  \end{center}%
  \par
  \vskip 2\baselineskip
  }
\def\and{%                  % \begin{tabular}
  \end{tabular}%
  \quad
  \begin{tabular}[t]{c}%
  \large\strut}%   % \end{tabular}
\fi
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      \normalfont\sectsettings#6{%
        \language\l@nohyphenation \raggedright
        \interlinepenalty \@M
        \leftskip #3\noindent
        \@svsec\ignorespaces
        #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname.}%
      \fi
      #8}%
  \else
    \def\@svsechd{%
      \normalfont\sectsettings#6{\hskip #3\relax
      \@svsec\ignorespaces #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname.}%
        \fi
        #8}}%
  \fi
  \@xsect{#5}}
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      \normalfont\sectsettings#4{%
        \language\l@nohyphenation \raggedright
        \interlinepenalty \@M
        \leftskip #1\noindent\ignorespaces
        #5\@@par}%
    \endgroup
  \else
    \def\@svsechd{\normalfont\sectsettings#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\newcommand*\partmark[1]{\markboth{}{}}
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\def\part@level{-1}
\def\chapter@level{0}
\def\section@level{1}
\def\subsection@level{2}
\def\subsubsection@level{3}
\def\paragraph@level{4}
\def\subparagraph@level{5}
\newcommand\@chapapp{\chaptername}
\renewcommand*\@seccntformat[1]{\csname the#1\endcsname.\enspace}
\def\cleardoublepage{\clearpage
  \if@twoside
    \ifodd\c@page\else
      \hbox{}\thispagestyle{blank}\newpage
      \if@twocolumn\hbox{}\newpage\fi
    \fi
  \fi}
\newcommand*\mw@getflags[1]{%
  \expandafter\expandafter\expandafter
  \mw@getflagsx\csname#1@flags\endcsname}
\newcommand*\mw@getflagsx[4]{%
  \def\mw@HeadingRunIn{1#1}%
  \def\mw@HeadingBreakBefore{1#2}%
  \def\mw@HeadingBreakAfter{1#3}%
  \def\mw@HeadingWholeWidth{1#4}%
}
\newcommand*\mw@setflags[1]{%
  \expandafter\edef\csname#1@flags\endcsname{%
    \if\mw@HeadingRunIn 1\else 0\fi
    \if\mw@HeadingBreakBefore 1\else 0\fi
    \if\mw@HeadingBreakAfter 1\else 0\fi
    \if\mw@HeadingWholeWidth 1\else 0\fi
  }
 }
\newcommand*\mw@section[1]{%
  \mw@getflags{#1}%
  \if@noskipsec \leavevmode \fi
  \par
  \if@nobreak \everypar{}\fi
  \@ifstar
    {\HeadingNumberedfalse\@dblarg{\mw@sectionx{#1}}}%
    {\HeadingNumberedtrue\@dblarg{\mw@sectionx{#1}}}}
\def\mw@sectionx#1[#2]{%
  \@dblarg{\mw@sectionxx{#1}{#2}}}
\def\mw@sectionxx#1#2[#3]#4{%
  \if\mw@HeadingBreakBefore
    \if@specialpage\else\thispagestyle{closing}\fi
 \if@openright\cleardoublepage\else
            \clearpage
 \fi
    \if\mw@HeadingBreakAfter
      \thispagestyle{blank}\else
      \thispagestyle{opening}\fi
       \global\@topnum\z@
    \fi
  \edef\mw@HeadingLevel{\csname #1@level\endcsname
        \space}% space delimits level number!
  \ifHeadingNumbered
      \ifnum \mw@HeadingLevel>\c@secnumdepth \HeadingNumberedfalse \fi
  \fi
  \ifHeadingNumbered
    \refstepcounter{#1}%
    \protected@edef\HeadingNumber{\expandafter\noexpand
\csname the#1\endcsname\relax}%
  \else
    \mw@hyperref@phantom{#1}%
    \let\HeadingNumber\@empty
  \fi
  \def\HeadingRHeadText{#2}%
  \def\HeadingTOCText{#3}%
  \def\HeadingText{#4}%
  \def\mw@HeadingType{#1}%
%%
  \if\mw@HeadingRunIn
    \mw@runinheading
  \else
    \if\mw@HeadingWholeWidth
      \if@twocolumn
        \if\mw@HeadingBreakAfter
        \onecolumn
        \mw@normalheading
        \pagebreak\relax
              \if@twoside
                \null
                \thispagestyle{blank}%
                \newpage
              \fi
        \twocolumn
        \else
          \@topnewpage[\mw@normalheading]%
          \mw@markandtoc
        \fi
      \else
        \mw@normalheading
        \if\mw@HeadingBreakAfter\pagebreak\relax\fi
      \fi
    \else
      \mw@normalheading
      \if\mw@HeadingBreakAfter\pagebreak\relax\fi
    \fi
  \fi
  }
\newcommand*\mw@markandtoc{%
     \csname \mw@HeadingType mark\endcsname{\HeadingRHeadText}%
     \ifnum \mw@HeadingLevel>\c@tocdepth \else
       \expandafter\ifx\csname \mw@HeadingType @toc\endcsname\relax
         \addcontentsline{toc}{\mw@HeadingType }{\ifHeadingNumbered
           \protect\numberline{\mw@seccntformat{\HeadingNumber}}\fi
           \HeadingTOCText}%
       \else
         \csname \mw@HeadingType @toc\endcsname
       \fi
     \fi
  }%
\def\mw@seccntformat#1{#1.\enspace}
\newcommand*\mw@normalheading{%
  \if\mw@HeadingBreakBefore \hrule\@height\z@\nobreak
     \else \addpenalty\@secpenalty \fi
  \addvspace{\csname \mw@HeadingType @preskip\endcsname}%
  \bgroup\language\l@nohyphenation
   \raggedright
   \interlinepenalty\@M
   \normalfont\sectsettings
   \csname \mw@HeadingType @head\endcsname
   \@@par
  \egroup
  \ifnum0<%
    \if@twocolumn0\else1\fi
    \if\mw@HeadingWholeWidth0\else1\fi
    \if\mw@HeadingBreakAfter1 \else0 \fi
  \mw@markandtoc\fi
  \nobreak
  \vskip\csname\mw@HeadingType @postskip\endcsname
  \@afterheading
 }
\newcommand*\mw@runinheading{%
    \addvspace{\csname \mw@HeadingType @preskip\endcsname}%
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \bgroup\language\l@nohyphenation
           \normalfont\sectsettings
           \csname \mw@HeadingType @head\endcsname
        \egroup
        \mw@markandtoc
        \hspace{\csname\mw@HeadingType @postskip\endcsname}%
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}
}
\let\@titleindent\z@

\newcommand*\FormatBlockHeading[1]{%
  \leftskip\@titleindent
  #1{\noindent
  \ifHeadingNumbered\mw@seccntformat\HeadingNumber\fi
  \ignorespaces\HeadingText\@@par}
  }
\newcommand*\FormatHangHeading[1]{%
  #1{%
    \@hangfrom{\hskip\@titleindent
        \ifHeadingNumbered\mw@seccntformat\HeadingNumber\fi}%
    \ignorespaces\HeadingText\@@par}%
  }
\newcommand*\FormatChapterHeading[3]{%
  \ifHeadingNumbered
   #2\HeadingNumber\par\nobreak
   \vspace{#1}%
  \fi
  #3\HeadingText\par\nobreak
  }
\newcommand*\FormatRigidChapterHeading[4]{%
  \nointerlineskip
  \vbox to#1{\color@begingroup
    \vfil
    \ifHeadingNumbered
     #3\HeadingNumber\par\nobreak
     \vspace{#2}%
    \fi
    #4\HeadingText\par\nobreak
    \color@endgroup
  }%
}
\newcommand*\FormatRunInHeading[1]{%
  \hskip\@titleindent
  #1{%
  \ifHeadingNumbered\mw@seccntformat\HeadingNumber\fi
  \ignorespaces\HeadingText\unskip}%
}
\newcommand*\SetSectionFormatting[5][default]{%
 \def\mw@HeadingRunIn{10}\def\mw@HeadingBreakBefore{10}%
 \def\mw@HeadingBreakAfter{10}\def\mw@HeadingWholeWidth{10}%
 \mw@processflags#1,\relax
 \expandafter\def\csname #2\endcsname{\mw@section{#2}}%
 \expandafter\def\csname #2@preskip\endcsname{#3}%
 \expandafter\def\csname #2@head\endcsname{#4}%
 \expandafter\def\csname #2@postskip\endcsname{#5}%
 \mw@setflags{#2}%
 }
\newcommand*\DeclareSectioningCommand[3][default]{%
        \SetSectionFormatting[#1]{#2}}
\def\mw@processflags#1,#2\relax{%
  \expandafter\ifx\csname sec@@flag@#1\endcsname\relax
        \ClassError{mwcls}{Unknown sectioning flag `#1'}{}\else
  \csname sec@@flag@#1\endcsname\fi
  \if,#2,\else \mw@processflags#2\relax \fi
  }
\def\sec@@flag@default{}
\def\sec@@flag@runin{\def\mw@HeadingRunIn{11}}
\def\sec@@flag@breakbefore{\def\mw@HeadingBreakBefore{11}}
\def\sec@@flag@breakafter{\def\mw@HeadingBreakAfter{11}}
\def\sec@@flag@wholewidth{\def\mw@HeadingWholeWidth{11}}
\SetSectionFormatting[breakbefore,breakafter,wholewidth]{part}
        {0\p@ plus1fil}
        {\FormatChapterHeading{20\p@}%
                {\centering\large\partname\space}%
                {\centering\LARGE}}
        {0\p@ plus1fil}
\SetSectionFormatting[breakbefore,wholewidth]{chapter}
        {56\p@}
        {\FormatBlockHeading{\LARGE}}
        {24\p@}
\newcommand*\chapter@toc{%
  \ifHeadingNumbered\typeout{\@chapapp\space\thechapter.}\fi
  \addcontentsline{toc}{chapter}{%
        \ifHeadingNumbered
 \protect\numberline{\mw@seccntformat{\HeadingNumber}}%
        \fi
        \HeadingTOCText}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  }
\SetSectionFormatting{section}
        {24\p@\@plus5\p@\@minus2\p@}
        {\FormatHangHeading{\large}}
        {10\p@\@plus3\p@}
\SetSectionFormatting{subsection}
        {16\p@\@plus4\p@\@minus1\p@}
        {\FormatHangHeading{}}
        {6\p@\@plus2\p@}
\SetSectionFormatting{subsubsection}
        {10\p@\@plus2\p@\@minus1\p@}
        {\FormatHangHeading{}}
        {4\p@\@plus1\p@}
\SetSectionFormatting[runin]{paragraph}
        {\bigskipamount}
        {\FormatRunInHeading{}}
        {.5em}
\SetSectionFormatting[runin]{subparagraph}
        {\medskipamount}
        {\FormatRunInHeading{}}
        {.5em}
\setlength\leftmargini{1\parindent}
\leftmargin  \leftmargini
\setlength\leftmarginii  {\parindent}
\setlength\leftmarginiii {\parindent}
\setlength\leftmarginiv  {\parindent}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{0\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\def\@listi{\leftmargin\leftmargini
  \parsep  \z@
  \topsep  .5\baselineskip plus .25\baselineskip minus
           .125\baselineskip
  \itemsep \z@}
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep  \z@
              \parsep  \z@
              \itemsep \z@}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \itemsep   \z@}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\partopsep\topsep \topsep\z@ %MW
        \usecounter\@enumctr\def\makelabel##1{##1\hfil}}%
  \fi}
\newenvironment*{enumerate*}{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\partopsep\topsep \topsep\z@ %MW
        \leftmargin\z@ \labelwidth\z@
        \itemindent\@parindent \advance\itemindent\labelsep
        \usecounter\@enumctr\def\makelabel##1{##1\hfil}}%
  \fi}
  {\endlist}
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\partopsep\topsep \topsep\z@ %MW
      \def\makelabel##1{##1\hfil}}%
  \fi}
\newenvironment*{itemize*}{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\partopsep\topsep \topsep\z@ %MW
      \leftmargin\z@ \labelwidth\z@
      \itemindent\@parindent \advance\itemindent\labelsep
      \def\makelabel##1{##1\hfil}}%
  \fi}
  {\endlist}
\newcommand\labelitemi{\textemdash}
\newcommand\labelitemii{\textemdash}
\newcommand\labelitemiii{\textemdash}
\newcommand\labelitemiv{\textemdash}
\newenvironment{description}
        {\list{}{\partopsep\topsep \topsep\z@ %MW
         \labelwidth\z@ \itemindent-\leftmargin
         \let\makelabel\descriptionlabel}}
        {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\if@titlepage
  \newenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \newenvironment{abstract}{%
      \if@twocolumn
        \section*{\abstractname}%
      \else
        \small
        \begin{center}%
          {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
        \end{center}%
        \quotation
      \fi}
      {\if@twocolumn\else\endquotation\fi}
\fi
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \parsep \medskipamount
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\def\@begintheorem#1#2{\trivlist
   \item[\hskip \labelsep{\bfseries #1\ #2.}]\itshape}
\def\@opargbegintheorem#1#2#3{\trivlist
      \item[\hskip \labelsep{\bfseries #1\ #2.\ (#3)}]\itshape}
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{blank}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\def\@floatboxreset{%
  \reset@font
  \normalsize
  \@setminipage
  \csname\@captype settings\endcsname
}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\def\centeredlast{%
  \let\\\@centercr
  \rightskip\z@\@plus-.5fil
  \leftskip\z@\@plus.5fil
  \parindent\z@
  \parfillskip\@flushglue
  }
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{.5\baselineskip}
\setlength\belowcaptionskip{.5\baselineskip}
\long\def\@caption#1[#2]#3{%
  \par
  \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{\csname the#1\endcsname.}{\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \captionsettings
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}
\long\def\@makecaption#1#2{%
  \addvspace\abovecaptionskip
  \bgroup\centeredlast
    #1.\enspace#2\par
  \egroup
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em plus 2cm}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
  {\@tempcnta=\c@tocdepth
   \c@tocdepth=-1
\chapter*%
        {\contentsname}%
        \protect\@mkboth{\contentsname}{\contentsname}%
     \c@tocdepth=\@tempcnta
    \secondarysize
    \gdef\previous@toc@level{-1000}%
    \@starttoc{toc}}%
    \if@restonecol\twocolumn\fi
    }
\def\mw@tocskip#1#2{%
     \ifnum#1>\previous@toc@level
        \nobreak
     \else\ifnum#1<\previous@toc@level
        \addpenalty\@secpenalty % czy to dobra wartosc?
     \fi\fi
    \gdef\previous@toc@level{#1}%
    \vskip #2\relax
}
\def\mw@tocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \mw@tocskip{#1}{\z@ \@plus.2\p@}%
    {\leftskip #3\relax
     \@tempdima #3\relax
     \advance\@tempdima -#2\relax
     \rightskip \@tocrmarg \parfillskip -\rightskip
     \interlinepenalty\@M
     \noindent\kern-\@tempdima{\ignorespaces#4}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}
\newcommand*\SetTOCIndents[1]{\bgroup
  \reset@font\secondarysize
  \setbox\@tempboxa\hbox{}%
  \set@tocindentsX
{}%
#1\relax
  \egroup
  }
\def\set@tocindentsX#1#2{%
  \ifx\relax#2\expandafter\@gobble\else
  \setbox\@tempboxa\hbox{\unhbox\@tempboxa#2}%
  \expandafter\xdef\csname @tocindent#1\endcsname{\the\wd\@tempboxa}%
  \expandafter\set@tocindentsX
  \fi
  {#1i}%
  }
\SetTOCIndents{{}{\bf9.\enspace}{9.10.\enspace}{9.9.10.\enspace}{9.9.9.10\enspace}{\quad}{\quad}}
\def\numberline#1{\hb@xt@\@tempdima{#1\hfil}\ignorespaces}
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \mw@tocskip{-1}{.6\baselineskip}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode\normalsize
        \def\numberline##1{##1\enspace}%
        \hfil\bfseries #1\hfil\null %\hb@xt@\@pnumwidth{\hss #2}%
        }\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \addvspace{.4\baselineskip}%
  \fi}
\newcommand*\l@chapter[2]{\addvspace{.3\baselineskip}%
        \mw@tocline{0}{\@tocindent}{\@tocindenti}{\textbf{#1}}{#2}%
        \addvspace{.2\baselineskip}}
\newcommand*\l@section{\mw@tocline{1}{\@tocindenti}{\@tocindentii}}
\newcommand*\l@subsection{\mw@tocline{2}{\@tocindentii}{\@tocindentiii}}
\newcommand*\l@subsubsection{\mw@tocline{3}{\@tocindentiii}{\@tocindentiiii}}
\newcommand*\l@paragraph{\mw@tocline{4}{\@tocindentiiii}{\@tocindentiiiii}}
\newcommand*\l@subparagraph{\mw@tocline{5}{\@tocindentiiiii}{\@tocindentiiiiii}}
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}
    {\secondarysize
    \gdef\previous@toc@level{-1000}%
    \@starttoc{lof}}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@figure{\mw@tocline{1}{0pt}{2.5em}}
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}
    {\secondarysize
    \gdef\previous@toc@level{-1000}%
    \@starttoc{lot}}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]{%
        \def
 \chaptermark
        ##1{\@mkboth{##1}{##1}}%
 \chapter*{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}%
            \secondarysize}%
      \sloppy
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn
               \chapter*{\indexname}%
                \@mkboth{\indexname}{\indexname}%
                \thispagestyle{opening}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem
        \secondarysize}
               {\if@restonecol\onecolumn\else
        \clearpage
                \fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width4pc
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent\@parindent
    \indent\@makefnmark\enspace#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\pagestyle{plain}
\pagenumbering{arabic}
\flushbottom
\if@twocolumn
  \twocolumn
  \sloppy
\else
  \onecolumn
\fi
\AtBeginDocument{\@ifpackageloaded{natbib}{%
\renewcommand\bibsection{\chapter*{\bibname}%
  \@mkboth{\bibname}{\bibname}}%
}{}}
\let\mw@hyperref@phantom\@gobble
\AtBeginDocument{\@ifpackageloaded{hyperref}{%
    \def\mw@hyperref@phantom#1{%
      \Hy@GlobalStepCount\Hy@linkcounter
      \xdef\@currentHref{#1*.\the\Hy@linkcounter}%
      \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
    }%
}{}}
\def\@doendpe{\@endpetrue
  \clubpenalty\@clubpenalty
  \def\par{\@restorepar\everypar{}\par\@endpefalse}%
  \everypar{{\setbox\z@\lastbox}\everypar{}\@endpefalse}%
}
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\endinput
%%
%% End of file `mwrep.cls'.
