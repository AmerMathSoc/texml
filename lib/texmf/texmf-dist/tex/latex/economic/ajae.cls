%%% LaTeX class for manuscripts submitted to the
%%% American Journal of Agricultural Economics (AJAE)
%%%
%%% author: Arne Henningsen
%%% version: 1.7 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the AJAE Formatting Instructions in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, bm, courier, endfloat, endnotes, geometry,
%%% helvet, mathptmx, natbib, setspace, titlesec, url
%%%
%%% The class provides following options:
%%% noendnotes - don't use endnotes (use footnotes)
%%% noendfloat - don't move floats to the end of the paper
%%% author - show name(s) of authors(s)
%%% date - show date
%%% preprint - print the 'preprint notice'
%%% published - print a notice that the paper has been published
%%%
%%%
%%% The corresponding BibTeX style file "ajae.bst" should be used
%%% for the bibliography: \bibliographystyle{ajae}
%%%
%%% This document class provides following new commands:
%%% \keywords can be use to show keywors below the abstract
%%% \jelclass can be use to show JEL classifications below the abstract
%%% \leadingfootnote can be used to add a leading unnumbered footnote
%%% \affiliation can be used to add affiliation information
%%% \veclatin should be used for latin symbols that denote vectors
%%% \matlatin should be used for latin symbols that denote matrices
%%% \vecgreek should be used for greek symbols that denote vectors
%%% \matgreek should be used for greek symbols that denote matrices
%%% \ajaeyear, \ajaeissue, \ajaenumber, and \ajaepages should be used
%%%    after the publication to specify the year, issue, number,
%%%    and pages, respectively.
%%%
%%% If you use footnotes, add following lines before the reference section:
%%%    \clearpage
%%%    \listofendnotes


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ajae}[2009/11/18 LaTeX class for the American Journal of Agricultural Economics]

\RequirePackage{ifthen}

% option to use footnotes in place of endnotes
\newif\if@UseEndnotes
\@UseEndnotestrue
\DeclareOption{noendnotes}{\@UseEndnotesfalse}

% option to NOT place floats at the end
\newif\if@UseEndfloat
\@UseEndfloattrue
\DeclareOption{noendfloat}{\@UseEndfloatfalse}

% option to show the authors' names
\newif\if@ShowAuthor
\@ShowAuthorfalse
\DeclareOption{author}{\@ShowAuthortrue}

% option to print the date
\newif\if@ShowDate
\@ShowDatefalse
\DeclareOption{date}{\@ShowDatetrue}

% option to print the 'preprint notice'
\newif\if@ShowPreprintNote
\@ShowPreprintNotefalse
\DeclareOption{preprint}{\@ShowPreprintNotetrue}

% option to print the 'published notice'
\newif\if@ShowPublishedNote
\@ShowPublishedNotefalse
\DeclareOption{published}{\@ShowPublishedNotetrue}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,tablecaptionabove]{scrartcl}
% tablecaptionabove = use \captionabove for tables

% page format, margins
\RequirePackage{geometry}
\geometry{letterpaper, tmargin=1.0in, bmargin=1.1in, lmargin=1.25in,
  rmargin=1.25in, headheight=0in, headsep=0in, footskip=0.5in }

% double spacing
\RequirePackage{setspace}
\doublespacing

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

% font for section headers
\setkomafont{section}{\normalfont\bfseries}

% font for subsection headers
\setkomafont{subsection}{\normalfont\itshape}

% fonts for math
\RequirePackage[leqno,fleqn]{amsmath}
\RequirePackage{bm}
% latin symbols for vectors and matrices
\newcommand{\veclatin}[1]{\bm{#1}}
\newcommand{\matlatin}[1]{\bm{#1}}
% greek symbols for vectors and matrices
\newcommand{\vecgreek}[1]{\pmb{#1}}
\newcommand{\matgreek}[1]{\pmb{#1}}

% font for URLs
\RequirePackage{url}
\def\UrlFont{\rmfamily}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\bibpunct{(}{)}{;}{a}{}{,}
\setlength{\bibsep}{0pt}

% captions of figures and tables
\setcapwidth[l]{\textwidth}
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalfont\bfseries}
\setkomafont{caption}{\normalfont\bfseries}
\renewcommand{\captionformat}{.\ }

% section and subsections are not numbered
\setcounter{secnumdepth}{0}

% leading unnumbered footnote
\long\def\leadingfootnote#1{\begingroup%
   \def\thefootnote{\fnsymbol{footnote}}\footnote[0]{#1}\endgroup}

% titlepage without author and date
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\newcommand{\ajaeissue}[1]{\newcommand{\@ajaeissue}{#1}}
\newcommand{\ajaenumber}[1]{\newcommand{\@ajaenumber}{#1}}
\newcommand{\ajaeyear}[1]{\newcommand{\@ajaeyear}{#1}}
\newcommand{\ajaepages}[1]{\newcommand{\@ajaepages}{#1}}
\renewcommand{\maketitle}{
   \begin{center}
   \begin{LARGE}
   \begin{spacing}{1.25}
   \textbf{\@title}
   \end{spacing}
   \end{LARGE}
   \vspace*{10mm}
   \if@ShowAuthor
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
   \fi
   \if@ShowDate
      \@date\\
      \vspace*{5mm}
   \fi
   \if@ShowPreprintNote
      \begin{small}
      This is a preprint of an Article accepted for publication in
      \textit{American Journal of Agricultural Economics}.
      \copyright{} \the\year ,
      American Agricultural Economics Association
      \end{small}
      \vspace*{5mm}
   \fi
   \if@ShowPublishedNote
      \begin{small}
      This is an electronic version of an Article published in\\
      \textit{American Journal of Agricultural Economics}%
      \ifthenelse{ \isundefined\@ajaeissue }{%
         \ClassWarningNoLine{ajae}{No issue of the AJAE publication specified.
            Please use the command \protect\ajaeissue}%
      }{, \@ajaeissue{}}%
      \ifthenelse{ \isundefined\@ajaenumber }{%
         \ClassWarningNoLine{ajae}{No number of the AJAE publication specified.
            Please use the command \protect\ajaenumber}%
      }{(\@ajaenumber{})}%
      \ifthenelse{ \isundefined\@ajaepages }{%
         \ClassWarningNoLine{ajae}{No pages of the AJAE publication specified.
            Please use the command \protect\ajaepages}%
      }{, p.~\@ajaepages{}}.\\
      \copyright{}%
      \ifthenelse{ \isundefined\@ajaeyear }{%
         \ClassWarningNoLine{ajae}{No year of the AJAE publication specified.
            Please use the command \protect\ajaeyear}%
      }{\@ajaeyear{}}
      American Agricultural Economics Association.\\
      The final version is available on
      \url{http://www.blackwell-synergy.com/loi/AJAE}
      \end{small}
      \vspace*{5mm}
   \fi
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
\ClassWarningNoLine{ajae}{No keywords specified.
   Please use the command \protect\keywords}
}{
\smallskip\\ \noindent
Key words: \@keywords
}
\ifthenelse{ \isundefined\@jelclass }{
\ClassWarningNoLine{ajae}{No JEL classification specified.
   Please use the command \protect\jelclass}
}{
\smallskip\\ \noindent
JEL classification: \@jelclass
}
\end{minipage}
\end{center}
\vspace{\baselineskip}
\@aftermylist
}
% command "\@aftermylist": do not indent the following paragraph
\def\@aftermylist{%
   \def\if@endpe\@doendpe\fi{\@endpetrue
      \def\par{\if@endpe\@@par\else\@restorepar\everypar{}\par\@endpefalse\fi}%
         \everypar{{\setbox\z@\lastbox}\everypar{}\@endpefalse}%
   }%
}
% This code was originally posted by Donald Arseneau on comp.text.tex
% I thank Ulrike Fischer for pointing this out to me.


% use babel package and set language to english
\RequirePackage[english]{babel}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

% use endnotes in place of footnotes
\if@UseEndnotes
\RequirePackage{endnotes}
\let\footnote=\endnote
\newcommand{\listofendnotes}{
   \begingroup
   \parindent 0pt
   \parskip 2ex
   \def\enotesize{\normalsize}
   \theendnotes
   \endgroup
}
\fi

% move floats to the end of the paper
\if@UseEndfloat
\RequirePackage[tabhead,fighead,nomarkers,nolists]{endfloat}
\fi

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
