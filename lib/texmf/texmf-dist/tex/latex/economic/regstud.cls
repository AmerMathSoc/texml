%%% LaTeX class for manuscripts submitted to the
%%% Journal "Regional Studies" (regstud)
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the Formatting Instructions of the "Regional Studies" in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, endfloat, endnotes, fontnec, geometry,
%%% ifthen, natbib, setspace, soul, titlesec, url, verbatim
%%%
%%% The corresponding BibTeX style file "regstud.bst" should be used
%%% for the bibliography: \bibliographystyle{regstud}
%%%
%%% The document class provides following options:
%%% noendfloat - don't move floats to the end of the paper
%%% hidefloats - hide all floats (figures and tables)
%%% author - show name(s) of authors(s)
%%% date - show date
%%%
%%% This document class provides 3 new commands:
%%% \keywords can be used to show keywors below the abstract
%%% \jelclass can be used to show JEL classifications below the abstract
%%% \affiliation can be used spefify the affiliation(s) of the author(s)
%%%
%%% If you use footnotes, add following line before the reference section:
%%%    \listofendnotes
%%%
%%% "Regional Studies" requires that you use single quotes
%%% you could do this with the ``csquotes'' package:
%%% \usepackage{csquotes}
%%% \MakeInnerQuote{<yourQuoteCharacter>}
%%%
%%% To prepare a manuscript without floats, you can use
%%% either option "hidefloats" to hide all floats
%%% or extract the pages that do not include the floats
%%% with "pdftk", e.g. "pdftk all.pdf cat 1-14 output main.pdf"
%%% The former has the drawback that references to the hidden floats
%%% with \ref{} are no longer possible.
%%% The figures and tables can be extracted as images, e.g. with kpdf.
%%%
%%% Website of the "Regional Studies":
%%% http://www.tandf.co.uk/journals/titles/00343404.asp


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{regstud}[2009/11/18 LaTeX class for the Journal 'Regional Studies']

% option to NOT place floats at the end
\newif\if@UseEndfloat
\@UseEndfloattrue
\DeclareOption{noendfloat}{\@UseEndfloatfalse}

% option to hide floats
\newif\if@HideFloats
\@HideFloatsfalse
\DeclareOption{hidefloats}{\@HideFloatstrue \@UseEndfloatfalse}

% option to show the authors' names
\newif\if@ShowAuthor
\@ShowAuthorfalse
\DeclareOption{author}{\@ShowAuthortrue}

% option to print the date
\newif\if@ShowDate
\@ShowDatefalse
\DeclareOption{date}{\@ShowDatetrue}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,tablecaptionabove,
   noonelinecaption]{scrartcl}
% pointlessnumbers = do not add final dot after ordinary section numbers
% tablecaptionabove = use \captionabove for tables
% noonelinecaption = do not treat one-line captions differently

% for internal use 
\RequirePackage{ifthen}

% use babel package and set language to english
\RequirePackage[english]{babel}

% page format, margins
\RequirePackage{geometry}
\geometry{a4paper, tmargin=2.5cm, bmargin=2.8cm, lmargin=2.5cm,
  rmargin=2.5cm, headheight=0cm, headsep=0cm, footskip=1.2cm }

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
\setlength{\intextsep}{15pt}

% font: latin modern
\RequirePackage{lmodern}

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

%% formatting section headers
\RequirePackage{titlesec}
% package for letterspacing
\RequirePackage{soul}
% format of section headers
\newcommand{\secformat}[1]{\MakeUppercase{\so{#1}}}
\titleformat{\section}[block]
   {\normalfont\filcenter}
   {}
   {0pt}
   {\secformat}
% spacing around section headers
\titlespacing*{\section}{0pt}{3ex}{0.3ex}
% format of subsection headers
\titleformat{\subsection}[block]
   {\normalsize\itshape}
   {}
   {0pt}
   {}
% spacing around subsection headers
\titlespacing*{\subsection}{0pt}{2ex}{0.15ex}

%% warning if subsubsection headers are present
\renewcommand{\subsubsection}[1]{%
\ClassWarningNoLine{regstud}{subsubsections are ignored}%
}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\AtBeginDocument{\renewcommand{\refname}{References}}
\setlength{\bibsep}{0pt}

%% use endnotes in place of footnotes
\RequirePackage{endnotes}
\renewcommand{\notesname}{Notes}
\let\footnote=\endnote
\newcommand{\listofendnotes}{
   \begingroup
   \parindent 0pt
   \parskip 0ex
   \def\enotesize{\normalsize}
   \theendnotes
   \endgroup
}
% use normalsize numbers (copied from endnote.sty and modified thereafter)
\def\enoteformat{\rightskip\z@ \leftskip\z@ \parindent=0em
  \leavevmode\llap{\theenmark. }}


% captions of figures and tables
\setcapwidth[c]{\textwidth}
\setkomafont{captionlabel}{\centering \itshape}
\setkomafont{caption}{\centering \itshape}
\renewcommand{\captionformat}{.\, }
\addto\captionsenglish{%
  \renewcommand{\figurename}{Fig.}%
}

% move floats to the end of the paper
\if@UseEndfloat
   \RequirePackage[noheads,nolists,tablesfirst,nomarkers]{endfloat}
   \AtBeginDelayedFloats{\pagestyle{empty}}
\fi

% hide floats
\if@HideFloats
   \RequirePackage{verbatim}
   \let\figure=\comment
   \let\endfigure=\endcomment
   \let\table=\comment
   \let\endtable=\endcomment
\fi

% titlepage with title, author, affiliation and date
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\renewcommand{\and}{{\normalfont and}}
\renewcommand{\maketitle}{
   \begin{center}
   \begin{Large}
   \begin{spacing}{1.25}
   \textbf{\@title}
   \end{spacing}
   \end{Large}
   \vspace*{5mm}
   \if@ShowAuthor
      \MakeUppercase{\so{\@author}}\\
      \ifthenelse{ \isundefined\@affiliation }{}{
         \textit{\@affiliation}\\
      }
      \vspace*{3mm}
   \fi
   \if@ShowDate
      \@date\\
      \vspace*{3mm}
   \fi
   \vspace*{2mm}
   \end{center}
}


% abstract, keywords, JEL classification
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\renewenvironment{abstract}{%
\vspace*{-\baselineskip}
\mbox{}\\\noindent%
}{%
\ifthenelse{ \isundefined\@keywords }{
\ClassWarningNoLine{ajae}{No keywords specified.
   Please use the command \protect\keywords}
}{

\medskip \noindent
Key words: \@keywords
}
\ifthenelse{ \isundefined\@jelclass }{
\ClassWarningNoLine{ajae}{No JEL classification specified.
   Please use the command \protect\jelclass}
}{

\medskip \noindent
JEL classification: \@jelclass
}

\medskip
}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
