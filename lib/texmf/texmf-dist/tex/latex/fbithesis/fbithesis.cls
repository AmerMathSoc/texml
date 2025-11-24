%%
%% This is file `fbithesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% fbithesis.dtx  (with options: `package')
%% 
%% This is `fbithesis.cls', a LaTeX2e package providing a replacement
%% for the maketitle command.
%% Copyright (C) 2002-2011 Andre Dierker
%% 
%% This file is part of the fbithesis package.
%% -------------------------------------------
%% 
%% It may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License, either version 1.3 of this license or
%% (at your option) any later version.
%% 
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This file may not be distributed without the original source file
%% `fbithesis.dtx'.
%% 
%% The list of all files belonging to the fbithesis package is given
%% in the file `README'.
%% 
%% For more details, LaTeX the source `fbithesis.dtx'.
%% 
%% \CharacterTable
%%   {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
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
\NeedsTeXFormat{LaTeX2e}[1994/12/01]%
\ProvidesClass{fbithesis}
  [2011/02/06 v1.2m
 TU Dortmund FBI Report class (AD)]
\newlength{\fbi@skip@v}%
\newlength{\fbi@skip@h}%
\newcount\fbi@tempcnta%
\newcount\fbi@tempcntb%
\newif\iffbi@draft%
\newif\iffbi@decor%
\newif\iffbi@declaration%
\newif\iffbi@base@ams%
\newif\iffbi@base@koma%
\providecommand*{\baseclass}{scrbook}%
\newcommand*{\fbi@font@author}{\Large}
\newcommand*{\fbi@font@title}{\LARGE\bfseries}
\newcommand*{\fbi@font@subject}{\large}
\newcommand*{\fbi@font@date}{\large}
\newcommand*{\fbi@font@thanks}{\scriptsize}
\newcommand*{\fbi@font@chair}{\normalsize}
\newcommand*{\fbi@font@super}{\normalsize}
\AtEndDocument{%
  \ifx\footnote\@oldfootnote
   \else%
    \ClassError{fbithesis}{No \protect\maketitle\space found.  Due to a
     bug in `fbithesis'\MessageBreak every \protect\footnote -command
     is ignored}{Type <return> to proceed, but please note: all
     \protect\footnote -commands in the\MessageBreak document have
     been ignored.  See `Known Bugs'\MessageBreak in the documentation
     of the class for further info.}%
  \fi%
}%
\DeclareOption{draft}{%
  \fbi@drafttrue%
  \PassOptionsToClass{draft}{\baseclass}
  \ClassInfo{fbithesis}{Option `draft' choosen}
}%
\DeclareOption{final}{%
  \fbi@draftfalse%
  \ClassInfo{fbithesis}{Option `final' choosen}
}%
\DeclareOption{german}{%
  \gdef\fbi@text@supervisors{Gutachter:}%
  \gdef\fbi@text@placendate{Ort, Datum}%
  \gdef\fbi@text@name{Unterschrift}%
  \ClassInfo{fbithesis}{Option `german' choosen}
}%
\DeclareOption{ngerman}{%
  \gdef\fbi@text@supervisors{Gutachter:}%
  \gdef\fbi@text@placendate{Ort, Datum}%
  \gdef\fbi@text@name{Unterschrift}%
  \ClassInfo{fbithesis}{Option `ngerman' choosen}
}%
\DeclareOption{english}{%
  \gdef\fbi@text@supervisors{Supervisors:}%
  \gdef\fbi@text@placendate{Place, Date}%
  \gdef\fbi@text@name{Signature}%
  \ClassInfo{fbithesis}{Option `english' choosen}
}%
\DeclareOption{american}{%
  \gdef\fbi@text@supervisors{Supervisors:}%
  \gdef\fbi@text@placendate{Place, Date}%
  \gdef\fbi@text@name{Signature}%
  \ClassInfo{fbithesis}{Option `american' choosen}
}%
\DeclareOption{decor}{%
  \fbi@decortrue%
  \ClassInfo{fbithesis}{Option `decor' choosen}
}%
\DeclareOption{nodecor}{%
  \fbi@decorfalse%
  \ClassInfo{fbithesis}{Option `nodecor' choosen}
}%
\DeclareOption{declaration}{%
  \fbi@declarationtrue%
  \ClassInfo{fbithesis}{Option `declaration' choosen}
}%
\DeclareOption{nodeclaration}{%
  \fbi@declarationfalse%
  \ClassInfo{fbithesis}{Option `nodeclaration' choosen}
}%
\DeclareOption{a4paper}{%
  \newcommand{\fbi@size@h@paper}{21}
  \newcommand{\fbi@size@v@paper}{29.7}
  \newcommand{\fbi@pos@h@}{2.9}
  \newcommand{\fbi@pos@h@square}{1.6}
  \newcommand{\fbi@size@h@square}{0.55}
  \newcommand{\fbi@pos@h@address}{12}
  \newcommand{\fbi@pos@v@windowhead}{25.65}
  \newcommand{\fbi@size@v@windowhead}{1.45}
  \newcommand{\fbi@pos@v@window}{15.4}
  \newcommand{\fbi@pos@v@windowfoot}{12.75}
  \newcommand{\fbi@size@v@windowfoot}{1.4}
  \newcommand{\fbi@size@h@window}{9.2}
  \newcommand{\fbi@size@v@window}{9.1}
  \newcommand{\fbi@pos@v@address}{3.73}
  \newcommand{\fbi@pos@v@addresshead}{4.35}
  \newcommand{\fbi@pos@v@addressfoot}{3.5}
  \newcommand{\fbi@size@h@address}{8.3}
  \newcommand{\fbi@size@v@address}{0.45}
  \newcommand{\fbi@pos@v@chair}{6.8}
  \newcommand{\fbi@size@v@chair}{3.2}
  \newcommand{\fbi@pos@h@logo}{13}
  \newcommand{\fbi@size@h@logo}{7.2}
  \newcommand{\fbi@pos@v@scale}{14.85}
  \newcommand{\fbi@size@h@scale}{19}
  \newcommand{\fbi@pos@h@scale}{10.5}
  \newcommand{\fbi@size@v@scale}{27.7}
  \ClassInfo{fbithesis}{Option `a4paper' choosen}
}%
\PassOptionsToClass{a4paper,titlepage}{\baseclass}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{\baseclass}
  \ClassInfo{fbithesis}{Option `\CurrentOption' choosen}
}%
\ExecuteOptions{final,ngerman,decor,nodeclaration}%
\ProcessOptions*\relax%
\LoadClass{\baseclass}
\begingroup
  \def\@temptokena{scrbook}
  \ifx\baseclass\@temptokena
    \global\fbi@base@komatrue\global\fbi@base@amsfalse
    \ClassInfo{fbithesis}{KOMA-Script is chosen as baseclass}
  \else
    \def\@temptokena{amsbook}
    \ifx\baseclass\@temptokena
      \global\fbi@base@amstrue\global\fbi@base@komafalse
    \ClassInfo{fbithesis}{AMS is chosen as baseclass}
    \else
      \global\fbi@base@komafalse\global\fbi@base@amsfalse
      \ClassInfo{fbithesis}{No special class is chosen as baseclass}
    \fi
  \fi
\endgroup
\RequirePackage{graphicx}[1996/08/05]
\iffbi@base@ams
  \renewcommand*{\and}{%      % \begin{tabular}
    \end{tabular}%
    \hskip 1em \@plus.17fil%
    \begin{tabular}[t]{c}}%   % \end{tabular}
\fi%
\renewcommand*{\date}[2][]{%
  \gdef\fbi@startdate{#1}%
  \gdef\@date{#2}%
}%
\gdef\fbi@startdate{}
\let\@oldfootnote=\footnote%
\renewcommand*{\thanks}[1]{%
  \ClassError{fbithesis}{With `fbithesis' the
    use of \protect\thanks\space is only allowed\MessageBreak with the
    \protect\author\space and the \protect\title\space command}{Type
    <return> to proceed.  The \protect\thanks\space will
    be ignored.}%
}%
\renewcommand*{\footnote}[1]{\ClassWarning{fbithesis}{The use of
    \protect\footnote\space is not allowed here.  Either
    you\MessageBreak tried \protect\footnote\space on the title
    page (then you have to\MessageBreak use \protect\thanks\space
    instead) or you forgot a \protect\maketitle\MessageBreak in
    you document.\MessageBreak This footnote will be ignored}}%
\newcommand*{\unidologo}[1]{%
  \fbi@testGfile{tu}{#1}%
}%
\newcommand*{\chairlogo}[1]{%
  \fbi@testGfile{chair}{#1}%
}%
\newcommand*{\thesislogo}[1]{%
  \fbi@testGfile{thesis}{#1}%
}%
\newcommand*{\thesistype}[1]{%
  \ClassWarning{fbithesis}{Due to compatibility reasons
  \protect\thesistype\space was renamed\MessageBreak to
  \protect\subject.  Please change your document}{Type
  <return> to proceed.}%
  \gdef\@subject{#1}%
}%
\providecommand*{\subject}[1]{%
  \gdef\@subject{#1}%
}%
\newcommand*{\supervisors}[2]{
  \gdef\fbi@supervis@i{#1}%
  \gdef\fbi@supervis@ii{#2}%
}%
\newcommand*{\chair}[1]{%
  \gdef\fbi@chair{#1}%
}%
\newcommand*{\titlevadjust}[1]{%
  \ClassWarning{fbithesis}{A manual correction of the positioning of
    the title\MessageBreak page should not be necessary.  Refer to
    section\MessageBreak `Customization' in the documentation for
    further\MessageBreak info}
  \setlength{\fbi@skip@v}{#1}%
}%
\newcommand*{\titlehadjust}[1]{%
  \ClassWarning{fbithesis}{A manual correction of the positioning of
    the title\MessageBreak page should not be necessary.  Refer to
    section\MessageBreak `Customization' in the documentation for
    further\MessageBreak info}
  \setlength{\fbi@skip@h}{#1}%
}%

\def\fbi@text@tu{TECHNISCHE UNIVERSIT{\fbi@ae}T}%
\def\fbi@text@do{DORTMUND}%
\def\fbi@text@fi{FAKULT{\fbi@ae}T F{\fbi@ue}R INFORMATIK}%
\def\fbi@text@ir@de{INTERNE BERICHTE}%
\def\fbi@text@ir@en{INTERNAL REPORTS}%
\def\fbi@text@address{GERMANY \fbi@dot\space D-44221 DORTMUND}%
\renewcommand{\maketitle}[1][1]{%
  \begin{titlepage}%
  \newcommand*{\fbi@warning}[1]{%
    \ClassWarning{fbithesis}{As explained in the documentation some of
    the title-\MessageBreak affecting commands of KOMA-Script- or
    AMS-classes are\MessageBreak of no use with
    `fbithesis'.\MessageBreak The command `\string##1' is ignored}}%
  \iffbi@base@koma
    \renewcommand*{\extratitle}[1]{\fbi@warning{\extratitle}}%
    \renewcommand*{\titlehead}[1]{\fbi@warning{\titlehead}}%
    \renewcommand*{\publishers}[1]{\fbi@warning{\publishers}}%
  \fi
  \iffbi@base@ams
    \renewcommand*{\address}[2][]{\fbi@warning{\address}}%
    \renewcommand*{\curraddr}[2][]{\fbi@warning{\curraddr}}%
    \renewcommand*{\email}[2][]{\fbi@warning{\email}}%
    \renewcommand*{\urladdr}[2][]{\fbi@warning{\urladdr}}%
    \renewcommand*{\keywords}[1]{\fbi@warning{\keywords}}%
    \renewcommand*{\translator}[2][]{\fbi@warning{\translator}}%
    \renewcommand*{\subjclass}[1]{\fbi@warning{\subjclass}}%
  \fi
  \def\fbi@dolist{\afterassignment\fbi@donext\let\fbi@next= }%
  \def\fbi@donext{%
    \ifx\fbi@next\fbi@endlist%
    \else%
      \fbi@do%
      \expandafter\fbi@dolist%
    \fi}%
  \def\fbi@endlist{\fbi@endlist}%
  \newcommand*{\fbi@stretchto}[2]{%
    \@tempcnta=\z@%
    \def\fbi@do{\advance\@tempcnta by\@ne\relax}%
    \expandafter\fbi@dolist##2\fbi@endlist%
    \advance\@tempcnta by\m@ne\relax
    \setbox\@tempboxa=\hbox{##2}%
    \@tempdima=##1%
    \advance\@tempdima by-\wd\@tempboxa\relax
    \divide\@tempdima by\@tempcnta\relax
    \def\fbi@do{%
      \expandafter\if\space\fbi@next%
        \setbox\@tempboxa=\hbox{\ }%
      \else%
        \setbox\@tempboxa=\hbox{\fbi@next}%
      \fi%
      \box\@tempboxa\kern\@tempdima}%
    \hbox{\expandafter\fbi@dolist##2\fbi@endlist\unkern}}%
  \newcommand*{\fbi@place@windowheader}{%
    \def\fbi@ae{\"{A}}%
    \def\fbi@ue{\"{U}}%
    \fontfamily{phv}\fontseries{b}\fontsize{20}{22}\selectfont%
    \setbox\@tempboxa=\hbox{\fbi@ae}%
    \@tempdima=\ht\@tempboxa%
    \setbox\@tempboxa=\hbox{A}%
    \advance\@tempdima by-\ht\@tempboxa%
    \@tempdimb=\fbi@size@v@windowhead cm%
    \advance\@tempdimb by \@tempdima%
    \parbox[b][\@tempdimb][s]{\fbi@size@h@window cm}{%
      \vspace{\z@}%
      \fbi@stretchto{\fbi@size@h@window cm}{\fbi@text@tu}\par
      \fbi@stretchto{\fbi@size@h@window cm}{\fbi@text@do}\par\vfil%
      \fontseries{m}\selectfont%
      \fbi@stretchto{\fbi@size@h@window cm}{\fbi@text@fi}\par}
  }%
  \newcommand*{\fbi@place@tulogo}{%
    \ifx\fbi@logo@tu\undefined\else%
      \makebox(\fbi@size@h@logo,\fbi@size@v@windowhead)[br]{%
        \includegraphics[width=\fbi@size@h@logo cm,%
                         height=\fbi@size@v@windowhead cm,%
                         keepaspectratio]{%
          \fbi@logo@tu}}%
    \fi
  }%
  \newcommand*{\fbi@place@window}{%
    \begin{minipage}[b][\fbi@size@v@window cm][s]{\fbi@size@h@window cm}%
      \let\footnotesize=\fbi@font@thanks%
      \def\thempfootnote{\@fnsymbol\c@mpfootnote}%
      \def\thanks{\ClassWarningNoLine{fbithesis}{The use of
          \protect\thanks\space is not recommended with \MessageBreak
          `fbithesis'.  Write a preface instead}%
        \@oldfootnote}%
      \vspace{\z@}%
      \begin{center}%
        \vskip 2em%
        {\fbi@font@author%
          \lineskip .75em%
          \begin{tabular}[t]{c}%
            \iffbi@base@ams\authors\else\@author\fi
          \end{tabular}\par}%
        \vfil%
        {\fbi@font@title\@title\par}%
        \vfil%
        \ifx\@subject\undefined\else%
          {\fbi@font@subject\@subject\par}%
          \vfil%
        \fi%
        {\fbi@font@date\ifx\@empty\fbi@startdate\else%
                 {\fbi@startdate} --
               \fi%
               \@date\par}%
      \end{center}%
      \vskip 2em%
      \skip\footins=\z@%
    \end{minipage}}%
  \newcommand*{\fbi@place@thesislogo}{%
    \ifx\fbi@logo@thesis\undefined\else%
      \makebox(\fbi@size@h@logo,\fbi@size@v@window)[cr]{%
        \includegraphics[width=\fbi@size@h@logo cm,%
                         height=\fbi@size@v@window cm,%
                         keepaspectratio]{%
          \fbi@logo@thesis}}%
    \fi
  }%
  \newcommand*{\fbi@place@windowfooter}{%
    \parbox[b][\fbi@size@v@windowfoot cm][s]{\fbi@size@h@window cm}{%
      \vspace{\z@}%
      \fontfamily{phv}\fontseries{m}\fontsize{20}{22}\selectfont%
      \fbi@stretchto{\fbi@size@h@window cm}{\fbi@text@ir@de}\par\vfil%
      \fbi@stretchto{\fbi@size@h@window cm}{\fbi@text@ir@en}\par
    }}%
  \newcommand*{\fbi@place@chair}{%
    \parbox[b][\fbi@size@v@chair cm][s]{\fbi@size@h@window cm}{%
      \vspace{\z@}%
      {\fbi@font@chair\fbi@chair\par}%
      \vfil%
      {\fbi@font@super%
      {\bfseries\fbi@text@supervisors}\par
      \fbi@supervis@i\par
      \fbi@supervis@ii\par}
    }%
  }%
  \newcommand*{\fbi@place@chairlogo}{%
    \ifx\fbi@logo@chair\undefined\else%
      \makebox(\fbi@size@h@logo,\fbi@size@v@chair)[cr]{%
        \includegraphics[width=\fbi@size@h@logo cm,%
                         height=\fbi@size@v@chair cm,%
                         keepaspectratio]{%
          \fbi@logo@chair}}%
    \fi
  }%
  \newcommand*{\fbi@place@address}{%
    \makebox(\fbi@size@h@address,\fbi@size@v@address)[b]{%
      \vspace{\z@}%
      \fontfamily{phv}\fontseries{m}\fontsize{14}{16}\selectfont%
      \def\fbi@dot{$\cdot$}%
      \fbi@stretchto{\fbi@size@h@address cm}{\fbi@text@address}}}%
  \iffbi@draft%
    \newcommand*{\fbi@place@marks}{%
      \thinlines%
      \newsavebox{\fbi@hscale}%
      \savebox{\fbi@hscale}(0,0){%
        \multiput(0,-0.6)(1,0){2}{%
          \put(0,0){\line(0,1){1.2}}%
        }%
        \put(0.5,-0.4){\line(0,1){0.8}}%
        \multiput(0.1,-0.15)(0.1,0){9}{%
          \put(0,0){\line(0,1){0.3}}%
        }%
      }%
      \newsavebox{\fbi@vscale}%
      \savebox{\fbi@vscale}(0,0){%
        \multiput(-0.6,0)(0,1){2}{%
          \put(0,0){\line(1,0){1.2}}%
        }%
        \put(-0.4,0.5){\line(1,0){0.8}}%
        \multiput(-0.15,0.1)(0,0.1){9}{%
          \put(0,0){\line(1,0){0.3}}%
        }%
      }%
      \put(\fbi@pos@h@,\fbi@pos@v@window){%
        \framebox(\fbi@size@h@window,\fbi@size@v@window){}}%
      \multiput(0,\fbi@pos@v@scale)(\fbi@size@h@scale,0){2}{%
        \multiput(0,0)(1,0){2}{%
          \put(0,0){\usebox{\fbi@hscale}}%
        }%
      }%
      \put(0,0.5){%
        \multiput(\fbi@pos@h@scale,0)(0,\fbi@size@v@scale){2}{%
          \multiput(0,0)(0,1){2}{%
            \put(0,0){\usebox{\fbi@vscale}}%
          }%
        }%
      }%
    }%
  \else%
    \let\fbi@place@marks=\relax
  \fi%
\def\fbi@text@declaration{%
  \begingroup
    \fbi@tempcnta=\z@%
    \@tempswafalse%
    \renewcommand*{\and}{%
      \global\let\if@tempswa=\iftrue%
      \global\advance\fbi@tempcnta by \@ne%
    }%
    \let\thanks=\@gobble%
    \setbox\@tempboxa=\vbox{\iffbi@base@ams\authors\else\@author\fi}%
    \ClassInfo{fbithesis}{Number of authors: \the\fbi@tempcnta +1}%
    \xdef\fbi@text@mewe{\if@tempswa wir\else ich\fi}%
    \xdef\fbi@text@have{\if@tempswa haben\else habe\fi}%
    \xdef\fbi@text@declare{\if@tempswa erkl\"{a}ren\else erkl\"{a}re\fi}%
    \xdef\fbi@text@work{%
      \if@tempswa
        entsprechend gekennzeichneten Teile der vorliegenden\space%
        Gruppenarbeit%
      \else
        vorliegende Arbeit%
      \fi
    }%
    \fbi@tempcntb=\z@%
    \renewcommand*{\and}{%
      \advance\fbi@tempcntb by \@ne%
      \ifnum\fbi@tempcntb<\fbi@tempcnta
        \unskip ,\space%
       \else
        und\space%
      \fi
    }%
    Hiermit \fbi@text@declare\space\fbi@text@mewe ,
    \iffbi@base@ams\authors\else\@author\fi , dass \fbi@text@mewe\ die
    \fbi@text@work\ selbstst\"{a}ndig verfasst und keine anderen als
    die angegebenen Quellen und Hilfsmittel verwendet \fbi@text@have .
    Zitate \fbi@text@have\space\fbi@text@mewe\ stets kenntlich
    gemacht.
  \endgroup
}%
    \setcounter{page}{#1}%
    \addtolength{\fbi@skip@v}{\topmargin}%
    \addtolength{\fbi@skip@v}{\headheight}%
    \addtolength{\fbi@skip@v}{\headsep}%
    \addtolength{\fbi@skip@v}{\topskip}%
    \addtolength{\fbi@skip@v}{\baselineskip}%
    \addtolength{\fbi@skip@h}{\oddsidemargin}%
    \addtolength{\fbi@skip@v}{1in}%
    \addtolength{\fbi@skip@h}{1in}%
    \addtolength{\fbi@skip@v}{\voffset}%
    \addtolength{\fbi@skip@h}{\hoffset}%
    \ClassInfo{fbithesis}{%
      These are the calculated values describing the\MessageBreak
      translation of the print space:\MessageBreak Vertical
      skip\space\space\space=\space\the\fbi@skip@v\MessageBreak
      Horizontal skip\space=\space\the\fbi@skip@h}%
    \null\vskip -\fbi@skip@v\vbox to \z@{%
    \noindent\hskip -\fbi@skip@h\hb@xt@\z@{%
    \setlength{\unitlength}{1cm}%
    \@picture(\fbi@size@h@paper,\fbi@size@v@paper)(0,0)
      \iffbi@decor
        \put(\fbi@pos@h@,\fbi@pos@v@windowhead){\fbi@place@windowheader}%
        \put(\fbi@pos@h@square,\fbi@pos@v@windowhead){%
          \rule{\fbi@size@h@square cm}{\fbi@size@h@square cm}}%
      \fi
      \put(\fbi@pos@h@logo,\fbi@pos@v@windowhead){\fbi@place@tulogo}%
      \put(\fbi@pos@h@,\fbi@pos@v@window){\fbi@place@window}%
      \put(\fbi@pos@h@logo,\fbi@pos@v@window){\fbi@place@thesislogo}%
      \iffbi@decor
        \put(\fbi@pos@h@,\fbi@pos@v@windowfoot){\fbi@place@windowfooter}%
      \fi
      \put(\fbi@pos@h@,\fbi@pos@v@chair){\fbi@place@chair}%
      \put(\fbi@pos@h@logo,\fbi@pos@v@chair){\fbi@place@chairlogo}%
      \iffbi@decor
        \linethickness{0.5mm}%
        \put(\fbi@pos@h@address,\fbi@pos@v@addresshead){\line(1,0){%
          \fbi@size@h@address}}%
        \put(\fbi@pos@h@address,\fbi@pos@v@addressfoot){\line(1,0){%
          \fbi@size@h@address}}%
        \put(\fbi@pos@h@address,\fbi@pos@v@address){\fbi@place@address}%
      \fi
      \fbi@place@marks%
    \endpicture\hss}%
    \vss}%
    \iffbi@base@koma
      \if@twoside
        \clearpage\thispagestyle{empty}%
        \noindent\begin{minipage}[t]{\textwidth}%
          \ifx\@uppertitleback\undefined\else%
            \@uppertitleback%
          \fi%
        \end{minipage}\par%
        \vfill%
        \noindent\begin{minipage}[b]{\textwidth}%
          \ifx\@lowertitleback\undefined\else%
            \@lowertitleback%
          \fi%
        \end{minipage}%
      \fi
    \fi
    \if@twoside
      \iffbi@declaration
        \cleardoublepage\thispagestyle{empty}%
        \noindent\begin{minipage}[t]{\textwidth}%
          \noindent\fbi@text@declaration\par%
          \vspace{1cm}%
          \fbi@tempcntb=\z@%
          \loop
            \vspace{1.5cm}%
            \noindent\rule{6cm}{1pt}\hspace{0.5cm}%
            \rule{6cm}{1pt}\par%
            \noindent\parbox{6cm}{\small\fbi@text@placendate}\hspace{0.5cm}%
            \parbox{6cm}{\small\fbi@text@name}\par%
           \ifnum\fbi@tempcntb<\fbi@tempcnta
            \advance\fbi@tempcntb by \@ne%
          \repeat
        \end{minipage}
      \fi
    \fi
    \iffbi@base@ams
      \ifx\@dedicatory\@empty\else
        \clearpage\thispagestyle{empty}\null\vfill
        {\centering\Large\@dedicatory\par}
        \vskip \z@ \@plus3fill
        \if@twoside\clearpage\thispagestyle{empty}\cleardoublepage\fi
      \fi
    \else
      \iffbi@base@koma
        \ifx\@dedication\@empty\else
          \clearpage\thispagestyle{empty}\null\vfill
          {\centering\Large\@dedication\par}
          \vskip \z@ \@plus3fill
          \if@twoside%
            \clearpage\thispagestyle{empty}\cleardoublepage%
          \fi
        \fi
      \fi
    \fi
  \end{titlepage}%
  \fbi@cleanup%
}%
\newcommand*{\fbi@cleanup}{%
  \setcounter{footnote}{0}%
  \global\let\footnote=\@oldfootnote
}%
\newcommand*{\fbi@testGfile}[2]{
  \begingroup
  \let\input@path\Ginput@path
  \filename@parse{#2}%
  \ifx\filename@ext\relax
    \@for\Gin@temp:=\Gin@extensions\do{%
      \ifx\Gin@ext\relax
        \Gin@getbase\Gin@temp
      \fi}%
  \else
    \Gin@getbase{\Gin@sepdefault\filename@ext}%
  \fi
  \ifx\Gin@ext\relax
    \ClassWarning{fbithesis}{File `#2' not found.  The command
    `\backslash #1'\MessageBreak is ignored}
  \else\expandafter\gdef\csname fbi@logo@#1\endcsname{#2}\fi
  \endgroup%
}
\InputIfFileExists{fbithesis.cfg}
  {\typeout{****************************************^^J%
            * Local config file fbithesis.cfg used *^^J%
            ****************************************}
  }{}%
\endinput
%%
%% End of file `fbithesis.cls'.
