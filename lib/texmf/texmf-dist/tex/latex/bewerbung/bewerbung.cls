%%
%% This is file `bewerbung.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% bewerbung.dtx  (with options: `bewerbung.cls,package')
%% 
%%  bewerbung.dtx
%%  Copyright 2015-07-14:14:18:49 -- Version 1.1 André Hilbig, mail@andrehilbig.de
%% 
%%  This work may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either version 1.3
%%  of this license of (at your option) any later version.
%%  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%%  and version 1.3 or later is part of all distributions of LaTeX
%%  version 2005/12/01 or later.
%% 
%%  This work has the LPPL maintenance status `maintained'.
%% 
%%  The Current Maintainer of this work is André Hilbig, mail@andrehilbig.de.
%% 
%%  This work consists of the files bewerbung.dtx and bewerbung.ins and the derived files bewerbung-cv-casual.sty, bewerbung-cv-classic.sty, bewerbung-cv-oldstyle.sty, bewerbung-cv.sty, bewerbung.sty, argetabelle.cls, bewerbung.cls, neueBewerbung.sh, config.inc, titlepage.inc.
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
%% zusätzliche
%% Farbdefinitionen:
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{bewerbung}[2015/07/14 v1.1 %
  Klasse zur Erstellung von Bewerbungsschreiben]
\RequirePackage{ifthen,kvoptions,calc}
\SetupKeyvalOptions{%
family=ahbewerbung,%
prefix=ahbewerbung@,%
setkeys=\kvsetkeys%
}
%%
%% for komacv are some color options available, that %
%% needed to get passed to the new cv package
%% ALL OPTIONS ARE CHANGED TO THE IDENTIFIER ahbewerbung
%%
\DeclareStringOption[mycolor]{lebenslaufColor}[mycolor]
\DeclareStringOption[x11names]{lebenslaufXcolor}[x11names]
\DeclareStringOption[classic]{lebenslaufStyle}[classic]
\DeclareStringOption[anschrift.csv]{anschrift}[anschrift.csv]
\DeclareBoolOption{idPlain}
\ProcessKeyvalOptions{ahbewerbung} % evaluate keyval options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptions\relax
\LoadClass[
DIN, pagenumber=botright, backaddress=true, parskip=half,%
fromalign=left, fromemail=true, fromfax=true, %
fromphone=true, fromurl=false, fromalign=right, %
fromlogo=false, fromrule=true, foldmarks=true, %
paper=a4, fontsize=10pt,enlargefirstpage=true, firstfoot=false
]{scrlttr2}
%% import from komacv.cls for easier maintaining
\RequirePackage{%
  etoolbox,%
  ifpdf,%
  ifluatex,%
  ifxetex,%
marvosym, %
  scrpage2,%
  array,%
  graphicx,%
  microtype,%
  enumitem, %
hyperref, %
}
\RequirePackage[%
%% xcolor=\ahbewerbung@lebenslaufXcolor,%
%% color=\ahbewerbung@lebenslaufColor,%
%% style=\ahbewerbung@lebenslaufStyle,%
]{bewerbung-cv}
\RequirePackage[autostyle,german=guillemets]{csquotes}
\RequirePackage[top=2.5cm]{geometry}
\RequirePackage{datatool}
\RequirePackage[right]{eurosym}
\RequirePackage{xspace}
\RequirePackage{multicol}
\RequirePackage{pdfpages}
\RequirePackage{comment}
\RequirePackage{xparse}
\RequirePackage{bewerbung}
\AtBeginDocument{%
\hypersetup{colorlinks=true}%
\InputIfFileExists{config.inc}{}{%
\@latex@warning@no@line{%
Achtung die Datei config.inc ist nicht lesbar.}%
}
\getBewerbung[\ahbewerbung@anschrift] %
\runKomaVar %
\InputIfFileExists{titlepage.inc}{}{%
\@latex@warning@no@line{%
Achtung die Datei titlepage.inc ist nicht lesbar.}%
} %
}
\endinput
%%
%% End of file `bewerbung.cls'.
