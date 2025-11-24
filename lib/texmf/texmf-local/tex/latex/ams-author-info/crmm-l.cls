%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "crmm-l.cls",
%%%    version   = "2.01",
%%%    date      = "2005/05/11",
%%%    time      = "14:51:14 EDT",
%%%    checksum  = "04190 61 197 2088",
%%%    author    = "American Mathematical Society",
%%%    address   = "American Mathematical Society,
%%%                 201 Charles Street
%%%                 Providence, RI 02904-2294, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the CRM Monograph
%%%                 Series of the American Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{crmm-l}[2005/05/11 v2.01 CRMM Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1999/12/16]

\newdimen\chapnumwidth
\settowidth\chapnumwidth{0.}
\renewcommand{\tocchapter}[3]{%
  \indentlabel{\@ifnotempty{#2}{\ignorespaces#1\space
    \hbox to\chapnumwidth{\hfil#2.}\quad}}#3}

\def\th@plain{%
%%  \let\thm@indent\noindent % no indent
  \thm@headfont{\bfseries}% heading font is bold
  \thm@notefont{\bfseries}%
%%  \thm@headpunct{.}% add period after heading
%%  \let\thm@swap\@gobble
%%  \thm@preskip\topsep
%%  \thm@postskip\theorempreskipamount
  \itshape % body font
}
\def\th@definition{%
  \thm@headfont{\bfseries}% heading font is bold
  \thm@notefont{\bfseries}%
  \normalfont % body font
}
\def\th@remark{%
  \thm@headfont{\bfseries}% heading font is bold
  \thm@notefont{\bfseries}%
  \normalfont % body font
}
\let\@secnumfont\bfseries
\def\citeform#1{{\mdseries#1}}

\endinput
