%%
%% This is file `my-thesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ua-classes.dtx  (with options: `my-thesis')
%% 
%% Except where otherwise indicated this code was originally written
%% by, and continues to be maintained by, Marcel Oliver. It is released
%% into the public domain.
%% Where otherwise indicated, code is covered by the licensing terms of
%% the original packages.
%% The above statement was added 2009/01/05 by Clea F. Rees on behalf
%% of the author.
%%
%% File ua-classes.dtx by Marcel Oliver
%%
%% Documentation can be obtained by running "latex labels.dtx"
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my-thesis}
              [1997/03/08 My Private Thesis Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions
\LoadClass[reqno]{amsbook}[1996/10/24]
\RequirePackage{my-title}
\def\@listI{\leftmargin\leftmargini \parsep\z@skip
  \topsep\listisep \itemsep\topsep
  \listparindent\normalparindent}
\let\@listi\@listI
\numberwithin{section}{chapter}
\renewenvironment{abstract}%
  {\chapter*{Abstract}}{}
\bibliographystyle{amsplain}
\def\chapter{\cleardoublepage \pagestyle{headings}%
  \setcounter{section}0\relax
  \thispagestyle{plain}%
  \global\@topnum\z@
  \@afterindentfalse \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\refstepcounter{chapter}%
  \ifnum \c@secnumdepth <\z@ \let\thechapter\@empty\fi
  \let\@secnumber\thechapter
  \typeout{\chaptername\space\thechapter}%
  \addcontentsline{toc}{chapter}{%
    \protect\numberline{%
      \ifx\thechapter\@empty\else\chaptername\ \thechapter.\fi}#1}%
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}\@afterheading}
\def\@schapter#1{\typeout{#1}%
  \@ifnotempty{#1}{\addcontentsline{toc}{chapter}{#1}}%
  \let\@secnumber\empty
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makeschapterhead{#1}\@afterheading}
\def\@makechapterhead#1{\begingroup
  \vspace*{37pt}
   \ifodd\c@page\raggedleft\else\raggedright\fi
    \ifnum\c@secnumdepth>\m@ne
      \leavevmode
     {\Large\bfseries
              \uppercase\@xp{\chaptername}\enspace
        {\LARGE\bfseries\thechapter\par}}\skip@34\p@
                \advance\skip@-\normalbaselineskip
        \vskip\skip@ {\huge\bfseries #1\par}\fi
 \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\def\@makeschapterhead#1{%
        \vtop to 8pc{\vfill
  \ifodd\c@page\raggedleft\else\raggedright\fi
  {\huge\bfseries #1\par}%
}%\endgroup
\skip@34\p@\advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\def\section{\@startsection{section}{1}%
  \z@{-1\baselineskip\@plus-.75\baselineskip}{.5\baselineskip}%
  {\large\bfseries}}
\def\subsection{\@startsection{subsection}{2}%
  \z@{-.75\baselineskip\@plus-.5\baselineskip}{.5\baselineskip}%
  {\normalfont\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}%
   \z@{.5\baselineskip\@plus.5\baselineskip}{-5\p@}%
   {\normalfont\itshape}}
\def\th@plain{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \itshape
}
\def\th@remark{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}%
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape
}
\def\th@definition{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}%
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape
}
\renewenvironment{proof}[1][\proofname]{\par \normalfont
  \topsep6\p@\@plus6\p@ \trivlist \itemindent\z@
  \item[\hskip\labelsep\bfseries
    #1\@addpunct{.}]\ignorespaces
}{%
  \qed\endtrivlist
}
\def\@captionheadfont{\bfseries}
\def\@captionfont{\footnotesize\mdseries}
\long\def\@makecaption#1#2{%
  \setbox\@tempboxa\vbox{\color@setgroup
    \advance\hsize-2\captionindent\noindent
    \@captionfont\@captionheadfont#1\@xp\@ifnotempty\@xp
        {\@cdr#2\@nil}{.\@captionfont\upshape\enspace#2}%
    \unskip\kern-2\captionindent\par
    \global\setbox\@ne\lastbox\color@endgroup}%
  \ifhbox\@ne % the normal case
    \setbox\@ne\hbox{\unhbox\@ne\unskip\unskip\unpenalty\unkern}%
  \fi
  \ifdim\wd\@tempboxa=\z@ % this means caption will fit on one line
    \setbox\@ne\hbox to\columnwidth{\hss\kern-2\captionindent\box\@ne\hss}%
  \else % tempboxa contained more than one line
    \setbox\@ne\vbox{\unvbox\@tempboxa\parskip\z@skip
        \noindent\unhbox\@ne\advance\hsize-2\captionindent\par}%
\fi
    \addvspace\abovecaptionskip
    \moveright\captionindent\box\@ne
\relax
}
\def\ps@plain{\ps@empty
  \def\@oddfoot{\normalfont\footnotesize\bfseries \hfil\thepage\hfil}%
  \let\@evenfoot\@oddfoot}
\def\ps@headings{\ps@empty
  \def\@evenhead{\normalfont\footnotesize\bfseries
      \rlap{\thepage}\hfil \leftmark{}{}\hfil}%
  \def\@oddhead{\normalfont\footnotesize\bfseries \hfil
      \rightmark{}{}\hfil \llap{\thepage}}%
  \let\@mkboth\markboth
  \def\partmark{\@secmark\markboth\partrunhead\partname}%
  \def\chaptermark{%
    \@secmark\markboth\chapterrunhead{}}%
  \def\sectionmark{%
    \@secmark\markright\sectionrunhead\sectionname}%
}
\pagestyle{headings}
\chaptermark{}
\def\partrunhead#1#2#3{%
  \@ifnotempty{#2}{{#1 #2}\@ifnotempty{#3}{. }}%
  \def\@tempa{#3}%
  \ifx\@empty\@tempa\else\@tempa\fi}
\let\chapterrunhead\partrunhead
\let\sectionrunhead\partrunhead
\def\thebibliography#1{
  \chapter*\bibname
  \markboth{\bibname}{\bibname}%
  \normalsize\labelsep .5em\relax
  \list{\@arabic\c@enumi.}{\settowidth\labelwidth{\@biblabel{#1}}%
  \leftmargin\labelwidth
  \advance\leftmargin\labelsep
        \bibsetup\relax
        \usecounter{enumi}}\sloppy
  \clubpenalty9999 \widowpenalty\clubpenalty  \sfcode`\.\@m}
\def\theindex{\cleardoublepage
\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@ \columnsep 35pt
\def\indexchap{\@startsection
                {chapter}{1}{\z@}{8pc}{34pt}%
                {\raggedright
                \huge\bfseries}}%
 \twocolumn[\indexchap*{\indexname}]
 \@mkboth{{\indexname}}{{\indexname}}%
        \thispagestyle{plain}\let\item\@idxitem\parindent\z@
         \footnotesize\parskip\z@ plus .3pt\relax\let\item\@idxitem}
\newlength{\@subsectionindent}
\newlength{\@subsubsectionindent}
\AtBeginDocument{%
  \setlength{\@subsectionindent}{1pc}
  \addtolength{\@subsectionindent}{\csname r@tocindent1\endcsname}
  \setlength{\@subsubsectionindent}{\@subsectionindent}
  \addtolength{\@subsubsectionindent}{\csname r@tocindent2\endcsname}}
\setcounter{tocdepth}{3}
\renewcommand{\@pnumwidth}{2em}
\def\numberline#1{\hbox{#1\quad}}
\renewcommand*{\l@chapter}[2]{%
  \@tocline{0}{10pt plus4pt}{0pt}{1pc}{\bfseries}{#1}{\bfseries #2}}
\def\l@subsection{\@tocline{2}{0pt}{\@subsectionindent}{}{}}
\def\l@subsubsection{\@tocline{3}{0pt}{\@subsubsectionindent}{}{}}
\let\listoffigures\relax
\let\listoftables\relax
\endinput
%%
%% End of file `my-thesis.cls'.
