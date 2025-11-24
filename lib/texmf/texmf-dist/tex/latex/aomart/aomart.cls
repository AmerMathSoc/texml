%%
%% This is file `aomart.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% aomart.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from aomart.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file aomart.dtx.
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
\ProvidesClass{aomart}
[2015/02/18 v1.14a Typesetting articles for the Annals of Mathematics]
\long\def\aom@size@warning#1{%
  \ClassWarning{aomart}{Size-changing option #1 will not be
    honored}}%
\DeclareOption{8pt}{\aom@size@warning{\CurrentOption}}%
\DeclareOption{9pt}{\aom@size@warning{\CurrentOption}}%
\DeclareOption{10pt}{\aom@size@warning{\CurrentOption}}%
\DeclareOption{11pt}{\aom@size@warning{\CurrentOption}}%
\DeclareOption{12pt}{\aom@size@warning{\CurrentOption}}%
\newif\if@aom@manuscript@mode
\@aom@manuscript@modefalse
\DeclareOption{manuscript}{\@aom@manuscript@modetrue}
\newif\if@aom@screen@mode
\@aom@screen@modefalse
\DeclareOption{screen}{\@aom@screen@modetrue}
\newif\if@aom@olddoi
\@aom@olddoifalse
\DeclareOption{olddoi}{\@aom@olddoitrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\InputIfFileExists{aomart.cfg}{%
  \ClassInfo{aomart}{%
    Loading configuration file aomart.cfg}}{%
  \ClassInfo{aomart}{%
    Configuration file aomart.cfg is not found}}
\ProcessOptions\relax
\LoadClass[11pt]{amsart}
\RequirePackage{fancyhdr, lastpage, ifpdf}
\RequirePackage[breaklinks,colorlinks]{hyperref}
\if@aom@screen@mode
\hypersetup{linkcolor=blue,citecolor=blue,
  urlcolor=blue, pdfpagescrop={110 705 500 80}}%
\else\if@aom@manuscript@mode
\hypersetup{linkcolor=blue,citecolor=blue,
  urlcolor=blue}%
\else
\hypersetup{linkcolor=black,citecolor=black,
  urlcolor=black}%
\fi\fi
\urlstyle{rm}
\def\@aom@by{By}
\def\@aom@and{and}
\AtBeginDocument{\@ifpackageloaded{babel}{%
  \addto\captionsfrench{\def\@aom@by{Par}\def\@aom@and{et}}%
  \addto\captionsgerman{\def\@aom@by{Von}\def\@aom@and{und}}%
  \addto\captionsenglish{\def\@aom@by{By}\def\@aom@and{and}}}{}}
\RequirePackage{yhmath}
\IfFileExists{cmtiup.sty}{%
  \RequirePackage{cmtiup}}{%
  \ClassWarning{aomart}{The package mdputu is not found.\MessageBreak
    You need this package to get italics with upright digits!}}
\def\specialdigits{}%
\let\sishape=\itshape
\let\textsi=\textit
\def\@typesizes{%
  \or{\@vipt}{9}\or{\@viipt}{9}\or{\@viiipt}{9}\or{\@ixpt}{12}%
  \or{\@xpt}{13}%
  \or{\@xipt}{14}% normalsize
  \or{\@xiipt}{15}\or{13}{17}\or{\@xviipt}{20}%
  \or{19}{23.2}\or{22}{27.8}}%
\normalsize \linespacing=\baselineskip
\let\widebar\overline
\setlength{\textwidth}{31pc}
\setlength{\textheight}{48pc}
\oddsidemargin=.65in
\evensidemargin=.65in
\setlength{\topskip}{12pt}
\setlength{\abovedisplayskip}{6.95pt plus3.5pt minus 3pt}
\setlength{\belowdisplayskip}{6.95pt plus4.5pt minus 3pt}
\setlength{\skip\footins}{20pt}
\setlength{\dimen\footins}{3in}
\setlength\footskip{30pt}
\setlength{\parindent}{22pt}
\setlength{\parskip}{\z@}
\widowpenalty=10000
\clubpenalty=10000
\setlength{\headsep}{14pt}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\if@aom@manuscript@mode
  \newsavebox{\@aom@linecount}
  \savebox{\@aom@linecount}[4em][t]{\parbox[t]{4em}{%
      \@tempcnta\@ne\relax
      \loop{\underline{\scriptsize\the\@tempcnta}}\\
      \advance\@tempcnta by \@ne\ifnum\@tempcnta<43\repeat}}
\fi
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
\fancyhead[CO]{\scriptsize\shorttitle}
\fancyhead[RO,LE]{\footnotesize\thepage}
\if@aom@manuscript@mode
  \fancyhead[LE]{\footnotesize\thepage\begin{picture}(0,0)%
      \put(-26,-25){\usebox{\@aom@linecount}}%
    \end{picture}}
  \fancyhead[LO]{\begin{picture}(0,0)%
      \put(-21,-25){\usebox{\@aom@linecount}}%
    \end{picture}}
  \fancyfoot[C]{\scriptsize Proof: page numbers may be temporary}
\fi
\fancyhead[CE]{\scriptsize\MakeUppercase\shortauthors}
\fancypagestyle{firstpage}{%
  \fancyhf{}%
  \if@aom@manuscript@mode
    \lhead{\begin{picture}(0,0)%
        \put(-21,-25){\usebox{\@aom@linecount}}%
      \end{picture}}
  \fi
  \chead{\scriptsize%
    \href{\@annalsurl}{Annals of Mathematics} \textbf{\currentvolume}
    (\currentyear),
    \start@page%
    \def\tempa{\pageref{LastPage}}%
    \edef\tempb{\start@page}%
    \ifx\tempa\end@page
      \edef\tempa{\HyPsd@@@pageref{LastPage}}%
    \else
       \edef\tempa{\end@page}%
    \fi
    \ifx\tempa\tempb\else--\end@page\fi\\
  \ifx\@doinumber\@empty\else
  \edef\@doinumber{\@doinumber}%
  \expandafter\doi\expandafter{\@doinumber}\fi}%
   \cfoot{\footnotesize\thepage}}%
\def\annalsurl#1{\gdef\@annalsurl{#1}}
\annalsurl{http://annals.math.princeton.edu/about}
\@onlypreamble{\title}
\@onlypreamble{\author}
\@onlypreamble{\email}
\@onlypreamble{\address}
\@onlypreamble{\curraddr}
\@onlypreamble{\urladdr}
\@onlypreamble{\givenname}
\@onlypreamble{\fulladdress}
\@onlypreamble{\surname}
\@onlypreamble{\thanks}
\@onlypreamble{\keyword}
\@onlypreamble{\subject}
\@onlypreamble{\received}
\@onlypreamble{\revised}
\@onlypreamble{\accepted}
\@onlypreamble{\published}
\@onlypreamble{\publishedonline}
\@onlypreamble{\proposed}
\@onlypreamble{\seconded}
\@onlypreamble{\corresponding}
\@onlypreamble{\editor}
\@onlypreamble{\version}
\@onlypreamble{\volumenumber}
\@onlypreamble{\issuenumber}
\@onlypreamble{\publicationyear}
\@onlypreamble{\copyrightnote}
\@onlypreamble{\copyrighyear}
\@onlypreamble{\papernumber}
\@onlypreamble{\startpage}
\@onlypreamble{\endpage}
\@onlypreamble{\doinumber}
\@onlypreamble{\mrnumber}
\@onlypreamble{\zblnumber}
\let\givenname=\@gobble
\let\surname=\@gobble
\let\fulladdress=\@gobble
\def\keyword#1{\ifx\@keywords\@empty\gdef\@keywords{#1}\else
  \g@addto@macro\@keywords{, #1}\fi}
\let\@subjects\@empty
\def\subject#1#2#3{\ifx\@subjects\@empty\gdef\@subjects{#1:#2:#3}\else
  \g@addto@macro\@subjects{, #1:#2:#3}\fi}
\def\formatdate#1{\@formatdate#1\@endformatdate}
\def\@formatdate#1-#2-#3\@endformatdate{%
  \@tempcnta=#3\relax
  \ifcase#2\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\the\@tempcnta,\space#1}
\def\received#1{\def\@received{#1}}
\let\@received\@empty
\def\revised#1{\def\@revised{#1}}
\let\@revised\@empty
\def\accepted#1{\def\@accepted{#1}}
\let\@accepted\@empty
\def\published#1{\def\@published{#1}}
\let\@published\@empty
\def\publishedonline#1{\def\@publishedonline{#1}}
\let\@publishedonline\@empty
\def\volumenumber#1{\def\currentvolume{#1}}
\def\issuenumber#1{\def\currentissue{#1}}
\def\publicationyear#1{\def\currentyear{#1}}
\def\papernumber#1{\def\currentpaper{#1}}
\papernumber{0000}
\def\startpage#1{\pagenumbering{arabic}\setcounter{page}{#1}%
  \def\start@page{#1}%
  \ifnum\c@page<\z@ \pagenumbering{roman}\setcounter{page}{-#1}%
    \def\start@page{\romannumeral#1}%
  \fi}
\def\endpage#1{\def\@tempa{#1}%
  \ifx\@tempa\@empty\def\end@page{\pageref{LastPage}}%
  \else\def\end@page{#1}\fi}
\def\pagespan#1#2{\startpage{#1}\endpage{#2}}
\pagespan{1}{}
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{aomart}{Abstract should precede
      \protect\maketitle\space in AMS derived classes}%
  \fi
  \global\setbox\abstractbox=\vtop\bgroup%
    \vglue1pc%
    {\centering\normalfont\normalsize\bfseries\abstractname\par\vglue1pc}%
    \list{}{\labelwidth\z@%
      \leftmargin3pc \rightmargin\leftmargin%
      \listparindent\normalparindent \itemindent\normalparindent%
      \parsep\z@ \@plus\p@%
      \let\fullwidthdisplay\relax%
    }%
    \item[]\normalfont\Small%
}{%
  \endlist\egroup%
  \ifx\@setabstract\relax\@setabstracta\fi%
}

\let\proposed\@gobble
\let\seconded\@gobble
\let\corresponding\@gobble
\let\version\@gobble
\def\doinumber#1{\gdef\@doinumber{#1}}
\doinumber{10.4007/annals.\currentyear.\currentvolume.\currentissue.\currentpaper}
\def\mrnumber#1{\gdef\@mrnumber{#1}}
\mrnumber{}
\def\zblnumber#1{\gdef\@zblnumber{#1}}
\zblnumber{}
\def\copyrightyear#1{\def\@copyrightyear{#1}}
\copyrightyear{}
\def\copyrightnote#1{\def\@copyrightnote{#1}}
\copyrightnote{\textcopyright~%
  \ifx\@empty\@copyrightyear\currentyear\else\@copyrightyear\fi~%
  Department of Mathematics, Princeton University}
\newwrite\@mainrpi
\def\aom@write@paper@info{%
  \bgroup
  \if@filesw
    \openout\@mainrpi\jobname.rpi%
    \def\and{\string\and\space}%
    \def\pkg##1{ ##1 }%
   \protected@write\@mainrpi{}%
    {\@percentchar authors=\authors}%
   \protected@write\@mainrpi{}%
    {\@percentchar title=\@title}%
   \protected@write\@mainrpi{}%
    {\@percentchar year=\currentyear}%
   \protected@write\@mainrpi{}%
    {\@percentchar volume=\currentvolume}%
   \protected@write\@mainrpi{}%
    {\@percentchar issue=\currentissue}%
   \protected@write\@mainrpi{}%
    {\@percentchar paper=\currentpaper}%
   \protected@write\@mainrpi{}%
    {\@percentchar startpage=\start@page}%
   \protected@write\@mainrpi{}%
    {\@percentchar endpage=\@tempa}%
   \protected@write\@mainrpi{}%
    {\@percentchar doi=\@doinumber}%
    \closeout\@mainrpi
    \fi
\egroup}
\def\@maketitle@hook{\aom@write@paper@info\global\let\@maketitle@hook\@empty}
\def\@settitle{\begin{center}%
  \baselineskip20\p@\relax
    \bfseries\LARGE
  \@title
  \ifpdf
    \hypersetup{pdftitle=\@title}%
  \fi
  \end{center}%
}
\def\@setauthors{%
  \ifx\authors\@empty\relax\else
    \begingroup
    \def\thanks{\protect\thanks@warning}%
    \trivlist
    \centering\footnotesize \@topsep30\p@\relax
    \advance\@topsep by -\baselineskip
    \item\relax
    \def\@@and{{\upshape \@aom@and}}
    \author@andify\authors
    \ifpdf
      \hypersetup{pdfauthor=\authors}%
    \fi
    \def\\{\protect\linebreak}%
    \small \@aom@by{} \scshape\authors%
    \ifx\@empty\contribs
    \else
      ,\penalty-3 \space \@setcontribs
      \@closetoccontribs
    \fi
    \endtrivlist
    \endgroup
    \fi}
\def\@setcontribs{%
  \@xcontribs
  {\scshape \xcontribs}%
}
\def\@adminfootnotes{%
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \ifx\@empty\@date\else \@footnotetext{\@setdate}\fi
  \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \ifx\@empty\@keywords\else\@setkeywords\fi
  \ifx\@empty\@subjects\else\@setsubjects\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks}%
  \fi
  \ifx\@empty\@copyrightnote\else \@footnotetext{%
    \def\par{\let\par\@par}\@copyrightnote\@addpunct.}%
  \fi
}
\def\@setkeywords{%
    \ifpdf
      \hypersetup{pdfkeywords=\@keywords}%
    \fi
}
\def\@setsubjects{%
    \ifpdf
      \hypersetup{pdfsubject=\@subjects}%
    \fi
}
\def\@@and{\MakeLowercase{\@aom@and}}
\def\enddoc@text{%
  \ifx\@empty\@translators \else\@settranslators\fi
  \ifx\@empty\@received \else\@setreceived\fi
  \ifx\@empty\@revised \else\@setrevised\fi
  \ifx\@empty\addresses \else\@setaddresses\fi}
\def\@setreceived{{\centering(Received: \@received)\par}}
\def\@setrevised{{\centering(Revised: \@revised)\par}}
\def\@setaccepted{{\centering(Accepted: \@accepted)\par}}
\def\@setpublished{{\centering(Published: \@published)\par}}
\def\@setpublishedonline{{\centering(Published online: \@publishedonline)\par}}
\def\emailaddrname{{\itshape E-mail}}
\def\@setaddresses{\par
  \nobreak \begingroup
\footnotesize
  \def\author##1{\nobreak\addvspace\bigskipamount}%
  \def\\{\unskip, \ignorespaces}%
  \interlinepenalty\@M
  \def\address##1##2{\begingroup
    \par\addvspace\bigskipamount\indent
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\scshape\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent\curraddrname
      \@ifnotempty{##1}{, \ignorespaces\scshape##1\unskip}\hskip0.2em:\space
      \scshape##2\par}\endgroup}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent\emailaddrname
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\hskip0.2em:\space
      \href{mailto:##2}{\nolinkurl{##2}}\par}\endgroup}%
  \def\urladdr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}%
      \url{##2}\par}\endgroup}%
  \addresses
  \endgroup
}
\renewcommand\contentsnamefont{\bfseries}
\def\section{\@startsection{section}{1}%
  \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\bfseries\centering}}
\def\subsection{\@startsection{subsection}{2}%
  {\parindent}{.5\linespacing}{-.5em}%
  {\normalfont\itshape}}
\def\oldsubsections{%
\gdef\subsection{\@startsection{subsection}{2}%
  {\parindent}{.5\linespacing\@plus.7\linespacing}{-.5em}%
  {\normalfont\itshape}}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  {\parindent}{.5\linespacing}{-.5em}%
  {\normalfont\itshape}}
\providecommand\Hy@AlphNoErr[1]{%
  \ifnum\value{#1}>26 %
    Alph\number\value{#1}%
  \else
    \ifnum\value{#1}<1 %
      Alph\number\value{#1}%
    \else
      \Alph{#1}%
    \fi
  \fi
}%
\def\appendix{\par\c@section\z@ \c@subsection\z@
  \gdef\theHsection{\Hy@AlphNoErr{section}}%
   \let\sectionname\appendixname
   \def\thesection{{\upshape\@Alph\c@section}}}
\def\@captionheadfont{\normalfont}
\newtheoremstyle{plain}{0.5\linespacing}{0.5\linespacing}{\sishape}%
   {\parindent}{\scshape}{.}{0.5em}%
   {\thmname{#1}\thmnumber{ #2}\thmnote{\normalfont{} (#3)}}
\newtheoremstyle{definition}{0.5\linespacing}{0.5\linespacing}%
   {\upshape}{\parindent}%
   {\sishape}{.}{0.5em}%
   {\thmname{#1}\thmnumber{ #2}\thmnote{\normalfont{} (#3)}}
\newtheoremstyle{remark}{0.5\linespacing}{0.5\linespacing}%
   {\upshape}{\parindent}%
   {\sishape}{.}{0.5em}%
   {\thmname{#1}\thmnumber{ #2}\thmnote{\normalfont{} (#3)}}
\renewcommand{\newtheorem}{\@ifstar{\@aom@newthm@star}{\@aom@newthm}}
\def\@aom@newthm@star{\@ifnextchar[{\@aom@newthm@star@}{\@aom@newthm@star@[]}}
\def\@aom@newthm{\@ifnextchar[{\@aom@newthm@}{\@aom@newthm@[]}}
\def\@aom@newthm@star@[#1]{\@xnthm *}
\def\@aom@newthm@[#1]{\@xnthm \relax}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep\hskip\parindent
        \itshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
\def\repeatedauthors#1{\ClassWarning{aomart}{The command is obsolte}#1}
\let\bysame@@orig=\bysame
\def\bysame{\ClassWarning{aomart}{We no longer omit
    repeated authors}\bysame@@orig}
\def\doi#1{\if@aom@olddoi\href{http://dx.doi.org/#1}{doi: \path{#1}}%
\else\url{http://dx.doi.org/#1}\fi}
\def\mr#1{\href{http://www.ams.org/mathscinet-getitem?mr=#1}{MR~\path{#1}}}
\def\zbl#1{\href{http://www.zentralblatt-math.org/zmath/en/search/?q=an:#1}{Zbl~\path{#1}}}
\def\arxiv#1{\href{http://www.arxiv.org/abs/#1}{arXiv~\path{#1}}}
\def\jfm#1{\href{http://www.emis.de/cgi-bin/JFM-item?#1}{JFM~\path{#1}}}
\renewcommand{\bibliofont}{\small}
\def\EditorialComment#1{\if@aom@manuscript@mode\bgroup
  \marginparwidth=75pt\marginpar{\scriptsize\raggedright#1}\egroup\fi}
\def\@fullref#1#2#3#4{\hyperref[#3]{#1~#2\ref*{#3}#4}}
\newcommand{\fullref}[2]{\@fullref{#1}{}{#2}{}}
\newcommand{\pfullref}[2]{\@fullref{#1}{(}{#2}{)}}
\newcommand{\bfullref}[2]{\@fullref{#1}{[}{#2}{]}}
\newcommand{\eqfullref}[2]{\hyperref[#2]{#1~\textup{\tagform@{\ref*{#2}}}}}
\def\eqnarray{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\arraycolsep1\p@
   \everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne\hskip \tw@\arraycolsep \hfil${##}$\hfil
      &\global\@eqcnt\tw@ \hskip \tw@\arraycolsep
         $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
         \tabskip\z@skip
      \cr
}
\endinput
%%
%% End of file `aomart.cls'.
