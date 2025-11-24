%%
%% This is file `ulthese.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ulthese.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2016 Universite Laval
%% 
%% This file may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3c of this
%% license or (at your option) any later version. The latest version
%% of this license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2006/05/20 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Universite Laval
%% <ulthese-dev@bibl.ulaval.ca>.
%% 
%% This work consists of the files ulthese.dtx and ulthese.ins and the
%% derived files listed in the README file.
%% 
\NeedsTeXFormat{LaTeX2e}[2009/09/24]
\ProvidesClass{ulthese}%
  [2016/03/29 v4.2 Classe pour les theses et memoires de l'Universite Laval]
\RequirePackage{ifthen}
\RequirePackage{ifxetex}
\newboolean{UL@babel}           % charger babel ou non
\newboolean{UL@natbib}          % charger natbib ou non
\newboolean{UL@isprogmasc}      % nom de programme masculin ou non
\newboolean{UL@isexam}          % examen de doctorat ou non
\newboolean{UL@hassubtitle}     % document a un sous-titre ou non
\setboolean{UL@natbib}{true}
\DeclareOption{nonatbib}{\setboolean{UL@natbib}{false}}
\setboolean{UL@babel}{true}
\DeclareOption{nobabel}{\setboolean{UL@babel}{false}}
\newcommand*{\UL@ptsize}{}
\DeclareOption{10pt}{%
  \PassOptionsToClass{10pt}{memoir}
  \renewcommand*{\UL@ptsize}{10}}
\DeclareOption{11pt}{%
  \PassOptionsToClass{11pt}{memoir}
  \renewcommand*{\UL@ptsize}{11}}
\DeclareOption{12pt}{%
  \PassOptionsToClass{12pt}{memoir}
  \renewcommand*{\UL@ptsize}{12}}
\newcommand*{\UL@typenum}{}
\DeclareOption{LLD}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{true}
  \newcommand*{\UL@typeofdoc}{Th\`ese}
  \newcommand*{\UL@degree}{Docteur en droit (L.L.D.)}}
\DeclareOption{DPsy}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{true}
  \newcommand*{\UL@typeofdoc}{Th\`ese}
  \newcommand*{\UL@degree}{Docteur en psychologie (D.Psy.)}}
\DeclareOption{DThP}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{true}
  \newcommand*{\UL@typeofdoc}{Th\`ese}
  \newcommand*{\UL@degree}{Docteur en th\'eologie pratique (D.Th.P.)}}
\DeclareOption{PhD}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{true}
  \newcommand*{\UL@typeofdoc}{Th\`ese}
  \newcommand*{\UL@degree}{Philosophi{\ae} doctor (Ph.D.)}}
\DeclareOption{LLM}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{false}
  \newcommand*{\UL@typeofdoc}{M\'emoire}
  \newcommand*{\UL@degree}{Ma\^itre en droit (L.L.M.)}}
\DeclareOption{MA}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{false}
  \newcommand*{\UL@typeofdoc}{M\'emoire}
  \newcommand*{\UL@degree}{Ma\^itre \`es arts (M.A.)}}
\DeclareOption{MMus}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{false}
  \newcommand*{\UL@typeofdoc}{M\'emoire}
  \newcommand*{\UL@degree}{Ma\^itre en musique (M.Mus.)}}
\DeclareOption{MSc}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{false}
  \newcommand*{\UL@typeofdoc}{M\'emoire}
  \newcommand*{\UL@degree}{Ma\^itre \`es sciences (M.Sc.)}}
\DeclareOption{MServSoc}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{false}
  \newcommand*{\UL@typeofdoc}{M\'emoire}
  \newcommand*{\UL@degree}{Ma\^itre en service social (M.Serv.Soc.)}}
\DeclareOption{MScGeogr}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{false}
  \newcommand*{\UL@typeofdoc}{M\'emoire}
  \newcommand*{\UL@degree}{Ma\^itre en sciences g\'eographiques (M.Sc.G\'eogr.)}}
\DeclareOption{MATDR}{%
  \renewcommand*{\UL@typenum}{0}
  \setboolean{UL@isprogmasc}{false}
  \newcommand*{\UL@typeofdoc}{M\'emoire}
  \newcommand*{\UL@degree}{Ma\^itre en am\'enagement du territoire et d\'eveloppement r\'egional (M.ATDR)}}
\DeclareOption{multifacultaire}{%
  \renewcommand*{\UL@typenum}{1}}
\DeclareOption{cotutelle}{%
  \renewcommand*{\UL@typenum}{2}
  \protected@edef\UL@typeofdoc{\UL@typeofdoc\ en cotutelle}}
\DeclareOption{bidiplomation}{%
  \renewcommand*{\UL@typenum}{2}
  \protected@edef\UL@typeofdoc{\UL@typeofdoc}}
\DeclareOption{extensionUdeS}{%
  \renewcommand*{\UL@typenum}{3}
  \newcommand*{\UL@extensionat}{Universit\'e de Sherbrooke}
  \newcommand*{\UL@extensionloc}{Sherbrooke, Qu\'ebec}}
\DeclareOption{extensionUQO}{%
  \renewcommand*{\UL@typenum}{3}
  \newcommand*{\UL@extensionat}{Universit\'e du Qu\'ebec en Outaouais}
  \newcommand*{\UL@extensionloc}{Gatineau, Qu\'ebec}}
\DeclareOption{extensionUQAC}{%
  \renewcommand*{\UL@typenum}{3}
  \newcommand*{\UL@extensionat}{Universit\'e du Qu\'ebec \`a Chicoutimi}
  \newcommand*{\UL@extensionloc}{Chicoutimi, Qu\'ebec}}
\setboolean{UL@isexam}{false}
\DeclareOption{examen}{%
  \ifthenelse{\equal{\UL@typeofdoc}{Th\`ese}}{%
    \setboolean{UL@isexam}{true}
    \renewcommand*{\UL@typeofdoc}{Examen de doctorat}}{%
    \ClassError{ulthese}{%
      Incompatible option examen}
    {Use this option with a thesis type only.}}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ExecuteOptions{11pt,letterpaper}
\ProcessOptions
\ifx\UL@typenum\empty
  \ClassError{ulthese}{%
    No thesis type specified}
    {Declare the thesis type as a class option.}
\fi
\LoadClass[oneside]{memoir}
\ifxetex
  \RequirePackage{fontspec}
  \RequirePackage{unicode-math}
  \defaultfontfeatures{Ligatures=TeX}
\else
  \RequirePackage[T1]{fontenc}
\fi
\ifthenelse{\boolean{UL@natbib}}{\RequirePackage{natbib}}{}
\ifthenelse{\boolean{UL@babel}}{%
  \RequirePackage{babel}
  \RequirePackage[autolanguage]{numprint}}{}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{textcomp}
\AtBeginDocument{%
  \@ifpackageloaded{geometry}{%
    \ClassError{ulthese}{%
      Package geometry is incompatible with this class}
    {Use the memoir class facilities to change the page layout.}}{\relax}}
\definecolor{ULlinkcolor}{rgb}{0,0,0.3}
\setlrmarginsandblock{30mm}{30mm}{*}
\setulmarginsandblock{25mm}{25mm}{*}
\checkandfixthelayout[nearest]
\setlength{\footskip}{\lowermargin}
\addtolength{\footskip}{-10mm}
\renewcommand{\@pnumwidth}{3em}
\renewcommand{\@tocrmarg}{4em}
\OnehalfSpacing
\setlength{\parskip}{0.5\baselineskip}
\setlength{\parindent}{0em}
\renewcommand{\tocheadstart}{\SingleSpacing\chapterheadstart}
\renewcommand{\lotheadstart}{\SingleSpacing\chapterheadstart}
\renewcommand{\lofheadstart}{\SingleSpacing\chapterheadstart}
\pagestyle{plain}
\newcommand*{\UL@phvfamily}{\fontencoding{T1}\fontfamily{phv}\selectfont}
\ifnum\UL@ptsize=10\relax
  \newcommand*{\UL@fonttitle}{\normalfont\huge\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontsubtitle}{\normalfont\LARGE\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontauthor}{\normalfont\Large\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontprogram}{\UL@fontauthor}
  \newcommand*{\UL@fontbase}{\normalfont\Large\UL@phvfamily}
\fi
\ifnum\UL@ptsize=11\relax
  \newcommand*{\UL@fonttitle}{\normalfont\LARGE\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontsubtitle}{\normalfont\Large\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontauthor}{\normalfont\large\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontprogram}{\UL@fontauthor}
  \newcommand*{\UL@fontbase}{\normalfont\large\UL@phvfamily}
\fi
\ifnum\UL@ptsize=12\relax
  \newcommand*{\UL@fonttitle}{\normalfont\Large\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontsubtitle}{\normalfont\large\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontauthor}{\normalfont\normalsize\bfseries\UL@phvfamily}
  \newcommand*{\UL@fontprogram}{\UL@fontauthor}
  \newcommand*{\UL@fontbase}{\normalfont\normalsize\UL@phvfamily}
\fi
\newcommand{\UL@maintitle}{}
\newcommand{\UL@subtitle}{}
\newcommand*{\UL@author}{}
\newcommand*{\UL@year}{}
\newcommand*{\UL@program}{}
\newcommand*{\UL@director}{}
\newcommand*{\UL@codirector}{}
\newcommand*{\UL@nameother}{}
\newcommand*{\UL@degreeother}{}
\newcommand*{\UL@facUL}{}
\newcommand*{\UL@facother}{}
\newcommand{\titre}[1]{\renewcommand{\UL@maintitle}{#1}}
\newcommand{\soustitre}[1]{%
  \setboolean{UL@hassubtitle}{true}
  \renewcommand{\UL@subtitle}{#1}}
\newcommand*{\auteur}[1]{\renewcommand*{\UL@author}{#1}}
\newcommand*{\annee}[1]{\renewcommand*{\UL@year}{#1}}
\newcommand*{\programme}[1]{\renewcommand*{\UL@program}{#1}}
\newcommand*{\direction}[1]{\renewcommand*{\UL@director}{#1}}
\newcommand*{\codirection}[1]{\renewcommand*{\UL@codirector}{#1}}
\newcommand*{\univcotutelle}[1]{\renewcommand*{\UL@nameother}{#1}}
\newcommand*{\gradecotutelle}[1]{\renewcommand*{\UL@degreeother}{#1}}
\newcommand*{\univbidiplomation}[1]{\renewcommand*{\UL@nameother}{#1}}
\newcommand*{\gradebidiplomation}[1]{\renewcommand*{\UL@degreeother}{#1}}
\newcommand{\faculteUL}[1]{\renewcommand*{\UL@facUL}{#1}}
\newcommand*{\faculteUdeS}[1]{\renewcommand*{\UL@facother}{#1}}
\newcommand*{\faculteUQO}[1]{\renewcommand*{\UL@facother}{#1}}
\newcommand*{\faculteUQAC}[1]{\renewcommand*{\UL@facother}{#1}}
\newsavebox{\UL@titlebox}
\newsavebox{\UL@subtitlebox}
\newlength{\UL@titleboxtotht}
\newlength{\UL@subtitleboxtotht}
\newcommand{\UL@measuretitle}{%
  \setbox\UL@titlebox=\vbox{%
    \centering\UL@fonttitle\UL@maintitle}
  \setlength{\UL@titleboxtotht}{%
    \dimexpr\ht\UL@titlebox+\dp\UL@titlebox}
  \ifthenelse{\boolean{UL@hassubtitle}}{%
    \setbox\UL@subtitlebox=\vbox{%
      \centering\vspace*{0.5\baselineskip}\UL@fontsubtitle\UL@subtitle}
    \setlength{\UL@subtitleboxtotht}{%
      \dimexpr\ht\UL@subtitlebox+\dp\UL@subtitlebox}}{}}
\newcommand{\UL@docid}{%
  {\UL@fontprogram\UL@typeofdoc\par
  \ifnum\UL@typenum=2 \UL@program\par \fi}}
\newcommand{\UL@details}{%
  \ifcase\UL@typenum\relax% 0 standard
    \vspace{96pt}
    {\UL@fontprogram\UL@program}\par
    \UL@degree\par
    \vspace{112pt}
    Qu\'ebec, Canada\par
  \or%                      1 multifacultaire
    \vspace{96pt}
    {\UL@fontprogram\UL@program}\par
    \UL@degree\par
    \vspace{36pt}
    \ifx\UL@facUL\empty
      \ClassWarningNoLine{ulthese}{UL faculty names missing.}
    \else
      \UL@facUL\par
    \fi
    \vspace{48pt}
    Qu\'ebec, Canada\par
  \or%                      2 cotutelle et bidiplomation
    \vspace{72pt}
    Universit\'e Laval\par Qu\'ebec, Canada\par
    \UL@degree\par
    \vspace{\baselineskip} et\par \vspace{\baselineskip}
    \ifx\UL@nameother\empty
      \ClassWarningNoLine{ulthese}{Other university name and location missing}
    \else
      \UL@nameother\par
    \fi
    \ifx\UL@degreeother\empty
      \ClassWarningNoLine{ulthese}{Other university degree missing}
    \else
      \UL@degreeother\par
    \fi
  \or%                      3 extension
    \vspace{48pt}
    {\UL@fontprogram\UL@program\ de l'Universit\'e Laval\par
      \ifthenelse{\boolean{UL@isprogmasc}}{offert}{offerte}
      en extension \`a l'\UL@extensionat}\par
    \vspace{36pt}
    \UL@degree\par
    \vspace{36pt}
    \ifx\UL@facother\empty
      \ClassWarningNoLine{ulthese}{Other university faculty name missing}
    \else
      \UL@facother\par
    \fi
    \UL@extensionat\par
    \UL@extensionloc\par
    \vspace{\baselineskip}
    \ifx\UL@facUL\empty
      \ClassWarningNoLine{ulthese}{UL faculty name missing}
    \else
      \UL@facUL\par
    \fi
    Universit\'e Laval\par Qu\'ebec, Canada\par
  \fi}
\newlength{\UL@docidspacing}
\setlength{\UL@docidspacing}{82pt}
\newlength{\UL@authorspacing}
\setlength{\UL@authorspacing}{72pt}
\newcommand{\pagestitre}{{%
    \clearpage
    \pagestyle{empty}
    \SingleSpacing\setlength{\parskip}{0pt}
    \centering
    \UL@fontbase
    \UL@measuretitle
    \addtolength{\UL@docidspacing}{-\UL@titleboxtotht}
    \addtolength{\UL@docidspacing}{-\UL@subtitleboxtotht}
    \ifdim\UL@docidspacing<\baselineskip\relax
      \setlength{\UL@docidspacing}{\baselineskip}
      \addtolength{\UL@authorspacing}{-\baselineskip}
    \fi
    \ifnum\UL@typenum>1\relax
      \vspace*{0pt}\par
    \else
      \includegraphics[height=15mm,keepaspectratio=true]{ul_p}\par
    \fi
    \vspace{82pt}
    \copy\UL@titlebox
    \copy\UL@subtitlebox
    \vspace{\UL@docidspacing}
    \UL@docid
    \vspace{\UL@authorspacing}
    {\UL@fontauthor\UL@author}\par
    \UL@details
    \vfill
    {\textcopyright} \UL@author, \UL@year\par
    \ifthenelse{\boolean{UL@isexam}}{}{%
      \clearpage
      \ifnum\UL@typenum>1\relax
      \vspace*{0pt}\par
      \else
      \rule{0mm}{15mm}\par      % strut
      \fi
      \vspace{82pt}
      \box\UL@titlebox
      \box\UL@subtitlebox
      \vspace{\UL@docidspacing}
      \UL@docid
      \vspace{\UL@authorspacing}
      {\UL@fontauthor\UL@author}\par
      \vspace{72pt}
      Sous la direction de:\par
      \vspace{\baselineskip}
      \UL@director\par
      \UL@codirector}
    \clearpage}}
\newcommand{\pagetitre}{
  \ClassWarning{ulthese}{Command \protect\pagetitre\space is obsolete.\MessageBreak
    Using \protect\pagestitre\space instead}\pagestitre}
\ifthenelse{\boolean{UL@babel}}{%
  \addto\captionsfrench{\renewcommand{\listfigurename}{Liste des figures}}}{}
\newcommand{\dedicace}[1]{{%
    \clearpage
    \pagestyle{empty}
    \setlength{\beforeepigraphskip}{10\baselineskip}
    \setlength{\epigraphrule}{0pt}
    \epigraphtextposition{flushright}
    \mbox{}\epigraph{\itshape #1}{}}}
\newcommand{\epigraphe}[2]{{%
    \clearpage
    \pagestyle{empty}
    \setlength{\beforeepigraphskip}{10\baselineskip}
    \mbox{}\epigraph{#1}{#2}}}
\renewenvironment{quote}{%
  \list{}{\rightmargin 10mm \leftmargin 10mm}%
  \item[]}{\endlist}
\renewenvironment{quotation}{%
  \list{}{%
    \SingleSpacing
    \listparindent 0em
    \itemindent    \listparindent
    \leftmargin    10mm
    \rightmargin   \leftmargin
    \parsep        6\p@ \@plus\p@}%
  \item[]}{\endlist}
\setsecnumdepth{subsection}
\endinput
%%
%% End of file `ulthese.cls'.
