% $Id: umich-thesis.cls,v 1.20 2004/03/12 19:56:55 kleb Exp $
%
%  Copyright (C) 1997,2004 by Bil.Kleb@NASA.Gov
%  This software is released under the terms of the LaTeX Project
%  public license.
%
%  A LaTeX2e class to create a University of Michigan dissertation
%  according to the Rackham dissertation handbook.
%
%  This basic approach is to load the LaTeX2e book class, make
%  modifications, and make use of various standard LaTeX2e packages.
%
%  To use:  \documentclass{umich-thesis}
%
%  If you need help using LaTeX, try a Google 'groups' search
%  on comp.text.tex; and while you wait, explore the TeX User
%  Group's frequently asked questions site last seen at
%  http://www.tex.ac.uk/cgi-bin/texfaq2html.  If both of these
%  fail to solve your problem, read
%
%    http://www.tex.ac.uk/cgi-bin/texfaq2html?label=askquestion
%
%  and post a question to news:comp.text.tex
%
%  For help specific to this class, email me but please try to use
%  the options above first.
%
%  Wish list:
%
%  o dissallow openright, twocolumn, twoside options for book class
%
%  o add internal hook to change chapter styles consistently
%
%  o produce list of appendices, etc. only if there are two or more
%    items.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\ProvidesClass{umich-thesis}[2004/03/12 v1.20 University of Michigan thesis class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}%
                \typeout{Unknown option, passing ``\CurrentOption"
                         option on to the standard LaTeX2e book class.}}
\ProcessOptions

\LoadClass[12pt,oneside,openany]{book}

\RequirePackage[left=1.5in,body={6in,9in}]{geometry}% page layout
\RequirePackage{setspace}% for \doublespacing and \singlespacing
\RequirePackage{placeins}% clear floats before starting new sections

% new logical variables
\newif\if@appendix \@appendixfalse
\newif\if@backmatter \@backmatterfalse

% define new fields (similar to the standard \author, \title, \date, etc.}:
\def\degree#1{\gdef\@degree{#1}}
\def\department#1{\gdef\@department{#1}}
\def\chairperson#1{\gdef\@chairperson{#1}}
\def\committee#1{\gdef\@committee{#1}}
% use \long definitions for the following since their contents
% may be more than a single paragraph:
\long\def\frontispiece#1{\gdef\@frontispiece{#1}}
\long\def\dedication#1{\gdef\@dedication{#1}}
\long\def\acknowledgements#1{\gdef\@acknowledgements{#1}}
\long\def\preface#1{\gdef\@preface{#1}}
\long\def\abstract#1{\gdef\@abstract{#1}}
\long\def\afterword#1{\gdef\@afterword{#1}}

% warn if fields are empty:
\def\@degree{\@latex@warning@no@line{No \noexpand\degree given}}
\def\@department{\@latex@warning@no@line{No \noexpand\department given}}
\def\@chairperson{\@latex@warning@no@line{No \noexpand\chairperson given}}
\def\@committee{\@latex@warning@no@line{No \noexpand\committee given}}
\def\@frontispiece{\@latex@warning@no@line{No [optional]
    \noexpand\frontispiece defined}}
\def\@dedication{\@latex@warning@no@line{No [optional]
    \noexpand\dedication provided}}
\def\@acknowledgements{\@latex@warning@no@line{No [optional]
    \noexpand\acknowledgements given}}
\def\@preface{\@latex@warning@no@line{No [optional]
    \noexpand\preface given}}
\def\@abstract{\@latex@warning@no@line{No \noexpand\abstract given}}
\def\@vita{\@latex@warning@no@line{No [optional]
    \noexpand\vita given}}
\def\@afterword{\@latex@warning@no@line{No [optional]
    \noexpand\afterword given}}

% change/add some names:
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\chaptername}{Chapter}
\renewcommand{\appendixname}{Appendix}
\newcommand{\appendicesname}{Appendices}
\newcommand{\listappendicesname}{List of Appendices}

% change the chapter numbers to roman numerals
\renewcommand{\thechapter}{\Roman{chapter}}
% but use arabic for sections, etc.
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
\renewcommand\theequation{\@arabic\c@chapter.\@arabic\c@equation}
\renewcommand\thefigure{\@arabic\c@chapter.\@arabic\c@figure}
\renewcommand\thetable{\@arabic\c@chapter.\@arabic\c@table}

% tweak \tableofcontents, \listoffigures, \listoftables
% and add \listofappendices:
\renewcommand\tableofcontents{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\contentsname}
    {\singlespace\@starttoc{toc}}%
   \if@restonecol\twocolumn\fi
   }
\renewcommand\listoffigures{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\listfigurename}
    \addcontentsline{toc}{chapter}{\MakeUppercase\listfigurename}%
    {\singlespacing\@starttoc{lof}}%
   \if@restonecol\twocolumn\fi
   }
\renewcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.8em}}
\renewcommand\listoftables{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\listtablename}
    \addcontentsline{toc}{chapter}{\MakeUppercase\listtablename}%
    {\singlespacing\@starttoc{lot}}%
   \if@restonecol\twocolumn\fi
   }
\renewcommand*\l@table{\@dottedtocline{1}{1.5em}{2.8em}}
\def\ext@appendix{loa}
\newcommand\listofappendices{%
   \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
    \chapter*{\listappendicesname}
    \addcontentsline{toc}{chapter}{\MakeUppercase\listappendicesname}%
    {\singlespacing\@starttoc{loa}}%
   \if@restonecol\twocolumn\fi
   }
\newcommand*\l@appendix{\@dottedtocline{1}{1.5em}{2.3em}}

% modify \mainmatter to add an entry to table of contents
% that introduces the chapters and to reset the page numbering:
\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}%
  \addtocontents{toc}{%
    \vspace{1em}\vspace{1pt}%
    \hbox{\bfseries \MakeUppercase\chaptername}%
    \vspace{10pt}}%
  }

% change sections to not add info to toc if in appendix:
\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \if@appendix%
      \relax%
    \else %
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}%
    \fi%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

% set default pagestyle (Note: \chapter and other things may override this.)
\pagestyle{plain}

% define a new verion of LaTeX's raggedright to allow some hyphenation
% per Edward Tufte's book layout:
\def\um@raggedright{%
  \let\\\@centercr\@rightskip\z@ plus .1\hsize
  \rightskip\@rightskip\leftskip\z@skip}

% change LaTeX's footnotes to get vertical spacing correct
\skip\footins \baselinestretch2\skip\footins
\long\def\@footnotetext#1{%
  \insert\footins{%
    \def\baselinestretch {\setspace@singlespace}%
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth
    \@parboxrestore
    \vskip 1.2\baselineskip
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}

% Set captions in smaller font
\newcommand{\captionsize}{\footnotesize\raggedright}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\captionsize #1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    {\captionsize #1: #2\par}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

% re-define the \maketitle command to do the thesis title page:
\renewcommand{\maketitle}%
  {\begin{titlepage}%
   \null\vfil
   \begin{spacing}{1}
     \begin{center}%
       {\Large\bfseries \MakeUppercase{\@title} \par}%
       \vfil%
       by%
       \vskip .75em
       \@author \par%
       \vfil%
       {A dissertation submitted in partial fulfillment \\
        of the requirements for the degree of \\
        \@degree \\
        (\@department) \\
        in The University of Michigan \\
        \@date \par}%
      \end{center}\par
      \vfil
      \hspace{1in} Doctoral Committee: \\[2ex]
      \mbox{ }\hspace{1.5in}%
      \parbox{4.5in}{\@chairperson, Chairperson \\
                     \@committee \par}%
    \end{spacing}
    \vfil\null%
  \end{titlepage}%
   \setcounter{footnote}{0}%
   \setcounter{page}{1}%
   \global\let\thanks\relax
   \global\let\maketitle\relax
   \global\let\@thanks\@empty
   \global\let\@degree\@empty
   \global\let\@department\@empty
   \global\let\@committee\@empty
   \global\let\and\relax
   \global\let\degree\relax
   \global\let\department\relax
   \global\let\committee\relax
}


% the frontispiece
\newcommand{\makefrontispiece}%
  {\cleardoublepage%
   \thispagestyle{empty}
   \null\vskip 1in%
   \@frontispiece \par%
   \setcounter{page}{1}%
   \global\let\makefrontispiece\relax
   \global\let\frontispiece\relax
   \global\let\@frontispiece\@empty
  }

% the copyright:
\newcommand{\makecopyright}%
  {\cleardoublepage%
   \thispagestyle{empty}
   \null\vfil%
   \newdimen\@tempdimt%
   \newdimen\@tempdimb%
   \settowidth{\@tempdimt}{\@author}%
   \settowidth{\@tempdimb}{All rights reserved.}%
   \ifdim \@tempdimt<\@tempdimb%
     \@tempdimt \@tempdimb%
   \fi%
   \begin{center}
     \renewcommand{\arraystretch}{0.1}%
     \begin{tabular}{rcl}
                  & \@author                      &        \\
       \copyright & \rule[2pt]{\@tempdimt}{0.2pt} & \@date \\
                  & All rights reserved.          &
     \end{tabular}
   \end{center}%
   \vfil\null%
   \setcounter{page}{1}%
   \global\let\makecopyright\relax
  }

% the dedication:
\newcommand{\makededication}%
  {\chapter{Dedication}
   \@dedication \par%
   \global\let\makededication\relax
   \global\let\dedication\relax
   \global\let\@dedication\@empty
  }

% the acknowledgements:
\newcommand{\makeacknowledgements}%
  {\chapter{Acknowledgements}
   \@acknowledgements \par%
   \global\let\makeacknowledgements\relax
   \global\let\acknowledgements\relax
   \global\let\@acknowledgements\@empty
}

% the preface:
\newcommand{\makepreface}
  {\chapter{Preface}
   \@preface \par%
   \global\let\makepreface\relax
   \global\let\preface\relax
   \global\let\@preface\@empty
}

% the vita:
\newcommand{\makevita}
  {\chapter*{Vita}
   \@vita \par%
   \global\let\makevita\relax
   \global\let\vita\relax
   \global\let\@vita\@empty
}

% the afterword:
\newcommand{\makeafterword}
  {\chapter*{Afterword}
   \@afterword \par%
   \global\let\makeafterword\relax
   \global\let\afterword\relax
   \global\let\@afterword\@empty
}

% the abstract:
\newcommand{\makeabstract}%
  {\begin{titlepage}%
     \null
     \begin{center}%
       {\Large\bfseries\MakeUppercase{Abstract}}
       \vskip \baselineskip
       {\bfseries\MakeUppercase\@title}
       \vskip 7\p@
        by \vskip 2\p@
        \@author
     \end{center}
     \vskip 20\p@
     \noindent Chairperson: \@chairperson
     \vskip 17\p@
     \noindent \@abstract \par
   \end{titlepage}%
   \global\let\makeabstract\relax
   \global\let\abstract\relax
   \global\let\title\relax
   \global\let\author\relax
   \global\let\@abstract\@empty
   \global\let\@title\@empty
   \global\let\@author\@empty
}

% change the format of the Table of Contents by
% add dotted lines to chapter-level toc entires
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak%
         \leaders\hbox{$\m@th \mkern \@dotsep% \hfil -> core of latex.ltx's
           mu.\mkern \@dotsep mu$}\hfill%
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

% change \chapter command [book.cls] to allow indentation of first paragraph
\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \if@backmatter\thispagestyle{empty}\else\thispagestyle{plain}\fi%
  \def\baselinestretch{1}%
  \global\@topnum\z@
  \@afterindenttrue%
  \secdef\@chapter\@schapter}

% change toc behavior of chapter entries [book.cls] to
% indent them from the left
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \if@appendix%
                           \addcontentsline{loa}{chap}%
                             {\protect\numberline{%
                                 \hbox{ }\hfill%
                                 \thechapter.\hspace{1em}}%
                              #1}%
                         \else%
                           \addcontentsline{toc}{chap}%
                             {\protect\numberline{\bfseries%
                                 \hbox{ }\hfill%
                                 \thechapter.\hspace{1em}}%
                             \bfseries \MakeUppercase{#1}}%
                         \fi%
                       \else
                         \addcontentsline{toc}{chapter}{\MakeUppercase{#1}}
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{\MakeUppercase{#1}}
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{\MakeUppercase{#2}}]
                    \else
                      \@makechapterhead{\MakeUppercase{#2}}
                      \@afterheading
                    \fi}
\def\@schapter#1{\@makeschapterhead{\MakeUppercase{#1}}\@afterheading}

% add chap entry for table of contents
\newcommand*\l@chap{\@dottedtocline{1}{0.5em}{3.5em}}
% modify indentation of the rest:
\renewcommand*\l@section{\@dottedtocline{2}{5.0em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{3}{8.3em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{4}{12.5em}{4.1em}}
\renewcommand*\l@paragraph{\@dottedtocline{5}{15.7em}{5em}}
\setcounter{tocdepth}{3}% default is 2

% change \@makechapterhead to center chapter 
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \centering%
        \large\bfseries\MakeUppercase\@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \centering%
    \Large \bfseries #1\par\nobreak
    \vskip 40\p@
  }}

% similar for chapter*'s:
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \centering%
    \Large \bfseries\MakeUppercase{#1}\par\nobreak
    \vskip 40\p@
  }}

% redefine \appendix command to produce title page, change counter
% styles, and add entries to table of contents 
\renewcommand{\appendix}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
  \bgroup%
    \null\vfil
    \centering
    \Large \bfseries \MakeUppercase\appendicesname\par
    \addcontentsline{toc}{chapter}{\MakeUppercase\appendicesname}%
    \vfil\newpage
  \egroup%
  \if@twoside\null\thispagestyle{plain}\newpage\fi
  \if@tempswa\twocolumn\fi
  \setcounter{chapter}{0}%
  \@appendixtrue
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}
  \renewcommand\thesection{\thechapter.\@arabic\c@section}
  \renewcommand\theequation{\thechapter.\@arabic\c@equation}
  \renewcommand\thefigure{\thechapter.\@arabic\c@figure}
  \renewcommand\thetable{\thechapter.\@arabic\c@table}
  \renewcommand\thefootnote{\thechapter\@arabic\c@footnote}
}

% change section command to revert to single spacing and to include
% the \FloatBarrier command from the placeins package so figures at
% least stay near the section they are referenced.
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\FloatBarrier%
                                    \def\baselinestretch{1}%
                                    \reset@font\Large\bfseries}}

% change the rest to have single spacing
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                       {-3.25ex\@plus -1ex \@minus -.2ex}%
                                       {1.5ex \@plus .2ex}%
                                       {\def\baselinestretch{1}%
                                        \normalfont\large\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                          {-3.25ex\@plus -1ex \@minus -.2ex}%
                                          {1.5ex \@plus .2ex}%
                                          {\def\baselinestretch{1}%
                                           \normalfont\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                      {3.25ex \@plus1ex \@minus.2ex}%
                                      {-1em}%
                                      {\def\baselinestretch{1}%
                                       \normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                         {3.25ex \@plus1ex \@minus .2ex}%
                                         {-1em}%
                                         {\def\baselinestretch{1}%
                                          \normalfont\normalsize\bfseries}}

% add a contents line for the bibliography and
% single-spaced entries
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname}
      \addcontentsline{toc}{chapter}{\MakeUppercase\bibname}%
      \begin{singlespace}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist\end{singlespace}}

% turn off page numbering for backmatter
\renewcommand\backmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \@backmattertrue
  \pagestyle{empty}
  }

% turn on `doublespacing' [setspace]
\AtBeginDocument{\doublespacing\um@raggedright}

% be sure to end with an even number of pages:
\AtEndDocument{\if@openright\cleardoublepage\else\clearpage\fi}
