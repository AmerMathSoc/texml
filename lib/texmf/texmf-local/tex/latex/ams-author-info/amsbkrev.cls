%%
%% This is file `amsbkrev.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% amsbkrev.dtx  (with options: `cls')
%% 
%% This is a generated file.
%% 
%% Copyright 2004, 2009, 2013-2016 American Mathematical Society.
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
\NeedsTeXFormat{LaTeX2e}% LaTeX 2.09 can't be used (nor non-LaTeX)
[1995/12/01]% LaTeX date must be December 1995 or later
\ProvidesClass{amsbkrev}   [2022/03/28 v2.41]
\newif\if@generic \@generictrue
\newif\if@russianjournal \@russianjournalfalse
\providecommand{\originfo}[4]{}
\newif\if@qam  \@qamfalse
\let\br@head\@empty
\newskip\reviewsep \reviewsep=15pt plus6pt minus3pt\relax
\def\Review{\def\@title{Book Review}}
\def\Reviews{\def\@title{Book Reviews}}
\let\initial@text\@empty
\def\@titlefont{\LARGE\bfseries}
\newcommand*\reviewer[1]{%
    \ifx\@empty\addresses
        \gdef\addresses{\reviewer{#1}}%
    \else
        \g@addto@macro\addresses{\and\reviewer{#1}}%
    \fi
}
\newcommand*\revtransl[1]{\g@addto@macro\addresses{\revtransl{#1}}}
\newcounter{revcount}
\let\enddoc@text\@empty
\let\endreview@text\enddoc@text
\newenvironment{review}{%
  \par
  \ifx\@empty\maketitle \addpenalty{-9999}\addvspace\reviewsep
  \else \maketitle
  \fi
  \let\authors\@empty \let\addresses\@empty \let\thankses\@empty
  \setcounter{bookinfo}{0}%
  \refstepcounter{revcount}%
}{%
  \endreview@text % reviewer addresses
}
\newcounter{bookinfo}
\newcounter{author}[bookinfo]
\newcommand{\msc}{}
\newcommand{\bkcontrib}{}
\newcommand{\bktransl}{}
\newcommand{\edition}{}
\newcommand{\editor}{}
\newcommand{\series}{}
\newcommand{\serieseditor}{}
\newcommand{\journal}{}
\newcommand{\volume}{}
\newcommand{\num}{}
\newcommand{\yr}{}
\newcommand{\pages}{}
\newcommand{\publisher}{}
\newcommand{\publaddr}{}
\newcommand{\cmheight}{}
\newcommand{\altpages}{}
\newcommand{\lang}{}
\newcommand{\binding}{}
\newcommand{\price}{}
\newcommand{\isbn}{}
\newcommand{\note}{}
\@ifundefined{ifresetcontrib}{%
  \newif\ifresetcontrib \resetcontribfalse
}{}
\newenvironment{bookinfo}{%
  \if@qam \setcounter{bookinfo}{\@ne}%
  \else \refstepcounter{bookinfo}%
  \fi
  \@namedef{@bookinfo\number\c@bookinfo}{}%
  \br@clearfields
  \global\let\br@serieseditors\@empty
  \def\title{\br@add\br@title}\def\subtitle{\br@add\br@subtitle}%
  \def\series{\br@add\br@series}%
  \def\ctitle{\br@add\br@ctitle}\def\cpubl{\br@add\br@cpubl}%
  \def\volume{\br@add\br@volume}\def\num{\br@add\br@num}%
  \def\yr{\br@add\br@yr}\def\edition{\br@add\br@edition}%
  \def\publisher{\br@add\br@publisher}%
  \def\publaddr{\br@add\br@publaddr}%
  \def\pages{\br@add\br@pages}\def\altpages{\br@add\br@altpages}%
  \def\lang{\br@add\br@lang}%
  \def\cmheight{\br@add\br@cmheight}\def\msc{\br@add\br@msc}%
  \def\note{\br@add\br@note}%
  \renewcommand\author[2][]{\refstepcounter{author}%
    \ifx\@empty\br@authors
      \gdef\br@authors{##2}%
    \else
      \g@addto@macro\br@authors{\and##2}%
    \fi
    \@ifnotempty{##1}{\g@addto@macro\br@authors{\ednote{##1}}}%
    \@wraptocauthors{##2}%
  }%
  \br@add\editor@flag{TF}%
  \gdef\ed@note{(\ed@string)}%
  \renewcommand\editor{%
    \br@add\editor@flag{TT}%
    \author
  }%
  \renewcommand\serieseditor[1]{%
    \ifx\@empty\br@serieseditors
      \gdef\br@serieseditors{##1}%
    \else
      \g@addto@macro\br@serieseditors{\and##1}%
    \fi
  }%
  \renewcommand\bkcontrib[2][]{%
    \def\@tempa{##1}%
    \ifx\@empty\@tempa
    \else
      \ifresetcontrib \@br@xcontribs
      \else \global\resetcontribtrue
      \fi
    \fi
    \ifx\@empty\br@bkcontribs
      \gdef\br@bkcontribs{##1 ##2}%
    \else
      \g@addto@macro\br@bkcontribs{\and##1 ##2}%
    \fi
    \@wraptocauthors{##2}%
    \@wraptocbkcontribs{##1}{##2}%
  }%
  \def\@br@xcontribs{%
    \author@andify\br@bkcontribs
    \ifx\@empty\br@xcontribs
      \xdef\br@xcontribs{\br@bkcontribs}%
    \else
      \xdef\br@xcontribs{\br@xcontribs, \br@bkcontribs}%
    \fi
    \let\br@bkcontribs\@empty
  }%
  \let\br@bkcontribs\@empty  \let\br@xcontribs\@empty
  \let\tocauthors\@empty  \let\tocbkcontribs\@empty
  \def\bktransl{\br@add\br@bktransl}%
  \def\price##1{\g@addto@macro\br@prices{\price{##1}}}%
  \def\binding##1{\g@addto@macro\br@prices{\binding{##1}}}%
  \def\isbn##1{\g@addto@macro\br@prices{\isbn{##1}}}%
  \def\journal{\br@add\br@journal}%
}{%
  \expandafter\br@add\expandafter\br@authors\expandafter{\br@authors}%
    \expandafter\br@add\expandafter\c@author\expandafter{\the\c@author}%
  \@br@xcontribs
  \expandafter\br@add\expandafter\br@xcontribs\expandafter{\br@xcontribs}%
  \@closetocauthors
  \@closetocbkcontribs
  \expandafter\br@add\expandafter\br@prices\expandafter{\br@prices}%
}
\def\@wraptocauthors#1{}
\def\@closetocauthors{}
\def\@wraptocbkcontribs#1#2{}
\def\@closetocbkcontribs{}
\def\br@clearfields{%
  \global\let\br@msc\@empty \global\let\br@journal\@empty
  \global\let\br@authors\@empty
  \global\let\br@bkcontrib\@empty \global\let\br@xcontribs\@empty
  \global\let\tocauthors\@empty
  \global\let\tocbkcontribs\@empty
  \global\let\br@bktransl\@empty
  \global\let\br@title\@empty \global\let\br@subtitle\@empty
  \global\let\br@series\@empty
  \global\let\br@ctitle\@empty \global\let\br@cpubl\@empty
  \global\let\br@volume\@empty \global\let\br@num\@empty
  \global\let\br@publisher\@empty \global\let\br@publaddr\@empty
  \global\let\br@edition\@empty \global\let\br@yr\@empty
  \global\let\br@pages\@empty \global\let\br@altpages\@empty
  \global\let\br@lang\@empty
  \global\let\br@cmheight\@empty \global\let\br@prices\@empty
  \global\let\br@note\@empty
}
\def\br@add#1#2{%
  \expandafter\g@addto@macro
    \csname @bookinfo\number\c@bookinfo\endcsname{\def#1{#2}}}
\providecommand{\bb@skip}[1]{%
  \skip@#1\relax \advance\skip@-\prevdepth \advance\skip@-\baselineskip
  \vskip\skip@}
\def\@setfootnotes{%
  \begingroup \let\@makefnmark\relax  \let\@thefnmark\relax
  \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks}\fi
  \endgroup
}
\def\@altmaketitle{\maketitle}
\newenvironment{revinfo}{%
  \def\@settitle{\prevdepth\z@ \bb@skip{44\p@}}%
  \let\@setlogo\relax \@altmaketitle
}{%
  \par
  \@setfootnotes % first-page administrative notes (subjclass etc)
  \def\do{\begingroup
    \br@clearfields \frenchspacing
    \csname @bookinfo\number\@tempcnta\endcsname
    \@setwhatinfo
    \endgroup
    \advance\@tempcnta\@ne
    \ifnum\@tempcnta>\c@bookinfo \expandafter\@gobble\fi
    \do}
  \@tempcnta\@ne
  \do % print info for each book in turn
  \par \penalty9999
  \if@perspective \vspace{-10\p@}\noindent
  \else \addvspace{12\p@}%
  \fi
}
\def\print@field#1#2#3{\ifx\@empty#2%
  \else\unskip\begingroup#1#2#3\endgroup\fi}
\newif\if@loosen
\def\loosen{\@loosentrue}
\newif\if@perspective \@perspectivefalse
\def\normal@setbookinfo{%
  \par\addvspace\medskipamount
  \normalfont\hangindent\parindent
  \noindent \br@head % nonempty for mcom and bull perspectives
  \if@loosen
    \tolerance 2000 \emergencystretch 1em
    \global\@loosenfalse
  \fi
  {\itshape\br@title}%
  \print@field{, }\br@edition\relax
  \ifx\@empty\br@authors
  \else
    \andify\br@authors
    \author@editor\br@authors
  \fi
  \print@field{, }\br@xcontribs\relax
  \print@field{, translated by }\br@bktransl\relax
  \print@field{, }\br@series\relax
  \print@field{, Vol.\@\nobreak\space}\br@volume\relax
  \print@field{, No.\@\nobreak\space}\br@num\relax
  \ifx\@empty\br@serieseditors
  \else
    \andify\br@serieseditors
    \print@field{, edited by }\br@serieseditors\relax
  \fi
  \print@field{, }\br@publisher\relax
  \print@field{, }\br@publaddr\relax
  \print@field{, }\br@yr\relax
  \print@field{, }\br@pages{\ pp.\ }% a following unskip will remove space
  \print@field{, }\br@cmheight{\thinspace cm }%
  \def\price{\unskip, }\let\binding\price \def\isbn{\unskip, ISBN }%
  \br@prices
  \print@field{; }\br@note\relax
  \print@field{ (}\br@lang{)}%
  \if@generic
    \par
    \print@field{[}\br@msc{]}%
  \fi
  \par}
\let\@setwhatinfo\normal@setbookinfo
\def\print@editors#1{\unskip, #1\unskip\space\ed@note\unskip}
\newcommand\ednote[1]{\unskip\space#1\unskip
  \global\let\ed@note\@empty
}
\def\ed@string{Editor\ifnum\c@author>\@ne s\fi}
\def\print@authors#1{\unskip, by #1}%
\def\author@editor{%
  \if\editor@flag\expandafter\print@editors
  \else\expandafter\print@authors
  \fi
}
\InputIfFileExists{amsbkrev.cfg}{}{}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions\relax
\LoadClass{amsart}[2009/07/02]
\if@generic
\else \thispagestyle{firstpage}
\fi
\if@generic
\else \@checkrussjnl
\fi
\if@generic
    \let\@setlogo\relax
\fi
\def\@setaddresses{\par
  \nobreak \begingroup
  \footnotesize \raggedleft
  \interlinepenalty\@M
  \def\reviewersep{\par\nobreak\addvspace{1\bigskipamount}%
    \def\reviewersep{\par\penalty9999 \addvspace{1\medskipamount}}}%
  \def\reviewer##1{\reviewersep{\normalsize \textsc{##1}\par\nobreak}}%
  \def\address##1##2{\begingroup
    \par\addvspace{1\smallskipamount}%
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\scshape\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak{\itshape Current address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak{\itshape Email address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par\endgroup}}%
  \def\revtransl##1{\reviewersep{\small Translated by \uppercase{##1}\par}}%
    \let\and\@empty
  \addresses
  \par % just in case
  \endgroup
}
\def\@settitle{%
    \vbox to57pt{%
        \vfil
        \@titlefont\centering
        \@title\par
    }%
    \nobreak{\baselineskip7\p@\relax \bb@skip{4pc}}%
}
\def\maketitle{%
     \vbox{%
         \dimen@\topskip
         \advance\dimen@\headheight
         \advance\dimen@\headsep
         \if@russianjournal \advance\dimen@ .5pc \fi
         \hrule height\topskip depth-\dimen@
     }%
    \@setcopyright
    \nointerlineskip
    \begingroup
        \uppercasenonmath\@title
        \toks@\expandafter{\@title}%
        \edef\@tempa{\noexpand\markboth{\the\toks@}{\the\toks@}}%
        \@tempa
        \if@brtitle\@settitle\fi
    \endgroup
    \if@russianjournal \kern-2.5pc \else \kern1pc \fi
    \@setlogo
    \initial@text
    \global\let\maketitle\@empty
}
\newif\if@brtitle
\@brtitlefalse
\def\brtitle{\@brtitletrue}
\if@generic
\else
  \csname publ@specific\endcsname % publication-specific tailoring
\fi
\if@generic
  \Review
  \AtBeginDocument{\maketitle}
\fi
\def\cprime{%
  \ClassWarning{ams}{%
    \protect\textprime\space should be used instead of \protect\cprime}%
  \textprime}
\def\author@andify{%
  \nxandlist {\unskip ,\penalty-1 \space\ignorespaces}%
    {\unskip {} and~}%
    {\unskip ,\penalty-2 \space and~}%
}
\advance\textheight-\normaltopskip
\advance\textheight.5\baselineskip
\divide\textheight\baselineskip
\multiply\textheight\baselineskip
\advance\textheight\normaltopskip
\endinput
%%
%% End of file `amsbkrev.cls'.
