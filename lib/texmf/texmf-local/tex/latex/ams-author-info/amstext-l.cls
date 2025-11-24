%%
%% This is file `amstext-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% amstext-l.dtx 
%% 
%% Copyright 2009, 2010, 2016, 2017 American Mathematical Society.
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
%% This work may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3c of this
%% license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% We request that if you modify this file, you give the modified
%% version another name.
%% 
%% This work has the LPPL maintenance status "maintained".
%% 
%% The Current Maintainer of this work is the American Mathematical
%% Society.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{amstext-l}[2017/01/27 v0.996 beta AMSTEXT Author Class]
\providecommand\@classname{amstext-l}
\newcommand\DelayedOption[2]{\@ifclasswith{\@classname}{#1}{#2}{}}
\newif\if@elevenpt  \@elevenptfalse
\DeclareOption{11pt}{\@elevenpttrue}
\DeclareOption{12pt}{\@elevenptfalse}
\newif\if@multixcb  \@multixcbfalse
\DeclareOption{multixcb}{\@multixcbtrue}
\DeclareOption{theorema}{}
\DeclareOption{theoremb}{}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ExecuteOptions{theorema}
\ProcessOptions\relax
\if@elevenpt
  \LoadClass[11pt]{amsbook}[2004/08/06]
\else
  \LoadClass[10pt]{amsbook}[2004/08/06]
\fi
\parskip 3\p@\relax
\toks@\@xp{\@listi}%
\edef\@listi{\the\toks@ \itemsep1\parskip plus\p@\relax}
\let\@listI\@listi \@listI
\@ifundefined{cleardouble@page}{%
  \let\cleardouble@page\cleardoublepage
  \def\cleardoublepage{\clearpage{\pagestyle{empty}\cleardouble@page}}%
}{}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax \refstepcounter{part}\fi
  \begingroup \Huge\sffamily\bfseries
  \hsize24pc \raggedright
  \ifnum \c@secnumdepth >-2\relax
    {\LARGE\normalfont\sffamily\slshape
      \top@space{18pc plus-1fil}% cancel \null\vfil done by \part
      \partname\ \thepart\par
    }%
    \bb@space{48pt}%
    \ignorespaces#2\unskip
    \addcontentsline{toc}{part}{%
      \partname\ \thepart.\protect\enspace\protect\noindent#1}%
  \else
    \ignorespaces#2\unskip
    \addcontentsline{toc}{part}{#1}%
  \fi
  \par
  \endgroup
  \thispagestyle{plain}%
  \newpage
  \thispagestyle{empty}}

\def\@spart#1{%
  \begingroup \c@secnumdepth=-2 \@part[#1]{#1}\endgroup
}
\providecommand\bb@space[1]{%
  \skip@#1\advance\skip@-\baselineskip\vskip\skip@
}
\providecommand\top@space[1]{%
  \par
  \ifdim\pagegoal<\maxdimen \else\hbox{}\fi
  \skip@#1\advance\skip@-\topskip
  \advance\skip@-\headsep\advance\skip@-\headheight
  \advance\skip@-\baselineskip\vskip\skip@
}
\def\chapter{\cleardoublepage\thispagestyle{plain}\global\@topnum\z@
  \@afterindentfalse \secdef\@chapter\@schapter}
\def\chapter@number{%
  \ifnum\c@secnumdepth>\m@ne
    \vskip-\headsep\vskip5pt
    \vbox{\LARGE\normalfont\sffamily\slshape
      \hbox to\textwidth{\hss\rule{8pc}{6pt}}%
      \hbox to\textwidth{\hss\chaptername\space\thechapter\unskip}%
    }%
  \fi
}
\providecommand{\indexintro}{}
\newif\if@index  \@indexfalse
\def\@makechapterhead#1{\global\topskip\normaltopskip
  \begingroup
  \vbox to\topskip{%
    \chapter@number
    \vss
  }\penalty\@M
  \Huge\sffamily\bfseries \hsize24pc \raggedright
  \top@space{11pc}%
  \noindent\ignorespaces #1\par \endgroup
  \if@index
    \ifx\@empty\indexintro
      \bb@space{7.5pc}%
    \else
      \vspace{3pc}%
      \begingroup \small
        \parbox[t]{27pc}{\leftskip3pc\normalfont\indexintro\par}%
      \endgroup
      \bb@space{3pc}%
    \fi
  \else
      \@dropfolio
      \bb@space{7.5pc}%
  \fi
  \@afterheading
}
\def\@makeschapterhead#1{\begingroup
  \c@secnumdepth\m@ne \@makechapterhead{#1}%
  \endgroup
}
\def\indexfont{\small}
\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
  \columnseprule\z@ \columnsep 35\p@
  \@indextitlestyle
  \thispagestyle{plain}%
  \let\item\@idxitem
  \parindent\z@  \parskip\z@\@plus.3\p@\relax
  \raggedright
  \hyphenpenalty\@M
  \indexfont}
\def\section{\@startsection{section}{1}%
  \z@{-.7\linespacing\@plus-\linespacing}{.5\linespacing}%
  {\large\normalfont\sffamily\bfseries \raggedright}}
\def\specialsection{\@startsection{section}{1}%
  \z@{-2\linespacing\@plus-\linespacing}{.5\linespacing}%
  {\Large\normalfont\sffamily\bfseries \raggedright}}
\def\subsection{\@startsection{subsection}{2}%
  \normalparindent{.5\linespacing\@plus.7\linespacing}{-.5em}%
  {\normalfont\sffamily\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  \normalparindent\z@{-.5em}%
  {\let\@secnumfont\bfseries\normalfont\sffamily\slshape}}
\newif\if@xcb \@xcbfalse
\newcommand{\xcbtitlefont}{\Large\sffamily\bfseries}
\newcommand\xcbdigits{00}
\newcommand{\amt@needspace}[1]{%
  \begingroup
    \setlength{\dimen@}{#1}%
    \vskip\z@\@plus\dimen@
    \penalty -100\vskip\z@\@plus -\dimen@
    \vskip\dimen@
    \penalty 9999%
    \vskip -\dimen@
    \vskip\z@skip
  \endgroup
}
\newif\if@longxcbtoprule \@longxcbtoprulefalse
\def\longxcbtoprule{\global\@longxcbtopruletrue}
\renewenvironment{xcb}{\par
  \ifdim\lastskip>\z@\vskip-\lastskip\fi
  \amt@needspace{80pt}%
  \settowidth{\leftmargini}{\xcbdigits.\hskip\labelsep}%
  \def\labelenumi{\theenumi.}
  \settowidth{\leftmarginii}{(d.)\hskip\labelsep}%
  \if@multixcb \global\@xcbtrue \fi
  \penalty-450
  \@tempskipa 20\p@ plus2\p@\relax
  \if@longxcbtoprule
    \advance\@tempskipa -\baselineskip
    \vskip\@tempskipa
    \null
    \global\@longxcbtoprulefalse
  \else
    \vskip\@tempskipa
  \fi
  \leaders\hrule width\columnwidth\vskip.5\p@\relax
  \@startsection{section}% counter name; ignored because of the * below
  {1}% sectioning level
  {\z@}% indent to the left of the title
  {-1sp}% vertical space above (faked, see leaders above)
  {12\p@}% Space below
  {\xcbtitlefont % The font of the title
   \raggedright\leftskip\columnwidth \advance\leftskip-12pc
   \xcb@rule}%
  *% always unnumbered
}{%
  \par
  \if@multixcb
    \setlength{\dimen@}{10pt}%
    \dimen@ii\pagegoal \advance\dimen@ii-\pagetotal
    \ifdim \dimen@>\dimen@ii
      \PackageWarning{amstext-l.cls}{%
        Add manual page break to avoid bad break\MessageBreak
        at \string\end\string{xcb\string}}%
    \fi
    \nopagebreak \xcb@endrule
  \fi
}
\def\xcb@rule{\par\nobreak\nointerlineskip%
  {\parskip\z@skip\noindent}\rule{12pc}{4pt}\break\ignorespaces}
\newif\if@shortxcbendrule \@shortxcbendrulefalse
\def\shortxcbendrule{\global\@shortxcbendruletrue}
\def\xcb@endrule{\par
  \ifdim\lastskip>\z@\vskip-\lastskip\fi
  \vskip6\p@ plus2\p@
  {\parfillskip\z@
  \baselineskip\z@ \offinterlineskip
  \hspace*{\fill}\rule{12pc}{4pt}%
  \if@shortxcbendrule
    \global\@shortxcbendrulefalse
  \else \\
    \unskip\vrule height\z@ depth.4\p@ width\columnwidth\null
  \fi
  \endgraf}}
\@ifundefined{ams@measure}{%
  \newif\if@ams@empty
  \def\ams@measure#1{%
    \begingroup
        \setbox\@tempboxa\hbox{\ignorespaces#1\unskip}%
    \expandafter\endgroup
    \ifdim\wd\@tempboxa=\z@
        \@ams@emptytrue
    \else
        \@ams@emptyfalse
    \fi
  }
}
\@ams@emptyfalse
\def\@sect#1#2#3#4#5#6[#7]#8{%
    \ams@measure{#8}%
  \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
  \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
  \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
  \@tempskipa #5\relax
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \edef\@secnumpunct{%
      \ifdim\@tempskipa>\z@ % not a run-in section heading
        \if@ams@empty\else.\@nx\enspace\fi
      \else
        \if@ams@empty.\else.\@nx\enspace\fi
      \fi
    }%
    \protected@edef\@svsec{%
      \ifnum#2<\@m
        \@ifundefined{#1name}{}{%
          \ignorespaces\csname #1name\endcsname\space
        }%
      \fi
      \@seccntformat{#1}%
    }%
  \fi
  \ifdim \@tempskipa>\z@ % then this is not a run-in section heading
    \begingroup #6\relax
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8\par}%
    \endgroup
    \if@xcb \global\@xcbfalse
    \else \csname #1mark\endcsname{#7}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
    \fi
  \else
    \def\@svsechd{#6\hskip #3\@svsec
    \if@ams@empty\else
        \ignorespaces#8\unskip
         \@addpunct.%
    \fi
      \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
    }%
  \fi
  \global\@nobreaktrue
  \@xsect{#5}%
}
\AtBeginDocument{%
  \labelsep=5pt\relax
  \setcounter{enumi}{13}\setcounter{enumii}{13}%
  \setcounter{enumiii}{13}\setcounter{enumiv}{13}%
  \settowidth\leftmargini{\labelenumi\hskip\labelsep}%
%%  \advance\leftmargini by \normalparindent
  \settowidth\leftmarginii{\labelenumii\hskip\labelsep}%
  \settowidth\leftmarginiii{\labelenumiii\hskip\labelsep}%
  \settowidth\leftmarginiv{\labelenumiv\hskip\labelsep}%
  \setcounter{enumi}{0}\setcounter{enumii}{0}%
  \setcounter{enumiii}{0}\setcounter{enumiv}{0}%
  \leftmarginv=10pt  \leftmarginvi=\leftmarginv
  \leftmargin=\leftmargini
  \labelwidth=\leftmargini \advance\labelwidth-\labelsep
  \@listi
  \if@multixcb
    \renewcommand{\xcbtitlefont}{\large\sffamily\bfseries}%
  \fi
}
\def\th@plain{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  % \thm@space@setup
  \itshape
}
\def\th@definition{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  % \thm@space@setup
  \upshape
}
\def\th@remark{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  % \thm@space@setup
  \upshape
}
\@ifundefined{swappedhead@plain}{%
  \let\swappedhead@plain=\swappedhead
}{}
\@ifundefined{pushQED}{%
  \let\pushQED\@gobble
  \def\popQED{\qed}%
}{}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}\relax
  \normalfont \topsep6\p@\@plus6\p@ \relax
  \trivlist
  \itemindent\z@
  \item[\hskip\labelsep
        \bfseries
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
\DelayedOption{theoremb}{%
  \def\th@plain{%
    \let\thm@indent\indent
    \thm@headfont{\scshape}%
    \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
    % \thm@space@setup
    \itshape
  }%
  \def\th@definition{%
    \let\thm@indent\indent
    \thm@headfont{\scshape}%
    \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
    % \thm@space@setup
    \upshape
  }%
  \def\th@remark{%
    \let\thm@indent\indent
    \thm@headfont{\itshape}%
    \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
    % \thm@space@setup
    \upshape
  }%
  \renewenvironment{proof}[1][\proofname]{\par
    \pushQED{\qed}\relax
    \normalfont \topsep6\p@\@plus6\p@\relax
    \trivlist
    \itemindent\normalparindent
    \item[\hskip\labelsep
          \itshape
      #1\@addpunct{.}]\ignorespaces
  }{%
    \popQED\endtrivlist\@endpefalse
  }%
}
\newcommand{\xqed}[1]{%
  \leavevmode\unskip\penalty9999 \hbox{}\nobreak\hfill
  \quad\hbox{\ensuremath{#1}}}
\newdimen\@mathstrutdepth
\def\setmathstrut{\setbox\@tempboxa\hbox{(}%
  \@mathstrutdepth\dp\@tempboxa
  \gdef\setmathstrut{}}
\def\maketag@@@framed#1{\hbox{\kern\leftskip\m@th\normalfont#1}}%
\newenvironment{framedthm}[1]{%
  \def\@current@framed{#1}%
  \thm@space@setup
  \addvspace\thm@preskip
  \setmathstrut
  \setbox\@tempboxa\vbox\bgroup
    \thm@preskip\z@skip
    \thm@postskip\z@skip
    \def\thm@space@setup{%
      \advance\leftskip\fboxsep\relax
      \advance\rightskip\fboxsep\relax
      \displaywidth=\textwidth
      \let\maketag@@@\maketag@@@framed
    }%
    \color@begingroup
    \kern\fboxsep
    \csname\@current@framed\endcsname
}{%
    \par
    \ifdim\lastskip=\belowdisplayskip
      \unskip
    \fi
    \ifdim\prevdepth<\@mathstrutdepth
      \kern-\prevdepth
      \kern\@mathstrutdepth
    \fi
    \kern\fboxsep
    \color@endgroup
  \egroup
  \@frameb@x\relax
  \addvspace\thm@postskip
}
\newcommand{\inclusionfont}{\small}
\newdimen\inclusionindent \inclusionindent2pc
\newenvironment{inclusion}[1]{%
  \addvspace{2\bigskipamount}%
  \begingroup
    \parskip=0pt
    \def\@temp{#1}%
    \ifx\@temp\@empty
    \else
      {\leftskip=2pc plus 1fil \rightskip\leftskip
       \parindent0pt \parfillskip0pt
       \small\bfseries#1\par}%
      \nobreak\vspace{2pt}
    \fi
    \leftskip=\inclusionindent
    \inclusionfont
    \noindent\ignorespaces
}{%
    \par
  \endgroup
  \vspace{.5\bigskipamount}
}
\let\bibintro\@empty
\renewcommand{\bibliofont}{\small}
\renewenvironment{thebibliography}[1]{%
  \@bibtitlestyle
  \normalfont\bibliofont \labelsep.5em\relax
  \ifx\@empty\bibintro
  \else
    \begingroup
      \settowidth{\leftmargini}{\kern\captionindent}
      \bibintro\par
    \endgroup
    \vspace{12\p@}
  \fi
  \renewcommand\theenumiv{\arabic{enumiv}}\let\p@enumiv\@empty
  \list{\@biblabel{\theenumiv}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth \advance\leftmargin\labelsep
    \usecounter{enumiv}}%
  \itemsep3\p@ plus\p@ minus\p@
  \sloppy \clubpenalty\@M \widowpenalty\clubpenalty
  \sfcode`\.=\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
\newenvironment{inchapterbibliography}[1]{%
  \@xp\section\@xp*\@xp{\bibname}%
  \normalfont\bibliofont \labelsep.5em\relax
  \renewcommand\theenumiv{\arabic{enumiv}}\let\p@enumiv\@empty
  \list{\@biblabel{\theenumiv}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth \advance\leftmargin\labelsep
    \usecounter{enumiv}}%
  \sloppy \clubpenalty\@M \widowpenalty\clubpenalty
  \sfcode`\.=\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `inchapterbibliography' environment}}%
  \endlist
}
\AtBeginDocument{%
  \def\indexchap#1{%
    \twocolumn[%
      \vskip-\topskip\vskip-\baselineskip % compensate for twocolumn fudging
      \c@secnumdepth\m@ne
      \@indextrue
      \@makechapterhead{#1}]%
    \@dropfolio
  }%
}
\def\ps@headings{\ps@empty
  \def\@evenhead{\rh@underline{\unskip
    \rlap{\thepage}\hfil {\slshape\leftmark{}{}}}}%
  \def\@oddhead{\rh@underline{\unskip
    {\slshape\rightmark{}{}}\hfil \llap{\thepage}}}%
  \let\@mkboth\markboth
  \def\partmark{\@secmark\markboth\partrunhead\partname}%
  \def\chaptermark{%
    \@secmark\markboth\chapterrunhead{}}%
  \def\sectionmark{%
    \@secmark\markright\sectionrunhead\sectionname}%
}
\def\partrunhead#1#2#3{%
  \@ifnotempty{#2}{{\@ifnotempty{#1}{#1 }#2}\@ifnotempty{#3}{. }}#3}
\let\chapterrunhead\partrunhead
\let\sectionrunhead\partrunhead
\def\ps@plain{\ps@empty
  \def\@oddhead{\rh@underline{%
    \vrule width\z@ height\headheight}}%
  \let\@evenhead\@oddhead
}
\def\rh@underline#1{\vbox to\headheight{%
  \hbox to\textwidth{\hskip\z@\@plus\textwidth\relax#1}%
  \baselineskip5\p@
  \hbox to\textwidth{\leaders \hrule\@height.5\p@\hfil}%
  \vss
}}
\headsep3pc \advance\headsep5.5pt \advance\headsep-\topskip
\newinsert\copyins
\skip\copyins=2pc
\count\copyins=999 % magnification factor, 1000 = 100%
\dimen\copyins=.5\textheight % maximum allowed per page
\def\@dropfolio{%
  \ifnum\count\copyins<\@m
    \global\count\copyins=\@m % reset to 999 in output routine
    \insert\copyins{\@parboxrestore
      \hsize\textwidth \raggedleft \normalfont\normalsize \everypar{}%
      \vss\nointerlineskip
      \vbox{\vskip-\skip\copyins
        \baselineskip=11\p@\relax % instead of 13.5
        \ialign{\hfil##\cr
          \vrule width\z@ height\skip\copyins\relax
          \rule{18\p@}{3\p@}\cr\thepage\cr}}%
    }%
  \fi
}
\def\@combinefloats{%
  \ifx \@toplist\@empty \else \@cflt \fi
  \ifx \@botlist\@empty \else \@cflb \fi
  \ifvoid\copyins \else \@cflci \fi
}
\def\@cflci{%
  \setbox\@outputbox\vbox{%
    \unvbox\@outputbox
    \vskip\skip\copyins
    \if@twocolumn \else \vskip\z@ plus\p@ \fi
    \hbox to\columnwidth{%
      \hss\vbox to\z@{\vss
        \if@twocolumn
          \if@firstcolumn \else \unvbox\copyins \fi
        \else
          \unvbox\copyins
        \fi
        }}}%
  \if@twocolumn \if@firstcolumn
    \insert\copyins{\unvbox\copyins}%
  \fi\fi
  \global\count\copyins=999 \relax
}
\def\@captionheadfont{\bfseries}
\def\@captionfont{\normalfont\Small}
\def\footnotesize{\SMALL}
\def\l@part#1#2{\@tocline{-1}{12pt plus2pt}{0pt}{}{\bfseries}{#1}{}}
\def\l@section{\@tocline{1}{3\p@\@plus\p@\@minus\p@}{1pc}{}{}}
\pagestyle{headings}
\textheight=50pc \advance\textheight 9.5\p@
\textwidth=30pc \calclayout
\endinput %
\endinput
%%
%% End of file `amstext-l.cls'.
