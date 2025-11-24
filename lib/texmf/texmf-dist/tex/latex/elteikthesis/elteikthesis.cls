%%
%% This is file `elteikthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ./elteikthesis.dtx  (with options: `class')
%% This is a generated file.
%% Copyright (C) 2010 Majoros Daniel
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.2 of this license or (at your option) any later
%% version. The latest version of this license is in:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of
%% LaTeX version 1999/12/01 or later.
%% 

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{elteikthesis}[2010/09/18 v1.2 class for ELTE/IK thesis]
\LoadClass[a4paper,12pt,oneside]{book}
\RequirePackage{graphicx}
\frenchspacing
\RequirePackage[left=3.5cm, top=2.5cm, right=2.5cm, bottom=2.5cm]{geometry}
\RequirePackage[onehalfspacing]{setspace}
\newcommand{\ths@period}{}
\DeclareRobustCommand{\period}[1]{
\renewcommand{\ths@period}{#1}
}
\newcommand{\ths@supervisor}{}
\DeclareRobustCommand{\supervisor}[1]{
\renewcommand{\ths@supervisor}{#1}
}
\newcommand{\ths@supervisorstitle}{}
\DeclareRobustCommand{\supervisorstitle}[1]{
\renewcommand{\ths@supervisorstitle}{#1}
}
\newcommand{\ths@city}{Budapest}
\DeclareRobustCommand{\city}[1]{
\renewcommand{\ths@city}{#1}
}
\newcommand{\ths@thesisyear}{}
\DeclareRobustCommand{\thesisyear}[1]{
\renewcommand{\ths@thesisyear}{#1}
}
\newcommand{\ths@university}{E\"otv\"os Lor\'and Tudom\'anyegyetem}
\DeclareRobustCommand{\university}[1]{
\renewcommand{\ths@university}{#1}
}
\newcommand{\ths@additionaltext}{}
\DeclareRobustCommand{\additionaltext}[1]{
\renewcommand{\ths@additionaltext}{#1}
}
\newcommand{\ths@faculty}{Informatikai Kar}
\DeclareRobustCommand{\faculty}[1]{
\renewcommand{\ths@faculty}{#1}
}
\newcommand{\ths@department}{}
\DeclareRobustCommand{\department}[1]{
\renewcommand{\ths@department}{#1}
}
\newcommand{\ths@logopic}{pics/eltecimerszines}
\DeclareRobustCommand{\logopic}[1]{
\renewcommand{\ths@logopic}{#1}
}

\DeclareRobustCommand{\temavezeto}[1]{\supervisor{#1}}
\DeclareRobustCommand{\temavezetocime}[1]{\supervisorstitle{#1}}
\DeclareRobustCommand{\egyetem}[1]{\university{#1}}
\DeclareRobustCommand{\kar}[1]{\faculty{#1}}
\DeclareRobustCommand{\tanszek}[1]{\department{#1}}
\DeclareRobustCommand{\evszam}[1]{\thesisyear{#1}}
\DeclareRobustCommand{\varos}[1]{\city{#1}}
\DeclareRobustCommand{\szak}[1]{\period{#1}}
\DeclareRobustCommand{\plusszoveg}[1]{\additionaltext{#1}}
\renewcommand{\maketitle}{
\begin{titlepage}
\vspace*{0cm}
\centering
\begin{tabular}{cp{2cm}c}
\begin{minipage}{4cm}
\vspace{0pt}
\includegraphics[width=1\textwidth]{\ths@logopic}
\end{minipage} & &
\begin{minipage}{7cm}
\vspace{0pt}\ths@university \vspace{10pt}
\newline \ths@faculty \vspace{10pt}
\newline \ths@department
\end{minipage}
\end{tabular}

\vspace*{0.2cm}
\rule{\textwidth}{1pt}

\vspace*{6cm}
{\Huge \@title}

\vspace*{5cm}
\begin{tabular}{lp{3cm}l}
\ths@supervisor  & &  \@author \\
\ths@supervisorstitle & & \ths@period
\end{tabular}

\vfill
\ths@additionaltext

\vspace*{1cm}
\ths@city, \ths@thesisyear
\end{titlepage}
}
\endinput
%%
%% End of file `elteikthesis.cls'.
