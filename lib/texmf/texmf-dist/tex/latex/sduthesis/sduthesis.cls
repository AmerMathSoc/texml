%%
%% This is file `sduthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% sduthesis.dtx  (with options: `class')
%% 
%% -----------------------------------
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2012 -- 2016 by Liam Huang
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Liam Huang.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{sduthesis}
  [2016/05/28 v1.2.1 Thesis Template of Shandong University]
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{family=SDU, prefix=SDU@opt@, setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{SDU}{#1}}
\DeclareBoolOption[true]{chsstyle}
\DeclareComplementaryOption{nochsstyle}{chsstyle}
\DeclareBoolOption[false]{print}
\DeclareComplementaryOption{noprint}{print}
\DeclareBoolOption[true]{double}
\DeclareComplementaryOption{single}{double}
\DeclareDefaultOption{\PassOptionsToPackage{\CurrentOption}{ctexcap}}
\LoadClass[a4paper, cs4size, UTF8, hyperref, fancyhdr]{ctexbook}
\ProcessKeyvalOptions*\relax
\ifSDU@opt@double\relax\else
  \PassOptionsToClass{oneside}{ctexbook}
\fi
\RequirePackage{ifpdf,ifxetex}
\RequirePackage{geometry}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{amsbsy}
\RequirePackage{bm}
\RequirePackage{mathrsfs}
\RequirePackage{booktabs}
\ifxetex
  \RequirePackage{graphicx}
\else
  \ifpdf
    \RequirePackage{graphicx}
    \RequirePackage{epstopdf}
  \else
    \RequirePackage[dvipdfmx]{graphicx}
    \RequirePackage{bmpsize}
  \fi
\fi
\RequirePackage{xcolor}
\RequirePackage{makecell}
\newcommand{\fzbHei}{\heiti}
\linespread{1.3}
\setlength{\parskip}{0.3ex}
\ifSDU@opt@double
  \geometry{left=2.5cm, right=3cm, top=3cm, bottom=3cm}
\else
  \geometry{left=2.75cm, right=2.75cm, top=3cm, bottom=3cm}
\fi
\AtBeginDocument{\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrule}{%
  \hrule\@height1.5pt\@width\headwidth%
  \vskip1pt%
  \hrule\@height\headrulewidth\@width\headwidth%
}
\fancyhead[C]{%
  \ifSDU@opt@chsstyle
    \chead{\zihao{5}山东大学学士学位论文}
  \else
    \chead{\small Shandong University Bachelor Thesis}
  \fi
}
\fancyfoot[OR, EL]{--~{\thepage}~--}}
\newcommand*{\me}{\ensuremath{\mathrm{e}}}
\newcommand*{\mi}{\ensuremath{\mathrm{i}}}
\newcommand*{\dif}{\ensuremath{\mathop{}\!\mathrm{d}}}
\DeclareMathAlphabet{\mathsfsl}{OT1}{cmss}{m}{sl}
\newcommand*{\VEC}[1]{\ensuremath{\boldsymbol{#1}}}
\newcommand*{\MATRIX}[1]{\ensuremath{\mathsfsl{#1}}}
\newcommand*{\TENSOR}[1]{\ensuremath{\mathsfsl{#1}}}
\newcommand*{\HUA}[1]{\ensuremath{\mathscr{{#1}}}}
\newcommand*{\SHUANG}[1]{\ensuremath{\mathbb{{#1}}}}
\numberwithin{equation}{chapter}
\graphicspath{{figures/}{figure/}{pictures/}
      {picture/}{pic/}{pics/}{image/}{images/}}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}
\newcommand{\figcaption}{\def\@captype{figure}\caption}
\newcommand{\tabcaption}{\def\@captype{table}\caption}
\AtBeginDocument{\hypersetup{colorlinks=true, linkcolor=blue}}
\ifSDU@opt@print
  \AtBeginDocument{\hypersetup{hidelinks}}
\else\relax\fi
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}
\newcommand\enabstractname{ABSTRACT}
\newcommand\enkeywordsname{Key words}
\newcommand\enkeywords[1]{%
  \vspace{1cm}\noindent{\bfseries\zihao{-4}\enkeywordsname: }#1}
\newcommand\cnabstractname{摘\quad 要}
\newcommand\cnkeywordsname{关键词}
\newcommand\cnkeywords[1]{%
  \vspace{1cm}\noindent{\bfseries\zihao{-4}\cnkeywordsname: }#1}
\newenvironment{enabstract}{%
  \newpage
  \centering
  \begin{minipage}{.9\textwidth}
  \centerline{\zihao{-3}\bfseries\enabstractname}\vspace{.3cm}
  \centering
  \begin{minipage}{.85\textwidth}
  \setlength{\parindent}{1.2em}
}{
\end{minipage}
\end{minipage}
\clearpage
}
\newenvironment{cnabstract}{%
  \newpage
  \centering
  \begin{minipage}{.9\textwidth}
  \centerline{\zihao{-3}\bfseries\cnabstractname}\vspace{.3cm}
  \centering
  \begin{minipage}[c]{.85\textwidth}
  \setlength{\parindent}{2em}
  \zihao{-4}
}{
\end{minipage}
\end{minipage}
\clearpage
}
\ifSDU@opt@chsstyle
  \CTEXsetup[name={第,章}]{chapter}
  \CTEXsetup[number={\chinese{chapter}}]{chapter}
  \CTEXsetup[format={\centering}]{chapter}
  \CTEXsetup[nameformat={\bfseries\zihao{3}}]{chapter}
  \CTEXsetup[titleformat={\bfseries\zihao{3}}]{chapter}
  \CTEXsetup[aftername={\quad{}}]{chapter}
  \CTEXsetup[beforeskip={10pt}]{chapter}
  \CTEXsetup[afterskip={10pt}]{chapter}
  \CTEXsetup[name={$\S$\,,}]{section}
  \CTEXsetup[format={\bfseries\flushleft\zihao{4}}]{section}
  \CTEXsetup[format={\bfseries\flushleft\zihao{-4}}]{subsection}
  \CTEXsetup[format={\flushleft\zihao{-4}}]{subsubsection}
  \CTEXsetup[name={附录~}]{appendix}
  \CTEXsetup[number={\Alph{chapter}}]{appendix}
\else
  \PassOptionsToClass{nocap, noindent}{ctexbook}
\fi
\input{sduthesis-cover.def}
\input{sduthesis-statement.def}
\newcommand{\maketitlepagestatement}{%
\maketitlepage
\thispagestyle{empty}
~
\vfill\eject
\thispagestyle{empty}
\makestatement
\vfill\eject
\thispagestyle{empty}
~
\vfill\eject
\setcounter{page}{1}
\frontmatter
}
\let\savedtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
  \savedtableofcontents
    \ifSDU@opt@double
    \cleardoublepage
  \else
    \clearpage
  \fi
  \mainmatter
}
\endinput
%% 
%% Copyright (C) 2012 -- 2016 by Liam Huang
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Liam Huang.
%% 
%% -----------------------------------
%% 
%% This work consists of the file  sduthesis.dtx and sduthesis.ins
%% and the derived files           sduthesis.cls,
%%                                 sduthesis-cover.def,
%%                                 sduthesis-statement.def,
%%                                 figures/,
%%                                 sduthesis-demo.tex,
%%                                 README.md,
%%                                 LICENSE.md,
%%                                 sduthesis.pdf and
%%                                 sduthesis-demo.pdf.
%%
%% End of file `sduthesis.cls'.
