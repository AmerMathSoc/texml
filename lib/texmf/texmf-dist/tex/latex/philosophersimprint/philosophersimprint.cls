%%
%% This is file `philosophersimprint.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% philosophersimprint.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from philosophersimprint.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file philosophersimprint.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{philosophersimprint}
[2013/01/13 v1.3 Typesetting articles for Philosophers' Imprint]
\newif\ifPHIM@titleimage\PHIM@titleimagetrue
\DeclareOption{titleimage}{\PHIM@titleimagetrue}
\DeclareOption{notitleimage}{\PHIM@titleimagefalse}
\newif\ifPHIM@trajantitle\PHIM@trajantitletrue
\DeclareOption{trajantitle}{\PHIM@trajantitletrue}
\DeclareOption{notrajantitle}{\PHIM@trajantitlefalse}
\newif\ifPHIM@sc\PHIM@sctrue
\DeclareOption{nosc}{\PHIM@scfalse}
\newif\ifPHIM@osf\PHIM@osftrue
\DeclareOption{noosf}{\PHIM@osffalse}
\DeclareOption{slantedGreek}{%
  \PassOptionsToPackage{\CurrentOption}{mathpazo}}
\DeclareOption{noBBpl}{%
  \PassOptionsToPackage{\CurrentOption}{mathpazo}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\InputIfFileExists{philosophersimprint.cfg}{%
  \ClassInfo{philosophersimprint}{%
    Loading configuration file philosophersimprint.cfg}}{%
  \ClassInfo{philosophersimprint}{%
    Configuration file philosophersimprint.cfg is not found}}
\ProcessOptions\relax
\LoadClass[landscape,letterpaper,twocolumn]{article}
\RequirePackage{ifpdf, color, graphicx, fancyhdr}
\ifPHIM@sc\PassOptionsToPackage{sc}{mathpazo}\fi
\ifPHIM@osf\PassOptionsToPackage{osf}{mathpazo}\fi
\RequirePackage{mathpazo}
\RequirePackage{courier}
\RequirePackage[scaled]{helvet}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\IfFileExists{microtype.sty}{\RequirePackage{microtype}}{%
  \ClassWarningNoLine{philosopherimprint}{%
      *********************************\MessageBreak
      * Microtype package not found.  * \MessageBreak
      * This package improves the     *\MessageBreak
      * typesetting quality.  You may *\MessageBreak
      * wish to upgrade your system.  *\MessageBreak
      ********************************}}
\ifPHIM@trajantitle
  \IfFileExists{trajan.sty}{\RequirePackage{trajan}}{%
    \ClassWarningNoLine{philosophersimprint}{%
      ********************************\MessageBreak
      * Trajan Fonts not found.  Will \MessageBreak
      * revert to Palatino in title.\MessageBreak
      ********************************}%
    \PHIM@trajantitlefalse}
\fi
\newif\ifPHIM@hyperref
\AtBeginDocument{%
  \@ifpackageloaded{hyperref}{%
    \PHIM@hyperreftrue}{%
    \ClassWarningNoLine{philosophersimprint}{%
      ****************************\MessageBreak
      * You did not load hyperref.\MessageBreak
      * PDF-specific features will\MessageBreak
      * not work.\MessageBreak
      *****************************}%
    \PHIM@hyperreffalse}}
\newlength{\PHIM@baselength}
\setlength{\PHIM@baselength}{13.5pt}
\renewcommand\normalsize{\@setfontsize\normalsize{9.5pt}\PHIM@baselength}
\renewcommand\small{\@setfontsize\small{9pt}{13.5pt}}
\renewcommand\footnotesize{%
  \@setfontsize\footnotesize{8.5pt}{9.5pt}}
\renewcommand\scriptsize{\@setfontsize\scriptsize{8pt}{9pt}}
\renewcommand\tiny{\@setfontsize\tiny{7.5pt}{8.5pt}}
\renewcommand\large{\@setfontsize\large{11pt}{16pt}}
\renewcommand\Large{\@setfontsize\Large{13pt}{19pt}}
\renewcommand\LARGE{\@setfontsize\LARGE{16pt}{23pt}}
\renewcommand\huge{\@setfontsize\huge{19pt}{28pt}}
\renewcommand\Huge{\@setfontsize\Huge{23pt}{33pt}}
\newcommand\HUGE{\@setfontsize\Huge{30pt}{45pt}}
\renewcommand\baselinestretch{}
\setlength\parindent{\PHIM@baselength}
\setlength\parskip{0pt}
\setlength\smallskipamount{0.25\PHIM@baselength}
\setlength\medskipamount{0.5\PHIM@baselength}
\setlength\bigskipamount{\PHIM@baselength}
\ifpdf\relax
  \pdfpageheight=\paperheight
  \pdfpagewidth=\paperwidth
  \ifdim\pdfvorigin=0pt\pdfvorigin=0pt\fi
  \ifdim\pdfhorigin=0pt\pdfhorigin=0pt\fi
\else
  \ClassWarningNoLine{philosophersimprint}{%
    ****************************\MessageBreak
    * The class is intended for \MessageBreak
    * pdflatex. You seem to use\MessageBreak
    * it with latex instead.\MessageBreak
    ****************************}
\fi
\lineskiplimit = -3pt\relax
\lineskip = \PHIM@baselength\relax
\setlength\headsep   {\PHIM@baselength}
\setlength\footskip   {3\PHIM@baselength}
\setlength\topskip\PHIM@baselength
\setlength\textheight{459pt}
\setlength\topmargin{61pt}
\addtolength\topmargin{-1in}
\addtolength\topmargin{-\topskip}
\addtolength\topmargin{-\headsep}
\@settopoint\topmargin
\abovedisplayskip \PHIM@baselength\relax
\abovedisplayshortskip \PHIM@baselength\relax
\belowdisplayshortskip \PHIM@baselength\relax
\belowdisplayskip \abovedisplayskip\relax
\newlength{\PHIM@colwidth}
\setlength{\PHIM@colwidth}{297pt}
\setlength\columnsep{54pt}
\setlength\textwidth{\PHIM@colwidth}
\multiply\textwidth by 2\relax
\addtolength{\textwidth}{\columnsep}
\setlength{\marginparwidth}{3\PHIM@baselength}
\setlength{\marginparsep}{0.5\PHIM@baselength}
\setlength{\marginparpush}{0.5\PHIM@baselength}
\setlength{\evensidemargin}{6pc}
\addtolength{\evensidemargin}{-1in}
\setlength{\oddsidemargin}{\evensidemargin}
\setlength\floatsep\PHIM@baselength
\setlength\textfloatsep\PHIM@baselength
\setlength\intextsep\PHIM@baselength
\setlength\dblfloatsep\PHIM@baselength
\setlength\dbltextfloatsep\PHIM@baselength
\setlength\abovecaptionskip\PHIM@baselength
\setlength\belowcaptionskip{\z@}\relax
\setlength\leftmargini\PHIM@baselength
\leftmargin\leftmargini
\setlength\leftmarginii\PHIM@baselength
\setlength\leftmarginiii\PHIM@baselength
\setlength\leftmarginiv\PHIM@baselength
\setlength\leftmarginv\PHIM@baselength
\setlength\leftmarginvi\PHIM@baselength
\setlength\listparindent\PHIM@baselength
\setlength\itemindent\PHIM@baselength
\setlength\labelsep{0.5em}
\setlength\labelwidth{\leftmargini}
\setlength\topsep{0.5\PHIM@baselength}
\setlength\partopsep\z@
\setlength\parsep\parskip
\setlength\itemsep\z@
\def\@listi{}%
\def\@listI{}%
\def\@listii{}%
\def\@listiii{}%
\def\@listiv{}%
\def\@listv{}%
\def\@listvi{}%
\renewenvironment{verse}{\let\\\@centercr
  \list{}{\rightmargin\leftmargin}\item\relax}{\endlist}
\renewenvironment{quote}{%
  \list{}{\rightmargin\leftmargin}\item\relax}{\endlist}
\renewenvironment{quotation}{%
  \list{}{\rightmargin\leftmargin
  \itemindent\parindent}\item\relax}{\endlist}
\setlength\bibindent\PHIM@baselength
\setlength\jot\z@
\setlength{\arraycolsep}{0.5\PHIM@baselength}
\setlength{\tabcolsep}{0.5\PHIM@baselength}
\setlength{\fboxsep}{0.25\PHIM@baselength}
\def\and{\unskip, %
  \ClassError{philosophersimprint}{%
    Command \string\and\space is not defined for this class}{%
    The authors for Philosophers' Imprint should be separated by
    commas.\MessageBreak
  I will convert your \string\and\space to comma and continue}}
\def\thanks#1{%
  \ClassError{philosophersimprint}{%
    Command \string\thanks\space is not defined for this class}{%
    Use \string\affiliation\space instead of \string\thanks.\MessageBreak
    I will delete this command and its argument}}
\def\title{\@ifnextchar[{\title@i}{\title@ii}}
\def\title@i[#1]#2{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\def\title@ii#1{\title@i[#1]{#1}}
\title{}
\def\author{\@ifnextchar[{\author@i}{\author@ii}}
\def\author@i[#1]#2{\gdef\@shortauthor{#1}\gdef\@author{#2}}
\def\author@ii#1{\author@i[#1]{#1}}
\author{}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or
  December\fi\space
  \number\year}
\newcommand*{\titleimage}[1]{\gdef\@titleimage{#1}}
\titleimage{}
\newcommand*{\affiliation}[1]{\gdef\@affiliation{#1}}
\affiliation{}
\newcommand*{\copyrightinfo}[1]{\gdef\@copyrightinfo{#1}}
\copyrightinfo{}
\newcommand*{\subject}[1]{\gdef\@subject{#1}}
\subject{}
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}
\keywords{}
\newcommand*{\copyrightlicense}[1]{\gdef\@copyrightlicense{#1}}
\copyrightlicense{This work is licensed under a Creative Commons
  Attribution-NonCommercial-NoDerivatives 3.0 License}
\def\PHIM@addzeros#1#2{\@tempcnta=#1\relax
  \edef#2{%
   \ifnum\@tempcnta>99
      \the\@tempcnta
   \else
      \ifnum\@tempcnta>9
         0\the\@tempcnta
      \else
        00\the\@tempcnta
      \fi
   \fi}}
\newcommand*{\journalnumber}[1]{%
  \gdef\@journalnumber{#1}%
  \PHIM@addzeros{\@journalnumber}{\@@journalnumber}}
\journalnumber{999}
\newcommand*{\journalvolume}[1]{%
  \gdef\@journalvolume{#1}%
  \PHIM@addzeros{\@journalvolume}{\@@journalvolume}}
\journalvolume{999}
\pagestyle{fancy}
\lhead{\makebox[\PHIM@colwidth]{\centering\scshape\large
    \MakeLowercase{\@shortauthor}}}
\chead{}
\rhead{\makebox[\PHIM@colwidth]{\centering\itshape\large\@shorttitle}}
\lfoot{\scshape\large philosophers' imprint}
\cfoot{-\space\large\thepage\space-}
\rfoot{\scshape\large vol.~\@journalvolume, no.~\@journalnumber\quad%
  (\MakeLowercase{\@date})}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\def\maketitle{%
  \thispagestyle{empty}
  \ifPHIM@hyperref\relax
    \hypersetup{pdfauthor=\@author, pdftitle=\@title, %
      pdfsubject=\@subject, pdfkeywords=\@keywords}
   \fi
   \ifPHIM@titleimage\relax
      \maketitle@image
   \else
      \maketitle@simulated
   \fi
   \newpage}
\def\maketitle@image{%
  \IfFileExists{\@titleimage}{%
    \begin{picture}(0,0)%
        \setlength{\unitlength}{1pt}%
        \put(-6,6){\makebox(0,0)[lt]{\includegraphics{\@titleimage}}}%
        \end{picture}}{%
  \ClassWarningNoLine{philosophersimprint}{%
    ********************************\MessageBreak
    * Cannot find title image \MessageBreak
    * \@titleimage.\MessageBreak
    * Switching to  simulated title.\MessageBreak
    ********************************}
  \maketitle@simulated}}
\def\maketitle@simulated{%
  {\centering
    \parbox{2in}{\textcolor{PHIM@blue}{%
        \hspace{1.4em}\fontsize{10pt}{11}\selectfont Philosophers'}\\[-1.4ex]%
      \textcolor{PHIM@gray}{\fontsize{34pt}{25}\selectfont Imprint}}
    \hfill
    \parbox{2in}{
      \begin{flushright}
        \scshape\large
        volume \@journalvolume, no.~\@journalnumber\\[0.2ex]
        \MakeLowercase{\@date}
      \end{flushright}}%
    \par
    \vskip 0pt plus 0.3fill\relax
    {\ifPHIM@trajantitle\trjnfamily\fi
      \HUGE\selectfont\MakeUppercase{\@title}\par}%
    \vskip 0pt plus 0.4fill\relax
    {\huge\itshape\@author\par}%
    \vskip 0pt plus 0.15fill\relax
    {\large\itshape\@affiliation\par}%
    \vskip 0pt plus 0.2fill\relax
    {\ifx\@copyrightinfo\@empty~\else%
         \copyright\space\@copyrightinfo\fi\\
         \itshape
         \ifx\@copyrightlicense\@empty~\else%
           \@copyrightlicense\fi\\[0.3ex]
      \edef\PHIM@url{%
        www.philosophersimprint.org/\@@journalvolume\@@journalnumber/}
      \ifPHIM@hyperref\relax
         \href{http://\PHIM@url}{\textcolor{black}{
             \textless \PHIM@url\textgreater}}%
      \else
         \textless \PHIM@url\textgreater
      \fi
      \vskip 0pt plus 0.2fill\relax
      \par}%
  }}%
\definecolor{PHIM@blue}{rgb}{0.184, 0.431, 0.7749}%
\definecolor{PHIM@gray}{gray}{0.549}%
\newif\ifPHIM@appendix\PHIM@appendixfalse
\renewcommand\section{\par
  \addpenalty\@secpenalty\nobreak
  \addvspace{0.75\PHIM@baselength}
  \@afterindentfalse
  \secdef\@section\@ssection}%
\def\@section[#1]#2{%
  \ifnum\c@secnumdepth>0\relax
     \refstepcounter{section}%
     \addcontentsline{toc}{section}{\ifPHIM@appendix\appendixname\space\fi
       \thesection.\quad#1}%
  \else
     \addcontentsline{toc}{section}{#1}%
  \fi
  {\noindent\raggedright\interlinepenalty\@M
   \normalsize\bfseries
   \ifnum\c@secnumdepth>0\relax
      \ifPHIM@appendix\appendixname\space\fi\thesection.\quad #2
   \else
      #2
   \fi}%
   \vspace*{0.25\PHIM@baselength}%
   \@afterheading
   \nobreak\par}
\def\@ssection#1{%
  {\noindent\raggedright\interlinepenalty\@M
   \normalsize\bfseries #1}%
   \vspace*{0.25\PHIM@baselength}%
   \@afterheading
   \nobreak\par}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-\PHIM@baselength}%
                                     {1sp}%
                                     {\normalfont\normalsize\itshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-1sp}%
                                     {1sp}%
                                     {\normalfont\normalsize\itshape}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {1sp}%
                                    {-1sp}%
                                    {\normalfont\normalsize}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {1sp}%
                                       {-1sp}%
                                      {\normalfont\normalsize}}
\renewcommand\appendix{\par
  \PHIM@appendixtrue
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesection{\@Alph\c@section}}
\renewcommand\@makefntext[1]{%
  \bgroup
  \parindent2\PHIM@baselength\relax
  \everypar{\hangindent=\PHIM@baselength\hangafter=1}%
  \noindent
  \makebox[\PHIM@baselength][l]{\@thefnmark.}#1\egroup}
\settoheight{\footnotesep}{\footnotesize\strut}
\setlength{\skip\footins}{13.5pt plus 1fill}
\interfootnotelinepenalty=0
\normalsize
\frenchspacing
\endinput
%%
%% End of file `philosophersimprint.cls'.
