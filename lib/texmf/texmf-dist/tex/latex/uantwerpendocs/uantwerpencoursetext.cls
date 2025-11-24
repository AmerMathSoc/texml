%%
%% This is file `uantwerpencoursetext.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% uantwerpendocs.dtx  (with options: `ct')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2013-2016  by Walter Daems <walter.daems@uantwerpen.be>
%% 
%% This work may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Walter Daems.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{uantwerpencoursetext}
    [2016/05/01 v1.7 .dtx skeleton file]
\def\fileversion{1.7}
\def\filedate{2016/05/01}

\newif\if@copyright
\DeclareOption{copyright}{\@copyrighttrue}
\newif\if@qr
\DeclareOption{qr}{\@qrtrue}
\newif\if@titlepagenoartwork
\DeclareOption{titlepagenoartwork}{\@titlepagenoartworktrue}
\newif\if@titlepagetableonly
\DeclareOption{titlepagetableonly}{\@titlepagetableonlytrue}
\newif\if@filled
\DeclareOption{filled}{\@filledtrue}
\ExecuteOptions{a4paper,11pt,final,oneside,openright}
\ProcessOptions
\LoadClassWithOptions{book}
\setlength{\parindent}{0pt}
\addtolength{\parskip}{0.75\baselineskip}
\setcounter{secnumdepth}{3}
\RequirePackage[top=1in, bottom=1in, left=1in, right=1in]{geometry}
\RequirePackage{ifthen}
\newcommand{\@emptymacro}{}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{tikz}
\if@copyright
\RequirePackage[firstpage=false,contents={Copyright University of Antwerp, All Rights Reserved},color=lightgray,scale=3]{background}
\fi
\if@qr
\RequirePackage{auto-pst-pdf}
\RequirePackage{pst-barcode}
\fi
\RequirePackage{fancyhdr}
\definecolor{uacorpbord}{cmyk}     {0.00,1.00,0.60,0.37}
\definecolor{uacorpblue}{cmyk}     {1.00,0.25,0.00,0.50}
\definecolor{uacorplightblue}{cmyk}{1.00,0.00,0.08,0.13}
\definecolor{uacorporange}{cmyk}   {0.00,0.32,1.00,0.09}
\definecolor{uaftifresh}{cmyk}     {0.34,1.00,0.00,0.00}
\definecolor{uaftisober}{cmyk}     {0.10,1.00,0.00,0.49}
\definecolor{lightgray}{cmyk}      {0.00,0.00,0.00,0.05}
\newcommand{\uaname}{University of Antwerp}
\newcommand{\logoname}{UA_HOR_ENG_CMYK}
\newcommand{\footername}{4E_PMS302_BR_ENG_RGB}
\newcommand{\orname}{of}
\newcommand{\domainname}{uantwerp.be}
\newcommand{\datename}{Date}
\newcommand{\subjectname}{Subject}
\newcommand{\academicyearname}{Academic year}
\newcommand{\masterthesisname}{Master's thesis}
\newcommand{\promotorsname}{Promoters}
\newcommand{\thesisname}{Thesis to obtain the degree of}
\AtBeginDocument{
  \@ifpackageloaded{babel}{
    \addto\captionsdutch{%
      \renewcommand{\uaname}{Universiteit Antwerpen}
      \renewcommand{\logoname}{UA_HOR_NED_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_NED_RGB}
      \renewcommand{\orname}{van}
      \renewcommand{\domainname}{uantwerpen.be}
      \renewcommand{\subjectname}{Onderwerp}%
      \renewcommand{\datename}{Datum}%
      \renewcommand{\academicyearname}{Academiejaar}
      \renewcommand{\masterthesisname}{Masterproef}
      \renewcommand{\promotorsname}{Promotoren}
      \renewcommand{\thesisname}{Proefschrift tot het behalen van de
        graad van}
    }
    \addto\captionsgerman{%
      \renewcommand{\uaname}{Universit\"at Antwerpen}
      \renewcommand{\logoname}{UA_HOR_DUI_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_NED_RGB}
      \renewcommand{\orname}{von}
      \renewcommand{\domainname}{uantwerpen.be}
      \renewcommand{\subjectname}{Betreff}%
      \renewcommand{\datename}{Datum}%
      \renewcommand{\academicyearname}{Akademisches Jahr}
      \renewcommand{\masterthesisname}{Masterdissertation}
      \renewcommand{\promotorsname}{Veranstalter}
      \renewcommand{\thesisname}{Dissertation zur Erreichung des
        Grades der}
    }
    \addto\captionsfrench{%
      \renewcommand{\uaname}{Universit\'e d'Anvers}
      \renewcommand{\logoname}{UA_HOR_FRA_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_ENG_RGB}
      \renewcommand{\orname}{de}
      \renewcommand{\domainname}{uanvers.be}
      \renewcommand{\subjectname}{Objet}%
      \renewcommand{\datename}{Date}%
      \renewcommand{\academicyearname}{Ann\'ee acad\'emique}
      \renewcommand{\masterthesisname}{Th\`ese de master}
      \renewcommand{\promotorsname}{Promoteurs}
      \renewcommand{\thesisname}{Th\`ese \`a l'atteinte du degr\'e de}
    }
    \addto\captionsspanish{%
      \renewcommand{\uaname}{Universidad de Amberes}
      \renewcommand{\logoname}{UA_HOR_SPA_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_ENG_RGB}
      \renewcommand{\orname}{de}
      \renewcommand{\domainname}{uantwerp.be}
      \renewcommand{\subjectname}{Asunto}%
      \renewcommand{\datename}{Fecha}%
      \renewcommand{\academicyearname}{A\~no acad\'emico}
      \renewcommand{\masterthesisname}{Tesis de maestr\'\i{}a}
      \renewcommand{\promotorsname}{Promotores}
      \renewcommand{\thesisname}{Disertaci\'on a la consecuci\'on del
        grado de}
    }
  }
  {}
}
\newcommand{\@facultyacronym}{}
\newcommand{\@faculty}{< Specify faculty using \tbs{}facultyacronym\{ABC\} >}
\newcommand{\facultyacronym}[1]{
  \renewcommand{\@facultyacronym}{#1}
  \ifthenelse{\equal{#1}{CPG}}{\renewcommand\@faculty{Centrum
      Pieter Gillis}}{
  \ifthenelse{\equal{#1}{FBD}}{\renewcommand\@faculty{Faculteit
      Farmaceutische, Biomedische en Diergeneeskundige Wetenschappen}}{
  \ifthenelse{\equal{#1}{GGW}}{\renewcommand\@faculty{Faculteit
      Geneeskunde en Gezondheidswetenschappen}}{
  \ifthenelse{\equal{#1}{IOB}}{\renewcommand\@faculty{Instituut
      voor Ontwikkelingsbeleid- en beheer}}{
  \ifthenelse{\equal{#1}{IOIW}}{\renewcommand\@faculty{Instituut
      voor Onderwijs- en Informatiewetenschappen}}{
  \ifthenelse{\equal{#1}{LW}}{\renewcommand\@faculty{Faculteit
      Letteren en Wijsbegeerte}}{
  \ifthenelse{\equal{#1}{OW}}{\renewcommand\@faculty{Faculteit
      Ontwerpwetenschappen}}{
  \ifthenelse{\equal{#1}{SW}}{\renewcommand\@faculty{Faculteit
      Sociale Wetenschappen}}{
  \ifthenelse{\equal{#1}{REC}}{\renewcommand\@faculty{Faculteit
      Rechten}}{
  \ifthenelse{\equal{#1}{TEW}}{\renewcommand\@faculty{Faculteit
      Toegepaste Economische Wetenschappen}}{
  \ifthenelse{\equal{#1}{TI}}{\renewcommand\@faculty{Faculteit
      Toegepaste Ingenieurswetenschappen}}{
  \ifthenelse{\equal{#1}{WET}}{\renewcommand\@faculty{Faculteit
      Wetenschappen}}{
    \errmessage{Error: wrong faculty acronym; choose one of FBD, GGW,
      LW, OW, PSW, REC, TEW, TI, WET}}}}}}}}}}}}}}
\newcommand{\@qrtitle}{}
\renewcommand{\title}[1]{%
  \renewcommand\@title{#1}
  \ifx\@qrtitle\@emptymacro
  \renewcommand\@qrtitle{#1}
  \fi
}
\newcommand{\qrtitle}[1]{%
  \renewcommand\@qrtitle{#1}
}
\newcommand{\@subtitle}{}
\newcommand{\@qrsubtitle}{}
\newcommand{\subtitle}[1]{%
  \renewcommand\@subtitle{#1}
  \ifx\@qrsubtitle\@emptymacro
    \renewcommand\@qrsubtitle{#1}
  \fi
}
\newcommand{\qrsubtitle}[1]{%
  \renewcommand\@qrsubtitle{#1}
}
\newcommand{\@qrauthor}{}
\renewcommand{\author}[1]{%
  \renewcommand\@author{#1}
  \ifx\@qrauthor\@emptymacro
  \renewcommand\@qrauthor{#1}
  \fi
}
\newcommand{\qrauthor}[1]{%
  \renewcommand\@qrauthor{#1}
}
\newcommand{\@courseversion}{}
\newcommand{\courseversion}[1]{\renewcommand{\@courseversion}{#1}}
\newcommand{\@versionyear}{}
\newcommand{\versionyear}[1]{\renewcommand{\@versionyear}{#1}}
\newcommand{\@publisher}{\uaname\\
Cursusdienst en reprografie\\
Campus Groenenborger, G.U.027\\
Groenenborgerlaan 171\\
2020 Antwerpen\\
T +32 3 265 32 15\\
F + 32 3 233 32 27\\
E cursusdienst.cgb@uantwerpen.be}
\newcommand{\publisher}[1]{\renewcommand{\@publisher}{#1}}
\newcommand{\@publishercode}{}
\newcommand{\publishercode}[1]{\renewcommand{\@publishercode}{#1}}
\newcommand{\@lectureri}{}
\newcommand{\@lecturerii}{}
\newcommand{\@lectureriii}{}
\newcommand{\@lectureriv}{}
\newcommand{\@qrlectureri}{}
\newcommand{\@qrlecturerii}{}
\newcommand{\@qrlectureriii}{}
\newcommand{\@qrlectureriv}{}
\newcommand{\lecturer}[1]{
  \renewcommand{\@lectureri}{#1}
  \ifx\@qrlectureri\@emptymacro
  \renewcommand\@qrlectureri{#1}
  \fi
}
\newcommand{\qrlecturer}[1]{
  \renewcommand\@qrlectureri{#1}
}
\newcommand{\lectureri}[1]{
  \renewcommand{\@lectureri}{#1}
  \ifx\@qrlectureri\@emptymacro
  \renewcommand\@qrlectureri{#1}
  \fi
}
\newcommand{\qrlectureri}[1]{
  \renewcommand\@qrlectureri{#1}
}
\newcommand{\lecturerii}[1]{
  \renewcommand{\@lecturerii}{#1}
  \ifx\@qrlecturerii\@emptymacro
  \renewcommand\@qrlecturerii{#1}
  \fi
}
\newcommand{\qrlecturerii}[1]{
  \renewcommand\@qrlecturerii{#1}
}
\newcommand{\lectureriii}[1]{
  \renewcommand{\@lectureriii}{#1}
  \ifx\@qrlectureriii\@emptymacro
  \renewcommand\@qrlectureriii{#1}
  \fi
}
\newcommand{\qrlectureriii}[1]{
  \renewcommand\@qrlectureriii{#1}
}
\newcommand{\lectureriv}[1]{
  \renewcommand{\@lectureriv}{#1}
  \ifx\@qrlectureriv\@emptymacro
  \renewcommand\@qrlectureriv{#1}
  \fi
}
\newcommand{\qrlectureriv}[1]{
  \renewcommand\@qrlectureriv{#1}
}
\newcommand{\@programmet}{} % type
\newcommand{\@programmec}{} % class
\newcommand{\@programmecqr}{} % class for qr code
\newcommand{\@programmes}{} % class
\newcommand{\@programmeq}{} % qualifier
\newcommand{\programme}[3]{%
    \ifthenelse{\equal{#1}{BA}}%
    {\renewcommand{\@programmet}{Bachelor of Science in de }}{%
    \ifthenelse{\equal{#1}{MA}}%
    {\renewcommand{\@programmet}{Master of Science in de }}{%
    \ifthenelse{\equal{#1}{VP}}%
    {\renewcommand{\@programmet}{Voorbereidingsprogramma voor Master of Science in de }}{%
    \ifthenelse{\equal{#1}{SP}}%
    {\renewcommand{\@programmet}{Schakelprogramma voor Master of Science in de }}{%
    \ifthenelse{\equal{#1}{FREE}}%
    {}{
    \errmessage{Error in 1st arg of macro programme[3]: invalid
      programme type!}}}}}}%
    %
    \ifthenelse{\equal{#2}{IW}}%
    {\renewcommand{\@programmec}{industri\"ele wetenschappen}
     \renewcommand{\@programmecqr}{industriële wetenschappen}}{
    \ifthenelse{\equal{#2}{}}%
    {}{
    \errmessage{{Error in 2nd arg of macro programme[3]: invalid
      programme class! }}}}%
    %
    \ifthenelse{\equal{#3}{BK}}%
    {\renewcommand{\@programmeq}{bouwkunde}}{%
    \ifthenelse{\equal{#3}{CH}}%
    {\renewcommand{\@programmeq}{chemie}}{%
    \ifthenelse{\equal{#3}{BCH}}%
    {\renewcommand{\@programmeq}{biochemie}}{%
    \ifthenelse{\equal{#3}{EM}}%
    {\renewcommand{\@programmeq}{elektromechanica}}{%
    \ifthenelse{\equal{#3}{EI}}%
    {\renewcommand{\@programmeq}{elektronica-ICT}}{%
    \ifthenelse{\equal{#3}{}}%
    {}{%
    \ifthenelse{\equal{#1}{FREE}}
    {\renewcommand{\@programmeq}{#3}}{
    \errmessage{Error in 3rd arg to macro programme[3]: invalid
      programme qualifier}}}}}}}}%
    %
    \ifthenelse{\equal{#2}{IW}\and\not\equal{#3}{}}
    {\renewcommand{\@programmes}{: }}{}
}
\newcommand{\@coursecodei}{}
\newcommand{\@coursecodeii}{}
\newcommand{\@coursecodeiii}{}
\newcommand{\@coursecodeiv}{}
\newcommand{\@coursei}{}
\newcommand{\@courseii}{}
\newcommand{\@courseiii}{}
\newcommand{\@courseiv}{}
\newcommand{\@qrcoursei}{}
\newcommand{\@qrcourseii}{}
\newcommand{\@qrcourseiii}{}
\newcommand{\@qrcourseiv}{}
\newcommand{\course}[2]{
  \renewcommand{\@coursecodei}{#1}
  \renewcommand{\@coursei}{#2}
  \ifx\@qrcoursei\@emptymacro
  \renewcommand{\@qrcoursei}{#2}
  \fi
}
\newcommand{\qrcourse}[1]{
  \renewcommand{\@qrcoursei}{#1}
}
\newcommand{\coursei}[2]{
  \renewcommand{\@coursecodei}{#1}
  \renewcommand{\@coursei}{#2}
  \ifx\@qrcoursei\@emptymacro
  \renewcommand{\@qrcoursei}{#2}
  \fi
}
\newcommand{\qrcoursei}[1]{
  \renewcommand{\@qrcoursei}{#1}
}
\newcommand{\courseii}[2]{
  \renewcommand{\@coursecodeii}{#1}
  \renewcommand{\@courseii}{#2}
  \ifx\@qrcourseii\@emptymacro
  \renewcommand{\@qrcourseii}{#2}
  \fi
}
\newcommand{\qrcourseii}[1]{
  \renewcommand{\@qrcourseii}{#1}
}
\newcommand{\courseiii}[2]{
  \renewcommand{\@coursecodeiii}{#1}
  \renewcommand{\@courseiii}{#2}
  \ifx\@qrcourseiii\@emptymacro
  \renewcommand{\@qrcourseiii}{#2}
  \fi
}
\newcommand{\qrcourseiii}[1]{
  \renewcommand{\@qrcourseiii}{#1}
}
\newcommand{\courseiv}[2]{
  \renewcommand{\@coursecodeiv}{#1}
  \renewcommand{\@courseiv}{#2}
  \ifx\@qrcourseiv\@emptymacro
  \renewcommand{\@qrcourseiv}{#2}
  \fi
}
\newcommand{\qrcourseiv}[1]{
  \renewcommand{\@qrcourseiv}{#1}
}
\newcommand{\@academicyear}{XXX-YYYY}
\newcommand{\academicyear}[1]{\renewcommand{\@academicyear}{#1}}
\newcommand{\@copyrightnotices}{}
\newcommand{\copyrightnotices}[1]{\renewcommand{\@copyrightnotices}{#1}}
\if@twoside
\lhead[\thepage]{\slshape\rightmark}
\chead[]{}
\rhead[\slshape\leftmark]{\thepage}
\lfoot[\uaname{} -- \@facultyacronym]{\@courseversion}
\cfoot[]{}
\rfoot[]{\@title{}\@ifmtarg{\@subtitle}{}{ --- \@subtitle}}
\else
\lhead[]{\leftmark}
\chead[]{}
\rhead[]{\thepage}
\lfoot[]{\@courseversion}
\cfoot[]{UAntwerpen--\@facultyacronym}
\rfoot[]{\@title{}}
\fi
\setlength{\headheight}{13.7pt}
\renewcommand{\headrulewidth}{1pt}
\renewcommand{\footrulewidth}{1pt}
\pagenumbering{arabic}
\if@filled\else
  \raggedright
\fi
\raggedbottom
\onecolumn
\newcommand{\@crnotice}{
  This document has been typeset using \LaTeX{} and the
  \texttt{uantwerpencoursetext} class.\\
  \@copyrightnotices

  \@courseversion

  CONFIDENTIAL AND PROPRIETARY.

  \copyright{} \@versionyear{} University of Antwerp, All rights reserved.
}
\pgfmathsetmacro{\ua@Wh}{\paperwidth}
\pgfmathsetmacro{\ua@Xh}{0.2\paperheight}
\pgfmathsetmacro{\ua@Yh}{0.125\paperheight}
\pgfmathsetmacro{\ua@XMYh}{\ua@Xh-\ua@Yh}
\pgfmathsetmacro{\ua@Rh}{0.5*\ua@Wh/\ua@XMYh*\ua@Wh+0.5*\ua@XMYh}
\pgfmathsetmacro{\ua@Qh}{\ua@Rh-\ua@Xh+\paperheight}
\pgfmathsetmacro{\ua@Wba}{0.4*\paperwidth}
\pgfmathsetmacro{\ua@Sba}{0.125*\paperheight}
\pgfmathsetmacro{\ua@XMYba}{0.02\paperheight}
\pgfmathsetmacro{\ua@Rba}{0.5*\ua@Wba/\ua@XMYba*\ua@Wba+0.5*\ua@XMYba}
\pgfmathsetmacro{\ua@Qba}{\ua@Rba+\ua@Sba}
\pgfmathsetmacro{\ua@Wbb}{0.65*\paperwidth}
\pgfmathsetmacro{\ua@Sbb}{0.14*\paperheight}
\pgfmathsetmacro{\ua@XMYbb}{0.06\paperheight}
\pgfmathsetmacro{\ua@Rbb}{0.5*\ua@Wbb/\ua@XMYbb*\ua@Wbb+0.5*\ua@XMYbb}
\pgfmathsetmacro{\ua@Qbb}{\ua@Rbb+\ua@Sbb}
\pgfmathsetmacro{\ua@ll}{0.15*\paperwidth}
\pgfmathsetmacro{\ua@l}{0.4*\paperwidth}
\pgfmathsetmacro{\ua@d}{0.1in}
\pgfmathsetmacro{\ua@rr}{0.85*\paperwidth}
\newcommand\sprtr{ / }
\newcommand\myqrdata{
I: Universiteit Antwerpen\string\n
F: \@faculty\string\n
P: \@programmet\ \@programmecqr\ \@programmeq\string\n
C: \@coursecodei\ \@qrcoursei
\sprtr
\@coursecodeii\ \@qrcourseii
\sprtr
\@coursecodeiii\ \@qrcourseiii
\sprtr
\@coursecodeiv\ \@qrcourseiv
\string\n
Y: \@academicyear\string\n
T: \@qrtitle\string\n
S: \@qrsubtitle\string\n
A: \@qrauthor\string\n
L: \@qrlectureri
\sprtr
\@qrlecturerii
\sprtr
\@qrlectureriii
\sprtr
\@qrlectureriv}
\newsavebox{\myqrcode}
\renewcommand\maketitle{%
  \pagestyle{empty}
  \if@qr
  \savebox{\myqrcode}[2.7in][t]{
    \begin{pspicture}(2.7in,2.7in)
      \psbarcode{\myqrdata}{width=1.0 height=1.0 encoding=byte eclevel=M}{qrcode}
    \end{pspicture}
  }
  \fi
  \begin{titlepage}
    \if@titlepagetableonly
    Dit is een cursustekst van Universiteit Antwerpen.\\
    Het titelblad dient opgemaakt te worden met de volgende gegevens:
    \begin{center}
      \begin{tabular}{|l|l|}
        \hline
        \bfseries I & Universiteit Antwerpen \\\hline
        \bfseries F & \@faculty \\\hline
        \bfseries P & \parbox[t]{14cm}{\@programmet
          \@programmec\@programmes \@programmeq}  \\\hline
        \bfseries C & \parbox[t]{14cm}{
          \texttt{\@coursecodei} \@coursei\\
          \texttt{\@coursecodeii} \@courseii\\
          \texttt{\@coursecodeiii} \@courseiii\\
          \texttt{\@coursecodeiv} \@courseiv} \\\hline
        \bfseries Y & \@academicyear \\\hline
        \bfseries T & \parbox[t]{14cm}{\@title}\\\hline
        \bfseries S & \parbox[t]{14cm}{\@subtitle}\\\hline
        \bfseries A & \parbox[t]{14cm}{\@author}\\\hline
        \bfseries L & \parbox[t]{14cm}{\@lectureri\\
                                       \@lecturerii\\
                                       \@lectureriii\\
                                       \@lectureriv} \\\hline
      \end{tabular}
    \end{center}
    ~\\
    Waarbij: I = instelleng, F = faculteit, P = programma, C =
    cursusmodule, T = titel, S = subtitel, A = auteur(s), L =
    lesgever(s)\\~\\
    \if@qr
    Deze informatie is ook gecodeerd in de onderstaande QR-code.\\
    \vspace*{1cm}
    \usebox{\myqrcode}
    \fi
    \else
    \begin{tikzpicture}[remember picture,overlay]
      \node at (current page.center) {
        \begin{tikzpicture}[inner sep=0pt]
          \clip (0,0) rectangle(\paperwidth,\paperheight);
          \if@titlepagenoartwork\else
          \filldraw [uacorpbord] (0.55\paperwidth,\ua@Qba pt) circle (\ua@Rba pt);
          \filldraw [white] (0.35\paperwidth,\ua@Qbb pt) circle (\ua@Rbb pt);
          \filldraw [uacorpblue] (0,\ua@Qh pt) circle (\ua@Rh pt);
          \path
          (0.95\paperwidth,0.1\paperheight)
          node [anchor=north east] {
            \includegraphics[width=0.25\paperwidth]{\logoname}};
          \fi
          \path
          (\ua@l pt -\ua@d pt,0.77\paperheight)
          node [anchor=north east, text width=0.35\paperwidth] {
            \begin{flushright}
              \uppercase\expandafter{\uaname}\\~\\
              \academicyearname{} \@academicyear
            \end{flushright}}
          (\ua@l pt +\ua@d pt,0.65\paperheight)
          node [anchor = north west, text width = 0.55\paperwidth] {
            {\large \@faculty{}}\\[0.05\paperheight]
            {\huge \bf \@title{}}\\[2ex]
            {\Large \bf \@subtitle{}}\\[3ex]
            {\Large \bf \@author{}}}
          (\ua@l pt +\ua@d pt,0.45\paperheight)
          node [anchor = north west, text width = 0.55\paperwidth] {
            \@lectureri~\\
            \@lecturerii~\\
            \@lectureriii~\\
            \@lectureriv}
          (\ua@l pt +\ua@d pt,0.35\paperheight)
          node [anchor = north west, text width = 0.55\paperwidth] {
            {\bf \@programmet \\ \@programmec\@programmes  \@programmeq}}
          (\ua@l pt +\ua@d pt,0.30\paperheight)
          node [anchor = north west, text width = 0.55\paperwidth] {
            \texttt{\@publishercode}~\\~\\
            \texttt{\@coursecodei{}} \@coursei~\\
            \texttt{\@coursecodeii{}} \@courseii~\\
            \texttt{\@coursecodeiii{}} \@courseiii~\\
            \texttt{\@coursecodeiv{}} \@courseiv}
          (\ua@l pt - 2\ua@d pt, 0.368\paperheight)
          node [anchor = north east, text width = 0.35\paperwidth] {
            {\normalsize\begin{flushright}
                \@publisher{}
              \end{flushright}}};
        \end{tikzpicture}
      };
    \end{tikzpicture}
    \fi
  \end{titlepage}%
  \clearpage
  \vspace*{\stretch{1}}
  \@crnotice
  \clearpage
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \pagestyle{fancy}
  \thispagestyle{empty}
}
\newcommand\makefinalpage{
  \if@titlepagetableonly
  \else
  \cleardoublepage
  \thispagestyle{empty}
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.center) {
      \begin{tikzpicture}[inner sep=0pt]
        \clip (0,0) rectangle(\paperwidth,\paperheight);
        \if@titlepagenoartwork\else
        \filldraw [uacorpblue] (\paperwidth,\ua@Qh pt) circle (\ua@Rh pt);
        \fi
        \path
        (0.1\paperwidth,0.1\paperheight)
        node [anchor = south west, text width = 0.6\paperwidth] {
          CONFIDENTIAL AND PROPRIETARY\\~\\

          \copyright{} \@versionyear{} \uaname,
          All rights reserved.}
        (0.9\paperwidth,0.1\paperwidth)
        node [anchor = south east] {
          \usebox{\myqrcode}
        };
      \end{tikzpicture}
    };
  \end{tikzpicture}
  \fi
}
\IfFileExists{varioref.sty}{\RequirePackage{varioref}}{}
\IfFileExists{hyperref.sty}{
    \RequirePackage{hyperref}
    \hypersetup{
      backref=true,
      breaklinks=true,
      colorlinks=true,
      citecolor=black,
      filecolor=black,
      hyperindex=true,
      linkcolor=black,
      pageanchor=true,
      pagebackref=true,
      pagecolor=black,
      pdfpagemode=UseOutlines,
      urlcolor=black
    }
    \AtBeginDocument{
      \hypersetup{
        pdftitle={\@title},
        pdfsubject={\@subtitle},
        pdfauthor={\@author}
      }
    }
}{}
\endinput
%%
%% End of file `uantwerpencoursetext.cls'.
