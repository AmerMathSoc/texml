%%% LaTeX class for manuscripts submitted to the
%%% Journal of Rural Studies (JRurStud)
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the JRurStud formatting instructions in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, endfloat, endnotes, geometry
%%% ifthen, lmodern, natbib, setspace, stringstrings, textcomp, url
%%%
%%% The class provides the following options:
%%% noendfloat    - don't move floats to the end of the paper
%%% noendnotes    - don't use endnotes (use footnotes)
%%% titlepage     - create "first" title page with title, authors' names,
%%%                    affiliations, and address of corresponding author
%%% nosecondtitle - do not create "second" title page with (repeated) title
%%%
%%% This class selects the BibTeX style "elsart-harv.bst".
%%% (see http://www.elsevier.com/wps/find/authorsview.authors/elsart)
%%%
%%% This class provides 4 new commands:
%%% \affiliation     specify affiliation(s) of the authors
%%% \cauthormark     mark the corresponding author (by an asterisk)
%%% \cauthoraddress  specify address of the corresponding author
%%% \keywords        specify some keywords (separated by semicolons)
%%%
%%% The Journal of Rural Studies requires that you use single quotes
%%% you could do this with the ``csquotes'' package:
%%% \usepackage{csquotes}
%%% \MakeInnerQuote{<yourQuoteCharacter>}
%%%
%%% The manuscript submitted to JRurStud shouldn't include any figures.
%%% If your paper contains any figures and you haven't removed/disabled
%%% them in the LaTeX source, you can remove the pages showing these figures
%%% from the PDF file. If you want to remove, say, pages 18 and 19 with
%%% "pdftk" (PDF toolkit), you could execute
%%%    pdftk original.pdf cat 1-17 20-end output manuscript.pdf
%%% While this needs some extra effort, it has the advantage (compared to
%%% removing the figures in the LaTeX source) that references to figures
%%% with \ref{} still work.
%%%
%%% Website of the "Journal of Rural Studies":
%%% http://www.elsevier.com/locate/jrurstud/
%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jrurstud}[2009/11/18 LaTeX class for the Journal of Rural Studies]

% package for convenient if-then-else statements
\RequirePackage{ifthen}

% option to NOT place floats at the end
\newif\if@useendfloat
\@useendfloattrue
\DeclareOption{noendfloat}{\@useendfloatfalse}

% option to NOT use endnotes (but footnotes)
\newif\if@useendnotes
\@useendnotestrue
\DeclareOption{noendnotes}{\@useendnotesfalse}

% option to create a "first" title page
\newif\if@maketitlepage
\@maketitlepagefalse
\DeclareOption{titlepage}{\@maketitlepagetrue}

% option not to create a "second" title page
\newif\if@makesecondtitle
\@makesecondtitletrue
\DeclareOption{nosecondtitle}{\@makesecondtitlefalse}

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
\setlength{\intextsep}{5pt}

% font family: latin modern
\RequirePackage{lmodern}

% section headers
\setkomafont{section}{\bfseries}
\setkomafont{subsection}{\normalfont\itshape}
\setkomafont{subsubsection}{\normalfont}

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
\bibliographystyle{elsart-harv}

% captions of figures and tables
\setcapwidth[l]{\textwidth}
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalsize\normalfont\bfseries}
\setkomafont{caption}{\normalsize\normalfont\bfseries}
\renewcommand{\captionformat}{.\ }

% titlepage without author and date
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\newcommand{\cauthoraddress}[1]{\newcommand{\@cauthoraddress}{#1}}
\newcommand{\cauthormark}{\textsuperscript{*}}
\renewcommand{\maketitle}{
   \if@maketitlepage
      \thispagestyle{empty}
      \vspace*{12mm}
      \begin{center}
      \begin{spacing}{1.5}
      \LARGE{\textbf{\@title}}%
      \end{spacing}
      \ifthenelse{ \isundefined\@author }{
         \ClassWarning{apecon}{No author(s) specified.
            Please specify with command \protect\author}
      }{
         \begin{large}
         \textbf{\@author}\\
         \end{large}
         \vspace*{3mm}
      }
      \begin{spacing}{1.1}
      \ifthenelse{ \isundefined\@affiliation }{
         \ClassWarning{apecon}{No affiliation(s) specified.
            Please specify with command \protect\affiliation}
      }{
         \textit{\@affiliation}\\
      }
      \vspace*{2cm}
      \textbf{\cauthormark{}~Corresponding author}.\\
      \ifthenelse{ \isundefined\@cauthoraddress }{
         \ClassWarningNoLine{jrurstud}{No address of the corresponding authors
            is specified. Please specify with command \protect\cauthoraddress}
      }{
         \@cauthoraddress\\
      }
      \end{spacing}
      \vspace*{5mm}
      \end{center}
      \clearpage
   \fi
   \if@makesecondtitle
      \begin{center}
      \begin{spacing}{1.5}
      \LARGE{\textbf{\@title}}%
      \end{spacing}
      \end{center}
   \fi
}

% abstract, keywords, JEL classification
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\renewenvironment{abstract}{%
   \hrule
   \vspace*{5mm}
   \begin{spacing}{1.5}
   \noindent
   \textbf{Abstract}\\
   \indent
}{%
   \ifthenelse{ \isundefined\@keywords }{
   \ClassWarningNoLine{erae}{No keywords specified.
      Please use the command \protect\keywords}
   }{
   \vspace*{5mm}\\ \noindent
   \textit{Keywords:} \@keywords%
   }
   \vspace*{5mm}
   \end{spacing}
   \hrule
   \clearpage
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
\if@useendfloat
   \RequirePackage[noheads,tablesfirst]{endfloat}
   \AtBeginDelayedFloats{%
      \pagestyle{empty}
   }
   \RequirePackage{stringstrings}
   \renewcommand{\@makecaption}[2]{%
      \testmatchingchar{#1}{1}{T}
      \ifmatchingchar
         \hfill \thetable\\
         \vspace*{3cm}
      \fi
   }
   \renewcommand*{\l@figure}[2]{%
      \setlength\@tempdima{2.3em}%
      \noindent\hspace*{1.5em}#1\hfil\newline
   }
   \let\l@table\l@figure
\fi

%% use endnotes in place of footnotes
\if@useendnotes
   \RequirePackage{endnotes}
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
   \AtEndDocument{%
      \IfFileExists{\jobname.ent}{%
         \clearpage
         \pagestyle{empty}
         \listofendnotes
      }{}
   }
\fi

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
