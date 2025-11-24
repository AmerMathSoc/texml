%%% LaTeX class for manuscripts submitted to the
%%%  journal 'Applied  Economics'
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (18 November 2009)
%%% license: LaTeX Project Public License
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the formatting instructions of 'Applied Economics' in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, endfloat, geometry, ifthen
%%% lmodern, natbib, setspace, textcomp, url
%%%
%%% The class provides following option:
%%% noendfloat - don't move floats to the end of the paper
%%%
%%% By default, the corresponding BibTeX style "apecon.bst" is used.
%%%
%%% This document class provides 4 new commands:
%%% \affiliation   specify affiliation(s) and full address(es) of the authors
%%% \rtitle   specify running title (max. 75 letters and spaces)
%%% \cauthor   specify corresponding author including contact details
%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apecon}[2009/11/18 LaTeX class for the journal 'Applied Economics']

% package for convenient if-then-else statements
\RequirePackage{ifthen}

% option to NOT place floats at the end
\newif\if@useendfloat
\@useendfloattrue
\DeclareOption{noendfloat}{\@useendfloatfalse}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,pointednumbers,tablecaptionabove]{scrartcl}
% pointednumbers = add final dot after ordinary section numbers
% tablecaptionabove = use \captionabove for tables

% additional symbols
\RequirePackage{textcomp}

% page format, margins
\RequirePackage{geometry}
\geometry{a4paper, tmargin=2.5cm, bmargin=2.8cm, lmargin=4cm,
  rmargin=2cm, headheight=0cm, headsep=0cm, footskip=1.2cm }

% one half spacing
\RequirePackage{setspace}
\doublespacing

% spacing around formulas
\AtBeginDocument{
\setlength{\abovedisplayshortskip}{6pt}
\setlength{\belowdisplayshortskip}{6pt}
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\allowdisplaybreaks
}

% spacing around captions and floats
\setlength{\abovecaptionskip}{6pt}
\setlength{\belowcaptionskip}{3pt}
\setlength{\floatsep}{0pt}
\setlength{\textfloatsep}{20pt}
\setlength{\intextsep}{5pt}

% font family: latin modern
\RequirePackage{lmodern}

% section headers
\setkomafont{section}{\sffamily\bfseries}
\setkomafont{subsection}{\normalfont\sffamily\itshape}
\setkomafont{subsubsection}{\normalfont\sffamily}
\renewcommand{\thesection}{\Roman{section}}
\setcounter{secnumdepth}{1} 

% amsmath
\RequirePackage{amsmath}
% for compatibility with ajae.cls
\newcommand{\veclatin}[1]{#1}
\newcommand{\matlatin}[1]{#1}
\newcommand{\vecgreek}[1]{#1}
\newcommand{\matgreek}[1]{#1}

% font for URLs
\RequirePackage{url}
\def\UrlFont{\rmfamily}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\setlength{\bibsep}{0pt}
\bibliographystyle{apecon}

% captions of figures and tables
\setcapwidth[l]{\textwidth}
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalsize\normalfont\bfseries}
\setkomafont{caption}{\normalsize\normalfont\bfseries}
\renewcommand{\captionformat}{.\ }

% titlepage without author and date
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\newcommand{\address}[1]{\newcommand{\@address}{#1}}
\newcommand{\rtitle}[1]{\newcommand{\@rtitle}{#1}}
\newcommand{\cauthor}[1]{\newcommand{\@cauthor}{#1}}
\renewcommand{\maketitle}{
   \begin{center}
   \begin{spacing}{1.5}
   \LARGE{\textbf{\@title}}%
   \end{spacing}
   \ifthenelse{ \isundefined\@author }{
      \ClassWarning{apecon}{No author(s) specified.
         Please specify with command \protect\author}
   }{
      \begin{large}
      \textbf{\@author}\\
      \end{large}
      \vspace*{3mm}
   }
   \begin{spacing}{1.1}
   \ifthenelse{ \isundefined\@affiliation }{
      \ClassWarning{apecon}{No affiliation(s) specified.
         Please specify with command \protect\affiliation}
   }{
      \textit{\@affiliation}\\
   }
   \ifthenelse{ \isundefined\@address }{
   }{
      \textit{\@address}\\
   }
   \end{spacing}
   \vspace*{5mm}
   \end{center}
   \ifthenelse{ \isundefined\@rtitle }{
      \ClassWarningNoLine{apecon}{No running title is specified.
         Please specify with command \protect\rtitle\space (max. 75 letters)}
   }{
      \textbf{Running title:}\\
      \@rtitle\\
   }
}

% abstract, keywords, JEL classification
\renewenvironment{abstract}{%
   \begin{spacing}{1.5}
   \noindent
   \textbf{Abstract}\\
}{%
   \smallskip\\ \noindent
   \end{spacing}
   \begin{spacing}{1.1}
   \noindent
   \textbf{Corresponding author:}
   \ifthenelse{ \isundefined\@cauthor }{
      ???
      \ClassWarningNoLine{apecon}{No corresponding author
         (including contact details) is specified.
         Please specify with command \protect\cauthor}
   }{
      \\\@cauthor\\
   }
   \clearpage
   \end{spacing}
}

% use babel package and set language to english
\RequirePackage[english]{babel}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

% move floats to the end of the paper
\if@useendfloat
   \RequirePackage[noheads,nomarkers,tablesfirst,nolists]{endfloat}
\fi

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
