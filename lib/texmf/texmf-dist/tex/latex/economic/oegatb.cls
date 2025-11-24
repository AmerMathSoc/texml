%%% LaTeX class for short papers for publication in the "Tagungsband"
%%% of the "Oesterreichische Gesellschaft für Agraroekonomie" (OeGA)
%%%
%%% author: Arne Henningsen
%%% version: 1.0 (19 August 2008)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the OeGA Formatting Instructions in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, fancyhdr, geometry, helvet, ifthen,
%%% natbib, setspace, titlesec, url
%%%
%%% The class provides following options:
%%% german - German language (default)
%%% english - English language
%%% nopagenumbers - suppress page numbers
%%%
%%%
%%% The corresponding BibTeX style file "oega.bst" is used
%%% for the bibliography: \bibliographystyle{oega}
%%%
%%% This document class provides following new commands:
%%% \affiliation should be used to add affiliation information


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oegatb}[2008/08/19 LaTeX class for the OeGA Tagungsband]

% option for English language
\newif\if@LanguageEnglish
\@LanguageEnglishfalse
\DeclareOption{english}{\@LanguageEnglishtrue}
\DeclareOption{german}{\@LanguageEnglishfalse}

% option for no page numbers
\newif\if@PageNumbers
\@PageNumberstrue
\DeclareOption{nopagenumbers}{\@PageNumbersfalse}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[10pt,tablecaptionabove]{scrartcl}
% tablecaptionabove = use \captionabove for tables

% load ifthen package
\RequirePackage{ifthen}

% Verdana font
\RequirePackage[scaled=1.18]{helvet}
\renewcommand\familydefault{phv}

% page format, margins
\RequirePackage{geometry}
\geometry{a4paper, tmargin=2.3cm, bmargin=2.5cm, lmargin=2.6cm,
  rmargin=2.0cm, headheight=0in, headsep=0in, footskip=1.25cm}

% language
\if@LanguageEnglish
   \RequirePackage[english]{babel}
\else
   \RequirePackage[ngerman]{babel}
\fi

% space between columns
\setlength{\columnsep}{1.25cm}

% spacing
\RequirePackage{setspace}

% formatting of main text
\newcommand{\StartTextFormat}{%
   \footnotesize%
   \begin{spacing}{1.18}%
}
\newcommand{\EndTextFormat}{%
   \end{spacing}%
}

% spacing around (sub)section headers
\RequirePackage{titlesec}
\titlespacing*{\section}{0pt}{1em}{0.25em}
\titlespacing*{\subsection}{0pt}{0.85em}{0.15em}

% spacing around formulas
\newcommand{\SetFormulaSpacings}{
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

% section headers: centering and set font
\titleformat{\section}[block]
   {\normalfont\filcenter}
   {\arabic{section}. }
   {0pt}
   {\normalfont\small\scshape}

% subsection headers: font
\setkomafont{subsection}{\normalfont\footnotesize\itshape}

% footnote: font
\setkomafont{footnote}{\fontsize{6pt}{8pt}\selectfont}
% no rule between text and footnotes
\renewcommand{\footnoterule}{}

% URLS: font
\RequirePackage{url}
\def\UrlFont{\sffamily}

% math
\RequirePackage{amsmath}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\setlength{\bibsep}{4pt}
\setlength{\bibhang}{0em}
\bibliographystyle{oega}

% set footer
\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0pt}
\newcommand{\FormatFooters}{%
\fancyhead{}
\fancyfoot{}
% \fancyfoot[L]{\fontsize{6pt}{8pt}\selectfont{\"O}GA Tagungsband \the\year}
\if@PageNumbers
   \fancyfoot[R]{\footnotesize\thepage}
\fi
\pagestyle{fancy}
}

% captions of figures and tables
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalfont\scriptsize}
\setkomafont{caption}{\normalfont\scriptsize}
\renewcommand{\captionformat}{.\ }

% section and subsections are not numbered
\setcounter{secnumdepth}{0}

% titlepage without author and date
\renewcommand{\maketitle}{
\twocolumn[
   \begin{@twocolumnfalse}
   \begin{center}
   \vspace*{5mm}
   \begin{huge}
   \begin{spacing}{1.25}
   \@title
   \end{spacing}
   \end{huge}
   \vspace*{6mm}
   \@author\\
   \vspace*{4.5mm}
   \end{center}
   \end{@twocolumnfalse}
   ]
\StartTextFormat
}

% abstract with affiliation
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\renewenvironment{abstract}{%
\noindent%
\scriptsize%
\bfseries%
\textit{Abstract} --
}{%
\ifthenelse{ \isundefined\@affiliation }{
\ClassWarning{oegatb}{no affiliation specified.
   Please use command  \protect\affiliation}%
}{%
\deffootnote[0pt]{0pt}{1.5em}{}%
\hspace{-1.0em}\footnote{\@affiliation}}%
\deffootnote[0.5em]{0.5em}{1.5em}{\textsuperscript{\thefootnotemark}}%
}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

% commands that should be used at the beginning / end of the document
\AtBeginDocument{
\sffamily
\SetFormulaSpacings
\FormatFooters
}
\AtEndDocument{
\EndTextFormat
}

% for compatibility with other classes
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}  % ignored
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}  % ignored

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
