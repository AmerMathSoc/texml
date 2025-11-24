%%
%% This is file `uantwerpenmasterthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% uantwerpendocs.dtx  (with options: `mt')
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
\ProvidesClass{uantwerpenmasterthesis}
    [2016/05/01 v1.7 .dtx skeleton file]
\def\fileversion{1.7}
\def\filedate{2016/05/01}

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
\newcommand{\@supervisori}{}
\newcommand{\@supervisorii}{}
\newcommand{\@supervisoriii}{}
\newcommand{\@supervisoriv}{}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisori}{#1}}
\newcommand{\supervisori}[1]{\renewcommand{\@supervisori}{#1}}
\newcommand{\supervisorii}[1]{\renewcommand{\@supervisorii}{#1}}
\newcommand{\supervisoriii}[1]{\renewcommand{\@supervisoriii}{#1}}
\newcommand{\supervisoriv}[1]{\renewcommand{\@supervisoriv}{#1}}
\newcommand{\@diploma}{ERROR}
\newcommand{\diploma}[1]{
  \newcommand{\MoSIW}{Master of Science in de industri\"ele wetenschappen}
  \newcommand{\MoSTEW}{Master of Science in de toegepaste economische wetenschappen}
  \renewcommand{\@diploma}{
    \ifthenelse{\equal{#1}{MA-IW-BK}}
                          {\MoSIW: bouwkunde}{
    \ifthenelse{\equal{#1}{MA-IW-BCH}}
                          {\MoSIW: biochemie}{
    \ifthenelse{\equal{#1}{MA-IW-CH}}
                          {\MoSIW: chemie}{
    \ifthenelse{\equal{#1}{MA-IW-EI}}
                          {\MoSIW: elektronica-ICT}{
    \ifthenelse{\equal{#1}{MA-IW-EI-AE}}
                          {\MoSIW:\\elektronica-ICT, afstudeerrichting automotive engineering}{
    \ifthenelse{\equal{#1}{MA-IW-EI-ICT}}
                          {\MoSIW:\\elektronica-ICT, afstudeerrichting ICT}{
    \ifthenelse{\equal{#1}{MA-IW-EM-AE}}
                          {\MoSIW:\\elektromechanica, afstudeerrichting automotive engineering}{
    \ifthenelse{\equal{#1}{MA-IW-EM-AU}}
                          {\MoSIW:\\elektromechanica, afstudeerrichting automatisering}{
    \ifthenelse{\equal{#1}{MA-IW-EM-EM}}
                          {\MoSIW:\\elektromechanica, afstudeerrichting elektromechanica}{
    \ifthenelse{\equal{#1}{MA-IW-EM-EN}}
                          {\MoSIW:\\elektromechanica, afstudeerrichting energie}{
    \ifthenelse{\equal{#1}{MA-TEW-HI}}
                          {\MoSTEW: handelsingenieur}{
    \ifthenelse{\equal{#1}{MA-TEW-HIBI}}
                          {\MoSTEW:\\handelsingenieur in de beleidsinformatica}{
    \ifthenelse{\equal{#1}{MA-TEW-EB}}
                          {\MoSTEW: economisch beleid}{
    \ifthenelse{\equal{#1}{MA-TEW-BK}}
                          {\MoSTEW: bedrijfskunde}
    {\errmessage{Error in argument to macro diploma: must be one of
        MA-IW-XXX with XXX one of BCH, CH, EI, EI-AE, EI-ICT, EM-AE,
        EM-AU, EM-EM, EM-EN, MA-TEW-YYY with YYY one of HI, HIBI, EB, BK! <<}}}}}}}}}}}}}}}
}
}
\newcommand{\@defensedate}{ERROR}
\newcommand{\defensedate}[1]{\renewcommand{\@defensedate}{#1}}
\newcommand{\@defenselocation}{Antwerpen}
\newcommand{\defenselocation}[1]{\renewcommand{\@defenselocation}{#1}}
\newcommand{\@academicyear}{XXX-YYYY}
\newcommand{\academicyear}[1]{\renewcommand{\@academicyear}{#1}}
\if@twoside
  \lhead[\thepage]{\slshape\rightmark}
  \chead[]{}
  \rhead[\slshape\leftmark]{\thepage}
  \lfoot[\uaname{} -- \@facultyacronym]{}
  \cfoot[]{}
  \rfoot[]{\@title{}}
\else
  \lhead[]{\leftmark}
  \chead[]{}
  \rhead[]{\thepage}
  \lfoot[]{}
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
\renewcommand\maketitle{%
  \pagestyle{empty}
  \begin{titlepage}
    \begin{tikzpicture}[remember picture,overlay]
      \node at (current page.center) {
        \begin{tikzpicture}[inner sep=0pt]
          \clip (0,0) rectangle(\paperwidth,\paperheight);
          \if@titlepagenoartwork\else
          \filldraw [lightgray] (0.55\paperwidth,\ua@Qba pt) circle (\ua@Rba pt);
          \filldraw [white] (0.35\paperwidth,\ua@Qbb pt) circle (\ua@Rbb pt);
          \filldraw [lightgray] (0,\ua@Qh pt) circle (\ua@Rh pt);
          \path
          (0.95\paperwidth,0.1\paperheight)
          node [anchor=north east] {
            \includegraphics[width=0.25\paperwidth]{\logoname}};
          \fi
          \path
          (\ua@ll pt,0.77\paperheight)
          node [anchor=north west, text width=0.7\paperwidth] {
            \uppercase\expandafter{\uaname}\\~\\
            \academicyearname{} \@academicyear\\~\\
            {\large \@faculty{}}\\~\\
            \masterthesisname{}\\[0.05\paperheight]
            {\Large \bf \@title{}}}
          (\ua@ll pt,0.55\paperheight)
          node [anchor = north west, text width = 0.7\paperwidth] {
            {\large \bf \@author{}}\\~\\~\\
            \begin{tabular}{@{}p{2.7cm}p{10.8cm}}
              \textbf{\promotorsname{}:}
              & \@supervisori \\
              & \@supervisorii \\
              & \@supervisoriii \\
              & \@supervisoriv
            \end{tabular}
          }
          (\ua@ll pt,0.3\paperheight) node [anchor=north west, text width = 0.7\paperwidth]{%
            \thesisname\\
            \@diploma\\
            \@defenselocation, \@defensedate
          };
        \end{tikzpicture}
      };
    \end{tikzpicture}
  \end{titlepage}%
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
  \cleardoublepage
  \thispagestyle{empty}
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.center) {
      \begin{tikzpicture}[inner sep=0pt]
        \clip (0,0) rectangle(\paperwidth,\paperheight);
        \if@titlepagenoartwork\else
        \filldraw [lightgray] (\paperwidth,\ua@Qh pt) circle (\ua@Rh pt);
        \fi
      \end{tikzpicture}
    };
  \end{tikzpicture}
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
        pdfsubject={Master's Thesis},
        pdfauthor={\@author}
      }
    }
}{}
\endinput
%%
%% End of file `uantwerpenmasterthesis.cls'.
