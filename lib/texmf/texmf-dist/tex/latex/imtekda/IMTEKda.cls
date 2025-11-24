%%
%% This is file `IMTEKda.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% IMTEKda.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2005-10 by Simon Dreher
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3 of this license or (at your option) any later
%% version. The latest version of this license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of
%% LaTeX version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% The Current Maintainer of this work is Simon Dreher
%% This work consists of all files listed in README.
%% 
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{IMTEKda}
   [2010/01/01 v1.7 IMTEK-Diplomarbeitsvorlage]
\newif\if@nomtotoc\@nomtotocfalse
\newif\if@englishpreamble\@englishpreambletrue
\newif\if@preamblelangdef\@preamblelangdeffalse
\newif\if@germanopt\@germanoptfalse
\newif\if@ngermanopt\@ngermanoptfalse
\DeclareOption{nomtotoc}{\@nomtotoctrue}
\DeclareOption{noenglishpreamble}%
  {\@preamblelangdeftrue\@englishpreamblefalse}
\DeclareOption{englishpreamble}%
  {\@preamblelangdeftrue\@englishpreambletrue}
\DeclareOption{german}%
  {\PassOptionsToClass{\CurrentOption}{scrbook}\@germanopttrue}
\DeclareOption{ngerman}%
  {\PassOptionsToClass{\CurrentOption}{scrbook}\@ngermanopttrue}
\newif\if@diplom\@diplomtrue
\newif\if@bachelor\@bachelorfalse
\newif\if@master\@masterfalse
\newif\ifh@snothesistype\h@snothesistypetrue
\DeclareOption{diplom}%
  {\@diplomtrue\@bachelorfalse\@masterfalse\h@snothesistypefalse}
\DeclareOption{bachelor}%
  {\@diplomfalse\@bachelortrue\@masterfalse\h@snothesistypefalse}
\DeclareOption{master}%
  {\@diplomfalse\@bachelorfalse\@mastertrue\h@snothesistypefalse}
\newif\if@oldcd\@oldcdfalse
\DeclareOption{oldcd}%
  {\@oldcdtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\ifh@snothesistype
  \@latex@warning@no@line{%
    Eine der Optionen diplom, bachelor oder master
    \MessageBreak muss angegeben werden. Nehme diplom.%
  }%
\fi
\LoadClass[a4paper,pagesize]{scrbook}
\AtBeginDocument{\RequirePackage{graphicx}}
\RequirePackage{calc}
\RequirePackage[absolute]{textpos}
\def\nomname{Nomenclature}
\AfterPackage*{babel}{
\iflanguage{german}{\@englishpreamblefalse}%
  {\if@preamblelangdef\else\@englishpreambletrue\fi}
    \addto{\captionsgerman}{\renewcommand*{\figurename}{Abb.}}
    \addto{\captionsgerman}{\renewcommand*{\tablename}{Tab.}}
    \addto{\captionsgerman}{\def\nomname{Nomenklatur}}
\iflanguage{ngerman}{\@englishpreamblefalse}%
  {\if@preamblelangdef\else\@englishpreambletrue\fi}
    \addto{\captionsngerman}{\renewcommand*{\figurename}{Abb.}}
    \addto{\captionsngerman}{\renewcommand*{\tablename}{Tab.}}
    \addto{\captionsngerman}{\def\nomname{Nomenklatur}}
}
\AfterPackage*{german}{
    \@englishpreamblefalse\@germanopttrue
    \renewcommand*{\figurename}{Abb.}
    \renewcommand*{\tablename}{Tab.}
    \newcommand*{\captionsgermansav}{}
    \let\captionsgermansav\captionsgerman
    \renewcommand*{\captionsgerman}%
        {\captionsgermansav\def\figurename{Abb.}%
        \def\tablename{Tab.}\def\nomname{Nomenklatur}}
}
\AfterPackage*{ngerman}{
    \@englishpreamblefalse\@ngermanopttrue
    \renewcommand*{\figurename}{Abb.}
    \renewcommand*{\tablename}{Tab.}
    \newcommand*{\captionsngermansav}{}
    \let\captionsngermansav\captionsngerman
    \renewcommand*{\captionsngerman}%
        {\captionsngermansav\def\figurename{Abb.}%
        \def\tablename{Tab.}\def\nomname{Nomenklatur}}
}
\newif\ifh@stitlepic\h@stitlepicfalse
\def\titlepic#1{\gdef\@titlepic{#1}\h@stitlepictrue}
\newif\ifh@stitlepicdesc\h@stitlepicdescfalse
\def\titlepicdesc#1{\gdef\@titlepicdesc{#1}\h@stitlepicdesctrue}
\def\dpoversion#1{\gdef\@dpoversion{#1}}
\def\@dpoversion{\@latex@error{No \noexpand\dpoversion given}\@ehc}
\def\chair#1{\gdef\@chair{#1}}
\def\@chair{\@latex@error{No \noexpand\chair given}\@ehc}
\def\referees#1{\gdef\@referees{#1}}
\def\@referees{\@latex@error{No \noexpand\referees given}\@ehc}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\@supervisor{\@latex@error{No \noexpand\supervisor given}\@ehc}
\def\thesistime#1{\gdef\@thesistime{#1}}
\def\@thesistime{\@latex@error{No \noexpand\thesistime given}\@ehc}
\newenvironment{abstract}{\addchap*{\abstractname}}{}
\newenvironment{nomenclature}{%
  \if@nomtotoc
    \addchap{\nomname}
    \@mkboth{\nomname}{\nomname}
  \else
    \if@hyperref
        \if@openright\cleardoublepage\else\clearpage\fi
        \phantomsection\pdfbookmark{\nomname}{nom}%
    \fi
    \chapter*{\nomname}
    \@mkboth{\nomname}{\nomname}
  \fi
}{%
}
\newcommand{\LLogo}{\parbox[b][2.2cm]{0.3\textwidth}{%
  \texttt{figures/IMTEK\_Logo\_Farbe.*}
  von \texttt{http://intern.imtek.de} downloaden}}
\newcommand{\RLogo}{\parbox[b][2.2cm]{0.3\textwidth}{%
  \texttt{figures/Uni\_Siegel.*}
  von \texttt{http://intern.imtek.de} downloaden}}
\newcommand{\BLogo}{\parbox[b][2.2cm]{7.5cm}{%
  \texttt{figures/Uni\_Logo\_E2\_A4\_CMYK.*}
  von \texttt{http://www.uni-freiburg.de/go/cd} downloaden}}
\newcommand{\l@g@error}{%
  \ClassError{IMTEKda}{Logo file(s) not found}
    {One or more of the files\MessageBreak
    \space\space\space\space figures/IMTEK_Logo_Farbe.eps \MessageBreak
    \space\space\space\space figures/IMTEK_Logo_Farbe.pdf \MessageBreak
    \space\space\space\space figures/Uni_Siegel.eps \MessageBreak
    \space\space\space\space figures/Uni_Siegel.pdf \MessageBreak
    \space\space\space\space figures/Uni_Logo_E2_A4_CMYK.eps \MessageBreak
    \space\space\space\space figures/Uni_Logo_E2_A4_CMYK.pdf \MessageBreak
    are not installed properly. \MessageBreak
    Install this subdirectory with the logo files \MessageBreak
    together with the class file, see README.\MessageBreak
    Type <return> to proceed without the logos.}
  }
\IfFileExists{figures/IMTEK_Logo_Farbe.eps}%
  {\IfFileExists{figures/IMTEK_Logo_Farbe.pdf}%
    {\renewcommand{\LLogo}%
      {\includegraphics[height=2.2cm]{figures/IMTEK_Logo_Farbe}}}%
    {\l@g@error}%
  }{\l@g@error}
\if@oldcd
  \IfFileExists{figures/Uni_Siegel.eps}%
    {\IfFileExists{figures/Uni_Siegel.pdf}%
      {\renewcommand{\RLogo}%
        {\includegraphics[height=2.2cm]{figures/Uni_Siegel}}}%
      {\l@g@error}%
    }{\l@g@error}
  \renewcommand{\BLogo}{\null}%
\else
  \IfFileExists{figures/Uni_Logo_E2_A4_CMYK.eps}%
    {\IfFileExists{figures/Uni_Logo_E2_A4_CMYK.pdf}%
      {\renewcommand{\BLogo}%
        {\includegraphics{figures/Uni_Logo_E2_A4_CMYK}}}%
      {\l@g@error}%
    }{\l@g@error}
  \renewcommand{\RLogo}{\null}%
\fi
\titlehead{\LLogo\hfill\RLogo}
\def\s@bject{%
  \if@diplom\if@englishpreamble{Diploma Thesis}\else{Diplomarbeit}\fi%
  \else%
    \if@bachelor\if@englishpreamble{Bachelor's Thesis}\else{Bachelorarbeit}\fi%
    \else
    \if@englishpreamble{Master's Thesis}\else{Masterarbeit}\fi%
    \fi
  \fi}
\subject{\titlefont{\s@bject}}
\date{}
  \renewcommand*\maketitle[1][1]{\begin{titlepage}%
    \begin{textblock*}{0pt}[0,1](\paperwidth-17pt, \paperheight-36pt)
      \llap{\BLogo}
    \end{textblock*}
    \enlargethispage{2cm}
    \setcounter{page}{#1}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let\footnote\thanks
    \renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
    \let\@oldmakefnmark\@makefnmark
    \renewcommand*{\@makefnmark}{\rlap\@oldmakefnmark}
    \ifx\@titlehead\@empty \else
        \noindent\begin{minipage}[t]{\textwidth}
        \@titlehead
        \end{minipage}\par
    \fi
    \null\vfill
    \begin{center}
    \ifx\@subject\@empty \else
        {\Large \@subject \par}
        \vskip 3em
    \fi
    {\titlefont\huge \@title\par}
    \vskip 3em
    \ifh@stitlepic
        \ifh@stitlepicdesc\relax\else
            \@latex@error{No \noexpand\titlepicdesc given}\@ehc
        \fi
        \@titlepic\par
        \vskip 3em
    \fi
    {\Large \lineskip 0.75em
    \begin{tabular}[t]{c}
        \@author
    \end{tabular}\par}
    \vskip 1.5em
    {\Large \@date \par}
    \vskip \z@ \@plus3fill
    {\Large \@publishers \par}
    \vskip 3em
    \end{center}\par
    \@thanks
    \vfill\null
    \if@twoside\next@tpage
        \noindent\begin{minipage}[t]{\textwidth}
        \@uppertitleback
        \end{minipage}\par
        \vfill
        \noindent\begin{minipage}[b]{\textwidth}
        \@lowertitleback
        \end{minipage}
    \fi
    \clearpage\thispagestyle{empty}
    \noindent%
    \if@englishpreamble
      \noindent
      \begin{tabular}[t]{p{0.24\textwidth}p{0.76\textwidth-4\tabcolsep}}
      &A \if@diplom{diploma}%
      \else{\if@bachelor{bachelor's}\else{master's}\fi}\fi{}
      thesis submitted in partial fulfillment of the
      requirements for the degree of
      \\[1em]
      &\if@diplom{Graduate Engineer of Microsystems Engineering}\else
      {\if@bachelor{Bachelor of Science of Microsystems Engineering}\else
      Master of Science of Microsystems Engineering\fi}\fi
      \\[1em]
      &according to the examination regulations
      at the University of Freiburg for the
      \if@diplom{Diploma}\else{\if@bachelor{Bachelor's degree}%
      \else{Master's degree}\fi}\fi{}
      in Microsystems Engineering of \@dpoversion{}.\\[1em]
      &\@chair\\
      &Department of Microsystems Engineering (IMTEK)\\
      &University of Freiburg\\
      &Freiburg im Breisgau, Germany
      \end{tabular}
      \vfil
      \noindent
      \begin{tabular}[t]{p{0.24\textwidth}p{0.76\textwidth-4\tabcolsep}}
      \bfseries Author&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@author\end{minipage}
      \end{tabular}
      \vfil
      \noindent
      \begin{tabular}[t]{p{0.24\linewidth}p{0.76\textwidth-4\tabcolsep}}
      \bfseries Thesis period&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@thesistime\end{minipage}\\&\\
      \bfseries Referees&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@referees\end{minipage}\\&\\
      \bfseries Supervisor&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@supervisor\end{minipage}\\
      \end{tabular}
      \ifh@stitlepicdesc
        \vfil
        \noindent
        \begin{tabular}[t]{p{0.24\linewidth}p{0.76\textwidth-4\tabcolsep}}
        \bfseries Title page&
          \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
    \@titlepicdesc\end{minipage}
        \end{tabular}
      \fi
      \clearpage\thispagestyle{empty}
      \null\vfill
      \noindent
      \begin{tabular}[t]{p{0.24\linewidth}p{0.76\textwidth-4\tabcolsep}}
        \bfseries\large Declaration&according to
        \if@diplom\S9(5) of the\else\if@bachelor\S22(8) of the\else{the}\fi\fi{}
        Examination Regulations:\\[1em]
        &I hereby confirm to have written the following thesis on my own,
        not having used any other sources or resources than those listed.
        All passages taken over literally or correspondingly from published
        sources have been marked accordingly. Additionally, this thesis has not
        been prepared or submitted for another examination, neither partially
        nor completely.
        \\[1em]
        &Freiburg, \today\\[2cm]
        &\begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@author\end{minipage}
      \end{tabular}
    \else
      {\if@ngermanopt\selectlanguage{ngerman}%
        \else\if@germanopt\selectlanguage{german}%
        \fi%
      \fi%
      \noindent%
      \begin{tabular}[t]{p{0.24\textwidth}p{0.76\textwidth-4\tabcolsep}}
      &Eingereichte \if@diplom{Diplomarbeit}\else{\if@bachelor{Bachelorarbeit}%
      \else{Masterarbeit}\fi}\fi{} gem\"a\ss{} den Bestimmungen der
      Pr\"ufungsordnung
      der Universit\"at Freiburg f\"ur den
      \if@diplom{Diplomstudiengang}\else{\if@bachelor{Bachelorstudiengang}%
      \else{Masterstudiengang}\fi}\fi{}
      Mikrosystemtechnik vom \@dpoversion\\[1em]
      &\@chair\\
      &Institut f\"ur Mikrosystemtechnik (IMTEK)\\
      &Albert-Ludwigs-Universit\"at Freiburg\\
      &Freiburg im Breisgau
      \end{tabular}
      \vfil
      \noindent
      \begin{tabular}[t]{p{0.24\linewidth}p{0.76\textwidth-4\tabcolsep}}
      \bfseries Autor&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@author\end{minipage}
      \end{tabular}
      \vfil
      \noindent
      \begin{tabular}[t]{p{0.24\linewidth}p{0.76\textwidth-4\tabcolsep}}
      \bfseries Bearbeitungszeit&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@thesistime\end{minipage}\\&\\
      \bfseries Gutachter&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@referees\end{minipage}\\&\\
      \bfseries Betreuer&
        \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
  \@supervisor\end{minipage}\\
      \end{tabular}
      \ifh@stitlepicdesc
        \vfil
        \noindent
        \begin{tabular}[t]{p{0.24\textwidth}p{0.76\textwidth-4\tabcolsep}}
        \bfseries Titelseite&
          \begin{minipage}[t]{0.76\textwidth-4\tabcolsep}%
    \@titlepicdesc\end{minipage}
        \end{tabular}
      \fi
      \clearpage\thispagestyle{empty}
      \null\vfill
      \noindent
      \begin{tabular}[t]{p{0.24\textwidth}p{0.76\textwidth-4\tabcolsep}}
        \bfseries\large Erkl\"arung&nach
        \if@diplom\S9(5) der Diplompr\"ufungsordnung\else
        {\if@bachelor\S22(8) der Pr\"ufungsordnung%
        \else der Pr\"ufungsordnung\fi}\fi{}:\\[1em]
        &Hiermit erkl\"are ich, dass ich diese Abschlussarbeit
        selbst\"andig verfasst habe, keine anderen als die
        angegebenen Quellen und Hilfsmittel benutzt habe und alle Stellen,
        die w\"ortlich oder sinngem\"a\ss\ aus ver\"offentlichten Schriften
        entnommen wurden, als solche kenntlich gemacht habe. Dar\"uberhinaus
        erkl\"are ich, dass diese Abschlussarbeit nicht, auch nicht
        auszugsweise, bereits f\"ur eine andere Pr\"ufung angefertigt
        wurde.\\[1em]
        &Freiburg, den \today\\[2cm]
        &\begin{minipage}[t]{0.76\textwidth-4\tabcolsep}
  \@author\end{minipage}
      \end{tabular}%
      }
    \fi
    \ifx\@dedication\@empty \else
        \next@tpage\null\vfill
        {\centering \Large \@dedication \par}
        \vskip \z@ \@plus3fill
        \if@twoside \next@tpage\cleardoublepage \fi
    \fi
    \end{titlepage}
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\@titlehead\@empty
    \global\let\@subject\@empty
    \global\let\@publishers\@empty
    \global\let\@uppertitleback\@empty
    \global\let\@lowertitleback\@empty
    \global\let\@dedication\@empty
    \global\let\author\relax
    \global\let\title\relax
    \global\let\extratitle\relax
    \global\let\titlehead\relax
    \global\let\subject\relax
    \global\let\publishers\relax
    \global\let\uppertitleback\relax
    \global\let\lowertitleback\relax
    \global\let\dedication\relax
    \global\let\date\relax
    \global\let\and\relax}
\newif\if@hyperref\@hyperreffalse
\AfterPackage*{hyperref}{%
    \@hyperreftrue
    \newcommand{\org@maketitle}{}%
    \let\org@maketitle\maketitle
    \def\maketitle{%
      \hypersetup{
        pdftitle={\@title},
        pdfauthor={\@author},
        pdfsubject={\s@bject}
        }%
      \org@maketitle
    }
}
\endinput
%%
%% End of file `IMTEKda.cls'.
