%%
%% This is file `sageep.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% sageep.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from sageep.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file sageep.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
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
\ProvidesClass{sageep}
[2009/01/14 v1.0 Typesetting Papers for Environmental and
  Engineering Geophysical Society's Annual Meeting]
\long\def\sageep@size@warning#1{%
  \ClassWarning{sageep}{Size-changing option #1 will not be
    honored}}%
\DeclareOption{8pt}{\sageep@size@warning{\CurrentOption}}%
\DeclareOption{9pt}{\sageep@size@warning{\CurrentOption}}%
\DeclareOption{10pt}{\sageep@size@warning{\CurrentOption}}%
\DeclareOption{11pt}{\sageep@size@warning{\CurrentOption}}%
\DeclareOption{12pt}{\sageep@size@warning{\CurrentOption}}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt]{article}
\usepackage{mathptmx}
\usepackage[scaled]{helvet}
\usepackage{courier}
\RequirePackage[top=0.75in, left=0.75in, right=0.75in, bottom=1in]{geometry}
\setlength{\parindent}{0.5in}
\RequirePackage{indentfirst}
\pagestyle{empty}
\renewcommand{\author}[1]{%
  \ifx\@empty\authors
     \gdef\authors{#1}%
  \else
     \g@addto@macro\authors{\and#1}%
  \fi}
\let\authors\@empty
\def\maketitle{%
  \bgroup
  \centering
  \ifx\@empty\@title\relax
  \else
    {\large\bfseries\MakeUppercase{\@title}\par\vspace{\baselineskip}}%
  \fi
  \ifx\@empty\authors\relax
  \else
    {\let\and=\linebreak
      \normalfont\itshape\authors\par\vspace{\baselineskip}}%
  \fi
  \egroup}
\setcounter{secnumdepth}{0}
\renewcommand\section{\@startsection{section}{1}{0pt}{\baselineskip}%
  {\baselineskip}{\normalfont\centering\large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{0pt}{\baselineskip}%
  {1sp}{\normalfont\normalsize\itshape\bfseries}}
\RequirePackage{caption}
\captionsetup{labelfont=bf, indent=0pt, singlelinecheck=off}
\captionsetup[table]{position=above}
\renewcommand{\textfraction}{0.05}
\renewcommand{\topfraction}{0.95}
\renewcommand{\bottomfraction}{0.95}
\renewcommand{\floatpagefraction}{0.35}
\setcounter{totalnumber}{5}
\RequirePackage[round]{natbib}
\let\cite=\citep
\endinput
%%
%% End of file `sageep.cls'.
