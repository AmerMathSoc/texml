%%% LaTeX class for manuscripts submitted to the
%%% Journal "Economica" (ecca)
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (01 Feb 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the Formatting Instructions of the "Economica" in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, courier, endfloat, endnotes, geometry,
%%% helvet, ifthen, mathptmx, natbib, setspace, url
%%%
%%% The corresponding BibTeX style file "ecca.bst" should be used
%%% for the bibliography: \bibliographystyle{ecca}
%%%
%%% This document class provides 3 new commands:
%%% \keywords can be used to show keywors below the abstract
%%% \jelclass can be used to show JEL classifications below the abstract
%%% \affiliation can be used spefify the affiliation(s) of the author(s)
%%%
%%% The Economica requires that you use single quotes
%%% you could do this with the ``csquotes'' package:
%%% \usepackage{csquotes}
%%% \MakeInnerQuote{<yourQuoteCharacter>}
%%%
%%% If you use footnotes, add following line before the reference section:
%%%    \listofendnotes
%%%
%%% Websites of the "Economica":
%%% http://www.blackwellpublishing.com/ecca
%%% http://darp.lse.ac.uk/Frankweb/Economica/EconomicaHome.htm


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecca}[2009/02/01 LaTeX class for the Journal 'Economica']

\RequirePackage{ifthen}

% option to place floats at the end
\newcounter{UseEndfloat}
\setcounter{UseEndfloat}{0}
\DeclareOption{endfloat}{\setcounter{UseEndfloat}{1}}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,pointlessnumbers,tablecaptionabove,
   noonelinecaption]{scrartcl}
% pointlessnumbers = do not add final dot after ordinary section numbers
% tablecaptionabove = use \captionabove for tables
% noonelinecaption = do not treat one-line captions differently

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

% font families: times/helvetica/courier
\RequirePackage{mathptmx}
\RequirePackage[scaled=0.90]{helvet}
\RequirePackage{courier}

% amsmath
\RequirePackage[leqno,fleqn]{amsmath}
% leqno = equations are numbered at the left of the page
% for compatibility with ajae.cls
\newcommand{\veclatin}[1]{#1}
\newcommand{\matlatin}[1]{#1}
\newcommand{\vecgreek}[1]{#1}
\newcommand{\matgreek}[1]{#1}

% font for URLs
\RequirePackage{url}
\def\UrlFont{\rmfamily}

%% formatting section headers
% numbered by Roman numerals
\renewcommand{\thesection}{\Roman{section}.}
% font
\setkomafont{section}{\normalfont \scshape}
% center section headers (copied from scrartcl.cls and modified thereafter)
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-2.0ex \@plus -1ex \@minus -.2ex}%
  {0.5ex \@plus.2ex}%
  {\setlength{\parfillskip}{\z@ \@plus 1fil}%
    \raggedsection\normalfont\sectfont\nobreak\size@section\nobreak \centering }}
% do not number section "Introduction"
% \let\sectionOrig\section
% \renewcommand{\section}[1]{
%    \ifthenelse{ \equal{ #1 }{ Introduction } }
%    {\sectionOrig*{#1}}
%    {\sectionOrig{#1}}
% }

%% formatting subsection headers
% numbered alphabetically
\renewcommand{\thesubsection}{(\alph{subsection})}
% font
\setkomafont{subsection}{\normalfont \itshape}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\AtBeginDocument{\renewcommand{\refname}{REFERENCES}}
\setlength{\bibsep}{0pt}

%% use endnotes in place of footnotes
\RequirePackage{endnotes}
\renewcommand{\notesname}{NOTES}
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

%% modify section headers in the appendix
% (copied from scrartcl.cls and modified thereafter)
\renewcommand*\appendix{\par%
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \renewcommand*\thesection{Appendix~\@Alph\c@section}%
  \let\othersectionlevelsformat\othersectionlevelsformatAppendix
  \@ifundefined{appendixmore}{}{\appendixmore}}
\newcommand*{\othersectionlevelsformatAppendix}[1]{%
   \ifthenelse{ \equal{ #1 }{ section } }
      {\csname the#1\endcsname : \enskip}
      {\csname the#1\endcsname\autodot\enskip}
}


% captions of figures and tables
\setcapwidth[c]{\textwidth}
\setcapindent*{0pt}
\setkomafont{captionlabel}{\centering \scshape}
\setkomafont{caption}{\centering \scshape}
\renewcommand{\captionformat}{}

% move floats to the end of the paper
\ifthenelse{\equal{\theUseEndfloat}{1}}{
   \RequirePackage[heads,nolists,tablesfirst]{endfloat}
   \renewcommand{\figureplace}{%
      \begin{center}
      [\figurename~\thepostfig\ here]
      \end{center}
   }
   \renewcommand{\tableplace}{%
      \begin{center}
      [\tablename~\theposttbl\ here]
      \end{center}
   }
}{}

% titlepage with title, author, affiliation and date
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\renewcommand{\and}{{\normalfont and}}
\renewcommand{\maketitle}{
   \begin{center}
   \begin{Large}
   \begin{spacing}{1.25}
   \@title
   \end{spacing}
   \end{Large}
   \vspace*{5mm}
   By \textsc{\@author}\\
   \ifthenelse{ \isundefined\@affiliation }{}{
      \vspace*{3mm}
      \textit{\@affiliation}\\
   }
   \vspace*{3mm}
   \@date\\
   \vspace*{3mm}
   \end{center}
}


% abstract, keywords, JEL classification
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\renewenvironment{abstract}{%
\begin{center}
\begin{minipage}{0.94 \textwidth}
\small
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
\end{minipage}
\end{center}%
\noindent%
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
