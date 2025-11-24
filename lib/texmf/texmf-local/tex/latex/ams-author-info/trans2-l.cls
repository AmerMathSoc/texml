% \def\filename{trans2-l.cls}
% \def\fileversion{1.3}
% \def\filedate{2011/10/31}
%
% \iffalse meta-comment
%
% American Mathematical Society
% Technical Support
% Publications Technical Group
% 201 Charles Street
% Providence, RI 02904
% USA
% tel: (401) 455-4080
%      (800) 321-4267 (USA and Canada only)
% fax: (401) 331-3842
% email: tech-support@ams.org
%
% Copyright 1997, 2011 American Mathematical Society.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
% 
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is the American Mathematical
% Society.
% 
% \fi
\NeedsTeXFormat{LaTeX2e}% LaTeX 2.09 can't be used (nor non-LaTeX)
[1994/12/01]% LaTeX date must December 1994 or later
\ProvidesClass{trans2-l}
              [2011/10/31 v1.3 TRANS2 Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[1996/10/24]
%\RequirePackage{ams-rust}

%%    Need some adjustments to make page size same as AMS-TeX version.
%\textwidth=32pc
%\textheight=52.5pc
%\calclayout

\copyrightinfo{1997}%            % copyright year
  {American Mathematical Society}% copyright holder

\def\publname{Amer. Math. Soc. Transl.}
\def\volinfo{(2) Vol. \textbf{\currentvolume}, \currentyear}

\def\ISSN{0065-9290}

%   Add "original appearance" info to first-page footnotes.
%   This is a candidate for addition to amsart or to a translations
%   author package.
%   Omit date.
\let\@oa\@empty
\def\oa#1{\gdef\@oa{#1}}
\def\@setoa{\@oa\@addpunct.}
\def\@maketitle{%
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \ifx\@empty\@oa\else \@footnotetext{\@setoa}\fi
  \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks}\fi
  \global\topskip8pc\relax
  \@settitle
  \ifx\@empty\authors \else \@setauthors \fi
  \ifx\@empty\@dedicatory
  \else
%    \baselineskip18\p@
    \baselineskip26\p@
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
} % end \@maketitle

\newcommand{\lcandify}{%
  \nxandlist{\unskip, }{\unskip{} \lowercase{and}~}{\unskip, \lowercase{and}~}}
%   Smaller size than in amsproc.cls.
%   Also, `and' is always lowercase.
\def\@settranslators{\par\begingroup
  \addvspace{6\p@\@plus9\p@}%
%  \hbox to\columnwidth{\hss\normalfont\normalsize
  \hbox to\columnwidth{\hss\normalfont\Small
    Translated by %
    \lcandify\@translators \uppercasenonmath\@translators
    \@translators}
  \endgroup
}

%    Reverse order of addresses and translator at end of article.
\def\enddoc@text{%
  \ifx\@empty\addresses \else\@setaddresses\fi
  \ifx\@empty\@translators \else\@settranslators\fi
}

%%    Change labeling style of first-level enumerated items.
%\def\labelenumi{\theenumi)}

\endinput
