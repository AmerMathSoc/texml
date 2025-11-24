%%
%% This is file `kdgmasterthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% kdgdocs.dtx  (with options: `mt')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2010-2011 by Paul Levrie  <paul.levrie@kdg.be>
%%                        and Walter Daems <walter.daems@kdg.be>
%% 
%% This work may be used, distributed and/or modified under the
%% conditions of the KdG-only LICENSE version 1.0.
%% 
%% This license can be found in the file LICENSE of this work.
%% 
%% This work consists of the files listed in the file manifest.txt.
%% 
%% This work has maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Walter Daems.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{kdgmasterthesis}
    [2011/11/01 v1.0 .dtx skeleton file]
\ExecuteOptions{a4paper,11pt,final,oneside,openright}
\ProcessOptions
\LoadClassWithOptions{book}
\setlength{\parindent}{0pt}
\addtolength{\parskip}{0.75\baselineskip}
\setcounter{secnumdepth}{3}
\RequirePackage[top=1in, bottom=1in, left=1in, right=1in]{geometry}
\newcommand{\selectverdananormal}
{
  \PackageError{kdgdocs}{
    Sorry, your font system is not set up appropriately.
    Please, use XeTeX, or pdfTeX in conjunction with the
    winfonts package or the verdana package (available from CTAN).
  }{1}
}
\newcommand{\selectverdanabold}{\selectverdananormal}
\RequirePackage{ifxetex}
\ifxetex
\RequirePackage{cmbright}
\RequirePackage{fontspec}
\addfontfeature{Ligatures=Common}
\renewcommand{\selectverdananormal}{\fontspec{Verdana}}
\renewcommand{\selectverdanabold}{\fontspec{Verdana}\bfseries}
\else
\IfFileExists{verdana.sty}
{\RequirePackage{verdana}
  \renewcommand{\selectverdananormal}{\usefont{T1}{vna}{m}{n}}
  \renewcommand{\selectverdanabold}{\usefont{T1}{vna}{b}{n}}
}
{\IfFileExists{winfonts.sty}
  {\RequirePackage{winfonts}
    \renewcommand{\selectverdananormal}{\usefont{T1}{verdana}{m}{n}}
    \renewcommand{\selectverdanabold}{\usefont{T1}{verdana}{b}{n}}}
  {}
}
\RequirePackage{cmbright}
\RequirePackage{ifthen}
\fi
\RequirePackage{graphicx}
\RequirePackage{eso-pic}
\RequirePackage{color}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\newcommand{\@department}{Industri\"ele Wetenschappen en Technologie}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\@departmentacronym}{IWT}
\newcommand{\departmentacronym}[1]{\renewcommand{\@departmentacronym}{#1}}
\newcommand{\@promoteri}{}
\newcommand{\@promoterii}{}
\newcommand{\@promoteriii}{}
\newcommand{\@promoteriv}{}
\newcommand{\promoter}[1]{\renewcommand{\@promoteri}{#1}}
\newcommand{\promoteri}[1]{\renewcommand{\@promoteri}{#1}}
\newcommand{\promoterii}[1]{\renewcommand{\@promoterii}{#1}}
\newcommand{\promoteriii}[1]{\renewcommand{\@promoteriii}{#1}}
\newcommand{\promoteriv}[1]{\renewcommand{\@promoteriv}{#1}}
\newcommand{\@diploma}{ERROR}
\newcommand{\diploma}[1]{
  \newcommand{\MoSIW}{Master of Science in de Industri\"ele Wetenschappen}
  \renewcommand{\@diploma}{
    \ifthenelse{\equal{#1}{BCH}}{\MoSIW{} Biochemie}{
    \ifthenelse{\equal{#1}{CH}}{\MoSIW{} Chemie}{
    \ifthenelse{\equal{#1}{EI-AE}}{\MoSIW\\Elektroncia-ICT, afstudeerrichting Automotive Engineering}{
    \ifthenelse{\equal{#1}{EI-ICT}}{\MoSIW\\Elektroncia-ICT, afstudeerrichting ICT}{
    \ifthenelse{\equal{#1}{EM-AE}}{\MoSIW\\Elektromechanica, afstudeerrichting Automotive Engineering}{
    \ifthenelse{\equal{#1}{EM-AU}}{\MoSIW\\Elektromechanica, afstudeerrichting Automatisering}{
    \ifthenelse{\equal{#1}{EM-EM}}{\MoSIW\\Elektromechanica, afstudeerrichting Elektromechanica}{>> ERROR: diploma must be one of BCH, CH, EI-AE, EI-ICT, EM-AE, EM-AU, EM-EM! <<}}}}}}}}
}

\newcommand{\@defensedate}{ERROR}
\newcommand{\defensedate}[1]{\renewcommand{\@defensedate}{#1}}
\newcommand{\@defenselocation}{Hoboken}
\newcommand{\defenselocation}[1]{\renewcommand{\@defenselocation}{#1}}
\newcommand{\@academicyear}{XXX-YYYY}
\newcommand{\academicyear}[1]{\renewcommand{\@academicyear}{#1}}
\if@twoside
  \lhead[\thepage]{\slshape\rightmark}
  \chead[]{}
  \rhead[\slshape\leftmark]{\thepage}
  \lfoot[Karel de Grote-Hogeschool -- \@departmentacronym]{}
  \cfoot[]{}
  \rfoot[]{\@title{}}
\else
  \lhead[]{\leftmark}
  \chead[]{}
  \rhead[]{\thepage}
  \lfoot[]{}
  \cfoot[]{KdG--\@departmentacronym}
  \rfoot[]{\@title{}}
\fi
\renewcommand{\headrulewidth}{1pt}
\renewcommand{\footrulewidth}{1pt}
\pagestyle{fancy}
\raggedbottom
\raggedright
\pagenumbering{arabic}
\onecolumn
\renewcommand\maketitle{%
  \definecolor{lightlightgray}{cmyk}{0,0,0,0.05}
  \definecolor{kdggroen}{cmyk}{0.29,0,1,0}
  \pagestyle{empty}
  \begin{titlepage}
    \AddToShipoutPicture*{%
      \setlength{\unitlength}{1cm}
      \put(0,0){%
        \begin{tikzpicture}[inner sep=0pt]
          \fill[color=kdggroen] (0,0)
          (2,1.5) -- (2,2.5) -- (19,2.5) -- (19,1.5) -- cycle;
          \fill[color=lightlightgray] (0,0)
          (2,2.5) -- (2,26.31) -- (19,27.2) -- (19,2.5) -- cycle;
          \path
          (2,28.2) node[anchor=north west]{\includegraphics[width=8.3cm]{kdg_color}}
          (2.5,25.8) node[anchor=north west, text width=15cm]{
            {\selectverdanabold\large Departement \@department{}}\\[0.13cm]
            {\selectverdanabold\large Masterproef \@academicyear}
          }
          (3.5,20) node [anchor=north west, text width=14cm]{
            {\selectverdanabold\Large \@title{}}\\[0.2cm]
            {\selectverdananormal\large \@author{}}
          }
          (2.5,12.2) node [anchor=south west, text width=13cm]{
            \selectverdananormal\small
            \begin{tabular}{@{}p{2.5cm}p{11cm}}
              \textbf{Promotoren:}
              & \@promoteri \\
              & \@promoterii \\
              & \@promoteriii \\
              & \@promoteriv
            \end{tabular}
          }
          (18.5,5.5) node [anchor=north east]{%
            \selectverdananormal\small
            \begin{tabular}{@{}r}
              Proefschrift tot het behalen van de graad van\\
              \@diploma\\
              \@defenselocation, \@defensedate
            \end{tabular}
          };
        \end{tikzpicture}
      }
    }%
    \phantom{Do not remove: this causes an empty title page to be generated}
  \end{titlepage}%
  \if@twoside
  \cleardoublepage
  \else
  \clearpage
  \fi
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
\RequirePackage{hyperref}
\hypersetup{backref=true,
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
            urlcolor=black}
\AtBeginDocument{
  \hypersetup{
    pdftitle={\@title},
    pdfsubject={Master's Thesis},
    pdfauthor={\@author}
  }
}
\endinput
%%
%% End of file `kdgmasterthesis.cls'.
