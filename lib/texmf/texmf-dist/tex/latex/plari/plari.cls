%%
%% This is file `plari.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% plari.dtx  (with options: `class')
%% 
%% This is a generated file.  The name of the source file is given above.
%% This document class is distributed in accordance to GNU General
%% Public License (version 2 or later).  Since this file is not
%% the source, *you are not allowed to distribute this file without giving
%% the diustributee access to the source* as mandated by the GNU General
%% Public License.
%% 
%% plari - Typesetting stage play scripts with LaTeX2e
%%
%% Copyright (c) 1998 Antti-Juhani Kaijanaho
%%
%%    This program is free software; you can redistribute it and/or modify
%%    it under the terms of the GNU General Public License as published by
%%    the Free Software Foundation; either version 2 of the License, or
%%    (at your option) any later version.
%%
%%    This program is distributed in the hope that it will be useful,
%%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%    GNU General Public License for more details.
%%
%%    You should have received a copy of the GNU General Public License
%%    along with this program; see the file COPYING.  If not, write to
%%    the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
%%    Boston, MA 02111-1307, USA.
%%
%% Just to be sure everybody understands this:
%%  Including plari.cls in one's document with the LaTeX2e command
%%     \documentclass[...]{plari}
%%  is considered /use/ of plari.cls and is therefore not restricted
%%  by the GNU General Public License.  If you still are unsure, you
%%  can regard this notice as a special exeption to the GNU General
%%  Public License, to be applied to plari.cls as authored by Antti-Juhani
%%  Kaijanaho.
%%
%% \CheckSum{87}
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
\def\filedate{1998/11/02}
\def\fileversion{19981102-CTAN}
\def\fileinfo{development snapshot}




\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{plari}[\filedate\space\fileversion\space\fileinfo]
\typeout{plari <\filedate:\fileversion> - typesetting stageplay scripts}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

\LoadClass{report}

\newcounter{act}
\newcounter{scene}[act]
\renewcommand{\theact}{\Roman{act}}
\renewcommand{\thescene}{\Roman{act}:\arabic{scene}}

\newcommand{\newact}{%
  \refstepcounter{act}%
  \newpage{\centering\bfseries\Huge--- \Roman{act} ---\par}%
  \vspace{1.5cm plus .5cm minus .5cm}%
  }
\newcommand{\newscene}{%
  \refstepcounter{scene}%
  \bigskip%
  {\centering\mdseries\Large\arabic{scene}\par}%
  \medskip%
  }

\newcommand{\setting}[1]{%
  \newscene%
  \begingroup%
    \list{}{%
      \listparindent=\parindent%
      \parsep=\parskip%
      \topsep=\z@%
      \rightmargin=\leftmargin%
      }%
    \item%
    \let\item\@undefined%
    {\normalsize\itshape\mdseries#1\par}%
    \endlist%
  \endgroup%
  }

\newcommand{\repl}[1]{%
  \medskip%
  {\centering\normalsize\mdseries\scshape#1\par}%
  }

\newcommand{\paren}[1]{\textit{#1}}

\parindent=\z@
\parskip=\medskipamount\relax

\let\@startsection\@undefined


\endinput
%%
%% End of file `plari.cls'.
