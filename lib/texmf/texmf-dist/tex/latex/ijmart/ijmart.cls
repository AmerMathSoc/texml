%%
%% This is file `ijmart.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ijmart.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from ijmart.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file ijmart.dtx.
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
\ProvidesClass{ijmart}
[2013/06/23 v1.7 Typesetting articles for The Israel Journal of Mathematics]
\def\@classname{ijmart}%
\newif\ifijm@french
\ijm@frenchfalse
\DeclareOption{french}{\ijm@frenchtrue}
\long\def\ijm@size@warning#1{%
  \ClassWarning{\@classname}{Size-changing option #1 will not be
    honored}}%
\DeclareOption{8pt}{\ijm@size@warning{\CurrentOption}}%
\DeclareOption{9pt}{\ijm@size@warning{\CurrentOption}}%
\DeclareOption{10pt}{\ijm@size@warning{\CurrentOption}}%
\DeclareOption{11pt}{\ijm@size@warning{\CurrentOption}}%
\DeclareOption{12pt}{\ijm@size@warning{\CurrentOption}}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\InputIfFileExists{ijmart.cfg}{%
  \ClassInfo{ijmart}{%
    Loading configuration file ijmart.cfg}}{%
  \ClassInfo{ijmart}{%
    Configuration file ijmart.cfg is not found}}
\ProcessOptions\relax
\PassOptionsToClass{10pt}{amsart}
\LoadClass{amsart}
\RequirePackage{ifpdf, fancyhdr, lastpage}
\def\@typesizes{%
  \or{5}{7}\or{6}{8}\or{7}{9}\or{8}{11.2}\or{9}{12.6}%
  \or{10}{14}% normalsize
  \or{\@xipt}{15}\or{\@xiipt}{16.8}\or{\@xivpt}{19.8}%
  \or{\@xviipt}{23.3}\or{\@xxpt}{28}}%
\normalsize \linespacing=\baselineskip
\setlength{\paperheight}{636.77bp}
\setlength{\paperwidth}{429.41bp}
\ifpdf\relax
  \pdfpageheight=\paperheight
  \pdfpagewidth=\paperwidth
  \pdfvorigin=0.9in
  \pdfhorigin=1in
\fi
\setlength{\headheight}{32pt}
\setlength{\footskip}{42pt}%
\setlength\topmargin{50bp}
\addtolength\topmargin{-0.9in}
\addtolength\topmargin{-\topskip}
\addtolength\topmargin{-\headsep}
\@settopoint\topmargin
\setlength\@tempdima{\paperheight}
\addtolength\@tempdima{-\topmargin}
\addtolength\@tempdima{-26bp} % Bottom margin
\addtolength\@tempdima{-\headheight}
\addtolength\@tempdima{-\headsep}
\addtolength\@tempdima{-\footskip}
\addtolength\@tempdima{-1in}
\divide\@tempdima\baselineskip
\@tempcnta=\@tempdima
\setlength\textheight{\@tempcnta\baselineskip}
\addtolength\textheight{\topskip}
\setlength\evensidemargin{43bp}
\addtolength{\evensidemargin}{-1in}
\setlength\oddsidemargin{43bp}
\addtolength{\oddsidemargin}{-1in}
\setlength\textwidth{\paperwidth}
\addtolength{\textwidth}{-1in}
\addtolength\textwidth{-\evensidemargin}
\addtolength\textwidth{-43bp} % right margin
\@settopoint\textwidth
\setlength\parindent{1em}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\pagestyle{fancy}
\fancyhead[LO]{\footnotesize Vol.~\currentvolume, \currentyear}
\fancyhead[CO]{\footnotesize\shorttitle}
\fancyhead[RO]{\footnotesize\thepage}
\fancyhead[LE]{\footnotesize\thepage}
\fancyhead[CE]{\footnotesize\shortauthors}
\fancyhead[RE]{\footnotesize Isr. J. Math.}
\fancyfoot{}
\fancypagestyle{firstpage}{%
  \fancyhf{}%
  \chead{\tiny%
    ISRAEL JOURNAL OF MATHEMATICS \textbf{\currentvolume}
    (\currentyear),
    \start@page--\end@page\\[0.5ex]
  DOI: \@doiinfo}%
   \cfoot{\thepage}}%
\renewcommand{\author}[2][]{%
  \ifx\@empty\authors
    \gdef\authors{#2}%
    \gdef\addresses{\author{#2}}%
  \else
    \g@addto@macro\authors{\and#2}%
    \g@addto@macro\addresses{\and\author{#2}}%
  \fi
  \def\@tempa{#1}%
  \ifx\@tempa\@empty\relax
   \ifx\@empty\shortauthors
     \gdef\shortauthors{#2}%
   \else
     \g@addto@macro\shortauthors{\and#2}%
   \fi
  \else
  \ifx\@empty\shortauthors
     \gdef\shortauthors{#1}%
   \else
     \g@addto@macro\shortauthors{\and#1}%
   \fi
 \fi
}%
\newbox\abstractbox
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in AMS-derived document classes; reported}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
  \vglue 10pt plus 6pt minus 6pt%
    \normalfont\tiny
    \centering\MakeUppercase{\abstractname}\par%
    \Small
    \list{}{\labelwidth\z@
      \leftmargin3pc \rightmargin\leftmargin
      \listparindent\normalparindent \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
  \item[]%
}{%
    \vspace*{-10pt}
  \endlist\egroup
  \ifx\@setabstract\relax \@setabstracta \fi
}%
\def\pagespan#1#2{\pagenumbering{arabic}\setcounter{page}{#1}%
  \def\start@page{#1}%
  \ifnum\c@page<\z@ \pagenumbering{roman}\setcounter{page}{-#1}%
    \def\start@page{\romannumeral#1}%
  \fi%
  \def\@tempa{#2}%
  \ifx\@tempa\@empty\def\end@page{\pageref{LastPage}}%
  \else\def\end@page{#2}\fi}
\pagespan{1}{}
\def\doiinfo#1{\gdef\@doiinfo{#1}}
\doiinfo{10.1007/s000000000000000000000000}
\def\thanks#1{\footnotemark
    \protected@xdef\thankses{\thankses
        \protect\footnotetext[\the\c@footnote]{\small#1}}%
}
\let\@thanks\@empty
\def\@maketitle@hook{%
  \uppercasenonmath\shortauthors
  \renewcommand\thefootnote{\ifcase\c@footnote\relax
    \or\@fnsymbol{1}%
    \or\@fnsymbol{1}\@fnsymbol{1}%
    \or\@fnsymbol{2}%
    \or\@fnsymbol{2}\@fnsymbol{2}%
    \or\@fnsymbol{3}%
    \or\@fnsymbol{3}\@fnsymbol{3}%
    \or\@fnsymbol{4}%
    \or\@fnsymbol{4}\@fnsymbol{4}%
    \or\@fnsymbol{5}%
    \or\@fnsymbol{5}\@fnsymbol{5}%
    \or\@fnsymbol{6}%
    \or\@fnsymbol{6}\@fnsymbol{6}%
  \fi}%
  \def\@makefnmark{\@textsuperscript{\normalfont\@thefnmark}}%
  \long\def\@makefntext##1{\noindent\hangindent=2em\hangafter=1
    \hb@xt@2em{%
      \hss\@textsuperscript{\normalfont\footnotesize\@thefnmark\space}}##1}%
  \def\footnoterule{\kern-3pt\hrule width 2in\kern 2.6pt}
  \setcounter{footnote}{0}%
}%
\def\@adminfootnotes{}%
\renewcommand{\andify}{%
  \nxandlist{\unskip, }{\unskip{} \@@and~}{\unskip{} \@@and~}}
\def\@@and{AND}
\ifijm@french\def\@@and{ET}\fi
\def\@@by{BY}
\ifijm@french\def\@@by{PAR}\fi
\def\curraddrname{Current address:}%
\def\emailaddrname{e-mail:}%
\def\urladdrname{URL:}%
\ifijm@french
  \def\curraddrname{Adresse actuelle:}%
  \def\emailaddrname{courriel:}%
\fi
\def\@settitle{%
    \begin{center}%
    \makebox[0pt]{\hphantom{\@title}}%
    \def\thanks##1{\addtocounter{footnote}{-1}\footnotemark}%
    \uppercasenonmath\@title
      \Large\baselineskip=14pt\lineskiplimit=2pt\lineskip=2pt\@title%
    \end{center}}%
\def\@setauthors{\vglue 21pt plus 6pt minus 3pt%
   \begin{center}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\par\curraddrname{}\par
      ##2\par}\endgroup}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\par\emailaddrname{}~%
      ##2\par}\endgroup}%
  \def\urladdr##1##2{\begingroup
    \@ifnotempty{##2}{\par\urladdrname{}~%
      ##2\par}\endgroup}%
      \if\authors\@empty\relax\else{\normalfont\tiny\@@by}\par\medskip
      \def\author##1{{\normalsize\scshape##1}\par\medskip}
      \def\and{\par\bigskip{\normalfont\tiny\@@and}\par\medskip}
     \small\itshape\addresses
   \end{center}}%
\let\@origmaketitle=\@maketitle
\def\@maketitle{\@origmaketitle
  \thankses
  \ifx\@date\@empty\else
    \def\thefootnote{}%
    \footnotetext{\small\@date}\fi%
  \gdef\thefootnote{\@arabic\c@footnote}}
\def\enddoc@text{}
\setcounter{tocdepth}{1}
\renewcommand\contentsnamefont{\scshape\footnotesize}
\def\@starttoc#1#2{\begingroup
  \setTrue{#1}%
  \par\removelastskip\vskip\z@skip
  \@startsection{}\@M\z@{\linespacing\@plus\linespacing}%
    {.5\linespacing}{\centering\contentsnamefont}{#2}%
  \ifx\contentsname#2%
  \else \addcontentsline{toc}{section}{#2}\fi
  \list{}{\labelwidth\z@
    \leftmargin2.4pc \rightmargin\leftmargin
    \listparindent\z@ \itemindent\z@
    \parsep\z@ \@plus\p@}%
  \item[]\makeatletter%
    \small\@input{\jobname.#1}\endlist%
  \if@filesw
    \@xp\newwrite\csname tf@#1\endcsname
    \immediate\@xp\openout\csname tf@#1\endcsname \jobname.#1\relax
  \fi
  \global\@nobreakfalse \endgroup
  \addvspace{32\p@\@plus14\p@}%
  \let\tableofcontents\relax
}%
\newcommand\@dotsep{4.5}
\def\@tocline#1#2#3#4#5#6#7{\relax
  \ifnum #1>\c@tocdepth % then omit
  \else
    \par \addpenalty\@secpenalty\addvspace{#2}%
    \begingroup \hyphenpenalty\@M
    \@ifempty{#4}{%
      \@tempdima\csname r@tocindent\number#1\endcsname\relax
    }{%
      \@tempdima#4\relax
    }%
    \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
    \rightskip\@pnumwidth plus4em \parfillskip-\@pnumwidth
    #5\leavevmode\hskip-\@tempdima #6\nobreak\relax
    \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
    \hbox to\@pnumwidth{\@tocpagenum{#7}}\par
    \nobreak
    \endgroup
  \fi}%
\def\l@section{%
  \@tocline{1}{0pt}{1pc}{}{%
    \ifnum\c@tocdepth>1\bfseries\fi}}
\def\l@subsection{\@tocline{2}{0pt}{2.8pc}{}{}}
\def\l@subsubsection{\@tocline{3}{0pt}{4.6pc}{}{}}
\def\@captionheadfont{\normalfont}
\let\@secnumfont\@empty
\def\section{\@startsection{section}{1}%
  \z@{20pt plus 4pt minus 4pt}{0.5\linespacing}%
 {\normalfont\bfseries}}%
\def\centeredsection{\@startsection{section}{1}%
  \z@{20pt plus 4pt minus 4pt}{0.5\linespacing}%
 {\normalfont\bfseries\centering}}%
\def\subsection{\@startsection{subsection}{2}%
  \z@{.5\linespacing\@plus.7\linespacing}{-0.5em}%
 {\normalfont\scshape}}%
\def\subsubsection{\@startsection{subsubsection}{3}%
  \z@{.5\linespacing\@plus.7\linespacing}{-0.5em}%
 {\normalfont\itshape}}%
\def\paragraph{\@startsection{paragraph}{4}%
  \z@\z@{-0.5em}%
 {\normalfont}}%
\def\subparagraph{\@startsection{subparagraph}{5}%
  \z@\z@{-0.5em}%
 {\normalfont}}%
\let\@afterindenttrue\@afterindentfalse
\@afterindentfalse
\def\appendix{\par\c@section\z@ \c@subsection\z@
   \let\sectionname\appendixname
   \def\thesection{\@Alph\c@section}%
   \def\@tochangmeasure##1{}}
\newtheoremstyle{plain}{0.5\linespacing}{0.5\linespacing}{\slshape}{0pt}%
   {\scshape}{:}{0.5em}{\thmname{#1}\thmnumber{ #2}\thmnote{\upshape{} (#3)}}
\newtheoremstyle{definition}{0.5\linespacing}{0.5\linespacing}%
   {\upshape}{0pt}%
   {\slshape}{:}{0.5em}{\thmname{#1}\thmnumber{ #2}\thmnote{\upshape{} (#3)}}
\newtheoremstyle{remark}{0.5\linespacing}{0.5\linespacing}%
   {\upshape}{0pt}%
   {\scshape}{:}{0.5em}{\thmname{#1}\thmnumber{ #2}\thmnote{\upshape{} (#3)}}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep
    \slshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
\DeclareRobustCommand{\qed}{%
  \leavevmode\unskip\penalty9999 \hbox{}\nobreak
  \ifmmode
     \makebox[0pt][l]{\qquad\hbox{\qedsymbol}}%
  \else
     \qquad\hbox{\qedsymbol}\fi}%
\def\mqedhere{\ensuremath{\text{\qedhere}}}%
\def\qedsymbol{\rule[0.47pt]{4pt}{6pt}}%
\newenvironment{namedprop}{%
  \namedprop@}{%
  \end{namedprop@thm}%
  \egroup}
\newenvironment{namedprop*}{%
  \namedprop@star@}{%
  \end{namedprop@thm}%
  \egroup}
\def\namedprop@star@#1#2{%
  \@ifnextchar[{\namedprop@star@@{#1}{#2}}{\namedprop@star@@{#1}{#2}[]}}%
\def\namedprop@star@@#1#2[#3]{%
  \bgroup
  \let\namedprop@thm\relax
  \theoremstyle{#1}
  \newtheorem*{namedprop@thm}{#2}
  \begin{namedprop@thm}[#3]}
\def\namedprop@#1#2#3{%
  \@ifnextchar[{\namedprop@@{#1}{#2}{#3}}{\namedprop@@{#1}{#2}{#3}[]}}%
\def\namedprop@@#1#2#3[#4]{%
  \bgroup
  \let\namedprop@thm\relax
  \theoremstyle{#1}
  \newtheorem{namedprop@thm}[#2]{#3}
  \begin{namedprop@thm}[#4]}
\renewcommand{\@bibtitlestyle}{%
  \@xp\centeredsection\@xp*\@xp{\refname}%
}%
\endinput
%%
%% End of file `ijmart.cls'.
