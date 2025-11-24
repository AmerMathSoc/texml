%%
%% This is file `estcpmm.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% estcpmm.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from estcpmm.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file estcpmm.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{estcpmm}
[2010/03/02 v0.4 Typesetting reports for ESTCP MM Reports]
\long\def\estcpmm@size@warning#1{%
  \ClassWarning{estcpmm}{Size-changing option #1 will not be
    honored}}%
\DeclareOption{8pt}{\estcpmm@size@warning{\CurrentOption}}%
\DeclareOption{9pt}{\estcpmm@size@warning{\CurrentOption}}%
\DeclareOption{10pt}{\estcpmm@size@warning{\CurrentOption}}%
\DeclareOption{11pt}{\estcpmm@size@warning{\CurrentOption}}%
\DeclareOption{12pt}{\estcpmm@size@warning{\CurrentOption}}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt]{book}
\RequirePackage{graphicx}
\RequirePackage{caption}
\captionsetup[table]{position=top}
\captionsetup{justification=centering,font=bf}
\usepackage{mathptmx}
\usepackage[scaled]{helvet}
\usepackage{courier}
\RequirePackage[margin=1in]{geometry}
\setlength{\parindent}{0pt}
\setlength{\parskip}{\baselineskip}
\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\pagestyle{fancy}
\lhead{}
\rhead{}
\chead{}
\lfoot{\parbox[b]{\headwidth}{\setlength{\parskip}{0pt}\raggedright
    \itshape\fontsize{\@xipt}{\@xipt}\selectfont
      \@shorttitle}}
\cfoot{{\small\thepage}}
\rfoot{\textit{\small\@date}}
\newcommand{\logo}[2][]{\gdef\@logo{\includegraphics[#1]{#2}}}%
\def\@logo{}%
\renewcommand{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}%
  \ifx\@shorttitle\@empty\gdef\@shorttitle{#2}\fi}
\def\@title{}
\def\@shorttitle{}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\def\@subtitle{}
\newcommand{\projectno}[1]{\gdef\@projectno{#1}}
\def\@projectno{}
\newcommand{\internalno}[1]{\gdef\@internalno{#1}}
\def\@internalno{}
\newcommand{\version}[1]{\gdef\@version{#1}}
\def\@version{}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\year}
\def\maketitle{%
  \thispagestyle{empty}%
  \begin{flushright}%
    \raisebox{0in}[2in][1in]{\@logo}\par
    \bgroup
     \fontsize{26pt}{32pt}\bfseries\selectfont\MakeUppercase{\@title}\\[-10pt]
     \rule{\textwidth}{5pt}\par
     \egroup
     \bgroup
     \fontsize{18pt}{24pt}\bfseries\selectfont
     \ifx\@subtitle\@empty\relax\else\@subtitle\par\fi
     \ifx\@projectno\@empty\relax\else Project Number \@projectno\par\fi
     \ifx\@internalno\@empty\relax\else\@internalno\par\fi
     \ifx\@date\@empty\relax\else\@date\par\fi
     \ifx\@version\@empty\relax\else\@version\par\fi
     \ifx\@author\@empty\relax\else\@author\par\fi
     \egroup
  \end{flushright}%
  \clearpage}
\def\texorpdfstring{%
     \expandafter\@firstoftwo}
\let\phantomsection\@empty
\def\@sectionprefix{}
\def\@sectionsuffix{}
\renewcommand \thesection {\@arabic\c@section.0}
\renewcommand \thesubsection{\@arabic\c@section.\@arabic\c@subsection}
\renewcommand\section{\par\cleardoublepage
  \addpenalty\@secpenalty\nobreak
  \secdef\@section\@ssection}
\def\@section[#1]#2{%
  \ifnum\c@secnumdepth>0\relax
     \refstepcounter{section}%
     \addcontentsline{toc}{section}{%
       \@sectionprefix\thesection\@sectionsuffix
       \texorpdfstring{\quad}{ }#1}%
  \else
     \addcontentsline{toc}{section}{#1}%
  \fi
  {\noindent\raggedright\interlinepenalty\@M
   \large\bfseries
   \ifnum\c@secnumdepth>0\relax
      \@sectionprefix\thesection\@sectionsuffix
      \quad\MakeUppercase{#2}%
   \else
      \MakeUppercase{#2}%
   \fi%
   \\[-10pt]\rule{\textwidth}{3pt}%
   \@afterheading
   \nobreak\par}}
\def\@ssection#1{%
  \phantomsection
  \addcontentsline{toc}{section}{#1}%
  {\noindent\raggedright\interlinepenalty\@M
   \large\bfseries
      \MakeUppercase{#1}%
   \\[-10pt]\rule{\textwidth}{3pt}%
   \@afterheading
   \nobreak\par}}
\renewcommand\subsection{\par
  \addpenalty\@secpenalty\nobreak
  \secdef\@subsection\@ssubsection}
\def\@subsection[#1]#2{%
  \ifnum\c@secnumdepth>1\relax
     \refstepcounter{subsection}%
     \addcontentsline{toc}{subsection}{%
       \thesubsection\texorpdfstring{\quad}{ }#1}%
  \else
     \addcontentsline{toc}{subsection}{#1}%
  \fi
  {\noindent\raggedright\interlinepenalty\@M
   \normalsize\bfseries
   \ifnum\c@secnumdepth>0\relax
      \thesubsection\quad#2%
   \else%
      #2%
   \fi%
   \@afterheading
   \nobreak\par}}
\def\@ssubsection#1{%
  \phantomsection
  \addcontentsline{toc}{subsection}{#1}%
  {\noindent\raggedright\interlinepenalty\@M
   \normalsize\bfseries
    #1%
   \@afterheading
   \nobreak\par}}
\renewcommand\appendix{%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand \thesection{\@Alph\c@section}%
  \renewcommand \thesubsection{\@Alph\c@section.\@arabic\c@subsection}%
  \def\@sectionprefix{Appendix~}%
  \def\@sectionsuffix{:}}
\def\specialsection#1{%
  \par\cleardoublepage
  \addpenalty\@secpenalty\nobreak
  {\noindent\raggedright\interlinepenalty\@M
   \large\bfseries
      \MakeUppercase{#1}%
   \\[-10pt]\rule{\textwidth}{3pt}%
   \@afterheading
   \nobreak\par}}
\renewcommand\tableofcontents{%
  \specialsection{\contentsname}%
  \@starttoc{toc}}
\renewcommand\listoffigures{%
  \specialsection{\listfigurename}%
  \@starttoc{lof}}
\renewcommand\listoftables{%
  \specialsection{\listtablename}%
  \@starttoc{lot}}
\renewenvironment{thebibliography}[1]
     {\section*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
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
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\renewenvironment{theindex}
               {\section*{\indexname}%
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\clearpage}
\endinput
%%
%% End of file `estcpmm.cls'.
