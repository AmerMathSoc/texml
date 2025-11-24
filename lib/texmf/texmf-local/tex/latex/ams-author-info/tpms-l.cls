%%
%% This is file `tpms-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% tpms-l.dtx 
%% 
%% This is a generated file.
%% 
%% Copyright 2003, 2011, 2013, 2020 American Mathematical Society.
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
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is the American Mathematical
%% Society.
%% 
%% ========================================================================
%% 
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{tpms-l}[2021/12/10 2.20 TPMS author class]
\newif\ifeditorial
\editorialfalse
\DeclareOption{editor}{%
  \editorialtrue
  \AtEndDocument{%
  \hfill\andify\authors\authors}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions

\LoadClass{amsart}[2009/07/02]
\def\publname{%
\hfill Theor. Probability and Math. Statist.%
}
\def\ISSN{0094-9000}
\copyrightinfo{\currentyear}%    % copyright year
  {Taras Shevchenko National University of Kyiv}% copyright holder
\def\englishvolinfo{%
  No. \number0\currentvolume, \currentyear}
\def\@setdateposted{%
  \linebreak\null\hfill Article electronically published on \@dateposted}
\providecommand{\setdoi@or@pii}{}
\providecommand\set@publname{\publname}
\AtBeginDocument{%
    \def\@serieslogo{%
        \vbox to\headheight{%
            \parindent\z@
            \parfillskip\z@
            \fontsize{8}{8\p@}\selectfont
            \frenchspacing
            \noindent\null\hfill\set@publname\linebreak
            \ifx\@empty\currentvolume \else
                \null\hfill\englishvolinfo, \pageinfo\linebreak
            \fi
            \null\hfill
            \begingroup
                \let\newline\relax
                \setdoi@or@pii
            \endgroup
            \ifx\@empty\@dateposted \else \@setdateposted\fi
            \endgraf
            \vss
        }%
    }%
}
\def\@maketitle{%
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks}\fi
  \global\topskip44\p@\relax % 5.5pc   "   "   "     "     "
  \@settitle
  \ifx\@empty\@UDC \else \@setUDC \fi
  \ifx\@empty\authors \else \ifeditorial \else \@setauthors \fi \fi
  \ifx\@empty\@dedicatory
  \else
    \baselineskip18\p@
    \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
      \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \fi
  \@setabstract
  \normalsize
  \if@titlepage
    \newpage
  \else
    \dimen@34\p@ \advance\dimen@-\baselineskip
    \vskip\dimen@\relax
  \fi
}
\def\@setabstracta{%
  \ifvoid\abstractbox
  \else
    \skip@18\p@ \advance\skip@-\lastskip
    \advance\skip@-\baselineskip \vskip\skip@
    \box\abstractbox
    \prevdepth\z@ % because \abstractbox is a vtop
  \fi
}
\def\@setcopyright{%
  \ifx\@empty\@serieslogo
  \else\ifx\@empty\copyrightyear
  \else
    \insert\copyins{\hsize\textwidth
      \parfillskip\z@ \leftskip\z@\@plus.9\textwidth
      \fontsize{6}{7\p@}\normalfont\upshape
      \everypar{}%
      \vskip-\skip\copyins \nointerlineskip
      \noindent\vrule\@width\z@\@height\skip\copyins
      \copyright\copyrightyear\ \copyrightholder
      \par
      \kern-\prevdepth}%

  \fi\fi
}
\def\enddoc@text{%
  \ifx\@empty\addresses \else\@setaddresses\fi
  \ifx\@empty\@date \else\@setdate\fi
}
\newcommand{\datereceivedname}{Received}
\newcommand{\dateacceptedname}{Accepted}
\let\@dateaccepted\@empty
\def\dateaccepted{\gdef\@dateaccepted}
\def\@setdate{\par\nobreak
  \begingroup
    \addvspace{6\p@\@plus9\p@}%
    \hbox to\columnwidth{\hss\normalfont\normalsize \datereceivedname\ \@date}%
    \ifx\@empty\@dateaccepted\else
    \par
    \hbox to\columnwidth{\hss\normalfont\normalsize \dateacceptedname\ \@dateaccepted}%
    \fi
  \endgroup
}
\let\@UDC\@empty
\def\UDC#1{\gdef\@UDC{UDC #1}}
\def\@setUDC{\vspace{-2pt}%
  {\baselineskip12\p@\relax
    \noindent\footnotesize\@UDC\vrule height11\p@ depth\z@ width\z@\par
  }%
}
\def\@setauthors{%
  \begingroup
  \trivlist
  \centering\footnotesize \@topsep42\p@\relax
  \advance\@topsep by -\baselineskip
  \item\relax
  \andify\authors
  \def\\{\protect\linebreak}%
\MakeUppercase{\authors}%
  \endtrivlist
  \endgroup
}
\bibliographystyle{amsplain}
\def\refname{Bibliography}
\renewenvironment{thebibliography}[1]{%
  \@xp\section\@xp*\@xp{\refname}%
  \normalfont\footnotesize\labelsep .5em\relax
  \renewcommand\theenumiv{\arabic{enumiv}}\let\p@enumiv\@empty
  \list{\@biblabel{\theenumiv}}{\settowidth\labelwidth{\kern1.5pc 00.}%
    \leftmargin\labelwidth \advance\leftmargin\labelsep
    \usecounter{enumiv}}%
  \sloppy \clubpenalty\@M \widowpenalty\clubpenalty
  \sfcode`\.=\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
\textwidth=32pc
\textheight=52.5pc
\calclayout
\endinput
%%
%% End of file `tpms-l.cls'.
