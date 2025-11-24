%%
%% This is file `exam-n.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% exam-n.dtx  (with options: `package')
%% exam-n: format exam questions
%% Release version 1.1, 2014 May 03.
%%
%%%% File: exam-n.dtx
%%%% Copyright 2005--2014, Norman Gray
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Norman Gray <http://nxg.me.uk>
%%
%% This work consists of the files exam-n.dtx and exam-n.ins,
%% the derived file exam-n.cls,
%% and the associated *.clo files.

%%%% Source: Mercurial revision 6f818b549982, 2014-05-03 13:42 +0100, tag 1.1 + 0
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exam-n}[2014/05/03 1.1]
\typeout{Class: `exam-n 1.1 <2014/05/03>}
 
 
 
\newcount\@draftstatus
\@draftstatus=0 % default is final
\DeclareOption{compose}{\@draftstatus=2
  \@showsolutionstrue
  \@pageperquestiontrue}
\DeclareOption{draft}{\@draftstatus=1
  \@showsolutionstrue
  \@pageperquestionfalse}
\DeclareOption{final}{\@draftstatus=0
  \@showsolutionsfalse
  \@pageperquestionfalse}
\newif\if@psfonts\@psfontsfalse
\DeclareOption{psfonts}{\@psfontstrue}
\DeclareOption{cmfonts}{\@psfontsfalse}
\newcount\examn@mtselect \examn@mtselect=0
\DeclareOption{mathptm}{\@psfontstrue\examn@mtselect=0}
\DeclareOption{mathtime}{\@psfontstrue\examn@mtselect=1}
\DeclareOption{mtpro2}{\@psfontstrue\examn@mtselect=2}
\newif\ifexamn@serif
\examn@seriftrue
\DeclareOption{serif}{\examn@seriftrue}
\DeclareOption{sansserif}{\examn@seriffalse}
\newif\if@showsolutions
\@showsolutionsfalse
\DeclareOption{showsolutions}{\@showsolutionstrue}
\DeclareOption{noshowsolutions}{\@showsolutionsfalse}
\newif\if@pageperquestion
\@pageperquestionfalse
\DeclareOption{pageperquestion}{\@pageperquestiontrue}
\DeclareOption{nopageperquestion}{\@pageperquestionfalse}
\newif\if@perquestionmarks
\@perquestionmarkstrue
\DeclareOption{perquestionmarks}{\@perquestionmarkstrue}
\DeclareOption{noperquestionmarks}{\@perquestionmarksfalse}
\newif\if@showmarktotals
\@showmarktotalstrue
\DeclareOption{showmarktotals}{\@showmarktotalstrue}
\DeclareOption{noshowmarktotals}{\@showmarktotalsfalse}
\newif\if@twosidepages
\@twosidepagesfalse
\DeclareOption{twoside}{\@twosidepagestrue}
\DeclareOption{oneside}{\@twosidepagesfalse}
\newif\if@fleqn
\@fleqnfalse
\DeclareOption{fleqn}{
  \@fleqntrue
  \PassOptionsToPackage{fleqn}{amsmath}
  \PassOptionsToClass{fleqn}{article}
}
\newif\if@fussydescription
\@fussydescriptiontrue
\DeclareOption{sloppydescription}{\@fussydescriptionfalse}
\def\examn@header@shoutformat#1{{\Large\bfseries #1}}
\DeclareOption{mono}{
  \PassOptionsToPackage{monochrome}{color}
  \def\examn@header@shoutformat#1{{\Huge\bfseries #1}}
}
\DeclareOption{colour}{}
\newif\ifbigfont
\bigfontfalse
\DeclareOption{bigfont}{\bigfonttrue}
\PassOptionsToClass{a4paper}{article}
\newtoks\@styleoverrides
\@styleoverrides={}
\def\OverrideFormatting{\@styleoverrides=}
\newtoks\@constantstoks
\def\@@displayconstants{%
  \clearpage
  \begingroup
  \the\@constantstoks
  \endgroup
  \clearpage }
\newtoks\@constantstoks
\@constantstoks={}
\let\@displayconstants\relax
\def\constantssheet{\let\@displayconstants\@@displayconstants
  \@constantstoks=}
\AtBeginDocument{\the\@styleoverrides}
\DeclareOption*{\InputIfFileExists{\CurrentOption.clo}{}
  {\ClassError{exam-n}
    {Bad option \CurrentOption}
    {I don't understand the option \CurrentOption\MessageBreak
      (I didn't find file \CurrentOption.clo, if that's what you meant)}}}
\InputIfFileExists{exam-n.config}{}{}
\ProcessOptions
\if@twosidepages
  \PassOptionsToClass{twoside}{article}
\else
  \PassOptionsToClass{oneside}{article}
\fi
\PassOptionsToClass{12pt}{article}
\PassOptionsToPackage{final}{graphicx}
\PassOptionsToPackage{final}{pdfpages}
\def\UniLogo#1{\vbox to 15.5mm{%
    \hrule
    \vss\hbox to #1{% Aspect ratio of logo is 100x31
      \hss no logo available\hss
    }%
    \vss
    \hrule}}
\RequirePackage[english]{babel} % UK hyphenation
\RequirePackage{amsmath}
\RequirePackage{color}
\LoadClass{article}
\def\examn@setdocident{%
  \begingroup
    % yes, a big \ifcase would be more straightforward;
    % no, that wouldn't be any fun at all
    % (also it ends up looking messy and even tricksier).
    \def\@step##1##2\@nil{\advance\@tempcnta##1 \def\@tempa{##2}}
    \def\@tempa{{31}{28}{31}{30}{31}{30}{31}{31}{30}{31}{30}{31}}%
    \@tempcnta=\day             % day of month
    \@tempcntb=\month           % month of year (unit-offset)
    \loop
      \advance\@tempcntb-1
      \ifnum \@tempcntb>0
        \expandafter\@step\@tempa\@nil
    \repeat
    \@tempcntb=\year            % yes, do calculate leap years
    \divide\@tempcntb 4 \multiply\@tempcntb 4
    \ifnum\@tempcntb=\year
      \ifnum\month>2            % but let's not worry about century years...
        \advance\@tempcnta 1
      \fi
    \fi
    % remove any \\ or ~ in the coursecode fields
    \let\\\space
    \let~\space
    \xdef\examn@docident{% first element is based on uni/school course code
      \ifx\@coursetitle\@empty
        \ifx\@schoolcoursecode\@empty
          exam%
        \else
          \@schoolcoursecode
        \fi
      \else
        \@coursetitle
      \fi
      /\the\@tempcnta           % day-of-year
      -\the\time}               % minutes since midnight
  \endgroup
}
\RequirePackage{ifpdf}
\def\@SetDocumentInfo{%
  \ifpdf
    {\pdfinfo{/Title (\examn@docident)}}%
    % Don't put out an /Author(xxx) info entry -- there may be
    % multiple authors, and it isn't obviously useful
  \fi
}
\AtBeginDocument{\examn@setdocident\@SetDocumentInfo}
\if@psfonts
  \ifcase\examn@mtselect
    \ifexamn@serif
      \RequirePackage{times}
    \else
      \RequirePackage{helvet}
    \fi
    \RequirePackage{mathptm}
    \ClassWarningNoLine{exam-n}{Using mathptm fonts}
  \or % use mathtime fonts
    \RequirePackage[LY1]{fontenc}   % specify text font encoding
    \RequirePackage[LY1,mtbold]{mathtime}   % switch math fonts
    \ifexamn@serif
      \RequirePackage{times}
    \else
      \RequirePackage{helvet}
    \fi
    \ClassWarningNoLine{exam-n}{Using Mathtime fonts}
  \or % use mtpro2 fonts
    \RequirePackage[T1]{fontenc}
    \RequirePackage{textcomp}
    \ifexamn@serif
      \renewcommand\rmdefault{ptm} % the default
    \else
      \RequirePackage[scaled=0.9]{helvet}
      \renewcommand\rmdefault{phv}
    \fi
    \RequirePackage[mtpbb]{mtpro2}
    \ClassWarningNoLine{exam-n}{Using MTPro2 fonts}
  \else
    \ClassError{exam-n}{Impossible value of mtselect: \examn@mtselect}
  \fi
\else
  \ClassWarningNoLine{exam-n}{Using CM fonts}
\fi
\def\examn@bodyfontchange{}
\ifexamn@serif \else
  \ClassWarningNoLine{exam-n}{Using sans serif fonts}
  \DeclareRobustCommand\normalfont
    {\usefont\encodingdefault\sfdefault\seriesdefault\shapedefault \relax}
\fi
\ifbigfont
  \def\examn@bodyfontchange{
    \renewcommand\normalsize{%
      \@setfontsize\normalsize{36}{42}%
      \abovedisplayskip 36\p@ \@plus7\p@ \@minus17.5\p@
      \abovedisplayshortskip \z@ \@plus10.5\p@
      \belowdisplayshortskip 21\p@ \@plus10.5\p@ \@minus10.5\p@
      \belowdisplayskip \abovedisplayskip
      \let\@listi\@listI}
    \parindent=48pt
    \parskip=36pt
    % Redefine \FormatPartMarks so that it doesn't push the text off the paper
    \def\FormatPartMarks##1{
      \setbox0=\hbox{\hskip 1em \textbf{[##1]}}
      \@tempdima=0.8\marginsize
      \ifdim\wd0>\@tempdima
        \advance\@tempdima -\wd0
        \hbox to 0pt{\hskip\@tempdima \box0\hss}%
      \else
        \hbox to 0pt{\box0\hss}
      \fi}}
\fi
\def\@exambanner{}
\def\exambanner{\def\@exambanner}

\def\@schoolcoursecode{}
\def\schoolcoursecode{\def\@schoolcoursecode}

\def\@universitycoursecode{}
\def\universitycoursecode{\def\@universitycoursecode}

\def\@paperident{}
\def\paperident{\def\@paperident}

\def\@examdate{}
\def\examdate{\def\@examdate}

\def\@examtime{}
\def\examtime{\def\@examtime}

\def\@coursetitle{}
\def\coursetitle{\def\@coursetitle}
\def\@degreedescriptions{}
\def\degreedescriptions{\def\@degreedescriptions}
\def\@displaydegreedescriptions{%
  \let\@tempb\leavevmode
  \def\dd##1\\{%
    \def\@tempa{##1}%
    \ifx\@tempa\@empty
      \let\next\relax
    \else
      \@tempb\hbox{##1}\let\next\dd
    \fi
    \def\@tempb{\discretionary{}{}{\kern0.5em--\kern0.5em}}%
    \next}
  \expandafter\dd\@degreedescriptions\\}
\def\@rubric{}
\def\rubric{\long\def\@rubric}
\def\norubric{\let\@rubric\@nnil}

\def\@baserubric{%
\textbf{Answer each question in a separate booklet}\par
Candidates are reminded that devices able to store or display text or
images may not be used in examinations without prior arrangement.
\if@perquestionmarks
  \par
  Approximate marks are indicated in brackets as a guide for candidates.
\fi
}
\def\baserubric{\long\def\@baserubric}
\def\@numquestions{}
\def\numquestions{\def\@numquestions}
\def\CheckTotalQuestions{%
  \ifnum\@draftstatus < 2
    \ifx\@numquestions\@empty \else
      \ifnum\questionnumber=\@numquestions \else
        \ClassWarning{exam-n}
          {Expected \@numquestions\space questions, got \the\questionnumber!}
        \ifnum\@draftstatus > 0 % draft mode
          \begin{center}
            \textbf{\highlighted{Expected \@numquestions\space questions, got \the\questionnumber}}
          \end{center}
        \fi
      \fi
    \fi
  \fi
}
\if@fleqn
  \mathindent\parindent
  \@mathmargin=\parindent
\fi
\newdimen\marginsize
  \marginsize=35mm

\headheight=15pt
\headsep=15pt
\definecolor{meta}{rgb}{0.7,0.2,0.2}
\def\highlighted{\textcolor{meta}}
\definecolor{solutiontext}{rgb}{0.2,0.2,0.5}
\definecolor{discreettext}{rgb}{0.6,0.6,0.6}
\newcommand\@settextblock[1]{
  \textwidth=\paperwidth
    \advance\textwidth -2\marginsize
  \textheight=\paperheight
    \advance\textheight -2\marginsize
  \oddsidemargin=\marginsize
    \advance\oddsidemargin -1in
    \advance\oddsidemargin -#1
  \evensidemargin=\oddsidemargin
  \topmargin=\marginsize
    \advance\topmargin -\headheight
    \advance\topmargin -\headsep
    \advance\topmargin -1in
  \marginparwidth=\marginsize
    \advance\marginparwidth -1.5cm
    \advance\marginparwidth #1
%%     \typeout{paperwidth=\the\paperwidth, paperheight=\the\paperheight,
%%     textwidth=\the\textwidth, textheight=\the\textheight,
%%     oddsidemargin=\the\oddsidemargin,
%%     headheight=\the\headheight, headsep=\the\headsep, topmargin=\the\topmargin}
  \marginparsep=0.5cm
}

\ifnum\@draftstatus > 0
  \@settextblock{2cm}
\else
  \@settextblock{0pt}
\fi
\let\leftnudge\@settextblock
\renewcommand\@marginparreset{%
  \reset@font
  \@setminipage
  \raggedright
  \small
}
\setlength{\parindent}{2em}
\setlength{\parskip}{\bigskipamount}
\ifcase\@draftstatus % Final version
  \def\ClosingText{
    \begin{center}\textbf{End of Paper}\\\end{center}
    \mark{END}}
\or % Draft version
  \def\ClosingText{
    \begin{center}\textbf{End of Draft Paper}\\\end{center}
    \mark{END}}
\else % Compose version (nothing, because this would be on a page by itself)
  \def\ClosingText{\mark{END}}
\fi
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\setlength{\headwidth}{\textwidth}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhead{}
\fancyfoot{}
\fancyfoot[L]{{\tiny\textcolor{discreettext}{%
  \ifx\@paperident\@empty\examn@docident\else\@paperident\fi
}}}
\fancyfoot[R]{%
  \def\@tempa{END}
  \xdef\examn@topmark{\botmark}
  \ifx\examn@topmark\@empty
    \formatcontinuations{Paper continued over}%
  \else\ifx\examn@topmark\@tempa
    \formatcontinuations{END}
  \else
    \formatcontinuations{Q\,\examn@topmark\ continued over\dots}%
  \fi\fi
}
\fancyfoot[C]{\thepage/\pageref{lastpage}}
\def\examn@topmark{}
\ifnum\@draftstatus=0
  \fancyhead[L]{%
    \ifx\examn@topmark\@empty \else
      \formatcontinuations{Q\,\examn@topmark\ continued}%
    \fi
  }
\fi
\def\examn@bighead#1{\strut\vbox to 0pt{\vss\hbox{\examn@header@shoutformat{#1}}\vskip 10mm}}
\ifnum\@draftstatus = 1
  \if@showsolutions
   \fancyhead[C]{\examn@bighead{\highlighted{DRAFT + SOLUTIONS, p\thepage/\pageref{lastpage}}}}
  \else
   \fancyhead[C]{\examn@bighead{\highlighted{DRAFT, p\thepage/\pageref{lastpage}}}}
 \fi
\else
  \if@showsolutions
    % Add a very prominent banner
    \fancyhead[C]{\examn@bighead{\highlighted{SHOWING SOLUTIONS}}}
  \fi
\fi
\def\formatcontinuations#1{\textbf{#1}}
\def\WriteLastPageLabel{\label{lastpage}}
\def\ps@titlepage{
  \def\@oddhead{}
  \def\@oddfoot{\xdef\examn@topmark{\botmark}}
}
\renewcommand\maketitle{
  \ifnum\@draftstatus < 2       % final or draft version
    \ifx\@examdate\@empty
      \ClassError{exam-n}
        {No exam date given}
        {Specify an exam date using \protect\examdate}
    \fi
    \ifx\@examtime\@empty
      \ClassError{exam-n}
        {No exam time given}
        {Specify an exam time using \protect\examtime}
    \fi
    \ifx\@exambanner\@empty
      \ClassError{exam-n}
        {No exam banner given}
        {Specify an exam banner (eg Examination for the degree...) using \protect\exambanner}
    \fi
    \if@fussydescription
      \ifx\@schoolcoursecode\@empty
        \ClassError{exam-n}
          {No school course code given}
          {Specify a school course code (eg P304H) using \protect\schoolcoursecode}
      \fi
      \ifx\@universitycoursecode\@empty
        \ClassError{exam-n}
          {No paper title given}
          {Specify a university course code (eg PHYS3031) using \protect\universitycoursecode}
      \fi
      \ifx\@coursetitle\@empty
        \ClassError{exam-n}
          {No course title given}
          {Specify a course title (eg Quantum Mechanics) using \protect\coursetitle}
      \fi
      \ifx\@degreedescriptions\@empty
        \ClassError{exam-n}
          {No paper subject given}
          {Specify a 'degree description' (eg Physics 3) using \protect\degreedescriptions}
      \fi
      \ifx\@rubric\@empty
        \ClassError{exam-n}
          {No rubric given}
          {Specify a rubric using \protect\rubric, or declare its absence with \protect\norubric}
      \fi
    \fi
    \thispagestyle{titlepage}
    \begin{center}
      \null
      \vskip -1.5cm
      \if@showsolutions
        \nointerlineskip
        \vbox to 0pt{\vss
          \examn@header@shoutformat{\shout{SHOWING SOLUTIONS}}
          \vskip 1.5\bigskipamount}
      \else
        \ifnum\examn@shoutcounttotal>0
          \typeout{SHOUTS: \the\examn@shoutcounttotal}
          \nointerlineskip
          \vbox to 0pt{\vss
            \examn@header@shoutformat
              {\highlighted{SHOUTS: \the\examn@shoutcounttotal\ (see end)}}
            \vskip 1.5\bigskipamount}
        \fi
      \fi
      \nointerlineskip
      \hbox to \textwidth{% date and time
        \vbox to 0pt{\vskip-2ex \UniLogo{50mm}\vss}
        \hss
        \setbox0=\hbox{\vtop{% \vtop or \vbox here?
          % Opinions differ:
          % This week, Norman prefers \vtop because it gives a cleaner top line.
          \hsize=0.5\textwidth
          \leftskip=0pt plus1fil \rightskip=0pt \parfillskip=0pt
          \baselineskip=2.5ex
          \parskip=0.25ex
          \let\\\par
            \ifx\@examdate\@empty
              \shout{missing exam date}
            \else
              \@examdate
            \fi
            \par
            \ifx\@examtime\@empty
              \shout{missing exam time}
            \else
              \@examtime
            \fi
            \par}}
        \dp0=0pt
        \box0}
      \vskip4\bigskipamount
      %\UoGname\\[\medskipamount]
      {\uppercase\expandafter{\@exambanner}}\\[\medskipamount]
      \vbox{}\hrule
      \ifx\@degreedescriptions\@empty\else
        \@displaydegreedescriptions\\
      \fi
      \vskip 2\baselineskip plus 0.3fil
      \def\@tempa{\def\@tempa{\vskip 0.5\baselineskip}}
      \ifx\@schoolcoursecode\@empty\else
        \@tempa
        {\large\textbf{\@schoolcoursecode}}
      \fi
      \ifx\@universitycoursecode\@empty\else
        \@tempa
        {\large\textbf{[~\@universitycoursecode~]}}
      \fi
      \ifx\@coursetitle\@empty\else
        \setbox0=\hbox{\Huge\textbf{\@coursetitle}}
        \ifdim\wd0>\columnwidth
          \setbox0=\hbox{\LARGE\textbf{\@coursetitle}}
          \ifdim\wd0>\columnwidth
            % we're not going any smaller than this
            \setbox0=\vbox{\hsize\columnwidth
              \Large\bfseries
              \@coursetitle}
          \fi
        \fi
        \vskip 1.2\ht0          % generous vertical skip, size-dependent
        \ifhbox0
          \hbox to \columnwidth{\hss\box0\hss}
        \else
          \box0
        \fi
      \fi
      \vskip 2\baselineskip plus 0.3fil
      \parindent=0pt
      \parskip=0.5\baselineskip
      \ifbigfont
        % Don't put the rubric here (see below)
      \else
        \ifx\@rubric\@empty\else
          \ifx\@rubric\@nnil\else
            % if there's a rubric, separate from the base rubric, then
            % separate the two with an hrule (the per-exam rubric
            % presumably represents special instructions for this exam,
            % so should be highlighted
            \vbox{\let\emph\textbf
              \@rubric
              \par}
            \vskip2\baselineskip
            \hrule
            \vskip1.5\baselineskip
          \fi
        \fi
      \ifx\@baserubric\@empty \else
        \@baserubric \par
      \fi
    \fi % end \ifbigfont\else
    \end{center}
    \vskip 2\baselineskip plus 0.6fil % \newpage is {\vfil\penalty-\@M}
    \vbox to 0pt{\hbox to \textwidth{%
        \tiny
        \textcolor{discreettext}
          {\hfil\ifx\@paperident\@empty\examn@docident\else\@paperident\fi\hfil}}\vss}
    \penalty -\@M
    \@displayconstants
  \else % compose version
   \begin{tabular}{rl}
      \textbf{Exam}&
        {\def\\{ / }\@schoolcoursecode}\\
      \textbf{Course codes}&
        \@universitycoursecode\\
      %% \textbf{Subject}&
      %%   {\def\and{and}\begin{tabular}
      %% {\@degreedescriptionstemplate}\@degreedescriptions
      %% \end{tabular}}\\
      \textbf{Date \& time}&
        {\def\\{, }\@examdate, \@examtime}\\
    \end{tabular}
  \fi
  \ifcase\@draftstatus
    % Final version
    \typeout{Exam \@schoolcoursecode: FINAL VERSION}
  \or % Draft version
    \typeout{Exam \@schoolcoursecode: DRAFT VERSION}
  \else % Compose version
    \typeout{Exam \@schoolcoursecode: COMPOSE VERSION}
  \fi
  %
  \examn@bodyfontchange
  \normalfont\normalsize
  \ifbigfont
    % Put the rubric on a second page, in the 'huge' size.
    \begin{center}
      \parskip=18pt
      \let\emph\textbf \@rubric\par
      \vskip\baselineskip
      \hrule
      \vskip\baselineskip
      \ifx\@baserubric\@empty \else
        \@baserubric \par
      \fi
    \end{center}
    \newpage
  \fi
}
\setcounter{secnumdepth}{0}
\renewcommand\section{
  \@ifundefined{@currentquestion}\@@section
    {\ClassError{exam-n}{Misplaced section}
      {You can't have a section inside a question;\MessageBreak
        move it before the {question} environment starts}}}
\newcommand\@@section{\@startsection{section}{1}{\z@}%
                        {-3.5ex \@plus -1ex \@minus -.2ex}%
                        {1ex \@plus.1ex \@minus 0.5ex}%
                        {\fmt@section}}
\def\fmt@section#1{%
  \examn@prequestionspace{}
  \hbox to \textwidth{{\hfil\bfseries SECTION #1\hfil}}%
}
\renewcommand\subsection{
  \@ifundefined{@currentquestion}\@@subsection
    {\ClassError{exam-n}{Misplaced subsection}
      {You can't have a subsection inside a question;\MessageBreak
        move it before the {question} environment starts}}}
\newcommand\@@subsection{\@startsection{subsection}{2}{\z@}
                         {-2ex \@plus -3ex \@minus -0.2ex}
                         {0.5ex \@plus .1ex \@minus 0.1ex}
                         {\fmt@subsection}}
\def\fmt@subsection#1{%
  \examn@prequestionspace{}
  \noindent\textbf{#1}}
\let\sectionmark\@gobble
\let\subsectionmark\@gobble
\def\@badsection#1#2{\ClassError{guexam}{Bad section}
  {The exam class goes not support subdivisions like #1{#2}}}
\def\subsubsection{\@badsection{subsubsection}}
\def\paragraph{\@badsection{paragraph}}
\def\subparagraph{\@badsection{subparagraph}}
\newcount\marktotal           % number of marks accumulated so far
\newcount\markgoal            % number of marks we should have in the end

\newcount\questionnumber
\questionnumber=0
\newcounter{partnumber}
\renewcommand\part{%
  \if@nobreak \else
    \par
    \@nobreakfalse
  \fi
  \ifvmode
    \vskip 0pt plus 4\bigskipamount
    \penalty-50
  \fi
  \stepcounter{partnumber}%
  \noindent\FormatPartNumber
}
\newcommand\FormatPartNumber{\hbox to \parindent{(\alph{partnumber})\hss}}
\newif\if@newpagebeforequestion
\if@pageperquestion
  \@newpagebeforequestiontrue
\else
  \@newpagebeforequestionfalse
\fi
\def\examn@prequestionspace#1{%
  \if@pageperquestion
    \if@newpagebeforequestion
      % Add all the stretchability here, rather than stretching out
      % displays and lists above this on the page.
      \newpage
      % Clear the \@newpagebeforequestion flag, to suppress the action
      % of any following calls to \examn@prequestionspace, until the end
      % of the next question.
      \global\@newpagebeforequestionfalse
    \fi
  \else
    #1%
  \fi
}
\long\def\examn@endquestion#1{%
  \mark{}         % the position of this call is slightly sensitive (but this works)
  \if@pageperquestion
    \global\@newpagebeforequestiontrue
  \fi
  #1
  \@nobreakfalse
  \everypar{}
}
\def\partmarks{%
  \@ifstar{\@tempswatrue \@partmarks}{\@tempswafalse \@partmarks}}
\newdimen\@partmarksspace
  \@partmarksspace=2em % default value
\def\@partmarks#1{%
  \if@perquestionmarks
    \if@insolution
      % visual display only -- doesn't count towards mark total
      \setbox0=\vbox to 0pt{\vss
        \hbox to \textwidth{\hfil\hbox to 0pt{\quad\small[\dots #1]\hss}}
        \vskip0.25ex }
      % the next line is probably unnecessary, but guarantees that box0
      % has zero depth, so no extra vertical space appears because of
      % this new box
      \dp0=0pt
      \ifvmode
        \box0
      \else
        \vadjust{\nointerlineskip\box0}%
      \fi
    \else
      \global\advance\marktotal #1
      \if@tempswa
        \setbox0=\vbox to 0pt{\vss
          \hbox to \textwidth{\strut\hfill\FormatPartMarks{#1}}%
          \vskip 1\baselineskip} % vskip means box has zero depth
        \ifvmode
          \box0
        \else
          \vadjust{\box0}%
        \fi
      \else
        \ifdim\@partmarksspace > 0pt
         {\unskip\nobreak\hfil\penalty50 \hskip\@partmarksspace
            \hbox{}\nobreak\hfil\FormatPartMarks{#1}%
          \parfillskip=0pt \finalhyphendemerits=0 \par}
        \else
          \unskip\nobreak\hfill\FormatPartMarks{#1}\par
        \fi
      \fi
    \fi
  \else
    \ClassError{exam-n}{\string\partmarks\ is not compatible with
      noperquestionmarks}{Either remove \string\partmarks\ or remove
      the noperquestionmarks option}
  \fi
  \ignorespaces
}
\@endparpenalty=\@M

\newcommand\FormatPartMarks[1]{\hbox to 0pt{\hskip1em \textbf{[#1]}\hss}}
\@partmarksspace=\z@
\newcommand\question{%
  \if@perquestionmarks
    \let\ex@next\@questionmarks
  \else
    \let\ex@next\@questionnomarks
  \fi
  \@ifnextchar[%]
    {\ex@next}{\ex@next[]}}
\def\@questionmarks[#1]#2{%
  \def\@tempa{#2}% marks available for this question
  \ifx\@tempa\@empty
    \ClassError{exam-n}
      {Missing mark goal for question (using 0 instead)}
      {Missing mark goal for question (using 0 instead)}
    \def\@tempa{0}
 \fi
 \ifx\@includequestionoverridenumber\@empty
    \do@question{#1}{\@tempa}%
  \else
    \ClassWarning{exam-n}{Forcing question number
      \@includequestionoverridenumber, in included question #2}
    \do@question{\@includequestionoverridenumber}{\@tempa}%
  \fi
}
\def\@questionnomarks[#1]{%
  \do@question{#1}{0}%
}
\newcount\ex@nmcq
\ex@nmcq=-1
\newcount\ex@mcqnanswer
\def\multiplechoiceanswers#1{\ex@nmcq=#1}
\newenvironment{mcq}
   {\parindent=0pt
    \ifnum\ex@nmcq<1
      \ClassError{exam-n}
        {mcq environment without preceding multiplechoiceanswers declaration}
        {The mcq environment may only be used if the number of
          permitted MCQ answers has been declared with \string\multiplechoiceanswers}
    \else
      \def\item{\@tempswafalse\ex@mcqitem}
      \def\answer{\@tempswatrue\ex@mcqitem}
      \ex@mcqi=0
      \ex@mcqnanswer=0
      \do@question{}{1}
    \fi}
   {\par
    \ifnum\ex@mcqi<\ex@nmcq
      \ClassWarning{exam-n}{Too few potential answers in MCQ \the\questionnumber}
      \@shout{Too few potential answers in MCQ \the\questionnumber}
      \ifnum\@draftstatus > 0
        \highlighted{TOO FEW ANSWERS}\par
      \fi
    \fi
    \ifcase\ex@mcqnanswer
      \ClassWarning{exam-n}
        {No correct MCQ answer provided in question \the\questionnumber}
      \@shout{No correct MCQ answer provided in question \the\questionnumber}
      \ifnum\@draftstatus > 0
        \highlighted{NO CORRECT ANSWER PROVIDED}\par
      \fi
    \or
       % ex@mcqanswer=1: correct -- do nothing
    \else
      \ClassWarning{exam-n}
        {Too many correct MCQ answers provided in question \the\questionnumber}
      \@shout{Too many correct MCQ answers provided in question \the\questionnumber}
      \ifnum\@draftstatus > 0
        \highlighted{TOO MANY CORRECT ANSWERS}\par
      \fi
    \fi
    \examn@endquestion{\relax}
   }
\newcount\ex@mcqi
\def\ex@mcqitem{%
  \par
  \ifnum\ex@mcqi=0
    % first one
    \smallskip
    \parskip=0pt   % nothing fancy -- we assume these won't spread
                   % over more than one line
    \advance\leftskip by 2em
  \fi
  \advance\ex@mcqi by 1
  \noindent
  \if@tempswa
    % the correct answer
    \advance\ex@mcqnanswer 1
    \if@showsolutions
      \hbox to 0pt{\hss \highlighted{$\Longrightarrow$ \@Alph\ex@mcqi . }}%
    \else
      \hbox to 0pt{\hss \@Alph\ex@mcqi . }%
    \fi
  \else
    \hbox to 0pt{\hss \@Alph\ex@mcqi . }%
  \fi
}
\def\do@question#1#2{%
  \par % get that out of the way...
  \markgoal=#2
  \marktotal=0
  \ifx\examn@questionpreamble\@empty
  \else
    \vspace{2\baselineskip}
    \hbox to \textwidth{\hfil\textbf{\examn@questionpreamble}\hfil}
    \questionpreamble{}
  \fi
  \setcounter{partnumber}{0}
  \global\advance\questionnumber 1
  \examn@prequestionspace{%
    \if@nobreak
      % after a heading (or something like that)
    \else
      % we're not forcing a new page here, but this would be a good point to choose
      \vskip 2\baselineskip plus 8\baselineskip
      \penalty-200
    \fi
  }
  \if@questionnumberchecks
    \def\@tempa{#1}% intended question number
    \ifx\@tempa\@empty
      % no optional argument -- easy
      \def\@currentquestion{\the\questionnumber}
    \else
      \setbox0=\hbox{\@tempcnta=#1}
      \ifdim\wd0>0pt
        \ClassWarning{exam-n}{Non-numeric question number, #1.
          You probably want to put \string\QuestionNumberChecksOff in the preamble}
        \par\textbf{Non-numeric question number, #1.
          You probably want to put \hbox{$\backslash$\ttfamily QuestionNumberChecksOff} in the preamble}
          (the formatting below may be messed up).\par
      \fi
      \ifcase\@draftstatus
        % Final version
        \@tempcnta=#1
        \ifnum\questionnumber=\@tempcnta
          \def\@currentquestion{#1}
        \else
          \ifx\@includequestionoverridenumber\@empty
            \ClassError{exam-n}
              {\string\question[#1] is actually question \the\questionnumber!}
              {The question in {question} environment number
                \the\questionnumber\space is specified as
                \string\question[#1].\MessageBreak
               This is an error in 'final' mode.\MessageBreak
               Perhaps you need \string\QuestionNumberChecksOff?}
            \def\@currentquestion{???}
          \else
            \ClassWarning{exam-n}{Forcing question number \@includequestionoverridenumber,
              in {question} environment number \the\questionnumber}
            \edef\@currentquestion{\@includequestionoverridenumber}% this doesn't seem to expand in fact!
            \message{current question=\@currentquestion, override \@includequestionoverridenumber}
          \fi
        \fi
      \or
        % Draft version -- let the given number override
        % \the\questionnumber, but warn if there's a difference.
        \@tempcnta=#1
        \ifnum\questionnumber=\@tempcnta \else
          \ClassWarning{exam-n}
            {\string\question[#1] is actually question \the\questionnumber!}
        \fi
        \def\@currentquestion{#1}
      \else
        % compose mode -- argument overrides without question
        \def\@currentquestion{#1}
      \fi
    \fi
  \else
    % skip question-number checks
    \def\@tempa{#1}% intended question number
    \ifx\@tempa\@empty
      % no optional argument -- this is possibly an error, so warn
      \ClassWarning{exam-n}{\string\QuestionNumberChecksOff\ is in
        force, but this question has no [number]}
      \def\@currentquestion{\the\questionnumber}
    \else
      \typeout{Forcing question \the\questionnumber\space to be #1}
      \def\@currentquestion{#1}
    \fi
  \fi
  \everypar{\setbox0=\lastbox % discard \box0
    \FormatQuestionNumber
    \mark{\@currentquestion}%
    \everypar{}}
}
\newcommand\FormatQuestionNumber
  {\hbox to 0pt{\hss \textbf{\@currentquestion}\hskip1em}}
\def\endquestion{%
  \ifnum\marktotal=\markgoal
    \typeout{Question \@currentquestion\if@perquestionmarks, \the\marktotal\space marks\fi}
    \iffalse % all of this is redundant, and ends up too shouty
    \ifcase\@draftstatus
      % Final version -- do nothing
      \relax
    \or % draft version
      \relax                    % no, the above is too much; do nothing
    \else % compose version
      \par
      \hfil\textbf{\highlighted{[Q\,\@currentquestion\if@perquestionmarks, \the\marktotal\space marks\fi]}}%
        \break
    \fi
    \fi
  \else
    \ClassWarning{exam-n}
      {Question \@currentquestion\space has a total of \the\marktotal\space marks,
        \MessageBreak
        when it should have \the\markgoal}
    \begin{center}
      \edef\@tempa{Question \@currentquestion\space
        has a total of \the\marktotal\space marks,
        when it should have \the\markgoal}
      \expandafter\shout\expandafter{\@tempa}
    \end{center}
  \fi
  \examn@endquestion{%
    \if@showmarktotals
      \par                      % into vertical mode
      \nobreak                  % keep the marks total with the question
      \vbox to 2\baselineskip{
        \vss
        % this should be very similar to the call to
        % \FormatPartMarks in \@partmarks, above
        \hbox to \textwidth{\strut\hfill\FormatPartMarks{Total: \the\markgoal
          \ifnum\@draftstatus>0
            % in draft modes, put a fairly discreet confirmation in the total
            \space
            \highlighted{\ifnum\marktotal=\markgoal OK\else X\fi}%
          \fi}}}
    \fi
  }
}
\newenvironment{questiondata}{%
  \penalty50 % poor break
  \vbox\bgroup
    \slshape
    \parindent=0pt \parskip=\medskipamount
    \smallskip
    \hrule
    \nobreak
    \smallskip
    \noindent \ignorespaces
}{%
    \par
    \nobreak
    \medskip
    \hrule width \textwidth
    \par
  \egroup
}
\newcommand\questionpreamble[1]{\gdef\examn@questionpreamble{#1}}
\let\examn@questionpreamble\@empty
\newif\if@questionnumberchecks
\@questionnumbercheckstrue
\newcommand\QuestionNumberChecksOff{\@questionnumberchecksfalse}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr
          \topsep0pt
          \partopsep0pt
          %\parskip=5.0pt \parsep=\parskip
          \def\makelabel##1{\hss\llap{##1}}}%
  \fi}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\topsep0pt
        \partopsep0pt
        \def\makelabel##1{\hss\llap{##1}}}%
  \fi}
\renewcommand\theenumi{\@roman\c@enumi}
\newcommand\comment[1]{%
  \ifnum\@draftstatus > 0
    \marginpar{\highlighted{#1}}%
    % should we \@shout this, too?
  \fi
  \ignorespaces
}
\renewcommand\author[1]{\comment{Author: #1}}
\newtoks\@allshouts \@allshouts={}
\def\@shout#1{\edef\@tempa{#1}\expandafter\@@shout\expandafter{\@tempa}}
\def\@@shout#1{\global\@allshouts=\expandafter{\the\@allshouts\t{#1}}}
\def\showthe@shouts{%
  {\def\t##1{{\LARGE\noindent\highlighted{NOTE: ##1}\par}}%
    \the\@allshouts}%
  % Remark on the number of shouts in the aux file
  {\@tempcnta=0 \def\t##1{\advance\@tempcnta1}\the\@allshouts
    \protected@write\@auxout{}%
      {\string\examn@shoutcount{\the\@tempcnta}}}}
\def\shout#1{\textbf{\highlighted{#1}}\@shout{#1}}
\newcount\examn@shoutcounttotal
\examn@shoutcounttotal=0
\def\examn@shoutcount#1{\global\examn@shoutcounttotal=#1}
\def\dummy@documentclass{%
  \@ifnextchar[\dummy@@documentclass{\dummy@@documentclass[]}}
\def\dummy@@documentclass[#1]#2{}
\def\includequestion{
  \@ifnextchar[%]
    {\@includequestion}{\@includequestion[]}}
\def\@includequestion[#1]#2{%
  \begingroup
    \let\documentclass\dummy@documentclass
    \let\document\@empty % not \relax: makes \begin think {document} is undef'd
    \let\enddocument\relax
    \def\@tempa{#1}
    \ifx\@tempa\@empty \else
      \def\@includequestionoverridenumber{#1}
      \message{includequestion override: \@includequestionoverridenumber}
    \fi
    \def\usepackage##1{\ClassWarning{exam-n}
      {Ignoring \string\usepackage{##1} in included question #2}}
    \input{#2}
  \endgroup
}
\let\@includequestionoverridenumber\@empty
\newif\if@insolution
\@insolutionfalse
\def\@formatsolution{\par
  \if@insolution
    \ClassError{exam-n}{Misplaced solution}{You can't have a solution within a solution}
  \else
    \@insolutiontrue            % this happens within a group
  \fi
  \examn@dummycaptions             % dummy captions within solutions
  \typeout{SHOWING SOLUTIONS}
  \vskip 1ex plus 2\bigskipamount % add stretchable space...
  \penalty-\@lowpenalty         % ...and encouragement to break here
  \parskip 0.5\baselineskip
  \raggedright
  \color{solutiontext}%\slshape
  \ifbigfont\else
    \small
  \fi
  \hrule
  \hbox to \textwidth{\vrule height 1ex \hfil \vrule height 1ex}
  \nobreak
  \vskip -\parskip              % cancel out the following parskip
  \textbf{\highlighted{Solution:}}\hskip2em
  \ignorespaces
}
\def\end@formatsolution{%
  \par
  \nobreak
  \vskip -0.5ex
  \hbox to \textwidth{\vrule height 1ex \hfil \vrule height 1ex}
  \hrule
}
\if@showsolutions
  \let\solution\@formatsolution
  \let\endsolution\end@formatsolution
\else
  \def\solution{%
    \if@insolution
      \ClassError{exam-n}{Misplaced solution}{You can't have a solution within a solution}
    \fi
    \let\endfigure\endfloat@skipsolutions
    \let\endtable\endfloat@skipsolutions
    \examn@dummycaptions           % dummy captions avoid counter increments
    \@ifundefined{includepdf}{}{\let\includepdf\examn@disabledpdfpages}
    \par
    \setbox\@tempboxa\vbox\bgroup
      \@insolutiontrue}
  \def\endsolution{%
    \egroup % ...and do nothing with this box
  }
\fi
\def\examn@badfloat#1[#2]{
  \ClassError{exam-n}
    {Bad #1 option #2 ignored}
    {In the exam-n class, the 'floating' environments take no argument,\MessageBreak
      and are always placed 'here'}
  \examn@float{#1}}
\def\examn@float#1{%
  % re-using the standard LaTeX parameter means that \caption works
  \def\@captype{#1}
  \setbox\@tempboxa\vbox\bgroup}
\def\examn@endfloat{%
  \egroup                % end \@tempboxa
  \unskip
  \nobreak
  % add lots of stretchability, but non-infinite, for the sake of tidiness
  \vskip 0pt plus 0.5\textheight
  \penalty50 % a pagebreak here discards following vskip
  % (cf TeXBook p106; or try \filbreak of p111)
  \vskip 2ex plus -0.5\textheight % negative stretch cancels previous vskip
  \box\@tempboxa
  %\vskip 1ex
  \nobreak
}
\def\endfloat@skipsolutions{%
  % variant when skipping solutions -- end the \@tempboxa and do nothing
  \egroup
}
\def\figure{%
  \@ifnextchar[{\examn@badfloat{figure}}{\examn@float{figure}}%]
}
\def\table{%
  \@ifnextchar[{\examn@badfloat{table}}{\examn@float{table}}%]
}
\let\endfigure\examn@endfloat
\let\endtable\examn@endfloat
\def\examn@dummycaptions{%
  \def\fnum@figure{\figurename} % 'Figure nnn' changed to just 'Figure'
  \def\fnum@table{\tablename}
  \def\caption{%
    \ifx\@captype\@undefined
      \@latex@error{\noexpand\caption outside float}\@ehd
      \expandafter\@gobble
    \else
      %\refstepcounter\@captype % omit this line from the standard definition
      \expandafter\@firstofone
    \fi
    {\@dblarg{\@caption\@captype}}%
  }
}
\def\examn@disabledpdfpages{\@ifnextchar[% ]
  \examn@disabledpdfpages@
  {\examn@disabledpdfpages@[]}}
\def\examn@disabledpdfpages@[#1]#2{\relax}
\AtEndDocument{
  \CheckTotalQuestions
  \ClosingText
  \showthe@shouts
  \WriteLastPageLabel}
\ifcase\examn@mtselect
  % mathptm fonts
  % This is a very clumsy version, but it appears to be our only option
  \def\vec#1{\mathchoice{\mbox{\boldmath $\displaystyle #1$}}
    {\mbox{\boldmath $ #1$}}
    {\mbox{\boldmath $\scriptstyle #1$}}
    {\mbox{\boldmath $\scriptscriptstyle #1$}}}
\or % mathtime (should this be the same for mathtime as for mtpro2?
  \let\vec\mathbf
\or % mtpro2
  \let\vec\mathbold
\fi
\newcommand\BSc{B.Sc.{}}
\newcommand\MSci{M.Sci.{}}
\newcommand\MSc{M.Sc.{}}
\newcommand\MA{M.A.{}}
\newcommand\MEng{M.Eng.{}}
\newcommand\BEng{B.Eng.{}}
\newcommand{\dd}{\mathrm{d}}
\newcommand{\ddd}{\,\mathrm{d}}  % inside an integral, including thinspace

\def\Diffl{\@ifstar\@Difflflat\@Diffl}
\def\Partial{\@ifstar\@Partialflat\@Partial}
\def\@Partial{\@ifnextchar[{\@@Diffl\partial}{\@@Diffl\partial[]}}
\def\@Partialflat{\@ifnextchar[{\@@Difflflat\partial}{\@@Difflflat\partial[]}}
\def\@Diffl{\@ifnextchar[{\@@Diffl\dd}{\@@Diffl\dd[]}}
\def\@Difflflat{\@ifnextchar[{\@@Difflflat\dd}{\@@Difflflat\dd[]}}
\def\@@Diffl#1[#2]#3#4{%
  \def\@tempa{#2}%
  \ifx\@tempa\empty
    \frac{#1#3}{#1#4}%
  \else
    \frac{{#1}^{#2}#3}{#1{#4}^{#2}}%
  \fi}
\def\@@Difflflat#1[#2]#3#4{%
  \def\@tempa{#2}%
  \ifx\@tempa\empty
    #1#3\mskip-0.8mu/\mskip-1.2mu #1#4%
  \else
    {#1}^{#2}#3\mskip-0.8mu /\mskip-1.2mu #1{#4}^{#2}%
  \fi}
\def\e{{\mathrm e}}
\def\units{\begingroup
  \catcode`\.=\active
  \@ifstar{\let\un@tsspace\relax    \un@ts}%
          {\let\un@tsspace\thinspace\un@ts}}
\begingroup
  \catcode`\.=\active
  \gdef\un@ts#1{\let~\thinspace\let.\thinspace
    \ifmmode
      \un@tsspace\mathrm{#1}%
    \else
      \nobreak$\un@tsspace\mathrm{#1}$%
    \fi
    \endgroup}
\endgroup
\def\au{au}
\def\lambdabar{\setbox\@tempboxa\hbox{$\lambda$}%
  \hbox to 0pt{\hbox to \wd\@tempboxa{\hss$\bar{}$\hss}\hss}\box\@tempboxa}
\endinput
%%
%% End of file `exam-n.cls'.
