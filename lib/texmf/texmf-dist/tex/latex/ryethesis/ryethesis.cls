%%
%% This is file `ryethesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ryethesis.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2009 by Jason V. Lassaline <jvl@ryerson.ca>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{ryethesis}
    [2014/05/09 v1.36 Ryerson University thesis class definition]

\RequirePackage{ifthen}
\RequirePackage{fancyhdr}
\RequirePackage{setspace}
\RequirePackage{vmargin}
\newboolean{@ryedraft} \setboolean{@ryedraft}{false} % not draft == final
\newboolean{@ryelistoftables} \setboolean{@ryelistoftables}{true}
\newboolean{@ryelistofplates} \setboolean{@ryelistofplates}{false}
\newboolean{@ryelistoffigures} \setboolean{@ryelistoffigures}{true}
\newboolean{@ryelistofillustrations} \setboolean{@ryelistofillustrations}{false}
\newboolean{@ryelistofappendices} \setboolean{@ryelistofappendices}{true}
\newboolean{@ryehyperref} \setboolean{@ryehyperref}{true}
\newboolean{@ryenomenclature} \setboolean{@ryenomenclature}{false}
\newboolean{@ryeglossary} \setboolean{@ryeglossary}{false}
\newboolean{@ryeindex} \setboolean{@ryeindex}{false}
\DeclareOption*{%
 \PassOptionsToClass{\CurrentOption}{book}
}


\DeclareOption{draft}{
   \typeout{Ryerson-Thesis Class Option: `draft'}
   \ExecuteOptions{10pt,oneside}
   \PassOptionsToClass{draft,oneside}{book}
   \setboolean{@ryedraft}{true}
}

\DeclareOption{review}{
   \typeout{Ryerson-Thesis Class Option: `review'}
   \ExecuteOptions{10pt,oneside}
   \PassOptionsToClass{final,oneside}{book}
   \setboolean{@ryedraft}{false}
}

\DeclareOption{final}{
   \typeout{Ryerson-Thesis Class Option: `final'}
   \ExecuteOptions{10pt,twoside}
   \PassOptionsToClass{final,twoside}{book}
   \setboolean{@ryedraft}{false}
}

\DeclareOption{lof}{
    \typeout{Ryerson-Thesis Class Option: `lof' Enabling List of Figures}
    \setboolean{@ryelistoffigures}{true}
}

\DeclareOption{nolof}{
    \typeout{Ryerson-Thesis Class Option: `nolof' Disabling List of Figures}
    \setboolean{@ryelistoffigures}{false}
}

\DeclareOption{lop}{
    \typeout{Ryerson-Thesis Class Option: `lop' Enabling List of Plates}
    \setboolean{@ryelistofplates}{true}
}

\DeclareOption{nolop}{
    \typeout{Ryerson-Thesis Class Option: `nolop' Disabling List of Plates}
    \setboolean{@ryelistofplates}{false}
}

\DeclareOption{loi}{
    \typeout{Ryerson-Thesis Class Option: `loi' Enabling List of Illustrations}
    \setboolean{@ryelistofillustrations}{true}
}

\DeclareOption{noloi}{
    \typeout{Ryerson-Thesis Class Option: `noloi' Disabling List of Illustrations}
    \setboolean{@ryelistofillustrations}{false}
}

\DeclareOption{lot}{
    \typeout{Ryerson-Thesis Class Option: `lot' Enabling List of Tables}
    \setboolean{@ryelistoftables}{true}
}

\DeclareOption{nolot}{
    \typeout{Ryerson-Thesis Class Option: `nolot' Disabling List of Tables}
    \setboolean{@ryelistoftables}{false}
}

\DeclareOption{loa}{
    \typeout{Ryerson-Thesis Class Option: `loa' Enabling List of Appendices}
    \setboolean{@ryelistofappendices}{true}
}

\DeclareOption{noloa}{
    \typeout{Ryerson-Thesis Class Option: `noloa' Disabling List of Appendices}
    \setboolean{@ryelistofappendices}{false}
}

\DeclareOption{nohyperref}{
    \typeout{Ryerson-Thesis Class Option: `nohyperref' Do not include hyperref}
    \setboolean{@ryehyperref}{false}
}

\DeclareOption{los}{
     \typeout{Ryerson-Thesis Class Option: `los' Enabling Nomenclature}
     \typeout{*********************************************************************}
     \typeout{}
     \typeout{ Use: makeindex filename.nlo -s nomencl.ist -o filename.nls }
     \typeout{         where filename is the root file name of the TeX source file.}
     \typeout{}
     \typeout{*********************************************************************}
     \setboolean{@ryenomenclature}{true}
}

\DeclareOption{nolos}{
     \typeout{Ryerson-Thesis Class Option: `nolos' Disabling Nomenclature}
     \setboolean{@ryenomenclature}{false}
}

\DeclareOption{glossary}{
    \typeout{Ryerson-Thesis Class Option: `glossary' Enabling Glossary}
     \typeout{*********************************************************************}
     \typeout{}
     \typeout{ Use: makeglossaries filename }
     \typeout{         where filename is the root file name of the TeX source file.}
     \typeout{}
     \typeout{*********************************************************************}
   \setboolean{@ryeglossary}{true}
}

\DeclareOption{noglossary}{
     \typeout{Ryerson-Thesis Class Option: `noglossary' Disabling Glossary}
     \setboolean{@ryeglossary}{false}
}

\DeclareOption{index}{
    \typeout{Ryerson-Thesis Class Option: `index' Enabling Index}
     \typeout{*********************************************************************}
     \typeout{}
     \typeout{ Use: makeindex filename }
     \typeout{         where filename is the root file name of the TeX source file.}
     \typeout{}
     \typeout{*********************************************************************}
   \setboolean{@ryeindex}{true}
}

\DeclareOption{noindex}{
     \typeout{Ryerson-Thesis Class Option: `noindex' Disabling Index}
     \setboolean{@ryeindex}{false}
}

\ExecuteOptions{letterpaper,10pt}
\ProcessOptions\relax

\LoadClass{book}

\setpapersize{USletter}
\setmargrb{1.25in}{1in}{1in}{1in}


\renewcommand{\cleardoublepage}{\newpage{\pagestyle{empty}%
\clearpage\if@twoside \ifodd\c@page\else%
\hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}}
\newcommand{\ryethesis@clearpage}
{\if@openright\cleardoublepage\else\clearpage\fi}

\newif\if@ryethesismatchtoc \@ryethesismatchtocfalse
\renewcommand\frontmatter{%
  \@mainmatterfalse
  \@ryethesismatchtocfalse
 \pagenumbering{roman}
  \pagestyle{plain}
  \maketitle
 \ryethesis@insertdeclaration
  \ryethesis@insertabstract
  \ryethesis@insertacknowledgements
  \ryethesis@insertdedication
  \ryethesis@inserttoc
  \ryethesis@insertlot
  \ryethesis@insertlop
  \ryethesis@insertlof
  \ryethesis@insertloi
  \ryethesis@insertloa
  \ryethesis@insertnom
  \ryethesis@clearpage
  \pagenumbering{arabic}
  \pagestyle{fancy}
  % If the acronym feature is used with the glossary of terms, \gls
  % commands for acronyms will be expanded on first use if used in the
  % front matter (e.g. in the abstract). Reset this usage so that the
  % first use of a \gls acronym is expanded in the main matter as well.
  \ifthenelse{\boolean{@ryeglossary}}{\glsresetall}{}
}

\renewcommand\mainmatter{%
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{fancy}
}
\renewcommand\backmatter{%
 \ifthenelse{\boolean{@ryelistofappendices}}{\@ryethesismatchtoctrue}{\@ryethesismatchtocfalse}
 \ryethesis@insertappendix
 \@ryethesismatchtocfalse
 \ryethesis@insertreferences
  \ryethesis@insertglossary
  \ryethesis@insertindex
 \@mainmatterfalse
}
\fancyhead{} % Clear all header fields
\fancyhead[LE,RO]{\slshape \rightmark}
\fancyhead[LO,RE]{\slshape \leftmark}
\fancyfoot{} % Clear all footer fields
\fancyfoot[C]{\thepage}


\global\def\ryethesis@documentType{thesis} % Alternate forms include 'dissertation' or 'project'
\global\def\ryethesis@degree{}
\global\def\ryethesis@prevDegreeA{}
\global\def\ryethesis@prevDegreeB{}
\global\def\ryethesis@prevDegreeC{}
\global\def\ryethesis@prevDegreeD{}
\global\def\ryethesis@prevLocationA{}
\global\def\ryethesis@prevLocationB{}
\global\def\ryethesis@prevLocationC{}
\global\def\ryethesis@prevLocationD{}
\global\def\ryethesis@prevYearA{}
\global\def\ryethesis@prevYearB{}
\global\def\ryethesis@prevYearC{}
\global\def\ryethesis@prevYearD{}
\global\def\ryethesis@program{}
\global\def\ryethesis@degreeyear{}
\global\def\ryethesis@partnerUniv{}
\global\def\ryethesis@theabstract{}
\global\def\ryethesis@theacknowledgements{}
\global\def\ryethesis@thededication{}
\global\def\ryethesis@listofbibfiles{}
\global\def\ryethesis@theappendices{}


\def\title#1{\gdef\@title{#1}\if@ryehyperref\hypersetup{pdftitle={#1}}\fi}

\def\author#1{\gdef\@author{#1}\if@ryehyperref\hypersetup{pdfauthor={#1}}\fi}

\newcommand{\documenttype}[1]{\ifx\empty#1\else\gdef\ryethesis@documentType{#1}\fi}
\newcommand{\thesis}{\documenttype{thesis}}
\newcommand{\dissertation}{\documenttype{dissertation}}
\newcommand{\project}{\documenttype{MRP}}

\newcommand{\degreeName}[1]{\gdef\ryethesis@degree{#1}\if@ryehyperref\hypersetup{pdfsubject={#1}}\fi}
\newcommand{\degreeYear}[1]{\gdef\ryethesis@degreeYear{#1}}
\newcommand{\program}[1]{\gdef\ryethesis@program{#1}}

\newcommand{\prevDegreeA}[3]{%
\gdef\ryethesis@prevDegreeA{#1}\gdef\ryethesis@prevLocationA{#2}\gdef\ryethesis@prevYearA{#3}}
\newcommand{\prevDegreeB}[3]{%
\gdef\ryethesis@prevDegreeB{#1}\gdef\ryethesis@prevLocationB{#2}\gdef\ryethesis@prevYearB{#3}}
\newcommand{\prevDegreeC}[3]{%
\gdef\ryethesis@prevDegreeC{#1}\gdef\ryethesis@prevLocationC{#2}\gdef\ryethesis@prevYearC{#3}}
\newcommand{\prevDegreeD}[3]{%
\gdef\ryethesis@prevDegreeD{#1}\gdef\ryethesis@prevLocationD{#2}\gdef\ryethesis@prevYearD{#3}}

\newcommand{\partnerUniversity}[1]{\gdef\ryethesis@partnerUniv{#1}}

\renewcommand{\maketitle}
{\begin{titlepage}
 %% Set the line spacing to 1 for the title page.
   \begin{spacing}{2}
   \begin{large}
  \begin{center}
    \vfill
     {\LARGE\textsc{\@title}}\\
     \vfill%\vspace{2\baselineskip}
      by \\
     \vfill%\vspace{\baselineskip}
      {\@author}\\
      {\ifx\empty\ryethesis@prevDegreeA\else{\ryethesis@prevDegreeA, \ryethesis@prevLocationA, \ryethesis@prevYearA}\\\fi}
      {\ifx\empty\ryethesis@prevDegreeB\else{\ryethesis@prevDegreeB, \ryethesis@prevLocationB, \ryethesis@prevYearB}\\\fi}
      {\ifx\empty\ryethesis@prevDegreeC\else{\ryethesis@prevDegreeC, \ryethesis@prevLocationC, \ryethesis@prevYearC}\\\fi}
      {\ifx\empty\ryethesis@prevDegreeD\else{\ryethesis@prevDegreeD, \ryethesis@prevLocationD, \ryethesis@prevYearD}\\\fi}
     \vfill%\vspace{3\baselineskip}
     {A \ryethesis@documentType}\\
      {presented to Ryerson University}\\
      {\ifx\empty\ryethesis@partnerUniv\else{and \ryethesis@partnerUniv}\\\fi}
     \vspace{\baselineskip}
    {in partial fulfillment of the}\\
      {requirements for the degree of}\\
      {\ryethesis@degree}\\
      {in the Program of}\\
      {\ryethesis@program}\\
     \vfill
     {Toronto, Ontario, Canada, \ryethesis@degreeYear}\\
      {\copyright\@author~\ryethesis@degreeYear}\\
 \end{center}
 \end{large}
  \end{spacing}
  \end{titlepage}

}

\newcommand{\declaration}{%
 \begin{flushleft}
 \textbf{AUTHOR'S DECLARATION FOR ELECTRONIC SUBMISSION OF A \MakeUppercase{\ryethesis@documentType{}}}\\
 \vspace{\baselineskip}
  I hereby declare that I am the sole author of this
  \ryethesis@documentType{}. This is a true copy of the thesis,
  including any required final revisions, as accepted by my
  examiners.\\
  \vspace{\baselineskip}
  I authorize Ryerson University to lend this
  \ryethesis@documentType{} to other institutions or individuals for
  the purpose of scholarly research.\\
  \vspace{\baselineskip}
  I further authorize Ryerson University to reproduce this \ryethesis@documentType{}  by photocopying or by other means, in total or in part, at the request of other institutions or individuals for the purpose of scholarly research.\\
  \vspace{0.75in}
  I understand that my dissertation may be made electronically available to the public.
\end{flushleft}
}
\newcommand{\ryethesis@insertdeclaration}{%
\ifthenelse{\boolean{@ryedraft}}
{}
{
\ryethesis@clearpage\phantomsection\label{declaration}\addcontentsline{toc}{section}{\textit{\mdseries{}Declaration}}\declaration
}
}

\newcommand{\abstract}[1]{\ifx\empty#1\else\gdef\ryethesis@theabstract{\begin{center}\section*{Abstract}\end{center}#1}\fi}
\newcommand{\ryethesis@insertabstract}{%
\ryethesis@clearpage
\phantomsection\label{abstract}\addcontentsline{toc}{section}{\textit{\mdseries{}Abstract}}
\begin{spacing}{2}
\begin{center}
\normalsize
\@title\\
\ryethesis@degree{} \ryethesis@degreeYear\\
\@author\\
\ryethesis@program\\
Ryerson University{\ifx\empty\ryethesis@partnerUniv\else{ and
    \ryethesis@partnerUniv}\fi}\\
\end{center}
{\ifx\empty\ryethesis@theabstract{\begin{center}\textit{Abstract goes here!}\end{center}}\else\ryethesis@theabstract\fi}
\end{spacing}
}


\newcommand{\acknowledgements}[1]{\ifx\empty#1\else\gdef\ryethesis@theacknowledgements{#1}\fi}

\newcommand{\ryethesis@insertacknowledgements}{%
\ifx\empty\ryethesis@theacknowledgements\else{
\ryethesis@clearpage
\phantomsection\label{acknowledgements}\addcontentsline{toc}{section}{\textit{\mdseries{}Acknowledgements}}
\begin{center}
\section*{Acknowledgements}
\end{center}
\ryethesis@theacknowledgements
}\fi
}

\newcommand{\dedication}[1]{\ifx\empty#1\else\gdef\ryethesis@thededication{#1}\fi}

\newcommand{\ryethesis@insertdedication}{%
\ifx\empty\ryethesis@thededication\else{
\ryethesis@clearpage
\phantomsection\label{dedication}\addcontentsline{toc}{section}{\textit{\mdseries{}Dedication}}
\begin{center}
\section*{Dedication}
\end{center}
\ryethesis@thededication
}\fi
}


\newcommand{\includelistoftables}{\setboolean{@ryelistoftables}{true}}
\newcommand{\nolistoftables}{\setboolean{@ryelistoftables}{false}}
\newcommand{\includelistoffigures}{\setboolean{@ryelistoffigures}{true}}
\newcommand{\nolistoffigures}{\setboolean{@ryelistoffigures}{false}}
\newcommand{\includelistofplates}{\setboolean{@ryelistofplates}{true}}
\newcommand{\nolistofplates}{\setboolean{@ryelistofplates}{false}}
\newcommand{\includelistofillustrations}{\setboolean{@ryelistofillustrations}{true}}
\newcommand{\nolistofillustrations}{\setboolean{@ryelistofillustrations}{false}}
\newcommand{\includelistofappendices}{\setboolean{@ryelistofappendices}{true}}
\newcommand{\nolistofappendices}{\setboolean{@ryelistofappendices}{false}}
\newcommand{\includenomenclature}{\setboolean{@ryenomenclature}{true}}
\newcommand{\nonomenclature}{\setboolean{@ryenomenclature}{false}}
\newcommand{\includeindex}{\setboolean{@ryeindex}{true}}
\newcommand{\noindex}{\setboolean{@ryeindex}{false}}
\newcommand{\includeglossary}{\setboolean{@ryeglossary}{true}}
\newcommand{\noglossary}{\setboolean{@ryeglossary}{false}}

\newcommand{\ryethesis@inserttoc}{
\ryethesis@clearpage
\tableofcontents
}

\newcommand{\ryethesis@insertlot}{
\ifthenelse{\boolean{@ryelistoftables}}{\ryethesis@clearpage\phantomsection\label{listoftab}\addcontentsline{toc}{section}{\textit{\mdseries{}List
    of Tables}}\listoftables}{}
}

\ifthenelse{\boolean{@ryelistofplates}}
{\RequirePackage{float}\newfloat{plate}{h}{lop}}{}

\newcommand{\ryethesis@insertlop}{
\ifthenelse{\boolean{@ryelistofplates}}{\ryethesis@clearpage\phantomsection\label{listofplates}\addcontentsline{toc}{section}{\textit{\mdseries{}List
    of Plates}}\listof{plate}{List of Plates}}{}
}

\newcommand{\ryethesis@insertlof}{
\ifthenelse{\boolean{@ryelistoftables}}{\ryethesis@clearpage\phantomsection\label{listoffig}\addcontentsline{toc}{section}{\textit{\mdseries{}List
    of Figures}}\listoffigures}{}
}

\ifthenelse{\boolean{@ryelistofillustrations}}
{\RequirePackage{float}\newfloat{illustration}{h}{loi}}{}

\newcommand{\ryethesis@insertloi}{
\ifthenelse{\boolean{@ryelistofillustrations}}{\ryethesis@clearpage\phantomsection\label{listofillustrations}\addcontentsline{toc}{section}{\textit{\mdseries{}List
      of Illustrations}}\listof{illustration}{List of Illustrations}}{}
}

\ifthenelse{\boolean{@ryelistofappendices}}
{
\newcommand{\nohyphens}{\hyphenpenalty=10000\exhyphenpenalty=10000\relax}
\newcommand{\listofappendices}{\chapter*{List of Appendices}\@starttoc{toa}}
}
{}

\newcommand{\ryethesis@insertloa}{%
\ifthenelse{\boolean{@ryelistofappendices}}{\ryethesis@clearpage\phantomsection\label{listofapp}\addcontentsline{toc}{section}
  {\textit{\mdseries{}List of Appendices}}\listofappendices}{}
}

\renewcommand{\appendix}[1]{\ifx\empty#1\else\gdef\ryethesis@theappendices{#1}\fi}

\newcommand{\ryethesis@insertappendix}{%
\ifx\empty\ryethesis@theappendices\else{
\ryethesis@clearpage
\renewcommand{\chaptername}{Appendix}
\setcounter{chapter}{0}
\ryethesis@theappendices
}\fi
}

\if@ryehyperref
\RequirePackage[pageanchor,hyperindex]{hyperref}
\RequirePackage{bookmark}
\fi

\ifthenelse{\boolean{@ryeglossary}}
{\RequirePackage[acronym,toc]{glossaries}\makeglossaries%
  %Glossaries prints a confusing warning
  \global\let\warn@noprintglossary\relax
}{}

\ifthenelse{\boolean{@ryeindex}}
{
\providecommand*\see[2]{\emph{\seename} #1}
\providecommand*\seealso[2]{\emph{\alsoname} #1}
\providecommand\printindex{\@input@{\jobname.ind}}
\providecommand\seename{see}
\providecommand*\alsoname{see also}
\makeindex
\RequirePackage{multicol}
\renewenvironment{theindex}
               {\begin{multicols}{2}[\@makeschapterhead{\indexname}\addcontentsline{toc}{chapter}{\indexname}%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}]%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\end{multicols}\clearpage}
}
{}

\ifthenelse{\boolean{@ryenomenclature}}{%
\RequirePackage{nomencl}
\renewcommand{\nomname}{List of Symbols}
\makenomenclature
}{}

\newcommand{\ryethesis@insertnom}{%
\ifthenelse{\boolean{@ryenomenclature}}{\ryethesis@clearpage\printnomenclature}{}
}

\newcommand{\ryethesis@insertreferences}{%
\ifx\emtpy\ryethesis@listofbibfiles
\else
 \ryethesis@clearpage\bibliography{\ryethesis@listofbibfiles}
 \addcontentsline{toc}{chapter}{\bibname}
\fi
}

\newcommand{\ryethesis@insertglossary}{%
\ifthenelse{\boolean{@ryeglossary}}
{\ryethesis@clearpage%
\printglossaries%glossaries.sty prints a false warning.
\global\let\warn@noprintglossary\relax%
}
{}
}

\newcommand{\ryethesis@insertindex}{%
\ifthenelse{\boolean{@ryeindex}}
{\ryethesis@clearpage%
\printindex
}
{}
}


\newcommand{\addtoreferences}[1]{%
\ifx\empty\ryethesis@listofbibfiles\edef\ryethesis@listofbibfiles{#1}\else\edef\ryethesis@listofbibfiles{#1,\ryethesis@listofbibfiles}\fi
}

\newcommand{\usebibliography}{\renewcommand{\bibname}{Bibliography}}
\newcommand{\usereferences}{\renewcommand{\bibname}{References}}
\newcommand{\useendnotes}{\renewcommand{\bibname}{End Notes}}


\AtEndOfClass{
\ifthenelse{\boolean{@ryedraft}}
{% Draft mode uses double spacing
\doublespacing}
{% Final mode uses 1.5 spacing as specified in SGS policy Sept. 2009.
\onehalfspacing}
\usereferences

}
\RequirePackage{etoolbox}
\AfterEndPreamble{


\newcommand{\Saved@addtocontents}{}
\let\Saved@addtocontents\addtocontents
\def\addtocontents#1#2{%
\if@ryethesismatchtoc%
{\ifthenelse{\equal{#1}{toc}}%
{\Saved@addtocontents{toa}{#2}}
{\Saved@addtocontents{#1}{#2}}}
\else
{\Saved@addtocontents{#1}{#2}}
\fi}

\frontmatter\mainmatter
}
\AtEndDocument{\backmatter}
\endinput
%%
%% End of file `ryethesis.cls'.
