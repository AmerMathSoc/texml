%%
%% This is file `jag-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% jag-l.dtx 
%% 
%% This is a generated file.
%% 
%% Copyright 2005, 2012 American Mathematical Society.
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

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jag-l}[2017/10/17 v1.6 JAG Author Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions
\LoadClass[leqno]{amsart}[2009/07/02]
\count@\@mainsize
\advance\count@-10
\def\@tempa{%   % 10pt
  \def\@typesizes{%
    \or{5}{6}\or{6}{7}\or{7}{8}\or{8}{10}\or{9}{11}%
    \or{10}{13}% normalsize
    \or{\@xipt}{13}\or{\@xiipt}{14}\or{\@xivpt}{17}%
    \or{\@xviipt}{20}\or{\@xxpt}{24}}}
\ifcase\count@  % 10pt
  \@tempa
\or             % 11pt
  \def\@typesizes{%
    \or{6}{7}\or{7}{8}\or{8}{10}\or{9}{11}\or{10}{12}%
    \or{\@xipt}{14}% normalsize
    \or{\@xiipt}{14}\or{\@xivpt}{17}\or{\@xviipt}{20}%
    \or{\@xxpt}{24}\or{\@xxvpt}{30}}%
\or             % 12pt
  \def\@typesizes{%
    \or{7}{8}\or{8}{10}\or{9}{11}\or{10}{12}\or{\@xipt}{13}%
    \or{\@xiipt}{16}% normalsize
    \or{\@xivpt}{17}\or{\@xviipt}{20}\or{\@xxpt}{24}%
    \or{\@xxvpt}{30}\or{\@xxvpt}{30}}%
\else
  \@tempa
  \ClassWarning{jag-l}{options smaller than 10pt not supported;
    defaulting to 10pt}%
\fi
\normalsize \linespacing=\baselineskip
\footskip=13pt
\textheight=43.5pc
\textwidth=28pc
\AtBeginDocument{%
  \def\pageinfo{%
    \ifnum\start@page=\z@
      000--000
    \else
      \ifx\start@page\end@page
        \start@page
      \else
        \start@page--\end@page
      \fi
    \fi}%
  \def\publname{J. ALGEBRAIC GEOMETRY}%
  \def\volinfo{\textbf{\currentvolume} (\currentyear)}%
  \def\@serieslogo{%
    \set@logo{%
      \set@publname
      \ifx\@empty\currentvolume
      \else \newline \volinfo\ \pageinfo
      \fi
      \setdoi@or@pii
      \ifx\@empty\@dateposted \else \@setdateposted\fi
    }%
  }%
}
\providecommand\setdoi@or@pii{}
\providecommand\set@publname{\publname}
\newinsert\copyins
\skip\copyins=1.5pc
\count\copyins=1000 % magnification factor, 1000 = 100%
\dimen\copyins=.5\textheight % maximum allowed per page
\g@addto@macro\@reinserts{%
  \ifvoid\copyins\else\insert\copyins{\unvbox\copyins}\fi
}
\def\@copyinsfontsize{\fontsize{6}{7\p@}\normalfont\upshape}
\newif\if@extracrline  \@extracrlinefalse
\let\@extracrline\@empty
\renewcommand{\copyrightinfo}[2]{%
  \def\copyrightyear{#1}%
  \@ifnotempty{#2}{\def\copyrightholder{#2}}%
}
\copyrightinfo{0000}{(copyright holder)}
\def\pagespan#1#2{\setcounter{page}{#1}%
  \ifnum\c@page<\z@ \pagenumbering{roman}\setcounter{page}{-#1}\fi
  \def\start@page{#1}\def\end@page{#2}}
\def\@setcopyright{%
  \ifx\@empty\@serieslogo
  \else\ifx\@empty\copyrightyear
  \else
    \insert\copyins{\hsize\textwidth
      \parfillskip\z@\relax
      \leftskip\z@\@plus.9\textwidth\relax \rightskip\z@\relax
      \@copyinsfontsize
      \everypar{}%
      \vskip-\skip\copyins
      \if@extracrline
        \vskip-6pt
      \fi
      \nointerlineskip
      \leavevmode\hfill\vrule\@width\z@\@height\skip\copyins
      \copyright\copyrightyear\ \copyrightholder\ignorespaces
      \if@extracrline \@extracrline \fi
      \par
      \kern\z@}%
  \fi\fi
  }
\newif\if@revertcopyright  \@revertcopyrightfalse
\renewcommand{\revertcopyright}{%
  \global\@revertcopyrighttrue
  \global\@extracrlinetrue}
\def\@revertcrfontsize{\fontsize{6}{7\p@}\normalfont\upshape}
\def\@extracrline{%
  \if@revertcopyright
    \unskip\\
    \@revertcrfontsize
    Reverts to public domain 28 years from publication
  \fi
  }
\def\ISSN{1056-3911}
\renewcommand{\datename}{Received}
\newcommand{\@subj@keyworderror}{%
  \string\subjclass\space and \string\keywords\space are not permitted
  in JAG;\MessageBreak
  please remove them}
\renewcommand{\keywords}[1]{%
  \ClassError{\@classname}{%
    \@subj@keyworderror
    }{%
    \@subj@keyworderror
    }}
\renewcommand{\subjclass}[2][]{%
  \ClassError{\@classname}{%
    \@subj@keyworderror
    }{%
    \@subj@keyworderror
    }}
\def\@@and{AND}
\def\maketitle{\par
  \@topnum\z@ % this prevents figures from falling at the top of page 1
  \@setcopyright
  \uppercasenonmath\shorttitle
  \ifx\@empty\shortauthors \let\shortauthors\shorttitle
  \else \andify\shortauthors \uppercasenonmath\shortauthors \fi
  \@maketitle@hook
  \begingroup
  \@maketitle
  \endgroup
\thispagestyle{firstpage}% this sets first page specifications
  \c@footnote\z@
  \def\do##1{\let##1\relax}%
  \do\maketitle \do\@maketitle \do\title \do\@xtitle \do\@title
  \do\author \do\@xauthor \do\address \do\@xaddress
  \do\email \do\@xemail \do\curraddr \do\@xcurraddr
  \do\commby \do\@commby
  \do\dedicatory \do\@dedicatory \do\thanks \do\thankses
  \do\keywords \do\@keywords \do\subjclass \do\@subjclass
}
\def\@maketitle{%
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \ifx\@empty\@subjclass\else \fi
  \ifx\@empty\@keywords\else \fi
  \ifx\@empty\@date
    \ifx\@empty\thankses
    \else \@footnotetext{\def\par{\let\par\@par}\@setthanks}%
    \fi
  \else
    \@footnotetext{\@setdate
      \ifx\@empty\thankses
      \else \def\par{\let\par\@par}\ \@setthanks
      \fi}%
  \fi
  \toks@\@xp{\shortauthors}\@temptokena\@xp{\shorttitle}%
  \edef\@tempa{\@nx\markboth{\the\toks@}{\the\@temptokena}}\@tempa
  \global\topskip54\p@ % 5 picas to the base of the first title line
  \@settitle
  \ifx\@empty\authors \else \@setauthors \fi
  \ifx\@empty\@commby
  \else
    \baselineskip18\p@
    \vtop{\centering{\footnotesize\@commby\@@par}%
      \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \fi
  \ifx\@empty\@dedicatory
  \else
    \baselineskip18\p@
    \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
      \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \fi
  \@setabstract
  \normalsize
  \dimen@30\p@ \advance\dimen@-\baselineskip
  \vskip\dimen@\relax
} % end \@maketitle
\def\@settitle{\begin{center}
    \Large\bfseries
    \uppercasenonmath\@title
    \@title
  \end{center}%
}
\def\@setauthors{%
  \begingroup
   \trivlist
    \centering \normalfont\normalsize
    \@topsep24\p@\relax
    \advance\@topsep by -\baselineskip
    \item\relax
    \andify\authors
    \uppercasenonmath\authors
    \authors
    \ifx\@empty\contribs
    \else
      ,\penalty-3 \space \@setcontribs
    \fi
   \endtrivlist
  \endgroup
}
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in AMS documentclasses; reported}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
  \normalfont\Small
  \centering{\bfseries \abstractname\vspace{2\p@}\vspace{\z@}}%
  \list{}{\labelwidth\z@
    \leftmargin3pc \rightmargin\leftmargin
    \listparindent\normalparindent \itemindent\z@
    \parsep\z@ \@plus\p@
    \let\fullwidthdisplay\relax
    }%
  \item[]%
}{%
  \endlist\egroup
  \ifx\@setabstract\relax \@setabstracta \fi
}
\def\@setabstracta{%
  \ifvoid\abstractbox
  \else
    \skip@34\p@ \advance\skip@-\lastskip
    \advance\skip@-\baselineskip \vskip\skip@
    \box\abstractbox
    \prevdepth\z@ % because \abstractbox is a vtop
  \fi
}
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
    \@ifnotempty{##2}{\nobreak\indent{\itshape Current address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape Email address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \def\urladdr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape URL}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \addresses
  \endgroup
}
\def\labelenumi{(\theenumi)}
\renewenvironment{enumerate}{%
  \ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}\def\makelabel##1{\hss\llap{\upshape##1}}}\fi
}{%
  \endlist
}
\let\@secnumfont\relax
\def\part{\@startsection{part}{0}%
  {\z@}{2.5\linespacing\@plus.3\linespacing}{.5\linespacing}%
  {\normalfont\bfseries\centering}}
\def\specialsection{\@startsection{section}{1}%
  {\z@}{2.5\linespacing\@plus.3\linespacing}{.5\linespacing}%
  {\normalfont\bfseries\centering}}
\def\section{\@startsection{section}{1}%
  {\z@}{2.5\linespacing\@plus.3\linespacing}{.5\linespacing}%
  {\normalfont\bfseries\centering}}
\def\subsection{\@startsection{subsection}{2}%
  {\normalparindent}{\z@ plus\z@}{-.5em}%
  {\normalfont\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  {\normalparindent}{\z@ plus\z@}{-.5em}%
  {\normalfont\bfseries}}
\def\contentsnamefont{\normalfont\bfseries}
\thm@preskip\z@
\thm@postskip\z@
\def\th@plain{%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip\z@ plus.1\baselineskip
  \thm@postskip\thm@preskip
  \let\thm@indent\indent
  \itshape % body font
}
\def\th@definition{%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip\z@ plus.1\baselineskip
  \thm@postskip\thm@preskip
  \let\thm@indent\indent
  \upshape
}
\def\th@remark{%
  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
  \thm@preskip\z@ plus.1\baselineskip
  \thm@postskip\thm@preskip
  \let\thm@indent\indent
  \upshape
}
\csname \if@compatibility \else re\fi newenvironment\endcsname
{proof}[1][\proofname]{\par
  \pushQED{\qed}\relax
  \normalfont
  \topsep\z@ plus.1\baselineskip
  \trivlist
  \itemindent\normalparindent
  \item[\hskip\labelsep\itshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist
}
\@ifundefined{pushQED}{%
  \let\pushQED\@gobble
  \def\popQED{\qed}%
}{}
\@ifundefined{swappedhead@plain}{%
  \let\swappedhead@plain=\swappedhead
}{}
\def\@refsection{\@startsection{section}{1}%
  {\z@}{2.5\linespacing\@plus.3\linespacing}{.5\linespacing}%
  {\large\bfseries\centering}}
\renewenvironment{thebibliography}[1]{%
  \@xp\@refsection\@xp*\@xp{\refname}%
  \normalfont\footnotesize\labelsep6\p@\relax
  \renewcommand\theenumiv{\arabic{enumiv}}\let\p@enumiv\@empty
  \list{\@biblabel{\theenumiv}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \@tempdima\labelwidth \advance\@tempdima\labelsep
    \ifdim\@tempdima<24pt
    \else \labelwidth24\p@ \advance\labelwidth-\labelsep
    \fi
    \leftmargin\labelwidth \advance\leftmargin\labelsep
    \ifdim\leftmargin=\labelsep \leftmargin24\p@ \itemindent-24\p@
    \else \ifdim\leftmargin>24\p@ \leftmargin24\p@ \itemindent-24\p@ \fi
    \fi
    \usecounter{enumiv}}%
  \sloppy \clubpenalty\@M \widowpenalty\clubpenalty
  \sfcode`\.=\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
\predisplaypenalty=8000
\endinput %
\endinput
%%
%% End of file `jag-l.cls'.
