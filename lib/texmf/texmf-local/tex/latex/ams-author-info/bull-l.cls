%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "bull-l.cls",
%%%    version   = "2.05",
%%%    date      = "2009/05/07",
%%%    time      = "12:00:15 EDT",
%%%    checksum  = "32607 108 249 3199",
%%%    author    = "Michael Downes, updated by Barbara Beeton",
%%%    address   = "American Mathematical Society,
%%%                 201 Charles Street,
%%%                 Providence, RI 02904, USA",
%%%    email     = "tech-support@ams.org",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the Bulletin
%%%                 of the American Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bull-l}[2009/05/07 v2.05 BULL Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions\relax

\LoadClass{amsart}[1996/10/24]

\def\publname{BULLETIN (New Series) OF THE\newline
  AMERICAN MATHEMATICAL SOCIETY}

\def\ISSN{0273-0979}

\def\@setlogo{%
  \setbox\z@\@serieslogo
  \setbox\tw@\vbox{\unvbox\z@\unskip}%
  \dimen@\dp\tw@
  \if@SuperTitle
    \vbox to28pt{\vss\unvbox\tw@}%
  \else
    \vtop{\unvbox\tw@}%
  \fi
  \prevdepth\dimen@
  \nobreak \bb@skip{24\p@}%
  \global\let\@serieslogo\relax \global\let\@setlogo\relax
}

\def\bullPerspective{}
\newif\if@SuperTitle  \@SuperTitlefalse
\def\SuperTitle#1{\@SuperTitletrue
  \def\@SuperTitle{#1}}
\def\@SuperTitlefont{\LARGE\bfseries}
\def\STintro#1{\def\@STintro{#1}}
\def\@STintro{}
\def\@setSuperTitle{%
  \vbox to4pc{\vfil\@SuperTitlefont\centering \@SuperTitle\par}%
  \ifx\@empty\STintro
  \else
    \begingroup \normalsize
      \centering
      \vskip24pt
      \parbox[t]{24pc}{\normalfont\small\@STintro\par}%
      \par
    \endgroup
    \prevdepth=\z@
  \fi
  \nobreak{\baselineskip7\p@\relax \bb@skip{4pc}}%
}
\def\maketitle{%
  \@topnum\z@ % this prevents figures from falling at the top of page 1
  \thispagestyle{firstpage}% this sets first page specifications
  \if@SuperTitle
    \vbox{\dimen@\topskip \advance\dimen@\headheight
      \advance\dimen@\headsep
      \hrule height\topskip depth-\dimen@}%
  \fi
  \@setcopyright
  \nointerlineskip
  \if@SuperTitle
    \begingroup
    \uppercasenonmath\@SuperTitle
    \@setSuperTitle
    \endgroup
    \@setlogo
  \fi
  \uppercasenonmath\shorttitle
  \ifx\@empty\shortauthors \let\shortauthors\shorttitle
  \else \andify\shortauthors
  \fi
  \@maketitle@hook
  \begingroup
  \@maketitle
  \toks@\@xp{\shortauthors}\@temptokena\@xp{\shorttitle}%
  \toks4{\def\\{ \ignorespaces}}% defend against questionable usage
  \edef\@tempa{%
    \@nx\markboth{\the\toks4
      \@nx\MakeUppercase{\the\toks@}}{\the\@temptokena}}%
  \@tempa
  \endgroup
  \c@footnote\z@
  \@cleartopmattertags
  \global\let\maketitle\@empty
}

\endinput
