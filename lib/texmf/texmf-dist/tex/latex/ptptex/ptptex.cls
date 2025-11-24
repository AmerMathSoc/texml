\ProvidesClass{ptptex}[2008/11/20 ver.0.91 LaTeX Class file for PTP]
\newcommand{\@typeset}{\sffamily typeset using \PTPTeX.cls $\langle$Ver.0.9$\rangle$}
%%%-----------------------------------------------------------%%%
\DeclareOption{paper}{%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\normalsize{\@setsize\normalsize{13.34\p@}\xipt\@xipt
 \abovedisplayskip 10\p@ plus2\p@ minus5\p@\belowdisplayskip \abovedisplayskip
 \abovedisplayshortskip \z@ plus3\p@\belowdisplayshortskip 6\p@ plus3\p@ minus3\p@}
\normalfont \normalsize
\let\pgn@size\normalsize
\def\small{\@setsize\small{12\p@}\xpt\@xpt
 \abovedisplayskip 10\p@ plus2\p@ minus5\p@\belowdisplayskip \abovedisplayskip
 \abovedisplayshortskip \z@ plus3\p@\belowdisplayshortskip 6\p@ plus3\p@ minus3\p@
 \def\@listi{\topsep=\z@ plus 2\p@%
 \itemsep=\z@\relax}}
\def\footn@tesize{\@setsize\footnotesize{11.4\p@}\ixpt\@ixpt
 \abovedisplayskip 6\p@ plus 2\p@ minus 4\p@\belowdisplayskip \abovedisplayskip
 \abovedisplayshortskip \z@ plus 1\p@\belowdisplayshortskip 3\p@ plus 1\p@ minus 2\p@
 \def\@listi{\topsep=\z@ plus 1\p@%
 \itemsep=\z@\relax}}
\def\footnotesize{\footn@tesize}
\def\scriptsize{\@setsize\scriptsize{10\p@}\viiipt\@viiipt}
\def\tiny{\@setsize\tiny{7.5\p@}\vipt\@vipt}
\def\large{\@setsize\large{14\p@}\xiipt\@xiipt}
\def\Large{\@setsize\Large{18\p@}\xivpt\@xivpt}
\def\LARGE{\@setsize\LARGE{22\p@}\xviipt\@xviipt}
\def\huge{\@setsize\huge{25\p@}\xxpt\@xxpt}
\def\Huge{\@setsize\Huge{30\p@}\xxvpt\@xxvpt}

\def\@abstwidth{370\p@}
\def\abstsize{\@setsize\abstsize{10.2\p@}\ixpt\@ixpt}
\def\instsize{\@setsize\instsize{13.34\p@}\xipt\@xipt}
\def\tabularsize{\footnotesize} 
\def\captionsize{\footnotesize}
\def\refsize{\abstsize}
\def\hruleheight{0.4\p@}
\doublerulesep 1.3\p@
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\oddsidemargin 20\p@ \evensidemargin 20\p@
\marginparwidth .75in \marginparsep .25in
\topmargin \z@ \headheight 12\p@ \headsep 17\p@ \footskip 2\baselineskip
\textheight 598\p@%
\textwidth 400\p@%
\columnsep 14\p@ \columnseprule \z@

\parskip \z@  \parindent 20\p@
\topsep \z@
\partopsep \z@
\itemsep \z@

\footnotesep 7.7\p@

\setlength\paperheight {297mm} \setlength\paperwidth  {210mm}
%%%\normalfont \normalsize%%%Be careful about `em' specifications.
\leftmargini 2.2em
\leftmarginii 2.2em
\leftmarginiii 1.87em
\leftmarginiv 1.7em
\leftmarginv 1em
\leftmarginvi 1em
\leftmargin\leftmargini
\labelsep .5em
\labelwidth\leftmargini\advance\labelwidth-\labelsep
\parsep=\z@ 
\labelwidth\leftmargini \advance\labelwidth-\labelsep
\def\@listi{\leftmargin\leftmargini}
\def\@listii{\leftmargin\leftmarginii
 \labelwidth\leftmarginii\advance\labelwidth-\labelsep
 \topsep=4\p@ 
 \parsep=\z@ 
 \itemsep=2\p@}
\def\@listiii{\leftmargin\leftmarginiii
 \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
 \topsep=\z@
\partopsep=\z@
 \itemsep=\z@ \topsep=\z@}
\def\@listiv{\leftmargin\leftmarginiv
 \labelwidth\leftmarginiv\advance\labelwidth-\labelsep}
\def\@listv{\leftmargin\leftmarginv
 \labelwidth\leftmarginv\advance\labelwidth-\labelsep}
\def\@listvi{\leftmargin\leftmarginvi
 \labelwidth\leftmarginvi\advance\labelwidth-\labelsep}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@maketitle{\newpage%
\null \vskip -13.45\p@%
\def\hang{\par\hangindent=\z@\hangafter=1\noindent}%
\centerline{\footnotesize%
\@ifundefined{@pubinfo}{~~}{%
Progress of Theoretical Physics, \@pubinfo%
\gdef\@pubinfo{}}}%
\par \vskip 12.3\p@%
\begin{center}%
{\large\bfseries\mathversion{bold} \hang \@title}%
\@ifundefined{@subtitle}{}%
{\par\vskip 5\p@ {\large\itshape\hang \rule[.5ex]{1.7em}{\hruleheight}\ %
\@subtitle\ \rule[.5ex]{1.7em}{\hruleheight}} \gdef\@subtitle{}}%
\par\vskip 12.3\p@%
{\hang \@ifundefined{@author}{}{\@author}} \par\vskip 7.47\p@%
\@ifundefined{@inst}{}%
{\instsize\itshape \hang \@inst \gdef\@inst{}\par \vskip 11\p@}%
\end{center}%
\@ifundefined{@recdate}{}%
{\hang{\footnotesize \begin{center}(Received \@recdate{})\end{center}}%
\gdef\@recdate{}\par \vskip 5.75\p@}%
\@ifundefined{@abst}{}%
{\begingroup%
\begin{center}%
\parbox[t]{\@abstwidth}{\setlength{\parindent}{1.4em}%
\abstsize \@abst}%
\gdef\@abst{}\par%
\end{center}%
\endgroup%
\vskip10\p@}
\@ifundefined{@PTPindex}{}%
{\hang{\hskip 15\p@ {\scriptsize{\sffamily Subject Index:} \@PTPindex{}}}%
\gdef\@PTPindex{}\par \vskip 5.75\p@}%
}
%%%bibliography%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{thebibliography}[1]{\vspace{-.1\baselineskip}\refsize
\def\@secapp{\secsymbol}%
\section*{\refsize References}\vspace{-.7\baselineskip}
\list{\arabic{enumi})}{\settowidth\labelwidth{#1)}
\leftmargin\labelwidth \advance\leftmargin\parindent \advance\leftmargin\labelsep \usecounter{enumi}}
 \newcommand\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax}{\endlist}
%%%end bibliography%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
}
%%%-----------------------------------------------------------%%%
\DeclareOption{letter}{
\typeout{-----Setting Option: letter-----}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@maketitle{\newpage%
\null \vskip -13.45\p@%
\def\hang{\par\hangindent=\z@\hangafter=1\noindent}%
\centerline{\footnotesize%
\@ifundefined{@pubinfo}{~~}%
{Prog.~Theor.~Phys. \@pubinfo, Letters\gdef\@pubinfo{}}}%
\par \vskip 12.3\p@%
\begin{center}%
{\large\bfseries\mathversion{bold} \hang \@title}%
\@ifundefined{@subtitle}{}%
{\par\vskip 5\p@ {\large\itshape\hang \rule[.5ex]{1.7em}{\hruleheight}\ %
\@subtitle\ \rule[.5ex]{1.7em}{\hruleheight}} \gdef\@subtitle{}}%
\par\vskip 12.3\p@%
{\hang \@ifundefined{@author}{}{\@author}} \par\vskip 7.47\p@%
\@ifundefined{@inst}{}%
{\instsize\itshape \hang \@inst \gdef\@inst{}\par \vskip 11\p@}%
\end{center}%
\@ifundefined{@recdate}{}%
{\hang{\footnotesize \begin{center}(Received \@recdate{})\end{center}}%
\gdef\@recdate{}\par \vskip 5.75\p@}%
\@ifundefined{@abst}{}%
{\begingroup%
\begin{center}%
\parbox[t]{\@abstwidth}{\setlength{\parindent}{1.4em}%
\abstsize \@abst}%
\gdef\@abst{} \par%
\end{center}%
\endgroup%
\vskip10\p@}%
\@ifundefined{@PTPindex}{}%
{\hang{\hskip 15\p@ {\scriptsize {\sffamily Subject Index:} \@PTPindex{}}}%
\gdef\@PTPindex{}\par \vskip 5.75\p@}%
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewenvironment{thebibliography}[1]{\vspace{-.1\baselineskip}\refsize%
\def\@secapp{\secsymbol}%
\section*{\vbox{\hrule width 71pt height 7.2\p@ depth -7\p@}}
\vspace{-.7\baselineskip}%
\list{\arabic{enumi})}{\settowidth\labelwidth{#1)}%
\leftmargin\labelwidth \advance\leftmargin\parindent \advance\leftmargin\labelsep \usecounter{enumi}}%
 \newcommand\newblock{\hskip .11em plus .33em minus .07em}%
 \sloppy\clubpenalty4000\widowpenalty4000%
 \sfcode`\.=1000\relax}{\endlist}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndOfClass{%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\pubinfo[1]{\gdef\@pubinfo{#1} \gdef\@letterinfo{\pubvolno<#1>} \gdef\@letterdate{\pubmonthyear<#1>}}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ps@myheadings{\let\@mkboth\@gobbletwo%
\def\@oddhead{\hbox to \textwidth{%
\makebox[0\p@][l]{\footnotesize%
\@ifundefined{@letterdate}{}{\@letterdate}}\hfil{\itshape Letters}\hfil%
\makebox[0\p@][r]{\pgn@size\upshape\thepage}}}%
\def\@evenhead{\hbox to \textwidth{\makebox[0\p@][l]{\pgn@size\upshape\thepage}%
\hfil{\itshape Letters}\hfil\makebox[0\p@][r]{\footnotesize%
\@ifundefined{@letterinfo}{}{\@letterinfo}}}}%
\def\@oddfoot{}\def\@evenfoot{}%
\let\sectionmark\@gobble\let\subsectionmark\@gobble}%
\pagestyle{myheadings}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
}}
%%%-----------------------------------------------------------%%%
\DeclareOption{supplement}{%
\typeout{-----Setting Option: supplement-----}%
\newcommand\@supple{Progress of Theoretical Physics Supplement }%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@maketitle{\newpage%
\null \vskip -13.45\p@%
\def\hang{\par\hangindent=0\p@\hangafter=1\noindent}%
\vskip 18\p@%
\begin{center}%
{\large\bfseries\mathversion{bold} \hang \@title}%
\@ifundefined{@subtitle}{}%
{\par\vskip 5\p@ {\large\itshape\hang \rule[.5ex]{1.7em}{\hruleheight}\ %
\@subtitle\ \rule[.5ex]{1.7em}{\hruleheight}} \gdef\@subtitle{}}%
\par\vskip 12.3\p@%
{\hang \@ifundefined{@author}{}{\@author}} \par\vskip 7.47\p@%
\@ifundefined{@inst}{}%
{\instsize\itshape \hang \@inst \gdef\@inst{}\par \vskip 11\p@}%
\end{center}%
\@ifundefined{@recdate}{}%
{\hang{\footnotesize \begin{center}(Received \@recdate{})\end{center}}%
\gdef\@recdate{}\par \vskip 5.75\p@}%
\@ifundefined{@abst}{}%
{\begingroup%
\begin{center}%
\parbox[t]{\@abstwidth}{\setlength{\parindent}{1.4em}%
\abstsize \@abst}%
\gdef\@abst{} \par%
\end{center}%
\endgroup%
\vskip20\p@}}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndOfClass{%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ps@headings{\let\@mkboth\markboth%
\def\@oddhead{\hbox to \textwidth{\hfil{\footnotesize%
\@supple\@ifundefined{@pubinfo}{}{\@pubinfo}}%
\hfil\makebox[0\p@][r]{\pgn@size\upshape\thepage}}}%
\def\@evenhead{\hbox to \textwidth{\makebox[0\p@][l]{\pgn@size\upshape\thepage}%
\hfil{\footnotesize\@supple\@ifundefined{@pubinfo}{}{\@pubinfo}}%
\hfil}}}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
}}
%%%-----------------------------------------------------------%%%
\DeclareOption{preprint}{\InputIfFileExists{ptp-prep.clo}{\typeout{-----Reading ptp-prep.clo-----}}%
{\ClassError{PTPTeX}{This class file needs the file named ``ptp-prep.clo'' in case the option `preprint' is specified.}{Please ensure the file is exist in proper location.}}}
%%%-----------------------------------------------------------%%%
\DeclareOption{addenda}{\newcommand\@addenda{Addenda}
\typeout{-----Setting Option: addenda-----}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@maketitle{\newpage
\null \vskip -13.45pt
\def\hang{\par\hangindent=0pt\hangafter=1\noindent}
\centerline{\Large\bf \@addenda}%
\par \vskip 20pt
\begin{center}
{\bf \hang \@title}
\@ifundefined{@subtitle}{}%
{\par \vskip 2.5pt {\it\hang \rule[.5ex]{1.7em}{\hruleheight}\ %
\@subtitle\ \rule[.5ex]{1.7em}{\hruleheight}} \gdef\@subtitle{}}
\par\vskip 10pt
{\hang \@author} \par\vskip 3pt%
\@ifundefined{@publishedin}%
{\immediate\write20{>Warning: <publishedin> is NOT defined!!}
Write ``Prog.~Theor.~Phys.~Vol.~(Year), Page'' in 
{\tt $\backslash$publishedin}!!}
{{\hang \@publishedin}\gdef\@publishedin{}}
\par\vskip 15pt
\@ifundefined{@recdate}{}
{{\hang (Received \@recdate{})}
\gdef\@recdate{}\par \vskip 5pt}
\end{center}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndOfClass{%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\normalsize{\footn@tesize}\normalfont\normalsize
\def\small{\@setsize\small{10\p@}\viiipt\@viiipt}
\def\footnotesize{\@setsize\footnotesize{10\p@}\viiipt\@viiipt}
\def\scriptsize{\@setsize\scriptsize{7.5\p@}\vipt\@vipt}
\def\large{\@setsize\large{12.35\p@}\xpt\@xpt}
\def\Large{\@setsize\Large{13.34\p@}\xipt\@xipt}
\def\LARGE{\@setsize\LARGE{14\p@}\xiipt\@xiipt}
\def\huge{\@setsize\huge{18\p@}\xivpt\@xivpt}
\def\refsize{\@setsize\refsize{9.5\p@}\viiipt\@viiipt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
}}
%%%-----------------------------------------------------------%%%
\DeclareOption{errata}{\newcommand\@addenda{Errata}
\typeout{-----Setting Option: errata-----}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@maketitle{\newpage
\null \vskip -13.45pt
\def\hang{\par\hangindent=0pt\hangafter=1\noindent}
\centerline{\Large\bf \@addenda}%
\par \vskip 20pt
\begin{center}
{\bf \hang \@title}
\@ifundefined{@subtitle}{}%
{\par \vskip 2.5pt {\it\hang \rule[.5ex]{1.7em}{\hruleheight}\ %
\@subtitle\ \rule[.5ex]{1.7em}{\hruleheight}} \gdef\@subtitle{}}
\par\vskip 10pt
{\hang \@author} \par\vskip 3pt%
\@ifundefined{@publishedin}%
{\immediate\write20{>Warning: <publishedin> is NOT defined!!}
Write ``Prog.~Theor.~Phys.~Vol.~(Year), Page'' in 
{\tt $\backslash$publishedin}!!}
{{\hang \@publishedin}\gdef\@publishedin{}}
\par\vskip 15pt
\@ifundefined{@recdate}{}
{{\hang (Received \@recdate{})}
\gdef\@recdate{}\par \vskip 5pt}
\end{center}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndOfClass{%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\normalsize{\footn@tesize}\normalfont\normalsize
\def\small{\@setsize\small{10\p@}\viiipt\@viiipt}
\def\footnotesize{\@setsize\footnotesize{10\p@}\viiipt\@viiipt}
\def\scriptsize{\@setsize\scriptsize{7.5\p@}\vipt\@vipt}
\def\large{\@setsize\large{12.35\p@}\xpt\@xpt}
\def\Large{\@setsize\Large{13.34\p@}\xipt\@xipt}
\def\LARGE{\@setsize\LARGE{14\p@}\xiipt\@xiipt}
\def\huge{\@setsize\huge{18\p@}\xivpt\@xivpt}
\def\refsize{\@setsize\refsize{9.5\p@}\viiipt\@viiipt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Header: Other Page%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
\def\@oddhead{\hbox to \textwidth{\hfil%\itshape\rightmark\hfil
\makebox[\z@][r]{\pgn@size\upshape\thepage}}}
\def\@evenhead{\hbox to \textwidth{\makebox[\z@][l]{\pgn@size\upshape\thepage}%
\hfil}}%\itshape\leftmark\hfil
\def\@oddfoot{}\def\@evenfoot{}
\let\sectionmark\@gobble\let\subsectionmark\@gobble}
\pagestyle{myheadings}
%%%end Header: Other Page%%%%%%%%%%%%%%%%%%%%%%%%%
}}
%%%-----------------------------------------------------------%%%
\newif\if@ams \@amsfalse
\DeclareOption{AMS}{%
\IfFileExists{amsmath.sty}
  {\IfFileExists{amsbsy.sty}
    {\IfFileExists{amsgen.sty}
      {\IfFileExists{amsopn.sty}
        {\IfFileExists{amstext.sty}
          {\IfFileExists{amssymb.sty}
            {\@amstrue}
          {\ClassWarningNoLine{PTPTeX}{Cannot Locate amssymb.sty}}}
        {\ClassWarningNoLine{PTPTeX}{Cannot locate amstext.sty}}}
      {\ClassWarningNoLine{PTPTeX}{Cannot locate amsopn.sty}}}
    {\ClassWarningNoLine{PTPTeX}{Cannot locate amsgen.sty}}}
  {\ClassWarningNoLine{PTPTeX}{Cannot locate amsbsy.sty}}}
{\ClassWarningNoLine{PTPTeX}{Cannot locate amsmath.sty}}}
%%%-----------------------------------------------------------%%%
\DeclareOption{seceq}{\AtEndOfClass{%
\typeout{-----Setting Option: seceq-----}
\@addtoreset{equation}{section}
\renewcommand{\theequation}{\arabic{section}\raise.5ex\hbox{.}\arabic{equation}}
}}
%%%-----------------------------------------------------------%%%
\ExecuteOptions{paper,AMS}
\ProcessOptions
%%%-----------------------------------------------------------%%%
%%%Input AMS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\if@ams
%
%with option AMS(default), and all required files exist
%
\typeout{-----Reading AMS Package-----}
\RequirePackage{amsmath}[1997/03/20]
\interdisplaylinepenalty=100\relax
\let\mib\boldsymbol
\typeout{-----Reading AMS Symbols-----}
\RequirePackage{amssymb}[1996/11/03]
%
\else
% some/all required files are missing
%
\ClassError{PTPTeX}{AMS Package is missing}
{Some/all files of AMS-LaTeX are missing.\MessageBreak You MUST prepare AMS-LaTeX package in order to use PTPTeX.}
%
\fi
%%%End Input AMS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%-----------------------------------------------------------%%%
\RequirePackage{overcite}[1997/04/04]
\renewcommand\citeform[1]{#1)}
%%%-----------------------------------------------------------%%%
\lineskip 1\p@ \normallineskip 1\p@
\def\baselinestretch{1}
\skip\footins 9\p@ plus 4\p@ minus 2\p@
\floatsep 12\p@ plus 2\p@ minus 2\p@ \textfloatsep 20\p@ plus 2\p@ minus 4\p@
\intextsep 12\p@ plus 2\p@ minus 2\p@ \dblfloatsep 12\p@ plus 2\p@ minus 2\p@
\dbltextfloatsep 20\p@ plus 2\p@ minus 4\p@
\@fptop \z@ plus 1fil \@fpsep 8\p@ plus 2fil \@fpbot \z@ plus 1fil 
\@dblfptop \z@ plus 1fil \@dblfpsep 8\p@ plus 2fil \@dblfpbot \z@ plus 1fil
\marginparpush 5\p@ 

\@lowpenalty 51 \@medpenalty 151 \@highpenalty 301
\@beginparpenalty -\@lowpenalty \@endparpenalty -\@lowpenalty 
\@itempenalty -\@lowpenalty

\def\section{\@startsection{section}{1}{\z@}%
{13.34\p@}{13.34\p@}{\center\normalsize\bfseries\mathversion{bold}}}
\def\subsection{\@startsection{subsection}{2}{\z@}%
{7\p@}{4\p@}{\normalsize\itshape}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
{4\p@}{2.5\p@}{\normalsize\rmfamily}}

\newcommand\@secapp{\secsymbol}
\newcommand\secsymbol{\mbox{\fontsize{10}{13.34}\S}}
%%%-----------------------------------------------------------%%%
\@twosidetrue
\newcommand{\notypesetlogo}{\renewcommand\@typeset{}}
\newcommand{\PTPTeX}{\raisebox{-.2ex}{$\cal P$}\kern-.05em{$\cal T$}\kern-.18em\raisebox{-.2ex}{$\cal P$}\kern-.03em\TeX}
\newcommand\today{\ifcase\month\or January\or February\or March\or April\or May\or June\or July\or August\or September\or October\or November\or December\fi \space\number\day, \number\year}
\def\sloppy{\tolerance=9999 \hfuzz=.5\p@ \vfuzz=.5\p@}
%%--- optional setting for PTP ---
\renewcommand{\theequation}{\arabic{equation}}
%%%\def\@eqnnum{{\normalfont\normalsize (\theequation)\hspace{1em}}} 
%%%\def\tagform@#1{\maketag@@@{(\ignorespaces#1\unskip)\hspace{1em}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Followings are to make Greek Letters italic for PTP %%%%%
%%%%% "70xx are changed into "71xx                        %%%%%
\mathchardef\Gamma="7100
\mathchardef\Delta="7101
\mathchardef\Theta="7102
\mathchardef\Lambda="7103
\mathchardef\Xi="7104
\mathchardef\Pi="7105
\mathchardef\Sigma="7106
\mathchardef\Upsilon="7107
\mathchardef\Phi="7108
\mathchardef\Psi="7109
\mathchardef\Omega="710A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\labelenumi}{\arabic{enumi}.}
\renewcommand{\theenumi}{\arabic{enumi}}
\newcommand{\labelenumii}{(\alph{enumii})}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\p@enumii}{\theenumi}
\newcommand{\labelenumiii}{\roman{enumiii}.}
\renewcommand{\theenumiii}{\roman{enumiii}}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\newcommand{\labelenumiv}{\Alph{enumiv}.}
\renewcommand{\theenumiv}{\Alph{enumiv}}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\labelitemi}{$\bullet$}
\newcommand{\labelitemii}{\bfseries --}
\newcommand{\labelitemiii}{$\ast$}
\newcommand{\labelitemiv}{$\cdot$}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \labelsep\z@
                \leftmargin 1em \itemsep 10\p@ 
                \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength\arraycolsep{6\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{\hruleheight}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
%%%-----------------------------------------------------------%%%
\setcounter{secnumdepth}{3}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\thesection {\arabic{section}}
\def\thesubsection {\rmfamily\upshape \arabic{section}.\arabic{subsection}}
\def\thesubsubsection {\rmfamily \thesubsection.\arabic{subsubsection}}
%%%TOC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@pnumwidth{\ifnum\value{page}<100 1.4em \else\ifnum\value{page}<1000 1.6em \else 2.2em \fi\fi}
\newcommand\@tocrmarg{3em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{\section*{Contents\@mkboth{CONTENTS}{CONTENTS}}
 \@starttoc{toc}}
\newcommand\l@section[2]{\addpenalty{\@secpenalty} \addvspace{\z@ plus 1\p@}
\@tempdima 1.7em \begingroup
 \parindent \z@ \rightskip \@pnumwidth 
 \parfillskip -\@pnumwidth 
 \bfseries\mathversion{bold} \leavevmode \advance\leftskip\@tempdima \hskip -\leftskip #1\nobreak\hfil
\nobreak\hbox to\@pnumwidth{\hss #2}\par
 \endgroup}
\newcommand*\l@subsection{\@dottedtocline{2}{2.1em}{1.9em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{4.2em}{2.7em}}
\newcommand\listoffigures{\section*{List of Figures\@mkboth {LIST OF FIGURES}{LIST OF FIGURES}}\@starttoc{lof}}
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{\section*{List of Tables\@mkboth
 {LIST OF TABLES}{LIST OF TABLES}}\@starttoc{lot}}
\let\l@table\l@figure
%%%end TOC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Footnote No. Change%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{footnote}{0}
\renewcommand{\footnoterule}{\kern-3\p@
 \hrule width .3\columnwidth height \hruleheight \kern 2.6\p@}
\long\def\@makefntext#1{%
\parindent 1.5em\noindent \footnotesize %
\hbox to 2.5em{\hss$^{\@thefnmark}$}\hskip3\p@#1}
\gdef\@thanks{}
%% The following is a macro by S.Fujita 1995/06/06
%% to reset the footnote number properly at each page.
%% Fujita's original macro is modified such that the resetting is made on 
%% the new counter {f@@tn@te} but not on the original counter {footnote}. 
\newcounter{f@@tn@te}\setcounter{f@@tn@te}{0}%
\newcount\CurrP@ge \CurrP@ge\z@%
%%%\@ifundefined{hyperlink}%                    
%%%{\renewcommand\thefootnote{\fnsymbol{f@@tn@te})}}     %<-- if not hyperlatex
%%%{\renewcommand\thefootnote{\fnsymbol{f@@tn@te}}}      %<-- if hyperlatex
\renewcommand\thefootnote{\fnsymbol{f@@tn@te})}
\newcommand{\ftnt@page}[2]{\@tempcnta=#2 \ifnum\@tempcnta>\CurrP@ge%
\expandafter\gdef\csname @ftnt@#1\endcsname{#2}%
\CurrP@ge=\@tempcnta\fi}
\let\fo@tnote=\footnote
\long\def\f@@tnote#1{\stepcounter{f@@tn@te}\fo@tnote{#1}}
\long\def\footnote#1{%
\@tempcnta=\c@footnote%
\@ifundefined{@ftnt@\the\@tempcnta}{\f@@tnote{#1}}%
{\c@f@@tn@te\z@\f@@tnote{#1}}%
\edef\the@fn@t{\the\@tempcnta}%
{\let\the\z@ \edef\next{\write\@auxout{%
\string\ftnt@page{\the@fn@t}{\the\c@page}}}\next}}
%%since \@addtoreset{footnote}{page} does not work well
%%%end Footnote No. Change%%%%%%%%%%%%%%%%%%%%%%%%
%%%Footnote expression%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@fnsymbol#1{\ensuremath{\ifcase#1 \or *\or {*}{*} \or {*}{*}{*}\or
   \dagger \or \dagger\dagger \or \dagger\dagger\dagger \or \ddagger \or
   \ddagger\ddagger \or \ddagger\ddagger\ddagger \else \@roman{#1}\fi}}
%%%end Footnote expression%%%%%%%%%%%%%%%%%%%%%%%%
%%%Float placement%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{topnumber}{5}
\renewcommand\topfraction{0.9}
\setcounter{bottomnumber}{5}
\renewcommand\bottomfraction{0.9}
\setcounter{totalnumber}{7}
\renewcommand\textfraction{0.1}
\renewcommand\floatpagefraction{0.9}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{1}
%%%end Float placement%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Table Figure%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@tableflag}{table}
\newcommand\@makecaption[2]{\captionsize
\ifx\@captype\@tableflag\else
\ifdim\topsep=\z@\vskip0.5\baselineskip\fi \fi
 \setbox\@tempboxa\hbox{#1.\hskip.8em#2}
 \ifdim \wd\@tempboxa > \hsize
     \hangindent=1.75em {#1.\hskip.8em#2\par} 
   \else \hbox to \hsize{\hfil\box\@tempboxa\hfil} 
 \fi}
\let\@Ttabular\tabular
\renewcommand\tabular{\vskip.25\baselineskip\tabularsize\@Ttabular}
\newcounter{figure}
\renewcommand\thefigure{\@arabic\c@figure}
\def\fps@figure{htbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{Fig.\hskip.35em\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newcounter{table}
\renewcommand\thetable{\@Roman\c@table}
\def\fps@table{tbhp}
\def\ftype@table{2} 
\def\ext@table{lot}
\def\fnum@table{Table\hskip.35em\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
%%%end Table Figure%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%figurebox%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\if@figbox \@figboxtrue
\newcommand{\nofigureboxrule}{\@figboxfalse}
\newcommand{\figurebox}[2]{% #1: fig-width  #2: fig-height
\begin{center}
\if@figbox \else \fboxrule 0\p@ \fi
\fbox{\rule{0cm}{#2}\hspace{#1}}
\end{center}}
%%%end figurebox%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%maketitle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\maketitle{\par
 \begingroup
 \newpage
 \global\@topnum\z@ \@maketitle \thispagestyle{headings}\@thanks
 \endgroup
 \let\maketitle\relax
 \let\@maketitle\relax
 \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax}
%%% \@maketitle --> ptptext.clo and ptp-prep.clo
%%%end maketitle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Items in titlepage%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\title[1]{\gdef\@title{#1}}
\newcommand\subtitle[1]{\gdef\@subtitle{#1}}
\renewcommand\author[1]{\gdef\@author{#1}}
\newcommand\inst[1]{\gdef\@inst{#1}}
\newcommand\abst[1]{\gdef\@abst{#1}}
\def\pubvolno<#1,#2,#3>{#1,#2}
\def\pubmonthyear<#1,#2,#3>{#3}
\newcommand\pubinfo[1]{\gdef\@pubinfo{#1}}
\newcommand\preprintnumber[2][30mm]{\gdef\@preprtnumwidth{#1}\gdef\@preprtnum{#2}}
\newcommand\publishedin[1]{\gdef\@publishedin{#1}}
\newcommand\recdate[1]{\gdef\@recdate{#1}}
\newcommand\PTPindex[1]{\gdef\@PTPindex{#1}}
\newenvironment{abstract}
{\small \begin{center}{\bfseries Abstract\vspace{-.5em}\vspace{0\p@}}\end{center}\quotation}
{\endquotation}
%%%end Items in titlepage%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Header: First Page%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\invitedpaper{\gdef\@invited{INVITED PAPERS}}
\def\ps@headings{\let\@mkboth\markboth
\def\@oddfoot{\hfil\@typeset}
\def\@oddhead{\@ifundefined{@invited}{}{%
\fbox{\rule[-.7\p@]{\z@}{.84em}\hspace{.5\p@}\@invited}}
\hfil\pgn@size\rmfamily\thepage}}
%%%end Header: First Page%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Header: Other Page%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
\def\@oddhead{\hbox to \textwidth{\hfil\itshape\rightmark\hfil%
\makebox[\z@][r]{\pgn@size\upshape\thepage}}}
\def\@evenhead{\hbox to \textwidth{\makebox[\z@][l]{\pgn@size\upshape\thepage}%
\hfil\itshape\leftmark\hfil}}
\def\@oddfoot{}\def\@evenfoot{}
\let\sectionmark\@gobble\let\subsectionmark\@gobble}
%%%end Header: Other Page%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Section Marks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@appendixstring{Appendix}
\newcommand\@widerule{\rule[.5ex]{2em}{\hruleheight}}
\def\f@rst#1#2\@@{#1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@sect#1#2#3#4#5#6[#7]#8{%
\ifnum #2=1   % TRUE if \section{}
  \ifx\@secapp\@appendixstring%after \appendix
    \ifnum #2>\c@secnumdepth
      \def\@svsec\@empty
    \else
      \refstepcounter{#1}%
      \def\@svsec{\@secapp~\csname the#1\endcsname}%
    \fi%
    \@tempskipa #5\relax%
    \ifdim \@tempskipa>\z@%always true if section
      \begingroup %
      #6\relax%
      \xdef\t@mp{\expandafter\f@rst#8{}\@@}%
      \ifx\t@mp\@empty %\section command has empty string
        \centerline{\interlinepenalty \@M \@secapp}%
      \else%
        \@svsec \par\nobreak%
        \@hangfrom{\hskip #3\relax\@widerule\ }{%
        \interlinepenalty \@M{\mathversion{normal}\mdseries\itshape #8}\ %
        \@widerule \par%
        \nobreak \vspace{-.1\baselineskip}}%
      \fi%
      \endgroup%
      \csname #1mark\endcsname{#7}\addcontentsline%
      {toc}{#1}{%
      \ifnum #2>\c@secnumdepth
      \else%
        \protect\rmfamily \protect\numberline{\ \ %
        \csname the#1\endcsname.}\protect\hspace{.7ex}%
      \fi%
      #7}%
    \else%this part may not be used
      \def\@svsechd{#6{\hskip #3\@svsec #8}\csname #1mark\endcsname%
      {#7}\addcontentsline%
      {toc}{#1}{%
      \ifnum #2>\c@secnumdepth
      \else%
        \protect\rmfamily \protect\numberline{\ \ %
        \csname the#1\endcsname.}\protect\hspace{.7ex}%
      \fi%
      #7}}%
    \fi%
  \else%normal section
    \ifnum #2>\c@secnumdepth
      \def\@svsec\@empty
    \else
      \refstepcounter{#1}%
      \ifx\thesection\@empty%
        \def\@svsec{\@secapp \csname the#1\endcsname\hskip .8em}%
      \else%
        \def\@svsec{\@secapp \csname the#1\endcsname.\hskip .8em}%
      \fi%
    \fi%
    \@tempskipa #5\relax%
    \ifdim \@tempskipa>\z@%
      \begingroup %
      #6\relax%
      \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}%
      \endgroup%
      \csname #1mark\endcsname{#7}\addcontentsline%
      {toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else%
        \protect\numberline{\csname the#1\endcsname.}%
      \fi%
      #7}%
    \else%
      \def\@svsechd{#6{\hskip #3\@svsec #8}\csname #1mark\endcsname%
      {#7}\addcontentsline%
      {toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else%
        \protect\numberline{\@secapp \csname the#1\endcsname.}%
      \fi%
      #7}}%
    \fi%
  \fi%
\else%not section
  \ifnum #2>\c@secnumdepth
    \def\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \def\@svsec{\csname the#1\endcsname.\hskip .8em}%
  \fi%
  \@tempskipa #5\relax%
  \ifdim \@tempskipa>\z@%
    \begingroup %
    #6\relax%
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}%
    \endgroup%
    \csname #1mark\endcsname{#7}\addcontentsline%
    {toc}{#1}{%
    \ifnum #2>\c@secnumdepth \else%
      \protect\numberline{\csname the#1\endcsname.}%
    \fi%
    #7}%
  \else%
    \def\@svsechd{#6{\hskip #3\@svsec #8}\csname #1mark\endcsname%
    {#7}\addcontentsline%
    {toc}{#1}{%
    \ifnum #2>\c@secnumdepth \else%
      \protect\numberline{\csname the#1\endcsname.}%
    \fi%
    #7}}%
  \fi%
\fi
\@xsect{#5}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@ssect#1#2#3#4#5{%
  \ifx\@secapp\@appendixstring%
    \@tempskipa #3\relax
    \ifdim \@tempskipa>8\p@% Section, probably
      \stepcounter{section}
      \@tempskipa #3\relax%
      \ifdim \@tempskipa>\z@%
        \begingroup %
        #4\relax%
        \xdef\t@mp{\expandafter\f@rst#5{}\@@}%
        \ifx\t@mp\@empty %
          \centerline{\interlinepenalty \@M \@secapp}%
        \else%
          \@appendixstring \par\nobreak%
          \@hangfrom{\hskip #1\relax\@widerule\ }{%
          \interlinepenalty \@M{\mathversion{normal}\mdseries\itshape #5}\ %
          \@widerule \par%
          \nobreak \vspace{-.1\baselineskip}}%
        \fi%
        \endgroup%
      \else%
        \def\@svsechd{#4{\hskip #1\@svsec #5}}%
      \fi%
    \else
      \@tempskipa #3\relax
      \ifdim \@tempskipa>\z@
        \begingroup 
        #4\@hangfrom{\hskip #1}{\interlinepenalty \@M #5\par}\endgroup
      \else
        \def\@svsechd{#4\hskip #1\relax #5}%
      \fi
    \fi
  \else%
    \@tempskipa #3\relax
    \ifdim \@tempskipa>\z@
      \begingroup 
      #4\@hangfrom{\hskip #1}{\interlinepenalty \@M #5\par}\endgroup
    \else
      \def\@svsechd{#4\hskip #1\relax #5}%
    \fi
  \fi%
\@xsect{#3}%
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\appendix{\par
 \addtocontents{toc}{\protect\vspace{.5ex}
 \protect\numberline{{\protect\bfseries Appendix}}} 
 \setcounter{section}{0}
 \setcounter{subsection}{0}
\let\@secapp\@appendixstring
 \@addtoreset{equation}{section}
 \def\theequation{\Alph{section}\raise.5ex\hbox{.}\arabic{equation}}
 \def\thesection{\Alph{section}}
 \def\thesubsection{\rmfamily\upshape\Alph{section}.\arabic{subsection}}}
%%%end Section Marks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Eqnarray%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\eqnarray{%
  \stepcounter{equation}%
  \let\@currentlabel=\theequation
  \global\@eqnswtrue
  \global\@eqcnt\z@
  \tabskip\@centering
  \let\\=\@eqncr
  $$\halign to \displaywidth\bgroup\@eqnsel\hskip\@centering
  $\displaystyle\tabskip\z@{##}$&\global\@eqcnt\@ne
  \hfil$\displaystyle{{}##{}}$\hfil
  &\global\@eqcnt\tw@$\displaystyle\tabskip\z@{##}$\hfil
  \tabskip\@centering&\llap{##}\tabskip\z@\cr}
%%%end Eqnarray%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%small macros%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\thanks}{\footnote}
\newcommand\tocite[1]{$^{\hbox{--}}$\cite{#1}}%\cite{xx}\tocite{yy}
\def\halftext{.471\textwidth}
\def\@JLone<#1,#2>{#1}
\def\@JLtwo<#1,#2,#3>{#2}
\def\@JLyear<#1,#2,#3,#4>{#3}
\def\@JLpage<#1,#2,#3,#4>{#4}
\newcommand\JL[1]{\@JLone<#1>\ {\bfseries \@JLtwo<#1>} (\@JLyear<#1>), \@JLpage<#1>}
\def\@Jpage<#1,#2,#3>{#3}
\newcommand\andvol[1]{{\bfseries \@JLone<#1>} (\@JLtwo<#1>), \@Jpage<#1>}
\newcommand\PTP[1]{Prog.\ Theor.\ Phys.\ \andvol{#1}}
\newcommand\PTPS[1]{Prog. Theor. Phys. Suppl.\ {No. \@JLone<#1> (\@JLtwo<#1>), \@Jpage<#1>}}
\newcommand\JPSJ[1]{J.~Phys.\ Soc.\ Jpn.\ \andvol{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\PR[1]{Phys.\ Rev.\ \andvol{#1}}%Maybe deleted in future version
\newcommand\PRA[1]{Phys.\ Rev.\ A\ \andvol{#1}}
\newcommand\PRB[1]{Phys.\ Rev.\ B\ \andvol{#1}}
\newcommand\PRC[1]{Phys.\ Rev.\ C\ \andvol{#1}}
\newcommand\PRD[1]{Phys.\ Rev.\ D\ \andvol{#1}}
\newcommand\PRE[1]{Phys.\ Rev.\ E\ \andvol{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\PRL[1]{Phys.\ Rev.\ Lett.\ \andvol{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\PL[1]{Phys.\ Lett.\ \andvol{#1}}%Maybe deleted in future version
\newcommand\PLA[1]{Phys.\ Lett.\ A\ \andvol{#1}}
\newcommand\PLB[1]{Phys.\ Lett.\ B\ \andvol{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\NP[1]{Nucl.\ Phys.\ \andvol{#1}}%Maybe deleted in future version
\newcommand\NPA[1]{Nucl.\ Phys.\ A\ \andvol{#1}}
\newcommand\NPB[1]{Nucl.\ Phys.\ B\ \andvol{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\JMP[1]{J.~Math.\ Phys.\ \andvol{#1}}
\newcommand\IJMP[1]{Int.\ J.~Mod.\ Phys.\ \andvol{#1}}
\newcommand\CMP[1]{Commun.\ Math.\ Phys.\ \andvol{#1}}
\newcommand\JP[1]{J.~of Phys.\ \andvol{#1}}
\newcommand\ANN[1]{Ann.\ of Phys.\ \andvol{#1}}
\newcommand\NC[1]{Nuovo Cim.\ \andvol{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\AJ[1]{Astrophys. J.\ \andvol{#1}}
\newcommand\PRP[1]{Phys. Rep.\ \andvol{#1}}
\newcommand\JHEP[1]{J. High Energy Phys.\ \andvol{#1}}
%%%end small macros%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Old FSS Compatibility%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
%%%end Old FSS Compatibility%%%%%%%%%%%%%%%%%%%%%%
%%%For Japanese TeX varietion%%%%%%%%%%%%%%%%%%%%%
%%%\let\r@m=\rm \let\i@t=\it
%%%\ifx\gtfam\undefined
%%%\ifx\jasciikanjiskip\undefined\else %i.e., if NTT-jTeX
%%%\def\rm{\r@m\dm} \def\it{\i@t\dm}\fi
%%%\else                               %i.e., in Asci jTeX, pTeX 
%%%\def\rm{\r@m\mc} \def\it{\i@t\mc}
%%%\fi
%%%Command \mc is not defined in pTeX, no longer.
%%%end For Japanese TeX varietion%%%%%%%%%%%%%%%%%
%%%Initialize%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\mark{{}{}}
\pagenumbering{arabic}
\pagestyle{myheadings}
%%%end Initialize%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
