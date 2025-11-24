%%
%% This is file `adfathesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% adfathesis.dtx  (with options: `package')
%% 
%% adfathesis.cls  -- A LaTeX thesis style for the Australian Defence
%% Force Academy.
%% Stephen Harker
%% 
%% These macros are placed in the public domain.  They may be freely
%% transmitted, reproduced, or modified.  No rights are reserved.
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
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{adfathesis}
         [2004/04/16 \space v2.50 \space ADFA thesis class]












\newif\ifATdr@ft
\ATdr@ftfalse
\newif\ifAT@harvbib
\AT@harvbibtrue
\newif\ifATh@nours
\ATh@noursfalse
\newcommand{\ptsize}{}
\DeclareOption{draft}
   {\ATdr@fttrue
    \PassOptionsToClass{draft}{report}}
\DeclareOption{normalbib}
   {\AT@harvbibfalse}
\DeclareOption{harvard}
   {\AT@harvbibtrue}
\DeclareOption{honours}
   {\ATh@nourstrue}
\DeclareOption{10pt}{\renewcommand{\ptsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\ptsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\ptsize}{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{12pt}
\ProcessOptions\relax
\LoadClass[a4paper,\ptsize]{report}
\ifAT@harvbib\IfFileExists{harvard.sty}{\RequirePackage{harvard}}%
  {\ClassError{\filename}{%
  The Harvard package was not found.}{%
  The Harvard package controls the bibliography appearance. \MessageBreak
  \space It is used by default unless you specify the normalbib option. \MessageBreak
  \space The Harvard package can be obtained from, e.g., ctan.unsw.edu.au
  }}\fi
\setlength{\oddsidemargin}  {1.5cm}
\setlength{\evensidemargin} {-0.5cm}
\setlength{\marginparwidth} {40\p@}
\setlength{\marginparsep}   {10\p@}
\setlength{\topmargin}      {-0.6cm}
\setlength{\headheight}     {15\p@}
\setlength{\headsep}        {0.5cm}
\setlength{\textwidth}      {14.9cm}
\setlength\@tempdima{\paperheight}
\addtolength\@tempdima{-30mm}
\addtolength\@tempdima{-20mm}
\divide\@tempdima\baselineskip
\@tempcnta=\@tempdima
\setlength\textheight{\@tempcnta\baselineskip}
\addtolength\textheight{\topskip}
\setlength{\topskip}{1\topskip \@plus 1\baselineskip}
\setlength{\parskip}{0pt}
\raggedbottom
\ifcase \@ptsize \relax % 10pt
  \linespread{1.25}%
\or % 11pt
  \linespread{1.213}%
\or % 12pt
  \linespread{1.241}%
\fi
\newcommand{\displayskipstretch}{\baselinestretch}
\newcommand{\setdisplayskipstretch}[1]{\renewcommand{\displayskipstretch}{#1}}
\everydisplay\expandafter{%
  \the\everydisplay
  \abovedisplayskip \displayskipstretch\abovedisplayskip
  \belowdisplayskip \displayskipstretch\belowdisplayskip
  \abovedisplayshortskip \displayskipstretch\abovedisplayshortskip
  \belowdisplayshortskip \displayskipstretch\belowdisplayshortskip
}
\newlength{\chaprule}
\newlength{\ATchapskip}
\setlength{\chaprule}{0.4\p@}
\setlength{\ATchapskip}{10\p@}
\advance \ATchapskip by -1\chaprule
\renewcommand{\@makechapterhead}[1]{%
  \ifdim\chaprule>6\p@ \setlength{\chaprule}{6\p@}\fi
  \vspace*{\ATchapskip}%
  \noindent\rule{\textwidth}{\chaprule}\par%
  \vskip 10\p@
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
        {\Large\scshape \@chapapp\space \thechapter}
        \par\nobreak
        \vskip 8\p@
    \fi
    \interlinepenalty\@M
    \Large #1\par\nobreak
    \vskip 10\p@
    \noindent\rule{\textwidth}{\chaprule}\par%
    \vskip\ATchapskip
  }}
\renewcommand{\@makeschapterhead}[1]{%
  \ifdim\chaprule>6\p@ \setlength{\chaprule}{6\p@}\fi
  \vspace*{\ATchapskip}%
  \noindent\rule{\textwidth}{\chaprule}\par%
  \vskip 10\p@
  {\parindent \z@ \centering
    \normalfont
    \interlinepenalty\@M
    \Large #1\par\nobreak
    \vskip 10\p@
    \noindent\rule{\textwidth}{\chaprule}\par%
    \vskip\ATchapskip
  }}

\renewcommand{\section}{\@startsection{section}{1}{\z@}%
    {-1.5ex \@plus-1ex \@minus -.2ex}{0.8ex \@plus.2ex}%
    {\normalfont\large\raggedright}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
    {-1.2ex \@plus -.5ex \@minus-.2ex}{0.5ex \@plus.1ex}%
    {\normalfont\normalsize\itshape\raggedright}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
    {-1.0ex\@plus -.5ex \@minus -.2ex}{0.3ex \@plus .1ex}%
    {\normalfont\normalsize\itshape\raggedright}}
\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
    {1.0ex \@plus.5ex \@minus.2ex}{-1em}%
    {\normalfont\normalsize\itshape\raggedright}}
\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\parindent}%
    {1.0ex \@plus.5ex \@minus .2ex}{-1em}%
    {\normalfont\normalsize\itshape\raggedright}}

\renewcommand{\bibname}{References}
\def\@listi{\leftmargin\leftmargini
    \labelsep .5em%
    \labelwidth\leftmargini
    \advance\labelwidth-\labelsep
    \parsep \z@
    \topsep 0.4ex \@plus\p@
    \itemsep 0\p@ \@plus1\p@}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
    \labelsep .5em%
    \labelwidth\leftmarginii
    \advance\labelwidth-\labelsep
    \topsep 0\p@ \@plus\p@
    \parsep \z@ \@plus\p@
    \itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
    \labelsep .5em%
    \labelwidth\leftmarginiii
    \advance\labelwidth-\labelsep
    \topsep 0\p@ \@plus\p@
    \parsep \z@
    \partopsep \z@ \@plus\p@
    \itemsep \topsep}
\def\@listiv{\leftmargin\leftmarginiv
    \labelsep .5em%
    \labelwidth\leftmarginiv
    \advance\labelwidth-\labelsep
    \topsep 0\p@ \@plus\p@
    \parsep \z@
    \partopsep \z@ \@plus\p@
    \itemsep \topsep}
\def\@listv{\leftmargin\leftmarginv
     \labelsep  .5em%
     \labelwidth\leftmarginv
     \advance\labelwidth-\labelsep%
     \topsep    0\p@ \@plus\p@
     \parsep    \z@
     \itemsep   \z@ \@plus\p@}
\def\@listvi{\leftmargin\leftmarginvi
     \labelsep  .5em
     \labelwidth\leftmarginvi
     \advance\labelwidth{-\labelsep}%
     \topsep    0\p@ \@plus\p@
     \parsep    \z@
     \itemsep   \z@ \@plus\p@}
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else
   \thispagestyle{empty}
   \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\doublehyphendemerits=10000     % No consecutive line hyphens.
\brokenpenalty=4991             % Reduce broken words across columns/pages.
\widowpenalty=9999              % Almost no widows at bottom of page.
\clubpenalty=9996               % Almost no orphans at top of page.
\interfootnotelinepenalty=9999  % Almost never break footnotes.
\predisplaypenalty=10000        % Default value
\postdisplaypenalty=1549        % Few breaks between display and widows
\displaywidowpenalty=1602       % At least as high as \postdisplaypenalty
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
\renewenvironment{table}
               {\setlength{\abovecaptionskip}{0\p@}
                \setlength{\belowcaptionskip}{10\p@}
                \linespread{1}\normalfont\small\@float{table}}
               {\end@float}
\renewenvironment{table*}
               {\setlength{\abovecaptionskip}{0\p@}
                \setlength{\belowcaptionskip}{10\p@}
                \linespread{1}\normalfont\small\@dblfloat{table}}
               {\end@dblfloat}
\renewenvironment{figure}
               {\linespread{1}\normalfont\small\@float{figure}}
               {\end@float}
\renewenvironment{figure*}
               {\linespread{1}\normalfont\small\@dblfloat{figure}}
               {\end@dblfloat}
\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}
\def\onecaptflag{268 }
\renewcommand{\@makecaption}[2]{\let\@tempa\relax
   \ifdim\prevdepth>-99\p@ \vskip\abovecaptionskip \relax
   \else \def\@tempa{\vbox to\topskip{}}\fi
   {#1: }\@tempa \vadjust{\penalty \onecaptflag}%
   #2\@finalstrut\strutbox\par
   \ifnum\lastpenalty=\onecaptflag % single line; centre it
      \unpenalty \setbox\@tempboxa\lastbox
      \nointerlineskip
      \hbox to\hsize{\hskip\parfillskip\unhbox\@tempboxa}%
   \fi \vskip\belowcaptionskip}
\renewcommand{\thefigure}{\thechapter.\@arabic\c@figure}
\renewcommand{\thetable}{\thechapter.\@arabic\c@table}
\renewcommand{\theequation}{\thechapter.\@arabic\c@equation}
\renewcommand{\@footnotetext}[1]{\insert\footins{%
    \linespread{1}\normalfont\footnotesize%
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}

\renewcommand{\@mpfootnotetext}[1]{%
  \global\setbox\@mpfootins\vbox{%
    \unvbox \@mpfootins
    \linespread{1}\normalfont\footnotesize%
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
       \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
   \color@endgroup}}
\newcommand{\dept}[1]{\gdef\@dept{#1}}
\newcommand{\thesistype}[1]{\gdef\@thesistype{#1}}
\newcommand{\degreetype}[1]{\gdef\@degreetype{#1}}
\newcommand{\principaladviser}[1]{\gdef\@principaladviser{#1}}
\newcommand{\advis@r}{Adviser}
\newcommand{\principaladvisor}[1]{\gdef\@principaladviser{#1}%
        \gdef\advis@r{Advisor}}
\newcommand{\firstreader}[1]{\gdef\@firstreader{#1}}
\newcommand{\secondreader}[1]{\gdef\@secondreader{#1}}
\newcommand{\submitdate}[1]{\gdef\@submitdate{#1}}
\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1}} % \author, \title
                                                         % in report

\renewcommand{\@title}{}
\renewcommand{\@author}{}
\newcommand{\@dept}{Physics}
\newcommand{\@thesistype}{Doctor of Philosophy}
\newcommand{\@degreetype}{Science}
\newcommand{\@principaladviser}{}
\newcommand{\@firstreader}{}
\newcommand{\@secondreader}{}
\newcommand{\@submitdate}{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\ifnum\month=12
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \newcommand{\@copyrightyear}{\number\the\year}
\fi

\newif\ifcopyright
\newif\iffigurespage
\newif\iftablespage
\copyrighttrue
\figurespagetrue
\tablespagetrue
\newcommand{\authornameonly}[1]{\gdef\Authornameonly{#1}}
\newcommand{\titlep}{%
        \pagestyle{empty}%
        \null\vskip2.5cm%
        \begin{center}
                {\rmfamily\Large\uppercase\expandafter{\@title}}
        \end{center}
        \vfill
        \begin{center}
                \textsc{A thesis submitted for the degree of \\
                \expandafter{\@thesistype}}
        \end{center}
        \vfill
        \begin{center}
                {\rmfamily\normalsize By\\
                \@author}\\
        \end{center}
        \vfill
        \begin{center}  % Department changed to School July 1995
                {\rmfamily\normalsize School of \expandafter{\@dept},\\
                University College, \\
                The University of New South Wales, \\
                Australian Defence Force Academy.} \\
                \vskip1cm
                {\rmfamily\normalsize \@submitdate}\\
        \end{center}
        \vskip1cm
        \newpage}
\ifATh@nours\renewcommand{\titlep}{%
        \pagestyle{empty}%
        \null\vskip2.5cm%
        \begin{center}
                {\rmfamily\Large\uppercase\expandafter{\@title}}
        \end{center}
        \vfill
        \begin{center}
                {\rmfamily\normalsize \@author}\\
        \end{center}
        \vskip1cm
        \begin{center}  % Department changed to School July 1995
                {\rmfamily\normalsize School of \expandafter{\@dept},\\
                University College, \\
                The University of New South Wales, \\
                Australian Defence Force Academy.} \\
                \vskip1cm
                {\rmfamily\normalsize \@submitdate}\\
        \end{center}
        \vfill
        \begin{center}
                \small\textsc{Submitted in partial fulfillment of the
                requirements of the degree of \\
                Bachelor of \expandafter{\@degreetype} with Honours}
        \end{center}
        \newpage}\fi

\newcommand{\copyrightpage}{%
        \null\vfill
        \begin{center}
                {\Large\copyright\ Copyright \@copyrightyear\\
                by\\
                \@author}\\
        \end{center}
        \vfill\newpage}

\newcommand{\declaration}{%
\newpage
\null\vfill
\begin{center}
\begin{minipage}{11cm}
\setlength{\parindent}{0\p@}
\setlength{\parskip}{2ex \@plus0.5ex}
{\rmfamily\normalsize

I hereby declare that this submission is my own work and to the best
of my knowledge it contains no material previously published or
written by another person, nor material which to a substantial extent
has been accepted for the award of any other degree or diploma at UNSW
or any other educational institution, except where due acknowledgement
is made in the thesis. Any contribution made to the research by
colleagues, with whom I have worked at UNSW or elsewhere, during my
candidature, is fully acknowledged.

I also declare that the intellectual content of this thesis is the
product of my own work, except to the extent that assistance from
others in the project's design and conception or in style,
presentation and linguistic expression is acknowledged.}
\par
\vspace{2.5cm}
\mbox{}\hfill\Authornameonly
\end{minipage}
\end{center}
\vfill\null
\addcontentsline{toc}{chapter}{Declaration}}
\newcommand{\beforepreface}{%
        \pagestyle{empty}
        \titlep
        \if@twoside\cleardoublepage\fi
        \pagenumbering{roman}
        \ifATdr@ft\pagestyle{draft}\else\pagestyle{plain}\fi
        \setcounter{page}\@ne% Reset the page number to 1, i.e. titlepage is page 0
        \ifcopyright\copyrightpage\fi
        }

\newcommand{\prefacesection}[1]{%
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}}

\newcommand{\afterpreface}{%
        \if@twoside
          \cleardoublepage
          \else\newpage
        \fi
        \tableofcontents
        \if@twoside
           \cleardoublepage
           \else\newpage
        \fi
        \iftablespage
                {\addvspace{10\p@}
                \let\saveaddvspace=\addvspace
                \def\addvspace##1{}
                \listoftables
                \let\addvspace=\saveaddvspace}
                \if@twoside
                  \cleardoublepage
                  \else\newpage
                \fi
        \fi
        \iffigurespage
                {\addvspace{10\p@}
                \let\saveaddvspace=\addvspace
                \def\addvspace##1{}
                \listoffigures
                \let\addvspace=\saveaddvspace}
                \if@twoside
                  \cleardoublepage
                  \else\newpage
                \fi
        \fi
        \pagenumbering{arabic}
        \ifATdr@ft\pagestyle{draft}\else\pagestyle{plain}\fi}
\newcommand{\ps@draft}{%\let\@mkboth\@gobbletwo
     \renewcommand{\@oddfoot}{\@empty}%
     \renewcommand{\@oddhead}{\rmfamily\slshape\today\hfil\thepage}%
     \renewcommand{\@evenhead}{\rmfamily\slshape\thepage\hfil\today}%
     \renewcommand{\@evenfoot}{\@oddfoot}}
\pagestyle{plain}
\newlength{\@chapwidth}%
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \settowidth{\@chapwidth}{\appendixname}% not \@chapapp
    \addtolength{\@chapwidth}{\@pnumwidth}
    \setlength\@tempdima{\@chapwidth}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \normalfont
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
       \refstepcounter{chapter}%
       \typeout{\@chapapp\space\thechapter.}%
       \addcontentsline{toc}{chapter}%
       {\protect\numberline{\expandafter\@chapapp\space\thechapter}#1}%
    \else
       \addcontentsline{toc}{chapter}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%
    \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
    \else
    \@makechapterhead{#2}%
    \@afterheading
    \fi}
\endinput
%%
%% End of file `adfathesis.cls'.
