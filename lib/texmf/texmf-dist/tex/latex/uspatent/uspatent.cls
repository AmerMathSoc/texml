%%
%% This is file `uspatent.cls',
%% 
%% 
%%   Author: Peter J. Pupalaikis  (pete_pope  at hotmail dot com)
%%   Copyright 2012 Peter J. Pupalaikis
%%   Version 1.0
%% 
%%   This work may be distributed and/or modified under the
%%   conditions of the LaTeX Project Public License, either
%%   version 1.3 of this license or (at your option) any
%%   later version.
%%   The latest version of the license is in
%%      http://www.latex-project.org/lppl.txt
%%   and version 1.3 or later is part of all distributions of
%%   LaTeX version 2003/06/01 or later.
%% 
%%   This work consists of the files listed in the README file.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uspatent}%
  [2012/06/09 v1.0 U.S. Patent Application Class]
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
%\ProcessOptions
\LoadClass[letterpaper,12pt]{memoir}[1996/10/24]

\newif\ifPatentOfficeMode
\PatentOfficeModetrue

\newcommand{\setAssigneeName}{\def\assigneeName}
\newcommand{\setAssigneeAddress}{\def\assigneeAddress}
\newcommand{\setAssigneeCity}{\def\assigneeCity}
\newcommand{\setAssigneePhone}{\def\assigneePhone}
\newcommand{\setDocketNumber}{\def\patentNumber}
\newcommand{\setLawyerName}{\def\patentLawyerName}
\newcommand{\setLawyerNumber}{\def\patentLawyerNumber}
\newcommand{\setLawyerPhone}{\def\patentLawyerPhone}
\newcommand{\setOtherInventor}[1]{\otherInventor{#1}}
\newcommand{\setDocumentVersion}{\def\patentDocumentVersion}
\newcommand{\setPrintingModeDraft}{\PatentOfficeModefalse}
\newcommand{\setPrintingModeApplication}{\PatentOfficeModetrue}
\newcommand{\inventor}{\author}

\settrimmedsize{11in}{8.5in}{*}
\setlength{\trimtop}{0pt}
\setlength{\trimedge}{0pt}
\settypeblocksize{8.5in}{36pc}{*}
\setulmargins{1.5in}{*}{*}
\setlrmargins{*}{*}{1}
\setmarginnotes{17pt}{51pt}{\onelineskip}
\setheadfoot{5\onelineskip}{3\onelineskip}
\setheaderspaces{*}{2\onelineskip}{*}
\checkandfixthelayout
\captiondelim{}

\ifpdf
\usepackage[pdftex]{graphicx}
%No Commas in the PDF Title!?!
\usepackage[
hyperindex=true,
pdfusetitle,
bookmarks=true,
extension= pdf,
linkcolor=black,
colorlinks=true,
hyperfootnotes=false,
pdffitwindow=true,
pdftoolbar=true,
pdfmenubar=true,
debug=false,
pagebackref=true
]{hyperref}
\DeclareGraphicsExtensions{ .pdf, .jpg, .tif}
\else
\usepackage[dvips]{graphicx}
\DeclareGraphicsExtensions{ .eps, .jpg }
\fi

\usepackage{amsmath}
\usepackage{enumitem}
\usepackage[nolist]{acronym}
\usepackage{memhfixc}
\usepackage{xspace}
\usepackage{prettyref}
\usepackage{lmodern}
\usepackage[T1]{fontenc}
\usepackage{babel}
\usepackage{tikz}

\newrefformat{eq}{\textup{(\ref{#1})}}
\newrefformat{cla}{claim \ref{#1}}
\newrefformat{tab}{Table \ref{#1}}
\newrefformat{fig}{\figurename \ \textbf{\ref{#1}}}

\newcommand{\patentTitlePage}{%

\ifx\assigneeName\undefined
\global\edef\assigneeName{~}
\global\edef\confidentialAssignee{~}
\else
\global\edef\confidentialAssignee{%
Confidential Property of \assigneeName}
\fi
\ifx\assigneeAddress\undefined
\global\edef\assigneeAddress{~}
\fi
\ifx\assigneeCity\undefined
\global\edef\assigneeCity{~}
\fi
\ifx\assigneePhone\undefined
\global\edef\assigneePhone{~}
\fi
\ifx\patentNumber\undefined
\global\edef\patentNumber{~}
\fi
\ifx\patentLawyerName\undefined
\global\edef\patentLawyerName{~}
\fi
\ifx\patentLawyerNumber\undefined
\global\edef\patentLawyerNumber{~}
\fi
\ifx\patentLawyerPhone\undefined
\global\edef\patentLawyerPhone{~}
\fi
\ifx\patentDocumentVersion\undefined
\global\edef\patentDocumentVersion{0.0}
\fi
\ifx\thedate\undefined
\global\edef\thedate{\today}
\fi

\ifPatentOfficeMode
%patent office mode
\pagestyle{title}
\makeoddhead{myheadings}
{}{}{\scriptsize{\patentNumber}}
\makeevenhead{myheadings}
{}{}{\scriptsize{\patentNumber}}
\else
%not patent office mode
\pagestyle{title}
\makeoddhead{myheadings}
{\confidentialAssignee}
{}
{\scriptsize{Draft of \thedate\\version \patentDocumentVersion}}
\makeevenhead{myheadings}
{\confidentialAssignee}
{}
{\scriptsize{Draft of \thedate\\version \patentDocumentVersion}}
\fi
\begin{titlingpage}
\aliaspagestyle{titlingpage}{myheadings}
\begin{center}
\textbf{APPLICATION FOR UNITED STATES LETTERS PATENT} 
\vskip 172 pt
Title: \MakeUppercase{ \thetitle } 
\end{center}
\vskip 172 pt
\begin{flushleft} \begin{tabular}{rl}  Inventors:  & 
\theauthor \\
& \inventorListName{1} \\
& \inventorListName{2} \\
& \inventorListName{3} \\
& \inventorListName{4} \\
& \inventorListName{5} \\
& \inventorListName{6} \\
& \inventorListName{7} \\
& \inventorListName{8} \\
\end{tabular}\par \end{flushleft}
\begin{flushright}
\tiny{
\vskip 10 pt
%\\[4\baselineskip]
\patentLawyerName \\
\patentLawyerNumber \\
[2\baselineskip]
\assigneeName \\
\assigneeAddress \\
\assigneeCity \\
\assigneePhone
}
\end{flushright}
\end{titlingpage}
\parindent 10pt
\DoubleSpacing
}

\renewcommand{\maketitle}{
\patentTitlePage
\patentStart
}

\def\figureName{FIG.}

\def\etal{%
\expandafter\ifx\csname inventorname 1\endcsname\relax
\else
~et~al.
\fi
}

% use this command to put a comment in the margin
\newcommand{\patentComment}[1]{
\ifPatentOfficeMode
%patent office mode
\else
%not patent office mode
\begin{SingleSpace}
\marginpar{\tiny\textcolor{red}{ \begin{flushleft} #1 \end{flushleft}}}
\end{SingleSpace}
\fi
}

\newcommand{\patentSection}[1]{
\Needspace{8pc}
\section[#1][]{}
%\label{#2}
\begin{center}
\textbf{\underline{\MakeUppercase{{#1}}}}
\end{center}
}

\newcommand{\patentParagraph}{
\par\noindent
\refstepcounter{parnum}[\textbf{%
\ifnum \value{parnum} < 10 0\else\fi
\ifnum \value{parnum} < 100 0\else\fi
\ifnum \value{parnum} < 1000 0\else\fi
\arabic{parnum}}]
\indent}

\newcommand{\patentStart}{
\ifPatentOfficeMode
%patent office mode
\pagestyle{myheadings}
\makeoddhead{myheadings}{}{}{\scriptsize{\patentNumber}}
\makeevenhead{myheadings}{}{}{\scriptsize{\patentNumber}}
\makeoddfoot{myheadings}{}{\thepage}{}
\makeevenfoot{myheadings}{}{\thepage}{}
\else
%not patent office mode
\pagestyle{myheadings}
\makeoddhead{myheadings}
{\confidentialAssignee}
{}{\scriptsize{Draft of \thedate\\version \patentDocumentVersion}}
\makeevenhead{myheadings}
{\confidentialAssignee}
{}{\scriptsize{Draft of \thedate\\version \patentDocumentVersion}}
\makeoddfoot{myheadings}{\thepage}{}{\scshape{\tiny{\thetitle}}}
\makeevenfoot{myheadings}{\scshape{\tiny{\thetitle}}}{}{\thepage}
\fi

\begin{center}\textbf{\MakeUppercase{ \thetitle }}\end{center}

% don't show section numbers!
\setcounter{secnumdepth}{-1}
% let them go into the "TOC" (even though we won't print it) because
% this allows the PDF file to contain the appropriate bookmarks
\setcounter{tocdepth}{1}

\setbeforesecskip{0pc}
\setaftersecskip{0pc}
\parskip=10pt

% this is used to number paragraphs
\newcounter{parnum}
}


\makeatletter
\newcount\@inventornumber
\@inventornumber=0
\makeatother

\makeatletter
\def\otherInventor#1{
\global\advance\@inventornumber by 1
\expandafter\edef\csname inventorname \the\@inventornumber\endcsname{#1}}
\makeatother

\def\inventorListName#1{\csname inventorname #1\endcsname}

% Claims are the only area where I still use labels, hence the
% prettyref include.
% \patentClaimsStart essentially begins the enumerate environment and 
% \patentClaimsEnd essentially ends it.
% I'd like to remove this dependency someday and use the counter
% mechanisms used elsewhere.

% Inside, a claim is begin with \beginClaim which labels it and starts
% an \item.
% Claims are referenced with \claimRef
\newcommand{\beginClaim}[1]{\item \label{cla:#1}}
\newcommand{\claimRef}[1]{claim \ref{cla:#1}}

\newcommand{\WhatIsClaimed}{What is claimed:}

\newcommand{\patentClaimsStart}{
\newpage
\section[Claims][]{}
\parskip=0pt
\WhatIsClaimed
\begin{enumerate}
}

\newcommand{\patentClaimsEnd}{
\end{enumerate}
\newpage
}

%I'm not sure what this is but I'm afraid to remove it
\newcommand{\putfigcaption}{}

% Patent drawings have a special header that numbers the drawing pages
\newcommand{\patentDrawingsStart}{
\cleartooddpage
%\newpage
\ifPatentOfficeMode
%patent office mode
\setcounter{page}{1}
\pagestyle{myheadings}
\makeoddhead{myheadings}{}{
\tiny{\thetitle} \\
\tiny{\theauthor\etal} \\
\tiny{\patentNumber} \\
\tiny{\patentLawyerName\ \patentLawyerPhone}\\[.1in]
\tiny{\thepage/\thelastpage}
}{}
\makeevenhead{myheadings}{}{
\tiny{\thetitle} \\
\tiny{\theauthor\etal} \\
\tiny{\patentNumber} \\
\tiny{\patentLawyerName\ \patentLawyerPhone}\\[.1in]
\tiny{\thepage/\thelastpage}
}{}
\makeoddfoot{myheadings}{}{}{}
\makeevenfoot{myheadings}{}{}{}
\else
%not patent office mode
\pagestyle{myheadings}
\makeoddhead{myheadings}
{\confidentialAssignee}
{}
{\scriptsize{Draft of \thedate\\version \patentDocumentVersion}}
\makeevenhead{myheadings}
{\confidentialAssignee}
{}
{\scriptsize{Draft of \thedate\\version \patentDocumentVersion}}
\makeoddfoot{myheadings}{\thepage}{}{\scshape{\tiny{\thetitle}}}
\makeevenfoot{myheadings}{\scshape{\tiny{\thetitle}}}{}{\thepage}
\fi

\section[Drawings][]{}
\begin{SingleSpace}
}

\newcommand{\patentDrawingsEnd}{
\end{SingleSpace}
%\newpage
\clearpage
}

\makeatletter
\newcount\@annotationnumber
\@annotationnumber=0
\makeatother

\makeatletter
\newcount\@annotationfigurenumber
\@annotationfigurenumber=0
\makeatother

\makeatletter
\def\advanceannotationfigurenumber{
\global\advance\@annotationfigurenumber by 1}
\makeatother

\makeatletter
\def\setannotationnumber#1{%
\global\@annotationnumber=#1
\global\advance\@annotationnumber by -1
}
\makeatother

\def\annotationnextfigure{
\global\advance\@annotationfigurenumber by 1}

\makeatletter
\def\setannotationfigurenumber#1{%
\global\@annotationfigurenumber=#1
}
\makeatother

\makeatletter
\def\@newannotation#1{
\expandafter\ifx\csname anonum#1 \endcsname\relax
\global\advance\@annotationnumber by 1
\expandafter\edef\csname anoele \the\@annotationnumber\endcsname{#1}
\expandafter\edef\csname anonum#1 \endcsname{\the\@annotationnumber}
\expandafter\edef\csname anofignum \the\@annotationnumber\endcsname{%
\the\@annotationfigurenumber}
\else\message{error: duplicate annotation #1}\fi}
\makeatother

\makeatletter
\def\annotationDefinition{%
\@ifnextchar[{\@annotationDefinitionmulti}{\@newannotation}}
\def\@annotationDefinitionmulti[#1]#2{%
\@newannotation{#2}\annotationName{#1}
\@ifnextchar[{\@annotationDefinitionfull}{}}
\def\@annotationDefinitionfull[#1]{\annotationDescription{#1}}
\makeatother

\makeatletter
\def\annotationDescription#1{%
\expandafter\ifx\csname anodesc \the\@annotationnumber\endcsname\relax
\expandafter\def\csname anodesc \the\@annotationnumber\endcsname{#1}
\else
\message{error while assigning description ``#1'' to annotation variable
``\annotationListVariableName{\the\@annotationnumber}''
 - it was already defined as
``\annotationListDescription{\the\@annotationnumber}''.}\fi}
\makeatother

\makeatletter
\def\annotationName#1{%
\expandafter\ifx\csname anotext \the\@annotationnumber\endcsname\relax
\expandafter\def\csname anotext \the\@annotationnumber\endcsname{#1}
\else
\message{error while assigning text name ``#1'' to annotation variable
``\annotationListVariableName{\the\@annotationnumber}''
 - it was already defined as
``\annotationListText{\the\@annotationnumber}''.}\fi}
\makeatother

\makeatletter
\def\annotationReference#1{%
[\thinspace\annotationNumberReference{#1}\thinspace]}
\makeatother

\def\annotationNameAndReference#1{%
\annotationTextReference{#1}~\annotationReference{#1}}

\def\annotationDescriptionreference#1{%
\csname anodesc \annotationNumberReference{#1}\endcsname}

\def\annotationTextReference#1{%
\csname anotext \annotationNumberReference{#1}\endcsname}

\def\annotationNumberReference#1{\csname anonum#1 \endcsname}

\def\annotationNumberReferenceUnderlined#1{\underline{\csname anonum#1 \endcsname}}

\def\annotationListVariableName#1{\csname anoele #1\endcsname}

\def\annotationListText#1{\csname anotext #1\endcsname}

\def\annotationListDescription#1{\csname anodesc #1\endcsname}

\def\annotationListFigureNumber#1{\csname anofignum #1\endcsname}

\def\annotationListFigureDescription#1{\csname anofigdesc #1\endcsname}

\def\annotationListFigureExtension#1{\csname anofigext #1\endcsname}

\def\annotationListFigureCaption#1{\csname anofigcap #1\endcsname}

\def\annotationListFigureName#1{\csname anofigname #1\endcsname}

\def\annotationListPrintFigure#1#2{
\edef\testa{#1}\edef\testb{#2}\edef\testzero{0}
\ifx\testb\testzero
\figureName #1---\annotationListFigureName{#1}.%
\annotationListFigureExtension{#1}%
---\annotationListFigureDescription{#1}
\par
\else
\ifx\testa\testb
\else
\figureName #1---\annotationListFigureName{#1}.%
\annotationListFigureExtension{#1}%
---\annotationListFigureDescription{#1}
\par
\fi\fi
}

\def\annotationListSectionName{\section*{Annotation List}}

\makeatletter
\def\printAnnotationList{{%
\@annotationnumber=1
\@annotationfigurenumber=0
\expandafter\ifx\csname anoele \the\@annotationnumber\endcsname\relax
\else
\annotationListSectionName\par
\loop
\expandafter\ifx\csname anoele \the\@annotationnumber\endcsname\relax
\else
\leftskip = -10 pt
\annotationListPrintFigure{%
\annotationListFigureNumber{\the\@annotationnumber}}
{\the\@annotationfigurenumber}
\leftskip = 10 pt
%\hangindent = 20 pt
%\hangafter
\par
\@annotationfigurenumber=%
\annotationListFigureNumber{\the\@annotationnumber}
\the\@annotationnumber---%
\annotationListVariableName{\the\@annotationnumber}---%
\annotationListText{\the\@annotationnumber}---%
\annotationListDescription{\the\@annotationnumber}
\par
\leftskip = -10 pt
\advance\@annotationnumber by 1
\repeat
\fi
}}
\makeatother

\def\annotationFigureListPrintFigure#1{
\figureName ~#1 \annotationListFigureDescription{#1}}

\def\annotationFigureListSectionName{%
\section*{Brief Description of the Drawings}}
\def\annotationFigureListPreamble{%
For a more complete understanding of the invention,
reference is made to the following description and accompanying
drawings, in which:\par}

\def\setFigureListNoRunOn{%
\def\annotationFigureListLast{.}
\def\annotationFigureListNextLast{.}
\def\annotationFigureListOther{.}
}

\def\annotationFigureListLast{.}
\def\annotationFigureListNextLast{; and}
\def\annotationFigureListOther{;}

\makeatletter
\def\printAnnotationFigureList{{
\@annotationfigurenumber=1
\expandafter\ifx\csname anofigdesc \the\@annotationfigurenumber\endcsname\relax
\else
\annotationFigureListSectionName\par
\annotationFigureListPreamble\par
\loop
\expandafter\ifx\csname anofigdesc \the\@annotationfigurenumber\endcsname\relax
\else
\annotationFigureListPrintFigure{\the\@annotationfigurenumber}%
{\advance\@annotationfigurenumber by 1
\expandafter\ifx\csname anofigdesc \the\@annotationfigurenumber\endcsname\relax
\annotationFigureListLast\else{\advance\@annotationfigurenumber by 1
\expandafter\ifx\csname anofigdesc \the\@annotationfigurenumber\endcsname\relax
\annotationFigureListNextLast\else\annotationFigureListOther\par\fi}\fi}
\advance\@annotationfigurenumber by 1
\repeat
\fi
}}
\makeatother

\makeatletter
\def\figureDescription#1{%
\expandafter\ifx\csname anofigdesc \the\@annotationfigurenumber\endcsname\relax
\expandafter\def\csname anofigdesc \the\@annotationfigurenumber\endcsname{#1}
\else
\message{error while assigning description ``#1'' to annotation figure number
``\the\@annotationfigurenumber'' - it was already defined as
``\annotationListFigureDescription{\the\@annotationfigurenumber}''.}\fi}
\makeatother

\makeatletter
\def\figureExtension#1{%
\expandafter\ifx\csname anofigext \the\@annotationfigurenumber\endcsname\relax
\expandafter\def\csname anofigext \the\@annotationfigurenumber\endcsname{#1}
\else
\message{error while assigning extension ``#1'' to annotation figure number
``\the\@annotationfigurenumber'' - it was already defined as
``\annotationListFigureExtension{\the\@annotationfigurenumber}''.}\fi}
\makeatother

\makeatletter
\def\figureCaption#1{%
\expandafter\ifx\csname anofigcap \the\@annotationfigurenumber\endcsname\relax
\expandafter\def\csname anofigcap \the\@annotationfigurenumber\endcsname{#1}
\else
\message{error while assigning caption ``#1'' to annotation figure number 
``\the\@annotationfigurenumber'' - it was already defined as
``\annotationListFigureCaption{\the\@annotationfigurenumber}''.}\fi}
\makeatother

\makeatletter
\def\figureClearPageAfter{%
\expandafter\def\csname anofigcp \the\@annotationfigurenumber\endcsname{}}
\makeatother

\makeatletter
\def\@newfigure#1{
\expandafter\ifx\csname fignum#1 \endcsname\relax
\global\advance\@annotationfigurenumber by 1
\expandafter\edef\csname anofigname \the\@annotationfigurenumber\endcsname{#1}
\expandafter\edef\csname fignum#1 \endcsname{\the\@annotationfigurenumber}
\else\message{error: duplicate annotation #1}\fi}
\makeatother

\makeatletter
\def\figureDefinition{\@ifnextchar[{\@figuredefinitionmulti}{\@newfigure}}
\def\@figuredefinitionmulti[#1]#2{\@newfigure{#2}\figureDescription{#1}}
\makeatother

\makeatletter
\def\figureReference#1{FIG.~\figurenumberreference{#1}}
\makeatother

\def\figurenumberreference#1{\csname fignum#1 \endcsname}

\expandafter\def\csname showfigure pdf\endcsname #1#2#3{%
\begin{figure}[!ht]
\centering
\includegraphics[]{#1.#2}\par
\figureReference{#1}~~#3 \par
\end{figure}
}

\expandafter\def\csname showfigure tpx\endcsname #1#2#3{%
\begin{figure}[ht]
\centering
\input{"#1.tpx"}\par
\figureReference{#1}~~#3 \par
\end{figure}
}

\expandafter\def\csname showfigure tex\endcsname #1#2#3{%
\begin{figure}[ht]
\centering
\input{"#1.tex"}\par
\figureReference{#1}~~#3 \par
\end{figure}
}

\expandafter\def\csname showfigure placeholder\endcsname #1#2#3{%
\begin{figure}[ht]
\centering
no extension provided for file name #1.\par This will be
used as a placeholder\par
\figureReference{#1}~~#3 \par
\end{figure}
}

\expandafter\def\csname showfigure unk\endcsname #1#2#3{%
\begin{figure}[ht]
\centering
\includegraphics[]{#1.#2}\par
\figureReference{#1}~~#3 \par
\end{figure}
}

\makeatletter
\def\figures{{%
\@annotationfigurenumber=1
\expandafter\ifx\csname anofigname \the\@annotationfigurenumber\endcsname\relax
\else
\figuresStart
\loop
\expandafter\ifx\csname anofigname \the\@annotationfigurenumber\endcsname\relax
\else
\expandafter\ifx\csname anofigext \the\@annotationfigurenumber\endcsname\relax
\edef\figureextension{placeholder}
\else
\edef\figureextension{%
\annotationListFigureExtension{\the\@annotationfigurenumber}}
\fi
\expandafter\ifx\csname showfigure \figureextension\endcsname\relax
% this is an unknown figure extension
\def\figureshower{\csname showfigure unk\endcsname}
\else
\def\figureshower{\csname showfigure \figureextension\endcsname}
\fi
\figureshower{\annotationListFigureName{\the\@annotationfigurenumber}}%
{\figureextension}%
{\annotationListFigureCaption{\the\@annotationfigurenumber}}
\expandafter\ifx\csname anofigcp \the\@annotationfigurenumber\endcsname\relax
\else
\clearpage
\fi
\advance\@annotationfigurenumber by 1
\repeat
\figuresEnd
\fi
}}
\makeatother

\def\annotationFigureListSectionName{
\patentSection{Brief Description of the Drawings}}

\def\annotationListSectionName{\patentSection{Annotation List}}

\def\annotationFigureListPreamble{
\patentParagraph{For a more complete understanding of the invention,
reference is made to the following description and accompanying
drawings, in which:}}

\def\patentDrawingDescriptions{\printAnnotationFigureList}

\def\referencePatentFigure#1{\figureReference{#1}}
\def\annotate#1{\annotationReference{#1}}
\def\annotateWithName#1{\annotationNameAndReference{#1}}

\def\annotationFigureListPrintFigure#1{
\patentParagraph{\figureName ~#1 \annotationListFigureDescription{#1}}}

\def\annotateNoBrackets#1{\annotationNumberReference{#1}}

\def\figuresStart{\patentDrawingsStart}
\def\figuresEnd{\patentDrawingsEnd}

\def\patentDrawings{%
\ifPatentOfficeMode
\else
\printAnnotationList
\fi

\figures
}

\endinput
%%
%% End of file `patent.cls'.
