%%% LaTeX class for manuscripts submitted to the
%%% European Review of Agricultural Economics (ERAE)
%%%
%%% author: Arne Henningsen
%%% version: 1.3 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the ERAE Formatting Instructions in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, courier, endfloat, geometry,
%%% helvet, ifthen, mathptmx, natbib, setspace, titlesec, url
%%%
%%% The class provides following options:
%%% noendfloat - don't move floats to the end of the paper
%%% author - show name(s) of authors(s)
%%% date - show date
%%%
%%% The ERAE requires that you use single quotes
%%% you could do this with the ``csquotes'' package:
%%% \usepackage{csquotes}
%%% \MakeInnerQuote{<yourQuoteCharacter>}
%%%
%%% The corresponding BibTeX style file "erae.bst" should be used
%%% for the bibliography: \bibliographystyle{erae}
%%%
%%% This document class provides 5 new commands:
%%% \keywords can be use to show keywors below the abstract
%%% \jelclass can be use to show JEL classifications below the abstract
%%% \affiliation can be used to add affiliation information
%%% \citetPage{page}{key} for citations like Author (Year: page)
%%% \citepPage{page}{key} for citations like (Author, year: page)
%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{erae}[2009/11/18 LaTeX class for the European Review of Agricultural Economics]

\RequirePackage{ifthen}

% option to NOT place floats at the end
\newcounter{UseEndfloat}
\setcounter{UseEndfloat}{1}
\DeclareOption{noendfloat}{\setcounter{UseEndfloat}{0}}

% option to show the authors' names
\newcounter{ShowAuthor}
\setcounter{ShowAuthor}{0}
\DeclareOption{author}{\setcounter{ShowAuthor}{1}}

% option to print the date
\newcounter{ShowDate}
\setcounter{ShowDate}{0}
\DeclareOption{date}{\setcounter{ShowDate}{1}}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,pointednumbers,tablecaptionabove]{scrartcl}
% pointednumbers = add final dot after ordinary section numbers
% tablecaptionabove = use \captionabove for tables

% page format, margins
\RequirePackage{geometry}
\geometry{a4paper, tmargin=2.5cm, bmargin=2.8cm, lmargin=2.5cm,
  rmargin=2.5cm, headheight=0cm, headsep=0cm, footskip=1.2cm }

% one half spacing
\RequirePackage{setspace}
\onehalfspacing

% spacing around (sub)section headers
\RequirePackage{titlesec}
\titlespacing*{\section}{0pt}{1em}{0.25em}
\titlespacing*{\subsection}{0pt}{0.85em}{0.15em}

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

% font families: times/helvetica/courier
\RequirePackage{mathptmx}
\RequirePackage[scaled=.90]{helvet}
\RequirePackage{courier}

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
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalfont\bfseries}
\renewcommand{\captionformat}{.\ }

% titlepage without author and date
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\renewcommand{\maketitle}{
   \begin{center}
   \begin{spacing}{1.5}
   \LARGE{\textbf{\@title}}%
   \end{spacing}
   \ifthenelse{\equal{\theShowAuthor}{1}}{
      \begin{large}
      \textbf{\@author}\\
      \end{large}
      \ifthenelse{ \isundefined\@affiliation }{}{
         \vspace*{3mm}
         \begin{small}
         \@affiliation\\
         \end{small}
      }
      \vspace*{5mm}
   }{}
   \ifthenelse{\equal{\theShowDate}{1}}{
      \@date\\
      \vspace*{5mm}
   }{}
   \end{center}
}

% abstract, keywords, JEL classification
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\renewenvironment{abstract}{%
\begin{center}
\begin{minipage}{0.9 \textwidth}
\small
\begin{center}
\textbf{Abstract}
\end{center}
}{%
\ifthenelse{ \isundefined\@keywords }{
\ClassWarningNoLine{erae}{No keywords specified.
   Please use the command \protect\keywords}
}{
\smallskip\\ \noindent
Key words: \@keywords
}
\ifthenelse{ \isundefined\@jelclass }{
\ClassWarningNoLine{erae}{No JEL classification specified.
   Please use the command \protect\jelclass}
}{
\smallskip\\ \noindent
JEL classification: \@jelclass
}
\end{minipage}
\end{center}%
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

% move floats to the end of the paper
\ifthenelse{\equal{\theUseEndfloat}{1}}{
\RequirePackage[heads,tablesfirst,nolists]{endfloat}
}{}

% cite page numbers after colon
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}: #1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}: #1}}
