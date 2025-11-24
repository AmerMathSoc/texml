%% Copyright 2010-2016 Yves de Saint-Pern
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Yves de Saint-Pern.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{droit-fr}[2016/20/02 v1.2 classe pour droit francais]
\LoadClassWithOptions{memoir} % classe de référence: memoir

%%% OPTIONS %%%

\RequirePackage{kvoptions} % support des options de type clé=valeur
\SetupKeyvalOptions{family=drfr,prefix=drfr@}

\DeclareBoolOption[true]{footnotereset}
\DeclareBoolOption[true]{versetitle}
\ProcessKeyvalOptions{drfr}

\ifdrfr@footnotereset
% reset des notes de bas de page à chaque nouvelle page
\PassOptionsToPackage{perpage}{footmisc}
\else
% numérotation continue des notes de bas de pages du début à la fin
\counterwithout{footnote}{chapter}
\fi

%%% PACKAGES REQUIS %%%
\RequirePackage{ifluatex}
\ifluatex
\else
	\RequirePackage[utf8]{inputenc} % pour bonne interprétation des caractère spéciaux dans la classe
\fi
\RequirePackage{ifdraft} % comportements spécifiques quand l'option de classe draft est présente
\RequirePackage{xifthen} % code conditionnel
\RequirePackage{xstring} % code conditionnel
\RequirePackage{footmisc} % gestion des notes de bas de page
\RequirePackage{engrec} % compteur à symbole grecs
\RequirePackage{filecontents} % génération des fichers de style makeindex
\RequirePackage{babel} % support des langues
\RequirePackage[babel]{csquotes} % support des guillemets babel
\RequirePackage{refcount} % utilisé pour commandes de raccourci \thref, \threfs

%%% PAGE DE TITRE %%%

% université
\newcommand{\university}[1]{\def\theuniversity{#1}}

% école doctorante
\newcommand{\school}[1]{\def\theschool{#1}}

% spécialité de la thèse
\newcommand{\speciality}[1]{\def\thespeciality{#1}}

% date de soutenance
\newcommand{\approvaldate}[1]{\def\theapprovaldate{#1}}

% titre
\renewcommand{\title}[1]{\def\thetitle{#1}}

% auteur
\renewcommand{\author}[2]{\def\theauthor{#1 \textsc{#2}}}

% directeur de thèse
% {civilité}{prénom}{nom}{poste}
\newcommand{\director}[4]{%
\def\thedirector{\textbf{#1 #2 \textsc{#3}}}
\def\thedirectorjob{#4}}

% rapporteurs
% {civilité}{prénom}{nom}{poste}
\newcommand{\reportera}[4]{%
\def\thereportera{\textbf{#1 #2 \textsc{#3}}}
\def\thereporterajob{#4}}

\newcommand{\reporterb}[4]{%
\def\thereporterb{\textbf{#1 #2 \textsc{#3}}}
\def\thereporterbjob{#4}}

% autres membres du jury
% {civilité}{prénom}{nom}{poste}
\newcommand{\membera}[4]{%
\def\themembera{\textbf{#1 #2 \textsc{#3}}}
\def\thememberajob{#4}}

\newcommand{\memberb}[4]{%
\def\thememberb{\textbf{#1 #2 \textsc{#3}}}
\def\thememberbjob{#4}}

% page de titre pour la soutenance
\newcommand{\maketitlepage}{{%
\thispagestyle{empty}

\begin{center}
%\includegraphics[height=3cm]{logo} \\[1\onelineskip]
{\Large Université \theuniversity \\[1\onelineskip]}
{École doctorale de \theschool \\[3\onelineskip]}

{\LARGE\bfseries\scshape \thetitle\\[3\onelineskip]}

{Thèse pour le Doctorat en \thespeciality\ (Arrêté du 7 août 2006)\\ 
présentée et soutenue publiquement le \theapprovaldate\ par\\}
{\theauthor \\[2\onelineskip]}

\vfill

\begin{tabular}{ll}
Sous la direction de: & \thedirector \\
  & \thedirectorjob \\
  &  \\
Rapporteurs: & \thereportera \\
  & \thereporterajob \\
  & \thereporterb \\
  & \thereporterbjob \\
  &  \\
Membres du jury: & \themembera \\
  & \thememberajob \\
  & \thememberb \\
  & \thememberbjob
\end{tabular}
\end{center}

\cleardoublepage
}}

%%% TEXTE %%%

\OnehalfSpacing % espacement de ligne
\frenchbsetup{PartNameFull=false} % "partie I" préféré à "première partie"

%%% EN-TETES / PIEDS DE PAGE %%%

% date de compilation indiquée en mode draft uniquement
\newcommand{\addversion}{\ifdraft{Imprimé le \today}{}}

% définition du style des headers et footers
\makepagestyle{corpus}
\makeheadrule{corpus}{\textwidth}{\normalrulethickness}
%\makefootrule{corpus}{\textwidth}{\normalrulethickness}{\footruleskip}
\makeevenhead{corpus}{\small\thetitle}{}{\small\addversion}
\makeoddhead{corpus}{}{}{\small\rightmark}
\makeevenfoot{corpus}{}{\small\thepage}{}
\makeoddfoot{corpus}{}{\small\thepage}{}
\makepsmarks{corpus}{%
\nouppercaseheads
\createmark{part}{right}{shownumber}{Titre }{. \ }
\createmark{chapter}{right}{shownumber}{\@chapapp\ }{. \ }
\createmark{section}{right}{shownumber}{}{. \ }
\createmark{subsection}{right}{shownumber}{}{ \ }
\createplainmark{toc}{right}{\contentsname}
\createplainmark{lof}{right}{\listfigurename}
\createplainmark{lot}{right}{\listtablename}
\createplainmark{bib}{right}{\bibname}
\createplainmark{index}{right}{\indexname}
\createplainmark{glossary}{right}{\glossaryname}
}

% hack de la classe memoir: équivalent à \createmark{book}, non disponible
\def\bookpagemark#1{%
  \markright{%
  \ifnum\c@secnumdepth > -2
    \if@mainmatter
      Partie \thebook. \ %
    \fi
  \fi
#1}}

%%% SECTIONS %%%

% [-2] parties ("Première partie")

% macro de conversion compteur => chaine de caractères de genre féminin
\newcommand{\counterToFrenchF}[1]{\ifcase\value{#1}\or Première\or
     Deuxième\or Troisième\or Quatrième\or Cinquième\or
     Sixième\or Septième\or Huitième\or Neuvième\or Dixième\or
     Onzième\or Douzième\or Treizième\or Quatorzième\or Quinzième\or
     Seizième\or Dix-septième\or Dix-huitième\or Dix-neuvième\or Vingtième\fi}
\renewcommand*{\bookname}{\protect\counterToFrenchF{book}~partie}
\renewcommand{\booknamenum}{} % espace entre intitulé et numéro
\renewcommand{\printbooknum}{} % numéro
\newcommand{\partie}{\book}

% [-1] titres (I)

\AtBeginDocument{%
\renewcommand*{\partname}{Titre}
}
\counterwithin*{part}{book}% RAZ du compteur \part dans un nouveau book
\newcommand{\titre}{\part}

% [0] chapitres (1)

\counterwithin*{chapter}{part}% RAZ du compteur \chapter dans une nouvelle part
\newcommand{\chapitre}{\chapter}

% [1] sections (I)

\renewcommand*{\thesection}{Section \Roman{section}}
%\setbeforesecskip{}
%\setsecindent{}
\setaftersecskip{2em}
\setsecheadstyle{\LARGE\bfseries\raggedright}
\setsechook{\needspace{4\baselineskip}}

% [2] paragraphes (§1)

\renewcommand*{\thesubsection}{\S~\arabic{subsection}.}
%\setbeforesubsecskip{}
%\setsubsecindent{}
\setaftersubsecskip{1.5em}
\setsubsecheadstyle{\Large\bfseries\raggedright}
\setsubsechook{\needspace{4\baselineskip}}
\newcommand{\paragraphe}{\subsection}

% [3] sous-paragraphes (A.)

\renewcommand*{\thesubsubsection}{\Alph{subsubsection}.}
%\setbeforesubsubsecskip{}
%\setsubsubsecindent{}
%\setaftersubsubsecskip{}
\setsubsubsecheadstyle{\large\bfseries\raggedright}
\setsubsubsechook{\needspace{4\baselineskip}}
\newcommand{\souspara}{\subsubsection}

% [4] alinéas (1.)

\renewcommand*{\theparagraph}{\arabic{paragraph}.}
%\setbeforeparaskip{}
%\setparaindent{}
%\setafterparaskip{}
\setparaheadstyle{\bfseries\raggedright}
\setparahook{\needspace{4\baselineskip}}
\newcommand{\alinea}{\paragraph}

% [5] sous-alinéas (a.)

\renewcommand*{\thesubparagraph}{\alph{subparagraph}.}
%\setbeforesubparaskip{}
\setsubparaindent{0pt}
%\setaftersubparaskip{} % 
\setsubparaheadstyle{\bfseries\raggedright}
\setsubparahook{\needspace{4\baselineskip}}
\newcommand{\sousalinea}{\subparagraph}

% [6] points (i.)

\newcommand{\subsubparagraph}{\@startsection{subsubparagraph}
  {6}{\parindent}{1\baselineskip plus 0.25\baselineskip}
  {.5em}{\normalsize\bfseries\raggedright}}
\newlistentry[subparagraph]{subsubparagraph}{toc}{5}
\newcommand*{\subsubparagraphmark}[1]{} % gobble heading mark
\renewcommand{\thesubsubparagraph}{\roman{subsubparagraph}.}
\newcommand{\point}{\subsubparagraph}

% [7] souspoints (alpha.)

\newcommand{\subsubsubparagraph}{\@startsection{subsubsubparagraph}
  {7}{\parindent}{1\baselineskip plus 0.25\baselineskip}
  {.5em}{\normalsize\bfseries\raggedright}}
\newlistentry[subsubparagraph]{subsubsubparagraph}{toc}{6}
\newcommand*{\subsubsubparagraphmark}[1]{} % gobble heading mark
\renewcommand{\thesubsubsubparagraph}{\engrec{subsubsubparagraph}.}
\newcommand{\souspoint}{\subsubsubparagraph}

% [8] versets (paragraphes numérotés)

\newcommand{\versetsec}[1]{\@startsection{versetsec}
  {8}{\parindent}{0.5\baselineskip}
  {#1}{\small\textbf}}
\newlistentry{versetsec}{toc}{7}
\newcommand*{\versetsecmark}[1]{} % gobble heading mark
\renewcommand{\theversetsec}{\arabic{versetsec}.}

% compteur pour référencement des versets dans l'index
\newcounter{indexv}

% ajout de point final si nécessaire.
% aucun point n'est ajouté si le verset est déjà fini par "!", "?", "." ou "/ldots".
\newcommand{\versetdot}[1]{%
	\saveexpandmode%
	\noexpandarg%
	\IfEndWith*{#1}{.}{}{%
    \IfEndWith*{#1}{?}{}{%
      \IfEndWith*{#1}{!}{}{%
        \IfEndWith*{#1}{\ldots}{}{.}%
      }%
    }%
  }%
	\restoreexpandmode%
}

\newcommand{\versetcontent}[1]{%
  \ifthenelse{\isempty{#1}}%
    {\versetsec{-0em}{#1}}%
    {\versetsec{-1em}{#1\protect\versetdot{#1}}}%
}

\newcommand{\verset}[1]{%
  \ifdrfr@versetitle%
    \versetcontent{#1}%
  \else%
    \versetcontent{}%
  \fi%
  \refstepcounter{indexv}% 
}

% numérotation visible
\setsecnumdepth{all}
\maxsecnumdepth{all}
\setcounter{secnumdepth}{7} % pour points (6) et sous-points (7)

% option pour éviter les pbs d'hyperliens ambigus (de \part et \chapter)
\PassOptionsToPackage{hypertexnames=true,plainpages=false,pdfpagelabels}{hyperref}

%%% REFERENCES CROISEES

\AtBeginDocument{%
% autoref est disponible via le package hyperref
\renewcommand*{\bookautorefname}{Partie}
\renewcommand*{\partautorefname}{Titre}
\renewcommand*{\chapterautorefname}{Chapitre}
}

% commande de renvoi: 
% "supra|infra, n°<numéro verset>, p. <numéro de page>.
\newcommand{\vref}[1]{%
	\ifthenelse{\getrefnumber{#1}<\value{versetsec}}{\emph{supra}}{\emph{infra}}% infra ou supra
	\ \no{\ref{#1}}% numéro de verset
	\ifthenelse{\getpagerefnumber{#1}=\value{page}}{}{, p.~\pageref{#1}}% numéro de page si différente
}

% commande de renvoi: dans une note de bas de page, 
% "V. supra|infra, n°<numéro verset> s., p. <numéro de page>."
\newcommand{\fvref}[1]{\footnote{V.~\vref{#1}.}}

%%% INDEX %%%

\renewcommand*{\seename}{\textit{voir}}
\renewcommand*{\alsoname}{\textit{v. aussi}}

\ifdraft{\showindexmarks}{}

% index de base par versets
\newcommand{\indexvfilename}{index}
\newcommand{\makeindexv}{\makeindex[\indexvfilename]}
\newcommand{\indexv}[1]{\specialindex{\indexvfilename}{indexv}{#1}}
\newcommand{\printindexv}{\printindex[\indexvfilename]}

% index d'auteur par versets
\newcommand{\indexafilename}{auteurs}
\newcommand{\makeindexa}{\makeindex[\indexafilename]}
\newcommand{\indexa}[1]{\specialindex{\indexafilename}{indexv}{#1}}
\newcommand{\printindexa}{\printindex[\indexafilename]}

% entête de l'index
\newcommand{\idxmark}[1]{#1\markboth{#1}{#1}}

%%% SOMMAIRE & TABLE DES MATIERES %%%

% paramètres communs
\renewcommand{\cftbookname}{Partie\space}%
\renewcommand{\cftpartname}{Titre\space}%
%
\cftsetindents{subsubparagraph}{4em}{2em}
\cftsetindents{subsubsubparagraph}{5em}{2em}
\cftsetindents{versetsec}{6em}{2em}

% sommaire
\newcommand*{\setupshorttoc}{%
\renewcommand*{\contentsname}{Sommaire}
\let\oldchangetocdepth\changetocdepth
\renewcommand*{\changetocdepth}[1]{}
\let\oldcftchapterfillnum\cftchapterfillnum
\setcounter{tocdepth}{0}% Parties / Titres / Chapitres seulement
%
%\cftpagenumbersoff{book}
%\cftpagenumbersoff{part}
%\cftpagenumbersoff{chapter}
%
\renewcommand{\tocheadstart}{}
%
\renewcommand{\cftbeforebookskip}{1em}%
%\renewcommand{\cftbookfont}{}%
\renewcommand{\cftbookindent}{0em}%
%\renewcommand{\cftbooknumwidth}{}%
\renewcommand{\cftbookpagefont}{\normalfont\bfseries\large}%
%\renewcommand{\cftafterbookskip}{}%
%\renewcommand{\cftbookleader}{\cftdotfill{\cftdotsep}}%
%
\renewcommand{\cftbeforepartskip}{0.5em}%
\renewcommand{\cftpartfont}{\normalfont\scshape}%
\renewcommand{\cftpartindent}{0.5em}%
%\renewcommand{\cftpartnumwidth}{}%
\renewcommand{\cftpartpagefont}{\normalfont\scshape}%
%\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}%
%
\renewcommand{\cftbeforechapterskip}{0em}%
\renewcommand{\cftchapterfont}{\normalfont}%
\renewcommand{\cftchaptername}{Chapitre\space}%
\renewcommand{\cftchapterindent}{1em}%
%\renewcommand{\cftchapternumwidth}{}%
\renewcommand{\cftchapterpagefont}{\normalfont}%
%\renewcommand{\cftchapterleader}{\cftdotfill{\cftdotsep}}%
}%

\newcommand{\shorttableofcontents}{%
\clearpage
\setupshorttoc
\tableofcontents
}%

% table des matières
\newcommand*{\setuplongtoc}{%
\renewcommand*{\contentsname}{Table des matières}%
\let\changetocdepth\oldchangetocdepth
\setcounter{tocdepth}{7}%
%
% \cftpagenumberson{book}
% \cftpagenumberson{part}
% \cftpagenumberson{chapter}
%
\renewcommand{\tocheadstart}{\chapterheadstart}
%
\renewcommand{\cftbookbreak}{\addpenalty{-\@highpenalty}\clearpage}
\renewcommand{\cftbeforebookskip}{2em}%
\renewcommand{\cftbookfont}{\normalfont\bfseries\Large}%
\renewcommand{\cftbookindent}{0em}%
%\renewcommand{\cftbooknumwidth}{}%
%\renewcommand{\cftafterbookskip}{}%
\renewcommand{\cftbookleader}{\cftdotfill{\cftdotsep}}%
%
\renewcommand{\cftbeforepartskip}{1.5em}%
\renewcommand{\cftpartfont}{\normalfont\bfseries\large}%
\renewcommand{\cftpartindent}{0em}%
%\renewcommand{\cftpartnumwidth}{}%
\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}%
%
\renewcommand{\cftbeforechapterskip}{1em}%
\renewcommand{\cftchapterfont}{\normalfont\bfseries\large}%
\renewcommand{\cftchaptername}{Chapitre\space}%
\renewcommand{\cftchapterindent}{0em}%
%\renewcommand{\cftchapternumwidth}{}%
\renewcommand{\cftchapterleader}{\cftdotfill{\cftdotsep}}%
%
\renewcommand{\cftbeforesectionskip}{0.5em}%
\renewcommand{\cftsectionfont}{\normalfont\large}%
%\renewcommand{\cftsectionname}{Section\space}%
\renewcommand{\cftsectionindent}{0em}%
\renewcommand{\cftsectionnumwidth}{5.5em}%
%\renewcommand{\cftsectionleader}{\cftdotfill{\cftdotsep}}%
%
\renewcommand{\cftbeforesubsectionskip}{0.5em}%
\renewcommand{\cftsubsectionfont}{\normalfont\scshape}%
%\renewcommand{\cftsubsectionname}{}%
\renewcommand{\cftsubsectionindent}{0em}%
\renewcommand{\cftsubsectionnumwidth}{2em}%
%\renewcommand{\cftsubsectionleader}{\cftdotfill{\cftdotsep}}%
%
%\renewcommand{\cftbeforesubsubsectionskip}{}%
\renewcommand{\cftsubsubsectionfont}{\normalfont\itshape}%
%\renewcommand{\cftsubsubsectionname}{}%
\renewcommand{\cftsubsubsectionindent}{1em}%
\renewcommand{\cftsubsubsectionnumwidth}{2em}%
%\renewcommand{\cftsubsubsectionleader}{\cftdotfill{\cftdotsep}}%
%
%\renewcommand{\cftbeforeparagraphskip}{}%
\renewcommand{\cftparagraphfont}{\normalfont}%
%\renewcommand{\cftparagraphname}{}%
\renewcommand{\cftparagraphindent}{2em}%
\renewcommand{\cftparagraphnumwidth}{2em}%
%\renewcommand{\cftparagraphleader}{\cftdotfill{\cftdotsep}}%
%
%\renewcommand{\cftbeforesubparagraphskip}{}%
\renewcommand{\cftsubparagraphfont}{\normalfont}%
%\renewcommand{\cftsubparagraphname}{}%
\renewcommand{\cftsubparagraphindent}{3em}%
\renewcommand{\cftsubparagraphnumwidth}{2em}%
%\renewcommand{\cftsubparagraphleader}{\cftdotfill{\cftdotsep}}%
%
\renewcommand{\cftsubsubparagraphfont}{\normalfont\small}%
%
\renewcommand{\cftsubsubsubparagraphfont}{\normalfont\small}%
%
}%

\newcommand{\longtableofcontents}{%
\clearpage
\setuplongtoc
\tableofcontents
}%

% génération du fichier de style .ist
\begin{filecontents}{\indexvfilename.ist}
% output main entry <entry> as: \item \idxmark{<entry>}, 
item_0 "\n\\item \\idxmark{"
delim_0 "}, "
% not forgetting the subitem case%    added 2008
item_x1 "} \n \\subitem "
% Wrap and uppercase head letters
heading_prefix "{\\bfseries\\hfil "
heading_suffix "\\hfil}\\nopagebreak\n"
headings_flag 1
\end{filecontents}

\begin{filecontents}{\indexafilename.ist}
% output main entry <entry> as: \item \idxmark{<entry>}, 
item_0 "\n\\item \\idxmark{"
delim_0 "}, "
% not forgetting the subitem case%    added 2008
item_x1 "} \n \\subitem "
% Wrap and uppercase head letters
heading_prefix "{\\bfseries\\hfil "
heading_suffix "\\hfil}\\nopagebreak\n"
headings_flag 1
\end{filecontents}

\endinput

