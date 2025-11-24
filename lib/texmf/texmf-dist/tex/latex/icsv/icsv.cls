%%
%% This is file `icsv.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% icsv.dtx  (with options: `classfile')
%%   ______________________________
%%   Copyright 2006  Will Robertson
%% 
%%   License information appended.
%% 
\ProvidesClass{icsv}
  [2006/07/25 v0.2 Class file for ICSV]
\LoadClass[12pt,twoside]{article}
\RequirePackage[a4paper,vmargin=38mm,hmargin=32mm,ignoreall]{geometry}
\RequirePackage{amsmath,amssymb,array,bm,calc,fancyhdr,fixltx2e,fix-cm,graphicx,hyperref,ifthen}
\RequirePackage{caption}[2006/01/12]
\hypersetup{
  colorlinks,
  linkcolor=black,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  menucolor=black,
  pagecolor=black,
  urlcolor=black,
  pdfstartview=FitH,
  pdfpagelayout=SinglePage
  }
\renewcommand\rmdefault{ptm}
\renewcommand\ttdefault{txtt}
\RequirePackage[scaled=0.87]{helvet}
\normalfont
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\frenchspacing
\setlength\parindent{1.5em}
\captionsetup{labelsep=endash,font={small,it}}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[CE]{\footnotesize \pdf@authors}
\fancyhead[CO]{\footnotesize ICSV13, July 2--6, Vienna, Austria}
\setcounter{secnumdepth}{0}
\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {-1.6\baselineskip}%
                                   {0.8\baselineskip}%
                                   {\centering\bfseries\MakeUppercase}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-0.8\baselineskip}%
                                     {0.8\baselineskip}%
                                     {\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                    {-0.8\baselineskip}%
                                    {0.8\baselineskip}%
                                    {\bfseries\itshape}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {0.8\baselineskip}%
                                    {-0.8\baselineskip}%
                                    {\bfseries}}
\let\subparagraph\undefined
\renewenvironment{abstract}
  {\vspace{\baselineskip}\fontsize{11}{11}\selectfont
   {\fontsize{13}{13}\bfseries\noindent Abstract\par}
   \noindent\ignorespaces}
  {\par}
\def\list@spacing{%
  \parsep    4pt
  \itemsep   0pt
  \topsep    6pt
  \partopsep 0pt}
\def\enumerate{%
  \ifnum \@enumdepth > \thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}%
         \list@spacing}%
  \fi}
\let\endenumerate\endlist
\def\itemize{%
  \ifnum \@itemdepth > \thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}%
       \list@spacing}%
  \fi}
\let\enditemize\endlist
\let\itemise\itemize
\let\enditemise\enditemize
\renewcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\def\fps@figure{htbp}
\def\fps@table{htbp}
\renewenvironment{figure}[1][\fps@figure]
                 {\edef\@tempa{\noexpand\@float{figure}[#1]}
                  \@tempa\centering}
                 {\end@float}
\renewenvironment{table}[1][\fps@table]
                 {\edef\@tempa{\noexpand\@float{table}[#1]}
                  \@tempa\centering}
                 {\end@float}
\AtBeginDocument{%
  \@ifpackageloaded{booktabs}{}{\setlength\extrarowheight{2pt}}}
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
\renewcommand\maketitle{%
  \thispagestyle{empty}\noindent
  \begin{minipage}{\textwidth}
    \renewcommand\footnoterule{\vspace{-1ex}}%
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \begin{center}
      \vspace{-3cm}
      \includegraphics[height=4cm]{icsv-logo}%
    \end{center}
    \vspace{1sp}%
    \begin{center}
      \bfseries\fontsize{15}{17}\selectfont\MakeUppercase{\@title}%
    \end{center}
    \vspace{-2.5ex}%
    \def\@makefnmark{\smash{\textsuperscript{\@thefnmark}}}%
    {\parindent\z@
     \leftskip\@flushglue
     \rightskip\@flushglue
     \parfillskip\z@
     \address@list\par}
     \def\thempfootnote{\@fnsymbol\c@mpfootnote}
    \after@maketitle
  \end{minipage}
  \hypersetup{pdfauthor={\pdf@authors},pdftitle={\@title}}%
  \vspace{2ex}\par}
\let\after@maketitle\@empty
\newcommand\pdfkeywords[1]{\hypersetup{pdfkeywords={#1}}}
\def\author@init{%
  \def\@@author##1{%
    \g@addto@macro\author@list{##1}%
    \def\@@author####1{\g@addto@macro\author@list{\author@sep ####1}}}%
  \let\author@list\@empty}
\author@init
\renewcommand\author[2][\c@affiliation]{%
  \ifx\pdf@authors\@empty\else
    \g@addto@macro\pdf@authors{, }%
  \fi
  \g@addto@macro\pdf@authors{#2}%
  \g@addto@macro\author@list{\mbox\bgroup}%
  \@@author{#2}%
  \if@showaff
    \@for\@@index :=#1\do{%
      \expandafter\g@addto@macro
      \expandafter\author@list
      \expandafter{%
      \expandafter\place@affiliation
      \expandafter{%
                   \@@index}}%
    }
  \fi
  \g@addto@macro\author@list{\egroup}}
\newcommand\place@affiliation[1]{\kern1pt\textsuperscript{#1}}
\let\pdf@authors\@empty
\def\email#1{%
  \g@addto@macro\author@list{\kern1pt\footnotemark}%
  \g@addto@macro\after@maketitle{%
    \stepcounter{footnote}%
    \footnotetext[\the\c@footnote]{\centering\url{#1}}}}
\g@addto@macro\after@maketitle{\setcounter{footnote}{0}}
\let\address@list\@empty
\providecommand\@@authorhook{}
\providecommand\@@addresshook{\vspace{1ex}\fontsize{11}{13}\selectfont}
\def\address#1{%
  \begingroup
    \let\footnotemark\relax
    \def\\{\egroup\hbox\bgroup\@@addresshook\ignorespaces}
    \sbox\tempbox{%
      \vbox{%
        \hbox{\strut\@@authorhook\author@list}
        \hbox{\@@addresshook #1}}}
    \settowidth\templength{\usebox\tempbox}
    \ifthenelse{\lengthtest{\templength>0.49\linewidth}}{\global\boxwidth\linewidth}{%
      \ifthenelse{\lengthtest{\templength>\boxwidth}}{\global\boxwidth\templength}{}}%
    \expandafter\make@address@box\expandafter{\author@list}{#1}
  \endgroup
  \author@init}
\newlength\boxwidth
\newlength\templength
\newbox\tempbox
\newcommand\make@address@box[2]{%
  \g@addto@macro\address@list{%
    \begin{minipage}[t]{\boxwidth+10pt}%
      \centering
      \def\@tempa{#1}%
      \ifx\@tempa\@empty
      \else
        \vspace*{\medskipamount}%
        {\@@authorhook#1\par\vspace{3pt}}
      \fi
      {\linespread{0.9}%
       \@@addresshook
       \if@showaff
         \makebox[0pt][r]{\textsuperscript{\number\c@affiliation}}%
       \fi
       \ignorespaces#2\par}
    \end{minipage}%
    \stepcounter{affiliation}%
    \hskip\@flushglue}}
\newcounter{affiliation}
\stepcounter{affiliation}
\g@addto@macro\after@maketitle{\setcounter{affiliation}{1}}
\newif\if@showaff
\newcommand\showaffiliations{\@showafftrue}
\def\author@sep{,~\,}
\let\zf@font@warning\@font@warning
\let\@font@warning\@font@info
\DeclareSymbolFont{legacymaths}{OT1}{cmr}{m}{n}
\SetSymbolFont{legacymaths}{bold}{OT1}{cmr}{bx}{n}
\DeclareMathAccent{\acute}   {\mathalpha}{legacymaths}{19}
\DeclareMathAccent{\grave}   {\mathalpha}{legacymaths}{18}
\DeclareMathAccent{\ddot}    {\mathalpha}{legacymaths}{127}
\DeclareMathAccent{\tilde}   {\mathalpha}{legacymaths}{126}
\DeclareMathAccent{\bar}     {\mathalpha}{legacymaths}{22}
\DeclareMathAccent{\breve}   {\mathalpha}{legacymaths}{21}
\DeclareMathAccent{\check}   {\mathalpha}{legacymaths}{20}
\DeclareMathAccent{\hat}     {\mathalpha}{legacymaths}{94}
\DeclareMathAccent{\dot}     {\mathalpha}{legacymaths}{95}
\DeclareMathAccent{\mathring}{\mathalpha}{legacymaths}{23}
\DeclareMathSymbol{!}{\mathclose}{legacymaths}{33}
\DeclareMathSymbol{:}{\mathrel}  {legacymaths}{58}
\DeclareMathSymbol{;}{\mathpunct}{legacymaths}{59}
\DeclareMathSymbol{?}{\mathclose}{legacymaths}{63}
\DeclareMathSymbol{0}{\mathalpha}{legacymaths}{`0}
\DeclareMathSymbol{1}{\mathalpha}{legacymaths}{`1}
\DeclareMathSymbol{2}{\mathalpha}{legacymaths}{`2}
\DeclareMathSymbol{3}{\mathalpha}{legacymaths}{`3}
\DeclareMathSymbol{4}{\mathalpha}{legacymaths}{`4}
\DeclareMathSymbol{5}{\mathalpha}{legacymaths}{`5}
\DeclareMathSymbol{6}{\mathalpha}{legacymaths}{`6}
\DeclareMathSymbol{7}{\mathalpha}{legacymaths}{`7}
\DeclareMathSymbol{8}{\mathalpha}{legacymaths}{`8}
\DeclareMathSymbol{9}{\mathalpha}{legacymaths}{`9}
\DeclareMathSymbol{\Gamma}{\mathalpha}{legacymaths}{0}
\DeclareMathSymbol{\Delta}{\mathalpha}{legacymaths}{1}
\DeclareMathSymbol{\Theta}{\mathalpha}{legacymaths}{2}
\DeclareMathSymbol{\Lambda}{\mathalpha}{legacymaths}{3}
\DeclareMathSymbol{\Xi}{\mathalpha}{legacymaths}{4}
\DeclareMathSymbol{\Pi}{\mathalpha}{legacymaths}{5}
\DeclareMathSymbol{\Sigma}{\mathalpha}{legacymaths}{6}
\DeclareMathSymbol{\Upsilon}{\mathalpha}{legacymaths}{7}
\DeclareMathSymbol{\Phi}{\mathalpha}{legacymaths}{8}
\DeclareMathSymbol{\Psi}{\mathalpha}{legacymaths}{9}
\DeclareMathSymbol{\Omega}{\mathalpha}{legacymaths}{10}
\DeclareMathSymbol{+}{\mathbin}{legacymaths}{43}
\DeclareMathSymbol{=}{\mathrel}{legacymaths}{61}
\DeclareMathDelimiter{(}{\mathopen} {legacymaths}{40}{largesymbols}{0}
\DeclareMathDelimiter{)}{\mathclose}{legacymaths}{41}{largesymbols}{1}
\DeclareMathDelimiter{[}{\mathopen} {legacymaths}{91}{largesymbols}{2}
\DeclareMathDelimiter{]}{\mathclose}{legacymaths}{93}{largesymbols}{3}
\DeclareMathDelimiter{/}{\mathord}{legacymaths}{47}{largesymbols}{14}
\DeclareMathSymbol{\mathdollar}{\mathord}{legacymaths}{36}
\DeclareSymbolFont{operators}\encodingdefault\rmdefault\mddefault\updefault
\SetSymbolFont{operators}{normal}\encodingdefault\rmdefault\mddefault\updefault
\SetMathAlphabet\mathrm{normal}\encodingdefault\rmdefault\mddefault\updefault
\SetMathAlphabet\mathit{normal}\encodingdefault\rmdefault\mddefault\itdefault
\SetMathAlphabet\mathbf{normal}\encodingdefault\rmdefault\bfdefault\updefault
\SetMathAlphabet\mathsf{normal}\encodingdefault\sfdefault\mddefault\updefault
\SetMathAlphabet\mathtt{normal}\encodingdefault\ttdefault\mddefault\updefault
\SetSymbolFont{operators}{bold}\encodingdefault\rmdefault\bfdefault\updefault
\SetMathAlphabet\mathrm{bold}\encodingdefault\rmdefault\bfdefault\updefault
\SetMathAlphabet\mathit{bold}\encodingdefault\rmdefault\bfdefault\itdefault
\SetMathAlphabet\mathsf{bold}\encodingdefault\sfdefault\bfdefault\updefault
\SetMathAlphabet\mathtt{bold}\encodingdefault\ttdefault\bfdefault\updefault
\let\font@warning\zf@font@warning
%% 
%% Copyright 2006 by Will Robertson <wspr81@gmail.com>
%% 
%% Distributable under the LaTeX Project Public License,
%% version 1.3c or higher (your choice). The latest version of
%% this license is at: http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status)
%% by Will Robertson.
%% 
%% This work consists of the file  icsv.dtx
%%           and the derived files icsv.cls and icsv.ins
%%           and the documentation icsv.pdf.
%% 
%%
%% End of file `icsv.cls'.
