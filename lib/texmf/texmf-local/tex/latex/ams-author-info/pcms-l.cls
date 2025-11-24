%%
%% This is file `pcms-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pcms-l.dtx  (with options: `cls')
%% 
%% Copyright 2006, 2009-2013, 2016 American Mathematical Society.
%% 
%% American Mathematical Society
%% Technical Support
%% Publications Technical Group
%% 201 Charles Street
%% Providence, RI 02904
%% USA
%% tel: (401) 455-4080
%%      (800) 321-4267 (USA and Canada only)
%% fax: (401) 331-3842
%% email: tech-support@ams.org
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is the American Mathematical
%% Society.
%% 
%% ========================================================================
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pcms-l}[2016/02/17 v2.14 PCMS Author Class]
\newif\if@lectures \@lecturesfalse
\DeclareOption{article}{\@lecturesfalse}
\DeclareOption{lectures}{\@lecturestrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions
\LoadClass{amsbook}[1999/12/16]
\let\bookauthor=\author
\DeclareRobustCommand{\author}[2][]{%
  \ifx\@empty\authors
    \gdef\authors{#2}%
  \else
    \g@addto@macro\authors{\and#2}%
    \g@addto@macro\addresses{\author{}}%
  \fi
  \@ifnotempty{#1}{%
    \ifx\@empty\shortauthors
      \gdef\shortauthors{#1}%
    \else
      \g@addto@macro\shortauthors{\and#1}%
    \fi
  }%
}
\let\LectureSeries\part
\def\partauthor{%
  \def\author##1{\newline{\phantom{\quad}\mdseries\scshape##1}}}
\def\@part[#1]#2{%
    \csname phantomsection\endcsname
  \begingroup
  \def\author##1{\gdef\saveauthor{##1}%
    \\ \hfil \\ \fontsize{\@xivpt}{20}\bfseries ##1}%
  \raggedleft
  \fontsize{\@xxpt}{25}\bfseries
    #2\vfil\vfil\endgroup \newpage\thispagestyle{empty}%
  \Chapter
  \let\@secnumber\@empty
  \typeout{Lecture series: #1}%
  \@tocwriteb\tocpart{part}{#2}%
  \begingroup
    \let\o\O \let\aa\AA \let\l\L
    \xdef\@saveauthor{\@xp\uppercase{\saveauthor}}%
  \endgroup
  \Chaptermark{\@saveauthor, #1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makeChapterhead{#2}\@afterheading
}
\let\@spart\@part
\def\shortLectureTitle#1{%
  \def\tempa@{#1}\uppercasenonmath\@tempa\@tempa
  \markboth{\@tempa}{\@tempa}}
\def\currentvolume{XX}
\def\currentyear{XXXX}
\copyrightinfo{\number\year}{American Mathematical Society}
\def\volinfo{}
\def\@logofont{\fontsize{6}{7\p@}\selectfont\bfseries}
\long\def\@serieslogo{%
  \vbox to\headheight{%
    \@parboxrestore \@logofont
    \noindent IAS/Park City Mathematics Series
    \ifx\@empty\currentvolume
    \else\newline Volume \currentvolume, \currentyear
    \fi
    \par\vss
  }%
}
\def\ps@firstpage{\ps@plain
  \def\@oddfoot{\normalfont\scriptsize \hfil\thepage\hfil
     \global\topskip\normaltopskip}%
  \let\@evenfoot\@oddfoot
  \def\@oddhead{\@serieslogo\hss}%
  \let\@evenhead\@oddhead % in case an article starts on a left-hand page
}
\long\def\@footnotetext#1{%
  \insert\footins{%
    \normalfont\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep \splitmaxdepth \dp\strutbox
    \floatingpenalty\@MM \hsize\columnwidth
    \@parboxrestore \parindent\z@ \sloppy
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark}%
    \@makefntext{%
      \rule\z@\footnotesep\ignorespaces#1\unskip\strut\par}}}
\def\C@footnote#1{{\let\@thefnmark\relax \@footnotetext{#1}}}
\newcommand*\C@subjclass[2][1991]{%
  \def\@subjclass{#2}%
  \@ifundefined{subjclassname@#1}{%
    \ClassWarning{\@classname}{Unknown edition (#1) of Mathematics
      Subject Classification; using '1991'.}%
  }{%
    \@xp\let\@xp\subjclassname\csname subjclassname@#1\endcsname
  }%
  \@ifnotempty{##1}{\C@footnote{\@setsubjclass}}%
}
\newcommand*\C@urladdr[1]{%
  \begingroup
    \def~{\char`\~}%
    \C@footnote{\textbf{URL: }\ttfamily#1}%
  \endgroup
}
\def\Chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \renewcommand{\address}[1]{%
    \@ifnotempty{##1}{\C@footnote{##1}}}%
  \renewcommand{\curraddr}[1]{%
    \@ifnotempty{##1}{\C@footnote{\textbf{Current address: }##1}}}%
  \renewcommand{\email}[1]{%
    \@ifnotempty{##1}{\C@footnote{\textbf{E-mail address: }##1}}}%
  \let\urladdr\C@urladdr
  \renewcommand{\thanks}[1]{%
    \@ifnotempty{##1}{\C@footnote{##1}}}%
  \let\subjclass\C@subjclass
  \renewcommand{\keywords}[1]{%
    \@ifnotempty{##1}{\C@footnote{\@setkeywords##1}}}%
  \@setcopyright
  \thispagestyle{firstpage}\global\@topnum\z@
  \@afterindenttrue
}
\def\@makeChapterhead#1{%
  \global\topskip 4.5pc\relax
  \begingroup
  \fontsize{\@xivpt}{18}\bfseries\raggedleft
    #1\par
  \vskip1pc\fontsize{\@xiipt}{14}\bfseries\saveauthor\par
  \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\def\Chapterrunhead#1#2#3{%
  \def\@tempa{#3}%
  \ifx\@empty\@tempa\else
    \begingroup \def\\{ \ignorespaces}% defend against questionable usage
      \uppercasenonmath\@tempa\@tempa
    \endgroup
  \fi
}
\def\l@chapter{\@tocline{0}{8pt plus1pt}{0pt}{}{\def\author##1{}}}
\if@lectures
  \newcounter{lecture}
  \let\c@lecture\c@chapter
  \let\c@section\relax
  \newcounter{section}[lecture]
  \numberwithin{subsection}{section}
  \numberwithin{subsubsection}{subsection}
  \let\sectionmark\@gobble
\fi
\renewcommand\chaptername{Lecture}%
\def\lecture{%
    \@ifundefined{toclevel@section}{}{%
        \def\toclevel@section{1}%
        \def\toclevel@subsection{2}%
        \def\toclevel@subsubsection{3}%
        \def\toclevel@paragraph{4}%
        \def\toclevel@subparagraph{5}%
    }%
    \let\lecture\chapter
    \lecture
}
\def\@@makechapterhead#1#2{\global\topskip 7.5pc\relax
  \begingroup
   \def\author##1{\vskip1pc\fontsize{\@xiipt}{14}\mdseries\textsc{##1}}%
   \fontsize{\@xivpt}{18}\bfseries\raggedleft
   #1%
   #2\par
  \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\def\@makechapterhead#1{%
  \if@lectures \setcounter{lecture}{\c@chapter}\fi
  \@@makechapterhead{%
    \ifnum\c@secnumdepth>\m@ne
      \leavevmode \hskip-\leftskip
      \rlap{\vbox to\z@{\vss
          {\normalsize\bfseries
              \MakeUppercase{\chaptername}\enspace\thechapter}
          \vskip 2pc}}\hskip\leftskip
    \fi}{#1}}
\def\@makeschapterhead#1{%
  \@@makechapterhead{\relax}{#1}}
\def\chapterrunhead#1#2#3{%
  \def\@tempa{#3}%
  \ifx\@empty\@tempa\else
    \begingroup
      \@xp\uppercase\@xp{\chaptername} \thechapter.\enspace
      \def\\{ \ignorespaces}% defend against questionable usage
      \uppercasenonmath\@tempa\@tempa
    \endgroup
  \fi
}
\def\@startsection#1#2#3#4#5#6{%
 \if@noskipsec \leavevmode \fi
 \par \@tempskipa #4\relax
 \@afterindentfalse
 \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
 \if@nobreak \everypar{}\else
     \addpenalty\@secpenalty\addvspace\@tempskipa\fi
 \@ifstar{\@dblarg{\@sect{#1}{\@m}{#3}{#4}{#5}{#6}}}%
         {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
}
\def\section{\@startsection{section}{1}%
  \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\bfseries}}
\def\subsection{\@startsection{subsection}{2}%
  \z@{.5\linespacing\@plus.7\linespacing}{.1\linespacing}%
  {\normalfont\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  \z@\z@{-.5em}%
  {\normalfont\itshape}}
\def\ps@headings{\ps@empty
  \def\@evenhead{%
    \setTrue{runhead}%
    \normalfont\scriptsize
    \rlap{\thepage}\hfil
    \def\thanks{\protect\thanks@warning}%
    \leftmark{}{}\hfil}%
  \def\@oddhead{%
    \setTrue{runhead}%
    \normalfont\scriptsize \hfil
    \def\thanks{\protect\thanks@warning}%
    \rightmark{}{}\hfil \llap{\thepage}}%
  \let\@mkboth\markboth
  \def\partmark{\@secmark\markboth\partrunhead\partname}%
  \def\Chaptermark{%
    \@secmark\markboth\Chapterrunhead{}}%
  \def\chaptermark{%
    \@secmark\markright\chapterrunhead{}}%
}
\pagestyle{headings}
\def\@tocline#1#2#3#4#5#6#7{\relax
  \ifnum #1>\c@tocdepth % then omit
  \else
    \ifnum #1=0
      \def\author##1{\newline\textsc{##1}}%
    \else \let\author\relax
    \fi
    \par \addpenalty\@secpenalty\addvspace{#2}%
    \begingroup \hyphenpenalty\@M
    \@ifempty{#4}{%
      \@tempdima\csname r@tocindent\number#1\endcsname\relax
    }{%
      \@tempdima#4\relax
    }%
    \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
    \rightskip\@pnumwidth plus4em \parfillskip-\@pnumwidth
    #5\leavevmode\hskip-\@tempdima #6\nobreak\relax
    \hfil\hbox to\@pnumwidth{\@tocpagenum{#7}}\par
    \nobreak
    \endgroup
  \fi}
\def\@thm#1#2#3{%
  \ifhmode\unskip\unskip\par\fi
  \normalfont
  \trivlist
  \let\thmheadnl\relax
  \let\thm@swap\@gobble
  \let\thm@indent\noindent % noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\fontseries\mddefault\upshape}%
  \thm@headpunct{.}% add period after heading
  \thm@headsep 5\p@ plus\p@ minus\p@\relax
  \thm@space@setup
  #1% style overrides
  \@topsep \thm@preskip               % used by thm head
  \@topsepadd \thm@postskip           % used by \@endparenv
  \def\@tempa{#2}\ifx\@empty\@tempa
    \def\@tempa{\@oparg{\@begintheorem{#3}{}}[]}%
  \else
    \refstepcounter{#2}%
    \def\@tempa{\@oparg{\@begintheorem{#3}{\csname the#2\endcsname}}[]}%
  \fi
  \@tempa
}
\newcommand{\BiblioAsSection}{%
  \renewcommand{\@bibtitlestyle}{%
    \@xp\section\@xp*\@xp{\bibname}%
  }%
}
\newcommand{\BiblioAsChapter}{%
  \renewcommand{\@bibtitlestyle}{%
    \@xp\chapter\@xp*\@xp{\bibname}%
    \gdef\@oddhead{%
      \setTrue{runhead}%
      \def\thanks{\protect\thanks@warning}%
      \normalfont\scriptsize
      \hfil
      \@xp\uppercase\@xp{\bibname}\hfil
      \llap{\thepage}}%
  }%
}
\if@lectures\BiblioAsChapter
\else\BiblioAsSection
\fi
\InputIfFileExists{pcms-l.cfg}{}{}
\endinput
%%
%% End of file `pcms-l.cls'.
