% University of Auckland thesis class
%
% aucklandthesis.cls
%
% built on memoir.cls by Peter Wilson, Lars Madsen
%
% Written for broader applicability
% across disciplines by 
% Alistair Kwan 
% Centre for Learning & Research in Higher Education
% University of Auckland
% 
% Version of 2016-06-11
%
% Accommodates theses for the PhD and some other degrees.
%
% This class does not intervene much — font and 
% chapter heading customisation are left for 
% user to determine, as is the choice to compile
% using XeLaTeX or LuaTeX.
%
% Incorporates code snippets from the Memoir class manual.
% 
% This file may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, either version 1.2 of this license
% or (at your option) any later version.  The latest version of this
% license is in:
% 
%    http://www.latex-project.org/lppl.txt
% 
% and version 1.2 or later is part of all distributions of LaTeX version
% 1999/12/01 or later.
%

 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{aucklandthesis}
      [2016/06/11 University of Auckland thesis class]
\newif\ifUa@examcp
\newif\ifUa@singlesp
\newif\ifUa@onehalfsp
\newif\ifUa@doublesp
\newif\ifUa@partialfulfilment
\newif\ifUa@subtitle

\Ua@examcpfalse
\Ua@onehalfspfalse
\Ua@doublespfalse
\Ua@partialfulfilmentfalse
\Ua@subtitlefalse

\DeclareOption{doublespace}{\Ua@doublesptrue}
\DeclareOption{singlespace}{\Ua@singlesptrue}
\DeclareOption{onehalfspace}{\Ua@onehalfsptrue}
\DeclareOption{examcopy}{\Ua@examcptrue}
\DeclareOption{partial}{\Ua@partialfulfilmenttrue}
%\DeclareOption{draft} option already exists 
%\DeclareOption{twoside}{\PassOptionsToPackage{twoside}{geometry}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

%\ExecuteOptions{oneside}
\ProcessOptions\relax

\LoadClass{memoir}

% Set page dimensions
\setlrmarginsandblock{4cm}{4cm}{*}
\setulmarginsandblock{3cm}{4cm}{*}
\setheadfoot{\baselineskip}{3\baselineskip}
\setheaderspaces{*}{2\baselineskip}{*}
\setmarginnotes{3mm}{3cm}{6pt}
\checkandfixthelayout
\fixpdflayout

% Typeface: leave the author to choose

\midsloppy % author can override with fussy or sloppy
\sloppybottom % for fewer widows and orphans

% Constrain excessive subdivisional numberings
\setsecnumdepth{subsubsection}

% Title page
\def\@title{}
\def\@subtitle{\relax}
\def\subtitle#1{
	\gdef\@subtitle{#1}
	\sbox0{#1}%
	\ifdim\wd0=0pt %
		\Ua@subtitlefalse%
	\else%
		\Ua@subtitletrue%
	\fi%
}
\def\@author{}
\def\degreesought#1{\gdef\@degreesought{#1}}
\def\@degreesought{\@latex@error{No \noexpand\degreesought given}\@ehc}
\def\degreediscipline#1{\gdef\@degreediscipline{#1}}
\def\@degreediscipline{\@latex@error{No \noexpand\degreediscipline given}\@ehc}
\def\degreecompletionyear#1{\gdef\@degreecompletionyear{#1}}
\def\@degreecompletionyear{\@latex@error{No \noexpand\degreecompletionyear given}\@ehc}

\renewcommand{\maketitle}{
	\cleardoublepage
	\thispagestyle{empty}
	\enlargethispage{1cm}
	\setcounter{page}{1}
	\noindent\hrulefill
	
	\noindent\begin{minipage}[t][0.3\textheight][t]{\textwidth}
	\vspace*{\fill}
	\begin{center}
		\Huge \@title \par
		\ifUa@subtitle
			\huge \vspace{0.5\baselineskip} \@subtitle \par 
			\else \relax
		\fi
	\end{center}
	\vspace*{\fill}
	\end{minipage}
	
	\vfill
	
	\noindent\begin{minipage}[t][0.3\textheight][t]{\textwidth}
	\vspace*{\fill}
	\begin{center}
		\large
		\@author
	\end{center}
	\vspace*{\fill}
	\end{minipage}
	
	\vfill
	
	\noindent\begin{minipage}[t][0.3\textheight][t]{\textwidth}
	\vspace*{\fill}
	\begin{center}
		\normalfont
		A thesis submitted in
		\ifUa@partialfulfilment
			partial 
		\fi
		fulfilment of the requirements for the degree of
		
		\@degreesought\
		in 
		\@degreediscipline,
		
		The University of Auckland,
		\@degreecompletionyear.
		
		\ifUa@examcp
			\bigskip
			\textbf{This thesis is for examination purposes only,} 
			
			\textbf{and is confidential to the examination process.}
		\fi
	\end{center}
	\vspace*{\fill}
	\end{minipage}
	
	\noindent\hrulefill
	
	\clearpage
	\killtitle
	\mainmatter
}

% Command for dedication page
\newcommand\thesisdedication[1]{
	\cleardoublepage
\thispagestyle{plain}
\vspace*{\fill}
\begin{center}
#1
\end{center}
\vspace*{\fill}
\vspace*{\fill}
}

% line spacing
\renewcommand\mainmatter{
	\ifUa@doublesp
   \DoubleSpacing%
\else\ifUa@singlesp
   \SingleSpacing%
\else
   \OnehalfSpacing
\fi%
\fi
}

\renewcommand\backmatter{
	\clearpage
	\setcounter{page}{0}
}

\frenchspacing



\nouppercaseheads
\createmark{chapter}{both}{nonumber}{}{}
\createmark{section}{right}{nonumber}{}{}

% Pagestyle: Forder
\copypagestyle{Forder}{myheadings}
\makerunningwidth{Forder}{1.2\textwidth}
\makeheadposition{Forder}{flushright}{flushleft}{}{}
\makeoddhead{Forder}{}{}{\itshape{\rightmark}\makebox[0.2\textwidth]{\quad\normalfont\thepage\hfill}}
\makeevenhead{Forder}{\makebox[0.2\textwidth]{\hfill\thepage\quad}\emph{\leftmark}}{}{}
\makepsmarks{Forder}{
	\nouppercaseheads
	\createmark{chapter}{both}{nonumber}{}{}
	\createmark{section}{right}{nonumber}{}{}
	}

% Chapter style: Forder
\makechapterstyle{Forder}{%
	\renewcommand\chaptername{chapter}
    \def\chapterheadstart{\vspace*{\beforechapskip}}
    \def\printchaptername{\SingleSpacing\center\chapnamefont --- \@chapapp} 
    \def\chapternamenum{\space}
    \def\printchapternum{\chapnumfont \NumToName{\value{chapter}}}
    \def\printchapternum{\chapnumfont \roman{chapter} ---}
    \def\afterchapternum{\par\nobreak\vskip\midchapskip}
    \def\printchapternonum{}
    \def\printchaptertitle##1{\begin{center}\SingleSpace\chaptitlefont ##1\end{center}}
    \def\afterchaptertitle{\par\nobreak\vskip \afterchapskip}
    \renewcommand*{\chapnamefont}{\normalfont\Large\scshape}
    \renewcommand*{\chapnumfont}{\chapnamefont}
    \renewcommand*{\chaptitlefont}{\normalfont\Huge\scshape\MakeLowercase}
    \setlength{\beforechapskip}{50pt}
    \setlength{\midchapskip}{20pt}
    \setlength{\afterchapskip}{60pt}
    %
    \setsecnumdepth{section}
    \renewcommand*\thesection{\arabic{section}}
	%
	\setsechook{\hangsecnum}
	\setaftersecskip{3pt}
	\setsecheadstyle{\raggedright\Large\scshape}
    \setbeforesecskip{-1.5\onelineskip}
    \setaftersecskip{0.5\onelineskip}
    %
    \setsubsechook{\defaultsecnum}
	\setsubsecheadstyle{\raggedright\large\bfseries}
    \setbeforesubsecskip{-\onelineskip}
    \setaftersubsecskip{0.5\onelineskip}
	%
	\setsubsubsecheadstyle{\raggedright\itshape}
    \setbeforesubsubsecskip{-\onelineskip}
    \setaftersubsubsecskip{0.5\onelineskip}
    %
    \pagestyle{Forder}
}

% Page style: Sewell
\copypagestyle{Sewell}{myheadings}
\makeoddhead{Sewell}{\itshape{\rightmark}}{}{\thepage}
\makeevenhead{Sewell}{\thepage}{}{\itshape{\thechapter. \leftmark}}
\makeheadrule{Sewell}{\textwidth}{0.5pt}
\makepsmarks{Sewell}{
	\nouppercaseheads
	\createmark{chapter}{both}{nonumber}{}{}
	\createmark{section}{right}{nonumber}{}{}
	}
	
% Chapter style: Sewell
\makechapterstyle{Sewell}{%
	\renewcommand\chaptername{Chapter}
    \def\chapterheadstart{\vspace*{\beforechapskip}}
    \def\printchaptername{\SingleSpacing\flushright \chapnamefont \@chapapp} 
    \def\chapternamenum{\space}
    \def\printchapternum{\chapnumfont\numtoName{\value{chapter}}}
    \def\afterchapternum{\par\nobreak \hrulefill\par\vskip\midchapskip}
    \def\printchapternonum{}
    \def\printchaptertitle##1{\SingleSpacing\raggedright\chaptitlefont ##1}
    \def\afterchaptertitle{\par\nobreak\vskip \afterchapskip}
    \renewcommand*{\chapnamefont}{\normalfont\Large\scshape}
    \renewcommand*{\chapnumfont}{\chapnamefont}
    \renewcommand*{\chaptitlefont}{\normalfont\Huge\itshape}
    \setlength{\beforechapskip}{50pt}
    \setlength{\midchapskip}{12pt}
    \setlength{\afterchapskip}{60pt}
    %
    \setsecnumdepth{chapter}
    %
	\setsecheadstyle{\center\Large\scshape\MakeLowercase}
    \setbeforesecskip{-1.5\onelineskip}
    \setaftersecskip{0.5\onelineskip}
    %
	\setsubsecheadstyle{\center\large\bfseries}
    \setbeforesubsecskip{-\onelineskip}
    \setaftersubsecskip{0.01\onelineskip}
	%
	\setsubsubsecheadstyle{\center\itshape}
    \setbeforesubsubsecskip{-\onelineskip}
    \setaftersubsubsecskip{0.01\onelineskip}
    %
    \pagestyle{Sewell}
}


% uppercase chapter entries in ToC, hyperref-friendly
%\makeatletter
%\renewcommand*{\l@chapter}[2]{%
%  \l@chapapp{\uppercase{#1}}{#2}{\cftchaptername}}
%\makeatother

\renewcommand\cftchapterfont{\scshape}
\setlength\cftsubsectionindent{6em}
\renewcommand\cftsubsectionfont{\itshape}

\AtBeginDocument{%
% Mark drafts in page footer
\ifdraftdoc
	\makeevenfoot{plain}{\textit{Draft}}{\thepage}{\textit\today}
	\makeoddfoot{plain}{\textit{Draft}}{\thepage}{\textit\today}
	\makeevenfoot{myheadings}{\thepage}{\textit{Draft: \today}}{}
	\makeoddfoot{myheadings}{}{\textit{Draft: \today}}{\thepage}
	\nouppercaseheads
	\createmark{chapter}{both}{nonumber}{}{}
	\createmark{section}{right}{nonumber}{}{}
\fi
}


\endinput
