% This is the ndsu-thesis document class. It is used to produce disquisitions
% for submission to the NDSU Graduate School.
% Copyright 2016, Aaron Feickert and Jonathan Totushek

% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public Licenese, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%  http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.

% This work has the LPPL maintenance status `maintained'.

% The current maintainer of this work is Aaron Feickert.
% Contact aaron.feickert@ndsu.edu for bug reports.

% Here is a history of changes:
%   2015-02-24: original release
%   2015-04-28: fixed a list header problem
%   2015-05-04: made entries in lot and lof single spaced, added cochaira and cochairb options and made cchair optional
%   2015-05-11: fixed spacing issue in lof and lot
%   2015-05-11: changed colons to periods in caption titles
%   2015-07-29: fixed spacing issue in the approval page
%   2016-02-02: fixed appendix equation numbering
%   2016-04-15: changed spacing in lists of appendix figures and tables

\ProvidesClass{ndsu-thesis}
\DeclareOption{draft}{\PassOptionsToClass{draft}{book}}
\ProcessOptions\relax
\LoadClass[11pt,oneside,notitlepage]{book}
\usepackage[utf8]{inputenc}
\usepackage[linktocpage,breaklinks,linktoc=all,hidelinks]{hyperref}
\usepackage[top=1in,bottom=1in,left=1in,right=1in,letterpaper]{geometry}
\usepackage[doublespacing]{setspace}
\usepackage{titling}
\usepackage{ifthen}
\usepackage{titlesec}
\usepackage{indentfirst}
\usepackage[titles]{tocloft}
\usepackage{etoolbox}
\usepackage[figure,table]{totalcount}
\usepackage[nottoc]{tocbibind}
\usepackage[within=chapter]{newfloat}
\usepackage[labelsep=period]{caption}
\usepackage{comment}
\usepackage{tikz}
\usetikzlibrary{matrix,arrows,decorations.pathmorphing}

% Basic spacing
\setlength{\parindent}{.5in}
\setcounter{secnumdepth}{5}
\setlength{\intextsep}{\baselineskip}

% Degree options
\newcommand{\thesistype}{phd}
\DeclareOption{phd}{\renewcommand{\thesistype}{phd}}
\DeclareOption{ms-thesis}{\renewcommand{\thesistype}{ms-thesis}}
\DeclareOption{ms-paper}{\renewcommand{\thesistype}{ms-paper}}
\DeclareOption{ma-thesis}{\renewcommand{\thesistype}{ma-thesis}}
\DeclareOption{ma-paper}{\renewcommand{\thesistype}{ma-paper}}
\ProcessOptions

% Table of contents tweaks
\renewcommand{\contentsname}{TABLE OF CONTENTS}
\renewcommand{\listtablename}{LIST OF TABLES}
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftfigaftersnum}{.}
\renewcommand{\cfttabaftersnum}{.}
\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\cftsubsecaftersnum}{.}
\setlength{\cftbeforesecskip}{0.5\baselineskip}
\setlength{\cftbeforesubsecskip}{0.5\baselineskip}
\setlength{\cftbeforetabskip}{0.5\baselineskip}
\setlength{\cftbeforefigskip}{0.5\baselineskip}
\setlength{\cftfigindent}{0em}
\setlength{\cfttabindent}{0em}
\renewcommand{\bibname}{REFERENCES}
\DeclareTotalCounter{appendixfigure}
\DeclareTotalCounter{appendixtable}
\DeclareFloatingEnvironment[fileext=loaf,placement={ht},listname={LIST OF APPENDIX FIGURES},name=Figure]{appendixfigure}
\DeclareFloatingEnvironment[fileext=loat,placement={ht},listname={LIST OF APPENDIX TABLES},name=Table]{appendixtable}

% Fix table captions
\captionsetup[table]{position=top,skip=\baselineskip}
\captionsetup[appendixtable]{position=top,skip=\baselineskip}

% Defines custom paper information
\newcommand\papertype[1]{\def\@papertype{#1}}
\let\@papertype=\@empty
\ifthenelse{\equal{\thesistype}{phd}}{\papertype{Dissertation}}{
\ifthenelse{\equal{\thesistype}{ms-thesis}}{\papertype{Thesis}}{
\ifthenelse{\equal{\thesistype}{ms-paper}}{\papertype{Paper}}{
\ifthenelse{\equal{\thesistype}{ma-thesis}}{\papertype{Thesis}}{
\ifthenelse{\equal{\thesistype}{ma-paper}}{\papertype{Paper}}}}}}{}

\newcommand\degree[1]{\def\@degree{#1}}
\let\@degree=\@empty
\ifthenelse{\equal{\thesistype}{phd}}{\degree{DOCTOR OF PHILOSOPHY}}{
\ifthenelse{\equal{\thesistype}{ms-thesis}}{\degree{MASTER OF SCIENCE}}{
\ifthenelse{\equal{\thesistype}{ms-paper}}{\degree{MASTER OF SCIENCE}}{
\ifthenelse{\equal{\thesistype}{ma-thesis}}{\degree{MASTER OF ARTS}}{
\ifthenelse{\equal{\thesistype}{ma-paper}}{\degree{MASTER OF ARTS}}}}}}{}

\newcommand\abstract[1]{\def\@abstract{#1}}
\let\@abstract=\@empty

\newcommand\department[1]{\def\@department{#1}}
\let\@department=\@empty

\newcommand\degreeoption[1]{\def\@degreeoption{Option:\\#1}}
\let\@degreeoption=\@empty

\newcommand\approvaldate[1]{\def\@approvaldate{#1}}
\let\@approvaldate=\@empty

\newcommand\approver[1]{\def\@approver{#1}}
\let\@approver=\@empty

\renewcommand\abstract[1]{\def\@abstract{#1}}
\let\@abstract=\@empty

\renewcommand\title[1]{\def\@title{\uppercase{#1}}}
\let\@title=\@empty

% Committee information
\newcommand\cchair[1]{\def\@cchair{#1\vspace{.05in}\hrule\vspace{.05in}
	{\tiny Chair}\\}\vspace{.2 in}}
\let\@cchair=\@empty
\newcommand\cochaira[1]{\def\@cochaira{#1\vspace{.05in}\hrule\vspace{.05in}
	{\tiny Co-Chair}\\}\vspace{.2 in}}
\let\@cochaira=\@empty
\newcommand\cochairb[1]{\def\@cochairb{#1\vspace{.05in}\hrule\vspace{.05in}
	{\tiny Co-Chair}\\}\vspace{.2 in}}
\let\@cochairb=\@empty
\newcommand\cmembera[1]{\def\@cmembera{#1\vspace{.05in}
      \hrule\vspace{.2in}}}
\let\@cmembera=\@empty
\newcommand\cmemberb[1]{\def\@cmemberb{#1\vspace{.05in}
      \hrule\vspace{.2in}}}
\let\@cmemberb=\@empty
\newcommand\cmemberc[1]{\def\@cmemberc{#1\vspace{.05in}
      \hrule\vspace{.2in}}}
\let\@cmemberc=\@empty
\newcommand\cmemberd[1]{\def\@cmemberd{#1\vspace{.05in}
      \hrule\vspace{.2in}}}
\let\@cmemberd=\@empty

% Other frontmatter sections
\newcommand\acknowledgements[1]{\def\@acknowledgements{\clearpage\chapter*{ACKNOWLEDGEMENTS}\addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}#1}}
\let\@acknowledgements=\@empty

\newcommand\dedication[1]{\def\@dedication{\clearpage\chapter*{DEDICATION}\addcontentsline{toc}{chapter}{DEDICATION}\begin{center}#1\end{center}}}
\let\@dedication=\@empty

\newcommand\preface[1]{\def\@preface{\clearpage\chapter*{PREFACE}\addcontentsline{toc}{chapter}{PREFACE}#1}}
\let\@preface=\@empty

% Title page
\setlength{\droptitle}{-1in}
\pretitle{\doublespacing \vfill \begin{center}}
\posttitle{\vfill \singlespacing A \@papertype \\ Submitted to the Graduate Faculty \\ of the \\ North Dakota State University \\ of Agriculture and Applied Science \end{center}}
\preauthor{\vfill \begin{center} By \\}
\postauthor{\vfill \singlespacing In Partial Fulfillment of the Requirements \\ for the Degree of \\ \@degree \vfill Major Department:\\ \@department \end{center}}
\predate{\vfill \begin{center}}
\postdate{\vfill Fargo, North Dakota \end{center}}

% These control the frontmatter sections
\newcommand{\makeapproval}{
\clearpage
\thispagestyle{empty}
\doublespacing
\vfill
\begingroup
    \centering {\Large \textbf{NORTH DAKOTA STATE UNIVERSITY}} \\
    {\large Graduate School} \\
    \vspace{.1in}
    \hrule height 1pt
    \begin{center}
    \parbox{5.5in}{
        \begin{center}
        \textbf{Title} \\
        \@title
        \vspace{.2in}
        \hrule
        \vspace{.2in}
        \textbf{By} \\
        \@author
        \vspace{.2in}
        \hrule
        \end{center}
    }
    \end{center}
\endgroup
\vfill
%\vspace{\baselineskip}
\noindent The supervisory committee certifies that this \MakeLowercase{\@papertype} complies with North Dakota State University's regulations and meets the accepted standards for the degree of\\
\begin{center}
\@degree
\vfill
\parbox{5.5in}{
    \hspace{-0.5in}SUPERVISORY COMMITTEE: \\
    \@cchair
    \@cochaira
    \@cochairb
    \@cmembera
    \@cmemberb
    \@cmemberc
    \@cmemberd
}
\parbox{5.5in}{
    \hspace{-0.5in}\noindent Approved: \\
    \noindent \parbox{1.5in}{\centering\@approvaldate\vspace{.05in}\hrule\vspace{.05in}{\tiny Date}} \hfill
    \parbox{3in}{\centering\@approver\vspace{.05in}\hrule\vspace{.05in}{\tiny Department Chair}}
}
\end{center}
}

\newcommand{\makeabstract}{
\chapter*{Abstract} \@abstract
\addcontentsline{toc}{chapter}{ABSTRACT}
}

\AtBeginDocument{\frontmatter \maketitle\thispagestyle{empty} \makeapproval \makeabstract \@acknowledgements \@dedication \@preface
\begin{singlespace}\tableofcontents\end{singlespace}
\iftotaltables
\begingroup
	\renewcommand*{\addvspace}[1]{}
	\begin{singlespace}\listoftables\end{singlespace}
\endgroup
\fi
\iftotalfigures
\begingroup
	\renewcommand*{\addvspace}[1]{}
	\begin{singlespace}\listoffigures\end{singlespace}
\endgroup
\fi
\iftotalappendixtables\begin{singlespace}\listofappendixtables\end{singlespace}\fi
\iftotalappendixfigures\begin{singlespace}\listofappendixfigures\end{singlespace}\fi
\mainmatter}

\pagestyle{plain}
\addtocontents{lot}{\noindent\underline{Table}\hfill \underline{Page}\par}
\addtocontents{lof}{\noindent\underline{Figure}\hfill \underline{Page}\par}
\addtocontents{loat}{\noindent\underline{Table}\hfill \underline{Page}\par}
\addtocontents{loaf}{\noindent\underline{Figure}\hfill \underline{Page}\par}

% Labels chapters correctly
\renewcommand{\chaptername}{}
\newcommand{\heading}[1]{\chapter{\uppercase{#1}}}

% Format headings correctly
\titleformat{\chapter}
    {\centering\normalfont\bfseries}{{\Large\MakeUppercase{{\chaptertitlename}}\ \thechapter.}}{1em}{\Large\MakeUppercase}
    \titlespacing*{\chapter}{0pt}{-0.5\baselineskip}{\baselineskip}

\titleformat{\section}
    {\normalfont\bfseries}{\thesection.}{0.5em}{}
    \titlespacing*{\section}{0pt}{*0}{0pt}
    
\titleformat{\subsection}
    {\normalfont\bfseries}{\thesubsection.}{0.5em}{}
    \titlespacing*{\subsection}{0pt}{*0}{0pt}

\titleformat{\subsubsection}
    {\normalfont\bfseries}{\thesubsubsection.}{0.5em}{}
    \titlespacing*{\subsubsection}{0pt}{*0}{0pt}

% Generate appendices with the correct numbering
\renewcommand{\appendix}{
    \chapter*{APPENDIX}
    \setcounter{appendixfigure}{0}
    \renewcommand{\theappendixfigure}{A.\arabic{appendixfigure}}
    \setcounter{appendixtable}{0}
    \renewcommand{\theappendixtable}{A.\arabic{appendixtable}}
    \addcontentsline{toc}{chapter}{APPENDIX}
    \renewcommand{\theequation}{A.\arabic{equation}}
}
\newcommand{\namedappendix}[1]{
    \chapter*{APPENDIX. #1}
    \setcounter{appendixfigure}{0}
    \renewcommand{\theappendixfigure}{A.\arabic{appendixfigure}}
    \setcounter{appendixtable}{0}
    \renewcommand{\theappendixtable}{A.\arabic{appendixtable}}
    \addcontentsline{toc}{chapter}{APPENDIX. \uppercase{#1}}
    \renewcommand{\theequation}{A.\arabic{equation}}
}
