%%
%% This is file `qam-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% qam-l.dtx 
%% 
%% This is a generated file.
%% 
%% Copyright 1995, 2004, 2013, 2016 American Mathematical Society.
%% 
%% American Mathematical Society
%% Technical Support
%% Publications Technical Group
%% 201 Charles Street
%% Providence, RI 02904
%% USA
%% tel: (401) 455-4080
%%      (800) 321-4267 (USA and Canada only)
%% fax: (401) 331-3842
%% email: tech-support@ams.org
%% 
%% Unlimited copying and redistribution of this file are permitted as
%% long as this file is not modified.  Modifications, and distribution
%% of modified versions, are permitted, but only if the resulting file
%% is renamed.
%% 
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{qam-l}[2017/10/18 v2.12 Quarterly of Applied Mathematics]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions\relax
\LoadClass[reqno]{amsart}[2009/07/02]
\count@\@mainsize
\advance\count@-10
\def\@tempa{%   % 10pt
  \def\@typesizes{%
    \or{5}{6}\or{6}{8}\or{7}{9}\or{8}{10}\or{9}{11}%
    \or{10}{13}% normalsize
    \or{\@xipt}{14}\or{\@xiipt}{15}\or{\@xivpt}{17}%
    \or{\@xviipt}{20}\or{\@xxpt}{24}}%
}
\def\@tempb{%   % 11pt
  \def\@typesizes{%
    \or{6}{7}\or{7}{8}\or{8}{10}\or{9}{11}\or{10}{12}%
    \or{\@xipt}{14}% normalsize
    \or{\@xiipt}{14}\or{\@xivpt}{17}\or{\@xviipt}{20}%
    \or{\@xxpt}{24}\or{\@xxvpt}{30}}%
}
\def\@tempc{%   % 12pt
  \def\@typesizes{%
    \or{7}{8}\or{8}{10}\or{9}{11}\or{10}{12}\or{\@xipt}{13}%
    \or{\@xiipt}{16}% normalsize
    \or{\@xivpt}{17}\or{\@xviipt}{20}\or{\@xxpt}{24}%
    \or{\@xxvpt}{30}\or{\@xxvpt}{30}}%
}
\ifcase\count@  % 10pt
    \@tempa
\or             % 11pt
    \@tempb
\or             % 12pt
    \@tempc
\else
  \@tempa
  \ClassWarning{qam-l}{options smaller than 10pt not supported;
    defaulting to 10pt}%
\fi
\normalsize \linespacing=\baselineskip
\def\publname{QUARTERLY OF APPLIED MATHEMATICS}
\def\ISSN{0033-569X}
\newif\ifprintonly  \printonlyfalse
\AtBeginDocument{%
  \def\@logofont{\fontsize{6}{8\p@}\selectfont}%
  \def\@serieslogo{%
    \set@logo{%
      \set@publname
      \ifx\@empty\currentvolume
      \else
        \newline\volinfo
        \newline\issinfo, \pageinfo
      \fi
      \ifprintonly \else \setdoi@or@pii\fi
      \ifx\@empty\@dateposted \else \@setdateposted\fi
    }%
  }%
}
\providecommand\setdoi@or@pii{}
\providecommand\set@publname{\publname}
\newcounter{volume}
\def\issueinfo#1#2#3#4{%
  \def\currentvolume{#1}%
  \ifx\@empty\currentvolume
    \setcounter{volume}{0}%
  \else
    \setcounter{volume}{#1}%
  \fi
  \def\currentissue{#2}%
  \def\currentmonth{#3}\def\currentyear{#4}}
\def\volinfo{VOLUME \Roman{volume}, NUMBER \number0\currentissue}
\def\issinfo{\uppercase\expandafter{\currentmonth} \currentyear}
\def\pageinfo{%
  \ifnum\start@page=\z@
    PAGES 000--000
  \else
    \ifx\start@page\end@page
      PAGE \start@page
    \else
      PAGES \start@page--\end@page
    \fi
  \fi
}
\def\@copyinsfontsize{\fontsize{8}{9\p@}\normalfont\upshape}
\copyrightinfo{\currentyear}{Brown University}
\textheight=49.5pc \topskip=10pt
\textwidth=32pc
\calclayout
\renewcommand{\author}[2][]{%
  \def\@tempa{#1}
  \ifx\@empty\authors
    \ifx\@tempa\@empty
      \gdef\shortauthors{#2}%
    \else
      \gdef\shortauthors{#1}%
    \fi
    \gdef\authors{\author{#2}}%
  \else
    \if\@tempa.
    \else
      \ifx\@tempa\@empty
        \g@addto@macro\shortauthors{\and#2}%
      \else
        \g@addto@macro\shortauthors{\and#1}%
      \fi
    \fi
    \g@addto@macro\authors{\and\author{#2}}%
  \fi
}
\def\itd@convert#1#2{%
  \toks@\@emptytoks
  \def\author##1{\toks@\@xp{\the\toks@\author{##1}}}%
  \let\and\@empty \let\address\@gobbletwo
  #1\relax
  \edef#1{\the\toks@}%
}
\renewcommand{\address}[2][]{\g@addto@macro\authors{\address{#1}{#2}}}
\def\@setauthors{%
  \begin{center}%
    \Small
    \vspace{10pt}
    \leavevmode
    \scshape
    By\\[8pt]
    \let\and\@empty
    \def\author##1{\advance\@tempcnta\@ne}%
    \def\address##1##2{\advance\@tempcntb\@ne}%
    \@tempcnta=\z@  \@tempcntb=\z@
    \authors
    \ifnum\@tempcnta>\@ne \ifnum\@tempcntb=\@ne
        \oneaddress
      \else
        \sepaddresses
      \fi
    \else
      \oneaddress
    \fi
  \end{center}%
}
\def\oneaddress{%
  \begingroup
  \let\author\@iden \let\address\@gobbletwo
  \renewcommand{\andify}{%
    \nxandlist{\unskip, }{\unskip{} \textsc{and}~}{\unskip, \textsc{and}~}}%
  \uppercasenonmath\authors
  \andify\authors
  \authors
  \endgroup
  \begingroup \let\and\relax \let\author\@gobble
  \def\address##1##2{\unskip\\[12pt] \itshape##2}%
  \authors
  \endgroup
}
\def\sepaddresses{%
  \begingroup
    \baselineskip10\p@\relax
    \def\address##1##2{ ({\itshape##2}\/)}
    \def\author##1{\def\temp{##1}\leavevmode\uppercasenonmath\temp\temp}%
    \nxandlist
      {,\\[\baselineskip]}
      {\\[\baselineskip] \textsc{\lowercase{and}}\\[\baselineskip]}
      {,\\[\baselineskip]\textsc{\lowercase{and}}\\[\baselineskip]}
      \authors % macro to operate on
    \authors
  \endgroup
}
\def\maketitle{\par
  \@topnum\z@
  \@setcopyright
  \thispagestyle{firstpage}%
  \uppercasenonmath\shorttitle
  \ifx\@empty\shortauthors \let\shortauthors\shorttitle
  \else
    \newcommand{\@xuppercasenonmath}[1]{\toks@\@emptytoks
      \@xp\@skipmath\@xp\@empty##1$$%
      \edef##1{\@nx\protect\@nx\@upprep\the\toks@}}%
    \@xuppercasenonmath\shortauthors
    \def\@@and{{\Tiny AND}}
    \renewcommand{\andify}{%
      \nxandlist{\unskip, }{\unskip{ }\@@and{ }}{\unskip, \@@and{ }}}%
    \andify\shortauthors
  \fi
  \@maketitle@hook
  \begingroup
  \@maketitle
  \endgroup
  \c@footnote\z@
  \@cleartopmattertags
}
\def\@maketitle{%
  \normalfont\normalsize
  \let\@makefntext\noindent
  \@adminfootnotes
  \ifx\@empty\addresses\else \@footnotetext{\@setotheraddresses}\fi
  \global\topskip68\p@\relax
  \@settitle
  \ifx\@empty\authors \else \@setauthors \fi
  \ifx\@empty\@dedicatory
  \else
    \baselineskip26\p@
    \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
      \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \fi
  \toks@\@xp{\shortauthors}\@temptokena\@xp{\shorttitle}%
  \edef\@tempa{\@nx\markboth{\the\toks@}{\the\@temptokena}}\@tempa
  \@setabstract
  \normalsize
  \if@titlepage
    \newpage
  \else
    \dimen@12\p@ \advance\dimen@-\baselineskip
    \vskip\dimen@\relax
  \fi
} % end \@maketitle
\renewcommand{\thanks}[1]{%
  \ifx\@empty\thankses
    \gdef\thankses{\thanks{#1}}%
  \else
    \g@addto@macro\thankses{\endgraf\thanks{#1}}%
  \fi}
\def\@setthanks{\def\thanks##1{\noindent##1\@addpunct.}\thankses}
\renewcommand{\curraddr}[2][]{%
  \ifx\@empty\addresses
    \gdef\addresses{\curraddr{#1}{#2}}%
  \else
    \g@addto@macro\addresses{\endgraf\curraddr{#1}{#2}}%
  \fi}
\renewcommand{\email}[2][]{%
  \ifx\@empty\addresses
    \gdef\addresses{\email{#1}{#2}}%
  \else
    \g@addto@macro\addresses{\endgraf\email{#1}{#2}}%
  \fi}
\renewcommand{\urladdr}[2][]{%
  \ifx\@empty\addresses
    \gdef\addresses{\urladdr{#1}{#2}}%
  \else
    \g@addto@macro\addresses{\endgraf\urladdr{#1}{#2}}%
  \fi}
\def\@setotheraddresses{%
  \def\curraddr##1##2{\noindent
    \emph{Current address\@ifnotempty{##1}{ of ##1}}:\space
      ##2\@addpunct.}%
  \def\email##1##2{\noindent
    \emph{Email address\@ifnotempty{##1}{ of ##1}}:\space
      \texttt{##2}}%
  \def\urladdr##1##2{\noindent
    \emph{WWW address\@ifnotempty{##1}{ of ##1}}:\space
      \texttt{##2}}%
  \addresses
}
\let\enddoc@text\relax
\renewcommand{\datename}{Received}
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in AMS documentclasses; reported}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
  \normalsize
  \indent \textbf{\abstractname.}%
}{%
  \egroup
  \ifx\@setabstract\relax \@setabstracta \fi
}
\def\@setabstracta{%
  \ifvoid\abstractbox
  \else
    \skip@28\p@ \advance\skip@-\lastskip
    \advance\skip@-\ht\abstractbox \advance\skip@-\prevdepth
    \vskip\skip@
    \unvbox\abstractbox
    \setbox\z@\lastbox
    \ifvoid\z@ \prevdepth\z@ \else \nointerlineskip \box\z@\fi
  \fi
}
\listisep\z@
\renewenvironment{enumerate}{%
  \ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}\def\makelabel##1{\hss\llap{\upshape##1}}}\fi
  \parsep\parskip
}{%
  \endlist
}
\let\@secnumfont\relax
\def\part{\@startsection{part}{0}%
  {\normalparindent}{\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\mdseries\centering}}
\def\specialsection{\@startsection{section}{1}%
  {\normalparindent}{\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\mdseries\centering}}
\def\section{\@startsection{section}{1}%
  {\normalparindent}{\linespacing\@plus\linespacing}{-.5em}%
  {\normalfont\bfseries}}
\def\subsection{\@startsection{subsection}{2}%
  {\normalparindent}{\z@ plus\z@}{-.5em}%
  {\normalfont\itshape}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  {\normalparindent}{\z@ plus\z@}{-.5em}%
  {\normalfont\itshape}}
\def\contentsnamefont{\normalfont\bfseries}
\def\th@plain{%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip.5\baselineskip plus.1\baselineskip
  \thm@postskip\thm@preskip
  \let\thm@indent\noindent
  \thm@headfont{\scshape}%
  \upshape % body font
}
\def\th@definition{%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip\z@ plus.1\baselineskip
  \thm@postskip\thm@preskip
  \let\thm@indent\indent
  \thm@headfont{\scshape}%
  \upshape
}
\def\th@remark{%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip\z@ plus.1\baselineskip
  \thm@postskip\thm@preskip
  \let\thm@indent\indent
  \thm@headfont{\scshape}%
  \upshape
}
\providecommand{\proof}{}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont
  \topsep\z@ \trivlist
  \item[\hskip\normalparindent\hskip\labelsep\itshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist
}
\renewenvironment{quotation}{\list{}{%
    \topsep6\p@\@plus\p@
    \leftmargin3pc \listparindent\normalparindent
    \itemindent\z@
    \rightmargin\leftmargin \parsep\z@ \@plus\p@}%
  \item[]%
}{%
  \endlist
}
\def\@captionfont{\normalfont\Small}
\captionindent=5.5pc
\def\figurename{Fig.}
\def\@startsectionstar#1#2#3#4#5#6{%
 \if@noskipsec \leavevmode \fi
 \par \@tempskipa #4\relax
 \@afterindenttrue
 \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
 \if@nobreak \everypar{}\else
     \addpenalty\@secpenalty\addvspace\@tempskipa\fi
 \@dblarg{\@sect{#1}{\@m}{#3}{#4}{#5}{#6}}%
}
\def\@defaultbiblabelstyle#1{[#1]}
\renewcommand{\@bibtitlestyle}{%
  \@startsectionstar{section}{1}%
    \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
    {\normalfont\scshape\centering}{\refname}%
}
\renewcommand{\@indextitlestyle}{%
  \twocolumn[\@startsectionstar{section}{1}%
    \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
    {\normalfont\scshape\centering}{\indexname}]%
}
\endinput %
\endinput
%%
%% End of file `qam-l.cls'.
