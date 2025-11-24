%%
%% This is file `sr-vorl.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% sr-vorl.dtx  (with options: `class')
%% 
%% 
%% 
%% Copyright 2013-2016 by Jonas L. Dabelow
%% 
%% Dieses Werk darf nach den Bedingungen der LaTeX Project Public License,
%% entweder Version 1.3c oder (nach Ihrer Wahl) jeder spaeteren Version,
%% verteilt und/oder veraendert werden.
%% Die neueste Version dieser Lizenz ist:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% Dieses Werk hat den LPPL-Betreuungs-Status "author-maintained" (vom Autor betreut).
%% 
%% Dieses Werk besteht aus den Dateien sr-vorl.dtx and sr-vorl.ins
%% und den daraus erzeugten Dateien sr-vorl.cls, frontmatter_sr-vorl.tex,
%% mainmatter_sr-vorl.tex, backmatter_sr-vorl.tex und hauptdatei_sr-vorl.tex.
%% 
%% 
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% This work has the LPPL maintenance status "author-maintained".
%% 
%% This work consists of the files sr-vorl.dtx and sr-vorl.ins
%% and the derived files sr-vorl.cls, frontmatter_sr-vorl.tex,
%% mainmatter_sr-vorl.tex, backmatter_sr-vorl.tex and hauptdatei_sr-vorl.tex.
%% 
%% 
%% 
%% Die vorliegende Datei ist Teil einer LaTeX-Klasse zur Erstellung einer Veroeffentlichung nach
%% den Massgaben von Springer Research und Springer VS.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sr-vorl}
[2016/01/30 v1.1 Vorlage fuer Autoren bei Springer Research]
\LoadClassWithOptions{scrbook}

\RequirePackage{xkeyval}
\RequirePackage{etoolbox}

\DeclareOptionX[sr]{no-shorthands}{%
\global\Germanshorthandsfalse%
}

\DeclareOptionX[sr]{test}{%
\PassOptionsToClass{draft}{scrbook}
\PassOptionsToPackage{showframe}{geometry}
}

\DeclareOptionX[sr]{deutsch}{%
\PassOptionsToPackage{ngerman}{babel}%
\ifGermanshorthands%
\else%
\AfterEndPreamble{\shorthandoff{"}}
\fi%
\gdef\GeleitwortTitel{Geleitwort}%
\gdef\VorwortTitel{Vorwort}%
}

\DeclareOptionX[sr]{deutsch-ar}{%
\PassOptionsToPackage{german}{babel}%
\ifGermanshorthands%
\else%
\AfterEndPreamble{\shorthandoff{"}}
\fi%
\gdef\GeleitwortTitel{Geleitwort}%
\gdef\VorwortTitel{Vorwort}%
}

\DeclareOptionX[sr]{englisch}{%
\PassOptionsToPackage{ngerman,british}{babel}%
\ifGermanshorthands%
\AfterPackage+{babel}{%
\useshorthands{"}%
\addto\extrasbritish{\languageshorthands{ngerman}}%
}%
\fi%
\gdef\GeleitwortTitel{Foreword}%
\gdef\VorwortTitel{Preface}%
}

\DeclareOptionX[sr]{no-microtype}{%
\global\Microtypefalse%
}

\DeclareOptionX[sr]{non-ams}{%
\global\AMSfalse%
}

\gdef\sr@schriftgroesse{11}% Standard-Schriftgroesse
\gdef\sr@format{a5-monografie}% Standard-Format

\newif\ifMicrotype% soll microtype eingebunden werden
\Microtypetrue

\newif\ifAMS% soll onlyamsmath eingebunden werden
\AMStrue

\newif\ifGermanshorthands% sollen die deutschen shorthands auch im Englischen nutzbar sein
\Germanshorthandstrue

\DeclareOptionX[sr]{schriftgroesse}[11]{\gdef\sr@schriftgroesse{#1}}

\DeclareOptionX[sr]{format}[a5-monografie]{\gdef\sr@format{#1}}

\ProcessOptions\relax
\ProcessOptionsX[sr]\relax

\RequirePackage{babel}
\RequirePackage{geometry}
\RequirePackage{scrpage2}
\RequirePackage{caption}
\RequirePackage{ragged2e}
\RequirePackage{enumitem}
\RequirePackage{xstring}
\RequirePackage{chngcntr}
\RequirePackage{varwidth}
\ifAMS
\RequirePackage[all,error]{onlyamsmath}
\AtEndPreamble{%
\@ifpackageloaded{tikz}% Test, ob TikZ geladen wurde
{% Catcode für $ in tikz-Befehlen anpassen, um Konflikt zwischen onlyamsmath und TikZ zu vermeiden
\preto\tikzpicture{\catcode`$=3 }
\preto\tikz{\catcode`$=3 }
}
{}
}
\fi
\ifMicrotype
\RequirePackage{microtype}
\fi

\ifundef{\GeleitwortTitel}% falls keine Sprachoption gesetzt wurde, wird der Befehl \GeleitwortTitel definiert
{\gdef\GeleitwortTitel{}}
{}
\ifundef{\VorwortTitel}% falls keine Sprachoption gesetzt wurde, wird der Befehl \VorwortTitel definiert
{\gdef\VorwortTitel{}}
{}

\defpagestyle{plain}
{%
(0pt,0pt)%
{}%
{}%
{}%
(0pt,0pt)%
}%
{%
(0pt,0pt)%
{}%
{}%
{}%
(0pt,0pt)%
}%

\KOMAoptions{% Einstellungen der KOMA-Klasse
fontsize=\sr@schriftgroesse pt,%
open=right,%
captions=signature,%
captions=abovetable,%
appendixprefix=false,%
}%

\gdef\frontmatter{%
\pagenumbering{Roman}%
\setcounter{page}{5}%
}

\captionsetup{% Einstellungen fuer Bild- und Tabellenbeschriftungen (mittels caption-Paket)
format=hang,%
font=small,%
labelfont=bf,%
justification=RaggedRight ,%
singlelinecheck=false,%
}%

\setlist{labelindent=0em,leftmargin=*}

\AfterEndPreamble{%
\pagestyle{sr-standard}% Standard-pagestyle einschalten
\raggedbottom% vertikalen Seitenausgleich abschalten
}

\IfStrEqCase{\sr@format}{%
{a5-monografie}%
{%
\KOMAoptions{%
paper=a4,%
twoside,%
pagesize=auto,%
}%
\recalctypearea
\geometry{% Einstellungen fuer Satzspiegel (mittels geometry-Paket)
includehead,%
textwidth=11.5cm,%
height=18cm,%
}%
\automark[section]{chapter}
\defpagestyle{sr-standard}% Standard pagestyle
{%
(0pt,0pt)%
{\pagemark\hfill\headmark}%
{\headmark\hfill\pagemark}%
{}%
(\textwidth,0.5pt)%
}%
{%
(0pt,0pt)%
{}%
{}%
{}%
(0pt,0pt)%
}%
}%
{handbuch-monografie}%
{%
\KOMAoptions{%
paper=16.8cm:24cm,%
twoside,%
pagesize=auto,%
}%
\recalctypearea
\geometry{% Einstellungen fuer Satzspiegel (mittels geometry-Paket)
includehead,%
textwidth=12.5cm,%
height=20cm,%
}%
\automark[section]{chapter}
\defpagestyle{sr-standard}% Standard pagestyle
{%
(0pt,0pt)%
{\pagemark\hfill\headmark}%
{\headmark\hfill\pagemark}%
{}%
(\textwidth,0.5pt)%
}%
{%
(0pt,0pt)%
{}%
{}%
{}%
(0pt,0pt)%
}%
}%
{a5-mehrautorenbuch}% Einstellungen fuer Mehrautorenbuecher
{%
\KOMAoptions{%
paper=a4,%
twoside,%
pagesize=auto,%
}%
\recalctypearea
\geometry{% Einstellungen fuer Satzspiegel (mittels geometry-Paket)
includehead,%
textwidth=11.5cm,%
height=18cm,%
}%
\automark{chapter}
\defpagestyle{sr-standard}% Standard pagestyle
{%
(0pt,0pt)%
{\pagemark\hfill\headmark}%
{\KapitelAutor\hfill\pagemark}%
{}%
(\textwidth,0.5pt)%
}%
{%
(0pt,0pt)%
{}%
{}%
{}%
(0pt,0pt)%
}%
\gdef\KapitelAutor{}%
    \newcommand{\sr@chapterheadstartvskip}{% Definition eines neuen Abstands vor Kapitelanfaengen
\vspace*{1.8\baselineskip}%
}%
\newcommand{\sr@chapterheadendvskip}{% Definition eines neuen Abstands nach Kapitelanfaengen
\vspace{.5\baselineskip plus 0.1\baselineskip minus .05\baselineskip}%
}%
\let\old@chapterheadstartvskip\chapterheadstartvskip% Sicherung des alten Abstandes vor Kapitelanfaengen
\let\old@chapterheadendvskip\chapterheadendvskip% Sicherung des alten Abstandes nach Kapitelanfaengen
\counterwithout{section}{chapter}%
\counterwithout{figure}{chapter}%
\counterwithout{table}{chapter}%
\counterwithout{equation}{chapter}%
\counterwithin*{section}{chapter}%
\counterwithin*{figure}{chapter}%
\counterwithin*{table}{chapter}%
\counterwithin*{equation}{chapter}%
\counterwithin*{footnote}{chapter}%
}%
{vs}% Einstellungen fuer Buch bei Springer VS
{%
\KOMAoptions{%
paper=a4,%
twoside,%
pagesize=auto,%
}%
\recalctypearea
\geometry{% Einstellungen fuer Satzspiegel (mittels geometry-Paket)
includehead,%
textwidth=11.5cm,%
height=18cm,%
}%
\automark[section]{chapter}
\defpagestyle{sr-standard}% Standard pagestyle
{%
(0pt,0pt)%
{\pagemark\hfill\headmark}%
{\headmark\hfill\pagemark}%
{}%
(\textwidth,0.5pt)%
}%
{%
(0pt,0pt)%
{}%
{}%
{}%
(0pt,0pt)%
}%
\gdef\frontmatter{%
\pagenumbering{arabic}%
\setcounter{page}{5}%
}%
\let\old@chapterheadstartvskip\chapterheadstartvskip%
\let\old@chapterheadendvskip\chapterheadendvskip%
\renewcommand*{\chapterheadstartvskip}{\vspace*{-\topskip}}%
\renewcommand*{\chapterheadendvskip}{\vspace{72pt}}%
\deffootnote%
{1em}%
{1em}%
{\thefootnotemark\ }%
}%
}

\newlength{\sr@widmungstretch@oben}% vertikaler Abstand vor der Widmung

\newlength{\sr@verfasserbreite@ort}% Breite des Ortes im Befehl \verfasser
\newlength{\sr@verfasserbreite@name}% Breite des Namens im Befehl \verfasser

\newenvironment{widmung}[1][]
{%
\ifblank{#1}%
{%
\cleardoublepage%
\thispagestyle{plain}%
\setlength{\sr@widmungstretch@oben}{-2\baselineskip}%
\addtolength{\sr@widmungstretch@oben}{\stretch{1}}%
\vspace*{\sr@widmungstretch@oben}%
\begin{flushright}%
}%
{%
\let\raggedsection\raggedleft%
\setlength{\sr@widmungstretch@oben}{-\baselineskip}%
\addtolength{\sr@widmungstretch@oben}{\stretch{1}}%
\def\chapterheadstartvskip{\vspace*{\sr@widmungstretch@oben}}%
\chapter*{\raggedleft #1}%
\begin{flushright}%
}%
\itshape%
}%
{%
\end{flushright}%
\vspace*{\stretch{1.618}}%
}%

\newcommand{\vorwort}{%
\addchap*{\VorwortTitel}%
\markboth{\VorwortTitel}{\VorwortTitel}
}

\newcommand{\geleitwort}{%
\addchap*{\GeleitwortTitel}%
\markboth{\GeleitwortTitel}{\GeleitwortTitel}
}

\newcommand{\verfasser}[3][0.4\linewidth,0.5\linewidth]{%
\StrBefore{#1}{,}[\sr@verfasserbefehl@ort]%
\StrBehind{#1}{,}[\sr@verfasserbefehl@name]%
\setlength{\sr@verfasserbreite@ort}{\sr@verfasserbefehl@ort}%
\setlength{\sr@verfasserbreite@name}{\sr@verfasserbefehl@name}%
\ifdimcomp{\sr@verfasserbreite@name + \sr@verfasserbreite@ort}{>}{\linewidth}% gucken, ob alles in eine Zeile passt
{% es passt nicht in eine Zeile
\ClassWarning{sr-vorl}{Die Summe der im Befehl '\verfasser' genutzten Laengen ist groesser als die Zeilenbreite!}% Warnung, wenn die Laengen zu gross sind
}%
{}% es passt in eine Zeile
\nopagebreak%

\nopagebreak%
\vspace*{1.5\baselineskip plus 0.75\baselineskip minus 0.75\baselineskip}%
\nopagebreak%
\noindent
\begin{varwidth}[t]{\sr@verfasserbreite@ort}%
\raggedright%
#2%
\end{varwidth}%
\hfill%
\begin{varwidth}[t]{\sr@verfasserbreite@name}%
\raggedleft%
#3%
\end{varwidth}%
}

\newcommand{\kapitel}[3][]{%
\gdef\KapitelAutor{#3}%
\stepcounter{chapter}
\let\chapterheadstartvskip\sr@chapterheadstartvskip%
\let\chapterheadendvskip\sr@chapterheadendvskip%
\ifblank{#1}%
{\addchap{#2}}%
{\addchap[#1]{#2}}%
\let\chapterheadstartvskip\old@chapterheadstartvskip%
\let\chapterheadendvskip\old@chapterheadendvskip%
{\usekomafont{section}\itshape#3}\par%
\vspace*{1.35\baselineskip plus 0.09\baselineskip minus .15\baselineskip}%
\noindent%
}

\setcounter{topnumber}{3}
\setcounter{bottomnumber}{1}
\setcounter{totalnumber}{5}

\renewcommand{\topfraction}{1}
\renewcommand{\bottomfraction}{0.4}
\renewcommand{\textfraction}{0.05}
\renewcommand{\floatpagefraction}{0.7}

\setlength{\@fptop}{0pt}
\setlength{\@fpsep}{8pt}
\setlength{\@fpbot}{0pt plus 1fil}

\clubpenalty=9999
\widowpenalty=9999
\displaywidowpenalty=9999

\endinput
%%
%% End of file `sr-vorl.cls'.
