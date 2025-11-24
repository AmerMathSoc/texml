% Classe `fiche' -- Devoir et fiches d'exercices
% Copyright (c) Christian Obrecht 2005.

\ProvidesClass{fiche}

\LoadClass[a4paper]{article}
\RequirePackage{mafr}

\nofiles
\pagestyle{empty}

% En-tête

\newcommand{\entete}[3]
{\noindent{\bf#1\hfill#2}\medskip\\\centerline{\bf\large#3}\medskip}

% Exercices

\parskip=4pt
\parindent=0pt

\newcount\squnumber
\def\sque{\global\advance\squnumber by 1\hangindent=3em%
\hbox to 1.5em{\bf\char\squnumber .\hfil}}
\def\squ{\par\noindent\kern1.5em\sque}

\newcount\quenumber
\def\que{\par\squnumber="60\global\advance\quenumber by 1\hangindent=1.5em%
\noindent\hbox to 1.5em{\bf\the\quenumber .\hfil}}
\def\qsq{\que\sque}

\newcount\exenumber
\def\exe{\quenumber=0\advance\exenumber by 1%
\bigskip\par{\it Exercice \the\exenumber}\par}

% Environnement `juxtapose' pour une illustration en parallèle avec un texte

\makeatletter
\newlength\dr@ite
\newenvironment{juxtapose}[1][.5\textwidth]
{\def\droite{\hfill\egroup\vcenter\bgroup
\dr@ite=\textwidth\advance\dr@ite by -#1\hsize=\dr@ite}
\hbox\bgroup$\vcenter\bgroup\hsize=#1}
{\egroup$\egroup}
\makeatother
