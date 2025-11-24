%%
%% This is file `uothesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% uothesis.dtx  (with options: `class')
%% ----------------------------------------------------------------
%% uothesis --- Support for formatting of documents associated with the
%% graduate requirements for the master and doctorate degrees as
%% defined by the University of Oregon Graduate School in the fall of 2010.
%% Contact:  All contact regarding this package should be to the UOGS.
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uothesis} [2012/02/08 v2.5.6 Submission to
 University of Oregon Graduate School]
\typeout{UO Thesis Class}
\typeout{}
\typeout{Based on the UO Thesis macros by Bart Massey, et al.}
\typeout{Currently maintained by Michael D. Anderson}
\typeout{Accepted by the University of Oregon Graduate School}
\typeout{for general use with Masters Thesis <date goes here>}
\typeout{Accepted by the University of Oregon Graduate School}
\typeout{for general use with PhD Dissertations <date goes here>}
\typeout{}
\listfiles
\newif\ifthesis
\newif\ifdraftcopy
\newif\ifcommitteedraft
\newif\iflatedraft
\newif\ifdraftimage
\newif\ifdraft
\newif\iffinal
\newif\ifsc
\newif\iflipsum
\newif\ifjustified
\newif\ifamstex
\newif\ifchem
\newif\ifbound
\newif\ifnatbib
\newif\ifnotables
\newif\ifnofigures
\newif\if@dissertation
\newif\if@copyright
\newif\if@gsmodern
\newif\if@numsections
\newif\if@contnumb
\newif\if@draftimage
\DeclareOption{dissertation}{\@dissertationtrue\thesistrue\natbibtrue}
\DeclareOption{msthesis}{\@dissertationfalse\thesistrue}
\DeclareOption{draftimages}{\draftimagetrue\PassOptionsToPackage{draft}{graphicx}}
\DeclareOption{draftcopy}{\drafttrue\draftcopytrue\boundtrue}
\DeclareOption{committeedraft}{\drafttrue\committeedrafttrue}
\DeclareOption{latedraft}{\drafttrue\latedrafttrue}
\DeclareOption{copyright}{\@copyrighttrue}
\DeclareOption{gsmodern}{\@gsmoderntrue}
\DeclareOption{numsections}{\@numsectionstrue}
\DeclareOption{amstex}{\amstextrue}
\DeclareOption{chemistry}{\chemtrue\amstextrue}
\DeclareOption{smallcaps}{\sctrue}
\DeclareOption{justified}{\justifiedtrue}
\DeclareOption{nofigures}{\nofigurestrue}
\DeclareOption{notables}{\notablestrue}
\DeclareOption{cheqns}{}
\DeclareOption{final}{\draftcopyfalse\draftimagefalse
\committeedraftfalse\latedraftfalse\finaltrue}
\DeclareOption{lipsum}{\lipsumtrue}
\DeclareOption{bound}{\boundtrue}
\DeclareOption{natbib}{\natbibtrue}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{natbib}}
\ProcessOptions
\ifthesis\else
\typeout{warning: Neither msthesis nor dissertation specified}
\fi
\ifbound
\typeout{PAGE FORMAT CHANGED FOR BINDING AND PRINTING}
\typeout{This format DOES NOT COMPLY with University of Oregon Guidelines}
\typeout{For personal use only!}
\fi
\iflatedraft\PassOptionsToClass{12pt,draft}{report}\fi
\ifcommitteedraft\PassOptionsToClass{12pt,draft}{report}\fi
\ifdraftcopy\PassOptionsToClass{10pt,draft}{report}
\PassOptionsToClass{draft}{todonotes}\fi
\iffinal
\ifbound
\PassOptionsToClass{12pt,twoside}{report}
\else
\PassOptionsToClass{12pt}{report}
\fi\fi
\LoadClass{report}
\RequirePackage{float}
\RequirePackage{subfig}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{xspace}
\RequirePackage[left,pagewise]{lineno}
\RequirePackage{layouts}
\RequirePackage[colorinlistoftodos]{todonotes}
\RequirePackage{ragged2e}
\captionsetup{labelsep=space}
\setlength\RaggedRightRightskip{0pt plus 1cm}
\setlength\RaggedRightParindent{0.4in}

\ifchem
\RequirePackage[version=3]{mhchem}
\fi
\ifamstex
\RequirePackage{amsmath,amsthm,amssymb}
\fi
\iflipsum
\RequirePackage{lipsum}
\fi
\ifnatbib
\RequirePackage{natbib}
\fi

\ifdraft
\RequirePackage{draftwatermark}
\newcommand{\watermark}[5]{\SetWatermarkAngle{#1}
\SetWatermarkLightness{#2}
\SetWatermarkFontSize{#3}
\SetWatermarkScale{#4}
\SetWatermarkText{\uppercase{#5}}}
\ifdraftcopy\watermark{45}{0.95}{5cm}{2.5}{Draft}\fi
\ifcommitteedraft\watermark{45}{0.95}{5cm}{2.25}{Committee Draft}\fi
\iflatedraft\watermark{45}{0.95}{5cm}{2.5}{Review Proof}\fi
\fi
\ifdraftcopy
\RequirePackage[colorlinks=true,breaklinks=true]{hyperref}
   \newcounter{ednote}
\@addtoreset{ednote}{chapter}
   \newcommand{\ednote}[1]{\stepcounter{ednote}\todo[color=blue!40,size=\scriptsize,
caption={NOTE \arabic{chapter}.\arabic{ednote}: #1},noprepend]%
{\bf\hfil N.\arabic{chapter}.\arabic{ednote}\hfil}%
{\textbf{\textcolor{blue}{[N.\arabic{chapter}.\arabic{ednote}]}}}}
\newcommand{\here}{\textcolor{BrickRed}{$\blacksquare$}\todo[color=red!40,
size=\small,caption={\uppercase{Incomplete Section: Section \arabic{chapter}.
\arabic{section}}}]{\hfil\textbf{\uppercase{Incomplete Section}}\hfil}}
\newcounter{citation}
\newcounter{citationbychapter}
\@addtoreset{citationbychapter}{chapter}
    \newcommand{\needref}[1]{\stepcounter{citation}\stepcounter{citationbychapter}\todo[color=green!40,
size=\scriptsize,caption={CITE \arabic{chapter}.\arabic{citation}: #1}]
{\bf C.\arabic{chapter}.\arabic{citation}}
{\textbf{\textcolor{ForestGreen}{[C.\arabic{chapter}.\arabic{citation}]}}}}
    \newcommand{\rfmk}{\stepcounter{citation}\stepcounter{citationbychapter}
{\addcontentsline{tdo}{todo}{\protect{\colorbox{green!40}{\textcolor{green!40}{o}}\ Missing Reference: C.\arabic{chapter}.\arabic{citationbychapter}}}}%
{{\textcolor{red}{\ensuremath{^\text{[REF: C.\arabic{chapter}.\arabic{citationbychapter}]}}}}}}
\else
    \newcommand{\ednote}[1]{}
\newcommand{\here}{}
\newcommand{\needref}{}
\newcounter{citation}
\newcommand{\rfmk}{\stepcounter{citation}{\textcolor{red}{\cite{dummy_\arabic{citation}}}}}
\fi

\newcommand{\cleanbreak}{
\ifjustified
\\\hfil
\else
\newline
\fi}
\ifchem
\newcounter{reaction}
\renewcommand\thereaction{Formula\ \thechapter.\arabic{reaction}}
\@addtoreset{reaction}{chapter}
\newcommand\reactiontag{\refstepcounter{reaction}\tag{\thereaction}}
\newcommand{\chem}[2][]{\begin{equation}\cee{#2}%
\ifx\@empty#1\@empty\else\label{#1}\fi\reactiontag\end{equation}}
\newcommand{\chemarray}[3][]{\begin{equation}\begin{array}{#2}\cee{#3}%
\end{array}\ifx\@empty#1\@empty\else\label{#1}\fi\reactiontag\end{equation}}
\newcommand{\Chem}[2][]{\begin{multline}\cee{#2}%
\ifx\@empty#1\@empty\else\label{#1}\fi\reactiontag\end{multline}}
\fi
\newcommand*{\cst@xspace}{\expandafter\xspace}
\newcommand*{\cst@latin}{\expandafter}
\newcommand*{\etc}{\@ifnextchar.{\cst@etc}{\cst@etc.\cst@xspace}}
\newcommand*{\invacuo}{\cst@latin{in vacuo}\cst@xspace}
\newcommand*{\etal}{\@ifnextchar.{\cst@etal}{\cst@etal.\cst@xspace}}
\newcommand*{\eg}{\cst@eg.}
\newcommand*{\ie}{\cst@ie.}
\newcommand*{\cst@etal}{\cst@latin{et~al}}
\newcommand*{\cst@etc}{\cst@latin{etc}}
\newcommand*{\cst@ie}{\cst@latin{i.e\spacefactor999\relax}}
\newcommand*{\cst@eg}{\cst@latin{e.g\spacefactor999\relax}}

\newenvironment{normalspace}{\begin{singlespacing}}{\end{singlespacing}}
\def\@mydouble{\endsinglespace\large\normalsize\setstretch{1.7}}
\def\@mysingle{\singlespace\large\normalsize\setstretch{1.7}}
\def\@mybibsingle{\singlespace\large\normalsize\setstretch{1}}
\def\@draftdate{{\the\year/\/\two@digits{\the\month}/\/\two@digits{\the\day}}}
\def\@longdraftdate{\today}
\if@dissertation
   \ifdraftcopy
     \gdef\@cappapertype{Dissertation Draft}
   \else
     \gdef\@cappapertype{Dissertation}
   \fi
\else
   \ifdraftcopy
     \gdef\@cappapertype{Thesis Draft}
   \else
     \gdef\@cappapertype{Thesis}
   \fi
\fi
\xdef\@upperpapertype{\uppercase{\@cappapertype}}
\xdef\@papertype{\lowercase{\@cappapertype}}
\ifdraftcopy
   \def\@draftstring{{{\sc Draft of} \@draftdate}}
\else
   \def\@draftstring{}
\fi
\def\@disclaimer{
\ifcommitteedraft\textcolor{red}{\textbf{\uppercase{committee draft}}}\fi
\iflatedraft\textcolor{red}{\textbf{\uppercase{review proof}}}\fi
\ifdraftcopy\textcolor{red}{\textbf{\uppercase{editing draft}}}\fi\\
\vspace*{0.5in}
\textcolor{red}{\textbf{\uppercase{This is a draft copy for review
 and editing purposes only!}}}
\vspace*{10pt}
\setlength\fboxsep{10pt}
\setlength\fboxrule{2pt}
\framebox[1\columnwidth]{\parbox{0.95\columnwidth}{\textcolor{black}
{\textbf{This draft format in no way complies with the University
of Oregon Style Graduate School Style Guide for theses or dissertations.
This draft may employ 10 point fonts for paper conservation, line numbering
for ease of editing, or watermarking and editing notations;  all of which violate
the Graduate School Style Guide for final documents.  See the uothesis.cls
documentation for instructions on producing a properly formatted document.}}}}}
\def\@bounddisclaimer{%
\parbox{0.75\textwidth}{\centering
\begin{spacing}{0.5}
{\tiny This document is for the the personal use of the author and does not comply
with the University of Oregon Graduate School.  Please contact the University
of Oregon Graduate School for information on how to obtain an official copy
of this document.}
\end{spacing}}\\
\vfill\LaTeX
}


\def\covertitle#1{\gdef\@covertitle{#1}\gdef\@uppercovertitle{\begin{doublespace} \uppercase{#1} \end{doublespace}}}
\def\abstracttitle#1{\gdef\@abstracttitle{#1}\gdef\@upperabstracttitle{\uppercase{#1}}}

\def\author#1{\gdef\@author{#1}\gdef\@upperauthor{\uppercase{#1}}}
\def\narrowauthor#1{\gdef\@narrowauthor{#1}\gdef\@uppernarrowauthor{\uppercase{#1}}}

\def\department#1{\gdef\@department{#1}}
\def\narrowdepartment#1{\gdef\@narrowdepartment{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\chair#1{\gdef\@chair{#1}}
\newif\if@cochair
\if@dissertation
  \def\cochair#1{\gdef\@cochair{#1}\@cochairtrue}
  \def\committee#1{\gdef\@committee{#1}}
\fi
\def\graddean#1{\gdef\@graddean{#1}}

\def\degreetype#1{\gdef\@degree{#1}}
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreeyear#1{\gdef\thedegreeyear{#1}}

\long\def\abstract#1{\gdef\@abstract{#1}}
\newif\if@dedication
\long\def\dedication#1{\gdef\@dedication{#1}\@dedicationtrue}
\long\def\acknowledge#1{\gdef\@acknowledge{#1}}

\def\@optional#1{\let\what=\expandafter\csname #1
\endcsname\ifx\what\relax\else\what\fi}
\newcommand{\@sigline}[2]{Approved: \rule{#1}{.4pt}\\*[-0.25\baselineskip]{#2}}
\newcommand{\@Sigline}[1]{Approved: \hrule\vspace*{-\parskip}\vspace*{4pt}{#1}}

\def\cvoneline#1#2{ \\*[\baselineskip] {#1}: {#2}}
\def\cvmultiline#1#2{
\par\vspace{1.5\baselineskip}\noindent
     {#1}:\\*[\baselineskip]\nopagebreak
     \indent\parbox[b]{5in}{#2}}
\newlength{\@cvhangindent}
\setlength{\@cvhangindent}{\parindent}
\addtolength{\@cvhangindent}{1.5em}
\long\def\cvpars#1{\par #1}
\long\def\cvitem#1#2{\par\vspace{1.5\baselineskip}\noindent{#1}:\nopagebreak\par #2}

\gdef\@schools{}
\gdef\@degrees{}
\gdef\@birthplace{}
\gdef\@birthday{}
\gdef\@interests{}
\gdef\@awards{}
\gdef\@experience{}
\gdef\@publications{}
\def\birthplace#1{\gdef\@birthplace{#1}}
\def\birthday#1{\gdef\@birthdate{#1}}
\def\school#1{\expandafter\gdef\expandafter\@schools\expandafter{\@schools\cvpars{#1}}}
\long\def\degree#1{\expandafter\gdef\expandafter\@degrees\expandafter{\@degrees\cvpars{#1}}}
\def\interests#1{\expandafter\gdef\expandafter\@interests\expandafter{\@interests\cvpars{#1}}}
\def\position#1{\expandafter\gdef\expandafter\@experience\expandafter{\@experience\cvpars{#1}}}
\def\award#1{\expandafter\gdef\expandafter\@awards\expandafter{\@awards\cvpars{#1}}}
\def\publication#1{\expandafter\gdef\expandafter\@publications\expandafter{\@publications\cvpars{#1}}}
\setstretch{1.7}
\newcommand{\@normalheaderdims}{
\textheight 620pt
\headheight 14pt
\headsep 14pt}
\ifbound
\oddsidemargin 0.6in
\evensidemargin 0.6in
\textwidth 5.8in
\footskip 0.5in
\footnotesep 15pt
\parindent 24pt
\topmargin 0in
\else
\oddsidemargin 0.25in
\evensidemargin 0.25in
\textwidth 6in
\footskip 0.25in
\footnotesep 15pt
\parindent 24pt
\topmargin 0in
\fi
\@normalheaderdims
\def\@fromtopskip#1{
\@tempdima=#1
   \advance\@tempdima by-1in
   \advance\@tempdima by-\topmargin
   \advance\@tempdima by-\headheight
   \advance\@tempdima by-\headsep
   \advance\@tempdima by-\baselineskip
   \advance\@tempdima by12pt
   \hbox to0pt{}\nointerlineskip\vskip\@tempdima}

\setcounter{tocdepth}{1}
\newcounter{@shownumdepth}
\if@gsmodern
  \setcounter{@shownumdepth}{2}
\else
\if@numsections
   \setcounter{@shownumdepth}{2}
\else
   \setcounter{@shownumdepth}{0}
   \setcounter{secnumdepth}{1}
\fi
\fi
\def\@emit#1{\if@filesw\immediate\write\@mainaux{#1}\fi}
\hyphenpenalty=500000
\tolerance=5000
\widowpenalty=10000
\clubpenalty=10000
\raggedbottom

\def\@maketitlepage{
\newpage
\thispagestyle{empty}
\ifdraftcopy\linenumbers\fi
\begin{center}
\vspace*{0.25in}
\doublespacing
\@uppercovertitle
\singlespacing
\vfill
by \\*[\baselineskip]
\@upperauthor\\
\vfil
\ifdraft\@disclaimer\\\fi\vfill
A \@upperpapertype \\*[\baselineskip]
   Presented to the  \@narrowdepartment \\*
   and the Graduate School of the
University of Oregon \\*
   in partial fulfillment of the requirements \\*
   for the degree of \\*
\@degree \\*[\baselineskip]
\@degreemonth ~\thedegreeyear\\
\end{center}}

\def\@makeapprovepage{
\clearpage
\thispagestyle{plain}
\@startchapter{\@upperpapertype\ APPROVAL PAGE}
\begin{spacing}{1}
\vspace*{3ex}
\noindent
Student: \@author\\*[\baselineskip]
Title: \@abstracttitle\\*[\baselineskip]
This \@papertype\ has been accepted and approved
 in partial fulfillment of the requirements for the
\@degree\ degree in the \@narrowdepartment\ by:\\*[\baselineskip]
\begin{tabular}[t]{p{2.25in} p{3.25in}}
\@chair & Chair\\
\if@cochair
\@cochair& Co-chair\\
\fi
\@advisor & Advisor\\
\@committee\\
and & \\ \\
\@graddean & Vice President for Research \& Innovation/ Dean of the Graduate School
\end{tabular}\\*[\baselineskip]
Original approval signatures are on file with the
University of Oregon Graduate School.\\*[\baselineskip]
Degree awarded \@degreemonth ~\thedegreeyear
\end{spacing}}

\def\@makecopyrightpage{
\if@copyright
\clearpage
\thispagestyle{plain}
\@fromtopskip{5in}
\ifbound\else\centerline{\copyright ~\thedegreeyear ~\@author}\fi
\ifbound{\centering\@bounddisclaimer}\else\vfill\fi\vfil
\fi}

\def\@makeabstractpage{
\clearpage
\pagestyle{plain}
\@startchapter{\@upperpapertype\ ABSTRACT}
\begin{spacing}{1}
\vspace*{3ex}
\noindent
\@author\\*[\baselineskip]
\@degree\\*[\baselineskip]
\@department\\*[\baselineskip]
 \@degreemonth ~\thedegreeyear\\*[\baselineskip]
Title: \@abstracttitle\\*[\baselineskip]
\parbox[t]{5in}{\raggedright
\if@cochair
\@sigline{3.5in}{\hspace*{1.5in}\@advisor, Co-chair}\\*[\baselineskip]
\@sigline{3.5in}{\hspace*{1.5in}\@cochair, Co-chair}
\else
\@sigline{3.5in}{\hspace*{1.5in}\@advisor}
\fi}\\*[2\baselineskip]
\end{spacing}
\ifjustified\else\RaggedRight\fi
\@abstract}

\def\@makeackpage{
\clearpage
\thispagestyle{plain}
\@startchapter{ACKNOWLEDGEMENTS}
\vspace*{\baselineskip}
\par
\ifcommitteedraft
\begin{center}\@disclaimer\end{center}
\else
\ifjustified\else\RaggedRight\fi
\@acknowledge
\iflatedraft
\vfill
\begin{center}
\textcolor{red}{\textbf{\uppercase{review proof}}}\\
\end{center}
\fi
\fi}

\def\@makededpage{
\if@dedication
\clearpage
\thispagestyle{plain}
\settowidth{\@tempdima}{\@dedication}
\ifcommitteedraft
\setlength{\@tempdima}{0pt}
\fi
\ifdim\@tempdima<\textwidth
\@fromtopskip{4in}
\@chapterline{}
\else
\@fromtopskip{3in}
\@startchapter{}
\fi
\vspace*{\baselineskip}
\par
\ifcommitteedraft
\begin{center}\@disclaimer\end{center}
\else
\begin{center}
\@dedication
\end{center}
\vfill
\iflatedraft
\begin{center}
\textcolor{red}{\textbf{\uppercase{review proof}}}\\
\end{center}
\fi
\fi
\fi}

\def\@makevita{
\clearpage
\thispagestyle{plain}
\@startchapter{CURRICULUM VITAE}
\begin{singlespacing}
\vspace*{3ex}
\noindent NAME OF AUTHOR:\quad \@author \vskip\baselineskip
%%\noindent PLACE OF BIRTH:\quad \@birthplace \vskip\baselineskip
%%\noindent DATE OF BIRTH:\quad \@birthdate \vskip\baselineskip
\everypar={\hangindent=\@cvhangindent}
\noindent GRADUATE AND UNDERGRADUATE SCHOOLS ATTENDED:
\@schools
\vskip \baselineskip
\noindent DEGREES AWARDED:
\@degrees
\vskip \baselineskip
\noindent AREAS OF SPECIAL INTEREST:
\@interests
\everypar={\parskip=0.75\baselineskip
\hangindent=\@cvhangindent
                \interlinepenalty=\@M}
\cvitem{PROFESSIONAL EXPERIENCE}{\@experience}
\cvitem{GRANTS, AWARDS AND HONORS}{\@awards}
\cvitem{PUBLICATIONS}{\@publications}
\par
\end{singlespacing}}

\def\@maketitlepages{
\pagenumbering{roman}
\@maketitlepage
\@makeapprovepage
\@makecopyrightpage
\@makeabstractpage
\@makevita
\@makeackpage
\@makededpage
\begin{singlespacing}
\clearpage
\@tableofcontents
\ifnofigures\else
\IfFileExists{\jobname.\ext@figure}{\@listoffigures}{\@starttoc{\ext@figure}}
\fi
\ifnotables\else
\IfFileExists{\jobname.\ext@table}{\@listoftables}{\@starttoc{\ext@table}}
\fi
\clearpage
\@normalheaderdims
\clearpage
\end{singlespacing}}

\def\@makedraftcover{
\clearpage
\thispagestyle{empty}
\linenumbers
\begin{center}
\vspace*{0.25in}
{\large \@upperpapertype}\\
\begin{singlespacing}
{\large \@covertitle}\\
\vspace*{\baselineskip}
Draft of \@longdraftdate\\
\@author
\end{singlespacing}
\end{center}
{\small
\begin{singlespacing}
\begin{center}ABSTRACT\end{center}
{\footnotesize \par\@abstract}
\vfill
\begin{center}
\noindent
\@disclaimer\\
\end{center}
\end{singlespacing}}
\clearpage}

\def\maketitle{
\ifdraftcopy
\iflatedraft
\@maketitlepages
\else
\ifcommitteedraft
\@maketitlepages
\else
\@makedraftcover
\pagenumbering{roman}
\listoftodos\clearpage
\@tableofcontents
\ifnofigures\else
\IfFileExists{\jobname.\ext@figure}{\@listoffigures}{\@starttoc{\ext@figure}}
\fi
\ifnotables\else
\IfFileExists{\jobname.\ext@table}{\@listoftables}{\@starttoc{\ext@table}}
\fi
\fi
\fi
\else
\@maketitlepages
\fi
\pagestyle{plain}
\ifjustified\else\RaggedRight\fi
\pagenumbering{arabic}
\setcounter{page}{1}}

\def\@footlines#1{\hbox to\textwidth{#1}}
\ifbound
\def\@footer{\hfill\rm\thepage}
\else
\def\@footer{\hfil\rm\thepage\hfil}
\fi
\def\ps@tocheadings{
\def\@oddfoot{\@footlines{\@footer}}
\def\@oddhead{}
\let\@evenfoot\@oddfoot
\let\@evenhead\@oddhead}
\def\ps@tocextraheadings{
\def\@oddfoot{\@footlines{\@footer}}
\def\@oddhead{{\hbox to\textwidth{Chapter\hfil{Page}}}}
\def\@evenfoot\@oddfoot
\def\@evenhead{{\hbox to\textwidth{Chapter\hfil{Page}}}}
\textheight 620pt
\headheight 14pt
\headsep 14pt}
\def\ps@lofextraheadings{
\def\@oddfoot{\@footlines{\@footer}}
\def\@oddhead{{\hbox to\textwidth{Figure\hfil{Page}}}}
\def\@evenfoot\@oddfoot
\def\@evenhead{{\hbox to\textwidth{Figure\hfil{Page}}}}
\textheight 620pt
\headheight 14pt
\headsep 14pt}
\def\ps@lotextraheadings{
\def\@oddfoot{\@footlines{\@footer}}
\def\@oddhead{{\hbox to\textwidth{Table\hfil{Page}}}}
\def\@evenfoot\@oddfoot
\def\@evenhead{{\hbox to\textwidth{Table\hfil{Page}}}}
\textheight 620pt
\headheight 14pt
\headsep 14pt}
\def\ps@plain{
\def\@oddfoot{\@footlines{\@footer}}
\def\@oddhead{}
\let\@evenfoot\@oddfoot
\let\@evenhead\@oddhead
\textheight 620pt
\headheight 14pt
\headsep 14pt}

\def\@tableofcontents{%
\clearpage
\markboth{Chapter}{Chapter}
\thispagestyle{tocheadings}
\@startchapter{TABLE OF CONTENTS}
\vspace*{14pt}
\noindent
\makebox[\textwidth][l]{Chapter \hfill Page}
\pagestyle{tocextraheadings}\@mysingle\@starttoc{toc}}
\def\@listoffigures{%
\clearpage
\markboth{Figure}{Figure}
\thispagestyle{tocheadings}
\@startchapter{LIST OF FIGURES}
\vspace*{14pt}
\noindent
\makebox[\textwidth][l]{Figure \hfill Page}
\pagestyle{lofextraheadings}\@mydouble\@starttoc{\ext@figure}}
\def\@listoftables{%
\clearpage
\markboth{Table}{Table}
\thispagestyle{tocheadings}
\@startchapter{LIST OF TABLES}
\vspace*{14pt}
\noindent
\makebox[\textwidth][l]{Table \hfill Page}
\pagestyle{lotextraheadings}\@mydouble\@starttoc{\ext@table}}

\if@gsmodern
   \def\numberline#1{\hbox to\@tempdima{\hskip 0.75em #1\hfil}}
\else
   \def\numberline#1{\hbox to\@tempdima{\hfil #1\hskip 0.75em}}
\fi
\def\@dottedtocline#1#2#3#4#5{
   \ifnum #1>\c@tocdepth
\else
    \vskip \z@ \@plus.2\p@
     {\leftskip=#2\relax \rightskip=\@tocrmarg
\parfillskip=-\rightskip
      \parindent=#2\relax \hangindent=1.5em
\singlespace\@afterindenttrue
      \interlinepenalty\@M
      \leavevmode
      \@tempdima=#3\relax
      \advance\leftskip by\@tempdima \null\nobreak
\hskip -\leftskip
      {#4}\nobreak
     \leaders\hbox{$\m@th
         \mkern \@dotsep mu\hbox{.}\mkern
\@dotsep
         mu$}\hfill
      \nobreak
      \hb@xt@\@pnumwidth{\hfil\normalfont
\normalcolor #5}
      \par}
\fi}
\def\@sechack{\relax}
\def\l@chapter#1#2{
   \pagebreak[3]\par\vskip\baselineskip
   \@dottedtocline{0}{0in}{0.5in}{#1}{#2}
   \nopagebreak\par
   \gdef\@sechack{\vskip\baselineskip\gdef\@sechack{\relax}}}
\if@gsmodern
   \def\l@section{\@sechack\@dottedtocline{1}{0.5in}{0.5in}}
\else
\if@numsections
   \def\l@section{
\@sechack\@dottedtocline{1}{0.5in}{0.5in}}
\else
   \def\l@section{
\@sechack\@dottedtocline{1}{0.75in}{0.5in}}
\fi
\fi
\def\l@figure{\@dottedtocline{0}{0in}{0.5in}}%
\def\l@table{\@dottedtocline{0}{0in}{0.5in}}

\def\@chapapp{CHAPTER}
\renewcommand{\thechapter}{\arabic{chapter}}
\def\@makechapterhead#1{{
\centering
\ifnum \c@secnumdepth>\m@ne
\@chapapp{}
\if@appendices
\ifnum 1=\aux@appendices
\ifnum 1=\c@chapter\else
\typeout{warning:
extra appendices; rerun LaTeX}
\thechapter
\fi
\else
\thechapter
\fi
\else
\Roman{chapter}
\fi
\par
\vskip 2ex
\fi
\ifsc\textsc{#1}\else\uppercase{#1}\fi\par\nopagebreak\vskip 4ex}}
\def\@makeschapterhead#1{{
\@startchapter{\ifsc\textsc{#1}\else\uppercase{#1}\fi}\par
\nopagebreak\vskip 4ex}}
\def\chapter{
\clearpage\global\@topnum\z@
\@afterindenttrue\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{
\stepcounter{chapter}
\if@appendices
\protected@edef\@currentlabel
{\csname p@chapter\endcsname\Alph{chapter}}
\else
\protected@edef\@currentlabel
{\csname p@chapter\endcsname\Roman{chapter}}
\fi
\typeout{[#1]}
\if@appendices
\ifnum\c@chapter=1
\ifnum\aux@appendices=1
\addtocontents{toc}{
\protect\pagebreak[3]\protect\vspace{3ex}
\protect\nopagebreak\protect\noindent
{}\protect\nopagebreak}
\else
\addtocontents{toc}{
\protect\pagebreak[3]\protect\vspace{3ex}
\protect\nopagebreak\protect\noindent
{APPENDICES}\protect\nopagebreak}
\fi
\fi
\fi
\@emit{\string\global\string\aux@appendices=\number\c@chapter}
\ifnum \c@secnumdepth >\m@ne
\if@appendices
\ifnum\aux@appendices=1
\addcontentsline{toc}{chapter}
{APPENDIX:
\ifsc\textsc{#1}\else\uppercase{#1}\fi}
\else\ifnum\aux@appendices > 1
\addcontentsline{toc}{chapter}
{\protect\number@appendix{\number\c@chapter
}{\Alph{chapter}.}
\ifsc\textsc{#1}\else\uppercase{#1}\fi}
\fi\fi
\else
\addcontentsline{toc}{chapter}
{\protect\numberline{\Roman{chapter}.}\ifsc\textsc{#1}
\else\uppercase{#1}\fi}
\fi
\fi
\chaptermark{\ifsc\textsc{#1}\else\uppercase{#1}\fi.}
\if@twocolumn
\@topnewpage[\@makechapterhead{\ifsc\textsc{#2}
\else\uppercase{#2}\fi}]
\else
\@makechapterhead{\ifsc\textsc{#2}\else\uppercase{#2}\fi}
\@afterheading
\fi}
\def\@schapter#1{
\if@twocolumn
\@topnewpage[\@makeschapterhead{\ifsc\textsc{#1}\else
\uppercase{#1}\fi}]
\else
\@makeschapterhead{\ifsc\textsc{#1}\else\uppercase{#1}\fi}
\@afterheading
\fi}
\def\chapter{
\clearpage\global\@topnum\z@
\@afterindenttrue \secdef\@chapter\@schapter}
\def\@chapterline#1{\centerline{#1}}
\def\@startchapter#1{\@chapterline{#1}}

\def\@underbar#1{{$\setbox0=\hbox{#1}\dp0=0pt\underline{\box0}$}}
\def\@startsection#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
\par \@tempskipa #4\relax
    \@afterindenttrue
    \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
    \if@nobreak
\everypar{}
\else
      \addpenalty{\@secpenalty}\addvspace{\@tempskipa}
\fi
\@ifstar{\@ssect{#2}{#3}{#4}{#5}{#6}}{\@dblarg{
\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sect#1#2#3#4#5#6[#7]#8{
      \if@gsmodern
        \refstepcounter{#1}
        \edef\@svsec{\csname the#1\endcsname~~}
      \else
\if@numsections
        \refstepcounter{#1}
        \edef\@svsec{\csname the#1\endcsname~~}
      \else
        \ifnum #2>\c@@shownumdepth
          \def\@svsec{}
\else
          \edef\@svsec{\csname the#1\endcsname\hskip 1em }
\fi
        \ifnum #2>\c@secnumdepth\else\refstepcounter{#1}\fi
      \fi
\fi
      \@tempskipa #5\relax
       \ifdim \@tempskipa>\z@
         \if@gsmodern
           \begingroup
             \@hangfrom{{\bf#6\relax\hskip #3\relax}}{\bf\@svsec{#8}}
             \interlinepenalty \@M
           \endgroup
         \else
\if@numsections
           \begingroup #6\relax
     \@hangfrom{#6\relax\hskip #3\relax}{
\ifnum #2=1 \bf\else
\ifnum #2=3 \it\else\fi\fi
\interlinepenalty \@M
       \ifnum #2=1 \@svsec{#8}\else
\ifnum #2=2 \@underbar{#8}\else#8\fi\fi
             \par}
             \interlinepenalty \@M
           \endgroup
         \else
   \begingroup #6\relax
     \@hangfrom{\hskip #3\relax\@svsec}{
\ifnum #2=1 \bf\else
\ifnum #2=2 \it\else\fi\fi
\interlinepenalty \@M
       \ifnum #2=3 \@underbar{#8} \else  #8 \fi
     \par}
   \endgroup
         \fi
\fi
        \csname #1mark\endcsname{#7}\addcontentsline{toc}{#1}{
        \ifnum #2>\c@@shownumdepth
\else
\protect\numberline{\csname the#1\endcsname}
\fi#7}
\else
\def\@svsechd{#6\hskip #3\@svsec #8
\csname #1mark\endcsname{#7}\addcontentsline{toc}{#1}{
\ifnum #2>\c@@shownumdepth
\else
                             \protect\numberline{\csname the#1\endcsname}
\fi#7}}
\fi
\@xsect{#5}}
\def\@ssect#1#2#3#4#5#6{\@tempskipa #4\relax
\ifdim\@tempskipa>\z@
\begingroup #5\@hangfrom{\hskip #2}{\interlinepenalty \@M
\ifodd #1
\ifnum #1 >3 \@underbar{#6} \hfil
\else
                       \@underbar{#6}
\fi
\else
                   #6
\fi \par}\endgroup
    \else
\def\@svsechd{#5\hskip #2\relax {#6}}
\fi
\@xsect{#4}}

\if@gsmodern
\def\section{\@startsection{section}{1}{\z@}{3ex}{2ex}{}}
\renewcommand{\thesection}{\thechapter.\arabic{section}.}
\def\subsection{\@startsection{subsection}{2}{\z@}{3ex}{2ex}{}}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{3ex}{2ex}{}}
\renewcommand{\thesubsubsection}{\thesubsection\arabic{subsubsection}.}
\renewcommand{\theequation}{Equation\ \thechapter.\arabic{equation}.}
\else
\if@numsections
\def\section{\@startsection{section}{1}{\z@}{3ex}{2ex}{\centering}}
\renewcommand{\thesection}{\thechapter.\arabic{section}.}
\def\subsection{\@startsection{subsection}{2}{\z@}{3ex}{2ex}{\centering}}
\renewcommand{\thesubsection}{}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{2ex}{2ex}{\centering}}
\renewcommand{\thesubsubsection}{}
\renewcommand{\theequation}{Equation\ \thechapter.\arabic{equation}.}

\else
\def\section{\@startsection{section}{1}{\z@}{3ex}{2ex}{\centering}}
\def\subsection{\@startsection{subsection}{2}{\z@}{3ex}{2ex}{\centering}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{2ex}{2ex}{}}
\fi
\fi

\newcommand{\@bibsection}[1]{
\clearpage
\addcontentsline{toc}{chapter}{#1}
\@startchapter{#1}
\ifnum \c@citation > 0
\centering
\setlength\fboxsep{10pt}
\setlength\fboxrule{2pt}
\begin{center}
\framebox[1\columnwidth]{\parbox{0.95\columnwidth}{\textcolor{red}
{\centering\textbf{There are unresolved citation issues!\\*%
 Number of unresolved citations: \arabic{citation}.\\*%
}}}}
\end{center}
\fi
\singlespacing
\@mybibsingle
\vspace*{3ex}}
\def\thebibliography#1{
\@bibsection{REFERENCES CITED}\list
{[\arabic{enumi}]}{\labelwidth\z@ \itemindent-\parindent
\leftmargin\parindent
\interlinepenalty\@M
\usecounter{enumi}}
\def\newblock{\hskip .11em plus .33em minus -.07em}
\sloppy
\raggedright
\sfcode`\.=1000\relax}
\let\endthebibliography=\endlist
%%\newcommand{\formatbib}{
%% \addcontentsline{toc}{chapter}{REFERENCES CITED}
%% \renewcommand\bibname{REFERENCES CITED}}
\AtEndOfClass{\renewcommand\bibname{REFERENCES CITED}}

\def\thefigure{\@arabic\c@figure}
\def\fnum@figure{FIGURE \thefigure.}
\def\thetable{\@arabic\c@table}
\def\fnum@table{TABLE \thetable}
\if@gsmodern
\else
\def\cl@chapter{\@elt{section}\@elt{footnote}\@elt{equation}}
\fi
\if@gsmodern
\renewcommand{\thefigure}{\thechapter.\arabic{figure}.}
\renewcommand{\thetable}{\thechapter.\arabic{table}.}
\renewcommand{\theequation}{Equation\ \thechapter.\arabic{equation}.}
\fi

\renewcommand{\descriptionlabel}[1]{
\hspace{\labelsep}\textit{#1}}

\newif\if@appendices
\newcount\aux@appendices
\def\number@appendix#1#2{
\ifnum 1=\aux@appendices
\ifnum 1=#1
{\protect\hspace*{0.5in}}
\else
\numberline{#2}
\fi
\else
\numberline{#2}
\fi}
\def\appendix{
\par
\setcounter{chapter}{0}
\def\@chapapp{\uppercase{appendix}}
\def\thechapter{\Alph{chapter}}
\@appendicestrue}

\ifx\@savdim\undefined
\let\@savdim\@savsk
\newskip\@savsk
\fi
\def\@bsphack{\relax
\ifmmode
\else
\@savsk\lastskip
\@savsf
\ifhmode
\spacefactor
\else
\lastpenalty\@savdim\prevdepth\removelastskip%
\fi
\fi}
\def\@esphack{\relax
   \ifmmode
   \else\ifvmode
           \penalty\if@nobreak\@M
                   \else\if@inlabel\@M
                        \else\if@noskipsec\@M
                             \else\@savsf
                             \fi
                        \fi
                   \fi
           \prevdepth\@savdim\vskip\@savsk
        \else
           \spacefactor\@savsf\relax
           \ifdim\@savsk>\z@\ignorespaces
           \fi
        \fi
   \fi}

\def\@@begintheorem#1#2#3{\noindent
\list{}{\rightmargin=\leftmargin
\itemindent=\leftmargin}
\item[\underline{#1\ #2}#3]\hskip
0pt\par\nobreak\ignorespaces}
\def\@begintheorem#1#2{
\@@begintheorem{#1}{#2}{}}
\def\@opargbegintheorem#1#2#3{
\@@begintheorem{#1}{#2}{ (#3)}}
\def\@qed{{\unskip\nobreak
\hfil\penalty50\hskip1em\null\nobreak\hfil
\qedsymbol\parfillskip\z@\finalhyphendemerits0\par}}
\def\@endtheorem{\expandafter
\ifx\csname qedsymbol\endcsname\relax
\else\@qed\fi\endlist}
\def\qedbox{{\mathsurround\z@$\Box$}}
\let\labelitemi=\labelitemii
\let\labelitemii=\labelitemiii
\let\labelitemiii=\labelitemiv
\catcode`\*=11
\let\itemize*=\enumerate
\let\enditemize*=\endenumerate
\@makeother\*
\let\@itemize=\itemize
\def\itemize{
\typeout{Warning: Itemize
deprecated by Grad. School}
\global\let\itemize=\@itemize
\itemize}
\newenvironment{quote*}
{\list{}{\rightmargin\leftmargin}
\item\relax}
{\endlist}
\renewenvironment{quote}
{\begin{quote*}\setstretch{1.7}}
{\end{quote*}}

\newif\if@pagesspecial
\newcommand{\pagesref}[5]{{
\@pagesspecialtrue
\expandafter\ifx\csname r@#1\endcsname\relax
\@pagesspecialfalse\else\fi
\expandafter\ifx\csname r@#2\endcsname\relax
\@pagesspecialfalse\else\fi
\if@pagesspecial
\@tempcnta=\pageref{#1}
\@tempcntb=\pageref{#2}
\ifnum\@tempcnta=\@tempcntb\else\@pagesspecialfalse\fi
\if@pagesspecial
\ifnum\@tempcnta=\c@page
{#5}
\else
\mbox{{#3}\pageref{#1}}
\fi
\fi
\fi
\if@pagesspecial
\else
\mbox{{#4}\pageref{#1}--\pageref{#2}}
\fi}}
\newcommand{\pages}[2]{\pagesref{#1}{#2}
{p.\hspace*{0.2em}}{pp.\hspace*{0.2em}}{this page}}
%% Originally written by Mark VandeWettering
%% Modified by Chet Haase, Christian Frank, Lars Hansen,
%% J. Paul Walser, Bei Li, Bart Massey, et al.
%% 
%% It may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License (LPPL), either version 1.3c of
%% this license or (at your option) any later version.  The latest
%% version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status) by
%% Michael D. Anderson
%% 
%% This work consists of the file  uothesis.dtx and the derived files uothesis.cls,
%% uothesis.ins, and, uothesis.pdf.
%%
%% End of file `uothesis.cls'.
