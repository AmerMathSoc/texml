%%% LaTeX class for manuscripts submitted to the
%%% Journal "World Development" (worlddev)
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (18 November 2009)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the Formatting Instructions of the "World Development" in every detail.
%%% Please report any problems at
%%%    http://sourceforge.net/projects/economtex/
%%% Further information is available at
%%%    http://economtex.wiki.sourceforge.net/
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, endfloat, endnotes, geometry,
%%% ifthen, lmodern, natbib, setspace, textcomp, titlesec, url
%%%
%%% The class provides following options:
%%% noendnotes - don't use endnotes (use footnotes)
%%% noendfloat - don't move floats to the end of the paper
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
%%% "World Development" requires that you use double quotes
%%% you could do this with the ``csquotes'' package:
%%% \usepackage{csquotes}
%%% \MakeOuterQuote{<yourQuoteCharacter>}
%%%
%%% Website of the journal "World Development":
%%% http://www.elsevier.com/wps/locate/worlddev/


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{worlddev}[2009/11/18 LaTeX class for the Journal 'World Development']

\RequirePackage{ifthen}

% option NOT to place floats at the end
\newcounter{UseEndfloat}
\setcounter{UseEndfloat}{1}
\DeclareOption{noendfloat}{\setcounter{UseEndfloat}{0}}

% option to use footnotes in place of endnotes
\newcounter{UseEndnotes}
\setcounter{UseEndnotes}{1}
\DeclareOption{noendnotes}{\setcounter{UseEndnotes}{0}}

% option to show the authors' names
\newcounter{ShowAuthor}
\setcounter{ShowAuthor}{0}
\DeclareOption{author}{\setcounter{ShowAuthor}{1}}

% option to print the date
\newcounter{ShowDate}
\setcounter{ShowDate}{0}
\DeclareOption{date}{\setcounter{ShowDate}{1}}

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

% font family: Latin Modern
\RequirePackage{textcomp}
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

%% formatting section and subsection headers
\RequirePackage{titlesec}
% format of section headers
\newcommand{\secformat}[1]{\MakeUppercase{#1}}
\titleformat{\section}[block]
   {\normalfont\filcenter}
   {\arabic{section}. }
   {0pt}
   {\secformat}
% spacing around section headers
\titlespacing*{\section}{0pt}{3ex}{0.3ex}
% format of subsection headers
\titleformat{\subsection}[block]
   {\normalsize\filcenter}
   {(\alph{subsection}) }
   {0pt}
   {\textit}
% spacing around subsection headers
\titlespacing*{\subsection}{0pt}{2ex}{0.15ex}

%% warning if subsubsection headers are present
\renewcommand{\subsubsection}[1]{%
\ClassWarning{worlddev}{subsubsections are ignored}%
}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\setlength{\bibsep}{0pt}

%% use endnotes in place of footnotes
\ifthenelse{\equal{\theUseEndnotes}{1}}{
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
}{}

% captions of figures and tables
\setcapwidth[c]{\textwidth}
\setkomafont{caption}{\centering \itshape}
\renewcommand{\captionformat}{. }

% move floats to the end of the paper
\ifthenelse{\equal{\theUseEndfloat}{1}}{
   \RequirePackage[nolists,tablesfirst]{endfloat}
}{}

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
   \ifthenelse{\equal{\theShowAuthor}{1}}{
      \MakeUppercase{\@author}\\
      \ifthenelse{ \isundefined\@affiliation }{}{
         \vspace*{3mm}
         \textit{\@affiliation}\\
      }
   }{}
   \vspace*{3mm}
   \ifthenelse{\equal{\theShowDate}{1}}{
      \@date\\
   }{}
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
\textbf{Summary.}\;---%
}{%
\ifthenelse{ \isundefined\@keywords }{
\ClassWarningNoLine{worlddev}{No keywords specified.
   Please use the command \protect\keywords}
}{

\medskip \noindent
\textit{Key words} --- \@keywords
}
\ifthenelse{ \isundefined\@jelclass }{
}{

\medskip \noindent
\textit{JEL classification} --- \@jelclass
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
