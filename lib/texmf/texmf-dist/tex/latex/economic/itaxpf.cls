%%% LaTeX class for manuscripts submitted to the
%%% Journal "International Tax and Public Finance" (itaxpf)
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the Formatting Instructions of the journal
%%% "International Tax and Public Finance" in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, endfloat, endnotes, geometry,
%%% ifthen, lmodern, natbib, setspace, url
%%%
%%% The corresponding BibTeX style file "itaxpf.bst" should be used
%%% for the bibliography: \bibliographystyle{itaxpf}
%%%
%%% This class provides 2 options:
%%% titlepage = include a title page (with command "\maketitle")
%%% noendfloat = do not move "floats" (tables and figures) to the end
%%%
%%% This document class provides 4 new commands:
%%% \keywords can be used to show keywors below the abstract
%%% \jelclass can be used to show JEL classifications below the abstract
%%% \affiliation can be used spefify the affiliation(s) of the author(s)
%%%    (only shown if option "titlepage" is used)
%%% \address can be used spefify the address of the corresponding author
%%%    (only shown if option "titlepage" is used)
%%%
%%% If you use footnotes, add following line before the reference section:
%%%    \listofendnotes
%%%
%%% Website of the journal "International Tax and Public Finance":
%%% http://www.springerlink.com/link.asp?id=102915


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itaxpf}[2009/11/18 LaTeX class for the Journal
   'International Tax and Public Finance']

\RequirePackage{ifthen}

% option to place floats not at the end
\newcounter{UseEndfloat}
\setcounter{UseEndfloat}{1}
\DeclareOption{noendfloat}{\setcounter{UseEndfloat}{0}}

% option to include a title page
\newcounter{IncludeTitlePage}
\setcounter{IncludeTitlePage}{0}
\DeclareOption{titlepage}{\setcounter{IncludeTitlePage}{1}}

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
\geometry{letterpaper, tmargin=1.0in, bmargin=1.0in, lmargin=1.0in,
  rmargin=1.0in, headheight=0in, headsep=0in, footskip=0.5in }

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
\setkomafont{section}{\normalfont \large \bfseries}
\setkomafont{subsection}{\normalfont}
\setkomafont{subsection}{\normalfont \itshape}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\AtBeginDocument{\renewcommand{\refname}{\clearpage References}}
\setlength{\bibsep}{0pt}

%% use endnotes in place of footnotes
\RequirePackage{endnotes}
\renewcommand{\notesname}{\clearpage Notes}
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
% \setcapindent*{0pt}
\setkomafont{captionlabel}{\centering \bfseries}
\setkomafont{caption}{\centering}
\renewcommand{\captionformat}{~ }

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
\newcommand{\address}[1]{\newcommand{\@address}{#1}}
\renewcommand{\and}{$\cdot$ }
\renewcommand{\maketitle}{
   \ifthenelse{\equal{\theIncludeTitlePage}{1}}{
      \thispagestyle{empty}
      \vspace*{25mm}
   }{}
   \begin{center}
   \begin{Large}
   \begin{spacing}{1.25}
   \textbf{\@title}
   \end{spacing}
   \end{Large}
   \vspace*{5mm}
   \ifthenelse{\equal{\theIncludeTitlePage}{1}}{
      \vspace*{7mm}
      \@author\\
      \ifthenelse{ \isundefined\@affiliation }{}{
         \vspace*{5mm}
         \textit{\@affiliation}\\
      }
      \ifthenelse{ \isundefined\@address }{}{
         \vspace*{10mm}
         \begin{spacing}{1}
         \@address\\
         \end{spacing}
      }
      \vspace*{3mm}
   }{}
   \end{center}
}


% abstract, keywords, JEL classification
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\renewenvironment{abstract}{%
\noindent
\textbf{Abstract~}
}{%
\ifthenelse{ \isundefined\@keywords }{
\ClassWarningNoLine{ajae}{No keywords specified.
   Please use the command \protect\keywords}
}{

\medskip \noindent
\textbf{Key words~} \@keywords
}
\ifthenelse{ \isundefined\@jelclass }{
\ClassWarningNoLine{ajae}{No JEL classification specified.
   Please use the command \protect\jelclass}
}{

\medskip \noindent
\textbf{JEL classification~} \@jelclass
}
\clearpage
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
