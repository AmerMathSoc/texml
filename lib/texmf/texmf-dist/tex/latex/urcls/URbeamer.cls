% Copyright 2014-2015 by Marei Peischl
%
% This file may be distributed and/or modified
% under the LaTeX Project Public License
\NeedsTeXFormat{LaTeX2e}
\def\fileversion{1.6}
\def\filedate{2015/06/15}
\ProvidesClass{URbeamer}
 [\filedate\space\fileversion\space
   beamer basierte Dokumentenklasse im Corporate Design der Universität Regensburg]

\RequirePackage{ifthen}
\newboolean{UR@draft}


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %5 % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%Hausschriftart
%\RequirePackage{frutigernext}
\renewcommand*\familydefault{\sfdefault}

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%%Optionen zum aktivieren einzelner Farben
\DeclareOption{lov}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{ffg}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{asz}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{rw}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{ww}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{kt}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{pkgg}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{pps}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{slk}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{bvm}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{mat}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{ph}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{chp}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{med}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{ub}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{zsk}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{eur}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{zhw}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{rul}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{zfw}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{spo}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{rz}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{fsimphy}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{externalize}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
%%Sammelaktivierung: all=alle Farben, faculties=alle 11 Fakultäten
\DeclareOption{all}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{faculties}{\PassOptionsToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{coloredboxes}{\PassOptionesToPackage{\CurrentOption}{beamerouterthemeUR}}
\DeclareOption{draft}{\setboolean{UR@draft}{true}\PassOptionsToClass{draft}{beamer}}
\DeclareOption{handout}{\PassOptionsToClass{handout}{beamer}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[xcolor=table,covered,hyperref={bookmarks,colorlinks}]{beamer}
%Laden der notwendigen Ergänzungspakete
\RequirePackage{graphicx}
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %5
\mode<presentation>%refers to the first four modes (beamer,handout,second and trans). That is, to all modes except the article mode
{
   \usetheme{UR}
%    	
%    	
   	\def\maketitle{
   		\ifbeamer@inframe\titlepage\else\frame{\titlepage}\fi}
   	



\setbeamertemplate{navigation symbols}{}
}

\mode<all>

\endinput


