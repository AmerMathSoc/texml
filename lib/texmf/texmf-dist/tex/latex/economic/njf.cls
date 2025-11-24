%%% LaTeX class for the NJF seminar 425
%%% "Economic System Research in Agriculture and Rural Development"
%%% (29 September - 1 October 2009, Tartu, Estonia)
%%% and hopefully also for other NJF seminars
%%%
%%% author: Arne Henningsen
%%% version: 1.0 (18 August 2009)
%%% license: LaTeX Project Public License
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the NJF Formatting Instructions in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, courier, geometry,
%%% helvet, ifthen, mathptmx, natbib, setspace, titlesec, url
%%%
%%% This document class provides 2 new commands:
%%% \keywords can be use to show keywors below the abstract
%%% \affiliation can be used to add affiliation information
%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{njf}[2009/08/18 LaTeX class for the NJF]

\RequirePackage{ifthen}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,halfparskip,tablecaptionabove]{scrartcl}
% tablecaptionabove = use \captionabove for tables

% page format, margins
\RequirePackage{geometry}
\geometry{a4paper, tmargin=2.5cm, bmargin=2.5cm, lmargin=2.5cm,
  rmargin=2.5cm, headheight=0cm, headsep=0cm, footskip=1.2cm }

% one half spacing
\RequirePackage{setspace}
\onehalfspacing

% spacing between paragraphs
\setlength{\parskip}{6pt}

% spacing around (sub)section headers
\RequirePackage{titlesec}
\titlespacing*{\section}{0pt}{6pt}{0pt}
\titlespacing*{\subsection}{0pt}{0pt}{0pt}

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
\setlength{\intextsep}{12pt}

% font families: times/helvetica/courier
\RequirePackage{mathptmx}
\RequirePackage[scaled=.90]{helvet}
\RequirePackage{courier}

% fonts of headings
\setkomafont{section}{\rmfamily\bfseries\normalsize}
\setkomafont{subsection}{\rmfamily\bfseries\normalsize}

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

% captions of figures and tables
\setcapwidth[l]{\textwidth}

% titlepage
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\renewcommand{\maketitle}{
   \begin{center}
   \begin{spacing}{1.5}
   \Large{\textbf{\@title}}%
   \end{spacing}
   \textbf{\@author}\\
   \ifthenelse{ \isundefined\@affiliation }{
      \ClassWarningNoLine{njf}{No affiliation(s) specified.
         Please use the command \protect\affiliation}
   }{
      \vspace*{3mm}
      \begin{small}
      \@affiliation\\
      \end{small}
   }
   \vspace*{5mm}
   \end{center}
}

% abstract & keywords
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\renewenvironment{abstract}{%
\section*{Abstract}
}{%
\ifthenelse{ \isundefined\@keywords }{
\ClassWarningNoLine{njf}{No keywords specified.
   Please use the command \protect\keywords}
}{
\smallskip\\ \noindent
\textbf{Keywords:} \@keywords
}
\noindent%
}

% use babel package and set language to english
\RequirePackage[english]{babel}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

