%%
%% This is file `mcl-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mcl-l.dtx 
%% 
%% This is a generated file.
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
%% Copyright 2006, 2009, 2012-2014 American Mathematical Society.
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
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mcl-l}[2014/10/01 v0.97 Math Circles Library Author Class]
\providecommand\@classname{mcl-l}
\newif\if@amsrefs \@amsrefsfalse
\DeclareOption{amsrefs}{\@amsrefstrue}
\newif\if@LCheads \@LCheadsfalse
\DeclareOption{LCheads}{\@LCheadstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions\relax
\LoadClass[11pt]{amsbook}[2009/07/02]
\if@amsrefs
  \RequirePackage{amsrefs}\relax
\fi
\def\ps@headings{\ps@empty
  \def\@evenhead{%
    \setTrue{runhead}%
    \normalfont\small
    \rlap{\thepage}\hfil
    \def\thanks{\protect\thanks@warning}%
    \leftmark{}{}}%
  \def\@oddhead{%
    \setTrue{runhead}%
    \normalfont\small
    \def\thanks{\protect\thanks@warning}%
    \rightmark{}{}\hfil \llap{\thepage}}%
  \let\@mkboth\markboth
  \def\partmark{\@secmark\markboth\partrunhead\partname}%
  \def\chaptermark{%
    \@secmark\markboth\chapterrunhead{}}%
  \def\sectionmark{%
    \@secmark\markright\sectionrunhead\sectionname}%
}
\def\ps@plain{\ps@empty
  \def\@oddfoot{\normalfont\scriptsize \hfill\thepage}%
  \def\@evenfoot{\normalfont\scriptsize \thepage\hfill}%
}
\def\specialpart#1{%
  \cleardoublepage \thispagestyle{empty}%
  \begingroup \flushright
    \hsize24pc
    \vspace*{11.5pc}
    \fontsize{\@xxvpt}{30}\bfseries
    \leavevmode #1\par
  \endgroup
  \newpage\thispagestyle{empty}%
}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax \refstepcounter{part}%
    \addcontentsline{toc}{part}{\partname\ \thepart.
        \protect\enspace\protect\noindent#1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \begingroup
    \ifnum \c@secnumdepth >-2\relax
       {\fontsize{\@xxpt}{24}\bfseries
         \partname\ \thepart} \vskip 20\p@
    \fi
    \flushright
    \fontsize{\@xxvpt}{30}\bfseries
      #1\vfil\vfil
  \endgroup
  \newpage\thispagestyle{empty}%
}
\def\@spart#1{%
  \begingroup \c@secnumdepth=-2 \@part[#1]{#1}\endgroup
}
\def\partrunhead#1#2#3{%
  \@ifnotempty{#2}{\uppercase{\ignorespaces#1 #2\unskip}\@ifnotempty{#3}{. }}%
  \def\@tempa{#3}%
  \ifx\@empty\@tempa\else
    \begingroup \def\\{\unskip\space\ignorespaces}%
      \if@LCheads \@tempa
      \else \uppercasenonmath\@tempa\@tempa
      \fi
    \endgroup
  \fi
}
\let\chapterrunhead\partrunhead
\let\sectionrunhead\partrunhead
\newif\if@schapter \@schapterfalse
\let\@schapterb\@schapter
\def\@schapter{\secdef\@schaptera\@schapterb}
\def\@schaptera[#1]#2{\typeout{#1}%
  \let\@secnumber\@empty
  \def\@toclevel{0}%
  \ifx\chaptername\appendixname \@tocwriteb\tocappendix{chapter}{#2}%
  \else \@tocwriteb\tocchapter{chapter}{#2}\fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makeschapterhead{#2}\@afterheading
}
\def\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}\global\@topnum\z@
  \@afterindentfalse \secdef\@chapter\@schapter}
\def\chapter@number{%
  \ifnum\c@secnumdepth>\m@ne
    \vspace{3pc}
    \normalfont\Large\bfseries
    \chaptername\enspace\thechapter
  \fi
}
\newif\if@index  \@indexfalse
\def\@chapauthorstyle{\LARGE\bfseries}%
\def\@makechapterhead#1{%
  \global\topskip 6.5pc\relax
  \begingroup
    \def\author##1{\\ \hfil \\ \@chapauthorstyle ##1}%
    \centering
    \if@schapter
      \topskip 9pc\relax
    \else
      \vbox to\topskip{%
        \chapter@number
        \vss
      }\penalty\@M
    \fi
    \huge\bfseries
    \noindent #1\par
  \endgroup
  \if@index
    \ifx\@empty\indexintro
      \vspace{3pc}%
    \else
      \vspace{3pc}%
      \begingroup \small
        \parbox[t]{27pc}{\leftskip3pc\normalfont\indexintro\par}%
      \endgroup
      \vspace{2.5pc}%
    \fi
  \else
    \vspace{3pc}%
  \fi
  \@afterheading
}
\def\@makeschapterhead#1{\begingroup
  \@schaptertrue
  \c@secnumdepth\m@ne \@makechapterhead{#1}%
  \endgroup
}
\let\indexintro\@empty
\def\section{\@startsection{section}{1}%
  \z@{-1.5\linespacing\@plus-.3\linespacing\@minus.2\linespacing}%
  {.5\linespacing}{\normalfont\large\bfseries}}
\def\subsection{\@startsection{subsection}{2}%
  \z@{-1.2\linespacing\@plus-.3\linespacing\@minus.2\linespacing}%
  {.25\linespacing}{\normalfont\normalsize\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  \z@{-1.0\linespacing\@plus-.3\linespacing\@minus.2\linespacing}%
  {.25\linespacing}{\normalfont\normalsize\bfseries}}
\def\paragraph{\@startsection{paragraph}{3}%
  \z@{-0.8\linespacing\@plus-.2\linespacing\@minus.1\linespacing}%
  {-.5em}{\normalfont\normalsize\bfseries}}
\renewcommand{\tocsection}[3]{%
  \def\\{\unskip\space\ignorespaces}%
  \ams@measure{#2}%
  \indentlabel{%
    \if@ams@empty
    \else\ignorespaces #1 #2%
         \ams@measure{#3}%
         \if@ams@empty
         \else .\quad
         \fi
    \fi
  }%
  #3%
}
\let\tocchapter\tocsection
\let\tocappendix\tocsection
\def\th@plain{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \itshape
}
\def\th@definition{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \upshape
}
\def\th@remark{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font small caps
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \upshape
}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \itemindent\z@
  \item[\hskip\labelsep\bfseries
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
\setbox\z@\hbox{\kern1.5pc 999}
\renewcommand{\@pnumwidth}{\wd\z@}
\def\@tocline#1#2#3#4#5#6#7{\relax
  \ifnum #1>\c@tocdepth % then omit
  \else
    \def\author##1{\newline\textsc{##1}}%
    \par \addpenalty\@secpenalty\addvspace{#2}%
    \begingroup \hyphenpenalty\@M
    \@ifempty{#4}{%
      \@tempdima\csname r@tocindent\number#1\endcsname\relax
    }{%
      \@tempdima#4\relax
    }%
    \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
    \rightskip\@pnumwidth plus.2\hsize \parfillskip-\@pnumwidth
    #5\leavevmode\hskip-\@tempdima #6\nobreak\relax
    \hfil\hbox to\@pnumwidth{\@tocpagenum{#7}}\par
    \nobreak
    \endgroup
  \fi
}
\AtBeginDocument{%
  \labelsep=5pt\relax
  \setcounter{enumi}{13}\setcounter{enumii}{13}%
  \setcounter{enumiii}{13}\setcounter{enumiv}{13}%
  \settowidth\leftmargini{\labelenumi\hskip\labelsep}%
%%  \verb|\advance\leftmargini by \normalparindent|
  \settowidth\leftmarginii{\labelenumii\hskip\labelsep}%
  \settowidth\leftmarginiii{\labelenumiii\hskip\labelsep}%
  \settowidth\leftmarginiv{\labelenumiv\hskip\labelsep}%
  \setcounter{enumi}{0}\setcounter{enumii}{0}%
  \setcounter{enumiii}{0}\setcounter{enumiv}{0}%
  \leftmarginv=10pt  \leftmarginvi=\leftmarginv
  \leftmargin=\leftmargini
  \labelwidth=\leftmargini \advance\labelwidth-\labelsep
  \@listi}
\newcounter{problem}
\newcounter{solution}
\thm@space@setup
\newenvironment{problem}{%
  \par\addvspace\thm@preskip
  \refstepcounter{problem}%
  \noindent\textbf{Problem \arabic{problem}.}\enskip\ignorespaces
}{%
  \par
  \addvspace\thm@postskip
}
\newenvironment{solution}{%
  \refstepcounter{solution}%
  \par\addvspace{\thm@preskip}%
  \noindent\textbf{Problem \arabic{solution}.}\enskip\ignorespaces
}{%
  \par
  \addvspace{\thm@postskip}%
}
\newenvironment{Remark}{%
  \par\addvspace{\medskipamount}
  \leftskip\normalparindent
  \small
  \noindent\hspace*{-\normalparindent}\emph{Remark.}\enskip\ignorespaces
}{%
  \par\addvspace{\medskipamount}%
}
\newcommand{\answ}[2]{
  \textbf{#1.}\enspace #2\quad
}
\newenvironment{fsl}{%
  \emph{First solution.}\enskip\ignorespaces
}{%
  \par\addvspace{\medskipamount}%
}
\newenvironment{ssl}{%
  \noindent \emph{Second solution.}\enskip\ignorespaces
}{%
  \par\addvspace{\medskipamount}%
}
\if@amsrefs
  \BibSpec{misc}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{,} { \url}                        {url}
    +{.} { }                            {note}
    +{.} {}                             {transition}
  }
  \BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
  }
  \BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{,} { }                            {journal}
    +{}  { \textbf}                     {volume}
    +{}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
    +{,} { }                            {status}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
  }
  \BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { \PrintDateB}                 {date}
    +{,} { pp.~}                        {pages}
    +{,} { }                            {status}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
  }
  \BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { Technical Report }           {number}
    +{,} { }                            {series}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{,} { \url}                        {url}
    +{.} { }                            {note}
    +{.} {}                             {transition}
  }
\fi
\def\upstrut{\noindent\vbox to \normalbaselineskip{}}
\def\downstrut{\noindent\lower.5em\vbox{}}
\def\emdash{\unskip\thinspace---\hskip.16667em\ignorespaces}
\newif\if@ams@empty
\@ams@emptyfalse
\def\ams@measure#1{%
    \begingroup
        \let\[\(\let\]\)%
        \let\stepcounter\@gobble
        \let\refstepcounter\@gobble
        \setbox\@tempboxa\hbox{\ignorespaces#1\unskip}%
    \expandafter\endgroup
    \ifdim\wd\@tempboxa=\z@
        \@ams@emptytrue
    \else
        \@ams@emptyfalse
    \fi
}
\pagestyle{headings}
\normalsize
\endinput %
\endinput
%%
%% End of file `mcl-l.cls'.
