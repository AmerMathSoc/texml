%%
%% This is file `schuleub.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% schule.dtx  (with options: `schuleub.cls,package')
%% Copyright (C)
%% 2010, 2011, 2012, 2013, 2014, 2015
%% Johannes Pieper (johannes_pieper@yahoo.de)
%% Johannes Kuhaupt (kujohann@seminar.ham.nw.schule.de)
%% Daniel Spittank (kontakt@daniel.spittank.net)
%% André Hilbig (mail@andrehilbig.de)
%% Adrian Salamon (adriansalamon@gmail.com)
%% 
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
%% The Current Maintainer of this work is Johannes Pieper.
%% 
%% This work consists of the files schule.dtx and schule.ins, readme
%% and the derived files schule.sty, schulinf.sty, syntaxdi.sty,
%% relaycircuit.sty, schulphy.sty, schulekl.cls, schuleub.cls,
%% schullzk.cls, schuleab.cls, schulein.cls, schuleue.cls,
%% schullsg.cls, schulit.cls, schulekl.sty, schulelzk.sty.
%% 
%% Dies ist der dokumentierte Makrocode zur Erzeugung und Dokumentation
%% des LaTeX-Paket `schule'.
%% 
%% This is the documented Macrocode to build the LaTeX-Package `schule'
%% and its documentation.
%% 
%% Some of the examples in the documentation have different copyright
%% notes.
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
%% Der folgende kenntlich gemachte Abschnitt ist in der Zusammenarbeit
%% von Informatikreferendaren und ehemaligen Informatikreferendaren
%% der Studienseminare (heute ZfsL) Arnsberg, Hamm und Solingen
%% entstanden.
%%
%% Der Abschnitt steht unter der Lizenz: Creative Commons by-nc-sa
%% Version 4.0
%% http://creativecommons.org/licenses/by-nc-sa/4.0/deed.de
%%
%% Nach dieser Lizenz darf der Abschnitt beliebig kopiert und
%% bearbeitet werden, sofern das Folgeprodukt wiederum unter
%% gleichen Lizenzbedingungen vertrieben und auf die ursprünglichen
%% Urheber verwiesen wird.  Eine kommerzielle Nutzung ist
%% ausdrücklich ausgeschlossen.
%%
%% Die Namensnennung durch einen Verweis und die Lizenzangabe der
%% ursprünglichen Urheber auf den Materialien für Schülerinnen und
%% Schüler ist erforderlich.
%%
%% Die vollständige Sammlung der Dokumente steht unter
%% http://ddi.uni-wuppertal.de/material/materialsammlung/ zur
%% Verfügung.
%%
%% Das LaTeX-Paket zum Setzen der Dokumente der Sammlung steht unter
%% http://www.ctan.org/pkg/ zur Verfügung.
%%
%% ----- BEGIN ------------------------------------------------------
%%
%% ----- END ---------------------------------------------------------
%% Der folgende kenntlich gemachte Abschnitt ist in der Zusammenarbeit
%% von Informatikreferendaren und ehemaligen Informatikreferendaren
%% der Studienseminare (heute ZfsL) Arnsberg, Hamm und Solingen
%% entstanden.
%%
%% Der Abschnitt steht unter der Lizenz: Creative Commons by-nc-sa
%% Version 4.0
%% http://creativecommons.org/licenses/by-nc-sa/4.0/deed.de
%%
%% Nach dieser Lizenz darf der Abschnitt beliebig kopiert und
%% bearbeitet werden, sofern das Folgeprodukt wiederum unter
%% gleichen Lizenzbedingungen vertrieben und auf die ursprünglichen
%% Urheber verwiesen wird.  Eine kommerzielle Nutzung ist
%% ausdrücklich ausgeschlossen.
%%
%% Die Namensnennung durch einen Verweis und die Lizenzangabe der
%% ursprünglichen Urheber auf den Materialien für Schülerinnen und
%% Schüler ist erforderlich.
%%
%% Die vollständige Sammlung der Dokumente steht unter
%% http://ddi.uni-wuppertal.de/material/materialsammlung/ zur
%% Verfügung.
%%
%% Das LaTeX-Paket zum Setzen der Dokumente der Sammlung steht unter
%% http://www.ctan.org/pkg/ zur Verfügung.
%%
%% ----- BEGIN ------------------------------------------------------
%% Der String Version: Version: 0.6 respektive 2015-05-07 wird beim Aufruf
%% des build-scripts durch die passende Nummer bzw. das passende
%% Datum ersetzt.
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{schuleub}[2015/05/07 v0.6 %
                         Vorlage für einen Unterrichtsbesuch]
\LoadClass[parskip=half,headsepline,DIV14]{scrartcl}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[headsepline]{scrpage2}
\setkomafont{pagehead}{\normalfont}
\RequirePackage{calc}
\RequirePackage{hyperref}
\RequirePackage[]{adjustbox}
\RequirePackage{pdfpages}
\pagestyle{scrheadings}
\newboolean{B@examen}
\setboolean{B@examen}{false}
\DeclareOption{examen}{\setboolean{B@examen}{true}}

\newboolean{B@neuePO}
\setboolean{B@neuePO}{false}
\DeclareOption{neuePO}{\setboolean{B@neuePO}{true}}

\newboolean{B@reversion}
\setboolean{B@reversion}{false}
\DeclareOption{reversion}{\setboolean{B@reversion}{true}}
\newboolean{B@kurzentwurf}
\setboolean{B@kurzentwurf}{false}
\DeclareOption{kurzentwurf}{\setboolean{B@kurzentwurf}{true}}

\newboolean{B@zieleMulti}
\setboolean{B@zieleMulti}{false}
\DeclareOption{zieleMulti}{\setboolean{B@zieleMulti}{true}}

\newboolean{B@bibBibtex}
\newboolean{B@bibBiblatexBibtex}
\setboolean{B@bibBibtex}{false}
\setboolean{B@bibBiblatexBibtex}{false}
\DeclareOption{bibBibtex}{\setboolean{B@bibBibtex}{true}}
\DeclareOption{bibBiblatexBibtex}{
\setboolean{B@bibBiblatexBibtex}{true}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\ifthenelse{\boolean{B@kurzentwurf}}{
\RequirePackage[bottom=1cm,top=1cm,left=1.5cm, right=2cm,
a4paper,landscape, includehead, includefoot]{geometry}
}{}
\ifthenelse{\boolean{B@bibBibtex}}{
  \RequirePackage{natbib}
  \bibpunct{[}{]}{}{a}{}{,~}
  \bibliographystyle{dinat}
}{
\ifthenelse{\boolean{B@bibBiblatexBibtex}}
   {\RequirePackage[backend=bibtex]{biblatex}}
   {\RequirePackage[backend=biber]{biblatex}}
}
\def\thema#1{\gdef\@thema{#1}}
\newcommand{\Thema}{\@thema}
\def\reihe#1{\gdef\@reihe{#1}}
\newcommand{\Reihe}{\@reihe}
\def\seminaradresse#1{\gdef\@seminaradresse{#1}}
\def\seminarinfo#1{\gdef\@seminarinfo{#1}}
\def\ort#1{\gdef\@ort{#1}}
\def\besuchtitel#1{\gdef\@besuchtitel{#1}}
\newcommand{\lerngruppe}[2][]{
\gdef\@lerngruppe{#2}
\ifthenelse{\equal{\unexpanded{#1}}{}}{\gdef\@lerngruppeKurz{#2}}
{\gdef\@lerngruppeKurz{#1}}
}
\def\datum#1{\gdef\@datum{#1}}
\def\zeit#1#2{\gdef\@startzeit{#1} \gdef\@endzeit{#2}}
\def\stunde#1{\gdef\@stunde{#1}}
\def\schule#1{\gdef\@schule{#1}}
\def\raum#1{\gdef\@raum{#1}}
\ifthenelse{\boolean{B@neuePO}}{
\newenvironment{teila}{
\renewcommand*{\thesection}{\Alph{section}}
\renewcommand*{\thesubsection}{\Alph{section}~\arabic{subsection}}
\addsec{Teil A -- Schriftliche Planung der Unterrichtsstunde}
\setcounter{section}{1}
\setcounter{subsection}{0}
}{\clearpage}
\newenvironment{teilb}{
\renewcommand*{\thesection}{\Alph{section}}
\renewcommand*{\thesubsection}{\Alph{section}~\arabic{subsection}}
\addsec{Teil B -- Darstellung der längerfristigen Zusammenhänge}
\setcounter{section}{2}
\setcounter{subsection}{0}
}{\clearpage}
\newenvironment{ziele}[3][]{%
\ifthenelse{\not\isempty{#1}}{%
\textbf{Hauptlernziel:} #1

}{}
\textbf{#2:}

#3
\ifthenelse{\boolean{B@zieleMulti}}{\begin{multicols}{2}}{}
\begin{smallitemize}
}{
\end{smallitemize}
\ifthenelse{\boolean{B@zieleMulti}}{\end{multicols}}{}
}

\newenvironment{anhang}{
\addsec{Anhang}
}{\clearpage}
}
{}
\def\schuladresse#1{\gdef\@seminaradresse{#1}}
\def\lehrer#1{\@ifnextchar[{\@referendarintern{#1}}%
    {\@referendarintern{#1}[]}}
\def\referendar#1{\@ifnextchar[{\@referendarintern{#1}}%
    {\@referendarintern{#1}[]}}
\def\@referendarintern#1[#2]{\gdef\@referendarIn{#2: & #1}%
    \gdef\@referendar{#1}}
\def\ausbildungsl#1{\@ifnextchar[{\@ausbildungslintern{#1}}%
    {\@ausbildungslintern{#1}[]}}
\def\@ausbildungslintern#1[#2]{\gdef\@ausbildungsl{#2: & #1}}
\def\foerderbedarfl#1#2#3{
  \gdef \@foerderbedarflVorn{#1}
  \gdef \@foerderbedarflNachn{#2}
  \gdef \@foerderbedarflFkt{#3}
}
\def\ako#1{\@ifnextchar[{\@akointern{#1}}{\@akointern{#1}[]}}
\def\@akointern#1[#2]{\gdef\@ako{#1}\gdef\@akoart{#2}}
\def\schulleiter#1{\@ifnextchar[{\@schulleiterintern{#1}}%
    {\@schulleiterintern{#1}[]}}
\def\@schulleiterintern#1[#2]{\gdef\@schulleiter{#2: & #1}}
\def\hauptseminar#1{\@ifnextchar[{\@hauptseminarintern{#1}}%
    {\@hauptseminarintern{#1}[]}}
\def\@hauptseminarintern#1[#2]{\gdef\@hauptseminar{#2: & #1}}
\def\fachEins#1#2{\@ifnextchar[{\@fachEinsintern{#1}{#2}}%
    {\@fachEinsintern{#1}{#2}[]}}
\def\@fachEinsintern#1#2[#3]{\gdef\@fachEins{#3 #1} %
    \gdef\@fachleiterEins{#2}}
\def\fachZwei#1#2{\@ifnextchar[{\@fachZweiintern{#1}{#2}}%
    {\@fachZweiintern{#1}{#2}[]}}
\def\@fachZweiintern#1#2[#3]{\gdef\@fachZwei{#3 #1} %
    \gdef\@fachleiterZwei{#2}}
\def\vorsitz#1{\@ifnextchar[{\@vorsitzintern{#1}}%
    {\@vorsitzintern{#1}[]}}
\def\@vorsitzintern#1[#2]{\gdef\@vorsitz{#2: & #1}}
\def\schulvertreter#1{\@ifnextchar[{\@schulvertreterintern{#1}}%
    {\@schulvertreterintern{#1}[]}}
\def\@schulvertreterintern#1[#2]{\gdef\@schulvertreter{#2: & #1}}
\def\fremderseminar#1{\@ifnextchar[{\@fremderseminarintern{#1}}%
    {\@fremderseminarintern{#1}[]}}
\def\@fremderseminarintern#1[#2]{\gdef\@fremderseminar{#2: & #1}}
\def\bekannterseminar#1{\@ifnextchar[{\@bekannterseminarintern{#1}}%
    {\@bekannterseminarintern{#1}[]}}
\def\@bekannterseminarintern#1[#2]{\gdef\@bekannterseminar{#2: & #1}}
\newcounter{@weiblich}
\def\weiblich#1{\setcounter{@weiblich}{#1}}
\newcounter{@maennlich}
\def\maennlich#1{\setcounter{@maennlich}{#1}}
\newcounter{@foerderbedarf}
\setcounter{@foerderbedarf}{-1}
\def\foerderbedarf#1{\setcounter{@foerderbedarf}{#1}}
\newcounter{@SuStotal}
\ihead{\@referendar}
\chead{\@lerngruppeKurz}
\ohead{\@datum}
\newcommand{\externesDokumentEinseitig}[1]{
\centering{\fbox{
\adjustbox{max size={\textwidth}{0.85\textheight}}{\includegraphics[page=1]{#1}}}
}
}
\newcommand{\externesDokumentMehrseitig}[2][]{
\centering{\fbox{
\adjustbox{max size={\textwidth}{0.85\textheight}}{\includegraphics[page=1]{#2}}}
}
\ifthenelse{\equal{#1}{\empty}}{%
\includepdf[
  pages=2-last,
scale=0.79,
pagecommand={\thispagestyle{scrheadings}},
frame=true]{#2}
}{%
\includepdf[pages=2-last,
  scale=0.79,
pagecommand={\thispagestyle{scrheadings}},
frame=true,
#1]{#2}
}
}
\newcommand\makehead{
\setcounter{@SuStotal}{\value{@weiblich} + \value{@maennlich}}
\ifthenelse{\boolean{B@neuePO}}{
\ifthenelse{\boolean{B@examen}}{
\begin{titlepage}
\begin{center}
Zentrum f\"ur schulpraktische Lehrerausbildung \@ort %

\@seminarinfo

\vspace{6mm}

\large \textbf{Schriftliche Arbeit gem\"a{\ss}
  \S 32 (5) OVP im Fach} \\[3mm]
\Large \textbf{\@fachEins}
\normalsize
\end{center}

\vspace{6mm}

\begin{tabular}{ll}
  \textbf{Pr\"ufling} \small (Name, Vorname):\normalsize
  & \@referendar \\[3mm]
Ausbildungsschule:
  & \@schule \\[3mm]
Datum der Pr\"ufung:
  & \@datum \\[0mm]
Unterrichtszeit (von -- bis):
  & \@startzeit~Uhr -- \@endzeit~Uhr (\@stunde .~Stunde) \\[3mm]
Lerngruppe (Klasse/Kurs/Jahrgang)*:
  & \@lerngruppe \\[0mm]
Lerngruppengr\"o{\ss}e (Anzahl):
  & \the@SuStotal
\end{tabular}

\vspace{6mm}
\textbf{Thema der unterrichtspraktischen Pr\"ufung:} \\
\@thema \\[9mm]

\textbf{Bezeichnung der zugeh\"origen Unterrichtsreihe:} \\
\@reihe\\[9mm]

\begin{tabular}{ll}
\textbf{Pr\"ufungskommission} \tabularnewline
Pr\"ufungsvorsitzende\@vorsitz \\[3mm]
Seminarausbilder\@bekannterseminar \tabularnewline
(an der Ausbildung \textbf{beteiligt}) & \\[3mm]
Seminarausbilder\@fremderseminar \tabularnewline
(an der Ausbildung \textbf{nicht beteiligt}) &
\end{tabular}

\vspace{20mm}

\small

\textbf{*) Zus\"atzliche Angaben f\"ur Gemeinsamen Unterricht~(GU):}

\SuS mit sonderp\"adagogischem F\"orderbedarf (Anzahl):
\the@foerderbedarf

Im GU eingesetzte Lehrkraft/weitere Person (Name, Vorname; Funktion):
\ifthenelse{\value{@foerderbedarf}>-1}{
  \@foerderbedarflNachn, \@foerderbedarflVorn; \@foerderbedarflFkt
}{--}
\end{titlepage}
}{
\begin{titlepage}
\begin{center}
Zentrum f\"ur schulpraktische Lehrerausbildung \@ort %

\@seminarinfo

\vspace{6mm}

\large \textbf{Unterrichtsentwurf} \\[3mm]
\Large \textbf{\@fachEins}
\normalsize
\end{center}

\vspace{6mm}

\begin{tabular}{ll}
\textbf{Pr\"ufling} \small (Name, Vorname):\normalsize
  & \@referendar \\[3mm]
Ausbildungsschule:
  & \@schule \\[3mm]
Datum der Pr\"ufung:
  & \@datum \\[0mm]
Unterrichtszeit (von -- bis):
  & \@startzeit~Uhr -- \@endzeit~Uhr (\@stunde .~Stunde) \\[3mm]
Lerngruppe
(Klasse/Kurs/Jahrgang)\ifthenelse{\value{@foerderbedarf}>-1}{*}{}:
  & \@lerngruppe \\[0mm]
Lerngruppengr\"o{\ss}e (Anzahl):
  & \the@SuStotal
\end{tabular}

\vspace{6mm}
\begin{tabular}{l}
\textbf{Thema der Unterrichtsstunde} \\
\@thema \\[9mm]

\textbf{Bezeichnung der zugeh\"origen Unterrichtsreihe:} \\
\@reihe\\[9mm]
\end{tabular}

\begin{tabular}{ll}
Seminarausbilder\@bekannterseminar \tabularnewline
\end{tabular}

\vspace{20mm}

\small
\ifthenelse{\value{@foerderbedarf}>-1}{
\textbf{*) Zus\"atzliche Angaben f\"ur Gemeinsamen Unterricht~(GU):}

\SuS mit sonderp\"adagogischem F\"orderbedarf (Anzahl):
  \the@foerderbedarf

Im GU eingesetzte Lehrkraft/weitere Person (Name, Vorname; Funktion):
  \@foerderbedarflNachn,
\@foerderbedarflVorn; \@foerderbedarflFkt}
{}
\end{titlepage}
}
}{
\begin{titlepage}
\begin{flushleft}\@seminaradresse \end{flushleft}
\begin{flushright}\@ort, \today\end{flushright} \par
\bigskip{}
\begin{center}
\textbf{\textsc{\huge Unterrichtsentwurf}} \par
(\@besuchtitel) \par
\vspace{4ex} \par
\textbf{\@thema} \par
\end{center} \par
\vfill \par
\begin{tabular}{ll}
\ifthenelse{\boolean{B@reversion}} %
    {Lehrer\@referendarIn \tabularnewline}%
        {Referendar\@referendarIn \tabularnewline}
Lerngruppe: & \@lerngruppe \tabularnewline
 & (\the@SuStotal~\SuS, \the@weiblich~weiblich %
    und \the@maennlich~m\"annlich  ) \tabularnewline
Datum: & \@datum \tabularnewline
Zeit: & \@startzeit~Uhr -- \@endzeit~Uhr (\@stunde .~Stunde)
\tabularnewline
\ifthenelse{\boolean{B@reversion}}{Raum: & \@raum \tabularnewline}{%
Ausbildungsschule: & \@schule \tabularnewline %
Raum: & \@raum \tabularnewline
}
\ifthenelse{\boolean{B@reversion}} %
    {Schulleiter\@schulleiter \tabularnewline}{
\tabularnewline
\tabularnewline
\textbf{Ausbilder und Schulvertreter} \tabularnewline
Ausbildungslehrer\@ausbildungsl \tabularnewline
Ausbildungskoordinator\@akoart: & \@ako \tabularnewline
Schulleiter\@schulleiter \tabularnewline
Hauptseminarleiter\@hauptseminar \tabularnewline
Fachleiter\@fachEins: & \@fachleiterEins \tabularnewline
Fachleiter\@fachZwei: & \@fachleiterZwei \tabularnewline
\ifthenelse{\boolean{B@examen}} {
\tabularnewline
\tabularnewline
\textbf{Pr\"ufungskommission} \tabularnewline
Pr\"ufungsvorsitzender\@vorsitz \tabularnewline
Weiterer Schulvertreter\@schulvertreter \tabularnewline
Fremder Seminarausbilder\@fremderseminar \tabularnewline
Bekannter Seminarausbilder\@bekannterseminar \tabularnewline} {}
}
\end{tabular}
\end{titlepage}
}
}
\AtBeginDocument{
\ifthenelse{\boolean{B@kurzentwurf}}{
\setboolean{@stundenverlaufquer}{false}
\ifthenelse{\boolean{@stundenverlaufASF}}{%
\setP{p{2.5cm}}%
\setO{X}
\setA{p{1cm}}%
\setM{p{1.5cm}}%
\setD{p{8cm}}%
}{ % mit didkatischer Kommentar, im Querformat, ohne ASF
\setP{p{2.35cm}}%
\setO{X}
\setA{p{3cm}}%
\setM{p{1.5cm}}%
\setD{p{6cm}}%
}
{\large\textbf{\Thema}}
}{
\makehead
}
}
\AtEndDocument{
\ifthenelse{\boolean{B@examen}}{
\ifthenelse{\boolean{B@neuePO}}{
\addsec{Versicherung}
Ich versichere, dass ich die Schriftliche Arbeit eigenst\"andig
verfasst, keine anderen Quellen und Hilfsmittel als die
angegebenen benutzt und die Stellen der Schriftlichen Arbeit,
die anderen Werken dem Wortlaut oder Sinn nach entnommen sind,
in jedem einzelnen Fall unter Angabe der Quelle als Entlehnung
kenntlich gemacht habe. Das Gleiche gilt auch f\"ur beigegebene
Zeichnungen, Kartenskizzen und Darstellungen. Anfang und Ende
von w\"ortlichen Text\"ubernahmen habe ich durch An- und
Abf\"uhrungszeichen, sinngem\"a{\ss}e \"Ubernahmen durch
direkten Verweis auf die Verfasserin oder den Verfasser
gekennzeichnet.

\vspace{26mm}

$\underset{\text{Unterschrift des Pr\"uflings}}{
\text{\underline{\hspace{8.5cm}}}}$
}{
\addsec{Schlusserkl\"arung}
Ich versichere, dass ich die schriftliche Planung eigenst\"andig
verfasst, keine anderen Quellen und Hilfsmittel als die
angegebenen benutzt und die Stellen der schriftlichen Planung,
die anderen Werken dem Wortlaut oder Sinn nach entnommen sind,
in jedem einzelnen Fall unter Angabe der Quelle als Entlehnung
kenntlich gemacht habe. Das Gleiche gilt auch f\"ur beigegebene
Zeichnungen, Kartenskizzen und Darstellungen. Anfang und Ende
von w\"ortlichen Text\"ubernahmen habe ich durch An- und
Abf\"uhrungszeichen, sinngem\"a{\ss}e \"Ubernahmen durch
direkten Verweis auf die Verfasserin oder den Verfasser
gekennzeichnet.
}
}{}
}
\endinput
%%
%% End of file `schuleub.cls'.
