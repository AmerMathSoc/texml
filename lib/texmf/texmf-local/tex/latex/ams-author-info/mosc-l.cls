%%
%% This is file `mosc-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% russian.dtx  (with options: `mosc')
%% 
%% This is a generated file.
%% 
%% Copyright 2003, 2011, 2013 American Mathematical Society.
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
\ProvidesClass{mosc-l}[2025/11/06 2.16 MOSC author class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions

\LoadClass{amsart}[2009/07/02]
\RequirePackage{ams-rust}
\def\publname{%
\Russian{Trudy Moskov. Matem. Obshch.}\hfill Trans. Moscow Math. Soc.%
}
\def\ISSN{0077-1554}
\copyrightinfo{\currentyear}%    % copyright year
  {American Mathematical Society}% copyright holder
\def\originfo#1#2#3#4{\def\origvolume{#1}\def\origissue{#2}%
  \def\origmonth{#3}\def\origyear{#4}}

\originfo{00}% volume number
  {0}%        % issue number
  {Yyyy}%     % month
  {0000}%     % year
\def\russianvolinfo{%
    \Russian{Tom \origvolume\ (\origyear)%
        \ifx\origissue\@empty\else
            \ifnum\origissue=\z@\else
                , vyp.\ \origissue
            \fi
        \fi
    }%
}
\def\englishvolinfo{\currentyear}
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
            \noindent\set@publname\linebreak
            \russianvolinfo
            \ifx\@empty\currentvolume \else
                \hfill\englishvolinfo, \pageinfo\linebreak
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
  \ifx\@empty\authors \else \@setauthors \fi
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
  \ifx\@empty\@translators \else\@settranslators\fi
  \ifx\@empty\@translnotes \else\@settranslnotes\fi
}
\renewcommand{\datename}{Received}
\def\@setdate{\par\nobreak
  \begingroup
    \addvspace{6\p@\@plus9\p@}%
    \hbox to\columnwidth{\hss\normalfont\normalsize \datename\ \@date}%
  \endgroup
}
\def\@settranslators{\par\begingroup
  \addvspace{6\p@\@plus9\p@}%
  \hbox to\columnwidth{\hss\normalfont\Small
    Translated by %
    \andify\@translators \uppercasenonmath\@translators
    \@translators}
  \endgroup
}
\def\translnote#1{%
    \ifx\@empty\@translnotes
        \def\@translnotes{#1}%
    \else
        \g@addto@macro\@translnotes{\par
            \vspace{3\p@}%
        #1}%
    \fi
}

\let\@translnotes=\@empty
\def\@settranslnotes{%
  \par\begingroup
    \addvspace{3\p@\@plus5\p@}%
    \flushright\normalfont\Small
    \@translnotes\par
  \endgroup}
\newcommand{\eo}[1]{\translnote{English original provided by #1}}
\newcommand{\rv}[1]{\translnote{Revised version provided by #1}}
\newcommand{\op}[1]{\translnote{Originally published in #1}}
\newcommand{\eb}[1]{\translnote{Edited by \uppercase{#1}}}
\newcommand{\origlang}[1]{}
\textwidth=32pc
\textheight=52.5pc
\calclayout
\let\origtitle\@gobble
\let\origauthor\@gobble
\let\origDOI\@gobble
\let\origpagespan\@gobbletwo
\endinput
%%
%% End of file `mosc-l.cls'.
