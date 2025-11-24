%%
%% This is file `kdgcoursetext.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% kdgdocs.dtx  (with options: `ct')
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
\ProvidesClass{kdgcoursetext}
    [2011/11/01 v1.0 .dtx skeleton file]
\newif\if@copyright
\DeclareOption{copyright}{\@copyrighttrue}
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
\newcommand{\@subtitle}{}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\@courseversion}{}
\newcommand{\courseversion}[1]{\renewcommand{\@courseversion}{#1}}
\newcommand{\@versionyear}{}
\newcommand{\versionyear}[1]{\renewcommand{\@versionyear}{#1}}
\newcommand{\@versioncomment}{}
\newcommand{\versioncomment}[1]{\renewcommand{\@versioncomment}{#1}}
\newcommand{\@professori}{}
\newcommand{\@professorii}{}
\newcommand{\@professoriii}{}
\newcommand{\@professoriv}{}
\newcommand{\professor}[1]{\renewcommand{\@professori}{#1}}
\newcommand{\professori}[1]{\renewcommand{\@professori}{#1}}
\newcommand{\professorii}[1]{\renewcommand{\@professorii}{#1}}
\newcommand{\professoriii}[1]{\renewcommand{\@professoriii}{#1}}
\newcommand{\professoriv}[1]{\renewcommand{\@professoriv}{#1}}
\newcommand{\@programme}{}
\newcommand{\programme}[1]{\renewcommand{\@programme}{#1}}
\newcommand{\@coursecodei}{}
\newcommand{\@coursecodeii}{}
\newcommand{\@coursecodeiii}{}
\newcommand{\@coursecodeiv}{}
\newcommand{\coursecode}[1]{\renewcommand{\@coursecodei}{#1}}
\newcommand{\coursecodei}[1]{\renewcommand{\@coursecodei}{#1}}
\newcommand{\coursecodeii}[1]{\renewcommand{\@coursecodeii}{#1}}
\newcommand{\coursecodeiii}[1]{\renewcommand{\@coursecodeiii}{#1}}
\newcommand{\coursecodeiv}[1]{\renewcommand{\@coursecodeiv}{#1}}
\newcommand{\@academicyear}{XXX-YYYY}
\newcommand{\academicyear}[1]{\renewcommand{\@academicyear}{#1}}
\newcommand{\@titlepagepicture}{}
\newcommand{\titlepagepicture}[1]{\renewcommand{\@titlepagepicture}{#1}}
\newcommand{\@copyrightnotices}{}
\newcommand{\copyrightnotices}[1]{\renewcommand{\@copyrightnotices}{#1}}
\if@twoside
  \lhead[\thepage]{\slshape\rightmark}
  \chead[]{}
  \rhead[\slshape\leftmark]{\thepage}
  \lfoot[Karel de Grote-Hogeschool -- \@departmentacronym]{\@courseversion}
  \cfoot[]{}
  \rfoot[]{\@title{}\if\@subtitle\else{ ---- \@subtitle}\fi}
\else
  \lhead[]{\leftmark}
  \chead[]{}
  \rhead[]{\thepage}
  \lfoot[]{\@courseversion}
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
\newcommand{\@crnotice}{
  This document has been typeset using \LaTeX{} and the
  \texttt{kdgcoursetext} class.\\
  \@copyrightnotices

  \@courseversion

  CONFIDENTIAL AND PROPRIETARY.

  \copyright{} \@versionyear{} Karel de Grote-Hogeschool, All rights reserved.
}
\renewcommand\maketitle{%
  \definecolor{lightlightgray}{cmyk}{0,0,0,0.05}
  \definecolor{kdggroen}{cmyk}{0.29,0,1,0}
  \pagestyle{empty}
  \begin{titlepage}
    \AddToShipoutPicture*{%
      \setlength{\unitlength}{1cm}
      \put(0,0){%
        \begin{tikzpicture}[inner sep=0pt]
          \path
          (19,2.5) node [anchor=south east]{%
            \IfFileExists{\@titlepagepicture}{%
              \includegraphics[width=13.99cm,height=9cm]{\@titlepagepicture}}{}};
          \fill[color=kdggroen] (0,0)
          (2,1.5) -- (2,26.31) -- (19,27.2) -- (19,22.7) --
          (5,22.7) -- (5,2.5) --  (19,2.5) -- (19,1.5) -- cycle;
          \path
          (2,28.2) node[anchor=north west]{\includegraphics[width=8.3cm]{kdg_color}}
          (3,25.8) node[anchor=north west, text width=15cm]{
            {\selectverdanabold\Large \@programme}\\[0.15cm]
            {\selectverdananormal
              \large Departement \@department{}\\[0.13cm]
              \large Academiejaar \@academicyear\\[0.11cm]
              \large \begin{tabular}{@{}p{3cm}p{5.5cm}p{5.5cm}}
                Cursuscode(s): & \@coursecodei{} & \@coursecodeii \\
                & \@coursecodeiii & \@coursecodeiv
              \end{tabular}}
          }
          (6,21.1) node [anchor=north west, text width=13cm]{
            {\selectverdanabold\huge \@title{}}\\[0.2cm]
            {\selectverdananormal
              \Large \@subtitle{}~\\[0.8cm]
              \Large Auteur(s): \@author{}}
          }
          (6,15.4) node [anchor=south west, text width=13cm]{
            \selectverdananormal\large
            \begin{tabular}{@{}p{3cm}p{11cm}}
              Titularis(sen):
              & \@professori \\
              & \@professorii \\
              & \@professoriii \\
              & \@professoriv
            \end{tabular}
            ~\\
            \@versionyear
          }
          (6,12.4) node [anchor=south west, text width=13cm]{%
            \selectverdananormal
            \begin{tabular}{@{}p{12.9cm}}
              \if\@versioncomment\else{Commentaar:  \@versioncomment}\fi
            \end{tabular}
          };
        \end{tikzpicture}
      }
    }%
    \phantom{Do not remove: this causes an empty title page to be generated}
  \end{titlepage}%
  \clearpage
  \if@copyright
  \AddToShipoutPicture{\put(120,180){
      \rotatebox{55}{\color{lightlightgray}{
          \selectverdanabold{}\Huge
          Copyright \@versionyear{} Karel de Grote-Hogeschool}}}}
  \fi
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
    pdfsubject={\@subtitle},
    pdfauthor={\@author}
  }
}
\endinput
%%
%% End of file `kdgcoursetext.cls'.
