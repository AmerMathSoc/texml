%% This is file `third-rep.cls'
%%
%% Time-stamp: <2011-08-17 16:46:44 grahamgough>
%%

%%
%% Copyright 1999-2001 G.D. Gough and the University of Manchester
%%
%% This program can redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or (at your option) any later version.

%%
%% A LaTeX class defining layout for UMCSD third year project reports
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{third-rep}[2001/04/03 UMCSD Third year report style]

\DeclareOption{draftgraphics}{\PassOptionsToPackage{draft}{graphicx}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

% PROCESS OPTIONS
\ProcessOptions

\LoadClass{report}
\usepackage{a4-mancs}
\usepackage{graphicx}

\usepackage{verbatim}

\newif\ifthanks@
\thanks@false
\def\thanksfile#1{\gdef\@thanksfile{#1}\thanks@true}

\def\supervisor#1{\gdef\@supervisor{#1}}
\def\reportyear#1{\gdef\@reportyear{#1}}
\def\abstractfile#1{\gdef\@abstractfile{#1}}
\def\@title{}\def\@author{}
\def\@supervisor{}
\reportyear{2001}
\abstractfile{null}

\def\dotitleandabstract{%
  \thispagestyle{empty}%
  \vspace*{1.4in}
  \begin{center}
    {\large { University of Manchester\\School of Computer Science\\Project Report \@reportyear} \\
      \vspace*{0.2in}
      {\bf \@title} \\
      \vspace*{0.2in}
      Author: \@author\\
      \vspace*{0.2in}
      Supervisor: \@supervisor}
  \end{center}
  \begin{abstract}
    \begin{center}
      \large
      \@title \\
      \vspace*{0.2in}
      Author: \@author
    \end{center}
    \normalsize
    \setlength{\parindent}{0pt}
    \input \@abstractfile \relax
    \begin{center}
      \large Supervisor: \@supervisor
    \end{center}
  \end{abstract}
  \ifthanks@{
    \clearpage
    \vspace*{1.4in}
    \begin{center}
      {\textbf{Acknowledgements}} \\
    \end{center}
    \begin{quotation}
      \input{\@thanksfile}
    \end{quotation}
  }
  \fi
}

\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname
        \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
%%%%%%%%%%%%%%%%%%%%%%%%
\addcontentsline{toc}{chapter}{\protect\numberline{}\bibname}% add toc entry
%%%%%%%%%%%%%%%%%%%%%%%%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
