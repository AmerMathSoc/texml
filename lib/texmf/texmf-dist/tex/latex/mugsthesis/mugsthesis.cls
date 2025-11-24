%%
%% This is file `mugsthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mugsthesis.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2014 by Paul D. Gessler
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3 of this license or (at your option) any later
%% version. The latest version of this license is in:
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of
%% LaTeX version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Paul D. Gessler <pdgessler@gmail.com>.
%% 
%% This work consists of the files mugsthesis.dtx and mugsthesis.ins
%% and the derived file mugsthesis.cls.
%% 
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{mugsthesis}
    [2014/08/07 v1.0 Marquette University Graduate School Thesis Class]
\RequirePackage{etoolbox}
\newbool{indentfirst}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{memoir}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{memoir}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{memoir}}
\DeclareOption{final}{\PassOptionsToClass{final}{memoir}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{memoir}}
\DeclareOption{indentfirsttrue}{\booltrue{indentfirst}}
\DeclareOption{indentfirstfalse}{\boolfalse{indentfirst}}
\DeclareOption*{%
  \ClassWarning{mugsthesis}{Unknown option `\CurrentOption' ignored}%
}
\ExecuteOptions{12pt,final,indentfirsttrue}
\ProcessOptions\relax
\ifbool{indentfirst}{\RequirePackage{indentfirst}}{}
\LoadClass[letterpaper,oneside]{memoir}
\DoubleSpacing
\raggedright
\raggedbottom
\setlrmarginsandblock{1.5in}{1.0in}{*} % left and right margins
\setulmarginsandblock{1.0in}{1.0in}{*} % top and bottom margins
\setheaderspaces{0.5in}{*}{*} % header 0.5in from edge
\marginparmargin{left} % use the wider (left) margin for notes
\setmarginnotes{0.125in}{1.25in}{\baselineskip} % type area for notes
\checkandfixthelayout[lines] % check the layout; TODO check algorithm selection
\setlength\parindent{0.5in}
\makepagestyle{mugs}
\makeevenhead{mugs}{}{}{\thepage}
\makeoddhead{mugs}{}{}{\thepage}
\aliaspagestyle{chapter}{mugs}
\pagestyle{mugs}
\newcommand{\degree}[1]{\def\mugsdegree{#1}}
\newcommand{\degreemo}[1]{\def\mugsdegreemo{#1}}
\newcommand{\degreeyr}[1]{\def\mugsdegreeyr{#1}}
\renewcommand{\title}[1]{\def\@title{\uppercase{#1}}}
\renewcommand{\maketitle}{{%
  \cleardoublepage
  \pagenumbering{Alph}
  \SingleSpace
  \thispagestyle{empty}
  \centering
  \@title
  \vfill
  by
  \vskip \onelineskip
  \@author
  \vfill
  A Thesis submitted to the Faculty of the Graduate School,\\
  Marquette University,\\
  in Partial Fulfillment of the Requirements for\\
  the Degree of \mugsdegree{}
  \vfill
  Milwaukee, Wisconsin
  \vskip \onelineskip
  \mugsdegreemo~\mugsdegreeyr
  \clearpage
}}
\renewenvironment{abstract}{%
  \thispagestyle{empty}
  \begin{SingleSpace}
  \begin{center}
    ABSTRACT\\
    \@title
    \vskip 2\onelineskip
    \@author
    \vskip \onelineskip
    Marquette University, \mugsdegreeyr
    \vskip 2\baselineskip
  \end{center}
  \@afterindentfalse\@afterheading % makes indentfirst work with custom envs
}{
  \end{SingleSpace}\setcounter{page}{0}
}
\newenvironment{acknowledgments}{%
  \addcontentsline{toc}{chapter}{ACKNOWLEDGMENTS}
  \chapter*{Acknowledgments}
  \begin{SingleSpace}
  \begin{center}
    \unskip
    \@author
    \vskip 2\onelineskip
  \end{center}
  \@afterindentfalse\@afterheading
}{\end{SingleSpace}}
\newenvironment{dedication}{%
  \addcontentsline{toc}{chapter}{DEDICATION}
  \chapter*{Dedication}
  \begin{SingleSpace}\vskip\onelineskip
  \@afterindentfalse\@afterheading
}{\end{SingleSpace}}
\newsubfloat{figure}
\newsubfloat{table}
\setcounter{lofdepth}{2}
\setcounter{lotdepth}{2}
\makechapterstyle{mugs}{%
  \setlength{\midchapskip}{0pt}
  \setlength{\afterchapskip}{0pt}
  \renewcommand*{\chapterheadstart}{}
  \renewcommand*{\chaptitlefont}{\bfseries}
  \renewcommand*{\printchaptername}{\centering \MakeTextUppercase{\@chapapp}}
  \renewcommand*{\printchapternum}{\thechapter}
  \renewcommand*{\printchaptertitle}[1]{%
    \SingleSpacing \protect\parbox{\textwidth}{%
      \centering \chaptitlefont \MakeTextUppercase{##1}
    }
  }
}% end{mugs}
\chapterstyle{mugs}
\pretocmd{\listoftables}{\clearforchapter}{}{%
  \ClassWarning{mugsthesis}{Patching `\noexpand\listoftables' failed}
}
\pretocmd{\listoffigures}{\clearforchapter}{}{%
  \ClassWarning{mugsthesis}{Patching `\noexpand\listoffigures' failed}
}
\renewcommand*{\contentsname}{TABLE OF CONTENTS}
\renewcommand*{\listtablename}{LIST OF TABLES}
\renewcommand*{\listfigurename}{LIST OF FIGURES}
\renewcommand*{\bibname}{BIBLIOGRAPHY}
\setlength{\bibitemsep}{\onelineskip}
\renewcommand*{\prebibhook}{\SingleSpacing\vskip\onelineskip}
\renewcommand*{\biblistextra}{%
  \setlength{\itemsep}{\bibitemsep}
  \setlength{\leftmargin}{0.375in}% hanging indent
  \setlength{\itemindent}{\labelwidth}%
  \addtolength{\itemindent}{\labelsep}
  \addtolength{\itemindent}{-\leftmargin}
}
\renewcommand{\tableofcontents}{%
  \@ifstar{\mem@tableofcontents{01}}
          {\mem@tableofcontents{01}}%
}
\setlength{      \cftchapterindent}{0.0in}
\setlength{      \cftsectionindent}{0.5in}
\setlength{   \cftsubsectionindent}{1.0in}
\setlength{\cftsubsubsectionindent}{1.5in}
\setlength{    \cftparagraphindent}{2.0in}
\setlength{ \cftsubparagraphindent}{2.5in}
\setlength{        \cfttableindent}{0.0in}
\setlength{     \cftsubtableindent}{0.5in}
\setlength{       \cftfigureindent}{0.0in}
\setlength{    \cftsubfigureindent}{0.5in}
\setrmarg{3.55em plus 1fil}
\setlength{\cftbeforechapterskip}{\onelineskip}
\setlength{\cftbeforesectionskip}{\onelineskip}
\setlength{\cftbeforesubsectionskip}{\onelineskip}
\setlength{\cftbeforesubsubsectionskip}{\onelineskip}
\setlength{\cftbeforeparagraphskip}{\onelineskip}
\setlength{\cftbeforesubparagraphskip}{\onelineskip}
\setlength{\cftbeforetableskip}{\onelineskip}
\setlength{\cftbeforesubtableskip}{\onelineskip}
\setlength{\cftbeforefigureskip}{\onelineskip}
\setlength{\cftbeforesubfigureskip}{\onelineskip}
\renewcommand{\insertchapterspace}{}
\renewcommand{\aftertoctitle}{\vspace{-\onelineskip}\aftergroup\SingleSpacing}
\renewcommand{\afterlottitle}{\vspace{-\onelineskip}\aftergroup\SingleSpacing}
\renewcommand{\afterloftitle}{\vspace{-\onelineskip}\aftergroup\SingleSpacing}
\renewcommand{\cftchapterfont}{\normalfont}
\renewcommand{\cftchapterleader}{\cftsectionleader}
\renewcommand{\cftchapterpagefont}{\normalfont}
\AtEndPreamble{\providecommand{\texorpdfstring}[2]{#1}}
\settocpreprocessor{chapter}{%
\let\tempf@rtoc\f@rtoc%
\def\f@rtoc{%
  \texorpdfstring{\MakeTextUppercase{\tempf@rtoc}}{\tempf@rtoc}}%
}
\AtBeginEnvironment{quote}{\par\SingleSpacing}
\AtBeginEnvironment{quotation}{\par\SingleSpacing}
\maxsecnumdepth{subsection}
\settocdepth{subsection}
\newlength{\preheadskip}\setlength{\preheadskip}{1sp plus 1sp minus 1sp}
\newlength{\postheadskip}\setlength{\postheadskip}{\onelineskip}
\setsecheadstyle{\bfseries\SingleSpacing}
\setbeforesecskip{\preheadskip}
\setaftersecskip{\postheadskip}
\setsubsecheadstyle{\bfseries\SingleSpacing}
\setbeforesubsecskip{\preheadskip}
\setaftersubsecskip{\postheadskip}
\setsubsubsecheadstyle{\bfseries\SingleSpacing}
\setbeforesubsubsecskip{\preheadskip}
\setaftersubsubsecskip{\postheadskip}
\tightlists
\AtBeginEnvironment{tabular}{\SingleSpacing}
\captionstyle[\centering]{\raggedright}
\subcaptionsize{\small}
\setlength{\abovecaptionskip}{\parsep}
\setlength{\belowcaptionskip}{-\parsep}
\clubpenalty=10000
\widowpenalty=9996
\brokenpenalty=4991
\predisplaypenalty=10000
\postdisplaypenalty=1549
\displaywidowpenalty=1602
\setlength{\floatsep}{3\onelineskip}
\setlength{\intextsep}{2\onelineskip}
\setlength{\textfloatsep}{2\onelineskip}
\setlength{\dblfloatsep}{2\onelineskip}
\setlength{\dbltextfloatsep}{2\onelineskip}

\endinput
%%
%% End of file `mugsthesis.cls'.
