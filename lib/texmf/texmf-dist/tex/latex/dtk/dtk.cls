%% This is file `dtk.cls',
%%
%% LaTeX Class for ``Die TeXnische Komoedie''.
%%
%% Copyright (C) 2015-
%% Rolf Niepraschk, Herbert Voss
%%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.

\listfiles
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\RequirePackage{hyphsubst}% Trennregeln austauschen
\HyphSubstIfExists{ngerman-x-latest}{%
  \HyphSubstLet{ngerman}{ngerman-x-latest}}{}
\HyphSubstIfExists{german-x-latest}{%
  \HyphSubstLet{german}{german-x-latest}}{}

\def\DTKversion{2.04}
\def\DTKversiondate{2016/05/08}
\ProvidesClass{dtk}[\DTKversiondate\ v\DTKversion\ dtk documentclass (RN)]

\RequirePackage{ifxetex,ifluatex,ifpdf,ifvtex}
\newcommand*\DTK@engine{}

\ifluatex
  \def\DTK@engine{4}% LuaTeX
\else
  \ifxetex
    \def\DTK@engine{3}% XeTeX
  \else
    \ifpdf
      \def\DTK@engine{2}% pdfTeX
    \else
      \ifvtex
        \def\DTK@engine{1}% VTeX
      \else
        \def\DTK@engine{0}% TeX+dvips
      \fi
    \fi
  \fi
\fi

\RequirePackage{xkeyval}

\newif\ifDTK@Author@ \DTK@Author@true
\newif\ifDTK@bib@ \DTK@bib@false
\newif\ifDTKcolor \DTKcolorfalse % "@" ?
\newif\ifDTK@korr@ \DTK@korr@false

\newcommand*\journalname{Die \protect\TeX{}nische Kom\"odie}

\newcommand*\DTKyear{} \edef\DTKyear{\the\year}
\newcommand*\DTKmonth{0}
\newcommand*\DTKissue{0}
\newcommand*\DTKvolume{??}
\newcommand*\DTKdate{?/??}
\newcommand*\DTKcorrVersion{\mbox{}}
\newcommand*\DTKfullIssue{\mbox{}}
\newcommand*\DTKissn{1434-5897}

\DeclareOptionX{Ausgabe}{\def\DTKissue{#1}}
\DeclareOptionX{Jahr}{\def\DTKyear{#1}}
\DeclareOptionX{Monat}{\def\DTKmonth{#1}}
\DeclareOptionX{korr}[true]{\csname DTK@korr@#1\endcsname}
\DeclareOptionX{full}[true]{\csname @tempswa#1\endcsname
  \if@tempswa\DTK@Author@false\else\DTK@Author@true\fi}
\DeclareOptionX{color}[true]{\csname DTKcolor#1\endcsname}
\DeclareOptionX{draft}{\PassOptionsToClass{\CurrentOption}{scrbook}}

\DeclareOptionX*{\OptionNotUsed}
\ProcessOptionsX\relax

\PassOptionsToPackage{paper=a5,pagesize}{typearea}

\newdimen\DTK@tempdima
\newdimen\DTK@tempdimb
\newdimen\DTK@tempdimc

\newcommand*\DTK@tempa{}
\newcommand*\DTK@tempb{}
\newcommand*\DTK@tempc{}

\PassOptionsToPackage{hyphens}{url}
\RequirePackage{dtk-url}

\LoadClass[%
,twoside
,fontsize=10pt
,captions=oneline
,parskip=full-
,headings=small
,open=any
,pagesize
]{scrbook}

\RequirePackage{scrhack}% Andere Pakete KOMA-Script-freundlich machen

% http://www.komascript.de/release3.18
\ifstr{\KOMAScriptVersion}{2015/07/02 v3.18 KOMA-Script}{%
  \ifx\par@update\default@par@update\else
    \AtBeginDocument{\par@updaterelative}%
  \fi
}{}

\AtEndOfClass{%
  \InputIfFileExists{dtk.cfg}{}{}%
}

% *** Konstanten ***

\ifDTK@Author@\else\setcounter{errorcontextlines}{100}\fi

\textheight = 485pt %
\textwidth  = 333pt %
\oddsidemargin  = -35.89157pt %
\evensidemargin = -17.70235pt %
\marginparwidth = 1cm %
\marginparsep = 7pt %
\topmargin  = -55.66684pt %
\headheight = 17pt %
\headsep    = 17pt %
\footskip = 24pt %
\parskip   = 0.3\baselineskip
\advance\parskip by 0pt plus 2pt %
\parindent = 0pt %
\columnsep = 5pt %

\emergencystretch = 1.5em %
\clubpenalty  = 10000 %
\widowpenalty = 10000 %
\raggedbottom

\setcounter{secnumdepth}{\numexpr\partnumdepth-1\relax}
\setcounter{tocdepth}{\chapternumdepth}

\@fptop=\z@
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.9}
\renewcommand\textfraction{.1}

\RequirePackage[english,main=ngerman]{babel}

\defineshorthand{"|}{%
  \ClassError{dtk2}{%
    Shorthand `\string"|' wird nicht unterstützt! Entferne `\string"|'%
  }{}%
}

\newcommand*\DTK@FontNameMissing{%
  \ClassError{dtk2}{%
    Eines der Makros `\string\DTKrmFontName', `\string\DTKsfFontName',
    \MessageBreak
    `\string\DTKttFontName`' oder `\string\DTKmathFontName'
    \MessageBreak
    ist nicht korrekt definiert%
  }{}%
}
\newcommand*\DTKrmFontName{}   \let\DTKrmFontName=\DTK@FontNameMissing
\newcommand*\DTKsfFontName{}   \let\DTKsfFontName=\DTK@FontNameMissing
\newcommand*\DTKttFontName{}   \let\DTKttFontName=\DTK@FontNameMissing
\newcommand*\DTKmathFontName{} \let\DTKmathFontName=\DTK@FontNameMissing

\ifnum\DTK@engine < 3 %
  \input{dtk-old-engines.clo}% pdfTeX oder TeX+dvips oder VTeX
\else
  \input{dtk-new-engines.clo}% LuaTeX oder XeTeX
\fi

\RequirePackage[autostyle=true,babel=once,german=guillemets,maxlevel=3]{csquotes}%
\MakeAutoQuote{»}{«}
\defineshorthand{"`}{\openautoquote}%
\defineshorthand{"'}{\closeautoquote}%

\ifxetex\else
\RequirePackage[%
,protrusion=true
,expansion=true
,verbose=true
,final=true
,letterspace=100
,babel=true
]{microtype}
% TODO: Spezielle Angaben zu den Schriften?
\fi

\RequirePackage[%
,style=dtk
,language=auto
,sorting=nyt
,sortlocale=auto
,backend=biber
]{biblatex}

\g@addto@macro\bibsetup{\RaggedRight}

%\RequirePackage{etex} % ???
\RequirePackage{ragged2e,dtk-logos}

\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \ifx\relax#1\relax\gdef\@@title{#2}\else\gdef\@@title{#1}\fi%
}

\newcommand\DTK@maketitle[1][]{%
  \begingroup
    \dimen0=\textheight
    \advance\dimen0 by -\pagetotal
    \ifdim\dimen0<.2\textheight
      \newpage
    \fi
  \endgroup
  \def\and{\end{tabular}, \begin{tabular}[t]{@{}c@{}}}%
  \chapter[\@@title]{\@title}%
  %%%\ifx\@author\@empty\else\addsec*{\@author}\fi
  \begingroup
    \usekomafont{author}\lineskip 0.75em %
    \begin{tabular}[t]{@{}c@{}}\@author\end{tabular}\par
  \endgroup
  \@thanks
  \global\let\@thanks=\@empty
  \global\let\@title=\@empty
  \global\let\@author=\@empty
  \global\let\@thanks=\@empty
  \global\let\and\relax
}

\renewcaptionname{ngerman}{\bibname}{Literatur und Software}
\defbibheading{dtk}{\section{\bibname}}

\RequirePackage[automark,draft=false]{scrlayer-scrpage}
\pagestyle{scrheadings}
\clearpairofpagestyles
\ihead{\headmark}
\ohead{\pagemark}
\ofoot*{\normalsize\DTKcorrVersion}
\ifoot*{\journalname~~\DTKdate}
\automark[chapter]{chapter}

\RequirePackage{xcolor}

\ifDTKcolor
  \colorlet{DTK@marker}{red!30}
  \definecolor{DTK@fancy}{rgb}{.72,.525,.044}
\else
  \colorlet{DTK@marker}{black!20}
  \colorlet{DTK@fancy}{black!60}
\fi

\colorlet{DTKlstBackground}{black!5}
\colorlet{DTKlstKeys}{black}
%\colorlet{DTKlstIdentifiers}{black}
\colorlet{DTKlstComments}{black}
\colorlet{DTKlstStrings}{black}
\colorlet{DTKlstNumbers}{black}
\newcommand*\DTKlstKeywordfont{\bfseries}

\RequirePackage[final]{listings}
\RequirePackage{lstautogobble}

\@ifundefined{ifDTKrecord}{\newif\ifDTKrecord \DTKrecordfalse}{}

\newcommand*\address[3]{%
  \ClassError{dtk2}{%
    Das Makro \string\address\space existiert nicht mehr!\MessageBreak
    Nimm stattdessen \string\Author%
    \string{Vorn.\string}\string{Nachn.\string}\string{Adr.\string}}{}%
}%
\def\author#1{%
  \ClassError{dtk2}{%
    Das Makro \string\author\space existiert nicht mehr!\MessageBreak
    Nimm stattdessen \string\Author%
    \string{Vorn.\string}\string{Nachn.\string}\string{Adr.\string}}{}%
}%

% Sternform: Autor-Eintrag im Verzeichnis, aber nicht im Artikel
\newcommand*\Author{% #1=Vorname, #2=Nachname, #3=Adresse
  \@ifstar\DTK@Author\DTK@@Author
}

\newcommand\DTK@Author[3]{}%

\newcommand\DTK@Author@article[3]{%
  \begingroup
    \ifx\@author\@empty\let\x=\@empty\else\def\x{\and}\fi
    \expandafter\g@addto@macro\expandafter\@author\expandafter{\x #1 #2}%
  \endgroup
}%

\let\@author=\@empty

\ifDTK@Author@
  \input{dtk-author.clo}
\else
  \input{dtk-full.clo}
\fi

\AfterEndPreamble{% "etoolbox"
  \def\bibliography#1{%
    \ClassError{dtk2}{%
      Das Makro `\string\bibliography' wird nicht unterstützt!\MessageBreak
      Verwende stattdessen `\string\addbibresource\string{#1.bib\string}'\MessageBreak
      und `\string\printbibliography' (siehe biblatex-Dokumentation)
    }{}%
  }%
}

%%%\ifDTKrecord \expandafter \endinput \fi % lohnt es?

\addtokomafont{caption}{\RaggedRight\small}
\setkomafont{captionlabel}{\sffamily}
\setcapindent{0pt}
\setcapwidth[c]{\textwidth}
\renewcaptionname{ngerman}{\figurename}{Abb.}
\renewcaptionname{ngerman}{\tablename}{Tab.}
\def\thefigure{\@arabic\c@figure}
\def\thetable{\@arabic\c@table}
\def\theequation{\@arabic\c@equation}
\def\thelstlisting{\@arabic\c@lstlisting}

\RedeclareSectionCommand[%
  ,beforeskip=-2.4ex \@plus -1ex \@minus -.2ex % Betrag ist von Bedeutung!
  ,afterskip=0.8ex \@plus .1ex \@minus .1ex %
]{section}

\RedeclareSectionCommand[%
  ,afterskip=0.8ex \@plus .1ex %
]{subsection}

\RedeclareSectionCommand[%
  ,style=section
  ,indent=\z@
  ,beforeskip=-2\baselineskip \@plus -.2\baselineskip \@minus -.2\baselineskip
  ,afterskip=1\baselineskip \@plus .1\baselineskip \@minus .1\baselineskip
]{chapter}

\setkomafont{disposition}{\normalfont\sffamily}
\setkomafont{part}{\usekomafont{disposition}\huge}
\setkomafont{chapter}{\usekomafont{disposition}\Large}
\setkomafont{section}{\usekomafont{disposition}\large}
\setkomafont{pagenumber}{\normalfont\sffamily}
\setkomafont{pagehead}{\sffamily\slshape}% \itshape?
\setkomafont{pagefoot}{\footnotesize\sffamily\slshape}% \itshape?
\setkomafont{author}{\usekomafont{section}}

%\addtokomafont{footnote}{\RaggedRight}
\deffootnote[1.2em]{1.2em}{1.2em}{\textsuperscript{\thefootnotemark}\,}
\newcommand*\DTK@footnote{}
\let\DTK@footnote=\footnote
\newcommand*\DTK@@footnote[2][]{%
  \edef\DTK@tempa{\ifx\relax#1\relax\else[#1]\fi}%
  \expandafter\DTK@footnote\DTK@tempa{\RaggedRight #2}%
}
\def\footnote{%
  \@ifstar\DTK@@footnote\DTK@footnote
}

\RequirePackage{enumitem}
\setlist{leftmargin=*,nosep}
\setlist[1]{labelindent=1em}
\iffalse
\setlist[itemize,1]{label=\raisebox{-.1ex}{\Large\textbullet}}
\setlist[itemize,2]{label=\raisebox{-.1ex}{\Large$\m@th\circ$}}
\setlist[itemize,3]{label=\raisebox{-.7ex}{\large\textasteriskcentered}}
\setlist[itemize,4]{label=\raisebox{.4ex}{\tiny$\m@th\triangleright$}}
\fi

% Listings
\newcommand*\DTKlstfont{\small\ttfamily}

% siehe ggf.: https://github.com/jez/latex-solarized

\lstdefinestyle{DTKlstSimple0}{%
,basicstyle=\DTKlstfont
,numbers=none
,backgroundcolor={}
,tabsize=2
,frame=none
}

\lstdefinestyle{DTKlstVerbatim}{
,style=DTKlstSimple0
,aboveskip=\smallskipamount
,belowskip=0pt plus .25pt minus .25pt %
}

\lstdefinestyle{DTKlstSimple1}{%
,style=DTKlstSimple0
,identifierstyle=\DTKlstfont
,stringstyle=\DTKlstfont
,commentstyle=\DTKlstfont
,basewidth=0.55em
,keepspaces
,autogobble=false
,backgroundcolor=\color{DTKlstBackground}
,numbers=none
,frame=single
,framesep=\fboxsep
,aboveskip=\medskipamount
,belowskip=1pt plus .5pt minus .5pt %
,xleftmargin=\fboxsep
,xrightmargin=\fboxsep
}

\newcommand*\DTK@lst@colorbox[2]{%
  \fboxsep=.3em %
  \settowidth\DTK@tempdima{#2}\settoheight\DTK@tempdimb{#2}%
  \makebox[\DTK@tempdima][c]{\colorbox{#1}{%
    \raisebox{0pt}[\DTK@tempdimb][\z@]{#2}}}%
}

\lstdefinestyle{DTKlstBase}{%
,style=DTKlstSimple1
%,identifierstyle=\color{DTKlstIdentifiers}
,keywordstyle=\DTKlstKeywordfont
,stringstyle=\itshape\color{DTKlstStrings}
,commentstyle=\itshape\color{DTKlstComments}
,columns=fullflexible
%,extendedchars=true
,showspaces=false
,showstringspaces=false
,breaklines=true
,breakindent=0.5em
,breakautoindent=true
,breakatwhitespace=false  % ???
,captionpos=t
,emphstyle=\DTK@lst@colorbox{DTKlstBackground!70!-DTKlstBackground}%
%,prebreak=
,postbreak=\mbox{$\hookrightarrow$}
,autogobble=true
}

\lstdefinestyle{number}{%  TODO: Evtl. doch besser Zeilennummern ganz ausrücken?
,style=DTKlstBase
,numbers=left
,numberstyle=\tiny\ttfamily
,numbersep=1.3em
,xleftmargin=1.5em
}

\lstdefinestyle{noNumber}{%
,style=DTKlstBase
,numbers=none
,xleftmargin=\fboxsep % ???
}

\lstset{style=noNumber}

% noHilit, latex ???

\let\verbatim=\relax
\lstnewenvironment{verbatim}
{\lstset{style=DTKlstVerbatim,language={}}}{}

\newlength\fullwidth
\setlength\fullwidth{\dimexpr\textwidth+\marginparwidth+\marginparsep\relax}
\newenvironment{Figure}[2][\fullwidth]
  {\figure[htb!]\setlength\columnsep{1.5em}%
   \captionbeside{#2}[o][#1][0pt]*}%
  {\endcaptionbeside\endfigure}
\newenvironment{Table}[2][\fullwidth]
  {\table[htb!]\setlength\columnsep{1.5em}%
   \begincaptionbeside{#2}[o][#1][0pt]*}%
  {\endcaptionbeside\endtable}

\newenvironment{abstract}
  {\quote\small}{\endquote\medskip\par}

\providecommand*\Macro[1]{\texttt{\textbackslash#1}}
\providecommand*\Code[1]{\texttt{#1}}
\let\Command\texttt
\let\Environment\texttt
\def\biblatex{\texttt{biblatex}\xspace}
\def\tex4ht{\hologo{TeX4ht}}
\let\Paket\texttt
\let\Package\texttt
\let\Programm\texttt
\let\Program\texttt
\let\Env\texttt
\let\Class\texttt

\endinput

