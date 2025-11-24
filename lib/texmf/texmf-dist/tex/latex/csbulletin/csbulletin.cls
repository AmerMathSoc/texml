\ProvidesClass{csbulletin}[2008/08/05 CSTUG Bulletin class]
\ClassInfo{csbulletin}{$Id: csbulletin.cls 29 2008-08-05 19:36:49Z zw $}

% Language attributes

\def\csbul@attributes{%
\languageattribute{czech}{split}
\languageattribute{slovak}{split}}

\DeclareOption{oldcsbabel}{\def\csbul@attributes{}}

% Ignore size options (even without warning)

\DeclareOption{10pt}{}
\DeclareOption{11pt}{}
\DeclareOption{12pt}{}

% Ignore one-/twoside

\DeclareOption{oneside}{}
\DeclareOption{twoside}{}

% Ignore paper sizes

\DeclareOption{a4paper}{}
\DeclareOption{a5paper}{}
\DeclareOption{b5paper}{}
\DeclareOption{letterpaper}{}
\DeclareOption{legalpaper}{}
\DeclareOption{executivepaper}{}
\DeclareOption{landscape}{}

% Pass all global options to the "article" class

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions

\LoadClass[twoside]{article}
\RequirePackage[english,slovak,czech]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{mflogo}
\RequirePackage{ifpdf}
\RequirePackage{csbulacronym}

\csbul@attributes

% To be deleted soon
\newif\if@html

\IfFileExists{microtype.sty}{\RequirePackage
   [protrusion=false,expansion=true,stretch=8,shrink=24,step=4]{microtype}}{}

\IfFileExists{array.sty}{\RequirePackage{array}}{}

\IfFileExists{fancyvrb.sty}{\RequirePackage{fancyvrb}}{}

\IfFileExists{verbatim.sty}{\RequirePackage{verbatim}}{%
  \def\macdef{\@latexerr{Package verbatim not loaded}\verbatim}%
  \let\endmacdef\endverbatim}
% \IfFileExists{path.sty}{\RequirePackage{path}}{\let\path\verb}

\IfFileExists{SpecChar.sty}{\RequirePackage{SpecChar}\AddSpecial\-}{}

\IfFileExists{csbulobalka.sty}{\RequirePackage{csbulobalka}}{}

\ifx\mubytein\undefined
  \newcount\mubytein
  \newcount\mubyteout
  \newcount\mubytelog
\else
  \IfFileExists{csbulutf8.sty}{\RequirePackage{csbulutf8}}{}
  \IfFileExists{encxvlna.sty}{\RequirePackage{encxvlna}}{}
\fi

% The next macros must be here, otherwise the PDF mode may report strange errors

\newtoks\cislo
\newtoks\rok
\newtoks\naklad
\newtoks\@uzaverka
\newtoks\pristi@uzaverka
\newtoks\obalka

% \uzaverka DD.MM.RRRR<space or end-of-line>

\def\uzaverka #1.#2.#3 {\begingroup
  \day=#1 \month=#2 \year=#3
  \xdef\@temp{#1.\,#2.\,#3}\endgroup
  \@uzaverka\expandafter{\@temp}}

\def\set@uzaverka#1#2#3#4#5#6#7#8{\begingroup
  \year=#1#2#3#4 \month=#5#6 \day=#7#8
  \xdef\@temp{\today}\endgroup
  \@uzaverka\expandafter{\@temp}}

\def\pristi #1.#2.#3 {\begingroup
  \day=#1 \month=#2 \year=#3
  \xdef\@temp{\today}\endgroup
  \pristi@uzaverka\expandafter{\@temp}}

%=========================================== My stuff

% looseness etc.

\def\looser{\my@note{Delší}\looseness=\@ne}
\def\denser{\my@note{Kratší}\looseness=\m@ne}
\def\noh#1{\my@note{Nedělím: #1}\hbox{#1}}
\def\Unlimited{\my@note{Velmi dlouhá stránka}\enlargethispage*{100cm}}
\newcommand*\shorter[1][1]{\my@note{Zkrácená stránka}\enlargethispage{-#1\baselineskip}}
\newcommand*\Shorter[1][1]{\my@note{*Zkrácená stránka*}\enlargethispage*{-#1\baselineskip}}
\newcommand*\longer[1][1]{\my@note{Prodloužená stránka}\enlargethispage{#1\baselineskip}}
\newcommand*\Longer[1][1]{\my@note{*Prodloužená stránka*}\enlargethispage*{#1\baselineskip}}
\def\TwiceLongerPage{\my@note{*Prodloužená stránka
    (2x)*}\enlargethispage*{2\baselineskip}}
\def\ShrinkPage{\my@note{Nepatrně prodloužená stránka}\enlargethispage*{1pt}}
\def\footlonger{\enlargethispage{\footskip}}
\def\Footlonger{\enlargethispage*{\footskip}}
\def\PageBreak{\my@note{Str\'ankov\'y zlom}\newpage}
\def\my@note#1{}

\def\te{\thispagestyle{empty}}

% No hyphenation
\let\zw@semicolon\;
\def\;{\ifmmode\let\next\zw@semicolon\else\let\next\zw@noh\fi\next}
\def\zw@noh #1 {\hbox{#1} \ignorespaces}


% \tolerance macro

\def\Tolerance{\@ifstar{\s@Tolerance}{\n@Tolerance}}
\def\zw@Tolerance #1{\tolerance #1
  \ifnum\tolerance<9999 \hbadness \tolerance \else \hbadness 200 \fi}
\newcommand\s@Tolerance[1][9999]{\zw@Tolerance{#1}\advance\hbadness-1\relax}
\newcommand\n@Tolerance[1][9999]{\zw@Tolerance{#1}\relax}

% Dashes etc.

\def\minus{-}
\DeclareRobustCommand\endash{\Unskip -- \ignorespaces}
\DeclareRobustCommand\emdash{\Unskip --- \ignorespaces}
\DeclareRobustCommand\dash{\ifvmode \leavevmode \else \unskip \fi--~\ignorespaces}
\DeclareRobustCommand\hdash{\kz-\kz}

\def\Unskip{\ifvmode \leavevmode \else \unskip~\fi}

\def\enspace{\hspace{.5em}}


% \vskip multiple baselines hacked for emTeX

\newcommand*\vb[1][1]{\vspace{#1\ZW@baselineskip}}

\newskip\ZW@baselineskip
\def\set@ZW@baselineskip{\ZW@baselineskip \baselineskip
  \advance\ZW@baselineskip 10sp minus 50sp }

\AtBeginDocument{\set@ZW@baselineskip}

% Correction \vskip

\newcommand*\Vcorr{\vskip 10sp minus 50sp}


% Newlines for titles and toc

\DeclareRobustCommand\nl{\protect\p@nl}
\def\p@nl{\unskip\\\ignorespaces}
\DeclareRobustCommand\ln{\protect\p@ln}
\let\p@ln\relax
\DeclareRobustCommand\toc@nl{\let\p@nl\relax
  \def\p@ln{\unskip\\\ignorespaces}}

%=========================================== Sizes etc.

\lineskiplimit -1.1dd

\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt{11dd}
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}

\small\normalsize

\setlength\partopsep{2\p@ \@plus 1\p@ \@minus 1\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep \z@
            \topsep \z@
            \itemsep \z@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \parsep \z@
              \topsep \z@
              \itemsep \z@}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \parsep \z@
              \topsep \z@
              \itemsep \z@}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}

\renewenvironment{theindex}
               {\columnseprule \z@
                \columnsep 35\p@
                \begin{multicols}{2}[\section*{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \let\item\@idxitem}
               {\end{multicols}}
\renewcommand\@idxitem{\par\hangindent 40\p@}
\renewcommand\subitem{\@idxitem \hspace*{20\p@}}
\renewcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\renewcommand\indexspace{\par \vskip \baselineskip\relax}

\renewcommand\section
  {\@startsection{section}{1}{0pt}%
     {-22dd minus -6pt}{11dd minus 3pt}{\raggedright\normalfont\large\bfseries}}

\renewcommand\subsection
  {\@startsection{subsection}{2}{0pt}%
     {-22dd minus -6pt}{1pt minus 1pt}{\raggedright\normalfont\bfseries}}

\renewcommand\subsubsection
  {\@startsection{subsubsection}{3}{0pt}%
     {-22dd minus -6pt}{1pt minus 1pt}{\raggedright\normalfont\mdseries}}

\renewcommand\paragraph
  {\@startsection{paragraph}{4}{0pt}%
     {11dd}{-1em}{\normalfont\bfseries}}

\renewcommand\subparagraph
  {\@startsection{subparagraph}{5}{0pt}%
     {11dd}{-1em}{\normalfont\mdseries}}

\newenvironment{summary}{\ifhmode \par \fi
  \begin{otherlanguage*}{english}
  \setcounter{secnumdepth}{-1}\section{Summary:
                    \zw@englishtitle}}{\ifhmode \par \fi\end{otherlanguage*}}

\renewcommand\@seccntformat[1]{\@nameuse{the#1}.\hspace{.5em}}

\newcommand\StartPage[1][1]{\clearpage\setcounter{page}{#1}}

\renewenvironment{abstract}{\narrower \small \noindent \ignorespaces}{\ifhmode \par \fi}

\def\keywords:{\ifhmode \par \fi \smallskip \noindent\textbf{Key words:} \ignorespaces}

% ===================================================== New layout

\newdimen\left@move@box
\left@move@box=7mm

\paperwidth 148mm
\paperheight 210mm
\pdfpagewidth\paperwidth
\pdfpageheight\paperheight
\headheight \z@
\headsep \z@
\textwidth 27cc
\evensidemargin 16mm
\textheight 41\baselineskip
\advance\textheight \topskip
\topmargin 13mm
\footskip 210mm
\advance\footskip -2\topmargin
\advance\footskip -\textheight
\oddsidemargin 148mm
\advance\oddsidemargin -\evensidemargin
\advance\oddsidemargin -\textwidth
\advance\topmargin -1in
\advance\oddsidemargin -1in
\advance\evensidemargin -1in
\parskip \z@

\newdimen\zw@bul@dim
\zw@bul@dim=148mm
\advance\zw@bul@dim -1in
\advance\zw@bul@dim -\evensidemargin

\def\ps@csbul{%
  \def\@oddhead{}\let\@evenhead\@oddhead
  \def\@oddfoot{\hfill \textrm{\thepage}}%
  \def\@evenfoot{\textrm{\thepage}\hfill}}

\pagestyle{csbul}


% ============================================ for use with minitoc

\newcounter{chapter}
\def\thechapter{\arabic{chapter}}
\def\chapter{\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\stepcounter{chapter}% no references to chapters!
  \addcontentsline{toc}{chapter}%
    {\protect\numberline{\thechapter}#1}}
\def\@schapter#1{}
\AtBeginDocument{\let\chapter\undefined} % No real \chapter please!

%=============================================  heading structure
\newbox\authb@x  \newlength\autl@n
\newif\ifautkn@wn

\newtoks\konec@clanku

\global\autkn@wnfalse
\konec@clanku{}%
\def\NaKonciClanku#1{\konec@clanku\expandafter{\the\konec@clanku #1}}%
\def\author#1{\def\auth@r{#1}%
     \settowidth\autl@n{\textsc{\enspace #1\unskip\enspace}}%
       \setbox\authb@x=\vbox to 17pt{\hsize \autl@n \parindent 0pt
          \hbox to\autl@n{\vrule height 10pt depth 4pt\hss
            {\textsc{\enspace #1\unskip\enspace}}\hss\vrule
                 \vrule width 3pt height 8pt depth 7pt}
          \vskip-3pt\hrule\vss
          \advance\autl@n -3pt
          \hfill\vrule width\autl@n height 3pt}\global\autkn@wntrue}

\def\title{\def\t@tle}
\def\pdftitle{\def\pdf@title}
\def\EnglishTitle{\def\zw@englishtitle}

\def\podpis{\def\p@dpis}
\let\p@dpis\relax
\let\pdf@title\relax
\let\signature\podpis

\def\csbul@podepis{\ifx\p@dpis\relax \else
  \ifhmode \par \else \textwidth\lastskip \fi
  \nobreak\medskip
  \begin{flushright}\clubpenalty\@M \widowpenalty\@M \interlinepenalty\@M
    \itshape\p@dpis
  \end{flushright}
  \par
\fi
\global\let\p@dpis\relax}

\AtEndDocument{\csbul@podepis}

\def\titlepenalty{-100}

\renewcommand\maketitle[1][\z@]{%
     \vskip 3cc\vskip 0pt plus 5cc\penalty\titlepenalty
     \vskip 0pt plus-5cc\vskip-\topskip
     \vbox{\hrule height 4pt \vskip 1pt
                  \hrule height 2pt \vskip 1pt
                  \hrule height 1pt
                  \medskip
  \begingroup
    \def\footnote##1{\footnotemark
      \xdef\ZW@f@@tmark{\c@footnote}%
      \gdef\ZW@f@@tnote{\footnotetext[\ZW@f@@tmark]{##1}}%
      \gdef\ZW@footnote{\aftergroup\ZW@f@@tnote}%
      \aftergroup\ZW@footnote}%
    \parindent\z@
    \bfseries \fontsize{14.4}{15dd}\selectfont \raggedright
    \t@tle\par
  \endgroup
  \vskip-3pt
  \ifdim#1=\z@ \else \kern#1\fi
     \@@line{\leaders\hrule height 10pt depth -9pt
     \hfill\ifautkn@wn\box\authb@x\fi
        \vrule height 17pt width 0pt}}%
    \nobreak\vglue 2cc plus 6dd minus 3dd \relax
  \ClanekToc
  \@afterindentfalse \@afterheading}

\def\ClanekToc{%
  \begingroup \let\footnote\@gobble
  \ifautkn@wn
    \def\PutAuthor{\protect\cl@nek{\auth@r}}
    \addcontentsline{toc}{clanek}{\protect\cl@nek{\auth@r}{\t@tle}}%
    \ifx\pdf@title\relax \def\pdf@title{\protect\cl@nek{\auth@r}{\t@tle}}\fi
  \else
    \def\PutAuthor{}
    \addcontentsline{toc}{clanek}{\t@tle}%
    \ifx\pdf@title\relax \def\pdf@title{\t@tle}\fi
  \fi
  \secdef\@chapter\@schapter{\t@tle}% for minitoc
  \endgroup}
%
% Index
%
\renewcommand*\makeindex[1]{%
  \def\bul@indexname{#1}%
  \newwrite\@indexfile
  \immediate\openout\@indexfile=\bul@indexname.idx
  \def\index{\@bsphack\begingroup
             \@sanitize
             \@wrindex}\typeout
    {Writing index file \bul@indexname.idx}}%
\def\printindex{%
  \@input@{\bul@indexname.ind}%
  \immediate\closeout\@indexfile}%
%
% Counters to reset
%
\def\csbul@zerocounters{%
\setcounter{part}\z@
\setcounter{section}\z@
\setcounter{subsection}\z@
\setcounter{subsubsection}\z@
\setcounter{paragraph}\z@
\setcounter{subparagraph}\z@
\setcounter{equation}\z@
\setcounter{figure}\z@
\setcounter{table}\z@
\setcounter{footnote}\z@
\setcounter{mpfootnote}\z@
\setcounter{secnumdepth}{-2}}

\def\csbul@prefix{} % default for single article
\def\csbul@redef#1 {\expandafter\let\csname csbul@#1\expandafter\endcsname\csname #1\endcsname
  \expandafter\def\csname #1\endcsname##1{\csname csbul@#1\endcsname{\csbul@prefix##1}}}
\csbul@redef label
\csbul@redef pageref
\csbul@redef ref

% Make the prefix

\newcount\csbul@tempcnt

\def\csbul@makeprefix{\global\advance\csbul@tempcnt\@ne
  \edef\csbul@prefix{CSBUL@@\number\csbul@tempcnt}}

% Input

\newcommand\Clanek[2][]{\csbul@makeprefix
  \begingroup
  \csbul@zerocounters
  \renewcommand\documentclass[2][CSBUL]{}%
  \renewcommand\usepackage[2][CSBUL]{}%
  \let\input\CSBULinput
  \renewenvironment{document}{\let\document\@notprerr\setmubytevalues}{\csbul@podepis}% ???
  \ifcat$#1$%
    \def\csbul@fn{#2}%
  \else
    \def\csbul@fn{#1/#2}\graphicspath{{#1/}}\def\csbul@input@path{#1/}%
  \fi
  \csbul@saved@input{\csbul@fn}
  \endgroup}

% Input path

\def\csbul@input@path{}
\def\CSBULinput#1{\csbul@saved@input{\csbul@input@path #1}}
\let\csbul@saved@input\input

%============================================= TUGboat -- obsah

\newenvironment{tugboat}{\vskip-2cc\parindent\z@ \def\and{{\normalfont and
}}\def\sm{``{\small small}''}}{} \newcommand\ti{\hspace*{1.5cc}}
\newcommand\aut[1]{\textsl{#1}: \ignorespaces}
\newcommand\sys[1]{{\normalfont $\cdot$ #1}}
\newcommand\tgb[1][\hfill]{\def\tgb@l{#1}\tgb@@}
\def\tgb@@#1<#2>{\leavevmode
  \parbox[t]{8cc}{\raggedleft\bfseries\strut\tgb@l\strut}\parbox[t]{1.5cc}{\hfill#2}\hfill
  \parbox[t]{14.2cc}{\raggedright \hangafter1 \hangindent 3cc \strut \ignorespaces
      #1\unskip\strut}\par\penalty\z@}


% Inclusion into TOC, numbering

\setcounter{tocdepth}{-2}
\setcounter{secnumdepth}{-2}

% Minulá čísla příliš často obsahují špatně rozdělené slovo PostScript ...

\def\deleni{post-script post-scriptu post-scrip-tem post-scrip-tov\'y post-scrip-tov\'a
post-scrip-tov\'e post-scrip-to-v\'em post-scrip-to-v\'emu post-scrip-to-v\'eho post-scrip-to-v\'ym
post-scrip-to-vou post-scrip-to-v\'ych post-scrip-to-v\'ymi
%
% Podobně JavaScript
%
java-script java-scriptu java-scrip-tem java-scrip-tov\'y java-scrip-tov\'a
java-scrip-tov\'e java-scrip-to-v\'em java-scrip-to-v\'emu java-scrip-to-v\'eho java-scrip-to-v\'ym
java-scrip-to-vou java-scrip-to-v\'ych java-scrip-to-v\'ymi}

\def\PridejDeleni#1{\expandafter\expandafter\expandafter\gdef
                    \expandafter\expandafter\expandafter\deleni
                    \expandafter\expandafter\expandafter
                    {\expandafter\deleni \space #1}}

\AtBeginDocument{\expandafter\hyphenation\expandafter{\deleni}}
\AtBeginDocument{\pdfpageheight 210mm \pdfpagewidth 148mm \relax}
\AtBeginDocument{\edef\setmubytevalues{\noexpand\mubytein\the\mubytein
  \noexpand\mubyteout\the\mubyteout \noexpand\mubytelog\the\mubytelog \relax}}
