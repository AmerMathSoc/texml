%%
%% This is file `usthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% usthesis.dtx  (with options: `cls')
%%  Copyright (C) 2003--2014 Danie Els
%% 
%% -------------------------------------------------------------------
%%         University of Stellenbosch Thesis Class
%% -------------------------------------------------------------------
%% This work may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3c of this
%% license or (at your option) any later version. The latest version
%% of this license is in
%%      http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008/05/04 or later.
%% 
%% This work has the LPPL maintenance status 'maintained'.
%% 
%% This Current Maintainer of this work is Danie Els (dnjels@sun.ac.za)
%% -------------------------------------------------------------------
%% 
\newcommand{\USfileversion}{v5.0}
\newcommand{\USfiledate}{2014/11/28}
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\def\US@basetype{book}
\ProvidesClass{usthesis}[\USfiledate\space
                         \USfileversion\space
                         Stellenbosh Thesis class (DNJ ELS)]
\RequirePackage{calc}
\RequirePackage{ifpdf}
\providecommand{\phantomsection}{}
\AtBeginDocument{%
   \@ifpackageloaded{graphicx}{}{%
      \ClassError{usthesis}{You must load the graphicx package}{}%
      }%
   }
\edef\US@AFRstr{\string afrikaans}
\newcommand{\AorE}[2]{%
   \ifx\US@AFRstr\languagename #1\else #2\fi}
\newenvironment{Afr}%
    {\ifx\languagename\US@AFRstr\relax\else
       \selectlanguage{afrikaans}%
     \fi}%
    {}
\newcommand*\US@ENGstr{}
\let\US@ENGstr=\relax
\newenvironment{Eng}%
    {\ifx\relax\US@ENGstr\relax\else
        \ifx\languagename\US@ENGstr\relax\else
           \edef\US@tempa{\noexpand\selectlanguage{\US@ENGstr}}%
           \US@tempa
        \fi
     \fi}%
    {}
\newcommand\DegreeName{%
   \ClassWarning{usthesis}{No degree or subject supplied}%
   \textfb{[No degree!]}}
\newcommand\DegreeNameLong{%
   \ClassWarning{usthesis}{No degree or subject supplied}%
   \textfb{[No degree!]}}
\newcommand*\USName{}
\newcommand*\AuthByTxt{}
\newcommand*\StudyLeaderType{}
\newcommand*\StudyLeadersType{}
\newcommand*\CoStudyLeaderType{}
\newcommand*\CoStudyLeadersType{}
\newcommand*\SupervisorType{}
\newcommand*\SupervisorsType{}
\newcommand*\CoSupervisorType{}
\newcommand*\CoSupervisorsType{}
\newcommand*\TypeReport{}
\newcommand*\TypeAssignment{}
\newcommand*\TypeThesis{}
\newcommand*\TypePhD{}
\newcommand*\CopyrightHolder{}
\newcommand*\CopyrightTxt{}
\newcommand*\CopyrightAnot{}
\newcommand*\Signat{}
\newcommand*\Datetxt{}
\newcommand*\MasterDescript{}
\newcommand*\PhDDescript{}
\newcommand*\ThesisDeclare{}
\newcommand*\MonthName{}
\newcommand*\DeclarationName{}
\newcommand*\AbstractName{}
\InputIfFileExists{usthesis.afr}
    {\ClassInfo{usthesis}{Input file 'usthesis.afr' loaded}}
    {\ClassError{usthesis}{No file 'usthesis.afr'}{}}
\InputIfFileExists{usthesis.eng}
    {\ClassInfo{usthesis}{Input file 'usthesis.eng' loaded}}
    {\ClassError{usthesis}{No file 'usthesis.eng'}{}}
\USextrasenglish
\UScaptionsenglish
\def\US@addto#1#2{%
  #2%
  \@temptokena{#2}%
  \ifx#1\relax
    \let#1\@empty
  \fi
  \ifx#1\undefined
     \edef#1{\the\@temptokena}%
  \else
     \toks@\expandafter{#1}%
     \edef#1{\the\toks@\the\@temptokena}%
  \fi
  \@temptokena{}\toks@\@temptokena}
\newcommand\US@addlangextras[2]{%
   \AtBeginDocument{%
      \expandafter\US@addto\csname extras#1\endcsname #2}}
\newcommand\US@addlangcaptions[2]{%
   \AtBeginDocument{%
      \expandafter\US@addto\csname captions#1\endcsname #2}}
\DeclareOption{english}{%
   \edef\US@ENGstr{\string english}%
   \US@addlangextras{english}{\USextrasenglish}%
   \US@addlangcaptions{english}{\UScaptionsenglish}}
\DeclareOption{UKenglish}{%
   \edef\US@ENGstr{\string UKenglish}%
   \US@addlangextras{UKenglish}{\USextrasenglish}%
   \US@addlangcaptions{UKenglish}{\UScaptionsenglish}}
\DeclareOption{USenglish}{%
   \edef\US@ENGstr{\string USenglish}%
   \US@addlangextras{USenglish}{\USextrasenglish}%
   \US@addlangcaptions{USenglish}{\UScaptionsenglish}}
\DeclareOption{british}{%
   \edef\US@ENGstr{\string british}%
   \US@addlangextras{british}{\USextrasenglish}%
   \US@addlangcaptions{british}{\UScaptionsenglish}}
\DeclareOption{afrikaans}{%
   \US@addlangextras{afrikaans}{\USextrasafrikaans}%
   \US@addlangcaptions{afrikaans}{\UScaptionsafrikaans}}
\newif\if@Report
\@Reporttrue
\newif\if@Masters
\@Mastersfalse
\newif\if@PhD
\@PhDfalse
\newcommand{\ThesisType}{}
\newcommand{\SupervisorText}{}
\newcommand{\SupervisorsText}{}
\newcommand{\CoSupervisorText}{}
\newcommand{\CoSupervisorsText}{}
\DeclareOption{report}{%
   \renewcommand{\ThesisType}{\TypeReport}%
   \renewcommand{\SupervisorText}{\StudyLeaderType}
   \renewcommand{\SupervisorsText}{\StudyLeadersType}
   \renewcommand{\CoSupervisorText}{\CoStudyLeaderType}%
   \renewcommand{\CoSupervisorsText}{\CoStudyLeadersType}%
   \@Reporttrue
   \@Mastersfalse
   \@PhDfalse}
\DeclareOption{masters-a}{%
   \renewcommand{\ThesisType}{\TypeAssignment}%
   \renewcommand{\SupervisorText}{\SupervisorType}%
   \renewcommand{\SupervisorsText}{\SupervisorsType}%
   \renewcommand{\CoSupervisorText}{\CoSupervisorType}%
   \renewcommand{\CoSupervisorsText}{\CoSupervisorsType}%
   \@Reportfalse
   \@Masterstrue
   \@PhDfalse}
\DeclareOption{masters-t}{%
   \renewcommand{\ThesisType}{\TypeThesis}%
   \renewcommand{\SupervisorText}{\SupervisorType}%
   \renewcommand{\SupervisorsText}{\SupervisorsType}%
   \renewcommand{\CoSupervisorText}{\CoSupervisorType}%
   \renewcommand{\CoSupervisorsText}{\CoSupervisorsType}%
   \@Reportfalse
   \@Masterstrue
   \@PhDfalse}
\DeclareOption{PhD}{%
   \renewcommand{\ThesisType}{\TypePhD}%
   \renewcommand{\SupervisorText}{\SupervisorType}%
   \renewcommand{\SupervisorsText}{\SupervisorsType}%
   \renewcommand{\CoSupervisorText}{\CoSupervisorType}%
   \renewcommand{\CoSupervisorsText}{\CoSupervisorsType}%
   \@Reportfalse
   \@Mastersfalse
   \@PhDtrue}
\DeclareOption{PhDfinal}{%
   \renewcommand{\ThesisType}{\TypePhD}%
   \renewcommand{\SupervisorText}{\SupervisorType}%
   \renewcommand{\SupervisorsText}{\SupervisorsType}%
   \renewcommand{\CoSupervisorText}{\CoSupervisorType}%
   \renewcommand{\CoSupervisorsText}{\CoSupervisorsType}%
   \@Reportfalse
   \@Mastersfalse
   \@PhDtrue}
\DeclareOption{twocolumn}{}
\newif\if@ABlock
\newif\if@GBlock
\newif\if@WBlock
\@ABlockfalse
\@GBlockfalse
\@WBlockfalse
\DeclareOption{a5block}{%
   \PassOptionsToClass{a4paper}{\US@basetype}%
   \@ABlocktrue
   \@GBlockfalse
   \@WBlockfalse}
\DeclareOption{goldenblock}{%
   \PassOptionsToClass{a4paper}{\US@basetype}%
   \@GBlocktrue
   \@ABlockfalse
   \@WBlockfalse}
\DeclareOption{wideblock}{%
   \PassOptionsToClass{a4paper}{\US@basetype}%
   \@GBlockfalse
   \@ABlockfalse
   \@WBlocktrue}
\DeclareOption{stdblock}{%
   \@GBlockfalse
   \@ABlockfalse
   \@WBlockfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\US@basetype}}
\ExecuteOptions{report}
\ProcessOptions*\relax
\LoadClass[oneside,openany]{\US@basetype}
\newlength{\US@tdima}
\newlength{\US@tdimb}
\newsavebox{\US@tboxa}
\newsavebox{\US@tboxb}
\newcounter{US@tcnta}
\newcounter{US@tcntb}
\newcommand\FixVertParams[1]{%
    \normalsize
    \setlength\US@tdima{\textheight-\topskip}%
    \setcounter{US@tcnta}{\US@tdima}
    \setcounter{US@tcntb}{\baselineskip}
    \setcounter{US@tcnta}{\value{US@tcnta}/\value{US@tcntb}}
    \setlength\textheight{\baselineskip*\value{US@tcnta}+\topskip}%
    \setlength\US@tdima{\paperheight-\textheight}%
    \setlength\topmargin{#1\US@tdima-\headheight-\headsep-1in}%
    \@settopoint\topmargin}
\newcommand\FixHorizParams[1]{%
    \@settopoint\textwidth
    \setlength\US@tdima{\paperwidth-\textwidth}%
    \if@twoside
        \setlength\oddsidemargin{#1\US@tdima-1in}%
    \else
        \setlength\oddsidemargin{.5\US@tdima-1in}%
    \fi
    \@settopoint\oddsidemargin
    \setlength\evensidemargin{\US@tdima-\oddsidemargin-2in}%
    \@settopoint\evensidemargin
    \setlength\marginparwidth{\evensidemargin+1in-\marginparsep-1cm}%
    \@settopoint\marginparwidth}
\if@ABlock
    \setlength\paperheight  {297.3mm}
    \setlength\paperwidth   {210.2mm} % A4 paper
    \setlength\textwidth    {.5\paperheight}
    \setlength\textheight   {\paperwidth}
    \setlength\marginparsep {7\p@}
    \setlength\marginparpush{7\p@}
    \FixVertParams{0.375}
    %\FixHorizParams{0.375}
    \FixHorizParams{0.5}% Changed in v3.0
    \ifpdf
       \setlength\pdfpagewidth{\paperwidth}
       \setlength\pdfpageheight{\paperheight}
    \fi
\fi
\if@GBlock
    \setlength\paperheight  {297.3mm}
    \setlength\paperwidth   {210.2mm} % A4 paper
    \setlength\textheight   {0.747547\paperheight}
    \setlength\textwidth    {0.666667\paperwidth}
    \setlength\marginparsep {7\p@}
    \setlength\marginparpush{7\p@}
    \FixVertParams{0.375}
    %\FixHorizParams{0.375}
    \FixHorizParams{0.5}% Changed in v3.0
    \ifpdf
       \setlength\pdfpagewidth{\paperwidth}
       \setlength\pdfpageheight{\paperheight}
    \fi
\fi
\if@WBlock
    \setlength\paperheight  {297.3mm}
    \setlength\paperwidth   {210.2mm} % A4 paper
    \setlength\textheight   {\paperheight-50mm}
    \setlength\textwidth    {\paperwidth-50mm}
    \setlength\marginparsep {7\p@}
    \setlength\marginparpush{7\p@}
    \FixVertParams{0.5}
    \FixHorizParams{0.5}
    \ifpdf
       \setlength\pdfpagewidth{\paperwidth}
       \setlength\pdfpageheight{\paperheight}
    \fi
\fi
\begingroup
   \catcode`\Q=3
   \long\gdef\US@ifempt#1{\US@xifempt#1QQ\@secondoftwo\@firstoftwo\@nil}
   \long\gdef\US@xifempt#1#2Q#3#4#5\@nil{#4}
\endgroup
\newenvironment{US@adjustwidth}[2]{%
   \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\partopsep}{0pt}%
      \setlength{\leftmargin}{#1}%
      \setlength{\rightmargin}{#2}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\itemindent}{\parindent}%
      \setlength{\parsep}{\parskip}%
      }%
   \item[]}{\end{list}}
\newenvironment{SetMargins}[2]%
  {\setlength{\US@tdima}{-1in-\hoffset-\oddsidemargin}%
   \setlength{\US@tdimb}{-\US@tdima}%
   \addtolength{\US@tdima}{#1}%
   \addtolength{\US@tdimb}{-\paperwidth+\textwidth+#2}%
   \begin{US@adjustwidth}{\US@tdima}{\US@tdimb}%
  }%
  {\end{US@adjustwidth}}
\newenvironment{US@titlepage}[4]
  {\cleardoublepage
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse\newpage
   \fi
   \thispagestyle{empty}%
   \setcounter{page}\@ne
   \setlength{\US@tdima}{1in+\voffset+\topmargin+\headheight+\headsep+\topskip}%
   \setlength{\US@tdimb}{#1 -\US@tdima}%
   \vspace*{\US@tdimb}%
   \addtolength{\US@tdima}{\textheight-\paperheight-\topskip}%
   \addtolength{\US@tdima}{#2}%
   \enlargethispage{-\US@tdima}%
   \setlength{\US@tdima}{-1in-\hoffset-\oddsidemargin}%
   \setlength{\US@tdimb}{-\US@tdima}%
   \addtolength{\US@tdima}{#3}%
   \addtolength{\US@tdimb}{-\paperwidth+\textwidth+#4}%
   \begin{US@adjustwidth}{\US@tdima}{\US@tdimb}%
  }%
  {\end{US@adjustwidth}%
   \if@restonecol\twocolumn \else \newpage \fi
   \if@twoside\else
      \setcounter{page}\@ne
   \fi}
\let\maketitle\relax
\newcommand{\TitlePage}{%
   \begingroup
      \let\footnote\relax
      \begin{US@titlepage}{2cm}{2.5cm}{2.5cm}{2.5cm}%
         \centering
         \if@Report
            \includegraphics[width=100mm]{USlogo-top}\par
            \vfill
         \else
            %\includegraphics[width=88mm]{UScrest-top}\par
            \vfill
         \fi
        {\LARGE \@title \par}
         \vspace{2em}
         \if@Authorpresent
            {\large \AuthByTxt\par}
             \vspace{2em}
            {\Large
             \lineskip .75em\relax%
             \begin{tabular}[t]{c}%
                \US@authorlong
             \end{tabular}\par}%
             \vfill
             \vfill
         \fi
         \if@Report\if@Subjectpresent
            {\large\DegreeNameLong\par}
            \vfill
         \fi\fi
        {\large\slshape
         \begin{US@adjustwidth}{1.5cm}{1.5cm}
            \centering\US@ThesisDescript
         \end{US@adjustwidth}\par}
         \vfill
         \vfill
        {\normalsize \US@spvset \par}
         \vspace{2em}
        {\normalsize \US@date\par}%
        {\footnotesize \US@sponsor \par}
      \end{US@titlepage}%
   \endgroup
   \global\let\TitlePage\relax
   \setcounter{footnote}{0}%
   \global\let\thanks\relax
   \global\let\@thanks\@empty
   }
\newif\if@Authorpresent
\@Authorpresentfalse
\renewcommand\author[2]{%
   \@Authorpresenttrue%
   \gdef\US@author{#1}%
   \gdef\US@authorlong{#2}}
\newcommand\US@author{%
   \ClassWarning{usthesis}{No author supplied}%
   }
\newcommand\US@authorlong{%
   \ClassWarning{usthesis}{No author supplied}%
   }
\newcommand{\US@ThesisDescript}{}
\newcommand\ThesisDescript[1]{%
   \long\gdef\US@ThesisDescript{#1}}
\let\ReportDescript=\ThesisDescript
\if@Masters
   \ThesisDescript{\MasterDescript}
\fi
\if@PhD
    \ThesisDescript{\PhDDescript}%
\fi
\newif\if@Subjectpresent
\@Subjectpresentfalse
\newcommand\degree[2]{%
   \@Subjectpresenttrue
   \gdef\DegreeName{#1}%
   \gdef\DegreeNameLong{#2}}
\let\subject=\degree
\newcommand\address[1]{\gdef\US@address{#1}}
\let\adress\address % backward compatibility :-)
\newcommand\US@address{%
   \ClassWarning{usthesis}{No institutional address supplied}}
\newcommand\faculty[1]{\gdef\USfaculty{#1}}
\newcommand\USfaculty{%
   \ClassWarning{usthesis}{No faculty name supplied}%
   \textbf{[No faculty name supplied!]}}
\newif\ifUS@spvpresent\US@spvpresentfalse
\newif\ifUS@cospvpresent\US@cospvpresentfalse
\newif\ifUS@spvmult\US@spvmultfalse
\newif\ifUS@cospvmult\US@cospvmultfalse
\newif\ifUS@spvrows\US@spvrowsfalse
\newcommand\US@spv{}
\newcommand\US@cospv{}
\newcommand*\US@spvalign{l}
\newcommand{\supervisor}{%
   \@ifstar{\US@spvrowsfalse\@supervisor}%
           {\US@spvrowstrue\@supervisor}}
\newcommand{\@supervisor}[2][l]{%
   \US@ifempt{#2}{}{\US@spvpresenttrue}%
   \renewcommand*\US@spvalign{#1}%
   \renewcommand\US@spv{#2}}
\newcommand{\cosupervisor}[1]{%
   \US@ifempt{#1}{}{\US@cospvpresenttrue}%
   \renewcommand\US@cospv{#1}}
\newcommand{\US@spvset}{%
    \ifUS@spvrows
        \US@spvrows
    \else
        \US@spvcols
    \fi}
\newcommand\US@spvrows{%
    \edef\US@beginTab{\noexpand\begin{tabular}[t]{@{}\US@spvalign @{}}}%
    \edef\US@endTab{\noexpand\end{tabular}}%
    \US@spvmultfalse
    \sbox{\US@tboxa}{%
        \let\and\US@spvand%
        \US@beginTab\US@spv\US@endTab}%
    \US@cospvmultfalse
    \sbox{\US@tboxb}{%
        \let\and\US@cospvand%
        \US@beginTab\US@cospv\US@endTab}%
    \ifUS@spvpresent
        \begin{tabular}{@{}ll@{}}
             \ifUS@spvmult\SupervisorsText\else\SupervisorText\fi
             & \usebox{\US@tboxa}\\
             \ifUS@cospvpresent%
                  \noalign{\vskip 1ex}
                  \ifUS@cospvmult\CoSupervisorsText\else\CoSupervisorText\fi
                & \usebox{\US@tboxb}
             \fi
        \end{tabular}
   \fi}
\newcommand\US@spvcols{%
    \edef\US@beginTab{\noexpand\begin{tabular}[t]{@{}\US@spvalign @{}}}%
    \edef\US@endTab{\noexpand\end{tabular}}%
    \US@spvmultfalse
    \sbox{\US@tboxa}{%
        \let\and\US@spvand%
        \US@beginTab\US@spv\US@endTab}%
    \US@cospvmultfalse
    \sbox{\US@tboxb}{%
        \let\and\US@cospvand%
        \US@beginTab\US@cospv\US@endTab}%
    \ifUS@spvpresent
        \US@beginTab
            \ifUS@spvmult\SupervisorsText\else\SupervisorText\fi\\[1ex]
             \usebox{\US@tboxa}
        \US@endTab
    \fi
    \ifUS@cospvpresent
        \hspace{2em}%
        \US@beginTab
            \ifUS@cospvmult\CoSupervisorsText\else\CoSupervisorText\fi\\[1ex]
             \usebox{\US@tboxb}
        \US@endTab
    \fi}
\newcommand*{\US@spvand}[1][0pt]{%
      \global\US@spvmulttrue%
      \\[#1]%
      \ignorespaces}
\newcommand*{\US@cospvand}[1][0pt]{%
      \global\US@cospvmulttrue%
      \\[#1]%
      \ignorespaces}
\let\studyleader\supervisor
\let\promotor\supervisor  %Backward compatibility
\newcount\US@month
\newcount\US@year
\US@month=0
\US@year=\number\year
\def\US@date{\MonthName{\US@month}\ \number\US@year}
\newcommand{\setdate}[2]{%
   \US@ifempt{#1}{\US@month=0}{\US@month=#1}%
   \US@year=#2
   \gdef\US@date{\MonthName{\US@month}\ \number\US@year}}
\newcommand\US@sponsor{\vspace{2em}}
\newcommand\SetSponsor[1]{%
    \renewcommand\US@sponsor{\vspace{2em}\par\parbox{\linewidth}{#1}}}
\newcommand\CopyrightPage[1][\CopyrightHolder]{%
   %\clearpage
   %\thispagestyle{empty}
   %\mbox{}\par\vfill
   %\begin{center}
   %   \CopyrightTxt\ \copyright\ \number\US@year\ #1\\
   %   \CopyrightAnot
   %\end{center}
   %\vfill\mbox{}\par
   %\clearpage
   }
\newcommand\SetCopyrightHolder[1]{%
   \renewcommand\CopyrightHolder{#1}}
\newif\ifUS@Copyright
\US@Copyrighttrue
\newcommand\SetCopyrightOff{%
   \US@Copyrightfalse}
\let\US@DeclDate\@empty
\newcommand{\DeclarationSign}[1]{}% Only for backward compatibility
\newcommand{\DeclarationDate}[1]{\renewcommand\US@DeclDate{#1}}
\newcommand\US@putdecldate{%
        \vspace{1cm}
        \noindent
        \begin{minipage}{.5\textwidth}
            \noindent
            \ifx\US@DeclDate\@empty\relax\else
                \phantom{\Signat:}~\hfill\makebox[0pt][c]{\US@DeclDate}\hfill\mbox{}\\[-.5\baselineskip]
            \fi
            \Datetxt:~ \dotfill\mbox{}\par
        \end{minipage}
        \par}
\newcommand{\DeclarationPage}[1][\ThesisDeclare]{%
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse
   \fi
   \par
   \thispagestyle{plain}%
   \chapter*{\DeclarationName}%
   \declaremark
   \phantomsection
   \addcontentsline{toc}{chapter}{\DeclarationName}%
   #1\par
   \US@putdecldate
   \ifUS@Copyright
       \mbox{}\par
       \vfill
       \vfill
       \noindent\CopyrightTxt\ \copyright\ \number\US@year\ \CopyrightHolder\\
       \noindent\CopyrightAnot
       \vfill
       \mbox{}\par
   \fi
   \if@restonecol\twocolumn\fi}
\newenvironment{abstract}[1][\languagename]%
   {\edef\@tempa{\expandafter\string #1}%
    \ifx\@tempa\languagename\relax\else
      \edef\@tempa{\noexpand\selectlanguage{#1}}\@tempa%
    \fi
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse
   \fi
   \par
   \chapter*{\AbstractName}%
   \abstractmark
   \phantomsection
   \addcontentsline{toc}{chapter}{\AbstractName}%
   \if@Report\else
       \begin{center}
          {\large\bfseries \@title \par}
           \medskip
          {\lineskip .75em\relax%
           \begin{tabular}[t]{@{}c@{}}%
              \US@author
           \end{tabular}\par}
           \smallskip
          {\small\itshape\US@address\par}
           \smallskip
          {\ThesisType: \DegreeName\par}
           \smallskip
          {\US@date\par}
       \end{center}
    \fi
    \if@restonecol\twocolumn\fi%
    }{}
\renewcommand\tableofcontents{%
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse
   \fi
   \chapter*{\contentsname}%
   \tocmark
   \phantomsection
   \addcontentsline{toc}{chapter}{\contentsname}%
   \@starttoc{toc}%
   \if@restonecol\twocolumn\fi}
\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \lofmark
    \phantomsection
    \addcontentsline{toc}{chapter}{\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{3em}}
\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \lotmark
    \phantomsection
    \addcontentsline{toc}{chapter}{\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi}
\let\l@table\l@figure
\providecommand\bibsection{}%
\AtBeginDocument{%
   \renewcommand{\bibsection}{%
      \chapter*{\bibname}%
      \bibmark
      \phantomsection
      \addcontentsline{toc}{chapter}{\bibname}}%
   }
\renewenvironment{thebibliography}[1]{%
   \bibsection
   \parindent \z@
   \bibpreamble
   \bibfont
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty \clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
   \endlist
   \vskip-\lastskip}
\let\bibfont\relax
\let\bibpreamble\relax
\newcommand*{\setbiblabel}[1]{%
   \renewcommand*{\@biblabel}[1]{#1}}
\setbiblabel{[#1]\hfill}
\renewenvironment{theindex}
   {\if@twocolumn
       \@restonecolfalse
    \else
       \@restonecoltrue
    \fi
    \columnseprule \z@
    \columnsep 35\p@
    \twocolumn[\@makeschapterhead{\indexname}]%
    \indexmark
    \phantomsection
    \addcontentsline{toc}{chapter}{\indexname}
    \thispagestyle{plain}
    \parindent\z@
    \parskip\z@ \@plus .3\p@\relax
    \let\item\@idxitem}
   {\if@restonecol
       \onecolumn
    \else
       \clearpage
    \fi}
\newcommand*{\US@headfnt}[1]{{\slshape\small#1}}
\newcommand*{\US@numfnt}[1]{{\normalsize\bfseries#1}}
\if@twoside
   \def\ps@usthesis{%
      \def\@evenhead{\US@numfnt{\thepage}\hfil\US@headfnt{\leftmark}}%
      \def\@oddhead{\US@headfnt{\rightmark}\hfil\US@numfnt{\thepage}}%
      \let\@oddfoot\@empty
      \let\@evenfoot\@empty
      \let\@mkboth\markboth
      \def\chaptermark##1{%
         \markboth{\MakeUppercase{%
            \ifnum \c@secnumdepth >\m@ne
               \if@mainmatter
                  \@chapapp\ \thechapter. \ %
               \fi
            \fi
            ##1}}{}}%
      \def\sectionmark##1{%
         \markright{\MakeUppercase{%
            \ifnum \c@secnumdepth > \z@
               \thesection. \ %
            \fi
            ##1}}}%
      \def\declaremark{\markboth{\MakeUppercase{\DeclarationName}}{}}%
      \def\abstractmark{\markboth{\MakeUppercase{\AbstractName}}{}}%
      \def\tocmark{\markboth{\MakeUppercase{\contentsname}}{}}%
      \def\lofmark{\markboth{\MakeUppercase{\listfigurename}}{}}%
      \def\lotmark{\markboth{\MakeUppercase{\listtablename}}{}}%
      \def\bibmark{\markboth{\MakeUppercase{\bibname}}{}}%
      \def\indexmark{\markboth{\MakeUppercase{\indexname}}{}}%
      }
\else
   \def\ps@usthesis{%
      \def\@oddhead{\US@headfnt{\rightmark}\hfil\US@numfnt{\thepage}}%
      \let\@oddfoot\@empty
      \let\@mkboth\markboth
      \def\chaptermark##1{%
         \markright{\MakeUppercase{%
            \ifnum \c@secnumdepth >\m@ne
               \if@mainmatter
                  \@chapapp\ \thechapter. \ %
               \fi
            \fi
            ##1}}}%
      \def\declaremark{\markright{\MakeUppercase{\DeclarationName}}}%
      \def\abstractmark{\markright{\MakeUppercase{\AbstractName}}}%
      \def\tocmark{\markright{\MakeUppercase{\contentsname}}}%
      \def\lofmark{\markright{\MakeUppercase{\listfigurename}}}%
      \def\lotmark{\markright{\MakeUppercase{\listtablename}}}%
      \def\bibmark{\markright{\MakeUppercase{\bibname}}}%
      \def\indexmark{\markright{\MakeUppercase{\indexname}}}%
      }
\fi
\def\ps@plain{%
   \let\@mkboth\@gobbletwo
   \let\@oddhead\@empty
   \let\@evenhead\@empty
   \def\@oddfoot{\reset@font\hfil\US@numfnt{\thepage}\hfil}%
   \let\@evenfoot\@oddfoot
   }
\pagestyle{usthesis}
\newcommand{\US@headfamily}{\normalfont\rmfamily}
\def\section{%
   \@startsection{section}{1}%
                 {\z@}%
                 {-3.5ex plus -1ex minus -.2ex}%
                 {2.3ex plus .2ex}%
                 {\US@headfamily\Large\bfseries\raggedright}}
\def\subsection{%
   \@startsection{subsection}{2}%
                 {\z@}%
                 {-3.25ex plus -1ex minus -.2ex}%
                 {1.5ex plus .2ex}%
                 {\US@headfamily\large\bfseries\raggedright}}%
\def\subsubsection{%
   \@startsection{subsubsection}{3}%
                 {\z@}%
                 {-3.25ex plus -1ex minus -.2ex}%
                 {1.5ex plus .2ex}%
                 {\US@headfamily\normalsize\bfseries\raggedright}}
\def\paragraph{%
   \@startsection{paragraph}{4}%
                 {\z@}%
                 {3.25ex plus 1ex minus .2ex}%
                 {-1em}%
                 {\US@headfamily\normalsize\bfseries}}
\def\subparagraph{%
   \@startsection{subparagraph}{5}%
                 {\parindent}%
                 {3.25ex plus 1ex minus .2ex}%
                 {-1em}%
                 {\US@headfamily\normalsize\bfseries}}
\setcounter{topnumber}{3}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{3}
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.7}
\renewcommand{\dbltopfraction}{.85}
\renewcommand{\dblfloatpagefraction}{.7}
\setlength{\floatsep}{15pt plus 12pt}
\setlength{\textfloatsep}{\floatsep}
\setlength{\intextsep}{\floatsep}
\setlength{\dblfloatsep}{15pt plus 12pt}
\setlength{\dbltextfloatsep}{15pt plus 12pt}
\setlength{\@fptop}{0pt plus1fil}
\setlength{\@fpbot}{0pt plus1fil}
\setlength{\@fpsep}{8pt plus1fil}
\setlength{\@dblfptop}{0pt plus1fil}
\setlength{\@dblfpbot}{0pt plus1fil}
\setlength{\@dblfpsep}{8pt plus1fil}
\setlength{\abovecaptionskip}{0.5\baselineskip}
\setlength{\belowcaptionskip}{0.5\baselineskip}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\small{\bfseries #1:} #2}%
  \ifdim \wd\@tempboxa >\hsize
    \unhbox\@tempboxa\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\endinput
%%
%% End of file `usthesis.cls'.
