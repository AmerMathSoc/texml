%%% LaTeX class for manuscripts submitted to the
%%% journal 'Agricultural Economics' (AgEcon)
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the AgEcon Formatting Instructions in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, caption, endfloat, geometry,
%%% lmodern, natbib, setspace, titlesec, url
%%%
%%% The class provides following options:
%%% noendfloat - do not move floats to the end of the paper
%%% author - show name(s) of authors(s)
%%% date - show date
%%% letterpaper - use US letter paper format instead of A4
%%%
%%% The AgEcon journal requires that you use double quotes
%%% you could do this with the ``csquotes'' package:
%%% \usepackage{csquotes}
%%% \MakeOuterQuote{<yourQuoteCharacter>}
%%%
%%% The corresponding BibTeX style file "agecon.bst" should be used
%%% for the bibliography: \bibliographystyle{agecon}
%%%
%%% This document class provides 3 new commands:
%%% \keywords can be use to show keywors below the abstract
%%% \jelclass can be use to show JEL classifications below the abstract
%%% \affiliation can be used to add affiliation information
%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{agecon}[2009/11/18 LaTeX class for the journal 'Agricultural Economics']

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

% option use US letter format (instead of A4)
\newcounter{UseLetterPaper}
\setcounter{UseLetterPaper}{0}
\DeclareOption{letterpaper}{\setcounter{UseLetterPaper}{1}}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,pointednumbers,tablecaptionabove]{scrartcl}
% pointednumbers = add final dot after ordinary section numbers
% tablecaptionabove = use \captionabove for tables

% use babel package and set language to english
\RequirePackage[english]{babel}

% page format, margins
\RequirePackage{geometry}
\ifthenelse{\equal{\theUseLetterPaper}{0}}{
   \geometry{a4paper, tmargin=2.5cm, bmargin=2.8cm, lmargin=2.5cm,
      rmargin=2.5cm, headheight=0cm, headsep=0cm, footskip=1.2cm }
}{
   \geometry{letterpaper, tmargin=2.5cm, bmargin=2.8cm, lmargin=2.5cm,
      rmargin=2.5cm, headheight=0cm, headsep=0cm, footskip=1.2cm }
}

% double spacing
\RequirePackage{setspace}
\doublespacing

% font of (subsub)section headers
\setkomafont{section}{\bfseries}
\setkomafont{subsection}{\normalfont\itshape}
\setkomafont{subsubsection}{\normalfont\itshape}

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

% font: latin modern
\RequirePackage{lmodern}

% amsmath
\RequirePackage[fleqn]{amsmath}
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
\usepackage{caption}
\captionsetup{justification=raggedright,singlelinecheck=false,
   labelfont=rm,textfont=rm}
\captionsetup[table]{labelsep=newline}
\captionsetup[figure]{labelsep=period}
\addto\captionsenglish{%
  \renewcommand{\figurename}{Fig.}%
}

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
\hrule
\section*{Abstract}
}{%
\ifthenelse{ \isundefined\@jelclass }{}{
\smallskip\\ \noindent
\textit{JEL classification:} \@jelclass
}
\ifthenelse{ \isundefined\@keywords }{}{
\smallskip\\ \noindent
\textit{Key words:} \@keywords
}
\bigskip
\hrule
\clearpage
}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

% move floats to the end of the paper
\ifthenelse{\equal{\theUseEndfloat}{1}}{
\RequirePackage[heads,tablesfirst,nomarkers,nolists]{endfloat}
}{}

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
