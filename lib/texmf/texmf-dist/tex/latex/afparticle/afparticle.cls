%%
%% This is file `afparticle.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% afparticle.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from afparticle.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file afparticle.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{afparticle}
[2014/12/23 v1.3 Typesetting articles for Archives of Forensic Psychology]
\def\AFP@DisableMacro#1{\ClassError{afparticle}{The macro
    \expandafter\protect\csname#1\endcsname\space
    is disabled}{The command
    \expandafter\protect\csname#1\endcsname\space
    is introduced in the
    elsarticle class.\MessageBreak  It is disabled in afpartcile
    class}}
\let\@xp=\expandafter
\let\@nx=\noexpand
\long\def\@ifempty#1{\@xifempty#1@@..\@nil}
\long\def\@xifempty#1#2@#3#4#5\@nil{%
  \ifx#3#4\@xp\@firstoftwo\else\@xp\@secondoftwo\fi}
\long\def\@ifnotempty#1{\@ifempty{#1}{}}
\newtoks\@emptytoks
\def\@andlista#1#2\and#3\and{\@andlistc{#2}\@ifnotempty{#3}{%
  \@andlistb#1{#3}}}
\def\@andlistb#1#2#3#4#5\and{%
  \@ifempty{#5}{%
    \@andlistc{#2#4}%
  }{%
    \@andlistc{#1#4}\@andlistb{#1}{#3}{#3}{#5}%
  }}
\let\@andlistc\@iden
\newcommand{\nxandlist}[4]{%
  \def\@andlistc##1{\toks@\@xp{\the\toks@##1}}%
  \toks@{\toks@\@emptytoks \@andlista{{#1}{#2}{#3}}}%
  \the\@xp\toks@#4\and\and
  \edef#4{\the\toks@}%
  \let\@andlistc\@iden}
\def\@@and{and}
\def\author@andify{%
  \nxandlist {\unskip ,\penalty-1 \space\ignorespaces}%
    {\unskip {} \@@and~}%
    {\unskip ,\penalty-2 \space\@@and~}%
}
\RequirePackage{xkeyval}
\def\AFP@OptionWarning#1{\ClassWarning{afparticle}{The option #1 is
    not used for afparticle.  I will silently ignore it}}
\DeclareOptionX{3p}{\AFP@OptionWarning{\CurrentOption}}%
\DeclareOptionX{5p}{\AFP@OptionWarning{\CurrentOption}}%
\DeclareOptionX{authoryear}{\AFP@OptionWarning{\CurrentOption}}%
\DeclareOptionX{number}{\AFP@OptionWarning{\CurrentOption}}%
\DeclareOptionX{sort&compress}{\AFP@OptionWarning{\CurrentOption}}%
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{elsarticle}}
\ProcessOptionsX
\@namedef{ver@natbib.sty}{}
\@namedef{opt@natbib.sty}{round,authoryear}
\newlength\bibsep
\LoadClass[1p,authoryear,round]{elsarticle}
\RequirePackage{lastpage,fancyhdr}
\RequirePackage{caption}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage[hyperfootnotes=false,colorlinks,allcolors=blue]{hyperref}
\expandafter\let\csname ver@natbib.sty\endcsname=\@undefined
\let\bibsep=\@undefined
\RequirePackage[natbibapa]{apacite}
\renewenvironment{abstract}{\global\setbox\absbox=\vbox\bgroup
  \hsize=\textwidth\def\baselinestretch{1}%
  \noindent\unskip\ignorespaces}
 {\egroup}
\def\tnoteref#1{\AFP@DisableMacro{tnoteref}}
\def\corref#1{\AFP@DisableMacro{corref}}
\def\fnref#1{\AFP@DisableMacro{fnref}}
\renewcommand*{\title}[2][]{\gdef\shorttitle{#1}\gdef\@title{#2}}
\edef\title{\@nx\@dblarg
  \@xp\@nx\csname\string\title\endcsname}
\newif\ifAFP@corrauthor
\def\authors{}
\def\shortauthors{\authors}
\def\author{%
  \@ifstar{\AFP@corrauthortrue\AFP@author}{\AFP@corrauthorfalse\AFP@author}}
\def\AFP@author{\@ifnextchar[{\@@author}{\@author}}
\def\@@author[#1]#2{%
  \ifx\@empty\authors
      \gdef\authors{#2}%
  \else
    \g@addto@macro\authors{\and#2}%
  \fi
  \g@addto@macro\elsauthors{%
    \normalsize\upshape
    \def\baselinestretch{1}%
    \authorsep#2\unskip}%
  \ifAFP@corrauthor
  \g@addto@macro\elsauthors{\textsuperscript{$\ast$,}}\fi
  \g@addto@macro\elsauthors{%
    \textsuperscript{%#1%
      \@for\@@affmark:=#1\do{%
        \edef\affnum{\@ifundefined{X@\@@affmark}{1}{\elsRef{\@@affmark}}}%
        \unskip\sep\affnum\let\sep=,}%
      \ifx\@fnmark\@empty\else\unskip\sep\@fnmark\let\sep=,\fi
      \ifx\@corref\@empty\else\unskip\sep\@corref\let\sep=,\fi
    }%
    \def\authorsep{\unskip,\space}%
    \global\let\sep\@empty\global\let\@corref\@empty
    \global\let\@fnmark\@empty}%
  \@eadauthor={#2}
}
\def\@author#1{%
  \ifx\@empty\authors
     \gdef\authors{#1}%
  \else
    \g@addto@macro\authors{\and#1}%
  \fi
 \g@addto@macro\elsauthors{\normalsize%
    \def\baselinestretch{1}%
    \upshape\authorsep#1}
  \ifAFP@corrauthor
  \g@addto@macro\elsauthors{\textsuperscript{$\ast$}}\fi
  \g@addto@macro\elsauthors{%
    \def\authorsep{\unskip,\space}%
    \global\let\@fnmark\@empty
    \global\let\sep\@empty}%
    \@eadauthor={#1}
}
\long\def\@address#1{\g@addto@macro\elsauthors{%
    \def\baselinestretch{1}\def\addsep{\par\vskip4pt}%
    \addsep\footnotesize\itshape#1%
    \def\authorsep{\par\vskip16pt}}}
\def\paperUrl#1{\gdef\@paperUrl{#1}}
\paperUrl{}
\newwrite\@mainrpi
\def\RESP@write@paper@info{%
  \bgroup
  \if@filesw
     \openout\@mainrpi\jobname.rpi%
     \write\@mainrpi{\relax}%
    \ifx\r@LastPage\@undefined
       \edef\@tempa{\start@page}%
    \else
       \def\@tempb##1##2##3##4##5{##2}%
       \edef\@tempa{\expandafter\@tempb\r@LastPage}%
    \fi
    \def\and{\string\and\space}%
    \protected@write\@mainrpi{}%
    {\string\articleentry{\authors}{\@title}{\start@page}{\@tempa}}%
   \protected@write\@mainrpi{}%
    {\@percentchar authors=\authors}%
   \protected@write\@mainrpi{}%
    {\@percentchar title=\@title}%
   \protected@write\@mainrpi{}%
    {\@percentchar year=\currentyear}%
   \protected@write\@mainrpi{}%
    {\@percentchar volume=\currentvolume}%
   \protected@write\@mainrpi{}%
    {\@percentchar issue=\currentissue}%
   \protected@write\@mainrpi{}%
    {\@percentchar paper=\currentpaper}%
   \protected@write\@mainrpi{}%
    {\@percentchar startpage=\start@page}%
   \protected@write\@mainrpi{}%
    {\@percentchar endpage=\@tempa}%
   \protected@write\@mainrpi{}%
    {\@percentchar doi=\@doinumber}%
   \ifx\@paperUrl\@empty\else
   \protected@write\@mainrpi{}%
    {\@percentchar paperUrl=\@paperUrl}%
   \fi
    \closeout\@mainrpi
    \fi
\egroup}
\def\maketitle{%
  \null\bigskip\par
  \iflongmktitle\getSpaceLeft
     \global\setbox\els@boxa=\vsplit0 to \@tempdima
     \box\els@boxa\par\resetTitleCounters
     \printFirstPageNotes
     \box0%
   \else
       \finalMaketitle\printFirstPageNotes
   \fi
   \RESP@write@paper@info
   \author@andify\authors
   \xdef\authors{\authors}%
   \gdef\thefootnote{\arabic{footnote}}%
   \thispagestyle{firstpagestyle}%
}
\def\volumenumber#1{\gdef\currentvolume{#1}}
\volumenumber{}
\def\issuenumber#1{\gdef\currentissue{#1}}
\issuenumber{}
\def\publicationyear#1{\gdef\currentyear{#1}}
\publicationyear{}
\newcommand\publicationmonth[2][]{\gdef\currentmonth{#2}%
  \gdef\abbrevcurrentmonth{#1}%
  \ifx\abbrevcurrentmonth\@empty\gdef\abbrevcurrentmonth{#2}\fi}
\publicationmonth{}
\def\papernumber#1{\gdef\currentpaper{#1}}
\papernumber{0000}
\def\doinumber#1{\gdef\@doinumber{#1}}
\doinumber{123.4567/archivesforensicpsychology.\currentyear.\currentvolume.\currentissue.\currentpaper}
\def\startpage#1{\pagenumbering{arabic}\setcounter{page}{#1}%
  \gdef\start@page{#1}%
  \ifnum\c@page<\z@ \pagenumbering{roman}\setcounter{page}{-#1}%
    \gdef\start@page{\romannumeral#1}%
  \fi}
\def\endpage#1{\def\@tempa{#1}%
  \ifx\@tempa\@empty\def\end@page{\pageref{LastPage}}%
  \else\def\end@page{#1}\fi}
\def\pagespan#1#2{\startpage{#1}\endpage{#2}}
\pagespan{1}{}
\def\articleentry#1#2#3#4{\@tempcnta=#4\relax
  \advance\@tempcnta by 1\relax
  \ifodd\the\@tempcnta\else\advance\@tempcnta by 1\relax\fi
  \startpage{\the\@tempcnta}}
\def\prevpaper#1{\IfFileExists{#1.rpi}{%
    \ClassInfo{afparticle}{%
      Reading first page number from the file #1.rpi}%
    \input{#1.rpi}%
  }{\ClassWarning{afparticle}{Cannot find the file #1.rpi.
      Did you run latex on the previous paper?}}}
\def\AFP@backmatter{}
\def\received#1{\g@addto@macro\AFP@backmatter{Received: #1\\}}
\def\revised#1{\g@addto@macro\AFP@backmatter{Revision Received: #1\\}}
\def\accepted#1{\g@addto@macro\AFP@backmatter{Accepted: #1\\}}
\def\printbackmatter{\ifx\AFP@backmatter\@empty\else\medskip
  \begin{flushright}%
    \AFP@backmatter
  \end{flushright}%
\fi}
\AtBeginDocument{\@twosidetrue}
\setlength\footskip{40\p@}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{standardpagestyle}{%
  \fancyhead{}%
  \fancyfoot{}%
  \fancyfoot[R]{\thepage}%
  \fancyhead[CE]{\scshape\MakeLowercase{\shortauthors}}%
  \fancyhead[CO]{\scshape\MakeLowercase{\shorttitle}}%
}
\pagestyle{standardpagestyle}
\fancypagestyle{firstpagestyle}{%
  \fancyhead{}%
  \fancyfoot{}%
  \fancyfoot[R]{\thepage}%
  \fancyhead[L]{\small Archives of Forensic Psychology\\
    \currentyear, Vol.~\currentvolume, No.~\currentissue,
    \thepage--\end@page}%
   \fancyhead[R]{\small\textcopyright~\currentyear\ Global Institute of
     Forensic Psychology\\ISSN~2334-2749}%
}
\setlength\parindent{2em}
\setcounter{secnumdepth}{-1}
\renewcommand\section{\@startsection {section}{1}{\z@}%
           {18\p@ \@plus 6\p@ \@minus 3\p@}%
           {9\p@ \@plus 6\p@ \@minus 3\p@}%
           {\centering\normalsize\bfseries\boldmath}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
           {18\p@ \@plus 6\p@ \@minus 3\p@}%
           {9\p@ \@plus 6\p@ \@minus 3\p@}%
           {\normalsize\bfseries\boldmath}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{0\z@}%
           {0\z@}%
           {-6\p@}%
           {\normalfont\hspace*{\parindent}\itshape\@addfinaldot}}
\def\@addfinaldot#1{#1.}
\DeclareCaptionLabelSeparator{periodNewline}{.\\}
\captionsetup[table]{position=top, format=plain,
  labelsep=periodNewline, justification=centering,
  singlelinecheck=off, font=normalsize, textfont=it}
\captionsetup[figure]{position=bottom, format=plain,
  labelsep=period, justification=centering,
  singlelinecheck=off, font=normalsize, labelfont=it}
\tolerance=1
\emergencystretch=\maxdimen
\hyphenpenalty=10000
\hbadness=10000
\normalsize\normalfont
\endinput
%%
%% End of file `afparticle.cls'.
