% Copyright 2014-2015 by Marei Peischl
%
% This file may be distributed and/or modified
% under the LaTeX Project Public License

% urletter ist eine Briefklasse, nach den momentenen (Januar 2015) Gestaltungsrichtlinien zum Corporate Design der Universität Regensburg
% Sie basiert auf der Dokumentenklasse scrlettr2.
% Diese Klasse wird in ihrer aktuellen Form bereitgestellt, allerdings übernimmt die Autorin keinerlei Verantwortung für die Verwendung.
% Bei Fragen, Wünschen oder Anregungen freue ich mich über eine Email: TeX@mareipeischl.de

\NeedsTeXFormat{LaTeX2e}
\def\fileversion{1.5}
\def\filedate{2015/01/28}
\ProvidesClass{URletter}
 [\filedate\space\fileversion\space
   Briefklasse im Corporate Design der Universität Regensburg]
   
%Lade scrlttr2 als Basisklasse mit KOMA-Script
\LoadClass[backaddress=plain,fontsize=11pt,parskip=half]{scrlttr2}
   
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Lade notwendige Pakete
\RequirePackage[utf8]{inputenc} %Eingabekodierung utf8
\RequirePackage[T1]{fontenc} %T1-Vektorschrift
%\RequirePackage{frutigernext} %UR-Hausschrift
\RequirePackage{babel}%Übersetzte captions

\RequirePackage{ifthen}%if-Abfragen und while-Schleifen

\RequirePackage{URcolors}%Farbdefinitionen der CD der UR, lädt automatisch xcolor

\RequirePackage{calc} %Rechnen bei Längenangaben und Countern
\RequirePackage{graphicx} %Grafikeinbindung
\RequirePackage{tikz,pgf} %Grafikerstellung mit pgf
\usetikzlibrary{calc}

\RequirePackage{kvoptions} %Keyval-Options

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Counter-Definitionen
\newcounter{UR@dep}
\newcounter{UR@temp} %temporärer counter zum Abtasten
\newcounter{UR@color}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Boolean-Definitionen
%22 Booleans zum aktivieren/deaktivieren der einzelnen Abteilungsfarben
\newcounter{UR@runner}
%Create Booleans UR@Dep@\the\value{UR@runner}
\def\newdep#1{\expandafter\@ifdefinable\csname ifUR@dep@#1\endcsname{%
		\expandafter\newif\csname ifUR@dep@#1\endcsname}}
\whiledo{\value{UR@runner}<23}{\stepcounter{UR@runner}\newdep{\the\value{UR@runner}}}
\newboolean{fsimphy}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Optionen zum aktivieren einzelner Farben
\DeclareOption{lov}{\setboolean{UR@dep@1}{true}\stepcounter{UR@dep}}
\DeclareOption{ffg}{\setboolean{UR@dep@2}{true}\stepcounter{UR@dep}}
\DeclareOption{asz}{\setboolean{UR@dep@3}{true}\stepcounter{UR@dep}}
\DeclareOption{rw}{\setboolean{UR@dep@4}{true}\stepcounter{UR@dep}}
\DeclareOption{ww}{\setboolean{UR@dep@5}{true}\stepcounter{UR@dep}}
\DeclareOption{kt}{\setboolean{UR@dep@6}{true}\stepcounter{UR@dep}}
\DeclareOption{pkgg}{\setboolean{UR@dep@7}{true}\stepcounter{UR@dep}}
\DeclareOption{pps}{\setboolean{UR@dep@8}{true}\stepcounter{UR@dep}}
\DeclareOption{slk}{\setboolean{UR@dep@9}{true}\stepcounter{UR@dep}}
\DeclareOption{bvm}{\setboolean{UR@dep@10}{true}\stepcounter{UR@dep}}
\DeclareOption{mat}{\setboolean{UR@dep@11}{true}\stepcounter{UR@dep}}
\DeclareOption{ph}{\setboolean{UR@dep@12}{true}\stepcounter{UR@dep}}
\DeclareOption{chp}{\setboolean{UR@dep@13}{true}\stepcounter{UR@dep}}
\DeclareOption{med}{\setboolean{UR@dep@14}{true}\stepcounter{UR@dep}}
\DeclareOption{ub}{\setboolean{UR@dep@15}{true}\stepcounter{UR@dep}}
\DeclareOption{zsk}{\setboolean{UR@dep@16}{true}\stepcounter{UR@dep}}
\DeclareOption{eur}{\setboolean{UR@dep@17}{true}\stepcounter{UR@dep}}
\DeclareOption{zhw}{\setboolean{UR@dep@18}{true}\stepcounter{UR@dep}}
\DeclareOption{rul}{\setboolean{UR@dep@19}{true}\stepcounter{UR@dep}}
\DeclareOption{zfw}{\setboolean{UR@dep@20}{true}\stepcounter{UR@dep}}
\DeclareOption{spo}{\setboolean{UR@dep@21}{true}\stepcounter{UR@dep}}
\DeclareOption{rz}{\setboolean{UR@dep@22}{true}\stepcounter{UR@dep}}
\DeclareOption{fsimphy}{\setboolean{UR@dep@23}{true}\setboolean{fsimphy}{true}\stepcounter{UR@dep}}
%Sammelaktivierung: all=alle Farben, faculties=alle 11 Fakultäten
\DeclareOption{all}{\setcounter{UR@temp}{1}\whiledo{\value{UR@temp}<23}{\setboolean{UR@dep@\arabic{UR@temp}}{true}\stepcounter{UR@dep}\stepcounter{UR@temp}}}
\DeclareOption{faculties}{\setcounter{UR@temp}{4}\whiledo{\value{UR@temp}<15}{\setboolean{UR@dep@\arabic{UR@temp}}{true}\stepcounter{UR@dep}\stepcounter{UR@temp}}}

\newboolean{UR@intern} %Tonersparender Briefkopf
\DeclareOption{intern}{\setboolean{UR@intern}{true}}
\newboolean{UR@dekanat}
\newboolean{UR@dekan}
\DeclareOption{dekan}{\setboolean{UR@dekan}{true}}
\DeclareOption{dekanat}{\setboolean{UR@dekanat}{true}}
\newboolean{UR@noheadline}
\DeclareOption{noheadline}{\setboolean{UR@noheadline}{true}}

\newboolean{norefline} %Keine Geschäftszeile -> Datum horizontal bündig mit Absenderergänzung
\DeclareOption{norefline}{\PassOptionsToClass{refline=nodate}{scrlttr2}\setboolean{norefline}{true}}

%LCO-Option for LoadLetterOptions
\SetupKeyvalOptions{
family=UR,
prefix=UR@
}
\DeclareStringOption{lco}

\ProcessKeyvalOptions*

\ifx\UR@lco\@empty
%\@empty predefined empty, wenn das argument leer ist, wollen wir keine umdefinition
\else
\AtBeginDocument{\LoadLetterOption{\UR@lco}}
\fi



\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptions\relax
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Neue Komavars
\newkomavar[\phonename\usekomavar{phoneseparator}]{officephone}%Telefon Sekretariat
\newkomavar[\faxname\usekomavar{phoneseparator}]{officefax}%Fax Sekretariat

\newkomavar{department}%Einrichtung

\newcaptionname{ngerman}{\chairname}{Lehrstuhl} %Lehrstuhl}%Lehrstuhl für...
\newkomavar[\chairname\chairseparator]{chair}
\newcommand{\chairseparator}{~für~}

\newcaptionname{ngerman}{\facultyname}{Fakultät}%Fakultät für...
\newkomavar[\facultyname\facultyseparator]{faculty}
\newcommand{\facultyseparator}{~für~}

\newcaptionname{ngerman}{\institutename}{}%Institut für...
\newkomavar[\institutename\instituteseparator]{institute}
\newcommand{\instituteseparator}{}

\newcaptionname{ngerman}{\roomname}{Zimmer}
\newcommand{\roomseparator}{:~}
\newkomavar[\roomname\roomseparator]{fromroom}

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Pseudolängen und Längen
%%%Skalierung des Logos
\newlength{\x}%halber Radius der Kugel
\setlength{\x}{0.5cm}
\setlength{\unitlength}{\x}
%Definition damit Text Bündig mit Adresse
\@setplength{refwidth}{\textwidth}
\@setplength{refhpos}{\useplength{toaddrhpos}}
\setlength{\oddsidemargin}{\useplength{toaddrhpos}-1in}
%Breite der Farbstreifen festlegen
\newlength{\streifen}	
\setlength{\streifen}{\paperwidth-10\x}
\setlength{\streifen}{0.5\streifen}
%Positionierung des Kopfes
\@setplength{firstheadhpos}{2.75\x}
\@setplength{firstheadvpos}{\x} %-1pt}
\@setplength{firstheadwidth}{2\streifen}
%Positionierung der Absenderergänzung
\@setplength{lochpos}{\useplength{refhpos}-.5em}
\@setplength{locvpos}{5.4\x}
\@setplength[1]{locwidth}{\streifen-\useplength{refhpos}}
\@setplength[1]{locheight}{\useplength{toaddrheight}}

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Briefkopf
\setcounter{UR@temp}{1}
\newcommand{\tikzmark}[1]{\tikz[overlay,remember picture] \node (#1) {};}
\ifthenelse{\boolean{UR@intern}}
	{
	%schwarz-weißer Briefkopf für Interna
	\setkomavar{firsthead}
		{
		\tikzmark{mark} \usekomavar{fromlogo}%\ifthenelse{\boolean{fsimphy}}{\includegraphics[width=12\x]{fsilogotext}}{\includegraphics[width=12\x]{urlogotextintern}}
		\begin{tikzpicture}[overlay, remember picture,]
			\draw(mark.north)++(7\x,3.2\x)--+(0,2\x)+(0,0)--++(.98\streifen,0)++(.02\streifen,0)--+(0,2\x)+(0,0)--++(\streifen,0);
		\end{tikzpicture}
		}
	}
	{
	%Farbiger Briefkopf
	\setkomavar{firsthead}{
	\ifthenelse{\boolean{UR@noheadline}}{}{
		\tikzmark{mark} \usekomavar{fromlogo}%\ifthenelse{\boolean{fsimphy}}{\includegraphics[width=12\x]{fsilogotext}}{\includegraphics[width=12\x]{urlogotext}}
		%grauer Balken
		\begin{tikzpicture}[overlay, remember picture,line width=0pt]
			\filldraw(mark.north)++(7\x,3.2\x)node[anchor=south west,fill=UR@reingrau,draw=UR@reingrau, rectangle,minimum width=\streifen, minimum height=3\x]{} ++(\streifen,0);
		\end{tikzpicture}
		%Taste nun alle Einrichtungen ab
		\whiledo{\value{UR@temp}<24}{
			\ifthenelse{\boolean{UR@dep@\value{UR@temp}}}{
				\begin{tikzpicture}[overlay,remember picture,line width=0pt]
				\filldraw[UR@color@\arabic{UR@temp}]($(mark.north)+(7\x,3.2\x)+(\streifen,0)+\arabic{UR@color}*(\streifen/\arabic{UR@dep},0)$)node[anchor=south west , rectangle,minimum width=\streifen/\arabic{UR@dep}, minimum height=3\x,fill=UR@color@\arabic{UR@temp},draw=UR@color@\arabic{UR@temp}]{};
				\end{tikzpicture}
				\stepcounter{UR@color}}
				{}
			\stepcounter{UR@temp}
			}
		}}

%evtl setcounter hier
	}
\AtEndLetter{\setcounter{UR@color}{0}\setcounter{UR@temp}{1}}
%Ende Briefkopf
\AtEndLetter{\setcounter{UR@temp}{1}\setcounter{UR@color}{0}}
%% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%%Rücksendeadresse
\setkomavar{backaddress}{Universität Regensburg $\cdot$ 93040 Regensburg}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Absenderergänzung

\ifthenelse{\boolean{UR@dekanat}}{
\setkomavar{location}{
		\sffamily\flushleft
		\fontsize{12}{0}\selectfont Dekanat\\[1em]
		\fontsize{8}{0}\selectfont\textbf{\usekomavar*[\MakeUppercase]{faculty}\usekomavar[\MakeUppercase]{faculty}\\[1em]}
		\fontsize{8}{0}\selectfont
				\textbf{Fakultätsverwaltung\\\usekomavar{fromname}}
				%Absendertelefonnummer
				\ifkomavarempty{fromphone}{\null\hspace*{0cm}\\[1em]}{\null\hspace*{0cm}\\[1.5pt]\usekomavar*{fromphone}\usekomavar{fromphone}} 
				\ifkomavarempty{fromroom}{}{\usekomavar*{fromroom} \usekomavar{fromroom}\\}
				\ifkomavarempty{fromfax}{\null\hspace*{0cm}\\[1em]}{\null\hspace*{0cm}\\[1.5pt]\usekomavar*{fromfax}\usekomavar{fromfax}\\[1.5pt]} %Absenderfax
				\usekomavar{fromaddress}\\[1.5em]
				\ifkomavarempty{fromemail}{}{\usekomavar{fromemail}\\[1.5pt]}
				\ifkomavarempty{fromurl}{}{\usekomavar{fromurl}}
				\ifthenelse{\boolean{norefline}}{\\[1.5em]
				\vfill
				\usekomavar{place},~den~\usekomavar{date}}{}
		
		
		}
}{
\ifthenelse{\boolean{UR@dekan}}{
		\setkomavar{location}{
		\sffamily\flushleft
		\fontsize{12}{0}\selectfont Der Dekan\\[1em]
		\fontsize{8}{0}\selectfont\textbf{\usekomavar*[\MakeUppercase]{faculty}\usekomavar[\MakeUppercase]{faculty}\\[1em]}
		\fontsize{8}{0}\selectfont
				\textbf{\usekomavar{fromname}}
				%Absendertelefonnummer
				\ifkomavarempty{fromphone}{\null\hspace*{0cm}\\[1em]}{\null\hspace*{0cm}\\[1.5pt]\usekomavar*{fromphone}\usekomavar{fromphone}} 
				\ifkomavarempty{fromfax}{\null\hspace*{0cm}\\[1em]}{\null\hspace*{0cm}\\[1.5pt]\usekomavar*{fromfax}\usekomavar{fromfax}\\[1.5pt]} %Absenderfax
				\ifkomavarempty{fromroom}{}{\usekomavar*{fromroom} \usekomavar{fromroom}\\}

				%Sekretariat:
				\ifkomavarempty{officephone}{\null\hspace*{0cm}\\[3em]}{Sekretariat:\\[1.5pt]
				\usekomavar*{officephone}\usekomavar{officephone}
				\ifkomavarempty{officefax}{\null\hspace*{0cm}\\[1em]}{\\[1.5pt]\usekomavar*{officefax}\usekomavar{officefax}\\[1.5pt]}}
				\usekomavar{fromaddress}\\[1.5em]
				\ifkomavarempty{fromemail}{}{\usekomavar{fromemail}\\[1.5pt]}
				\ifkomavarempty{fromurl}{}{\usekomavar{fromurl}}
				\ifthenelse{\boolean{norefline}}{\\[1.5em]
				\vfill
				\usekomavar{place},~den~\usekomavar{date}}{}
		
		
		}
		
		}{
		\setkomavar{location}{
			\sffamily\flushleft
				{	
		%Einrichtung 
		\ifkomavarempty{department}
				{\ifkomavarempty{faculty}
										{\hspace{0pt}\\[2.1cm]}
										{\fontsize{6}{0}\selectfont\textbf{\usekomavar*[\MakeUppercase]{faculty}\usekomavar[\MakeUppercase]{faculty}\\[5pt]}}}
				{\fontsize{6}{0}\selectfont\textbf{\usekomavar*[\MakeUppercase]{department}\usekomavar[\MakeUppercase]{department}\\[5pt]}}
					\fontsize{12}{0}\selectfont
					\ifkomavarempty{chair}
									{
									\ifkomavarempty{institute}
										{\null\hspace*{0cm}\\[2.2cm]}
										{\usekomavar*{institute}\usekomavar{institute}\\[1.5em]}
									}
									{\usekomavar*{chair}\usekomavar{chair}\\[1.5em]}
				
				
		}
		\fontsize{8}{0}\selectfont
		\textbf{\usekomavar{fromname}}
		%Absendertelefonnummer
		\ifkomavarempty{fromphone}{\null\hspace*{0cm}\\[1em]}{\null\hspace*{0cm}\\[1.5pt]\usekomavar*{fromphone}\usekomavar{fromphone}} 
		\ifkomavarempty{fromfax}{\null\hspace*{0cm}\\[1em]}{\null\hspace*{0cm}\\[1.5pt]\usekomavar*{fromfax}\usekomavar{fromfax}\\[1.5pt]} %Absenderfax
		\ifkomavarempty{fromroom}{}{\usekomavar*{fromroom} \usekomavar{fromroom}\\}
		%Sekretariat:
		\ifkomavarempty{officephone}{\null\hspace*{0cm}\\[3em]}{\null\hspace*{0cm}\\[3pt]Sekretariat:\\[1.5pt]
		\usekomavar*{officephone}\usekomavar{officephone}
		\ifkomavarempty{officefax}{\null\hspace*{0cm}\\[1em]}{\\[1.5pt]\usekomavar*{officefax}\usekomavar{officefax}\\[1.5pt]}}
		\usekomavar{fromaddress}\\[1.5em]
		\ifkomavarempty{fromemail}{}{\usekomavar{fromemail}\\[1.5pt]}
		\ifkomavarempty{fromurl}{}{\usekomavar{fromurl}}
		\ifthenelse{\boolean{norefline}}{\\[1.5em]
		\vfill
		\usekomavar{place},~den~\usekomavar{date}}{}
		}}}
%Defaultwerte für komavar
\setkomavar{fromaddress}{Universitätsstraße 31\\[1.5pt]93053 Regensburg}
%  \newcommand{\faxname}%
%    {Telefax}
%  \newcommand{\datename}{\ifkomavaremplty{place}{Datum}{\usekomavar{place}, den}}
  

%\captionname{ngerman}{\faxname}{Telefax}
%\newcaptionname{ngerman}{\datename}{\ifkomavarempty{place}{Datum}{\usekomavar{place}, den}}

\setkomavar{phoneseparator}{ +49 941 943-}
\setkomavar{faxseparator}{ +49 941 943-}
\renewcommand{\familydefault}{\sfdefault}

\pgfdeclareimage[width=12\x]{logo}{urlogotext}
\pgfdeclareimage[width=12\x]{logointern}{urlogotextintern}
\ifthenelse{\boolean{UR@intern}}{\setkomavar{fromlogo}{\pgfuseimage{logointern}}}{\setkomavar{fromlogo}{\pgfuseimage{logo}}}

\endinput
