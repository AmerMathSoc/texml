%%
%% This is file `play.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% play.dtx  (with options: `package,class')
%% This is a generated file. Generated from the source named above
%% The play package
%% Copyright 1999 James Kilfiger
%% This program can redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or (at your option) any later
%% version.
%% 
%% play - Typesetting Drama with LaTeX2e
%% \CheckSum{159}
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
\ProvidesClass{play}[1999/03/26 A LaTeX class for typesetting plays]
\DeclareOption{lineno}{
  \newcommand{\PLthemoduloline}{\@tempcnta=\c@line
    \divide\@tempcnta\c@linemodulo
    \multiply\@tempcnta\c@linemodulo
    \ifnum\@tempcnta=\c@line\arabic{line}\fi}
  \newcommand{\@PLtypemodline}{%
    \ifnum\value{linemodulo}=0%
    \else
      \marginpar{\scriptsize\PLthemoduloline}%
    \fi}
  \newcommand{\@PLputline}{%
    \@PLtypemodline
    \refstepcounter{line}}%
}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass{book}
\newcounter{act}
\newcounter{scene}[act]
\renewcommand{\theact}{\Roman{act}}
\renewcommand{\thescene}{\theact.\arabic{scene}}
\newcommand{\actname}{Act}
\newcommand{\scenename}{Scene}

\DeclareRobustCommand\act{\@ifstar{\@sact}{\@act}}

\newcommand{\@act}{%
  \refstepcounter{act}
  \chapter*{\actname~\theact}
  \addcontentsline{toc}{chapter}{\actname~\theact}}

\newcommand{\@sact}[1]{%
  \refstepcounter{act}
  \chapter*{#1}
  \addcontentsline{toc}{chapter}{#1}}

\DeclareRobustCommand{\scene}{\@ifstar{\@sscene}{\@scene}}

\newcommand{\@scene}{%
  \refstepcounter{scene}
  \section*{\scenename~\arabic{scene}}
   \addcontentsline{toc}{section}{\scenename~\arabic{scene}}}

\newcommand{\@sscene}[1]{%
  \refstepcounter{scene}
  \section*{#1}
  \addcontentsline{toc}{section}{\scenename~\arabic{scene}}}

\DeclareRobustCommand{\setting}[1]{\thesetting #1\endthesetting}
\newenvironment{thesetting}{\em\quotation}{\endquotation}
\newcounter{line}
\newcounter{linemodulo}\setcounter{linemodulo}{5}
\providecommand{\@PLtypemodline}{\relax}
\providecommand\@PLthemoduloline{\relax}
\providecommand{\typeline}{\marginpar{\scriptsize\theline}}
\providecommand{\@PLputline}{\relax}
\newcommand\shortdirectionopen{(}
\newcommand\shortdirectionclose{)}
\newcommand\directionfont{\em}
\DeclareRobustCommand*{\speaker}[1]{\item[#1]}
\DeclareRobustCommand*{\shortdirection}[1]{\shortdirectionopen
                                           {\directionfont#1\/}%
                                           \shortdirectionclose}
\DeclareRobustCommand{\longdirection}[1]%
           {{\list{}{\setlength{\topsep}{0pt}}\item\directionfont#1\endlist}}
\DeclareRobustCommand*{\phantomline}[1]{\leavevmode\phantom{#1}}
\newcommand*\speakerfont{\scshape}
\newcommand*\speakerdelim{}
\newcommand*{\@PLplaylabel}[1]{{\speakerfont#1\speakerdelim\hfil}}
\newenvironment{verseplay}[1][8em]{%
  \list{}{%
    \setcounter{line}{0}
    \refstepcounter{line}
    \def\\{\@PLputline\@centercr}
    \setlength\labelwidth{#1}
    \setlength\itemindent{-3em}
    \setlength\leftmargin{\labelwidth}
    \setlength{\itemsep}{0pt}
    \setlength{\parsep}{0pt}
    \addtolength\leftmargin{-\itemindent}
    \addtolength\leftmargin{\labelsep}
    \setlength\listparindent{\itemindent}
    \let\makelabel=\@PLplaylabel
  }
}
{\endlist}
\newenvironment{play}{%
  \list{}{%
    \setlength{\labelwidth}{0pt}
    \setlength{\labelsep}{1em}
    \setlength{\leftmargin}{1em}
    \setlength{\itemsep}{0pt}
    \setlength{\parsep}{0pt}
    \let\makelabel=\@PLplaylabel
  }
}
{\endlist}

\endinput
%%
%% End of file `play.cls'.
