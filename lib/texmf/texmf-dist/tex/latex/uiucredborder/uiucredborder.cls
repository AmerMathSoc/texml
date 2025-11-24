%%
%% This is file `uiucredborder.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% uiucredborder.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2000 Scott Pakin <pakin@uiuc.edu>
%% -------------------------------------------------------
%% 
%% This package may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.2
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
%% File: uiucredborder.dtx Copyright (C) 2000 Scott Pakin <pakin@uiuc.edu>
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uiucredborder}
   [2000/11/02 v1.00 UIUC red-bordered form class (SDP)]
\setlength{\paperwidth}{8.5in}
\setlength{\paperheight}{11in}
\RequirePackage{geometry}
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
%%
\def\phdthesis{\def\@degree{Doctor of Philosophy}}
\def\msthesis{\def\@degree{Master of Science}}
\def\degreeyear#1{\def\@degreeyear{#1}}
\def\degreemonth#1{\def\@degreemonth{#1}}
\newlength{\date@indent}
\newlength{\author@indent}
\newlength{\title@indent}
\newlength{\degree@indent}
\newlength{\date@width}
\newlength{\author@width}
\newlength{\title@width}
\newlength{\degree@width}
\def\center@lines{%
  \setlength{\date@indent}{127mm}
  \setlength{\author@indent}{39mm}
  \setlength{\title@indent}{60mm}
  \setlength{\degree@indent}{73mm}
  \setlength{\date@width}{63mm}
  \setlength{\author@width}{150mm}
  \setlength{\title@width}{130mm}
  \setlength{\degree@width}{118mm}
}
\def\center@globally{%
  \setlength{\date@indent}{127mm}
  \setlength{\author@indent}{60mm}
  \setlength{\title@indent}{60mm}
  \setlength{\degree@indent}{60mm}
  \setlength{\date@width}{63mm}
  \setlength{\author@width}{130mm}
  \setlength{\title@width}{130mm}
  \setlength{\degree@width}{130mm}
}
\newcommand{\formattext}[1]{\textbf{\MakeUppercase{#1}}}
\newcommand{\maketitle}{%
  \thispagestyle{empty}%
  \setlength{\baselineskip}{11mm}\setlength{\parindent}{0pt}%
  \vspace*{65mm}\hspace*{\date@indent}%
  \parbox[t]{\date@width}{%
    \hfil\formattext{\@degreemonth{} \@degreeyear}\hfil}\par
  \vspace*{22mm}\hspace*{\author@indent}%
  \parbox[t]{\author@width}{%
    \hfil\formattext{\@author}\hfil}\par
  \hspace*{\title@indent}%
  \begin{minipage}[t][3\baselineskip]{\title@width}
    \begin{center}
      \setlength{\baselineskip}{11mm}\setlength{\parindent}{0pt}%
      \formattext{\@title}
    \end{center}
  \end{minipage}\par
  \vspace*{-1mm}\hspace*{\degree@indent}%
  \parbox[t]{\degree@width}{\hfil\formattext{\@degree}\hfil}
}
\center@globally
\DeclareOption{linecentered}{\center@lines}
\newcommand{\@ptsize}{0}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\ProcessOptions\relax
\input{size1\@ptsize.clo}
\geometry{noheadfoot,letterpaper,marginparsep=0pt}
\geometry{lmargin=0mm, rmargin=0mm}
\geometry{tmargin=0mm, bmargin=0mm}
\endinput
%%
%% End of file `uiucredborder.cls'.
