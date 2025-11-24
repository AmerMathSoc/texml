%%
%% This is file `gsemthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% gsemthesis.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2014-2015 by Emmanuel Rousseaux <emmanuel.rousseaux@gmail.com>
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, version 1.3c
%% of this license.
%% The latest version of this license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{gsemthesis}
    [2015/02/09 v0.9.4 .dtx gsemthesis file]
\LoadClass[a4paper,12pt,twoside]{book}
\usepackage[utf8]{inputenc}
\usepackage{lmodern}
\usepackage{etoolbox}
\newtoggle{fr}
\DeclareOption{fr}{\toggletrue{fr}}
\newtoggle{draft}
\DeclareOption{draft}{\toggletrue{draft}}
\newtoggle{custombib}
\DeclareOption{custombib}{\toggletrue{custombib}}
\DeclareOption{b5paper}{
  \PassOptionsToClass{\CurrentOption}{book}
}
\ProcessOptions
\RequirePackage[top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm]{geometry}
\usepackage{setspace}
\usepackage{xcolor}
\definecolor{erblue}{HTML}{126199}
\definecolor{erorange}{HTML}{FF7F00}
\definecolor{gsemblue}{HTML}{465F7F}
\usepackage[final]{graphicx}
\usepackage{float}
\usepackage{subfigure}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  filecolor=erblue,
  citecolor=erblue,
  urlcolor=erblue,
  final
}
\RequirePackage{url}
\urlstyle{sf}
\usepackage{amssymb,amsmath,amsfonts}
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\thepage}
\fancyhead[RE]{\nouppercase{\leftmark}}
\fancyhead[LO]{\nouppercase{\rightmark}}
\fancyhead[RO]{\thepage}
\fancyfoot[LE,RO]{}
\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[LE,RO]{}
}
\fancypagestyle{cover}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0.5pt}
  \renewcommand{\footrulewidth}{0.5pt}
}
\fancypagestyle{unnumberedchapter}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhead[LE]{\thepage}
  \fancyhead[RE]{}
  \fancyhead[LO]{}
  \fancyhead[RO]{\thepage}
  \fancyfoot[LE,RO]{}
}
\fancypagestyle{empty}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[LE,RO]{}
}
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}
    \thispagestyle{empty}
    \newpage
    \if@twocolumn\hbox{}\newpage\fi\fi\fi}
\clearpage{\pagestyle{empty}\cleardoublepage}
\iftoggle{fr}{
  \usepackage[francais]{babel}
  \usepackage[T1]{fontenc}
}{
  \usepackage[english]{babel}
}
\usepackage{csquotes}
\usepackage{datetime}
\newdateformat{monthyeardate}{\monthname[\THEMONTH] \THEYEAR}
\iftoggle{custombib}{}{
  \usepackage[backend=biber,natbib=true,style=authoryear-comp,sorting=nymdt,%
  maxbibnames=99,mincitenames=1,maxcitenames=2,uniquelist=false]{biblatex}
}
\iftoggle{custombib}{}{
  \DeclareSortingScheme{nymdt}{
    \sort{
      \field{presort}
    }
    \sort[final]{
      \field{sortkey}
    }
    \sort{
      \name{sortname}
      \name{author}
      \name{editor}
      \name{translator}
      \field{sorttitle}
      \field{title}
    }
    \sort{
      \field{sortyear}
      \field{year}
    }
    \sort{
      \field[padside=left,padwidth=2,padchar=0]{month}
      \literal{00}
    }
    \sort{
      \field[padside=left,padwidth=2,padchar=0]{day}
      \literal{00}
    }
    \sort{
      \field{sorttitle}
    }
    \sort{
      \field[padside=left,padwidth=4,padchar=0]{volume}
      \literal{0000}
    }
  }
}
\def\theFaculty{Geneva School of Economics and Management}

\def\thesisLocationLabel{
  ~ \\[0.4em]%
  \iftoggle{fr}{
    Une thèse soumise à la\\[0.2em]
    \theFaculty\\[0.2em]
    Université de Genève, Suisse,\\[0.2em]
    pour l'obtention du\\[0.2em]
  }{
    A thesis submitted to the\\[0.2em]
    \theFaculty, \\[0.2em]
    University of Geneva, Switzerland,\\[0.2em]
    in fulfillment of the requirements for the degree of\\[0.2em]
  }
}

\iftoggle{fr}{
  \def\thesisByLabel{par}
}{
  \def\thesisByLabel{by}
}
\iftoggle{fr}{
  \def\thesisFieldLabel{Doctorat en}
}{
  \def\thesisFieldLabel{PhD in}
}
\iftoggle{fr}{
  \def\thesisCommitteeLabel{Membres du jury:}
}{
  \def\thesisCommitteeLabel{Members of the thesis committee:}
}
\iftoggle{fr}{
  \def\thesisNumberLabel{Thèse no.}
}{
  \def\thesisNumberLabel{Thesis No.}
}

\def\theauthorFirstname{}
\newcommand{\authorFirstname}[1]{\def\theauthorFirstname{#1}}
\def\theauthorLastname{}
\newcommand{\authorLastname}[1]{\def\theauthorLastname{\textsc{#1}}}
\def\thethesisField{}
\newcommand{\thesisField}[1]{\def\thethesisField{#1}}
\def\thethesisCommitteeA{}
\newcommand{\thesisCommitteeA}[4]{%
\ifx&#3&%
  \def\thethesisCommitteeA{}%
\else
  \def\thethesisCommitteeA{#1~#2~\textsc{#3},~#4}%
\fi
}
\def\thethesisCommitteeB{}
\newcommand{\thesisCommitteeB}[4]{%
\ifx&#3&%
  \def\thethesisCommitteeB{}%
\else
  \def\thethesisCommitteeB{#1~#2~\textsc{#3},~#4}%
\fi
}
\def\thethesisCommitteeC{}
\newcommand{\thesisCommitteeC}[4]{%
\ifx&#3&%
  \def\thethesisCommitteeC{}%
\else
  \def\thethesisCommitteeC{#1~#2~\textsc{#3},~#4}%
\fi
}
\def\thethesisCommitteeD{}
\newcommand{\thesisCommitteeD}[4]{%
\ifx&#3&%
  \def\thethesisCommitteeD{}%
\else
  \def\thethesisCommitteeD{#1~#2~\textsc{#3},~#4}%
\fi
}
\def\thethesisCommitteeE{}
\newcommand{\thesisCommitteeE}[4]{%
\ifx&#3&%
  \def\thethesisCommitteeE{}%
\else
  \def\thethesisCommitteeE{#1~#2~\textsc{#3},~#4}%
\fi
}
\def\thethesisCommitteeF{}
\newcommand{\thesisCommitteeF}[4]{%
\ifx&#3&%
  \def\thethesisCommitteeF{}%
\else
  \def\thethesisCommitteeF{#1~#2~\textsc{#3},~#4}%
\fi
}
\def\thethesisNumber{}
\newcommand{\thesisNumber}[1]{\def\thethesisNumber{#1}}
\newcommand{\printcoverpage}{%
  \thispagestyle{empty}
  \begin{center}
  \rule{\linewidth}{0.4pt}

  \vspace*{1.2cm}

  {\huge
    {\scshape
      \begin{spacing}{0.8}
        \@title
      \end{spacing}
    }
  }

  \vspace*{1.2cm}

  \thesisByLabel

  \vspace*{0.4cm}

  {\large \theauthorFirstname~\theauthorLastname}

  \vspace*{0.8cm}

  \thesisLocationLabel
  \thesisFieldLabel{~}\thethesisField

  \vfill

  \iftoggle{draft}{
    \iftoggle{fr}{
      \emph{Ébauche}
    }{
      \emph{Draft}
    }
  }

  \iftoggle{draft}{~}{
    \vspace*{0.8cm}

    \thesisCommitteeLabel
  }

  \vspace*{0.2em}

  \iftoggle{draft}{~}{\thethesisCommitteeA}

  \vspace*{0.2em}

  \iftoggle{draft}{~}{\thethesisCommitteeB}

  \vspace*{0.2em}

  \iftoggle{draft}{~}{\thethesisCommitteeC}

  \vspace*{0.2em}

  \iftoggle{draft}{~}{\thethesisCommitteeD}

  \vspace*{0.2em}

  \iftoggle{draft}{~}{\thethesisCommitteeE}

  \vspace*{0.2em}

  \iftoggle{draft}{~}{\thethesisCommitteeF}

  \vspace*{1.4cm}

  \iftoggle{draft}{~}{\thesisNumberLabel{~}\thethesisNumber}

  \vspace*{0.1cm}

  \iftoggle{draft}{\@date}{\monthyeardate\today}

  \vspace*{0.1cm}

  \rule{\linewidth}{0.4pt}
  \end{center}
}
\def\theacknowledgements{}
\newcommand{\acknowledgements}[1]{\def\theacknowledgements{#1}}
\def\theabstractEN{}
\newcommand{\abstractEN}[1]{\def\theabstractEN{#1}}
\def\theabstractFR{}
\newcommand{\abstractFR}[1]{\def\theabstractFR{#1}}
\def\thededication{}
\newcommand{\dedication}[1]{\def\thededication{#1}}
\newcommand{\printfrontmatter}{%

  \iftoggle{draft}{~}{
    \frontmatter

    \iftoggle{fr}{
      \chapter*{Remerciements}
      \addcontentsline{toc}{chapter}{Remerciements}
    }{
      \chapter*{Acknowledgements}
      \addcontentsline{toc}{chapter}{Acknowledgements}
    }
    \label{ch:acknowledgements}
    \thispagestyle{plain}
    \theacknowledgements

    \newpage

    \iftoggle{fr}{
      \chapter*{Résumé}
      \addcontentsline{toc}{chapter}{Résumé}
      \label{ch:abstractFR}
      \thispagestyle{plain}
      \theabstractFR

      \newpage

      \chapter*{Abstract}
      \addcontentsline{toc}{chapter}{Abstract}
      \label{ch:abstractEN}
      \thispagestyle{plain}
      \theabstractEN
    }{
      \chapter*{Abstract}
      \addcontentsline{toc}{chapter}{Abstract}
      \label{ch:abstractEN}
      \thispagestyle{plain}
      \theabstractEN

      \newpage

      \chapter*{Résumé}
      \addcontentsline{toc}{chapter}{Résumé}
      \label{ch:abstractFR}
      \thispagestyle{plain}
      \theabstractFR
    }
  }

  \tableofcontents

  \iftoggle{draft}{~}{
    \cleardoublepage

    \thispagestyle{plain}

    \vspace*{4cm}
    {\em
    \raggedleft\thededication\par
    }

    \newpage
  }

  \mainmatter
}%
\newcommand{\startintroduction}{%
\chapter*{Introduction}
\addcontentsline{toc}{chapter}{Introduction}
\label{ch:introduction}
\markboth{}{Introduction}
}
\newcommand{\startconclusion}{%
\chapter*{Conclusion}
\addcontentsline{toc}{chapter}{Conclusion}
\label{ch:conclusion}
\markboth{}{Conclusion}
}
\newenvironment{itemize*}%
  {\vspace{-2mm}\begin{itemize}%
    \setlength{\itemsep}{0pt}%
    \setlength{\parskip}{0pt}%
  }%
  {\end{itemize}\vspace{-2mm}%
  }
\endinput
%%
%% End of file `gsemthesis.cls'.
