%%
%% This is file `active-conf.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% active-conf.dtx  (with options: `classfile')
%%   _______________________
%%   The "active-conf" class
%%   (C) 2005 Will Robertson
%% 
%%   Proper license appended
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{active-conf}
  [2006/02/08 v0.3a Class file for the Active conference]
\let\active@option@warn\relax
\DeclareOption*{%
  \active@option@warn
  \def\active@option@warn{%
    \ClassError{active-conf}
      {The only class option possible is the name or year of the conference}
      {\MessageBreak
       This class takes one option: the name or year of the conference.\MessageBreak
       The file active-header-YYYY.tex is then used to create the titlepage header.\MessageBreak}}
  \let\active@option\CurrentOption}
\ProcessOptions
\LoadClass[12pt]{article}
\renewcommand\rmdefault{ptm}
\renewcommand\ttdefault{pcr}
\RequirePackage[scaled=0.87]{helvet}
\normalfont
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{calc,ifthen,url}
\RequirePackage[a4paper,margin=3cm,ignoreall]{geometry}
\RequirePackage{amsmath,amssymb,array,bm,graphicx,hyperref}
\hypersetup{
  colorlinks,
  linkcolor=black,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  menucolor=black,
  pagecolor=black,
  urlcolor=black,
  bookmarks,
  pdfstartview=FitH,
  pdfpagelayout=SinglePage
  }
\frenchspacing
\linespread{1.0517}
\pagestyle{empty}
\setlength\parindent{1.5em}
\setcounter{secnumdepth}{3}
\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {-\baselineskip}%
                                   {1pt plus 1pt}%
                                   {\sffamily\bfseries\MakeUppercase}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-\baselineskip}%
                                     {1pt plus 1pt}%
                                     {\sffamily\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                    {-\baselineskip}%
                                    {1pt plus 1pt}%
                                    {\sffamily\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {\baselineskip}%
                                    {-\baselineskip}%
                                    {\sffamily\bfseries}}
\let\subparagraph\undefined
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
                                \normalfont\itshape #1}
\def\abstract@error{%
  \ClassError{active-conf}{Not allowed in the abstract.}
    {The abstract must not contain maths, references, or footnotes.}}
\renewenvironment{abstract}
  {\vspace{\baselineskip}\fontsize{10}{11}\selectfont
   {\centering\sffamily\bfseries ABSTRACT\par}
   \setlength\leftskip{\leftskip+1.5cm}%
   \setlength\rightskip{\rightskip+1.5cm}%
   \noindent\ignorespaces}
  {\par}
\def\eqref#1{Equation~\ref{eq:#1}}
\def\figref#1{Figure~\ref{fig:#1}}
\def\tabref#1{Table~\ref{tab:#1}}
\def\secref#1{Section~\ref{sec:#1}}
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
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\small #1:~#2}%
  \ifdim \wd\@tempboxa > \hsize
    \begingroup
      \setlength\leftskip{\leftskip+1.5cm}%
      \setlength\rightskip{\rightskip+1.5cm}%
      \small #1:~#2\par\endgroup
  \else
    \global\@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\newcommand\topcaption{%
  \refstepcounter\@captype
  \@dblarg{\@topcaption\@captype}}
\def\@topcaption#1[#2]#3{%
  \@tempskipa\abovecaptionskip
  \abovecaptionskip\belowcaptionskip
  \belowcaptionskip\@tempskipa
  \@caption{#1}[{#2}]{#3}%
  \@tempskipa\abovecaptionskip
  \abovecaptionskip\belowcaptionskip
  \belowcaptionskip\@tempskipa}
\let\caption@orig\caption
\renewcommand\caption{%
  \let\@tempa\caption@orig
  \def\@tempb{table}%
  \ifx\@captype\@tempb
    \let\@tempa\topcaption
  \fi
  \@tempa}
\def\appendix{\par
  \c@section\z@\c@subsection\z@
  \gdef\thesection{Appendix \@Alph\c@section}}
\renewcommand\maketitle{%
  \begingroup
    \def\footnote##1{\ClassWarning{active-conf}
      {Footnotes aren't allowed in address text blocks}}
    \def\thefootnote{\@alph\c@footnote}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \centering
    \@ifundefined{active@option}{}
      {\vspace*{-24pt}% hard coded because I'm lazy
       \begin{minipage}{\textwidth}
         \sffamily\small
         \IfFileExists{active-header-\active@option.tex}
           {\input active-header-\active@option.tex}
           {\ClassError{active-conf}
              {Titlepage header file active-header-\active@option.tex not found}
              {\MessageBreak
               The file active-header-YYYY.tex is required to produce the titlepage header,\MessageBreak
               where YYYY is the name or year of the conference. \MessageBreak
               Please contact the conference organisers for further information.
               \MessageBreak}}
       \end{minipage}\vspace{1ex}}
    \begin{center}
      \sffamily\bfseries\fontsize{16}{17}\selectfont\@title
    \end{center}
    \vspace{-2.5ex}%
    \begingroup
      \long\def\@makefntext##1{\parindent 1em\noindent##1}%
      \@note
      \setcounter{footnote}{0}
      \global\def\note##1{%
        \ClassWarning{active-conf}
          {\protect\note\space is only allowed before \protect\maketitle}
          {Please input all notes before the document begins.}}
    \endgroup
    \def\@makefnmark{\smash{\textsuperscript{\@thefnmark}}}
    {\parindent\z@
     \leftskip\@flushglue
     \rightskip\@flushglue
     \parfillskip\z@
     \address@list\par}
    \after@maketitle
  \endgroup
  \hypersetup{pdfauthor={\pdf@authors},pdftitle={\@title}}}
\let\after@maketitle\@empty
\newcommand\pdfkeywords[1]{\hypersetup{pdfkeywords={#1}}}
\def\note#1{\g@addto@macro\@note{\footnotetext[0]{#1}}}
\let\@note\@empty
\let\thanks\note
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
\newcommand\place@affiliation[1]{\kern1pt\textsuperscript{\@fnsymbol#1}}
\let\pdf@authors\@empty
\def\email#1{%
  \g@addto@macro\author@list{\kern1pt\footnotemark}%
  \g@addto@macro\after@maketitle{%
    \stepcounter{footnote}%
    \footnotetext[\the\c@footnote]{Email address: \url{#1}}}}
\g@addto@macro\after@maketitle{\setcounter{footnote}{0}}
\let\address@list\@empty
\providecommand\@@authorhook{\sffamily}
\providecommand\@@addresshook{\sffamily\fontsize{10}{11}\selectfont}
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
      \vspace*{\medskipamount}%
      \centering
      {\@@authorhook#1\par\vspace{3pt}}
      {\linespread{0.9}%
       \@@addresshook
       \if@showaff
         \makebox[0pt][r]{\textsuperscript{\@fnsymbol\c@affiliation}}%
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
\newcommand\unit[1]{\ensuremath{\mathrm{#1}}}
\newcommand\num[2]{\ensuremath{\text{#1}\,\mathrm{#2}}}
\AtBeginDocument{%
  \let\cite@orig\cite
  \def\cite{\ifnum\lastskip>0\relax\unskip~\fi\cite@orig}}
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
%% Copyright (C) 2005 by Will Robertson <wspr81@gmail.com>
%% Distributable under the LaTeX Project Public License,
%% v1.3a or higher (your choice). The latest version of
%% this license is at: http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status)
%% by Will Robertson.
%% 
%% This work consists of the file active-conf.dtx,
%%          and the derived files active-conf.cls and active-conf-2006.pdf,
%%          and the documentation active-conf.pdf.
%% 
%% This work contains a mostly verbatim copy of the topcapt package,
%% by Robin Fairbairns, which also has an LPPL license.
%%
%% End of file `active-conf.cls'.
