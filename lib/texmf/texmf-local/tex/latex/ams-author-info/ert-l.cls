%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "ert-l.cls",
%%%    version   = "2.02",
%%%    date      = "2007/06/18",
%%%    time      = "09:14:58 EDT",
%%%    checksum  = "56040 66 238 2480",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    supported = "yes",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    abstract  = "This is a LaTeX documentclass for the Representation
%%%                 Theory, an electronic journal of the American
%%%                 Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ert-l}[2007/06/18 v2.02 Representation Theory Document Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions

%    Requires amsart.cls dated 24 October 1996 or later.
\LoadClass[e-only]{amsart}[1996/10/24]

%    \rlap to keep the second line from breaking at .5\hsize
\def\publname{%
  REPRESENTATION THEORY\newline
  \rlap{An Electronic Journal of the American Mathematical Society}}

\def\ISSN{1088-4165}

\copyrightinfo{\currentyear}%    % copyright year
  {American Mathematical Society}% copyright holder

\setcounter{page}{1}% reset from 0 as done by \pagespan

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
