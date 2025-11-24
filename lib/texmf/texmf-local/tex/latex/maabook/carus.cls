%%
%% This is file `carus.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% carus.dtx 
%% This is a generated file.
%% 
%% Copyright 2018, 2019, 2022 American Mathematical Society.
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
\NeedsTeXFormat{LaTeX2e}[2016/03/31]
\ProvidesClass{carus}[2025/02/24 v1.05]
\DeclareOption{6x9}{%
    \ClassWarning{carus}{%
        6x9 trim size is not supported. Using default size 5.5x8.5.
    }
}
\DeclareOption{7x10}{%
    \ClassWarning{carus}{%
        7x10 trim size is not supported. Using default size 5.5x8.5.
    }
}
\DeclareOption{11pt}{%
    \ClassWarning{carus}{%
        11pt is not supported. Using default size 10.
    }
}
\PassOptionsToPackage{monograph,smallbook}{amscip}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{maabook}}
\ProcessOptions\relax
\LoadClass[5.5x8.5]{maabook}[2018/07/17]
\def\titlepage@series{The Carus Mathematical Monographs}
\def\maa@seriesfontsize{\fontsize{11}{13}}
\def\@typesizes{%
    \do{5}{6}%          \Tiny
    \do{6}{7}%          \tiny
    \do{7}{8}%          \SMALL
    \do{8}{10}%         \Small
    \do{9}{11}%         \small
    \do{10}{13}%        \normalsize
    \do{12}{14}%        \large
    \do{14}{18}%        \Large
    \do{17}{22}%        \LARGE
    \do{20}{25}%        \huge
    \do{25}{30}%        \Huge
}%

\def\do{\noexpand\or}
\xdef\@typesizes{\@typesizes}

\normalsize
\def\verbatim@font{\normalfont\sffamily}
\def\ams@heading@font{\normalfont}
\def\tocsection#1#2#3{%
    \leavevmode
    \@ifundefined{wd@tocindent@\@toclevel}{%
        \@namexdef{wd@tocindent@\@toclevel}{0pt}%
    }{}%
    \@ams@emptyfalse
    \ifnum\@toclevel<\@ne
        \ams@measure{#2}%
    \else
        \ifdim\@nameuse{wd@tocindent@\@toclevel}=\z@
            \@namexdef{wd@tocindent@\@toclevel}{2em}%
        \fi
    \fi
    \if@ams@empty\else
        \ifnum\@toclevel<\@ne
            \ignorespaces#1 #2\unskip\enskip
        \else
            \@tempdima\@nameuse{wd@tocindent@\@toclevel}
            \hbox to \@tempdima{%
                \ignorespaces
                #2\unskip\hfil
            }%
        \fi
    \fi
    #3%
}
\def\l@part         {\@tocline{-1}{12pt plus2pt}{0pt}{}{\bfseries}}
\def\l@chapter      {\@tocline{0}{8pt plus1pt}{0pt}{}{\bfseries}}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2
        \refstepcounter{part}%
        \addcontentsline{toc}{part}{%
            \protect\tocpart{\partname}{\thepart}{#1}%
        }%
    \else
        \addcontentsline{toc}{part}{\protect\tocpart{}{}{#1}}%
    \fi
    \markboth{}{}%
    \begingroup
        \centering
        \interlinepenalty \@M
        \normalfont
        \ifnum \c@secnumdepth >-2\relax
            \huge\bfseries
            \partname\nobreakspace\thepart
            \par
            \vskip 20\p@
        \fi
        \Huge\bfseries#2\par
    \endgroup
}
\def\@spart#1{%
    \begingroup
        \centering
        \interlinepenalty \@M
        \normalfont
        \Huge\bfseries#1\par
    \endgroup
}
\def\@makechapterhead#1{%
    \vspace*{30\p@}%
    \begingroup
        \parindent\z@
        \raggedright
        \interlinepenalty\@M
        \normalfont
        \bfseries
        \ifnum\c@secnumdepth>\m@ne
            \Large
            \chaptername\space
            \Huge
            \thechapter\par
            \nobreak
            \vskip 6\p@
        \fi
        \huge #1\par
    \endgroup
    \bb@space 4.5pc
}
\maa@chaps@sink36bp

\def\@makeschapterhead#1{%
    \begingroup
        \null
        \vskip\maa@chaps@sink
        \parindent\z@
        \raggedright
        \normalfont
        \interlinepenalty\@M
        \huge \bfseries #1\par
    \endgroup
    \bb@space* 4.5pc
}
\def\section{%
    \@startsection{section}%
        {1}%
        \z@
        {-3pc\@minus-0.6pc}%
        {1.3ex \@plus.1ex}%
        {\normalfont\Large\bfseries}%
}
\def\subsection{%
    \@startsection{subsection}%
        {2}%
        \z@
        {-2pc\@minus-0.4pc}%
        {1ex \@plus .1ex}%
        {\normalfont\large\bfseries}%
}
\def\subsubsection{%
    \@startsection{subsubsection}%
        {3}
        \z@
        {-2pc\@minus-0.4pc}%
        {1ex \@plus .1ex}%
        {\normalfont\normalsize\bfseries}%
}
\def\paragraph{%
    \@startsection{paragraph}%
        {4}%
        \z@
        {2pc\@minus0.4pc}%
        {-1em}%
        {\normalfont\normalsize\bfseries}%
}
\def\subparagraph{%
    \@startsection{subparagraph}%
        {5}
        \parindent
        {2pc\@minus0.4pc}%
        {-1em}%
        {\normalfont\normalsize\itshape}%
}
\setlength\textfloatsep{13\p@ \@plus 2\p@ \@minus 2\p@}
\renewcommand\topfraction{.95}          % was .7
\setcounter{bottomnumber}{2}            % was  1
\setcounter{totalnumber}{4}             % was  3
\renewcommand\textfraction{.1}          % was .2
\renewcommand\floatpagefraction{.75}    % was .5
\renewcommand\dbltopfraction{.95}       % was .7
\renewcommand\dblfloatpagefraction{.75} % was .5
\def\@captionfont{\normalfont\small}
\def\@captionheadfont{\normalfont\bfseries}
\def\bibliofont{\normalsize}
\def\indexchap#1{%
    \global\topskip 7.5pc
    \twocolumn[{%
        \begingroup
            \null
            \vskip\maa@chaps@sink
            \vskip\baselineskip
            \parindent\z@
            \raggedright
            \normalfont
            \interlinepenalty\@M
            \huge \bfseries #1\par
            \endgroup
        \global\topskip 34\p@
        \ifx\indexintro\@empty \else
            \begingroup
                \normalsize
                \skip@\topskip
                \advance\skip@ -\baselineskip
                \vskip\skip@
                \parbox[t]{24pc}{\normalfont\indexintro\par}%
            \endgroup
            \global\topskip 24\p@
        \fi
    }]%
}
\paperwidth  5.5in
\paperheight 8.5in
\textheight=42pc
\textwidth=25pc
\headheight=7.5pt
\headsep=2pc
\topskip=10pt
\parindent=1pc
\calclayout
\pagestyle{headings}
\pagenumbering{arabic}
\endinput
%%
%% End of file `carus.cls'.
