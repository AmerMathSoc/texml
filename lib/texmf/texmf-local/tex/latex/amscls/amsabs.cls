%%
%% This is file `amsabs.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% amsabs.dtx 
%% 
%% ====================================================================
%%  @LaTeX-class-file{
%%    filename  = "amsabs.dtx",
%%    version   = "2.08",
%%    date      = "2008/08/04",
%%    time      = "13:42:37 EDT",
%%    checksum  = "25945 268 755 8555",
%%    author    = "American Mathematical Society",
%%    address   = "American Mathematical Society,
%%                 Production Technical Group,
%%                 201 Charles Street,
%%                 Providence, RI 02940-2294,
%%                 USA",
%%    telephone = "+1 401 455 4080",
%%    FAX       = "+1 401 331 3842",
%%    email     = "tech-support@ams.org",
%%    copyright = "Copyright 2005 American Mathematical Society,
%%                 all rights reserved.  Copying of this file is
%%                 authorized only if either:
%%                 (1) you make absolutely no changes to your copy,
%%                 including name; OR
%%                 (2) if you do make changes, you first rename it
%%                 to some other name.",
%%    supported = "yes",
%%    keywords  = "latex, AMS, documentclass, abstracts",
%%    abstract  = "This file is the LaTeX document class
%%                 for abstracts of papers presented to
%%                 the American Mathematical Society.  It
%%                 defines features which are specific to
%%                 Abstracts of the AMS.",
%%    docstring = "The checksum field above contains a CRC-16
%%                 checksum as the first value, followed by the
%%                 equivalent of the standard UNIX wc (word
%%                 count) utility output of lines, words, and
%%                 characters.  This is produced by Robert
%%                 Solovay's checksum utility.",
%%  }
%% ====================================================================
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{amsabs}[2008/08/04 v2.08 AMS Abstracts document class]
\let\@xp\expandafter
\let\@nx\noexpand
\long\def\@ifempty#1{\@xifempty#1@@..\@nil}
\long\def\@xifempty#1#2@#3#4#5\@nil{%
  \ifx#3#4\@xp\@firstoftwo\else\@xp\@secondoftwo\fi}
\long\def\@ifnotempty#1{\@ifempty{#1}{}}
\newif\ifmtginfo\mtginfofalse
\newif\ifprelim\prelimfalse
\def\@prelimreport{\unskip}
\def\prelim{\gdef\@prelimreport{Preliminary report.}\prelimtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[12pt]{article}[1995/12/01]
\RequirePackage{amssymb}[1995/01/01]
\RequirePackage{amsmath}[2000/07/18]
\IfFileExists{abs.proof}{\global\mtginfotrue}{}
\ifx\pdftexversion\@undefined
  \AtBeginDocument{\special{landscape}}%
\else
  \pdfpageheight=8.5in\pdfpagewidth=11in\relax
\fi
\nofiles
\if@compatibility\input{newlfont.sty}\fi
\def\normalmode{%
  \textwidth51.5pc\relax
  \textheight30pc\relax
  \advance\textheight by \topskip
  \oddsidemargin1pc\evensidemargin1pc\marginparwidth\z@
  \normalbaselineskip12pt\def\baselinestretch{1.15}%
  \normalsize
  \leftskip1.5in}
\normalmode
\def\proofmode{%
  \ClassWarning{amsabs}{%
    \string\proofmode\space no longer available.  Print using
    \MessageBreak
    landscape orientation instead}%
}
\def\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\hb@xt@\z@{$\m@th^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{\hss\@makefnmark}##1}%
    \ifmtginfo
      \@xp\@ifnotempty\@xp{\@mtginfo}{%
        \begingroup
          \leftskip\z@skip
          \noindent
          \vbox to\z@{\vss
            \noindent\textbf{Meeting:} \ \textrm{\@mtginfo}\endgraf
            \vskip.5in}\endgraf
        \endgroup
      }%
    \fi
    \global\@topnum\z@
    \@maketitle
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
}
\def\@maketitle{\null
  \begingroup
    \skip@\leftskip
    \raggedright
    \leftskip\skip@
    \def\baselinestretch{1}\normalsize
    \noindent
    \llap{\hbox to\leftskip{\absnum\hfil}}%
    \begingroup
      \setcounter{author}{0}%
      \let\author\printauthor\let\email\printemail
      \let\address\printaddress
      \def\@tempa##1##2@{\def\authordata{##2##1}}%
      \@xp\@tempa\authordata @%
      \authordata\unskip.\space
    \endgroup
    \textit{\ignorespaces\@title}%
    \ignorespaces\enspace\@prelimreport\par
  \endgroup}
\newif\ifpreviousaddress
\newif\ifaddress
\def\printauthor#1#2\@nil{%
  \stepcounter{author}%
  \addressfalse
  \begingroup \let\email\@gobble
    \def\address##1{\aftergroup\addresstrue}%
    #2\relax
  \endgroup
  \ifnum\c@author>\@ne
    \ifnum\c@author=\c@totalauthors
      \ifpreviousaddress,\fi\space and\space
    \else
      \ifaddress
        \ifpreviousaddress
          \unskip,\space
        \else
          \unskip\space and\space
        \fi
      \else
        \ifpreviousaddress
          \unskip,\space and\space
        \else
          \unskip,\space
        \fi
      \fi
    \fi
  \fi
  \textbf{#1}%
  \previousaddressfalse
  #2\relax
}
\IfFileExists{url.sty}{\RequirePackage{url}}{\let\url\texttt}
\def\printemail#1{\unskip\space(\url{#1})}
\def\printaddress#1{\previousaddresstrue\unskip,\space#1}
\newcount\c@author\c@author0
\newcount\c@totalauthors\c@totalauthors0
\def\authordata{}
\def\author#1{\stepcounter{totalauthors}%
  \toks@\@xp{\authordata \@nil\author{#1}}%
  \edef\authordata{\the\toks@}}
\def\email#1{%
  \@ifnotempty{#1}{%
    \toks@\@xp{\authordata \email{#1}}%
    \edef\authordata{\the\toks@}}}
\def\address#1{%
  \@ifnotempty{#1}{%
    \toks@\@xp{\authordata\address{#1}}%
    \edef\authordata{\the\toks@}}}
\def\abstract{\leftskip\z@\noindent\ignorespaces}
\def\endabstract{\par}
\def\amsmtginfo#1{\gdef\@mtginfo{#1}}
\amsmtginfo{}
\def\received#1{\unskip\enspace(Received #1)}
\def\amsabsnum#1{\gdef\absnum{\textrm{#1}}}
\amsabsnum{}
\endinput
%%
%% End of file `amsabs.cls'.
