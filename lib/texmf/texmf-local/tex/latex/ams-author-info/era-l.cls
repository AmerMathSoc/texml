%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "era-l.cls",
%%%    version   = "2.02",
%%%    date      = "2007/06/18",
%%%    time      = "09:13:32 EDT",
%%%    checksum  = "33242 143 471 5105",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the journal
%%%                 Electronic Research Announcements of the American
%%%                 Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{era-l}[2007/06/18 v2.02 ERA-AMS Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions

%    Requires amsart.cls dated 24 October 1996 or later.
\LoadClass[e-only]{amsart}[1996/10/24]

\def\publname{ELECTRONIC RESEARCH ANNOUNCEMENTS\newline
    OF THE AMERICAN MATHEMATICAL SOCIETY}

\def\ISSN{1079-6762}

\copyrightinfo{\currentyear}%    % copyright year
  {American Mathematical Society}% copyright holder

\setcounter{page}{1}% reset from 0 as done by \pagespan

%    This is a copy of PROC's \@maketitle in order to have the \commby
%    information print. [mjd,1996/02/29]

\def\@maketitle{%
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \ifx\@empty\@date\else \@footnotetext{\@setdate}\fi
  \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks}\fi
  \@mkboth{\@nx\shortauthors}{\@nx\shorttitle}%
  \global\topskip42\p@\relax % 5.5 picas to the base of the first title line
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
  \dimen@34\p@ \advance\dimen@-\baselineskip
  \vskip\dimen@\relax
} % end \@maketitle

\newcommand{\revdate}[1]{%
  \ifx\@empty\@revdates \gdef\@revdates{#1}%
  \else\g@addto@macro\@revdates{\and#1}\fi}

\let\@revdates\@empty

\def\@setdate{\datename\ \@date
  \ifx\@empty\@revdates\else
    \andify\@revdates
    \unskip\space and, in revised form, \@revdates
  \fi
  \@addpunct.}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    The commands \communicated_by and \inRevisedForm, which were
%    provided in an early version of era-l.cls, have been superseded by
%    preferred forms (\commby, \revdate) , but we'd better continue to
%    support the old forms to avoid inconvenient problems with existing
%    documents. [mjd,1996/03/04]

%    Underscore is not a valid character in LaTeX command names;
%    this definition only worked by virtue of TeX's arcane delimited
%    macro argument feature.
\def\communicated_by{%
  \ClassWarning{era-l}{The command
    \protect\communicated_by is deprecated, try
    \protect\commby\space instead}%
  \commby}

%    Instead of \inRevisedForm, a command syntax more consistent with
%    the handling of other multi-instance data (e.g., \author, \email)
%    would be
%
%      \date{...}% primary received date
%      \revdate{...}% revised
%      \revdate{...}% and maybe another time
%
%    And then arrange to automatically construct the date list in the
%    proper form in the same way as we do for author names.
%    [mjd,1996/02/29]

\def\inRevisedForm{%
  \ClassWarning{era-l}{Command \protect\inRevisedForm\space is
    deprecated, use \protect\revdate\space instead}%
  \leavevmode\unskip, and in revised form, }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    The following patches provide elements not included in or different
%    from those in the the public version of amsart.cls. [bnb, 1996/10/17]
\@ifundefined{AMSPPS}{}{\endinput}

% Misc patches
%    Add \MR, \CMP, \URL
\newcommand\AMSPPS[1]{\relax\ifhmode\unskip\spacefactor3000 \space\fi
  \def\@tempa##1-##2-##3-##4\@nil{\AMSPPShref{##1}{##2}{##3}}%
  \@tempa #1-?-?-?\@nil{AMSPPS \##1}}
\let\MRhref\@gobble
\def\AMSPPShref#1#2#3{}
\providecommand\CMP[1]{CMP #1}
\renewcommand\URL{\begingroup
  \def\@sverb##1{%
    \def\@tempa####1##1{\hyphenchar\font=`\/\relax
      \@URL{####1}%
      \hyphenchar\font\m@ne \egroup\endgroup}%
    \@tempa}%
  \verb}

\endinput
