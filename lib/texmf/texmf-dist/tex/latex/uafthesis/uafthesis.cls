%% uafthesis.cls -- curt a.l. szuberla  1996/11/13
%% 
%%        produces a UAF approved thesis format; kludged from the
%%        std. latex2e report.cls and from ucthesis.cls; uses many
%%        features of the former and is not so complex as the
%%        latter; for my comments, see the "%%" marks
%%

%%  Edited by Matt Heavner 1999/02/05
%%        Add index (so it'll show up on the toc)
%%        Increment the version number
%%  Edited by Dana Moudry 2002/12/18

%%  Edited by Ryan Woodard 2004/8/16
%%        Made all fonts the same size so that Craven will shut up.
%%
%%  Edited by Joshua Holbrook 2010/3/08
%%        Fixed font size in title page, added "Page" headings.
%%
%%  Edited by Jesse Frey 2012/12/6
%%        Messed with the signature page some of us need longer lines

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uafthesis}
%%              [2011/04/20 v5.0 UAF thesis class]
%%              [2004/08/17 v4.9 UAF thesis class]
%%              [2002/12/18 v4.8 UAF thesis class]
%%              [1999/02/05 v4.7 UAF thesis class]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@openright
\newif\if@openbib
\newif\if@arabic
\newif\if@chapterone
\@chapteronetrue
\@arabicfalse
\@openbibfalse

% These add the "page" headings. They are placed early to ensure that
% they are the *first* item.
\addtocontents{toc}{~\hfill \textbf{Page}\par}
\addtocontents{loa}{~\hfill \textbf{Page}\par}
\addtocontents{lot}{~\hfill \textbf{Page}\par}
\addtocontents{lof}{~\hfill \textbf{Page}\par}
\addtocontents{lom}{~\hfill \textbf{Page}\par}

%% options have been reduced to what is reasonable for a uaf thesis
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{\@openbibtrue}
\DeclareOption{arabic}{\@arabictrue}
\ExecuteOptions{11pt,oneside,final,openany}
\ProcessOptions

%% too lazy to deconvolve columnar options, so hard-wired to onecolumn!
\@twocolumnfalse
\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}

%% typset the thing in 1.5ish spacing; but provide for singlespaced
%% captions; redefine to 2.0, etc. if you don't like 1.37
\renewcommand\baselinestretch{1.37}
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.37}\large\normalsize}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}

%% We need a degree!
\def\@department{Department of Physics}
\def\department#1{\gdef\@department{#1}}

%% declarations used to declare arguments needed for the 
%% construction of the front matter.  
%%   The year the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}
%%   The month the degree will be officially conferred
\def\degreemonth#1{\gdef\@degreemonth{#1}}
%%   The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}
%%   All previous degrees: one per line in chronological order
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}
%%   The number of committee members, which provides for the
%%    correct number of lines on the signature page.  INCLUDE THE
%%    CHAIR IN THIS NUMBER! 
\def\@numberofmembers{3}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}}
%%   The name of your college or school
\def\college#1{\gdef\@college{#1}}
%%   The width of committee signature lines
\def\@committeewidth{3in}
\def\committeewidth#1{\gdef\@committeewidth{#1}}
%%   The width of approval signature and date lines
\def\@approvedwidth{3.75in}
\def\approvedwidth#1{\gdef\@approvedwidth{#1}}
%%   The space between "RECOMMENDED:" and the committee signature lines
\def\@comitteespace{\hfill}
\def\comitteespace#1{\gdef\@comitteespace{#1}}
%%   The space between "APPROVED:" and the approval lines
\def\@approvedspace{\hspace{0.75in}}
\def\approvedspace#1{\gdef\@approvedspace{#1}}


%% \maketitle makes titlepage. requires all the above macros 
\def\maketitle{
{   \let\footnotesize\small
    \let\footnoterule\relax
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \setcounter{page}{2} 
    \thispagestyle{empty}
    \addcontentsline{toc}{section}{\titlename}
    \null\vfill
  \begin{center}
    {\bfseries {\expandafter\uppercase\expandafter{\@title}} \par}
    \bigskip \bigskip \medskip 
        A \par 
        \medskip 
        THESIS \par
    \bigskip \bigskip \medskip 
        Presented to the Faculty \par
        \medskip
        of the University of Alaska Fairbanks \par
    \bigskip \medskip
        in Partial Fulfillment of the Requirements \par
        \medskip
        for the Degree of \par
    \bigskip \bigskip \medskip 
    {\expandafter\uppercase\expandafter{\@degree}} \par
    \bigskip \bigskip \bigskip 
    By \par
    \bigskip 
    {\@author}, {\@prevdegrees} \par
    \bigskip \bigskip
    Fairbanks, Alaska \par
    \bigskip 
    {\@degreemonth} {\@degreeyear}
  \end{center}
    \vfill\null
\setcounter{footnote}{0}
}\newpage}

%% The \makesig macro emits a UAF-approved signature page ready for
%% your committee's signature.  requires the the \title, \author, and
%% \college macros have been defined.  (this bastard finally is
%% independant of the font you choose for the thesis!)
\def\makesig{
\setcounter{page}{1}
\thispagestyle{empty}
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\addcontentsline{toc}{section}{\signame}
\begin{center}
    {\large \bfseries {\expandafter\uppercase\expandafter{\@title}} \par}
    \bigskip \bigskip
    By \par
    \bigskip \bigskip
    {\@author} \par
    \bigskip \bigskip \medskip
\vspace{.25in}
\end{center}
RECOMMENDED:\@comitteespace
\begin{minipage}[t]{\@committeewidth}
    \rule{\@committeewidth}{.05mm}\vskip2.5ex\relax
    \rule{\@committeewidth}{.05mm}
    \vskip2.5ex\relax
    \rule{\@committeewidth}{.05mm}
    \vskip2.5ex\relax
    \ifnum \@numberofmembers = 3
    \vskip-3.5ex\relax
    \relax Advisory Committee Chair \vskip2.5ex
    \fi
    \ifnum \@numberofmembers = 4
    \rule{\@committeewidth}{.05mm}
    \vskip-1ex\relax
    \relax Advisory Committee Chair \vskip2.5ex
    \fi
    \ifnum \@numberofmembers = 5
    \rule{\@committeewidth}{.05mm}
    \vskip2.5ex\relax
    \rule{\@committeewidth}{.05mm}
    \vskip-1ex\relax
    \relax Advisory Committee Chair \vskip2.5ex
    \fi
    \ifnum \@numberofmembers = 6
    \rule{\@committeewidth}{.05mm}
    \vskip2.5ex\relax
    \rule{\@committeewidth}{.05mm}
    \vskip2.5ex\relax
    \rule{\@committeewidth}{.05mm}
    \vskip-1ex\relax
    \relax Advisory Committee Chair \vskip2.5ex
    \fi
    \rule{\@committeewidth}{.05mm}
    \vskip-1ex\relax
    \relax Chair, \@department
\end{minipage}
\bigskip \bigskip \bigskip \par
%\noindent APPROVED: \@approvedspace
\noindent APPROVED: \@approvedspace
\begin{minipage}[t]{\@approvedwidth}
    \rule{\@approvedwidth}{.05mm}
    \vskip-1ex\relax
    Dean, {\@college}
    \vskip2.5ex\relax
    \rule{\@approvedwidth}{.05mm}
    \vskip-1ex\relax
    Dean of the Graduate School
    \vskip2.5ex\relax
    \rule{\@approvedwidth}{.05mm}
    \vskip-1ex\relax
    Date
\end{minipage}
\newpage
}

%% the abstract goes here and gets its page set to 3, as req'd (note:
%% abstract and acknowledgements are frontschap's --> defined later)
\newenvironment{abstract}{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\setcounter{page}{3}\frontchap*{\abstractname}
\addcontentsline{toc}{section}{\abstractname}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% after the acknowledgements we reset to arabic page #'s if req'd
\newenvironment{acknowledgements}
{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\newpage\addcontentsline{toc}{section}{\acknowledgename}
\frontchap*{\acknowledgename}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% a page for quotes, etc. is allowed here; it is unnumbered
%%      but page counter advances
\newenvironment{quotepage}
{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\frontchap*{\relax}\thispagestyle{empty}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% just for heavner
\newenvironment{preface}
{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\newpage\addcontentsline{toc}{section}{\prefname}
\frontchap*{\prefname}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% Index (use /index in text, 
%% have \begin{nindex}\printindex\end{nindex} (after Bib)
\newenvironment{nindex}
{
%\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
%%\newpage\addcontentsline{toc}{section}{\indname}
\newpage\addcontentsline{toc}{section}{\indname}
%%\frontchap*{\prefname}
}
%%{\newpage\renewcommand{\thepage}{\arabic{page}}}

%%%%%%%%%%%%%%%
\if@twoside
    \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
      \def\chaptermark##1{%
        \markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ \fi
            ##1}}{}}%
      \def\sectionmark##1{%
        \markright {\uppercase{\ifnum \c@secnumdepth >\z@
            \thesection. \ \fi
            ##1}}}}
\else
    \def\ps@headings{%
      \let\@oddfoot\@empty
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
      \def\chaptermark##1{%
        \markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ \fi
            ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
\newcommand\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thepart          {\Roman{part}}
\renewcommand\thechapter       {\arabic{chapter}}
\renewcommand\thesection       {\thechapter.\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection .\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}
\newcommand\@chapapp{\chaptername}
\newcommand\part{\cleardoublepage
                 \thispagestyle{myheadings}%
                 \if@twocolumn
                     \onecolumn
                     \@tempswatrue
                   \else
                     \@tempswafalse
                 \fi
                 \hbox{}\vfil
                 \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}
    {\centering
     \interlinepenalty \@M
     \reset@font
     \ifnum \c@secnumdepth >-2\relax
       \normalsize\bfseries \partname~\thepart
       \par
     \fi
     \normalsize \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \reset@font
     \normalsize \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
                \hbox{}%
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{
\if@arabic\relax\else\if@chapterone\setcounter{page}{1}\else\relax\fi\fi
\@chapteronefalse
                    \if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{myheadings}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \addtocontents{lom}{\protect\addvspace{10\p@}}%
                    \addtocontents{loa}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  {\parindent \z@ \centering \reset@font
    \ifnum \c@secnumdepth >\m@ne
         \normalsize\bfseries \@chapapp{} \thechapter
         \par
       \fi
    \normalsize \bfseries #1\par
    \nobreak
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  {\parindent \z@ \centering
    \reset@font
    \normalsize \bfseries  #1\par
    \nobreak
  }}

%% here's the frontchap stuff, TOTALLY the same as a chapter, but with 
%% centered chapter title
\newcommand\frontchap{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{myheadings}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@frontchap\@sfrontchap}
\def\@frontchap[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{frontchap}%
                         \typeout{\@chapapp\space\thefrontchap.}%
                         \addcontentsline{toc}{frontchap}%
                                   {\protect\numberline{\thefrontchap}#1}%
                    \else
                      \addcontentsline{toc}{frontchap}{#1}
                    \fi
                    \frontchapmark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \addtocontents{lom}{\protect\addvspace{10\p@}}%
                    \addtocontents{loa}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makefrontchaphead{#2}]%
                    \else
                      \@makefrontchaphead{#2}%
                      \@afterheading
                    \fi}
\def\@makefrontchaphead#1{%
  {\parindent \z@ \centering \reset@font
    \ifnum \c@secnumdepth >\m@ne
         \normalsize\bfseries \@chapapp{} \thefrontchap
         \par
       \fi
    \centering \bfseries #1\par
    \nobreak
  }}
\def\@sfrontchap#1{\if@twocolumn
                   \@topnewpage[\@makesfrontchaphead{#1}]%
                 \else
                   \@makesfrontchaphead{#1}%
                   \@afterheading
                 \fi}
\def\@makesfrontchaphead#1{%
%% put these suckers at top of page
%%  \vspace*{50\p@}%
  {\parindent \z@ \centering
    \reset@font
    \begin{center}
    \normalsize \bfseries  #1\end{center}\par
    \nobreak
%%    \vskip 40\p@
  }}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {0.1ex }%
                                   {\reset@font\normalsize\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\reset@font\normalsize\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\reset@font\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\reset@font\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\reset@font\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength\leftmargin    {\leftmargini}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\arabic{enumi}}
\renewcommand\theenumii{\alph{enumii}}
\renewcommand\theenumiii{\roman{enumiii}}
\renewcommand\theenumiv{\Alph{enumiv}}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{$\m@th\bullet$}
\newcommand\labelitemii{\normalfont\bfseries --}
\newcommand\labelitemiii{$\m@th\ast$}
\newcommand\labelitemiv{$\m@th\cdot$}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item[]}
               {\endlist}
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\Alph{chapter}}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
\renewcommand\theequation{\thechapter.\arabic{equation}}
\newcounter{figure}[chapter]
\renewcommand\thefigure{\thechapter.\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand\thetable{\thechapter.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1. #2}%
  \ifdim \wd\@tempboxa >\hsize
    {\ssp#1. #2\par}
  \else
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\def\cal{\protect\pcal}
\newcommand{\pcal}{\@fontswitch{\relax}{\mathcal}}
\def\mit{\protect\pmit}
\newcommand{\pmit}{\@fontswitch{\relax}{\mathnormal}}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg {2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
  \newpage\addcontentsline{toc}{section}{\contentsname}  %added by LEif
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\uppercase{\contentsname}}{\uppercase{\contentsname}}}%
    \@chapteronetrue
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\newcommand\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \setlength\@tempdima{3em}%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \normalsize \bfseries #1\hfil \hbox to\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}
    \endgroup
  \fi}
\newcommand\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand\l@section      {\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\l@subsection   {\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand\l@paragraph    {\@dottedtocline{4}{10em}{5em}}
\newcommand\l@subparagraph {\@dottedtocline{5}{12em}{6em}}
\newcommand\listofappendices{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listappname
      \@mkboth{\uppercase{\listappname}}%
              {\uppercase{\listappname}}}%
    \@chapteronetrue
    %% get this in contents as a section
    \addcontentsline{toc}{section}{\listappname}
    \@starttoc{loa}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\newcommand\listofothermaterials{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listothermatname
      \@mkboth{\uppercase{\listothermatname}}%
              {\uppercase{\listothermatname}}}%
    \@chapteronetrue
    %% get this in contents as a section
    \addcontentsline{toc}{section}{\listothermatname}
    \@starttoc{lom}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\newcommand\listoffigures{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename
      \@mkboth{\uppercase{\listfigurename}}%
              {\uppercase{\listfigurename}}}%
    \@chapteronetrue
    %% get this in contents as a section
    \addcontentsline{toc}{section}{\listfigurename}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\newcommand\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename
      \@mkboth{\uppercase{\listtablename}}{\uppercase{\listtablename}}}%
    %% get this in contents as a section
    \@chapteronetrue
    \addcontentsline{toc}{section}{\listtablename}
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\let\l@table\l@figure
\newdimen\bibindent
\bibindent=1.5em
\newenvironment{thebibliography}[1]
     {
      \chapter*{\bibname
        \@mkboth{\uppercase{\bibname}}{\uppercase{\bibname}}
        }%
      \list{\@biblabel{\arabic{enumiv}}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \if@openbib
              \advance\leftmargin\bibindent
              \itemindent -\bibindent
              \listparindent \itemindent
              \parsep \z@
            \fi
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\arabic{enumiv}}}%
      \if@openbib
        \renewcommand\newblock{\par}
      \else
        \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
      \fi
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m
      \@pageheadingtrue
      }
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{}
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\uppercase{\indexname}}%
                        {\uppercase{\indexname}}%
                \thispagestyle{myheadings}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem  {\par\hangindent 40\p@}
\newcommand\subitem   {\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\@addtoreset{footnote}{chapter}
\long\def\@makefntext#1{%
    \parindent 1em%
    \noindent
    \hbox to 1.8em{\hss\@makefnmark}#1}

%% this little gem provides for single-spaced footnotes
\long\def\@footnotetext#1{\insert\footins{\ssp\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}

%% change names here if'n you'd rather call 'em by a different name
\newcommand\contentsname{Table of Contents}
\newcommand\signame{Signature Page}
\newcommand\titlename{Title Page}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\listothermatname{List of Other Materials}
\newcommand\listappname{List of Appendices}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\acknowledgename{Acknowledgements}
\newcommand\prefname{Preface}
\newcommand\indname{Index}

%% get bibliography in contents as a chapter (robustly)
\renewcommand\bibliography[1]{
        \newpage
                \addcontentsline{toc}{chapter}{\bibname}
\if@filesw
  \immediate\write\@auxout{\string\bibdata{#1}}\fi
  \@input@{\jobname.bbl}}
        

\newcommand\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{myheadings}
\pagenumbering{arabic}      % Arabic page numbers
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi

%% here's where we meet the page layout requirements of the grad school
\oddsidemargin 0.5in   %   Note that \oddsidemargin = \evensidemargin
   \evensidemargin 0.5in
   \marginparwidth 0pt
\marginparsep 10pt      % Horizontal space between outer margin and 
                        % marginal note
\topmargin 0.0in        %    Nominal distance from top of page to top of
                        %    box containing running head.
\headheight 12pt        %    Height of box containing running head.
\headsep 25pt           %    Space between running head and text.
\topskip = 11pt         %    '\baselineskip' for first line of page.
                        % Bottom of page:
\footskip 30pt          %    Distance from baseline of box containing
                        %    foot to baseline of last line of text.
\textheight = 8.0truein
%\advance\textheight by \topskip
\textwidth 6.0truein     % Width of text line.
                         % For two-column mode: 
\columnsep 10pt          %    Space between columns 
\columnseprule 0pt       %    Width of rule between columns.
 
%% force a raggedbottom here so page numbers at fronts o' chap's don't
%% spill over bottom margins
\raggedbottom

%% lastly, get page numbers where we want 'em (mixed top-right/bottom-
%% center) (the arabic/roman controversy is solved in each frontmatter
%% section so that separate parts can be consistently produced)
\pagestyle{myheadings}

\endinput
%% that's all she wrote
