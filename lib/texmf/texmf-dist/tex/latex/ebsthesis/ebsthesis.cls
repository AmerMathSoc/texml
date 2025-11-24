%%
%% This is file `ebsthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ebsthesis.dtx  (with options: `ebsthesis')
%% 
%% The ebsthesis document class
%% Copyright (c) 2006 Philipp N. Baecker. All right reserved.
%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
\NeedsTeXFormat{LaTeX2e}[2003/12/01]
\ProvidesClass{ebsthesis}%
              [2006/12/31 v1.0 EBS Thesis Class (PNB)]
\newif\if@gabler
\DeclareOption{gabler}{\@gablertrue}
\DeclareOption{grundregeln}{\@gablerfalse}
\newif\if@singlespacing
\DeclareOption{singlespacing}{\@singlespacingtrue}
\DeclareOption{onehalfspacing}{\@singlespacingfalse}
\newif\if@headrules
\DeclareOption{headrules}{\@headrulestrue}
\DeclareOption{noheadrules}{\@headrulesfalse}
\newif\if@tools
\DeclareOption{tools}{\@toolstrue}
\DeclareOption{notools}{\@toolsfalse}
\newif\if@fancyfoot
\DeclareOption{fancyfoot}{\@fancyfoottrue}
\DeclareOption{nofancyfoot}{\@fancyfootfalse}
\newif\if@indentcaptions
\DeclareOption{indentcaptions}{\@indentcaptionstrue}
\DeclareOption{noindentcaptions}{\@indentcaptionsfalse}
\newif\if@mathematica
\DeclareOption{mathematica}{\@mathematicatrue}
\DeclareOption{nomathematica}{\@mathematicafalse}
\DeclareOption{8pt}{\OptionNotUsed}
\DeclareOption{9pt}{\OptionNotUsed}
\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{14pt}{\OptionNotUsed}
\DeclareOption{17pt}{\OptionNotUsed}
\DeclareOption{20pt}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extbook}}
\ExecuteOptions{%
  grundregeln,%
  onehalfspacing,%
  noheadrules,%
  notools,%
  nofancyfoot,%
  noindentcaptions,%
  nomathematica%
}
\ProcessOptions\relax
\if@gabler
  \PassOptionsToClass{a5paper,9pt,twoside}{extbook}
\else
  \PassOptionsToClass{a4paper,12pt,oneside}{extbook}
\fi
\LoadClass{extbook}[1999/01/07]
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\figurename}{Fig.}
\renewcommand{\tablename}{Table}
\newcommand{\abkuerzungsverzeichnisname}{List of Abbreviations}
\newcommand{\appendicesname}{Appendices}
\newcommand{\geleitwortname}{Foreword}
\newcommand{\inhaltsuebersichtname}{Summary of Contents}
\newcommand{\listappendixname}{List of Appendices}
\newcommand{\symbolverzeichnisname}{List of Symbols}
\newcommand{\vorwortname}{Preface}
\AtBeginDocument{%
  \@ifpackageloaded{babel}{%
    \addto{\captionsenglish}{%
      \renewcommand{\contentsname}{Table of Contents}%
      \renewcommand{\figurename}{Fig.}%
      \renewcommand{\tablename}{Table}%
    }%
    \addto{\extrasenglish}{%
      \renewcommand{\abkuerzungsverzeichnisname}{List of Abbreviations}%
      \renewcommand{\appendicesname}{Appendices}%
      \renewcommand{\geleitwortname}{Foreword}%
      \renewcommand{\inhaltsuebersichtname}{Summary of Contents}%
      \renewcommand{\listappendixname}{List of Appendices}%
      \renewcommand{\symbolverzeichnisname}{List of Symbols}%
      \renewcommand{\vorwortname}{Preface}%
    }%
    \addto{\captionsngerman}{%
      \renewcommand{\figurename}{Abb.}%
      \renewcommand{\tablename}{Tab.}%
    }%
    \addto{\extrasngerman}{%
      \renewcommand{\abkuerzungsverzeichnisname}{Abk\"urzungsverzeichnis}%
      \renewcommand{\appendicesname}{Anhang}%
      \renewcommand{\geleitwortname}{Geleitwort}%
      \renewcommand{\inhaltsuebersichtname}{Inhalts\"ubersicht}%
      \renewcommand{\listappendixname}{Verzeichnis des Anhangs}%
      \renewcommand{\symbolverzeichnisname}{Symbolverzeichnis}%
      \renewcommand{\vorwortname}{Vorwort}%
    }%
  }{\relax}%
}
\RequirePackage{geometry}[2002/07/08]
\if@gabler
  \geometry{%
    totalwidth=11.5cm,%
    totalheight=18cm,%
    includeheadfoot,%
    centering,%
    mag=1414
  }
\else
  \geometry{%
    left=4cm,%
    right=2cm,%
    top=3cm,%
    bottom=2cm,%
    headsep=1cm,%
    footnotesep=\baselineskip
  }
\fi
\RequirePackage[nodisplayskipstretch]{setspace}[2000/12/01]
\if@gabler
  \renewcommand{\singlespacing}{\setstretch{1.1}%
    \vskip \baselineskip}
  \renewcommand{\onehalfspacing}{\setstretch{1.3}%
    \vskip \baselineskip}
  \newcommand*{\ebsindent}{\relax}
\else
  \renewcommand{\singlespacing}{\setstretch{1.0}%
    \vskip \baselineskip}
  \renewcommand{\onehalfspacing}{\setstretch{1.5}%
    \vskip \baselineskip}
  \newcommand*{\ebsindent}{\addvspace{\medskipamount}\noindent}
\fi
\if@singlespacing
  \singlespacing
\else
  \onehalfspacing
\fi
\RequirePackage{rotfloat}[2004/01/04]
\RequirePackage{caption}[2004/07/16]
\DeclareCaptionLabelSeparator{period-enspace}{.\enspace}
\DeclareCaptionLabelFormat{tight}{#1\,#2}
\captionsetup{%
  font=small,
  labelfont=bf,%
  labelsep=period-enspace%
}
\captionsetup[figure]{%
  labelformat=tight%
}
\captionsetup[table]{%
  position=top%
}
\if@indentcaptions
  \captionsetup{%
    format=hang%
  }
\fi
\RequirePackage{ragged2e}[2003/03/25]
\RequirePackage[ragged,%
                bottom,%
                hang,%
                splitrule,%
                stable,%
                multiple]{footmisc}[2004/05/02]
\renewcommand{\mpfootnoterule}{\relax}
\RequirePackage{remreset}
\@removefromreset{footnote}{chapter}
\if@fancyfoot
  \long\def\@makefntext#1{%
    \bgroup
      \setbox\@tempboxa\hbox{%
      \ifdim\footnotemargin>0pt
        \hb@xt@\footnotemargin{\rlap\normalfont%
          \@thefnmark.\hss}%
      \else
        \rlap\normalfont\@thefnmark.
      \fi
    }%
    \leftmargin\wd\@tempboxa
    \rightmargin\z@
    \linewidth \columnwidth
    \advance \linewidth -\leftmargin
    \parshape \@ne \leftmargin \linewidth
    \footnotesize
    \parskip\hangfootparskip\relax
    \parindent\hangfootparindent\relax
    \@setpar{{\@@par}}%
    \leavevmode
    \llap{\box\@tempboxa}%
    \footnotelayout#1%
    \par\egroup%
  }
\fi
\RequirePackage[nobottomtitles*,
                newparttoc,
                clearempty,
                toctitles,
                newlinetospace,
                pagestyles]{titlesec}[2005/01/22]
\RequirePackage{calc}[1998/07/07]
\titleformat{\part}[display]{%
  \thispagestyle{empty}\normalfont\huge\mdseries\singlespacing\filright}{%
  \bfseries\partname~\thepart}{0pt}{}
\titlespacing*{\part}{%
  0pt}{-\headheight-\headsep}{1.15ex plus .1ex}
\titleformat{\chapter}{%
  \normalfont\LARGE\bfseries\singlespacing\filright}{%
  \thechapter}{1em}{}
\titlespacing*{\chapter}{%
  0pt}{-\headheight-\headsep}{1.15ex plus .1ex}
\titleformat{\section}{%
  \normalfont\Large\bfseries\singlespacing\filright}{%
  \thesection}{1em}{}
\titlespacing*{\section}{%
  0pt}{1.75ex plus .5ex minus .1ex}{1.15ex plus .1ex}
\titleformat{\subsection}{%
  \normalfont\large\bfseries\singlespacing\filright}{%
  \thesubsection}{1em}{}
\titlespacing*{\subsection}{%
  0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
\titleformat{\subsubsection}{%
  \normalfont\normalsize\bfseries\filright}{%
  \thesubsubsection}{1em}{}
\titlespacing*{\subsubsection}{%
  0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
\titleformat{\paragraph}{%
  \normalfont\normalsize\mdseries\itshape\filright}{%
  \upshape\theparagraph}{1em}{}
\titlespacing*{\paragraph}{%
  0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
\titleformat{\subparagraph}{%
  \normalfont\normalsize\mdseries\itshape\filright}{%
  \upshape\thesubparagraph.}{1em}{}
\titlespacing*{\subparagraph}{%
  0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
\renewcommand{\thesubparagraph}{\alph{subparagraph}}
\titleclass{\subsubparagraph}{straight}[\subparagraph]
\newcounter{subsubparagraph}[subparagraph]
\renewcommand{\thesubsubparagraph}{\roman{subsubparagraph}}
\titleformat{\subsubparagraph}{%
  \normalfont\normalsize\mdseries\filright}{%
  \thesubsubparagraph.}{1em}{}
\titlespacing*{\subsubparagraph}{%
  0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
\setcounter{secnumdepth}{6}
\if@headrules
  \newlength{\headrulewidth}
  \setlength{\headrulewidth}{0.05em}
\fi
\renewpagestyle{plain}[\small]{%
  \if@gabler
    \sethead[][][]%
            {}{}{}
    \setfoot[\usepage][][]%
            {}{}{\usepage}
  \else
    \if@headrules
      \headrule
      \setheadrule{\headrulewidth}
    \fi
    \sethead[][--\,\usepage\,--][]%
            {}{--\,\usepage\,--}{}
    \setfoot[][][]%
            {}{}{}
  \fi%
}
\newpagestyle{ebs}[\small]{%
  \if@headrules
    \headrule
    \setheadrule{\headrulewidth}
  \fi
  \if@gabler
    \sethead[\usepage][][\ifthechapter{\thechapter\quad}{}\textit{\chaptertitle}]%
            {\ifthesection{\thesection\quad}{}\textit{\sectiontitle}}{}{\usepage}
  \else
    \sethead[][--\,\usepage\,--][]%
            {}{--\,\usepage\,--}{}
  \fi
  \setfoot[][][]%
          {}{}{}%
}
\pagestyle{ebs}
\RequirePackage{titletoc}[2005/01/22]
\titlecontents{part}[0pt]{%
  \addvspace{10pt}\filright}{%
  \textbf{\partname\space\textsc{\MakeLowercase{\thecontentslabel}}:\enspace}}{}{}
\newlength{\digitlength}
\settowidth{\digitlength}{9.}
\newlength{\pnumwidth@roman}
\settowidth{\pnumwidth@roman}{XVIII}
\newlength{\pnumwidth@arabic}
\settowidth{\pnumwidth@arabic}{999}
\addtolength{\pnumwidth@arabic}{0.25em}
\contentsmargin{\pnumwidth@arabic}
\titlecontents{chapter}[2\digitlength]{\addvspace{5pt}\bfseries\contentsmargin{\pnumwidth@roman}}{\contentslabel{2\digitlength}}{\hspace*{-2\digitlength}}{\titlerule*[0.75em]{}\contentspage}
\dottedcontents{section}[5\digitlength]{}{3\digitlength}{0.75em}
\dottedcontents{subsection}[9\digitlength]{}{4\digitlength}{0.75em}
\dottedcontents{subsubsection}[14\digitlength]{}{5\digitlength}{0.75em}
\dottedcontents{paragraph}[20\digitlength]{}{6\digitlength}{0.75em}
\dottedcontents{subparagraph}[27\digitlength]{}{7\digitlength}{0.75em}
\dottedcontents{subsubparagraph}[35\digitlength]{}{8\digitlength}{0.75em}
\newcommand{\listofappendices}{%
  \section*{\listappendixname\sectionmark{\listappendixname}}
  \printcontents[appendix]{1}{1}{\setcounter{tocdepth}{4}}
  \titlecontents{section}[2\digitlength]{\addvspace{5pt}\bfseries\contentsmargin{\pnumwidth@roman}}{\contentslabel{2\digitlength}}{\hspace*{-2\digitlength}}{\titlerule*[0.75em]{}\contentspage}
  \dottedcontents{subsection}[5\digitlength]{}{3\digitlength}{0.75em}
  \dottedcontents{subsubsection}[9\digitlength]{}{4\digitlength}{0.75em}
  \dottedcontents{paragraph}[14\digitlength]{}{5\digitlength}{0.75em}
  \dottedcontents{subparagraph}[20\digitlength]{}{6\digitlength}{0.75em}
  \dottedcontents{subsubparagraph}[27\digitlength]{}{7\digitlength}{0.75em}
}
\renewcommand{\appendix}{%
  \ClassWarningNoLine{ebsthesis}{%
    Use \noexpand\startappendices and \noexpand\stopappendices instead of \noexpand\appendix}
}
\newcommand{\startappendices}{%
  \ttl@toclabelfalse
  \ttl@setifthe{chapter}
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \renewcommand{\chaptername}{\appendixname}
  \renewcommand{\thesection}{\Alph{section}}
  \numberwithin{equation}{section}
  \numberwithin{figure}{section}
  \numberwithin{table}{section}
  \numberwithin{thm}{section}
  \numberwithin{cor}{section}
  \numberwithin{defn}{section}
  \numberwithin{conj}{section}
  \numberwithin{exmp}{section}
  \chapter*{\appendicesname\chaptermark{\appendicesname}}
  \addcontentsline{toc}{chapter}{\appendicesname}
  \titleformat{\section}{%
    \normalfont\large\bfseries}{%
    \chaptertitlename~\thesection}{1em}{}
  \titlespacing*{\section}{%
    0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
  \titleformat{\subsection}{%
    \normalfont\normalsize\bfseries}{%
    \thesubsection}{1em}{}
  \titlespacing*{\subsection}{%
    0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
  \titleformat{\subsubsection}{%
    \normalfont\normalsize\mdseries\itshape}{%
    \upshape\thesubsubsection}{1em}{}
  \titlespacing*{\subsubsection}{%
    0pt}{1.625ex plus .5ex minus .1ex}{.75ex plus .1ex}
  \stopcontents[main]%
  \resumecontents[appendix]%
  \stoplist[main]{lof}%
  \resumelist[appendix]{lof}%
  \stoplist[main]{lot}%
  \resumelist[appendix]{lot}%
}
\newcommand{\stopappendices}{%
  \stopcontents[appendix]%
  \resumecontents[main]%
}
\newcommand{\thegrad}{Doctor rerum politicarum}
\newcommand*{\grad}[1]{%
  \renewcommand{\thegrad}{#1}}
\newcommand{\thetitel}{%
  \ClassWarningNoLine{ebsthesis}{%
    Kein \noexpand\titel angegeben}}
\newcommand*{\titel}[1]{%
  \renewcommand{\thetitel}{#1}}
\newcommand{\theuntertitel}{}
\newcommand*{\untertitel}[1]{%
  \renewcommand{\theuntertitel}{#1}}
\newcommand{\thefachbereich}{Betriebswirtschaftslehre}
\newcommand*{\fachbereich}[1]{%
  \renewcommand{\thefachbereich}{#1}}
\newcommand{\thehochschule}{%
  European Business School}
\newcommand*{\hochschule}[1]{%
  \renewcommand{\thehochschule}{#1}}
\newcommand{\thekandidat}{%
  \ClassWarningNoLine{ebsthesis}{%
    Kein \noexpand\kandidat angegeben}}
\newcommand*{\kandidat}[1]{%
  \renewcommand{\thekandidat}{#1}}
\renewcommand*{\author}[1]{%
  \renewcommand{\thekandidat}{#1}}
\newcommand{\thegeburtsort}{%
  \ClassWarningNoLine{ebsthesis}{%
    Kein \noexpand\geburtsort angegeben}}
\newcommand*{\geburtsort}[1]{%
  \renewcommand{\thegeburtsort}{#1}}
\newcommand{\thereferenten}{%
  \ClassWarningNoLine{ebsthesis}{%
    Keine \noexpand\referenten angegeben}}
\newcommand*{\referenten}[1]{%
  \renewcommand{\thereferenten}{#1}}
\newcommand{\theeinreichungstermin}{%
  \ClassWarningNoLine{ebsthesis}{%
    Kein \noexpand\einreichungstermin angegeben}}
\newcommand*{\einreichungstermin}[1]{%
  \renewcommand{\theeinreichungstermin}{#1}}
\newcommand{\thepruefungstermin}{%
  \ClassWarningNoLine{ebsthesis}{%
    Kein \noexpand\pruefungstermin angegeben}}
\newcommand*{\pruefungstermin}[1]{%
  \renewcommand{\thepruefungstermin}{#1}}
\newcommand{\thehochschulsignatur}{1540}
\newcommand*{\hochschulsignatur}[1]{%
  \renewcommand{\thehochschulsignatur}{#1}}
\RequirePackage{array}[2003/12/17]
\renewcommand{\maketitle}{%
  \renewcommand{\and}{\tabularnewline &}
  \begin{titlepage}
    \begin{singlespacing}
      \begin{center}
        {\Large\bfseries Dissertation}\\
        zur Erlangung des akademischen Grades\\
        \thegrad\par
        \vspace{\stretch{1000}}
        {\LARGE\bfseries\thetitel\par\medskip\Large\mdseries\theuntertitel\par}
        \vspace{\stretch{1618}}
        \begin{tabular}{@{}>{\bfseries}ll@{}}
          Fachbereich:&\thefachbereich\tabularnewline
          Hochschule:&\thehochschule\tabularnewline
          Hochschulsignatur:&\thehochschulsignatur\tabularnewline
          Kandidat:&\thekandidat\tabularnewline
          Geburtsort:&\thegeburtsort\tabularnewline
          Referenten:&\thereferenten\tabularnewline
          Einreichungstermin:&\theeinreichungstermin\tabularnewline
          Pr\"ufungstermin:&\thepruefungstermin\tabularnewline
        \end{tabular}
      \end{center}
    \end{singlespacing}
  \end{titlepage}
  \startcontents[main]%
  \startcontents[appendix]%
  \stopcontents[appendix]%
  \startlist[main]{lof}%
  \startlist[appendix]{lof}%
  \stoplist[appendix]{lof}%
  \startlist[main]{lot}%
  \startlist[appendix]{lot}%
  \stoplist[appendix]{lot}%
}
\newcommand{\inhaltsuebersicht}{%
  \chapter*{\inhaltsuebersichtname\chaptermark{\inhaltsuebersichtname}}
  \printcontents[main]{0}{-1}{\setcounter{tocdepth}{1}}%
}
\renewcommand{\tableofcontents}{%
  \chapter*{\contentsname\chaptermark{\contentsname}}
  \printcontents[main]{0}{-1}{\setcounter{tocdepth}{4}}%
}
\setcounter{topnumber}{3}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.5}
\renewcommand{\textfraction}{0.15}
\renewcommand{\floatpagefraction}{0.7}
\interfootnotelinepenalty=10000
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\renewcommand{\frontmatter}{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
}
\renewcommand{\mainmatter}{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
}
\renewcommand{\backmatter}{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
}
\RequirePackage[nottoc]{tocbibind}[2003/03/13]
\newcommand{\geleitwort}{%
  \chapter*{\geleitwortname\chaptermark{\geleitwortname}}%
}
\newcommand{\vorwort}{%
  \chapter*{\vorwortname\chaptermark{\vorwortname}}%
}
\RequirePackage[noprefix]{nomencl}[2005/03/31]
\RequirePackage{mdwlist}[1996/05/02]
\newcommand{\symbolverzeichnis}{\printnomenclature}
\renewcommand{\nomname}{\symbolverzeichnisname}
\newlength{\nomindent}
\setlength{\nomindent}{3em}
\def\thenomenclature{%
  \chapter*{\nomname\chaptermark{\nomname}}
  \addcontentsline{toc}{chapter}{\nomname}
  \nompreamble
  \addvspace{10pt}
  \begin{basedescript}{%
      \desclabelwidth{\nomindent}
      \desclabelstyle{\nextlinelabel}
      \renewcommand*{\makelabel}[1]{##1}
      \parskip\z@\itemsep\z@%
    }%
}
\def\endthenomenclature{%
  \end{basedescript}
  \nompostamble%
}
\makenomenclature
\newcommand{\abkuerzungsverzeichnis}{%
  \chapter*{\abkuerzungsverzeichnisname\chaptermark{%
      \abkuerzungsverzeichnisname}}
  \addcontentsline{toc}{chapter}{\abkuerzungsverzeichnisname}
  \addvspace{10pt}%
}
\RequirePackage{acronym}[2004/11/10]
\renewcommand*{\acsfont}[1]{\textsc{\MakeLowercase{#1}}}
\newlength{\acroindent}
\setlength{\acroindent}{6em}
\renewenvironment{acronym}[1][1]{%
   \providecommand*{\acro}{\AC@acro}%
   \long\def\acroextra##1{##1}%
   \ifx1#1
      \global\expandafter\let\csname ac@des@mark\endcsname\AC@used
      \begin{basedescript}{%
          \desclabelwidth{\acroindent}
          \desclabelstyle{\nextlinelabel}
          \renewcommand*{\makelabel}[1]{##1}
          \parskip\z@\itemsep\z@%
        }
   \else
      \begin{AC@deflist}{#1}%
   \fi%
  }%
  {%
   \ifx\AC@populated\AC@used\else
      \item[]\relax
   \fi
   \expandafter\ifx\csname ac@des@mark\endcsname\AC@used
      \end{basedescript}%
   \else
      \end{AC@deflist}%
   \fi}
\RequirePackage[tbtags]{amsmath}[2000/07/18]
\RequirePackage[all]{onlyamsmath}[2001/10/04]
\if@gabler
  \newcommand{\graphicsmag}{1.0000}
  \newcommand{\smallgraphicsmag}{0.7500}
  \newcommand{\tinygraphicsmag}{0.5625}
\else
  \newcommand{\graphicsmag}{1.3333}
  \newcommand{\smallgraphicsmag}{1.0000}
  \newcommand{\tinygraphicsmag}{0.7500}
\fi
\RequirePackage{comment}
\if@gabler
  \includecomment{gabler}
  \excludecomment{grundregeln}
\else
  \includecomment{grundregeln}
  \excludecomment{gabler}
\fi
\if@mathematica
  \RequirePackage{wrisym}[1999/04/20]
  \newcommand{\D}{\DifferentialD}
\else
  \RequirePackage{amssymb}[2002/01/22]
  \RequirePackage{dsfont}[1995/08/01]
  \renewcommand{\mathbb}[1]{\mathds{#1}}
  \DeclareMathSymbol{\D}{\mathord}{operators}{`d}
  \newcommand{\E}{\mathrm{e}}
  \newcommand{\I}{\mathrm{i}}
  \newcommand{\MathLogo}{\emph{Mathematica}}
\fi
\if@tools
  % Statistics
  \DeclareRobustCommand\expect{%
    \@ifnextchar[{\ebs@expect}{\ebs@expect[]}%
  }
  \def\ebs@expectop{\mathbf{E}}
  \def\ebs@expect{%
    \@ifnextchar[{\ebs@@expect}{\ebs@@expect[]}%
  }
  \def\ebs@@expect[#1]{%
    \@ifnextchar[{\ebs@@@expect[#1]}{\ebs@@@expect[][#1]}%
  }
  \def\ebs@@@expect[#1][#2]#3{%
    \@expectx[#1][#2]{#3}%
  }
  \def\@expectx[#1][#2]#3{%
    \ifx\relax#1\relax
      \ifx\relax#2\relax
        \ebs@expectop\!\left[#3\right]
      \else
        \ebs@expectop\!\left[#3\,\middle|\,#2\right]
      \fi
    \else
      \ifx\relax#2\relax
        \ebs@expectop_{#1}\!\left[#3\right]
      \else
        \ebs@expectop_{#1}\!\left[#3\,\middle|\,#2\right]
      \fi
    \fi
  }
  \newcommand{\indic}[1]{\mathbf{1}_{#1}}
  \newcommand{\var}[1]{\mathbf{V}\!\left[#1\right]}
  \newcommand{\Var}{\mathrm{Var}}
  \newcommand{\Cov}{\mathrm{Cov}}
  \newcommand{\normal}{\mathrm{N}}
  % Order
  \newcommand{\order}[1]{\mathrm{O}\!\left(#1\right)}
  % Sets
  \newcommand{\Cset}{\mathbf{C}}
  \newcommand{\Hset}{\mathbf{H}}
  \newcommand{\Nset}{\mathbf{N}}
  \newcommand{\Qset}{\mathbf{Q}}
  \newcommand{\Rset}{\mathbf{R}}
  \newcommand{\Zset}{\mathbf{Z}}
  % Absolute value and sign
  \providecommand{\abs}[1]{\left\lvert#1\right\rvert}
  \DeclareMathOperator{\sign}{sign}
  % Evaluated at
  \RequirePackage{ifthen}[2001/05/26]
  \newcommand{\evaluatedat}[3][]{%
    \left.#3\right\rvert_{#2}\ifthenelse{\equal{#1}{}}{\relax}{^{#1}}}
  % Other mathematical expressions
  \DeclareMathOperator*{\argmax}{argmax}
  % Common (English) abbreviations
  \newcommand{\eg}{e.g.}
  \newcommand{\ie}{i.e.}
  \newcommand{\iid}{i.i.d.}
  % Common (German) abbreviations
  \newcommand{\cp}{c.\,p.}
  \newcommand{\idR}{i.\,d.\,R.}
  \newcommand{\mE}{m.\,E.}
  \newcommand{\uU}{u.\,U.}
  \newcommand{\zB}{z.\,B.}
  % Theorems
  \newcommand{\theoremname}{Theorem}
  \newcommand{\lemmaname}{Lemma}
  \newcommand{\propositionname}{Proposition}
  \newcommand{\corollaryname}{Corollary}
  \newcommand{\definitionname}{Definition}
  \newcommand{\conjecturename}{Conjecture}
  \newcommand{\examplename}{Example}
  \newcommand{\remarkname}{Remark}
  \newcommand{\casename}{Case}
  % Babel support for theorems
  \AtBeginDocument{%
    \@ifpackageloaded{babel}{%
       \addto\extrasenglish{%
         \renewcommand{\theoremname}{Theorem}
         \renewcommand{\lemmaname}{Lemma}
         \renewcommand{\propositionname}{Proposition}
         \renewcommand{\corollaryname}{Corollary}
         \renewcommand{\definitionname}{Definition}
         \renewcommand{\conjecturename}{Conjecture}
         \renewcommand{\examplename}{Example}
         \renewcommand{\remarkname}{Remark}
         \renewcommand{\casename}{Case}%
       }
       \addto{\extrasngerman}{%
         \renewcommand{\theoremname}{Theorem}
         \renewcommand{\lemmaname}{Lemma}
         \renewcommand{\propositionname}{Satz}
         \renewcommand{\corollaryname}{Korollar}
         \renewcommand{\definitionname}{Definition}
         \renewcommand{\conjecturename}{Vermutung}
         \renewcommand{\examplename}{Beispiel}
         \renewcommand{\remarkname}{Bemerkung}
         \renewcommand{\casename}{Fall}%
       }%
     }{\relax}%
   }
 \RequirePackage{amsthm}[2004/08/06]
 \theoremstyle{plain}
 \newtheorem{thm}{\theoremname}[chapter]
 \newtheorem{lem}[thm]{\lemmaname}
 \newtheorem{prop}[thm]{\propositionname}
 \newtheorem{cor}{\corollaryname}[chapter]
 \theoremstyle{definition}
 \newtheorem{defn}{\definitionname}[chapter]
 \newtheorem{conj}{\conjecturename}[chapter]
 \newtheorem{exmp}{\examplename}[chapter]
 \theoremstyle{remark}
 \newtheorem*{rem}{\remarkname}
 \newtheorem{case}{\casename}
\fi
\endinput
%%
%% End of file `ebsthesis.cls'.
