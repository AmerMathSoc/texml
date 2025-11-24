%%
%% This is file `nddiss2e.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% nddiss2e.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%%  Copyright (C) 2004-2005 Sameer Vijay
%% 
%%  This file may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either
%%  version 1.2 of this license or (at your option) any later
%%  version. The latest version of this license is in
%%     http://www.latex-project.org/lppl.txt
%% 
%% 
%% ==============================================================
%% 
%% Notre Dame's Dissertation document class by Sameer Vijay
%% that adheres to the University of Notre Dame guidelines
%% published in Spring 2004.
%% 
%% Please send any improvements/suggestions to :
%%     Shari Hill, Graduate Reviewer.
%%     shill2@nd.edu
%% 
%% For documentation on how to use nddiss2e class, process the
%% file nddiss2e.dtx through LaTeX.
%% 
%% ==============================================================
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{nddiss2e}
    [2005/07/27 v3.0 ^^J%
     Notre Dame Dissertation document class by Sameer Vijay^^J]
\providecommand{\dissfileversion}{3.0}
\providecommand{\dissfiledate}{2005/07/27}
\newif\ifdiss@draft             \diss@drafttrue
\newif\ifdiss@review            \diss@reviewfalse
\newif\ifdiss@final             \diss@finalfalse
\newif\ifinfo@page              \info@pagetrue
\newif\ifadvisors@two           \advisors@twofalse
\newif\ifdiss@dedication        \diss@dedicationfalse
\newif\ifnum@refs               \num@refstrue
\newif\ifcentered@chaptitle     \centered@chaptitletrue
\DeclareOption{draft}{
    \setlength\overfullrule{5pt}
    \typeout{DRAFT MODE}\typeout{}\info@pagefalse%
    \diss@drafttrue\diss@reviewfalse\diss@finalfalse
    \PassOptionsToClass{letterpaper,oneside,draft}{book} }
\DeclareOption{review}{
    \typeout{REVIEW MODE}\typeout{}\info@pagetrue%
    \diss@draftfalse\diss@reviewtrue\diss@finalfalse
    \PassOptionsToClass{12pt,letterpaper,oneside,final}{book} }
\DeclareOption{final}{
    \setlength\overfullrule{0pt}
    \typeout{FINAL MODE}\typeout{}\info@pagetrue%
    \diss@draftfalse\diss@reviewfalse\diss@finaltrue
    \PassOptionsToClass{12pt,letterpaper,oneside,final}{book} }
\DeclareOption{numrefs}{
  \typeout{NUMBERED REFERENCES}\num@refstrue}
\DeclareOption{textrefs}{
  \typeout{TEXTUAL REFERENCES}\num@refsfalse}
\DeclareOption{nocenter}{\centered@chaptitlefalse}
\DeclareOption{openbib}{%
   \PassOptionsToPackage{openbib}{natbib}
}
\DeclareOption{twoadvisors}{\typeout{TWO ADVISORS}\typeout{}%
    \advisors@twotrue}
\DeclareOption{10pt}{%
 \ifdiss@draft%
  \PassOptionsToClass{10pt}{book}%
 \else%
  \OptionNotUsed%
  \ClassWarningNoLine{nddiss2e}%
    {Font size 10pt not allowed; using 12pt}%
 \fi%
}
\DeclareOption{11pt}{%
 \ifdiss@draft%
  \PassOptionsToClass{11pt}{book}%
 \else%
  \OptionNotUsed%
  \ClassWarningNoLine{nddiss2e}%
    {Font size 11pt not allowed; using 12pt}%
 \fi
}
\DeclareOption{12pt}{%
   \PassOptionsToClass{12pt}{book}%
}
\DeclareOption{noinfo}{\info@pagefalse}
\DeclareOption{twoside}{\typeout{TWO SIDED DOCUMENT}%
  \PassOptionsToClass{twoside}{book} }%
\DeclareOption*{\ClassWarning{nddiss2e}%
    {UnknownOption `\CurrentOption'} }%
\ProcessOptions\relax
\LoadClass{book}
\RequirePackage{ifthen,exscale}
\RequirePackage{ifpdf}
\RequirePackage{longtable}
\RequirePackage{xspace}
\RequirePackage{indentfirst}
\RequirePackage{tabularx}
\RequirePackage{enumerate}
\RequirePackage{latexsym}
\ifdiss@final\relax\else\RequirePackage{showkeys}\fi
\ifpdf
  \RequirePackage[pdftex]{epsfig}
  \RequirePackage[pdftex]{color}
  \RequirePackage[pdftex]{graphicx}
  \RequirePackage[pdftex,
            letterpaper=true,%
            bookmarks=true,%
            bookmarksnumbered=true,%
            linktocpage=true,%
            breaklinks=true,%
            bookmarkstype=toc,%
            colorlinks=false,%
            pdfpagemode=UseOutlines]{hyperref}
  \AtBeginDocument{
  \pdfadjustspacing=1
  }
\else
  \RequirePackage[dvips]{epsfig}
  \RequirePackage[dvips]{color}
  \RequirePackage[dvips]{graphicx}
\fi
\ifnum@refs
  \RequirePackage[numbers,sort&compress]{natbib}
\else
  \RequirePackage[authoryear,sort]{natbib}
\fi
\ifpdf
    \RequirePackage{hypernat}
\fi
\AtBeginDocument{
\RequirePackage{amsmath,amssymb}
\RequirePackage{float}
\RequirePackage{lscape}
\RequirePackage{booktabs}
\RequirePackage{rotating}
\RequirePackage{url}
\RequirePackage[doublespacing]{setspace}[2000/12/01]
}
\AtBeginDocument{
\pagestyle{plain}
\normalspacing
\typeout{Pagestyle and spacing normal}
}
\newcommand{\normalspacing}{\doublespacing}
\newcommand\single@baselinestretch{1.0}
\newcommand\double@baselinestretch{1.66}
\newlength{\single@skip}
\setlength{\single@skip}{\single@baselinestretch em}
\newlength{\double@skip}
\setlength{\double@skip}{\double@baselinestretch em}
\setlength{\hoffset}{0pt}
\setlength{\voffset}{0pt}
\addtolength{\topmargin}{-32pt}
\setlength{\headsep}{12pt}
\setlength{\marginparwidth}{54pt}
\setlength{\marginparsep}{0pt}
\addtolength{\textheight}{63pt}
\addtolength{\textwidth}{26pt}
\setlength{\oddsidemargin}{36pt}
\setlength{\evensidemargin}{18pt}
\setlength{\footskip}{36pt}
\setlength{\floatsep}{30pt}
\setlength{\intextsep}{50pt}
\newcommand{\clearemptydoublepage}{\newpage{\pagestyle{empty}%
    \cleardoublepage}}
\DeclareRobustCommand{\nddiss}{%
        \textsf{{\scshape nd}diss}\kern-0.03em%
        2$_\mathsf{\textstyle\varepsilon}$}
\newcommand{\work}[1]{\def\@work{#1}}
\newcommand{\degaward}[1]{\def\@degaward{#1}}
\newcommand{\degprior}[1]{\def\@degprior{#1}}
\newcommand{\advisor}[1]{\def\@advisor{#1}}
\ifadvisors@two
    \newcommand{\secondadvisor}[1]{\def\@secondadvisor{#1}}
\fi
\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\degdate}[1]{\def\@degdate{#1}}
  \degdate{\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\year}
  \title{}
  \author{}
  \work{}
  \degaward{}
  \degprior{}
  \advisor{}
  \ifadvisors@two \secondadvisor{} \fi
  \department{}
\DeclareRobustCommand{\@infopage}{
  \thispagestyle{empty}
  \null\vspace*{\single@skip}
  \begin{center}
  \large This \@work\space \\ entitled \\ \@title \\
        typeset with \nddiss\ v%
      \dissfileversion\ (\dissfiledate) %
      on \today\space for\\
  \@author\\
  \end{center}

   \normalfont\normalsize\singlespacing

   \noindent This \LaTeXe\space classfile conforms to the
   University of Notre Dame style guidelines established in
   Spring  2004. However it is still possible to generate a
   non-conformant document if the instructions in the class
   file documentation are not followed!

   \begin{center}
   \begin{minipage}{0.75\textwidth}
   \noindent Be sure to refer to the published Graduate
   School guidelines at \url{http://graduateschool.nd.edu}
   as well. Those guidelines override everything mentioned
   about formatting in the documentation for
   this \nddiss\space class file.
   \end{minipage}
   \end{center}

   \noindent It is YOUR responsibility to ensure that the Chapter titles
   and Table caption titles are put in CAPS LETTERS. This classfile does
   {\em NOT\space} do that! \\

  \noindent\itshape This page can be disabled by
  specifying the ``{\upshape\ttfamily noinfo}'' option to the class invocation.
  \upshape
(i.e.,{\ttfamily{\textbackslash}documentclass[\ldots,noinfo]\{nddiss2e\}}
)
  \begin{center}
    {\bfseries\large\singlespacing This page is \slshape NOT
    \upshape part of the dissertation/thesis, but MUST be turned in to the
    proofreader(s) or the reviwer(s)!}
  \end{center}
    \normalsize\normalfont
    \nddiss\ documentation can be found at these locations:
  \begin{center}
    \url{http://www.gsu.nd.edu}\\
    \url{http://graduateschool.nd.edu}
  \end{center}

\vfill
\normalfont\normalsize\normalspacing\eject}
\renewcommand{\maketitle}{
  \ifinfo@page\@infopage\else\relax\fi%
  \clearemptydoublepage
  \normalfont\normalsize\normalspacing
  \begin{titlepage}%
\ifthenelse{\equal{\@work}{}}{\ClassError{nddiss2e}%
  {The \protect\work\space macro is undefined.\MessageBreak
        The title page may be incorrectly formatted.}%
  {Specify \protect\work\space as Dissertation or Thesis}}{\relax}
\ifthenelse{\equal{\@degaward}{}}{\ClassError{nddiss2e}%
  {The \protect\degaward\space macro is undefined.\MessageBreak
        The title page may be incorrectly formatted.}%
  {Specify \protect\degaward\space. It defines the awarded degree%
         (Ph.D., M.S., etc.)}}{\relax}
\ifthenelse{\equal{\@advisor}{}}{\ClassError{nddiss2e}%
  {The \protect\advisor\space macro is undefined.\MessageBreak
        The title page may be incorrectly formatted.}%
  {Spepcify \protect\advisor\space It is who signs your walking papers!}}{\relax}
\ifthenelse{\equal{\@department}{}}{\ClassError{nddiss2e}%
  {The \protect\department\space macro is undefined.\MessageBreak
        The title page may be incorrectly formatted.}%
  {Specify which \protect\department\space is awarding your degree?}}{\relax}
\ifadvisors@two
  \ifthenelse{\equal{\@secondadvisor}{}}{\ClassError{nddiss2e}%
  {The \protect\secondadvisor\space macro is undefined.\MessageBreak
            The title page may be incorrectly formatted.}%
  {Use \protect\secondadvisor\space for your second advisor}}{\relax}
\fi
\skip1=1.2\double@skip
\skip2=1.7\double@skip
\skip3=2.7\double@skip
\skip4=1em
\ifadvisors@two \skip1=1.0\double@skip \skip4=1.5em \else\relax\fi
\setbox0=\hbox{\@title}
\ifdim \wd0 > 3\hsize
   \advance\skip4 .5\double@skip
   \advance\skip1 -.33\double@skip
\else
   \ifdim \wd0 > 2\hsize
     \advance\skip4 .5\double@skip
         \advance\skip1 -.167\double@skip
  \else
     \ifdim \wd0 > \hsize
        \advance\skip4 .5\double@skip
         \fi
  \fi
\fi
\setbox1=\vbox{\@degaward}
\ifdim \ht1 > \double@skip\relax
   \else \advance\skip1 .167\double@skip \fi
  \null\vspace*{-\skip4}
  \begin{center}%
    \@title \par%
    \vskip\skip1%
    A \@work \par%
    \vskip\skip1%
      Submitted to the Graduate School \\
          of the University of Notre Dame \\
          in Partial Fulfillment of the Requirements \\
          for the Degree of \par
        \vskip\skip1%
        \@degaward%
        \vskip\skip1%
        by%
        \vskip\skip1%
    {\normalsize
      \begin{tabular}[t]{c@{}l}%
        \@author, &\ \@degprior
      \end{tabular}\par }%
     \ifadvisors@two
        \vskip\skip2\else
        \vskip\skip3\fi%
        \hspace*{2.75in}\underline{\hspace{2.75in}}\\%
        \hspace*{2.75in}\@advisor, Director\\
\ifadvisors@two %
      \vskip\double@skip%
        \hspace*{2.75in}\underline{\hspace{2.75in}}\\%
        \hspace*{2.75in}\@secondadvisor, Director\\
\fi
  \vskip\skip1%
  Graduate Program in \@department \\%
  Notre Dame, Indiana \\
  \@degdate
  \end{center}
  \end{titlepage}%
}
\newenvironment{copyrightpage}{%
  \clearemptydoublepage
  \typeout{Copyleft page}
  \pagestyle{empty}
  \null\vfil
  \begin{center}\normalspacing}%
{ \end{center}\vfil\null \clearpage }
\newcommand{\@copyrightyear}{\year}
\newcommand{\@copyrightholder}{\@author}
\newcommand{\copyrightyear}[1]{\renewcommand{\@copyrightyear}{#1}}
\newcommand{\copyrightholder}[1]{\renewcommand{\@copyrightholder}{#1}}
\newcommand{\makecopyright}{%
  \ifdiss@final
    \begin{copyrightpage}
    \normalfont\normalsize
    \copyright\space Copyright by \\
    \@copyrightholder \\
    \@copyrightyear\\
    All Rights Reserved \\[10mm]
    \end{copyrightpage}
  \fi
}%
\newcommand{\makepublicdomain}{%
  \ifdiss@final
    \begin{copyrightpage}
       This document is in the public domain.
    \end{copyrightpage}
  \fi
}%
\providecommand{\abstractname}{Abstract}
\providecommand{\dedicationname}{\mbox{}}
\providecommand{\prefacename}{PREFACE}
\providecommand{\acknowledgename}{ACKNOWLEDGMENTS}
\providecommand{\symbolsname}{SYMBOLS}
\renewcommand{\tablename}{TABLE}
\renewcommand{\figurename}{Figure}
\renewcommand{\chaptername}{CHAPTER}
\renewcommand{\appendixname}{APPENDIX}
\renewcommand{\contentsname}{CONTENTS}
\renewcommand{\listfigurename}{FIGURES}
\renewcommand{\listtablename}{TABLES}
\renewcommand{\bibname}{BIBLIOGRAPHY}
\renewcommand{\indexname}{INDEX}
\newenvironment{abstract}{%
  \ifpdf
     \pdfbookmark[0]{\abstractname}{abstract}%abstract.0
  \fi
  \typeout{Abstract page(s)}
  \renewcommand{\@oddfoot}{\@empty}
  \renewcommand{\@evenfoot}{\@empty}
  \let\@evenhead\@oddhead
  \renewcommand{\@oddhead}{\hfil{\upshape\@author}}
  \titlepage
  \null
  \begin{center}
  \vspace*{0.25in}
  {\normalsize\mdseries \normalspacing
     \@title \\[3.5ex]
     \normalsize\abstractname \\ by \\ \@author\space}%
   \@endparpenalty \@M
   \end{center}\par}%
{\par\vfil\null\endtitlepage}
\newenvironment{dedication}{%
  \global\diss@dedicationtrue
  \typeout{Dedication page}
  \ifpdf
      \pdfbookmark[0]{\dedicationname}{dedication}%dedication.0
  \fi
  \chapter*{\dedicationname}%
  \thispagestyle{plain}
  \setcounter{page}{2}
  \null\centering}
{\par\null\clearpage}%
\renewcommand\tableofcontents{%
  \ifdiss@dedication\relax\else\setcounter{page}{2}\fi
  \chapter*{\contentsname}%
  \ifpdf
      \pdfbookmark[0]{\contentsname}{contents}%contents.0
  \fi
  \singlespacing
  \@starttoc{toc}%
  \normalspacing
  }
\renewcommand\listoffigures{%
    \chapter*{\listfigurename}%
    \addcontentsline{toc}{chapter}{\listfigurename}%
    \typeout{List of figures - \listfigurename}
    \singlespacing
    \@starttoc{lof}%
    \normalspacing
}
\renewcommand\listoftables{%
    \chapter*{\listtablename}%
    \addcontentsline{toc}{chapter}{\listtablename}%
    \typeout{List of tables - \listtablename}
    \singlespacing
    \@starttoc{lot}%
    \normalspacing
}
\newenvironment{preface}{%
  \typeout{Preface page}
  \chapter*{\prefacename}
  \addcontentsline{toc}{chapter}{\prefacename}%
}%
{\par\null\clearpage}%
\newenvironment{acknowledge}{%
  \typeout{Acknowledgment page}
  \chapter*{\acknowledgename}
  \addcontentsline{toc}{chapter}{\acknowledgename}%
}%
{\par\null\clearpage}%
\newcommand{\sym}[2]{\ensuremath{#1} & #2 \\}
\newenvironment{symbols}[1][rl]{%
  \typeout{Symbols page}
  \chapter*{\symbolsname}%
  \addcontentsline{toc}{chapter}{\symbolsname}%
  \begin{center}\begin{longtable}{#1}}%
{\end{longtable}\end{center}\par\null}
\def\@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
  \if@mainmatter
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \addcontentsline{toc}{chapter}%
      {{\@chapapp\ \thechapter: #1}}%
    \else
      \addcontentsline{toc}{chapter}{#1}%
    \fi
  \else
     \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}%
  \@afterheading }%
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{.625in}%
  {\parindent \z@ \raggedright
    \ifnum \c@secnumdepth >\m@ne
      \normalfont\normalsize%
      \if@mainmatter
        \ifcentered@chaptitle\center\else\relax\fi%
        \@chapapp{} \thechapter\par\nobreak
      \fi
    \fi
    \interlinepenalty\@M
    \ifcentered@chaptitle\center\else\relax\fi%
    \mdseries{#1}\par\nobreak
    \vskip 30\p@
  }}
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{.625in}%
  {\parindent \z@ \raggedright
     \normalfont\normalsize%
     \interlinepenalty\@M
     \ifcentered@chaptitle\center\else\relax\fi
     \mdseries{#1}\par\nobreak
     \vskip 30\p@
  }}
\renewcommand\section{\suppressfloats[t]%
    \@startsection {section}{1}{\z@}%
    {-4.2ex \@plus -1ex \@minus -.2ex}%
    {1.8ex \@plus.2ex}%
    {\normalfont\normalsize\mdseries} }
\renewcommand\subsection{\suppressfloats[t]%
    \@startsection{subsection}{2}{\z@}%
    {-3.9ex\@plus -1ex \@minus -.2ex}%
    {1.2ex \@plus .2ex}%
    {\normalfont\normalsize\mdseries} }
\renewcommand\subsubsection{\suppressfloats[t]%
    \@startsection{subsubsection}{3}{\z@}%
    {-3.9ex\@plus -1ex \@minus -.2ex}%
    {1.2ex \@plus .2ex}%
    {\normalfont\normalsize\mdseries} }
\renewcommand\paragraph{%
    \@startsection{paragraph}{4}{\z@}%
    {3.9ex \@plus1ex \@minus.2ex}%
    {-1em}%
    {\normalfont\normalsize\mdseries} }
\renewcommand\subparagraph{%
    \@startsection{subparagraph}{5}{\parindent}%
    {3.9ex \@plus1ex \@minus .2ex}%
    {-1em}%
    {\normalfont\normalsize\mdseries} }
\renewcommand*{\l@chapter}[2]{%
  \addpenalty{-\@highpenalty}%
  \setlength\@tempdima{1.5em}%
  \begingroup \leavevmode
  \@dottedtocline{1}{0pt}{\@tempdima}{#1}{#2}
  \par
  \penalty\@highpenalty
  \endgroup
}
\renewcommand{\l@subsubsection}{%
   \@dottedtocline{3}{3.8em}{4.1em}}
\addtocounter{secnumdepth}{1}
\addtocounter{tocdepth}{1}
\renewcommand{\thesubsubsection}{%
   \thesubsection.\arabic{subsubsection}}
\renewenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                 \singlespacing
               \item\relax}
               {\endlist}
\setlength\abovecaptionskip{20\p@}
\newlength\capwidth
\setlength{\capwidth}{0.90\textwidth}
\newlength\abovetableskip
\newlength\belowtableskip
\newlength\abovefigureskip
\newlength\belowfigureskip
\setlength\abovetableskip\belowcaptionskip
\setlength\belowtableskip\abovecaptionskip
\setlength\abovefigureskip\abovecaptionskip
\setlength\belowfigureskip\belowcaptionskip
\renewenvironment{figure}{%
   \setlength{\abovecaptionskip}{\abovefigureskip}
   \setlength{\belowcaptionskip}{\belowfigureskip}
   \let\@makecaption\@makefigurecaption
   \@float{figure}}%
   {%
   \addtocontents{lof}{ {\vskip 0.4em} }%
   \end@float%
}
\long\def\@makefigurecaption#1#2{%
  \vskip\abovecaptionskip
  \begin{center}
  \parbox{\capwidth}{
    \centering\singlespacing
    {#1}. {#2}%\par
  \vskip\belowcaptionskip\normalspacing }%
  \end{center}
}%
\renewenvironment{table}{%
   \setlength{\abovecaptionskip}{\abovetableskip}
   \setlength{\belowcaptionskip}{\belowtableskip}
   \singlespacing
   \renewcommand{\arraystretch}{\double@baselinestretch}
   \let\@makecaption\@maketablecaption
   \@float{table}}%
   {%
   \addtocontents{lot}{ {\vskip 0.4em} }%
   \end@float%
}
\long\def\@maketablecaption#1#2{
  \vskip\abovecaptionskip
  \begin{center}
    \parbox{\capwidth}{
    \centering\normalspacing
    {#1}\\[\single@skip]
    {#2}%\par
  \vskip\belowcaptionskip }%
  \end{center}
}
\renewcommand\longtable{%
   \singlespacing
   \renewcommand{\arraystretch}{\double@baselinestretch}
   \begingroup
   \@ifnextchar[\LT@array{\LT@array[x]}}
\renewcommand\endlongtable{%
  \crcr
  \noalign{%
    \let\LT@entry\LT@entry@chop
    \xdef\LT@save@row{\LT@save@row}}%
  \LT@echunk
  \LT@start
  \unvbox\z@
  \LT@get@widths
  \if@filesw
    {\let\LT@entry\LT@entry@write\immediate\write\@auxout{%
      \gdef\expandafter\noexpand
        \csname LT@\romannumeral\c@LT@tables\endcsname
          {\LT@save@row}}}%
  \fi
  \ifx\LT@save@row\LT@@save@row
  \else
    \LT@warn{Column \@width s have changed\MessageBreak
             in table \thetable}%
    \LT@final@warn
  \fi
  \endgraf\penalty -\LT@end@pen
  \addtocontents{lot}{ {\vskip 0.4em} }%
  \endgroup
  \global\@mparbottom\z@
  \pagegoal\vsize
  \endgraf\penalty\z@\addvspace\LTpost
  \ifvoid\footins\else\insert\footins{}\fi
}
\setlength{\LTcapwidth}{\capwidth}
\renewcommand\LT@makecaption[3]{%
  \LT@mcol\LT@cols c{\hbox to\z@{\hss\parbox[t]\LTcapwidth{%
  \vskip\abovetableskip%
    \centering\normalspacing
    #1{#2 }\\[\single@skip]
    {#3}\par
  \endgraf\vskip\belowtableskip}%
  \hss}}}
\newcommand\timenow{%
  \@tempcnta=\time \divide\@tempcnta by 60 \number\@tempcnta:\multiply
  \@tempcnta by 60 \@tempcntb=\time \advance\@tempcntb by -\@tempcnta
  \ifnum\@tempcntb <10 0\number\@tempcntb\else\number\@tempcntb\fi}
\newcommand{\diss@header}{%
    \ifdiss@review Review \else Draft \fi document [\today\/ at \timenow\/]
    }%
\ifdiss@final
    \renewcommand{\ps@plain}{
        \renewcommand{\@oddhead}{\@empty}
        \renewcommand{\@oddfoot}{\hfil\thepage\hfil}
        \let\@evenhead\@oddhead
        \let\@evenfoot\@oddfoot
    }%
\else
    \renewcommand{\ps@plain}{
        \renewcommand{\@oddhead}{\framebox[\textwidth]{
           \centering\footnotesize\tt\diss@header}}%
        \renewcommand{\@oddfoot}{\hfil\textrm{\thepage}\hfil}
        \let\@evenhead\@oddhead
        \let\@evenfoot\@oddfoot
    }%
    \renewcommand{\ps@empty}{
        \renewcommand{\@oddhead}{\framebox[\textwidth]{
           \centering\footnotesize\tt\diss@header}}%
        \renewcommand{\@oddfoot}{\@empty}
        \let\@evenhead\@oddhead
        \let\@evenfoot\@oddfoot
    }%
\fi
\renewcommand{\bibsection}{
  \chapter*{\bibname}%
  \addcontentsline{toc}{chapter}{\bibname}%
}%
\newcommand{\bibfont}{\singlespacing}
\ifnum@refs
  \renewcommand{\@biblabel}[1]{\hfill#1.\hfill}
\fi
\ifdiss@final
\AtEndDocument{
    \vfill
    \centering\singlespacing
    \framebox[0.85\textwidth]{
    \begin{minipage}{0.80\textwidth}\footnotesize%
    \centering \itshape This document was prepared \& typeset with
    \upshape\ifpdf pdf\LaTeX\else\LaTeXe\fi\itshape , and
    formatted with \upshape\nddiss\xspace\itshape classfile
    (v\dissfileversion [\dissfiledate]) provided by Sameer Vijay.
    \end{minipage} }
    \clearpage}
\else\relax\fi
%%
%%
\endinput
%%
%% End of file `nddiss2e.cls'.
