%%% LaTeX class for manuscripts submitted to the
%%% Journal 'Post-Communist Economies' (PoCoEc)
%%%
%%% author: Arne Henningsen
%%% version: 1.3 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the PoCoEc formatting instructions in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, csquotes, endfloat, endnotes, geometry
%%% ifthen, lmodern, natbib, setspace, stringstrings, textcomp, url
%%%
%%% The class provides the following options:
%%% noendfloat       - don't move floats to the end of the paper
%%% nofulltitlepage  - suppress "full" title page with author names,
%%%                    affiliations, and address of corresponding author
%%% noshorttitlepage - suppress "short" title page without information
%%%                    about authors
%%% showauthor       - show author name(s) on "short" title page
%%%                    (useful in combination with option "nofulltitlepage")
%%%
%%% This class selects the BibTeX style "tandfx.bst".
%%% (Taylor and Francis Reference Style X)
%%%
%%% This class provides 5 new commands:
%%% \affiliation     specify affiliation(s) of the authors
%%% \cauthormark     mark the corresponding author (by an asterisk)
%%% \cauthoraddress  specify address of the corresponding author
%%% \keywords        specify some keywords (separated by semicolons)
%%%
%%%
%%% Websites of the journal ``Post-Communist Economies":
%%% 
%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pocoec}[2009/11/18 LaTeX class for the journal 'Post-Communist Economies']

% package for convenient if-then-else statements
\RequirePackage{ifthen}

% option to NOT place floats at the end
\newif\if@useendfloat
\@useendfloattrue
\DeclareOption{noendfloat}{\@useendfloatfalse}

% option to suppress the full title page with author names
\newif\if@makefulltitlepage
\@makefulltitlepagetrue
\DeclareOption{nofulltitlepage}{\@makefulltitlepagefalse}

% option to suppress the short title page without author names
\newif\if@makeshorttitlepage
\@makeshorttitlepagetrue
\DeclareOption{noshorttitlepage}{\@makeshorttitlepagefalse}

% option to show author name(s)
\newif\if@showauthor
\@showauthorfalse
\DeclareOption{showauthor}{\@showauthortrue}


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
\geometry{a4paper, tmargin=2.5cm, bmargin=2.8cm, lmargin=2.8cm,
  rmargin=2.8cm, headheight=0cm, headsep=0cm, footskip=1.2cm }

% double spacing
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
\setlength{\intextsep}{6mm}

% font families: times/helvetica/courier
\RequirePackage{mathptmx}
\RequirePackage[scaled=.90]{helvet}
\RequirePackage{courier}

% section headers
\setkomafont{section}{\rmfamily\bfseries}
\setkomafont{subsection}{\rmfamily\bfseries\itshape}
\setkomafont{subsubsection}{\rmfamily\itshape}
\setkomafont{paragraph}{\rmfamily\itshape}
\setcounter{secnumdepth}{0} 

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
\bibpunct{(}{)}{,}{a}{}{,}
\setlength{\bibsep}{0pt}
\bibliographystyle{tandfx}

% captions of figures and tables
\setcapwidth[l]{\textwidth}
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalsize\normalfont\bfseries}
\setkomafont{caption}{\normalsize\normalfont\bfseries}
\renewcommand{\captionformat}{.\ }

% titlepage(s)
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\newcommand{\affilmark}[1]{\textsuperscript{\normalfont{#1}}}
\newcommand{\email}[1]{\newcommand{\@email}{#1}}
\newif\if@cauthormarkused
\@cauthormarkusedfalse
\newcommand{\cauthormark}{\textsuperscript{*}\@cauthormarkusedtrue}
\RequirePackage{stringstrings}
\renewcommand{\maketitle}{
   \if@makefulltitlepage
      \setcounter{page}{0}
      \thispagestyle{empty}
      \vspace*{12mm}
      \begin{spacing}{1.5}\noindent
      \large{\textbf{\@title}}%
      \end{spacing}
      \vspace*{6mm}
      \ifthenelse{ \isundefined\@author }{
         \ClassWarning{pocoec}{No author(s) specified.
            Please specify with command \protect\author}
      }{
      }
      \noindent
      \@author\\
      \if@cauthormarkused
      \else
         \ClassWarningNoLine{pocoec}{No author has been indicated as
            corresponding author.
            Please specify with command \protect\cauthormark}
      \fi
      \vspace*{6mm}
      \begin{spacing}{1.1}
      \ifthenelse{ \isundefined\@affiliation }{
         \ClassWarning{pocoec}{No affiliation(s) specified.
            Please specify with command \protect\affiliation}
      }{
         \noindent
         \textit{\@affiliation}\\
      }
      \vfill
      \ifthenelse{ \isundefined\@email }{
         \ClassWarningNoLine{pocoec}{No email address of the corresponding author
            is specified. Please specify with command \protect\email}
      }{
         \noindent
         \rule{0.3\textwidth}{0.1mm}\\
         \vspace*{2mm}\noindent
         \cauthormark%
         \findwords[q]{\@author}{~and~}%
         \ifthenelse{ \equal{\theresult}{0} }{}{%
            Corresponding author.
         }%
         Email: \url{\@email}\\
      }
      \end{spacing}
      \vspace*{5mm}
      \clearpage
   \fi
   \if@makeshorttitlepage
      \begin{spacing}{1.5}\noindent
      \large{\textbf{\@title}}
      \if@showauthor
         \renewcommand{\cauthormark}{}
         \findwords[q]{\@author}{~and~}%
         \ifthenelse{ \equal{\theresult}{0} }{%
            \renewcommand{\affilmark}[1]{}}{}%
         \vspace*{3mm}\\
         \@author
         \vspace*{1mm}\\
         \textit{\small \@affiliation}
      \fi
      \end{spacing}
      \vspace*{4mm}
   \fi
}

% abstract, keywords
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\renewenvironment{abstract}{%
   \vspace*{5mm}
   \noindent
   \textbf{Abstract}\\
   \noindent
}{%
   \ifthenelse{ \isundefined\@keywords }{
   \ClassWarningNoLine{pocoec}{No keywords specified.
      Please use the command \protect\keywords}
   }{
   \vspace*{5mm}\\ \noindent
   \textbf{Keywords:} \@keywords%
   }
   \vspace*{5mm}
   \clearpage
}

% use babel package and set language to british english
\RequirePackage[english,british]{babel}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

% move floats to the end of the paper
\if@useendfloat
   \RequirePackage[nolists,tablesfirst]{endfloat}
\fi

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
