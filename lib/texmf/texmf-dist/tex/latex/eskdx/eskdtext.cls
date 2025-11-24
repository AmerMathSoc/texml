% Copyright 2006 Konstantin Korikov <lostclus@ua.fm>
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "maintained".
% 
% This Current Maintainer of this work is Konstantin Korikov.
%
% This work consists of all files listed in manifest.txt.
%

%
% This is automaticaly generated file, do not edit it.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eskdtext}[2010/01/14 v0.98 Textual Documentation]

\newcommand{\ESKD@docfont}{14pt}
\newcommand{\ESKD@float@style}{single}
\newcommand{\ESKD@equation@style}{single}

\DeclareOption{russian}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{ukrainian}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{koi8-r}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{koi8-u}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{cp1251}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{iso8859-5}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{cp866}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{utf-8}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{utf8}{\PassOptionsToPackage{\CurrentOption}{eskdlang}}
\DeclareOption{12pt}{\renewcommand{\ESKD@docfont}{12pt}}
\DeclareOption{14pt}{\renewcommand{\ESKD@docfont}{14pt}}
\DeclareOption{pointsingle}{\PassOptionsToPackage{\CurrentOption}{eskdsect}}
\DeclareOption{pointsection}{\PassOptionsToPackage{\CurrentOption}{eskdsect}}
\DeclareOption{pointsubsection}{\PassOptionsToPackage{\CurrentOption}{eskdsect}}
\DeclareOption{floatsingle}{\renewcommand{\ESKD@float@style}{single}}
\DeclareOption{floatsection}{\renewcommand{\ESKD@float@style}{section}}
\DeclareOption{floatsubsection}{\renewcommand{\ESKD@float@style}{subsection}}
\DeclareOption{equationsingle}{\renewcommand{\ESKD@equation@style}{single}}
\DeclareOption{equationsection}{\renewcommand{\ESKD@equation@style}{section}}
\DeclareOption{equationsubsection}{\renewcommand{\ESKD@equation@style}{subsection}}
\DeclareOption{footnotearabic}{\PassOptionsToPackage{\CurrentOption}{eskdfootnote}}
\DeclareOption{footnoteasterisk}{\PassOptionsToPackage{\CurrentOption}{eskdfootnote}}
\DeclareOption{twoside}{%
  \PassOptionsToClass{\CurrentOption}{extarticle}%
  \PassOptionsToPackage{\CurrentOption}{eskdstamp}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{extarticle}}
\DeclareOption{formI}{%
  \ClassError{eskdtext}{formI style is for graphical documentaion}{}}
\DeclareOption{zonelabels}{%
  \ClassError{eskdtext}{Zone labels is not allowed for textual documentaion}{}}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{eskdstamp}}

\ProcessOptions\relax

\LoadClass[\ESKD@docfont]{extarticle}
\RequirePackage{eskdlang}
\RequirePackage[a4paper,formII]{eskdstamp}
\RequirePackage{eskdindent}
\RequirePackage{eskdlist}
\RequirePackage{eskdsect}
\RequirePackage{eskdcap}
\RequirePackage{eskdfootnote}
\RequirePackage{eskdbiblist}
\RequirePackage{eskdexplan}
\RequirePackage{eskdinfo}
\RequirePackage{eskdtitlebase}
\RequirePackage{eskdtitle}

\linespread{1.25}

\newcommand{\ESKD@float@style@single}{}

\newcommand{\ESKD@float@style@section}{
  \@addtoreset{figure}{section}
  \@addtoreset{table}{section}
  \renewcommand{\thefigure}{%
    \ifnum \c@section>\z@ \thesection.\fi \arabic{figure}}
  \renewcommand{\thetable}{%
    \ifnum \c@section>\z@ \thesection.\fi \arabic{table}}}

\newcommand{\ESKD@float@style@subsection}{
  \@addtoreset{figure}{subsection}
  \@addtoreset{table}{subsection}
  \renewcommand{\thefigure}{%
    \ifnum \c@subsection>\z@ \thesubsection.\fi \arabic{figure}}
  \renewcommand{\thetable}{%
    \ifnum \c@subsection>\z@ \thesubsection.\fi \arabic{table}}}

\@nameuse{ESKD@float@style@\ESKD@float@style}

\newcommand{\ESKD@equation@style@single}{}

\newcommand{\ESKD@equation@style@section}{
  \@addtoreset{equation}{section}
  \renewcommand{\theequation}{%
    \ifnum \c@section>\z@ \thesection.\fi \arabic{equation}}}

\newcommand{\ESKD@equation@style@subsection}{
  \@addtoreset{equation}{subsection}
  \renewcommand{\theequation}{%
    \ifnum \c@subsection>\z@ \thesubsection.\fi \arabic{equation}}}

\@nameuse{ESKD@equation@style@\ESKD@equation@style}

