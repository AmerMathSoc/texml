% Turabian Formatting for LaTeX
%
% Based on the Chicago Manual of Style (16th edition) and Kate Turabian's A
% Manual for Writers of Research Papers, Theses, and Dissertations (8th edition)
%
% ==============================
% Copyright 2013-2016 Omar Abdool
%
% This work may be distributed and/or modified under the conditions of the LaTeX
% Project Public License (LPPL), either version 1.3 of this license or (at your
% option) any later version.
%
% The latest version of this license is in:
%	http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% LPPL Maintenance Status: maintained (by Omar Abdool)
%
% This work consists of the files: turabian-formatting.sty,
% turabian-researchpaper.cls, turabian-thesis.cls, turabian-formatting-doc.tex,
% and turabian-formatting-doc.pdf (in addition to the README file).
%
% ==============================
%
%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{turabian-thesis}[2016/03/18 Turabian Theses and Dissertations]


% Default point size
\def\@@ptsize{12pt}


% Options for document class

\DeclareOption{raggedright}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{authordate}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{noadjustbib}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{endnotes}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{twocolumn}{%
	\ClassWarningNoLine{turabian-researchpaper}{The '\CurrentOption' option is not supported.}
	\OptionNotUsed}

\DeclareOption{notitlepage}{%
	\ClassWarningNoLine{turabian-researchpaper}{The '\CurrentOption' option is not supported.}
	\OptionNotUsed}

\DeclareOption{10pt}{\def\@@ptsize{10pt}}

\DeclareOption{11pt}{\def\@@ptsize{11pt}}

\DeclareOption{12pt}{\def\@@ptsize{12pt}}


% Deprecated option
\DeclareOption{emptymargins}{%
	\ClassWarningNoLine{turabian-researchpaper}{The '\CurrentOption' option has been deprecated.}
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}


% Pass other options to book document class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptions\relax


% Build upon book document class
\LoadClass[titlepage,oneside,onecolumn,\@@ptsize]{book}


% Load turabian-formatting package
\RequirePackage{turabian-formatting}


% Create binding offset of 0.5in
\setlength\oddsidemargin{0.5in}
\setlength\evensidemargin{\z@}
\addtolength\textwidth{-\oddsidemargin}


% Title page commands for use with \maketitle (deprecated, not functional)

\newcommand{\faculty}[1]{\gdef\tf@faculty{#1}}
\faculty{\@empty}

\newcommand{\mydegree}[1]{\gdef\tf@mydegree{#1}}
\mydegree{\@empty}


% Renew \maketitle command for Thesis/Dissertation title page

\submissioninfo{%
	A Dissertation Submitted to\par
	[Faculty]\par
	in Candidacy for the Degree of\par
	[Degree]}

\department{[Department]}

\institution{[Institution]}

\location{[City], [State/Province]}

\renewcommand{\maketitle}{%
	\begin{titlepage}%
		\singlespacing
		\tf@setfnpunct{}
		\renewcommand*{\thefootnote}{\fnsymbol{footnote}}
		\let\footnoterule\relax
		\normalfont\normalsize
		\begin{center}
			\vspace*{-1.2\baselineskip}
			\parskip=1\baselineskip
			\tf@institution\par
			\vspace*{\stretch{1}}
			{\bfseries\@title}\par
			{\bfseries\tf@subtitle}\par%
			\vspace*{\stretch{1}}
			\tf@submissioninfo\par
			\vspace*{1\baselineskip}
			\tf@department\par
			\vspace*{\stretch{1}}
			by\par
			{\bfseries\@author}\par
			\vspace*{\stretch{1}}
			\tf@location\par
			\@date
			\parskip=0pt
		\end{center}%
	\end{titlepage}%
	\setcounter{page}{2}
	\tf@emptymaketitle
	\global\let\@faculty\@empty
	\global\let\@mydegree\@empty
	\global\let\faculty\relax
	\global\let\mydegree\relax
	\cleardoublepage}


% Renew \contentsname based on language package

\AtEndPreamble{
	\@ifpackageloaded{polyglosia}%
		{%
			\addto\captionsenglish{%
				\renewcommand{\contentsname}{Table of Contents}}%
		}{}
	\@ifpackageloaded{babel}%
		{%
			\addto\captionsenglish{%
				\renewcommand{\contentsname}{Table of Contents}}%
		}{}}


