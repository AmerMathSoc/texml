%%
%% This is file `bgteubner.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% bgteucls.dtx  (with options: `class')
%% 
%%   bgteubner class bundle
%% 
%%   Copyright 2003--2012 Harald Harders
%% 
%%   This program may be distributed and/or modified under the
%%   conditions of the LaTeX Project Public License, either version 1.3
%%   of this license or (at your opinion) any later version.
%%   The latest version of this license is in
%%      http://www.latex-project.org/lppl.txt
%%   and version 1.3 or later is part of all distributions of LaTeX
%%   version 1999/12/01 or later.
%% 
%%   Additional conditions to the license:
%% 
%%   If you modify a renamed copy of the files `bgteubner.cls' or
%%   `bgteucls.dtx', you have to preserve some information in the
%%   PDF /Creator entry. The following data have to remain:
%%   - The name `bgteubner.cls',
%%   - a hint that this class has been developed for the `Teubner
%%     Verlag, Wiesbaden, Germany'.
%% 
%%   This program consists of all files listed in manifest.txt.
%% 
%%   harald.harders@gmx.de
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bgteubner}
  [2012/04/07  v2.02  Springer Vieweg Verlag]
\typeout{^^J^^JDokumentklasse zum Erstellen von Buechern fuer den
  Springer Vieweg Verlag, Wiesbaden}%
\typeout{(vormals Vieweg+Teubner Verlag, B. G. Teubner Verlag).}%
\typeout{Erstellt im Auftrag des B. G. Teubner Verlags von}%
\typeout{Harald Harders (harald.harders@gmx.de).^^J}%
\typeout{Beachten Sie die Dokumentation in den unterschiedlichen
  Versionen:}%
\typeout{\space\space bgteubner-17x24-times.pdf\space\space Times,
  17cm x 24cm,}%
\typeout{\space\space
  bgteubner-17x24-cm.pdf\space\space\space\space\space European
  Computer Modern, 17cm x 24cm,}%
\typeout{\space\space
  bgteubner-a5-times.pdf\space\space\space\space\space Times, DIN-A 5,}%
\typeout{\space\space
  bgteubner-a5-cm.pdf\space\space\space\space\space \space\space\space
  European Computer Modern, DIN-A 5.}%
\typeout{^^JDocument class to produce books for the Springer Vieweg
  Verlag, Wiesbaden, Germany}%
\typeout{(formerly Vieweg+Teubner Verlag, B. G. Teubner Verlag).}%
\typeout{Made by Harald Harders (harald.harders@gmx.de).}%
\typeout{Documentation is available in German only.^^J^^J}%
\newcommand\hhcls@onefilewithoptions{}
\let\hhcls@onefilewithoptions\@onefilewithoptions
\AtEndOfClass{\let\@onefilewithoptions\hhcls@onefilewithoptions}
\def\@onefilewithoptions#1[#2][#3]#4{%
  \@pushfilename
  \xdef\@currname{#1}%
  \global\let\@currext#4%
  \expandafter\let\csname\@currname.\@currext-h@@k\endcsname\@empty
  \let\CurrentOption\@empty
  \@reset@ptions
  \makeatletter
  \def\reserved@a{%
    \@ifl@aded\@currext{#1}%
      {\@if@ptions\@currext{#1}{#2}{}%
        {\@latex@error
            {Option clash for \@cls@pkg\space #1}%
            {The package #1 has already been loaded
             with options:\MessageBreak
             \space\space[\@ptionlist{#1.\@currext}]\MessageBreak
             There has now been an attempt to load it
              with options\MessageBreak
             \space\space[#2]\MessageBreak
             Adding the global options:\MessageBreak
             \space\space
                  \@ptionlist{#1.\@currext},#2\MessageBreak
             to your \noexpand\documentclass declaration may fix this.%
             \MessageBreak
             Try typing \space <return> \space to proceed.}}}%
      {\@pass@ptions\@currext{#2}{#1}%
       \global\expandafter
       \let\csname ver@\@currname.\@currext\endcsname\@empty
       \InputIfFileExists
         {\@currname.\@currext}%
         {}%
         {\@missingfileerror\@currname\@currext}%
    \let\@unprocessedoptions\@@unprocessedoptions
    \csname\@currname.\@currext-h@@k\endcsname
    \expandafter\let\csname\@currname.\@currext-h@@k\endcsname
              \@undefined
    \@unprocessedoptions}
    \@ifl@ter\@currext{#1}{#3}{}%
      {\@latex@error
         {You have requested,\on@line,
          version\MessageBreak
            `#3' of \@cls@pkg\space #1,\MessageBreak
          but only version\MessageBreak
           `\csname ver@#1.\@currext\endcsname'\MessageBreak
          is available}{%
          The bgteubner class is more restrictive with old packages than^^J%
          standard LaTeX. Please update the specified package. New^^J%
          packages may be downloaded from CTAN, e.g., ftp://ftp.dante.de.}}%
    \ifx\@currext\@clsextension\let\LoadClass\@twoloadclasserror\fi
    \@popfilename
    \@reset@ptions}%
  \reserved@a}
\PassOptionsToClass{smallheadings}{scrbook}
\PassOptionsToClass{bibtotoc,idxtotoc,liststotoc}{scrbook}
\PassOptionsToClass{fleqn}{scrbook}
\PassOptionsToPackage{fleqn}{amsmath}
\PassOptionsToPackage{intlimits}{amsmath}
\PassOptionsToClass{pointlessnumbers}{scrbook}
\PassOptionsToClass{cleardoubleempty}{scrbook}
\PassOptionsToClass{headnosepline}{scrbook}
\PassOptionsToClass{noappendixprefix}{scrbook}
\PassOptionsToClass{tablecaptionabove}{scrbook}
\PassOptionsToPackage{pagesize,headinclude}{typearea}
\newif\ifhhcls@dinafuenf
\DeclareOption{a5paper}{\hhcls@dinafuenftrue}
\DeclareOption{a5}{\hhcls@dinafuenftrue}
\DeclareOption{17x24paper}{\hhcls@dinafuenffalse}
\DeclareOption{17x24}{\hhcls@dinafuenffalse}
\newif\ifhhcls@times
\newif\ifhhcls@mathtime
\DeclareOption{times}{\hhcls@timestrue}
\DeclareOption{mathtime}{\hhcls@timestrue\hhcls@mathtimetrue}
\DeclareOption{cm}{\hhcls@timesfalse}
\newif\ifhhcls@headingoutside
\DeclareOption{headingoutside}{\hhcls@headingoutsidetrue}
\DeclareOption{headinginside}{\hhcls@headingoutsidefalse}
\newif\ifhhcls@tocindent
\DeclareOption{tocindent}{\hhcls@tocindenttrue}
\DeclareOption{tocleft}{\hhcls@tocindentfalse}
\DeclareOption{arrowvec}{\PassOptionsToPackage{arrow}{hhtensor}}
\DeclareOption{boldvec}{\PassOptionsToPackage{bold}{hhtensor}}
\DeclareOption{ulinevec}{\PassOptionsToPackage{uline}{hhtensor}}
\newif\ifhhcls@greybox
\DeclareOption{greybox}{\hhcls@greyboxtrue}
\DeclareOption{graybox}{\hhcls@greyboxtrue}
\newif\ifhhcls@theoremsmall
\DeclareOption{smalltheorem}{\hhcls@theoremsmalltrue}
\DeclareOption{normaltheorem}{\hhcls@theoremsmallfalse}
\newif\ifhhcls@entwurf
\newif\ifhhcls@titlepage
\DeclareOption{draft}{\hhcls@entwurftrue\hhcls@titlepagetrue}
\DeclareOption{titlepage}{\hhcls@titlepagetrue}
\DeclareOption{epsfigures}{%
  \ifpdf
    \ClassWarning{bgteubner}{Class option `epsfigures' ignored
      for pdf output}%
  \else
    \ClassWarning{bgteubner}{Class option `epsfigures' ignored for dvi
      output. eps figures are now included without this option}%
  \fi
}
\newif\if@exercisetotoc
\DeclareOption{exercisetotoc}{\@exercisetotoctrue}
\newif\if@answertotoc
\DeclareOption{answertotoc}{\@exercisetotoctrue\@answertotoctrue}
\newcommand\hhcls@publisher{}
\DeclareOption{springervieweg}{\def\hhcls@publisher{%
    Springer Vieweg Verlag\quad Wiesbaden%
}}
\DeclareOption{viewegteubner}{\def\hhcls@publisher{%
    Vieweg+Teubner\quad Stuttgart $\cdot$ Leipzig $\cdot$ Wiesbaden%
}}
\DeclareOption{bgteubner}{\def\hhcls@publisher{%
    B.~G.\ Teubner\quad Stuttgart $\cdot$ Leipzig $\cdot$ Wiesbaden%
}}
\ExecuteOptions{times,headingoutside,17x24,tocindent,%
  normaltheorem,springervieweg}
\ProcessOptions\relax
\PassOptionsToClass{10pt}{scrbook}
\LoadClass{scrbook}[2003/04/22]
\let\scr@fnt@wrn@pagehead=\@undefined
\let\scr@fnt@wrn@pagefoot=\@undefined
\RequirePackage{fixltx2e}[2000/09/24]
\RequirePackage{wasysym}[2003/05/31]
\let\iint=\@undefined
\let\iiint=\@undefined
\let\iiiint=\@undefined
\RequirePackage{amsmath}[2000/07/18]
\RequirePackage{amsfonts}[2001/10/25]
\RequirePackage{amssymb}[2002/01/22]
\RequirePackage{booktabs}[2003/03/28]
\RequirePackage{array}[1998/05/13]
\RequirePackage{longtable}[2000/10/22]
\RequirePackage[T1]{fontenc}[2001/06/05]
\ifhhcls@times
  \ifhhcls@mathtime
    \RequirePackage[slantedgreek,mtbold]{mathtime}[1999/03/29]
  \else
    \RequirePackage[slantedGreek]{mathptmx}[2003/03/02]
  \fi
  \RequirePackage[scaled=0.92]{helvet}[2003/03/02]
  \RequirePackage{courier}[2003/03/02]
  \renewcommand\bfdefault{b}
  \newcommand\newstylenums{}
  \thinmuskip=3mu
\else
  \RequirePackage[origtt]{hfoldsty}[2003/10/12]
\fi
\renewcommand*\oldstylenums{%
  \ClassWarning{bgteubner}{\string\oldstylenums\space is ignored}%
}
\RequirePackage{textcomp}[2001/06/05]
\RequirePackage[rmdefault]{mathcomp}[2001/01/07]
\ifhhcls@times
  \RequirePackage{ptmxcomp}[2004/03/07]
  \ifhhcls@mathtime
  \else
    \renewcommand*\boldmath{%
      \ClassError{bgteubner}{With the base font Times, bold math is
        undefined\MessageBreak
        (when not using MathTime math extensions)}{%
        Avoid using bold math or buy the MathTime and MathTimePlus
        fonts by Y\&Y.}%
    }
  \fi
\fi
\RequirePackage[hang,RaggedRight]{hhsubfigure}[2003/09/14]
\RequirePackage{ragged2e}[2003/01/26]
\ifhhcls@times
\else
  \RequirePackage{exscale}[1997/06/16]
\fi
\RequirePackage{graphicx}[1999/02/16]
\RequirePackage{color}[1999/02/16]
\RequirePackage{framed}[2003/07/19]
\RequirePackage{hhtensor}[2003/10/09]
\RequirePackage{makeidx}[2000/03/29]
\RequirePackage{mdwlist}[1996/05/02]
\RequirePackage{paralist}[2002/03/18]
\RequirePackage{ifthen}[2001/05/26]
\RequirePackage{ifpdf}[2001/06/14]
\ifhhcls@times
  \ifhhcls@mathtime
    \DeclareMathSymbol\Gamma    {\mathalpha}{letters}{0}
    \DeclareMathSymbol\Delta    {\mathalpha}{letters}{1}
    \DeclareMathSymbol\Theta    {\mathalpha}{letters}{2}
    \DeclareMathSymbol\Lambda   {\mathalpha}{letters}{3}
    \DeclareMathSymbol\Xi       {\mathalpha}{letters}{4}
    \DeclareMathSymbol\Pi       {\mathalpha}{letters}{5}
    \DeclareMathSymbol\Sigma    {\mathalpha}{letters}{6}
    \DeclareMathSymbol\Upsilon  {\mathalpha}{letters}{7}
    \DeclareMathSymbol\Phi      {\mathalpha}{letters}{8}
    \DeclareMathSymbol\Psi      {\mathalpha}{letters}{9}
    \DeclareMathSymbol\Omega    {\mathalpha}{letters}{10}
    \DeclareMathSymbol\upGamma  {\mathord}{letters}{48}
    \DeclareMathSymbol\upDelta  {\mathord}{letters}{49}
    \DeclareMathSymbol\upTheta  {\mathord}{letters}{50}
    \DeclareMathSymbol\upLambda {\mathord}{letters}{51}
    \DeclareMathSymbol\upXi     {\mathord}{letters}{52}
    \DeclareMathSymbol\upPi     {\mathord}{letters}{53}
    \DeclareMathSymbol\upSigma  {\mathord}{letters}{54}
    \DeclareMathSymbol\upUpsilon{\mathord}{letters}{55}
    \DeclareMathSymbol\upPhi    {\mathord}{letters}{56}
    \DeclareMathSymbol\upPsi    {\mathord}{letters}{57}
    \DeclareMathSymbol\upOmega  {\mathord}{letters}{127}
  \fi
\else
  \RequirePackage{fixmath}[2000/04/11]
\fi
\RequirePackage{babel}[2001/03/01]
\RequirePackage{setspace}[2000/12/01]
\RequirePackage{relsize}[1999/11/01]
\ifhhcls@times
  \DeclareRobustCommand\noscshape{%
    \not@math@alphabet\noscshape\relax
    \ifthenelse{\equal{\f@shape}{\scdefault}}{%
      \fontshape\updefault
    }{%
    }%
    \selectfont
  }
\else
  \RequirePackage{slantsc}[2003/09/17]
\fi
\RequirePackage{ginpenc}[2003/09/29]
\RequirePackage{warning}[2001/08/17]
\RequirePackage[all]{onlyamsmath}[2001/10/04]
\RequirePackage[sepfour,autolanguage]{numprint}[2003/11/09]
\RequirePackage{scrpage2}[2002/11/01]
\RequirePackage[fixlanguage]{babelbib}[2003/07/28]
\RequirePackage{fnbreak}[2003/04/03]
\RequirePackage[countmax]{subfloat}[2002/12/16]
\RequirePackage{multicol}[2000/07/10]
\RequirePackage[activate]{pdfcprot}[2002/02/27]
\ifpdftex{}{%
  \ClassError{bgteubner}{Ordinary latex used to compile this
    document.\MessageBreak
    Please use pdflatex. If you need dvi output\MessageBreak
    use pdflatex and include `\string\pdfoutput=0' as first
    line\MessageBreak
    of your document}{The execution of latex is stopped immediately.}%
  \stop
}
\ifpdf
\else
  \addglobalwarning{%
    \ClassWarningNoLine{bgteubner}{%
      Output format is DVI, not PDF.\MessageBreak
      If possible, use PDF output}%
  }%
\fi
\newcommand\iftimes[2]{\ifhhcls@times #1\else #2\fi}
\newcommand\ifmathtime[2]{%
  \ifhhcls@times
    \ifhhcls@mathtime
      #1%
    \else%
      #2%
    \fi
  \else
    #2%
  \fi
}
\BeforePackage{float}{%
  \newcommand*\hhcls@float@addtolists{}%
  \let\hhcls@float@addtolists=\float@addtolists
  \let\float@addtolists=\undefined}
\AfterPackage{float}{%
  \let\hhclsflt@float@addtolists=\float@addtolists
  \renewcommand\float@addtolists[1]{%
    \hhclsflt@float@addtolists{#1}%
    \hhcls@float@addtolists{#1}%
  }%
  \renewcommand*\listof[2]{%
    \begingroup%
      \@ifundefined{ext@#1}{%
        \float@error{#1}%
      }{%
        \@namedef{l@#1}{\@dottedtocline{1}{0em}{2.9em}}%
        \if@twocolumn
          \@restonecoltrue\onecolumn
        \else
          \@restonecolfalse
        \fi
        \float@listhead{#2}%
        \small
        \setlength{\parskip}{\z@}%
        \@starttoc{\@nameuse{ext@#1}}%
        \if@restonecol\twocolumn\fi
      }%
    \endgroup
  }%
  \floatstyle{komabelow}
}
\ifhhcls@dinafuenf
  \setlength{\paperwidth}{148mm}
  \setlength{\paperheight}{210mm}
  \areaset[7mm]{115mm}{174mm}
\else
  \setlength{\paperwidth}{170mm}
  \setlength{\paperheight}{240mm}
  \areaset[7mm]{135mm}{200mm}
\fi
\newcommand\ifafive[2]{\ifhhcls@dinafuenf #1\else #2\fi}
\begingroup
\newdimen\gammel
\gammel=\textheight
\advance\gammel by -0.6\baselineskip
\textheight0mm
\@whiledim\textheight<\gammel
  \do{\global\advance\textheight by \baselineskip}
\endgroup
\ClassInfo{bgteubner}{%
    These are the values describing the layout:\MessageBreak
    BCOR\space=\space\the\ta@bcor\MessageBreak
    \string\paperwidth\space\space\space\space\space\space=%
                         \space\the\paperwidth\MessageBreak
    \space\string\textwidth\space\space\space\space\space\space=%
                         \space\the\textwidth\MessageBreak
    \space\string\evensidemargin\space=%
                         \space\the\evensidemargin\MessageBreak
    \space\string\oddsidemargin\space\space=%
                         \space\the\oddsidemargin\MessageBreak
    \string\paperheight\space\space\space\space\space=%
                         \space\the\paperheight\MessageBreak
    \space\string\textheight\space\space\space\space\space=%
                         \space\the\textheight\MessageBreak
    \space\string\topmargin\space\space\space\space\space\space=%
                         \space\the\topmargin\MessageBreak
    \space\string\headheight\space\space\space\space\space=%
                         \space\the\headheight\MessageBreak
    \space\string\headsep\space\space\space\space\space\space\space\space=%
                         \space\the\headsep\MessageBreak
    \space\string\topskip\space\space\space\space\space\space\space\space=%
                         \space\the\topskip\MessageBreak
    \space\string\footskip\space\space\space\space\space\space\space=%
                         \space\the\footskip\MessageBreak
    \space\string\baselineskip\space\space\space=%
                         \space\the\baselineskip\MessageBreak
  }
\clubpenalty=100
\widowpenalty=400
\displaywidowpenalty=50
\brokenpenalty=400
\relpenalty=700
\binoppenalty=2000
\setlength{\parindent}{\baselineskip}
\addto\extrasamerican{\frenchspacing}%
\addto\noextrasamerican{\nonfrenchspacing}%
\addto\extrasbritish{\frenchspacing}%
\addto\noextrasbritish{\nonfrenchspacing}%
\addto\extrasbritish{\frenchspacing}%
\addto\noextrasbritish{\nonfrenchspacing}%
\addto\extrascanadian{\frenchspacing}%
\addto\noextrascanadian{\nonfrenchspacing}%
\addto\extrasUKenglish{\frenchspacing}%
\addto\noextrasUKenglish{\nonfrenchspacing}%
\addto\extrasUSenglish{\frenchspacing}%
\addto\noextrasUSenglish{\nonfrenchspacing}%
\newlength{\hhcls@chapterindent}%
\newlength{\hhcls@sectionindent}%
\newlength{\hhcls@subsectionindent}%
\newlength{\hhcls@subsubsectionindent}%
\newlength{\hhcls@paragraphindent}%
\newlength{\hhcls@subparagraphindent}%
\setlength{\hhcls@chapterindent}{3.9199em}%
\AtBeginDocument{%
  \setlength{\hhcls@sectionindent}{\hhcls@chapterindent}%
  \setlength{\hhcls@subsectionindent}{\hhcls@chapterindent}%
  \setlength{\hhcls@subsubsectionindent}{\hhcls@chapterindent}%
  \setlength{\hhcls@paragraphindent}{\hhcls@chapterindent}%
  \setlength{\hhcls@subparagraphindent}{\hhcls@chapterindent}%
}
\setkomafont{sectioning}{\normalcolor\normalfont\bfseries
  \iftensor@bold\else\mathversion{bold}\fi}
\renewcommand*\chapterformat{%
  \makebox[\hhcls@chapterindent][l]{%
    \chapappifchapterprefix{\ }\thechapter\autodot}}
\DeclareRobustCommand*\othersectionlevelsformat[1]{%
  \makebox[\csname hhcls@#1indent\endcsname][l]{%
    \csname prefix#1\endcsname\csname the#1\endcsname\autodot
    \csname postfix#1\endcsname}}
\def\prefixsection{}%
\def\prefixsubsection{}%
\def\prefixsubsubsection{}%
\def\prefixparagraph{}%
\def\prefixsubparagraph{}%
\ifhhcls@tocindent
  \newlength{\hhcls@tocindentlength}
  \settowidth{\hhcls@tocindentlength}{0.}
  \renewcommand*\l@section{%
    \@dottedtocline{1}{1\hhcls@tocindentlength}{2.3em}}
  \renewcommand*\l@subsection{%
    \@dottedtocline{2}{2\hhcls@tocindentlength}{3.2em}}
  \renewcommand*\l@subsubsection{%
    \@dottedtocline{3}{3\hhcls@tocindentlength}{4.1em}}
  \renewcommand*\l@paragraph{%
    \@dottedtocline{4}{4\hhcls@tocindentlength}{5.0em}}
  \renewcommand*\l@subparagraph{%
    \@dottedtocline{5}{5\hhcls@tocindentlength}{5.9em}}
\else
  \renewcommand*\l@section{\@dottedtocline{1}{0em}{2.3em}}
  \renewcommand*\l@subsection{\@dottedtocline{2}{0em}{3.2em}}
  \renewcommand*\l@subsubsection{\@dottedtocline{3}{0em}{4.1em}}
  \renewcommand*\l@paragraph{\@dottedtocline{4}{0em}{5.0em}}
  \renewcommand*\l@subparagraph{\@dottedtocline{5}{0em}{5.9em}}
\fi
\ifhhcls@times
  \def\appendixmore{%
    \addpart{\appendixname}%
  }
\else
  \def\appendixmore{%
    \renewcommand*\thechapter{\textsc{\@alph\c@chapter}}%
    \addpart{\appendixname}%
  }
\fi
\setkomafont{descriptionlabel}{\normalcolor\normalfont\rmfamily\bfseries
  \iftensor@bold\else\mathversion{bold}\fi}
\setkomafont{pagehead}{\normalfont\normalcolor\small}
\pagestyle{scrheadings}
\renewcommand*\partpagestyle{empty}
\renewcommand*\chapterpagestyle{empty}
\renewcommand*\indexpagestyle{empty}
\clearscrheadfoot
\ifhhcls@headingoutside
  \rohead[\pagemark]{\headmark\makebox[\hhcls@chapterindent][r]{\pagemark}}
  \lehead[\pagemark]{\makebox[\hhcls@chapterindent][l]{\pagemark}\headmark}
\else
  \ohead[\pagemark]{\pagemark}
  \ihead{\headmark}
\fi
\ProvideTextCommand{\flqq}{T1}{%
  \textormath{\guillemotleft}{\mbox{\guillemotleft}}}
\ProvideTextCommand{\flqq}{OT1}{%
  \textormath{\guillemotleft}{\mbox{\guillemotleft}}}
\ProvideTextCommandDefault{\flqq}{\UseTextSymbol{OT1}\flqq}
\ProvideTextCommand{\frqq}{T1}{%
  \textormath{\guillemotright}{\mbox{\guillemotright}}}
\ProvideTextCommand{\frqq}{OT1}{%
  \textormath{\guillemotright}{\mbox{\guillemotright}}}
\ProvideTextCommandDefault{\frqq}{\UseTextSymbol{OT1}\frqq}
\ProvideTextCommand{\flq}{T1}{%
  \textormath{\guilsinglleft}{\mbox{\guilsinglleft}}}
\ProvideTextCommand{\flq}{OT1}{%
  \textormath{\guilsinglleft}{\mbox{\guilsinglleft}}}
\ProvideTextCommandDefault{\flq}{\UseTextSymbol{OT1}\flq}
\ProvideTextCommand{\frq}{T1}{%
  \textormath{\guilsinglright}{\mbox{\guilsinglright}}}
\ProvideTextCommand{\frq}{OT1}{%
  \textormath{\guilsinglright}{\mbox{\guilsinglright}}}
\ProvideTextCommandDefault{\frq}{\UseTextSymbol{OT1}\frq}
  \let\glqq=\frqq
  \let\grqq=\flqq
  \let\glq=\frq
  \let\grq=\flq
\renewenvironment{thebibliography}[1]{%
  \setchapterpreamble{\bibpreamble}%
  \bib@heading%
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand*\theenumiv{\@arabic\c@enumiv}%
  }%
  \sloppy\clubpenalty4000\widowpenalty4000%
  \setlength\RaggedRightRightskip{\z@\@plus 6em}%
  \small\RaggedRight
  \sfcode`\.=\@m
}{
  \def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
\renewcommand*\newblock{\ }
\def\@bibitem#1{\stepcounter{\@listctr}%
\item[{[\newstylenums{\the\value{\@listctr}}]}]\if@filesw
  \immediate\write\@auxout
  {\string\bibcite{#1}{%
      \string\newstylenums{\the\value{\@listctr}}}}\fi\ignorespaces}
\def\@lbibitem[#1]#2{\item[\@biblabel{\newstylenums{#1}}\hfill]\if@filesw
  {\let\protect\noexpand
    \immediate\write\@auxout{%
      \string\bibcite{#2}{\protect\newstylenums{#1}}}}\fi\ignorespaces}
\def\@citex[#1]#2{%
  \let\@citea\@empty
  \@cite{\@for\@citeb:=#2\do
    {\@citea\def\@citea{,\,}%
     \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
       \G@refundefinedtrue
       \@latex@warning
         {Citation `\@citeb' on page \thepage \space undefined}}%
       {\hbox{\csname b@\@citeb\endcsname}}}}{#1}%
}
\renewcommand\btxISBN{\acro{ISBN}}
\renewcommand\btxISSN{\acro{ISSN}}
\ifhhcls@times
  \newcommand\printISBN[1]{\mbox{#1}}
\else
  \newcommand\printISBN[1]{%
    \mbox{\expandafter\hhcls@printISBN#1\@empty\@empty}%
  }
  \newcommand\hhcls@printISBNx[1]{\acro{#1}}
  \def\hhcls@printISBN#1#2\@empty{%
    \begingroup
    \edef\hhcls@argeins{#1}%
    \edef\hhcls@argzwei{#2}%
    \def\hhcls@argX{X}%
    \def\hhcls@argx{x}%
    \ifx\hhcls@argeins\hhcls@argX
      \hhcls@printISBNx{#1}%
    \else
      \ifx\hhcls@argeins\hhcls@argx
        \hhcls@printISBNx{#1}%
      \else
        #1%
      \fi
    \fi
    \ifx\hhcls@argzwei\@empty
    \else
      \hhcls@printISBN#2\@empty
    \fi
    \endgroup
  }
\fi
\setbibliographyfont{ISBN}{\printISBN}
\setbibliographyfont{ISSN}{\printISBN}
\newcolumntype{d}[1]{D{.}{,}{#1}}
\renewcommand\fps@figure{tp}
\renewcommand\fps@table{tp}
\renewcommand{\floatpagefraction}{0.75}  % Default: 0.5
\renewcommand{\topfraction}{0.75}        % Default: 0.7
\renewcommand{\bottomfraction}{0.35}     % Default: 0.3
\renewcommand{\textfraction}{0.2}       % Default: 0.2
\setcounter{topnumber}{2}               % Default: 2
\setcounter{bottomnumber}{1}            % Default: 1
\setcounter{totalnumber}{3}             % Default: 3
\g@addto@macro\end@float{%
  \ifnum\@floatpenalty<\z@
    \ifnum\@floatpenalty<-\@Mii
    \else
      \ifhmode
        \if@ignore
          \penalty\@M
          \hskip\z@skip
        \fi
      \fi
    \fi
  \fi
}
\setlength\floatsep{18\p@ \@plus 10\p@ \@minus 2\p@}
\setlength\textfloatsep{14\p@ \@plus 20\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{18\p@ \@plus 1fil}
\setlength\@fpbot{0\p@ \@plus 2fil}
\setcaphanging
\setkomafont{caption}{\normalfont\normalcolor\small\RaggedRight}
\newcommand*\germanfigurename[1]{\gdef\hhcls@germanfigurename{#1}}
\germanfigurename{Bild}
\addto\captionsgerman{\renewcommand*\figurename{\hhcls@germanfigurename}}%
\addto\captionsngerman{\renewcommand*\figurename{\hhcls@germanfigurename}}%
\addto\captionsaustrian{\renewcommand*\figurename{\hhcls@germanfigurename}}%
\addto\captionsnaustrian{\renewcommand*\figurename{\hhcls@germanfigurename}}%
\newcommand*\@floatfont{\normalfont\normalcolor\normalsize}
\newcommand*\scr@fnt@float{\@floatfont}
\@ifpackageloaded{setspace}{%
  \def\@xfloat #1[#2]{%
    \latex@xfloat #1[#2]%
    \def\baselinestretch{\setspace@singlespace}%
    \scr@fnt@float
  }%
}{%
  \def\@floatboxreset{%
    \reset@font
    \scr@fnt@float
    \@setminipage
  }%
}%
\setkomafont{float}{\normalfont\normalcolor\small}%
\newcommand\hhcls@longtable{}
\let\hhcls@longtable\longtable
\renewcommand\longtable{\small\hhcls@longtable}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{2.9em}}
\let\l@table\l@figure
\renewcommand{\subfigtopskip}{0pt}
\renewcommand{\subfigbottomskip}{0pt}
\renewcommand{\subfigcapmargin}{0pt}
\renewcommand{\subcapsize}{\small}
\setlength{\subfigcapskip}{8pt}
\renewcommand{\subcapfont}{\rmfamily\RaggedRight}
\renewcommand{\subcaplabelfont}{\rmfamily}
\renewcommand*{\thesubfigure}{\,\alph{subfigure}}
\renewcommand*{\@@thesubfigure}{\alph{subfigure}}
\renewcommand{\@thesubfigure}{%
  {\subcapsize\subcaplabelfont\alph{subfigure}:}\space}
\renewcommand*\thesubfloatfigure{%
  \themainfigure\,(\arabic{subfloatfigure}/\arabic{subfloatfiguremax})}
\renewcommand*\thesubfloattable{%
  \themaintable\,(\arabic{subfloattable}/\arabic{subfloattablemax})}
\newcounter{bilderzahl}%
\g@addto@macro\endfigure{%
  \stepcounter{bilderzahl}%
}%
\newcounter{tabellenzahl}%
\g@addto@macro\endtable{%
  \stepcounter{tabellenzahl}%
}%
\AtEndDocument{%
  \immediate\write\@auxout{%
    \string\gdef\string\hhclsbilderzahl{\thebilderzahl}^^J%
    \string\gdef\string\hhclstabellenzahl{\thetabellenzahl}^^J%
    \string\gdef\string\hhclsaufgabenzahl{\theaufgabenzahl}}%
}
\addglobalwarning{%
  \typeout{^^JNumber of figures: \thebilderzahl}%
  \typeout{Number of tables: \thetabellenzahl}%
  \typeout{Number of exercises: \theaufgabenzahl^^J}%
}%
\renewcommand*\listoffigures{%
  \begingroup%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \lof@heading%
    \small
    \@parskipfalse\@parskip@indent%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
  \endgroup
}
\renewcommand*\listoftables{%
  \begingroup
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \lot@heading%
    \small
    \@parskipfalse\@parskip@indent%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
  \endgroup
}
\newcommand\hhcls@makeindex{}
\let\hhcls@makeindex=\makeindex
\renewcommand\makeindex{%
  \hhcls@makeindex
  \addglobalwarning{%
    \typeout{^^JGenerate index by using^^J%
      \space\space`makeindex -c -g -s bgteubner.ist \jobname'.^^J%
      Have a look to the log file `\jobname.ilg'.^^J}%
  }%
}
\newcommand*\hhcls@germanindexname{Stichwortverzeichnis}
\addto\captionsgerman{\renewcommand*\indexname{\hhcls@germanindexname}}%
\addto\captionsngerman{\renewcommand*\indexname{\hhcls@germanindexname}}%
\addto\captionsaustrian{\renewcommand*\indexname{\hhcls@germanindexname}}%
\addto\captionsnaustrian{\renewcommand*\indexname{\hhcls@germanindexname}}%
\AtEndDocument{\printindex}
\newcommand\listsfont{\footnotesize}
\renewenvironment{theindex}
  {\if@twocolumn
      \@restonecolfalse
    \else
      \@restonecoltrue
    \fi
    \columnseprule \z@
    \columnsep 20\p@
    \setchapterpreamble{\index@preamble}%
    \idx@heading%
    \thispagestyle{\indexpagestyle}%
    \par
    \parindent\z@
    \setlength{\parskip}{\z@ \@plus .3\p@}%
    \setlength{\parfillskip}{\z@ \@plus 1fil}%
    \let\item\@idxitem
    \setlength\RaggedRightRightskip{\z@\@plus 4em}%
    \newif\ifhhclsiscorrectindex
    \RaggedRight\listsfont}
  {\ifhhclsiscorrectindex
    \else
      \ClassError{bgteubner}{You have not used the correct index
        style\MessageBreak
        `bgteubner.ist' for the class `bgteubner.cls'}{%
        You have to use the style bgteubner.ist:^^J%
        Generate index by using^^J%
        \space\space`makeindex -c -g -s bgteubner.ist \jobname'.^^J%
        Have a look to the log file `\jobname.ilg'.}%
    \fi
    \if@restonecol\onecolumn\else\clearpage\fi}
\renewcommand*\@idxitem{\par\hangindent 24\p@}
\renewcommand*\subitem{\@idxitem \quad --\;}
\renewcommand*\subsubitem{\@idxitem \quad --\;--\;}
\newcommand*\f[1]{#1\,f}%
\newcommand*\ff[1]{#1\,ff}%
\newcommand*\textbff[1]{\textbf{#1\,f}}%
\newcommand*\textbfff[1]{\textbf{#1\,ff}}%
\newcommand\subind{\,--\,\hskip\z@skip}%
\newcommand*\emphindex[1]{\textbf{#1}}%
\deffootnote{1.5em}{1.5em}{\normalfont\newstylenums{\thefootnotemark}\enspace}
\addtokomafont{footnote}{\normalfont\RaggedRight}
\deffootnotemark{\textsuperscript{\newstylenums{\thefootnotemark}}}
\setlength{\skip\footins}{10\p@ \@plus 4\p@ \@minus 2\p@}
\ifhhcls@times
  \DeclareRobustCommand\acro[1]{\textsmaller{\MakeUppercase{#1}}}
\else
  \DeclareRobustCommand\acro[1]{%
    \ifthenelse{\equal{\f@family}{hfor}\or\equal{\f@family}{cmr}}{%
      \textsc{\MakeLowercase{#1}}%
    }{%
      \ifthenelse{\(\equal{\f@family}{hfott}\or\equal{\f@family}{cmtt}\)%
        \and\equal{\f@shape}{n}}{%
        \textsc{\MakeLowercase{#1}}%
      }{%
        \textsmaller{\MakeUppercase{#1}}%
      }%
    }%
  }
\fi
\newcommand\person{}%
\let\person=\emph
\newcommand\new{}%
\let\new=\emph
\newcommand\engl{}%
\let\engl=\emph
\newcommand*\qed{%
  \hskip 1em plus 1fill\rule{0pt}{1ex}\hskip\z@skip
  \hglue 0pt plus 1fill\mbox{\qedname}}
\newcommand*\qedname{\rule{1ex}{1ex}}
\newcommand*\tr{\mathop{\operator@font tr}\nolimits}
\newcommand*\e{\mathop{\operator@font e}\nolimits}
\let\origd=\d
\AtBeginDocument{
  \renewcommand*\d{%
    \relax\ifmmode
      \mathrm{d}%
    \else
      \expandafter\origd
    \fi
  }%
}%
\newcommand*\D{\ensuremath{\upDelta}}
\newcommand*\grad{\mathop{\operator@font grad}\nolimits}
\newenvironment{cases*}{%
  \matrix@check\cases\env@cases
}{%
  \endarray\right\rbrace%
}
\newcommand*\equivalent{\ensuremath{\mathrel{\widehat{=}}}}
\newenvironment{nomathindent}[1][1.0]{%
  \addtolength{\mathindent}{-#1\mathindent}%
  \ignorespaces
}{\ignorespacesafterend}
\iftensor@bold
  \ifhhcls@times
    \ifhhcls@mathtime
    \else
      \addglobalwarning{%
        \ClassWarningNoLine{bgteubner}{The combination of the main font
          Times\MessageBreak
          with bold vectors (option <boldvec>)\MessageBreak
          leads to ugly results in some cases}}%
      \renewcommand*\vec[1]{\ensuremath{\pmb{#1}}}
      \renewcommand*\matr[1]{\ensuremath{\pmb{#1}}}
      \renewcommand*\tens[2]{\ensuremath{\pmb{#1}}}
    \fi
  \fi
\fi
\AtBeginDocument{%
  \providecommand*\tensor{%
    \ClassError{bgteubner}{\string\tensor\space command used instead
      of \string\tens\space command (see help by pressing h)}{%
      Because of some name clashes, the \string\tensor\space command
      had to be renamed to \string\tens. Please change all calls
      inside your document.}%
    \tens
  }%
}
\allowdisplaybreaks
\def\maketag@@@#1{\hbox{\m@th#1}}
\mathchardef\mathcomma\mathcode`\,
\mathcode`\,=32768 % "8000
\begingroup
\catcode`\_=12
\catcode`\,=\active
\@firstofone{%
\endgroup
 \edef\DC@char{\meaning_}
 \def\DC@parse#1 _{\def\DC@parse##1#1 ##2##3\delimiter{##2}}
 \expandafter\DC@parse\DC@char
 \toks@={\expandafter\DC@parse\meaning\DC@char}
 \edef\DC@test{9<2\the\toks@ \DC@char.\delimiter}
 \DeclareRobustCommand\ActiveComma{\futurelet\DC@char\DC@docomma}
 \def\DC@docomma{%
   \ifnum\DC@test \mathord \fi
   \mathcomma
 }
 \let,\ActiveComma
}
\makeatother
\newcommand*\ifhasat[1]{%
  \expandafter\csname @ifhasat\expandafter\endcsname#1@\end
}
\expandafter\def\csname @ifhasat\endcsname#1@#2\end{%
  \ifx\relax#2\relax
    \expandafter\csname @secondoftwo\expandafter\endcsname
  \else
    \expandafter\csname @firstoftwo\expandafter\endcsname
  \fi
}
\newcommand*\beforeat[1]{%
  \expandafter\csname @beforeat\expandafter\endcsname#1@\end
}
\expandafter\def\csname @beforeat\endcsname#1@#2\end{#1}
\newcommand*\afterat[1]{%
  \ifhasat{#1}{\expandafter\csname hh@afterat\expandafter\endcsname#1\end}{}%
}
\expandafter\def\csname hh@afterat\endcsname#1@#2\end{#2}
\makeatletter
\def\hhcls@gloprefix{}
\let\glossary=\@undefined
\let\makeglossary=\@undefined
\newcommand*\makeglossary[1][\@empty]{%
  \edef\hhcls@gloname{glo#1}%
  \expandafter\edef\csname hhcls@#1glsname\endcsname{gls#1}%
  \typeout{^^JNew glossary type \string\glossary#1 with file
    extensions `\hhcls@gloname' and `\csname hhcls@#1glsname\endcsname'.}%
  \typeout{Writing glossary file `\jobname.\hhcls@gloname'.^^J}%
  \addglobalwarning{%
    \typeout{^^JGenerate glossary type \string\glossary#1 by using^^J%
      \space\space`makeindex -c -g -s bgteuglo.ist -o
      \jobname.\csname hhcls@#1glsname\endcsname\space
      -t \jobname.\hhcls@gloname lg \jobname.\hhcls@gloname'^^J%
      or^^J%
      \space\space`makeindex -c -g -s bgteuglochar.ist -o
      \jobname.\csname hhcls@#1glsname\endcsname\space
      -t \jobname.\hhcls@gloname lg \jobname.\hhcls@gloname'.^^J%
      Have a look to the log file `\jobname.\hhcls@gloname lg'^^J.}%
  }%
  \@ifundefined{glossary#1}{%
    \expandafter\def\csname glossary#1\endcsname{%
      \def\hhcls@tmpoutputfile{\csname hhcls@glossaryfile#1\endcsname}%
      \protect\@hhcls@glossary
    }%
    \expandafter\newwrite\csname hhcls@glossaryfile#1\endcsname
    \immediate\openout\csname hhcls@glossaryfile#1\endcsname=%
      \jobname.\hhcls@gloname%
    \expandafter\def\csname glossary#1preamble\endcsname{%
      \@ifundefined{glossary#1name}{%
        \ClassError{bgteubner}{No title for glossary type `#1'
          defined}{You have to define a title for the glossary type by
          doing^^J%
          \space\space\space\space%
          \string\newcommand\string\glossary #1name{<Name>}.}%
        \addchap{\itshape ????}%
      }{%
        \addchap{\csname glossary#1name\endcsname}}%
      }%
    \expandafter\def\csname printglossary#1\endcsname{%
      \@ifnextchar[%
      {\csname @printglossary#1\endcsname}%
      {\csname @printglossary#1\endcsname[\glossarylabelwidth]}%
    }%
    \expandafter\def\csname @printglossary#1\endcsname[##1]{%
      \begingroup
      \setlength{\glossarylabelwidth}{##1}%
      \def\hhcls@glossarypreamble{\csname glossary#1preamble\endcsname}%
      \@input@{\jobname.\csname hhcls@#1glsname\endcsname}%
      \endgroup
    }%
  }{%
    \ClassError{bgteubner}{Glossary type `#1' already defined}{You
      have tried to define the glossary type `#1' twice}}%
}
\@onlypreamble\makeglossary
\def\hhcls@glossarypreamble{\addchap{\glossaryname}}%
\def\hhcls@glo@verb{\expandafter\strip@prefix\meaning}
\def\@hhcls@glossary{%
  \@bsphack
  \begingroup
  \@sanitize
  \@ifnextchar[%
  {\@@@hhcls@glossary}{\@@@hhcls@glossary[\hhcls@gloprefix]}%
}%
\def\@@@hhcls@glossary[#1]#2#3{%
 \def\@tempa{#2}\def\@tempb{#3}%
 \ifhasat{#2}{%
   \protected@write\hhcls@tmpoutputfile{}%
   {\string\glossaryentry{#1\beforeat{#2}@{\afterat{#2}}]
       \@tempb
       |glossarypage}{\thepage}%
   }%
 }{%
   \protected@write\hhcls@tmpoutputfile{}%
   {\string\glossaryentry{%
       #1\@tempa @{\@tempa}]
       \@tempb
       |glossarypage}{\thepage}%
   }%
 }%
 \endgroup
 \@esphack}
\newlength{\glossarylabelwidth}
\setlength{\glossarylabelwidth}{3em}
\def\glossarylabel#1{#1\hfil}
\newenvironment{theglossary}[1][\@empty]{%
  \def\tuetel{#1}%
  \def\tueteluet{\@empty}%
  \begin{multicols}{2}[%
    \let\size@section\normalsize
    \let\size@subsection\small
    \let\size@subsubsection\small
    \small
    \ifx\tuetel\tueteluet
      \hhcls@glossarypreamble
    \else
      #1%
    \fi
    ]%
    \setlength{\columnsep}{20pt}%
    \listsfont
    \begin{list}{\ClassError{bgteubner}{No symbol given for
          \string\item}{In the `theglossary' environment, you have to
          specify a symbol^^J%
          for each \string\item\space using \string\item[<symbol>], e.g.^^J%
          \space\space\space\space
          \string\item[{$\string\sigma_{\string\mathrm{max}}$}] Maximal
          stress^^J%
          \space\space\space\space
          \string\item[DIN] Deutsches Institut f"ur Normung}}{%
        \setlength{\labelwidth}{\glossarylabelwidth}%
        \leftmargin\labelwidth
        \advance\leftmargin by \labelsep
        \let\makelabel\glossarylabel%
        \parsep\z@%
        \parskip\z@%
        \setlength{\itemsep}{0pt}%
        \newif\ifhhclsiscorrectglossary
        \RaggedRight
      }%
    }{%
    \end{list}%
  \end{multicols}%
  \ignorespacesafterend
  \noindentnextpar\par
}
\def\glossarypage#1{}
\def\glossarypagedelim{}
\def\glossarypagerange{}
\newcommand\glossarynewchar[1]{%
  \indexspace
  \item [\textbf{#1}]\strut
    \@nobreaktrue\nopagebreak
}
\if@twoside
\else
  \ClassError{bgteubner}{One-side format chosen}{You may not print a
    book with one-side format.}
\fi
\providecommand*\GetFileInfo[1]{%
  \def\filename{#1}%
  \def\@tempb##1 ##2 ##3\relax##4\relax{%
    \def\filedate{##1}%
    \def\fileversion{##2}%
    \def\fileinfo{##3}}%
  \edef\@tempa{\csname ver@#1\endcsname}%
  \expandafter\@tempb\@tempa\relax? ? \relax\relax}
\newcommand*\version[1]{%
  \begingroup
  \GetFileInfo{bgteubner.cls}%
  \ifx\hhcls@tmp\fileversion
    \typeout{^^JVersion of the class `bgteubner.cls'
      (\fileversion) is identical^^J%
      with the wanted version.^^J}%
  \else
    \typeout{^^JVersion of the class `bgteubner.cls'
      (\fileversion) differs from wanted version (#1).^^J}%
    \addglobalwarning{\ClassWarningNoLine{bgteubner}{The version, wanted in
        the document (#1),\MessageBreak
        differs from the used version of the
        `bgteubner.cls'\MessageBreak
        class (\fileversion)}}%
  \fi
  \endgroup
}
\newcommand\hhcls@frontmatter{}
\let\hhcls@frontmatter=\frontmatter
\renewcommand\frontmatter[1][5]{%
  \hhcls@frontmatter
  \ifhhcls@times
    \pagenumbering{Roman}%
  \else
    \renewcommand\thepage{\textsc{\roman{page}}}%
  \fi
  \setcounter{page}{5}%
}
\renewcommand*\backmatter{\ClassWarning{bgteubner}{The
    \string\backmatter\space command is ignored}}
\ifhhcls@entwurf
  \addglobalwarning{%
    \ClassWarningNoLine{bgteubner}{Leave out the class option
      <draft>\MessageBreak
      for the final version}%
  }
  \newcommand*\now{{%
      \def\Time{3}%
      \def\Hour{4}%
      \def\Minute{5}%
      \count\Time=\time\relax
      \count\Hour=\count\Time\relax
      \divide\count\Hour by 60\relax%%hours past midnight
      \count\Minute=\count\Hour\relax
      \multiply\count\Minute by -60\relax
      \advance\count\Minute by \count\Time\relax %%minutes past hour
      \the\count\Hour\relax:%
      \ifnum\count\Minute<10
        0%
      \fi
      \the\count\Minute\relax
  }}
  \ifoot[{\rmfamily \"Ubersetzt: \today, \now}]{%
    {\rmfamily \"Ubersetzt: \today, \now}}
  \overfullrule5mm
\fi
\newcommand*\noindentnextpar{%
  \global\everypar{%
    \setbox0\lastbox
    \global\everypar{}%
  }%
}
\newcommand\hhcls@bigskip{}
\let\hhcls@bigskip=\bigskip
\renewcommand\bigskip{\par\hhcls@bigskip\noindentnextpar}
\setlength{\bigskipamount}{18.0pt plus 6.0pt minus 6.0pt}
\newcommand*\hhcls@medskip{}
\let\hhcls@medskip\medskip
\renewcommand{\medskip}{\par\hhcls@medskip\noindentnextpar}
\setlength{\medskipamount}{9.0pt plus 3.0pt minus 3.0pt}
\newcommand*\hhcls@smallskip{}
\let\hhcls@smallskip\smallskip
\renewcommand{\smallskip}{\par\hhcls@smallskip\noindentnextpar}
\setlength{\smallskipamount}{4.5pt plus 1.5pt minus 1.5pt}
\newcommand*\gliederungsfehler[1]{%
  \renewcommand{\part}{\ClassError{bgteubner}{\string\part\space
      used inside #1 environment}{%
      Inside the #1 environment,^^J\string\part,
      \string\addpart, \string\chapter, \string\addchap,
      \string\section\space, and \string\subsection\space
      ^^Jmay not be used.
      ^^J\string\subsubsection\space and \string\paragraph\space
      are allowed.}}%
  \renewcommand{\addpart}{\ClassError{bgteubner}{\string\addpart\space
      used inside #1 environment}{%
      Inside the #1 environment,^^J\string\part,
      \string\addpart, \string\chapter, \string\addchap,
      \string\section\space, and \string\subsection\space
      ^^Jmay not be used.
      ^^J\string\subsubsection\space and \string\paragraph\space
      are allowed.}}%
  \renewcommand{\chapter}{\ClassError{bgteubner}{\string\chapter\space
      used inside #1 environment}{%
      Inside the #1 environment,^^J\string\part,
      \string\addpart, \string\chapter, \string\addchap,
      \string\section\space, and \string\subsection\space
      ^^Jmay not be used.
      ^^J\string\subsubsection\space and \string\paragraph\space
      are allowed.}}%
  \renewcommand{\addchap}{\ClassError{bgteubner}{\string\addchap\space
      used inside #1 environment}{%
      Inside the #1 environment,^^J\string\part,
      \string\addpart, \string\chapter, \string\addchap,
      \string\section\space, and \string\subsection\space
      ^^Jmay not be used.
      ^^J\string\subsubsection\space and \string\paragraph\space
      are allowed.}}%
  \renewcommand{\section}{\ClassError{bgteubner}{\string\section\space
      used inside #1 environment}{%
      Inside the #1 environment,^^J\string\part,
      \string\addpart, \string\chapter, \string\addchap,
      \string\section\space, and \string\subsection\space
      ^^Jmay not be used.
      ^^J\string\subsubsection\space and \string\paragraph\space
      are allowed.}}%
  \renewcommand{\subsection}{\ClassError{bgteubner}{\string\subsection\space
      used inside #1 environment}{%
      Inside the #1 environment,^^J\string\part,
      \string\addpart, \string\chapter, \string\addchap,
      \string\section\space, and \string\subsection\space
      ^^Jmay not be used.
      ^^J\string\subsubsection\space and \string\paragraph\space
      are allowed.}}%
}
\newlength{\hhcls@leftmargin}%
\newlength{\hhcls@rightmargin}%
\newenvironment{hhcls@quotation}[3][\@empty]{%
  \edef\hhcls@tmpa{#1}%
  \ifx\hhcls@tmpa\@empty
    \setlength{\hhcls@rightmargin}{#2}%
  \else
    \setlength{\hhcls@rightmargin}{#1}%
  \fi
  \setlength{\hhcls@leftmargin}{#2}%
  \begin{list}{}{%
      \listparindent\parindent%
      \itemindent0em%
      \leftmargin\hhcls@leftmargin%
      \rightmargin\hhcls@rightmargin
      \parsep\z@ \@plus\p@}%
    \begin{spacing}{#3}%
    \item\relax
  }{%
    \end{spacing}%
    \removelastskip
    \end{list}%
  }%
\renewenvironment{quotation}{%
  \list{}{%
    \listparindent \parindent
    \itemindent    \z@
    \leftmargin    \hhcls@leftmargin
    \rightmargin   \hhcls@rightmargin
    \parsep        \z@ \@plus\p@}%
  \item\relax
}{%
  \endlist
}
\renewenvironment{quote}{%
  \list{}{%
    \leftmargin    \hhcls@leftmargin
    \rightmargin   \hhcls@rightmargin
  }%
  \item\relax
}{%
  \endlist
}
\newcommand*\setmargin[1]{%
  \edef\@setmarginname{#1}%
  \@setmargin}
\newcommand*\@setmargin[2][\@empty]{%
  \edef\hhcls@tmp{#1}%
  \ifx\hhcls@tmp\@empty
    \setlength{%
      \expandafter\csname\@setmarginname @lmargin\endcsname}{#2}%
  \else
    \setlength{%
      \expandafter\csname\@setmarginname @lmargin\endcsname}{#1}%
  \fi
  \setlength{%
    \expandafter\csname\@setmarginname @rmargin\endcsname}{#2}%
}
\setlength{\leftmargini}{1.75\parindent}
\setlength{\leftmargin}{\leftmargini}
\setlength{\hhcls@leftmargin}{\leftmargini}
\setlength{\labelwidth}{\leftmargini}
\newlength{\advanced@lmargin}
\newlength{\advanced@rmargin}
\setmargin{advanced}{\leftmargini}
\newcommand\advancedfont{\footnotesize}
\ifhhcls@times
  \newcommand\advancedspacing{1.18}
\else
  \newcommand\advancedspacing{1.12}
\fi
\newcommand*\advancednamefont{\bfseries%
  \iftensor@bold\else\mathversion{bold}\fi}
\newcommand*\noadvancedname{\gdef\advancedname{}}
\noadvancedname
\newenvironment{advanced}{%
  \gliederungsfehler{advanced}%
  \let\size@subsubsection\advancedfont
  \let\size@paragraph\advancedfont
  \let\size@subparagraph\advancedfont
  \begin{hhcls@quotation}[\advanced@rmargin]{\advanced@lmargin}{%
      \advancedspacing}%
  \advancedfont
      \ifx\advancedname\empty
      \else
        {\advancednamefont\advancedname}~%
      \fi
    \ignorespaces
  }{%
  \end{hhcls@quotation}%
  \ignorespacesafterend
  \noindentnextpar\par
}
\ifhhcls@theoremsmall
  \def\theoremfont{\small}
  \ifhhcls@times
    \newcommand\theoremspacing{1.12}
  \else
     \newcommand\theoremspacing{1.06}
  \fi
\else
  \def\theoremfont{\normalsize}
  \newcommand\theoremspacing{1.0}
\fi
\newlength{\theorem@lmargin}
\newlength{\theorem@rmargin}
\newlength{\theorem@indent@min}
\setlength{\theorem@indent@min}{7.8398em}
\newlength{\theorem@indent}
\setlength{\theorem@indent}{\theorem@indent@min}
\newlength{\theorem@indent@max}
\AtEndDocument{%
  \ifdim\theorem@indent@max>\theorem@indent@min
    \immediate\write\@auxout{%
      \string\global\string\theorem@indent=\the\theorem@indent@max}%
    \ifdim\theorem@indent@max>\theorem@indent
      \addglobalwarning{%
        \ClassWarningNoLine{bgteubner}{Indentation for theorem
          titles has been increased.\MessageBreak
          Rerun to adjust the indentation}%
      }%
    \else
      \ifdim\theorem@indent@max<\theorem@indent
        \addglobalwarning{%
          \ClassWarningNoLine{bgteubner}{Indentation for theorem
            titles has been decreased.\MessageBreak
            Rerun to adjust the indentation}%
        }%
      \fi
    \fi
  \else
    \ifdim\theorem@indent>\theorem@indent@min
      \addglobalwarning{%
        \ClassWarningNoLine{bgteubner}{Indentation for theorem
          titles has been decreased.\MessageBreak
          Rerun to adjust the indentation}%
      }%
    \fi
  \fi
}
\newcommand\float@addtolists[1]{%
  \def\hhcls@theoremskip{#1}%
  \hhcls@theoremlist}
\newcommand\hhcls@theoremlist{}
\newcommand\hhcls@theoremanzahl{}
\newsavebox{\hhcls@@@theoremtitlewidth}
\newif\iftheorem@starvariant
\def\newtheorem#1#2{%
  \expandafter\def\csname theorem@#1name\endcsname{#2}%
  \expandafter\def\csname theorem@#1postfix\endcsname{:}%
  \expandafter\newlength\expandafter{\csname theorem@#1@lmargin\endcsname}%
  \expandafter\newlength\expandafter{\csname theorem@#1@rmargin\endcsname}%
  \setmargin{theorem@#1}{\leftmargini}%
  \newcounter{theorem@#1}[chapter]%
  \newcounter{theorem@#1zahl}%
  \g@addto@macro\hhcls@theoremanzahl{%
    ; #2: \csname thetheorem@#1zahl\endcsname}%
  \expandafter\def\csname thetheorem@#1\endcsname{%
    \thechapter.\@arabic\csname c@theorem@#1\endcsname}%
  \expandafter\def\csname theorem@#1title\endcsname##1{%
    \iftheorem@starvariant
    \else
      \refstepcounter{theorem@#1}%
    \fi
    {%
      \raggedsection\normalfont\normalsize\sectfont\nobreak
      \savebox{\hhcls@@@theoremtitlewidth}{%
        \csname theorem@#1name\endcsname%
        \iftheorem@starvariant
        \else
        ~\csname thetheorem@#1\endcsname
        \fi
        \csname theorem@#1postfix\endcsname~}%
      \settowidth{\@tempdima}{\usebox{\hhcls@@@theoremtitlewidth}}%
      \ifdim\@tempdima>\theorem@indent@max
        \global\theorem@indent@max=\@tempdima
      \fi
      \normalfont\normalsize\sectfont
      \makebox[\theorem@indent][l]{\usebox{\hhcls@@@theoremtitlewidth}}%
      \setlength\@tempdima{1pt}%
      \settoheight\@tempdimb{D}%
      \addtolength\@tempdima{\@tempdimb}%
      \settoheight\@tempdimb{\theoremfont D}%
      \addtolength\@tempdima{-\@tempdimb}%
      ##1\nobreak\par\nobreak\vspace{\@tempdima}\nobreak}\nobreak
    \@afterheading}%
  \g@addto@macro\hhcls@theoremlist{%
    \addtocontents{#1}{\hhcls@theoremskip}%
  }%
  \expandafter\def\csname #1*\endcsname{%
    \theorem@starvarianttrue
    \csname #1\endcsname
  }%
  \expandafter\def\csname end#1*\endcsname{\csname end#1\endcsname}%
  \expandafter\def\csname #1\endcsname{%
    \@ifnextchar[{%
      \csname hhcls@@#1\endcsname
    }{%
      \csname hhcls@@#1\endcsname[\empty]%
    }}%
  \expandafter\def\csname hhcls@@#1\endcsname[##1]{%
  \setlength{\theorem@lmargin}{\csname theorem@#1@lmargin\endcsname}%
  \setlength{\theorem@rmargin}{\csname theorem@#1@rmargin\endcsname}%
  \ifhhcls@inimportant
    \addtolengthminzero{\theorem@lmargin}{-\fboxsep}%
    \addtolengthminzero{\theorem@rmargin}{-\fboxsep}%
    \addtolengthminzero{\theorem@indent}{-\fboxsep}%
  \fi
    \par
    \begin{list}{}{%
        \topsep 8\p@ \@plus2\p@ \@minus4\p@
        \itemindent-\theorem@lmargin
        \listparindent\parindent
        \leftmargin\theorem@lmargin
        \rightmargin\theorem@rmargin
        \parsep\z@ \@plus\p@
        \stepcounter{theorem@#1zahl}%
        \gliederungsfehler{#1}%
        \let\size@subsubsection\theoremfont
        \let\size@paragraph\theoremfont
        \let\size@subparagraph\theoremfont
        \theoremfont
      }%
      \begin{spacing}{\theoremspacing}%
    \item\relax
        \csname theorem@#1title\endcsname{##1}\nobreak%
    \edef\hhtmp{##1}%
    \ifx\hhtmp\empty
    \else
      \iftheorem@starvariant
        \addcontentsline{#1}{#1}{##1}%
      \else
        \addcontentsline{#1}{#1}{%
          \numberline {\csname thetheorem@#1\endcsname}##1}%
      \fi
    \fi
    \nobreak\ignorespaces
  }%
  \expandafter\def\csname end#1\endcsname{%
    \end{spacing}%
    \removelastskip
    \end{list}%
    \ignorespacesafterend
    \noindentnextpar
    \par
  }%
  \expandafter\def\csname l@#1\endcsname{\@dottedtocline{1}{0em}{2.9em}}%
  \addglobalwarning{%
    \typeout{#2: \csname thetheorem@#1zahl\endcsname\space times used}%
  }
}
\newcommand*\listoftheorems[2]{%
  \begingroup%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \float@listhead{#2}%
    \small
    \setlength{\parskip}{\z@}%
    \@starttoc{#1}%
    \if@restonecol\twocolumn\fi
  \endgroup
}
\newenvironment{theoremdelimiter}[2]{%
  \expandafter\def\csname theorem@#1postfix\endcsname{#2}%
  \ignorespaces
}{%
  \ignorespacesafterend
}%
\newcommand*\settheoremmargin[1]{%
  \edef\@setmarginname{#1}%
  \@settheoremmargin}
\newcommand*\@settheoremmargin[2][\@empty]{%
  \edef\hhcls@tmp{#1}%
  \ifx\hhcls@tmp\@empty
    \setlength{%
      \expandafter\csname theorem@\@setmarginname @lmargin\endcsname}{#2}%
  \else
    \setlength{%
      \expandafter\csname theorem@\@setmarginname @lmargin\endcsname}{#1}%
  \fi
  \setlength{%
    \expandafter\csname theorem@\@setmarginname @rmargin\endcsname}{#2}%
}
\newtheorem{example}{\examplename}
\newcommand*\listofexamples{\listoftheorems{example}{\listexamplename}}
\newcommand*\examplename{}
\newcommand*\listexamplename{}
\addto\captionsgerman{%
  \renewcommand*\examplename{Beispiel}%
  \renewcommand*\listexamplename{Verzeichnis der Beispiele}%
}
\addto\captionsngerman{%
  \renewcommand*\examplename{Beispiel}%
  \renewcommand*\listexamplename{Verzeichnis der Beispiele}%
}
\addto\captionsaustrian{%
  \renewcommand*\examplename{Beispiel}%
  \renewcommand*\listexamplename{Verzeichnis der Beispiele}%
}
\addto\captionsnaustrian{%
  \renewcommand*\examplename{Beispiel}%
  \renewcommand*\listexamplename{Verzeichnis der Beispiele}%
}
\addto\captionsenglish{%
  \renewcommand*\examplename{Example}%
  \renewcommand*\listexamplename{List of Examples}%
}
\addto\captionsamerican{%
  \renewcommand*\examplename{Example}%
  \renewcommand*\listexamplename{List of Examples}%
}
\newtheorem{definition}{\definitionname}
\newcommand*\listofdefinitions{%
  \listoftheorems{definition}{\listdefinitionname}}
\newcommand*\definitionname{}
\newcommand*\listdefinitionname{}
\addto\captionsgerman{%
  \renewcommand*\definitionname{Definition}%
  \renewcommand*\listdefinitionname{Verzeichnis der Definitionen}%
}
\addto\captionsngerman{%
  \renewcommand*\definitionname{Definition}%
  \renewcommand*\listdefinitionname{Verzeichnis der Definitionen}%
}
\addto\captionsaustrian{%
  \renewcommand*\definitionname{Definition}%
  \renewcommand*\listdefinitionname{Verzeichnis der Definitionen}%
}
\addto\captionsnaustrian{%
  \renewcommand*\definitionname{Definition}%
  \renewcommand*\listdefinitionname{Verzeichnis der Definitionen}%
}
\addto\captionsenglish{%
  \renewcommand*\definitionname{Definition}%
  \renewcommand*\listdefinitionname{List of Definitions}%
}
\addto\captionsamerican{%
  \renewcommand*\definitionname{Definition}%
  \renewcommand*\listdefinitionname{List of Definitions}%
}
\newtheorem{proof}{\proofname}
\newcommand*\listofproofs{\listoftheorems{proof}{\listproofname}}
\newcommand*\proofname{}
\newcommand*\listproofname{}
\addto\captionsgerman{%
  \renewcommand*\proofname{Beweis}%
  \renewcommand*\listproofname{Verzeichnis der Beweise}%
}
\addto\captionsngerman{%
  \renewcommand*\proofname{Beweis}%
  \renewcommand*\listproofname{Verzeichnis der Beweise}%
}
\addto\captionsaustrian{%
  \renewcommand*\proofname{Beweis}%
  \renewcommand*\listproofname{Verzeichnis der Beweise}%
}
\addto\captionsnaustrian{%
  \renewcommand*\proofname{Beweis}%
  \renewcommand*\listproofname{Verzeichnis der Beweise}%
}
\addto\captionsenglish{%
  \renewcommand*\proofname{Proof}%
  \renewcommand*\listproofname{List of Proofs}%
}
\addto\captionsamerican{%
  \renewcommand*\proofname{Proof}%
  \renewcommand*\listproofname{List of Proofs}%
}
\newcommand*\addtolengthminzero[2]{%
  \addtolength{#1}{#2}%
  \ifdim#1<0pt
    \setlength{#1}{0pt}%
  \fi
}
\newif\ifhhcls@importantmath
\newif\ifhhcls@inimportant
\ifhhcls@greybox
  \newsavebox{\hhcls@@@important}
  \newlength{\hhcls@important@parindent}
  \definecolor{importantcolor}{gray}{0.9}
  \newcounter{hhcls@savefootnote}
  \newcommand\addfnmark[2][\@empty]{%
    \begingroup
    \edef\hhcls@temp{#1}%
    \ifx\hhcls@temp\@empty
      \g@addto@macro\hhcls@fnlist{%
        \stepcounter{hhcls@savefootnote}%
        \footnotetext[\thehhcls@savefootnote]{#2}%
      }%
    \else
      \g@addto@macro\hhcls@fnlist{\footnotetext[#1]{#2}}%
    \fi
    \endgroup
    }
  \newcommand\hhcls@important@footnote[2][\@empty]{%
    \begingroup
    \edef\hhcls@temp{#1}%
    \ifx\hhcls@temp\@empty
      \footnotemark
    \else
      \footnotemark[#1]%
    \fi
    \addfnmark[#1]{#2}%
    \endgroup
    }%
  \newenvironment{important}{%
    \hhcls@inimportanttrue
    \setlength{\fboxsep}{0.5\parindent}%
    \addtolengthminzero{\mathindent}{-\fboxsep}%
    \addtolengthminzero{\theorem@lmargin}{-\fboxsep}%
    \addtolengthminzero{\theorem@rmargin}{-\fboxsep}%
    \addtolengthminzero{\advanced@lmargin}{-\fboxsep}%
    \addtolengthminzero{\advanced@rmargin}{-\fboxsep}%
    \addtolengthminzero{\subexercise@lmargin}{-\fboxsep}%
    \addtolengthminzero{\subexercise@rmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@@subexerciseindent}{-\fboxsep}%
    \addtolengthminzero{\answer@lmargin}{-\fboxsep}%
    \addtolengthminzero{\answer@rmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@@answerindent}{-\fboxsep}%
    \addtolengthminzero{\subanswer@lmargin}{-\fboxsep}%
    \addtolengthminzero{\subanswer@rmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@@subanswerindent}{-\fboxsep}%
    \addtolengthminzero{\leftmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@leftmargin}{-\fboxsep}%
    \setlength{\hhcls@important@parindent}{\parindent}%
    \removelastskip
    \par
    \vskip\topsep
    \gdef\hhcls@fnlist{}%
    \setcounter{hhcls@savefootnote}{\value{footnote}}%
    \let\mpfootnote=\footnote
    \let\footnote\hhcls@important@footnote%
    \let\hhcls@important@figure=\figure
    \renewcommand\figure{%
      \ClassError{bgteubner}{%
        figure environment used inside
        important\ifhhcls@importantmath *\fi\space environment}{%
        Inside the important\ifhhcls@importantmath *\fi\space
        environment, floats cannot be used.}%
      \hhcls@important@figure}%
    \let\hhcls@important@table=\table
    \renewcommand\table{%
      \ClassError{bgteubner}{%
        table environment used inside
        important\ifhhcls@importantmath *\fi\space environment}{%
        Inside the important\ifhhcls@importantmath *\fi\space
        environment, floats cannot be used.}%
      \hhcls@important@table}%
    \let\hhcls@important@marginpar=\marginpar
    \renewcommand\marginpar{%
      \ClassError{bgteubner}{%
        \string\marginpar\space used inside
        important\ifhhcls@importantmath *\fi\space environment}{%
        Inside the important\ifhhcls@importantmath *\fi\space
        environment, floats cannot be used.}%
      \hhcls@important@marginpar}%
    \begin{lrbox}{\hhcls@@@important}%
      \setlength\@tempdima{\linewidth}%
      \addtolength\@tempdima{-2\fboxsep}%
      \begin{minipage}{\@tempdima}%
        \ifhhcls@importantmath
          \vspace{-\abovedisplayskip}%
        \fi
        \setlength{\parindent}{\hhcls@important@parindent}%
        \noindent
        \@setminipage
        \ignorespaces
      }{%
        \par\unskip
      \end{minipage}%
    \end{lrbox}%
    \noindent
    \colorbox{importantcolor}{%
      \setlength\@tempdima{\linewidth}%
      \addtolength\@tempdima{-2\fboxsep}%
      \begin{minipage}{\@tempdima}%
        \usebox{\hhcls@@@important}%
      \end{minipage}%
    }%
    \hhcls@fnlist
    \vskip\topsep
    \noindentnextpar
    \par
    \ignorespacesafterend
  }
  \newenvironment{important*}{%
    \hhcls@importantmathtrue
    \begin{important}%
    }{%
    \end{important}%
    \ignorespacesafterend}
  \newenvironment{longimportant}{%
    \hhcls@inimportanttrue
    \setlength{\fboxsep}{0.5\parindent}%
    \addtolengthminzero{\mathindent}{-\fboxsep}%
    \addtolengthminzero{\theorem@lmargin}{-\fboxsep}%
    \addtolengthminzero{\theorem@rmargin}{-\fboxsep}%
    \addtolengthminzero{\advanced@lmargin}{-\fboxsep}%
    \addtolengthminzero{\advanced@rmargin}{-\fboxsep}%
    \addtolengthminzero{\subexercise@lmargin}{-\fboxsep}%
    \addtolengthminzero{\subexercise@rmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@@subexerciseindent}{-\fboxsep}%
    \addtolengthminzero{\answer@lmargin}{-\fboxsep}%
    \addtolengthminzero{\answer@rmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@@answerindent}{-\fboxsep}%
    \addtolengthminzero{\subanswer@lmargin}{-\fboxsep}%
    \addtolengthminzero{\subanswer@rmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@@subanswerindent}{-\fboxsep}%
    \addtolengthminzero{\leftmargin}{-\fboxsep}%
    \addtolengthminzero{\hhcls@leftmargin}{-\fboxsep}%
    \def\FrameCommand{\colorbox{importantcolor}}%
    \renewcommand\footnote[2][]{%
      \ClassError{bgteubner}{%
        \footnote\space used inside longimportant environment}{%
        Inside the longimportant environment, footnotes cannot be
        used.\MessageBreak
        You may use the short version, the important or important*
        environment if you\MessageBreak
        really need a footnote. Be aware that these environments
        don't\MessageBreak
        break across pages.}%
    }%
    \let\hhcls@important@figure=\figure
    \renewcommand\figure{%
      \ClassError{bgteubner}{%
        figure environment used inside longimportant environment}{%
        Inside the longimportant environment, floats cannot be used.}%
      \hhcls@important@figure}%
    \let\hhcls@important@table=\table
    \renewcommand\table{%
      \ClassError{bgteubner}{%
        table environment used inside longimportant environment}{%
        Inside the longimportant environment, floats cannot be used.}%
      \hhcls@important@table}%
    \let\hhcls@important@marginpar=\marginpar
    \renewcommand\marginpar{%
      \ClassError{bgteubner}{%
        \string\marginpar\space used inside longimportant environment}{%
        Inside the longimportant environment, floats cannot be used.}%
      \hhcls@important@marginpar}%
    \MakeFramed {\advance\hsize-\width \FrameRestore
      \noindent\@setminipage}%
    \hhcls@important@workaround
    \ignorespaces
  }{%
    \par\unskip
    \endMakeFramed
    \noindentnextpar
    \par
    \ignorespacesafterend
  }
  \newenvironment{longimportant*}[1][\abovedisplayskip]{%
    \begin{longimportant}\vspace{-#1}\ignorespaces
  }{%
    \end{longimportant}%
  }
  \@ifpackagelater{framed}{2004/03/07}{%
    \newcommand*\hhcls@important@workaround{}
  }{%
    \newcommand*\hhcls@important@workaround{\vspace{0mm}}
    \ClassWarningNoLine{bgteubner}{Outdated version of framed.sty
      used. A workaround\MessageBreak
      for a bug has been installed. Future versions of\MessageBreak
      bgteubner.cls will need a version of framed.sty\MessageBreak
      that is dated 2004/03/07 or newer}
  }
\else
  \newenvironment{important}{\par}{\par}
  \newenvironment{important*}{\par}{\par}
  \newenvironment{longimportant}{\par}{\par}
  \newenvironment{longimportant*}[1][]{\par}{\par}
\fi
\newcounter{aufgabenzahl}%
\newlength{\hhcls@@exerciseindent}%
\setlength{\hhcls@@exerciseindent}{7.8398em}%
\newcounter{@exercise}
\renewcommand*\the@exercise{\@arabic\c@@exercise}
\newcommand\@exercise{\@startsection{@exercise}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}}
\if@exercisetotoc
  \newcommand*\l@@exercise[2]{\@dottedtocline{1}{1.5em}{2.3em}{%
      \def\numberline##1{%
        \hb@xt@\@tempdima{\lprefix@exercise##1\hfil}}#1}{#2}}
\else
  \newcommand*\l@@exercise[2]{}
\fi
\newcommand*\exercisename{Aufgabe}
\def\prefix@exercise{\exercisename~}%
\def\postfix@exercise{:}%
\def\prefix@exercisestar{\exercisename}%
\def\postfix@exercisestar{:}%
\def\lprefix@exercise{}%
  \g@addto@macro\hhcls@theoremlist{%
    \addtocontents{exercise}{\hhcls@theoremskip}%
  }%
\let\@exercisemark\@gobble
\newcommand*\exercisefont{\normalsize}
\newenvironment{exercise}[1]{%
  \setcounter{subtaskoffset}{0}%
  \stepcounter{aufgabenzahl}%
  \@exercise{#1}%
  \addcontentsline{exercise}{exercise}{\numberline {\the@exercise}#1}%
  \gliederungsfehler{exercise}%
  \exercisefont
}{%
  \ignorespacesafterend
  \noindentnextpar
  \par
}
\newenvironment{exercise*}[1]{%
  \setcounter{subtaskoffset}{0}%
  \stepcounter{aufgabenzahl}%
  \@exercise*{\makebox[\hhcls@@exerciseindent][l]{%
    \prefix@exercisestar\postfix@exercisestar}#1}%
  \addcontentsline{exercise}{exercise}{#1}%
  \gliederungsfehler{exercise}%
  \exercisefont
}{%
  \ignorespacesafterend
  \noindentnextpar
  \par
}
\newlength{\hhcls@@answerindent}%
\AtBeginDocument{%
  \setlength{\hhcls@@answerindent}{\hhcls@@exerciseindent}%
}
\newcounter{@answer}
\renewcommand*\the@answer{}
\newcommand\@answer{\@startsection{@answer}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\raggedsection\normalfont\sectfont\nobreak\size@subsection\nobreak}}
\if@answertotoc
  \newcommand*\l@@answer[2]{\@dottedtocline{1}{0em}{6.2em}{%
      \def\numberline##1{%
        \hb@xt@\@tempdima{\lprefix@answer##1\hfil}}#1}{#2}}
\else
  \newcommand*\l@@answer[2]{}
\fi
\ifhhcls@times
  \newcommand\answerspacing{1.12}
\else
  \newcommand\answerspacing{1.06}
\fi
\newcommand*\answername{L\"osung}
\def\prefix@answer{\answername~}%
\def\postfix@answer{:}%
\def\prefix@answerstar{\answername}%
\def\postfix@answerstar{:}%
\def\lprefix@answer{\answername~}%
\let\@answermark\@gobble
\newcommand\answerfont{\footnotesize}
\newlength{\answer@lmargin}
\newlength{\answer@rmargin}
\setmargin{answer}{0em}
\newcommand\answer[2][\@empty]{%
  \def\the@answer{\ref{#2}}%
  \@@answer{#1}%
}
\expandafter\newcommand\csname answer*\endcsname[1][\@empty]{%
  \def\the@answer{}%
  \def\prefix@answer{\prefix@answerstar}%
  \def\postfix@answer{\postfix@answerstar}%
  \@@answer{#1}%
}
\def\@@answer#1{%
  \@answer{#1}%
  \setcounter{subtaskoffset}{0}%
  \gliederungsfehler{answer}%
  \answerfont
  \let\size@subsubsection\answerfont
  \let\size@paragraph\answerfont
  \let\size@subparagraph\answerfont
  \setlength{\mathindent}{0.5\leftmargini}%
  \setlength{\abovecaptionskip}{0.89\abovecaptionskip}%
  \setkomafont{caption}{\normalfont\rmfamily\footnotesize\RaggedRight}%
  \setkomafont{float}{\normalfont\normalcolor\footnotesize}%
  \renewcommand{\subcapsize}{\footnotesize}%
    \setstretch{\answerspacing}%
}
\def\endanswer{%
  \par
  \ignorespacesafterend
  \noindentnextpar
}
\expandafter\def\csname endanswer*\endcsname{\endanswer}
\newlength{\hhcls@@subexerciseindent}%
\AtBeginDocument{%
  \setlength{\hhcls@@subexerciseindent}{\hhcls@@exerciseindent}%
}
\newcounter{@subexercise}[chapter]
\renewcommand*\the@subexercise{\thechapter.\@arabic\c@@subexercise}
\newcommand\subexercise@title[1]{%
  \iftheorem@starvariant
  \else
    \refstepcounter{@subexercise}%
  \fi
  {%
    \raggedsection\normalfont\normalsize\sectfont\nobreak
    \makebox[\hhcls@@subexerciseindent][l]{\exercisename
      \iftheorem@starvariant
      \else
        ~\the@subexercise
      \fi
    \postfix@exercise}%
    \setlength\@tempdima{1pt}%
    \settoheight\@tempdimb{D}%
    \addtolength\@tempdima{\@tempdimb}%
    \settoheight\@tempdimb{\subexercisefont D}%
    \addtolength\@tempdima{-\@tempdimb}%
    #1\nobreak\par\nobreak\vspace{\@tempdima}\nobreak}\nobreak
  \@afterheading}
\newcommand\subexercisefont{\normalfont\small}
\ifhhcls@times
  \newcommand\subexercisespacing{1.12}
\else
  \newcommand\subexercisespacing{1.06}
\fi
\newlength{\subexercise@lmargin}
\newlength{\subexercise@rmargin}
\setmargin{subexercise}{\leftmargini}
\expandafter\def\csname subexercise*\endcsname{%
  \theorem@starvarianttrue
  \subexercise
}%
\expandafter\def\csname endsubexercise*\endcsname{\endsubexercise}
\newenvironment{subexercise}[1]{%
  \par
  \begin{list}{}{%
      \itemindent-\subexercise@lmargin
      \listparindent\parindent
      \leftmargin\subexercise@lmargin
      \rightmargin\subexercise@rmargin
      \parsep\z@ \@plus\p@
      \stepcounter{aufgabenzahl}%
      \gliederungsfehler{subexercise}%
      \setcounter{subtaskoffset}{0}%
    }%
    \begin{spacing}{\subexercisespacing}%
    \item\relax
      \subexercise@title{#1}%
      \edef\hhtmp{#1}%
      \ifx\hhtmp\empty
      \else
        \iftheorem@starvariant
          \addcontentsline{exercise}{exercise}{#1}%
        \else
          \addcontentsline{exercise}{exercise}{%
            \numberline{\the@subexercise}#1}%
        \fi
      \fi
      \subexercisefont
      \let\size@subsubsection\subexercisefont
      \let\size@paragraph\subexercisefont
      \let\size@subparagraph\subexercisefont
      \ignorespaces
    }{%
    \end{spacing}%
    \removelastskip
  \end{list}%
  \ignorespacesafterend
  \noindentnextpar
  \par
}
\newlength{\hhcls@@subanswerindent}%
\AtBeginDocument{%
  \setlength{\hhcls@@subanswerindent}{\hhcls@@answerindent}%
}
\newcounter{@subanswer}
\renewcommand*\the@subanswer{}
\newcommand\subanswer@title[2]{%
  {%
    \raggedsection\normalfont\normalsize\sectfont\nobreak
    \makebox[\hhcls@@subanswerindent][l]{\answername
      \iftheorem@starvariant
      \else
        ~\ref{#1}%
      \fi
    \postfix@answer}%
    \setlength\@tempdima{1pt}%
    \settoheight\@tempdimb{D}%
    \addtolength\@tempdima{\@tempdimb}%
    \settoheight\@tempdimb{\subanswerfont D}%
    \addtolength\@tempdima{-\@tempdimb}%
    #2\nobreak\par\nobreak\vspace{\@tempdima}\nobreak}\nobreak
  \@afterheading}
\newcommand\subanswerfont{\footnotesize}
\ifhhcls@times
  \newcommand\subanswerspacing{1.12}
\else
  \newcommand\subanswerspacing{1.06}
\fi
\newlength{\subanswer@lmargin}
\newlength{\subanswer@rmargin}
\setmargin{subanswer}{\leftmargini}
\expandafter\newcommand\csname subanswer*\endcsname[1][\@empty]{%
  \theorem@starvarianttrue
  \subanswer[#1]{}%
}%
\expandafter\def\csname endsubanswer*\endcsname{\endsubanswer}
\newenvironment{subanswer}[2][\@empty]{%
  \par
  \begin{list}{}{%
      \itemindent-\subanswer@lmargin
      \listparindent\parindent
      \leftmargin\subanswer@lmargin
      \rightmargin\subanswer@rmargin
      \parsep\z@ \@plus\p@
      \gliederungsfehler{subanswer}%
      \setcounter{subtaskoffset}{0}%
    }%
    \begin{spacing}{\subanswerspacing}%
    \item\relax
      \subanswer@title{#2}{#1}%
      \let\size@subsubsection\subanswerfont
      \let\size@paragraph\subanswerfont
      \let\size@subparagraph\subanswerfont
      \subanswerfont
      \ignorespaces
    }{%
    \end{spacing}%
    \removelastskip
  \end{list}%
  \ignorespacesafterend
  \noindentnextpar
  \par
}
\newcommand*\exercise@heading{\float@listhead{\listexercisename}}
\newcommand*\listofexercises{%
  \begingroup%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \exercise@heading
    \small
    \setlength{\parskip}{\z@}%
    \@starttoc{exercise}%
    \if@restonecol\twocolumn\fi
  \endgroup
}
\newcommand*\listexercisename{List of Exercises}
\newcommand*\hhcls@germanlistexercisename{Aufgabenverzeichnis}
\addto\captionsgerman{%
  \renewcommand{\listexercisename}{\hhcls@germanlistexercisename}}%
\addto\captionsngerman{%
  \renewcommand{\listexercisename}{\hhcls@germanlistexercisename}}%
\addto\captionsaustrian{%
  \renewcommand{\listexercisename}{\hhcls@germanlistexercisename}}%
\addto\captionsnaustrian{%
  \renewcommand{\listexercisename}{\hhcls@germanlistexercisename}}%
\newcommand*\l@exercise{\@dottedtocline{1}{0em}{2.9em}}
\newenvironment{exercisedelimiter}[1]{%
  \def\postfix@exercise{#1}%
  \def\postfix@exercisestar{#1}%
  \def\postfix@answer{#1}%
  \def\postfix@answerstar{#1}%
  \ignorespaces
}{%
  \ignorespacesafterend
}%
\newcounter{subtask}
\newcounter{subtaskoffset}[@exercise]%
\renewcommand\thesubtask{\alph{subtask}}%
\newenvironment{subtask}{%
  \begin{list}{\thesubtask)}{\usecounter{subtask}%
      \parskip\z@%
      \itemsep\z@%
      \parsep\z@
      \listparindent\parindent
      \setcounter{subtask}{\value{subtaskoffset}}}}{%
    \setcounter{subtaskoffset}{\value{subtask}}%
  \end{list}%
  \ignorespacesafterend
  \noindentnextpar\par}
\newcommand\subtaskref[1]{\ref{#1})}
\renewcommand*\labelenumii{\theenumii.}
\newcommand*\preface[1]{%
  \begingroup
  \@openrightfalse
  \chapter*{#1}%
  \markboth{}{}%
  \endgroup
  \noindentnextpar\par
}
\newcommand*\signature[3]{%
  \par\bigskip
  \begin{minipage}[t]{0.45\linewidth}%
    #1,\\
    #2%
  \end{minipage}%
  \hfill
  \begin{minipage}[t]{0.5\linewidth}%
    \itshape\raggedleft
    #3%
  \end{minipage}%
}
\let\@author=\@empty
\let\@title\@empty
\let\@subtitle\@empty
\@ifundefined{subtitle}{%
  \newcommand\subtitle[1]{\gdef\@subtitle{#1}}%
}{}
\let\@edition\@empty
\newcommand*\edition[1]{\gdef\@edition{#1}}
\edition{1}
\newwrite\hhcls@fileinfo
\immediate\openout\hhcls@fileinfo\jobname.info
\AtEndDocument{%
  \ifpdf
    \if\@title\@empty\else\pdfinfo{/Title (\@title)}\fi
    \if\@subtitle\@empty
      \pdfinfo{/Subject (\@edition. Auflage)}%
    \else
      \pdfinfo{/Subject (\@subtitle\space (\@edition. Auflage))}%
    \fi
    \ifx\@author\@empty
    \else
      \pdfinfo{/Author (\@author)}%
    \fi
    % If you modify a renamed copy of the files `bgteubner.cls' or
    % `bgteucls.dtx', you have to preserve some information in the
    % PDF /Creator entry. The following data have to remain:
    % - The name `bgteubner.cls',
    % - a hint that this class has been developed for the `Teubner
    %   Verlag, Wiesbaden, Germany'.
    \begingroup
    \GetFileInfo{bgteubner.cls}%
    \pdfinfo{/Creator (document class bgteubner.cls for the
      Springer Vieweg Verlag, Wiesbaden, Germany, by Harald Harders
      \fileversion)}%
    \endgroup
    \pdfinfo{/Keywords (Bild: \thebilderzahl; Tabelle: \thetabellenzahl;
      Aufgabe: \theaufgabenzahl\hhcls@theoremanzahl)}%
  \fi
  \if\@title\@empty
  \else
    \immediate\write\hhcls@fileinfo{Titel: \@title}%
  \fi
  \if\@subtitle\@empty
  \else
    \immediate\write\hhcls@fileinfo{Untertitel: \@subtitle}%
  \fi
  \if\@subtitle\@empty
  \fi
  \immediate\write\hhcls@fileinfo{\@edition. Auflage}%
  \ifx\@author\@empty
  \else
    \immediate\write\hhcls@fileinfo{Autor(en): \@author}%
  \fi
  \immediate\write\hhcls@fileinfo{Bild: \thebilderzahl; Tabelle:
    \thetabellenzahl; Aufgabe: \theaufgabenzahl\hhcls@theoremanzahl}%
}
\ifhhcls@titlepage
\renewcommand*\maketitle{%
  \edef\hhcls@tmppage{\arabic{page}}%
  \begin{titlepage}%
    \renewcommand{\sfdefault}{phv}%
    \ifx\@title\@empty
      \ClassError{bgteubner}{No title given}{Define a title using
        \string\title{Titel}}
    \fi
    \ifx\@author\@empty
      \ClassError{bgteubner}{No author given}{Define
        an author using \string\author{Name}.}
    \fi
    \newlength{\hhcls@parindent}%
    \setlength{\hhcls@parindent}{2.5\parindent}%
    \setlength{\parindent}{0mm}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
    \let\@oldmakefnmark\@makefnmark
    \def\@makefnmark{\rlap\@oldmakefnmark}
    \begin{center}
      \sffamily\Large
      {\bfseries\LARGE \@author}%
      \vskip 2.5em
      \par
      {\bfseries\iftensor@bold\else\mathversion{bold}\fi\Huge\@title\par}
      \ifx\@subtitle\@empty
      \else
        \vskip 2.5em
        {\bfseries\iftensor@bold\else\mathversion{bold}\fi
          \LARGE\@subtitle\par}
      \fi
      \vskip 2.5em
      \par
      \@ifundefined{hhclsbilderzahl}{%
        Mit
        \textbf{??}~Abbildungen,
        \textbf{???}~Tabellen
        und
        \textbf{???}~Aufgaben
      }{%
        \ifnum\hhclsbilderzahl=0\relax
          \ifnum\hhclstabellenzahl=0\relax
            \ifnum\hhclsaufgabenzahl=0\relax
            \else
              Mit \hhclsaufgabenzahl~Aufgaben
            \fi
          \else
            Mit \hhclstabellenzahl~Tabellen
            \ifnum\hhclsaufgabenzahl=0\relax
            \else
              und \hhclsaufgabenzahl~Aufgaben
            \fi
          \fi
        \else
          Mit \hhclsbilderzahl~Abbildungen%
          \ifnum\hhclstabellenzahl=0\relax
            \ifnum\hhclsaufgabenzahl=0\relax
            \else
              \space und \hhclsaufgabenzahl~Aufgaben
            \fi
          \else
            \ifnum\hhclsaufgabenzahl=0\relax
              \space und \hhclstabellenzahl~Tabellen
            \else
              , \hhclstabellenzahl~Tabellen
              und \hhclsaufgabenzahl~Aufgaben
            \fi
          \fi
        \fi
      }%
      \ifhhcls@entwurf
        \vskip 2.5em
        \par
        \strut\"Ubersetzt: \today, \now
      \fi
      \vfill
      \par
      \ifx\@edition\@empty
      \else
        \ifnum1<1\@edition
          \ifnum1<0\@edition\relax
            \@edition.~Auf\/lage%
            \vskip 4em
          \fi
        \else
          \@edition
          \vskip 4em
        \fi
      \fi
      \par
      {\Large \hhcls@publisher\par}
    \end{center}
  \end{titlepage}
  \next@tpage\cleardoubleemptypage
  \setcounter{page}{\hhcls@tmppage}%
   \ifx\@dedication\@empty \else
     \next@tpage\null\vfill
     {\centering \Large \@dedication \par}
     \vskip \z@ \@plus3fill
     \if@twoside \next@tpage\cleardoublepage \fi
   \fi
  \global\let\maketitle\relax
}
\else
  \renewcommand\maketitle{%
    \ClassWarningNoLine{bgteubner}{Titlepage switched off for final print}%
    \ifx\@dedication\@empty \else
      \begin{titlepage}
        \next@tpage\null\vfill
        {\centering \Large \@dedication \par}
        \vskip \z@ \@plus3fill
        \if@twoside \next@tpage\cleardoublepage \fi
      \end{titlepage}
    \fi
    \global\let\maketitle\relax
  }
\fi
\ifhhcls@entwurf
  \newlength{\hhtmplen}%
  \setlength{\hhtmplen}{0.35145980351\textwidth}%
  \typeout{^^JText width: \strip@pt\hhtmplen mm}%
  \setlength{\hhtmplen}{0.35145980351\textheight}%
  \typeout{Text block: \strip@pt\hhtmplen}%
  \setlength{\hhtmplen}{\headheight}%
  \addtolength{\hhtmplen}{\headsep}%
  \addtolength{\hhtmplen}{\textheight}%
  \setlength{\hhtmplen}{0.35145980351\hhtmplen}%
  \typeout{Total height: \strip@pt\hhtmplen mm}%
  \setlength{\hhtmplen}{0.35145980351\baselineskip}%
  \typeout{Baseline skip: \strip@pt\hhtmplen mm^^J}%
\fi
\newcommand\verboten[1]{%
  \BeforePackage{#1}{%
    \ClassError{bgteubner}{Forbidden package `#1' loaded}{%
      You are not allowed to load the package `#1' because it^^J%
      changes the layout. This error message occurs one line below^^J%
      the line.}}%
}
\verboten{a4wide}
\verboten{a4}
\verboten{a5comb}
\verboten{a5}
\verboten{aeguill}
\verboten{ae}
\verboten{appendix}
\verboten{avantgar}
\verboten{avant}
\verboten{bibgerm}
\verboten{bookman}
\verboten{caption2}
\verboten{caption}
\verboten{chancery}
\verboten{chappg}
\verboten{charter}
\verboten{cmbright}
\verboten{concmath}
\verboten{doublespace}
\verboten{dropcaps}
\verboten{eco}
\verboten{endfloat}
\verboten{epsfig}
\verboten{eulervm}
\verboten{extsizes}
\verboten{fandyhdr}
\verboten{figcaps}
\verboten{floatfig}
\verboten{floatflt}
\verboten{fltpage}
\verboten{french}
\verboten{geometry}
\verboten{geomsty}
\verboten{german}
\verboten{graphics}
\verboten{hangcaption}
\verboten{hangftn}
\verboten{hanging}
\verboten{helvetic}
\verboten{here}
\verboten{hvmath}
\verboten{indentfirst}
\verboten{initials}
\verboten{landscape}
\verboten{lmodern}
\verboten{lucidabr}
\verboten{lucidaso}
\verboten{mathptm}
\verboten{mathsans}
\verboten{mathtime}
\verboten{ncntrsbk}
\verboten{newcent}
\verboten{ngerman}
\verboten{palatcm}
\verboten{palatino}
\verboten{sansmath}
\verboten{sectsty}
\verboten{times}
\verboten{titlesec}
\verboten{utopia}
\verboten{zapfchan}
\verboten{zefonts}
\endinput
%%
%% End of file `bgteubner.cls'.
