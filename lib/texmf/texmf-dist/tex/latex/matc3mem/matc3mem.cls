%%
%% This is file `matc3mem.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% matc3mem.dtx  (with options: `class')
%% 
%% Copyright (C) 2013 by Dimitrios Vrettos - d.vrettos@gmail.com
%% 
%% This file may be distriubuted and/or modified under the
%% conditions of the LaTeX Project Public Licence, either
%% version 1.3c of this licence or (at your option) any later
%% version. The latest version of this licence is in:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3c  or later is part of all distriubutions of
%% LaTeX version 2008/05/04 or later.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{matc3mem}
    [2014/04/10 v1.1 Classe per il libri di MatematicaC3]
\LoadClassWithOptions{memoir}[2011/03/06]
\RequirePackage{amsthm}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{shadethm}
\newcommand{\mcpar}[1]{%
\paragraph*{%
\small\normalfont\scshape{#1}%
}%
}
\newcommand{\spazielen}{%
  \setlength{\itemsep}{0pt}%
  \setlength{\parskip}{0pt}%
}
\newcommand{\spazielenx}{%
  \setlength{\itemsep}{0pt}%
  \setlength{\parskip}{5pt}%
}
\renewcommand{\labelitemi}{%
  \textcolor{Salmon}{\ding{225}}%
}
\renewcommand{\labelitemii}{%
  \textcolor{Salmon}{\ding{224}}%
}
\renewcommand{\labelitemiii}{%
  \textcolor{Salmon}{\ding{223}}%
}
\newenvironment{description*}{%
  \begin{description}
    \spazielen}%
  {\end{description}%
}
\renewcommand{\descriptionlabel}[1]{%
  \labelwidth=3cm\hspace{%
\labelsep}\emph{#1}%
}
\newenvironment{enumeratea}{%
  \begin{enumerate}[label=\alph*\,)]%
    \spazielen}{%
  \end{enumerate}%
}
\newenvironment{enumerate*}{%
  \begin{enumerate}%
    \spazielen}{%
  \end{enumerate}%
}
\newenvironment{itemize*}{%
  \begin{itemize}
    \spazielen}{%
  \end{itemize}%
}
\newenvironment{exrig}{%
  \vskip2mm\hrule\vskip2mm}{%
  \hrule\vskip2mm}
\theoremstyle{definition}
\newshadetheorem{definizione}{Definizione}[chapter]
\newshadetheorem{criterio}[definizione]{Criterio}
\newshadetheorem{sesempio}{Esempio}[chapter]
\newtheorem{esempio}[sesempio]{\color{Sepia}Esempio}
\newtheorem{problema}[sesempio]{\color{Sepia}Problema}
\newtheorem{esercizio}{\color{Sepia}}[chapter]
\theoremstyle{plain}
\newcommand{\thmcolor}{%
  \definecolor{shadethmcolor}{gray}{1}%
  \definecolor{shaderulecolor}{gray}{0.95}%
}
\newshadetheorem{teorema}{\thmcolor{Teorema}}[chapter]
\newshadetheorem{legge}[teorema]{Legge}
\newshadetheorem{postulato}[teorema]{Postulato}
\newshadetheorem{principio}[teorema]{Principio}
\newshadetheorem{procedura}[teorema]{Procedura}
\newshadetheorem{proposizione}[teorema]{Proposzione}
\newshadetheorem{proprieta}[teorema]{Propriet\`a}
\newenvironment{soluzione}[1][Soluzione]%
 {\begin{trivlist}%
   \item[\hskip \labelsep {\itshape #1}]%
 }
 {\end{trivlist}%
   {\flushright{\color{Sepia}$\blacklozenge$}\par}%
 }
\newcommand{\diagramname}{Grafico}
\newcommand{\listdiagramname}{Elenco dei grafici}
\newlistof{listofdiagrams}{dgm}{\listdiagramname}
\newfloat[chapter]{grafico}{dgm}{Grafico}
\newlistentry{grafico}{dgm}{0}
\newcommand*{\frntspz}{%
  \begingroup\newlength{\drop}
  \drop=0.15\textheight
  \vspace{\drop}
  \centering
    \fontsize{16pt}{0in}%
    \selectfont\MakeUppercase\serie\\[0.5\drop]
    \fontsize{26pt}{0pt}%
    \selectfont\MakeUppercase\titolo\par
  \vspace{\drop}
    {\LARGE\descr}\par
  \vspace{2.5\drop}
    \large\editore
  \vskip2mm
    \large\Edizione\ - \anno\par
  \vspace{\drop}
  \endgroup}
\renewcommand{\printpartname}{}
\newcommand{\numeroparte}{\partnumfont \thepart}
\renewcommand{\printpartnum}{}
\renewcommand{\partnamenum}{}
\renewcommand{\beforepartskip}{\vspace*{0.1in}}
\renewcommand{\midpartskip}{}
\renewcommand{\afterpartskip}{\vspace{1in}}
\renewcommand\parttitlefont{%
  \Huge\fontseries{b}\fontfamily{phv}%
  \selectfont\raggedleft%
}
\renewcommand\partnumfont{%
  \fontseries{b}\fontsize{.9in}{0in}%
  \selectfont\color{BrickRed}%
}
\renewcommand{\@setuppart}{%
  \beforepartskip}
\renewcommand{\@endpart}{%
  \afterpartskip}
\renewcommand{\printparttitle}[1]{%
  \thispagestyle{empty}%
    \noindent
    \begin{tabularx}{\textwidth}{Xr}
     {\parbox[b]{\linewidth}{\parttitlefont #1}}%
      & \raisebox{-15pt}{\numeroparte} \\%
    \end{tabularx}
}
\newif\ifchapternonum
  \makechapterstyle{matc3chap}{%
    \renewcommand\printchaptername{}
    \renewcommand\printchapternum{}
    \renewcommand{\beforechapskip}{-25pt}
    \renewcommand\printchapternonum{\chapternonumtrue}
    \renewcommand\chaptitlefont{%
      \huge\fontseries{b}\fontfamily{phv}\selectfont\raggedleft%
    }
    \renewcommand\chapnumfont{%
      \fontseries{b}\fontsize{.9in}{0in}%
      \selectfont\raggedright\color{Mahogany}%
    }
    \renewcommand\printchaptertitle[1]{%
      \noindent%
      \ifchapternonum%
\begin{tabularx}{\textwidth}{X}%
  {\parbox[b]{\linewidth}{\chaptitlefont ##1}%
  \vphantom{\raisebox{15pt}{\chapnumfont 1}}}
\end{tabularx}%
      \else
\begin{tabularx}{\textwidth}{Xl}
  {\parbox[b]{\linewidth}{\chaptitlefont ##1}}%
  & \raisebox{-15pt}{ \chapnumfont  \thechapter}%
\end{tabularx}%
      \fi
     \par\vskip2mm%\hrule
  }
}
\chapterstyle{matc3chap}
\setsecheadstyle{%
  \Large\fontfamily{phv}\fontseries{b}\selectfont\raggedright%
}
\setsubsecheadstyle{%
  \fontfamily{phv}\fontseries{b}\selectfont\raggedright%
}
\setsubsubsecheadstyle{%
  \fontfamily{phv}\fontseries{b}\selectfont\raggedright%
}
\makepagestyle{matc3page}
\makeevenhead{matc3page}{\thepage}{}{\slshape\leftmark}
\makeoddhead{matc3page}{\slshape\rightmark}{}{\thepage}
\newcommand{\headcap}{%
  {\color{Mahogany}\chaptername\ \thechapter. }%
}
\newcommand{\headsec}{%
  {\color{Mahogany}Sezione~\thesection. }%
}
\makepsmarks{matc3page}{%
  \def\chaptermark##1{\markboth{%
        \ifnum \value{secnumdepth} > -1
          \if@mainmatter
           \headcap   %
          \fi
        \fi
        ##1}{}%
  }
  \def\sectionmark##1{\markright{%
        \ifnum \value{secnumdepth} > 0
          \headsec \ %
        \fi
        ##1}%
  }
}
\endinput
%%
%% End of file `matc3mem.cls'.
