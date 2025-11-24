%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "pcmi.cls",
%%%    version   = "1.02",
%%%    date      = "2012/02/01",
%%%    time      = "09:18:47 EDT",
%%%    checksum  = "51234 71 206 2486",
%%%    author    = "Ian Morrison",
%%%    address   = "Mathematics Department, Fordham University, 441 East Fordham Rd., Bronx, NY 10458 USA",
%%%    email     = "morrison@fordham.edu (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the IAS/Park City Mathematics Series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================
%%% ====================================================================
%%% 
%%% Change history
%%% 
%%% 2015/06/15 Version 1.00
%%% 
%%% 2016/08/01 Version 1.01
%%%            \numberwithin does not reset its interior counter
%%%            when a parent of the exterior counter causes the 
%%%            latter to be reset. So when \subsectionstrue we need to
%%%            manually \@addtoreset{equation}{section} here
%%%            to correctly set the equation counter when a new section
%%%            begins without a subsection 
%%% 
%%% 2017/02/01 Version 1.02
%%%            The setting of the footnote marker in amsart.cls
%%%            causes this marker to change size unpredictably.
%%%            Fixed by manually inserting the code to set this marker
%%%            used in the LaTeX kernel immediately after amsart.cls is
%%%            loaded.
%%% 
%%% 2019/02/25 Version 1.03
%%% 		   Use \everydisplay hook to reset \lineskiplimits
%%% 		   inside displays to prevent extra space at top of 
%%% 		   align and related amsmath environments.
%%%			   See \def\@display@init#1{% in amsmath.sty
%%%            Tweaked setting of displayskips in \@adjustvertspacing
%%%			   to compensate for sideffects of using a negative
%%%			   \lineskiplimit to compnesate for effects of this
%%%			   change.
%%% 		   Added \cleardoublepage in \AtEndDocument so my proofs
%%%            will have same number of pages as AMS' making
%%%            creation of "shuffled" spreads to compare these easier.
%%% 		   Added \ifproofs boolean (at top of source files) for
%%%			   producing proofs with line numbers for referees and lecturers
%%% 		   Only set to true by IMs proof production shell script. 
%%% 		   If so, \linenumbers is turned on AtBeginDocument
%%%            so avoid reflows caused by interactions with code for display
%%% 		   math in amsart.cls and amsmath.sty.
%%% 		   Fixed bug in \bibarxiv macro (missing //).
%%% 
%%% ====================================================================



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pcmi}[2019/02/25 v1.03]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions

\LoadClass{amsart}[2015/03/04 v2.20.2]

% override buggy setting of footnote marker in amsart.cls with code from LaTeX kernel
\def\@makefnmark{\hbox{\@textsuperscript{\normalfont\@thefnmark}}} 

%IM set up AMS publication series terms
\def\publname{IAS/Park City Mathematics Series}
\def\ISSN{1079-5634}
\def\volinfo{%
  Volume \currentvolume%
}%

%title and authors
\def\maketitle{\par
  \@topnum\z@ % this prevents figures from falling at the top of page 1
  \@setcopyright
  \thispagestyle{firstpage}% this sets first page specifications
%IM title and runnning head in roman not smallcaps
%\uppercasenonmath\shorttitle%IM Removed the conversion to upper case in the original line above. 
%\shorttitle%IM Removed the conversion to upper case in the original line above. 
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
%IM Removed the conversion to upper case in the original line below. 
%     \@nx\MakeUppercase{\the\toks@}}{\the\@temptokena}}%
      \@nx{\the\toks@}}{\the\@temptokena}}%%IM 
  \@tempa
  \endgroup
  \c@footnote\z@
  \@cleartopmattertags
}
\def\@settitle{\begin{center}%
  \baselineskip14\p@\relax
    \bfseries
%IM Increase type size of title since no longer all caps
\Large
%IM deleted uppercasenonmath from orogonal next line
%\uppercasenonmath\@title
\@title
  \end{center}%
}
\def\author@andify{%
  \nxandlist {\unskip ,\penalty-1 \space\ignorespaces}%
    {\unskip {} \@@and~}%
    {\unskip ,\penalty-2 \space \@@and~}%
}
\def\@setauthors{%
  \begingroup
  \def\thanks{\protect\thanks@warning}%
  \trivlist
  \centering\footnotesize \@topsep30\p@\relax
  \advance\@topsep by -\baselineskip
  \item\relax
  \author@andify\authors
  \def\\{\protect\linebreak}%
%IM Removed the conversion to upper case in the original line above.%\MakeUppercase{\authors}%
%IM INcrease size of author names since no longer in small caps
{\large\authors}
%
  \ifx\@empty\contribs
  \else
    ,\penalty-3 \space \@setcontribs
    \@closetoccontribs
  \fi
  \endtrivlist
  \endgroup
}
%addresses
\def\@setaddresses{\par
  \nobreak \begingroup
\footnotesize
  \def\author##1{\nobreak\addvspace\bigskipamount}%
  \def\\{\unskip, \ignorespaces}%
  \interlinepenalty\@M
  \def\address##1##2{\begingroup
    \par\addvspace\bigskipamount\indent
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\ignorespaces##2}\par\endgroup}%% IM removed \scshape
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent\curraddrname
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par}\endgroup}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent\emailaddrname
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par}\endgroup}%
  \def\urladdr##1##2{\begingroup
    \def~{\char`\~}%
    \@ifnotempty{##2}{\nobreak\indent\urladdrname
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par}\endgroup}%
  \addresses
  \endgroup
}
%abstract
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in AMS document classes; reported}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
    \normalfont\Small
    \list{}{\labelwidth\z@
      \leftmargin3pc \rightmargin\leftmargin
      \listparindent\normalparindent \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
    \item[\hskip\labelsep\bfseries\abstractname.]%
}{%
  \endlist\egroup
  \ifx\@setabstract\relax \@setabstracta \fi
}

% add 2017 subject classification to prevent warnings from amsart.c;s
\renewcommand{\subjclassname}{%
  \textup{1991} Mathematics Subject Classification}
\@xp\let\csname subjclassname@1991\endcsname \subjclassname
\@namedef{subjclassname@2000}{%
  \textup{2000} Mathematics Subject Classification}
\@namedef{subjclassname@2010}{%
  \textup{2010} Mathematics Subject Classification}
\@namedef{subjclassname@2017}{%
  \textup{201} Mathematics Subject Classification}


\ifsubsections

\setcounter{tocdepth}{2}
%IM the equation counter is used to number everything (including figures and tables)
%         equation numbers as section.subsection.equation
%         resetting with each subsection
%IM toc lists sections and subsections$
%\renewcommand{\theequation}{\thesection.\thesubsection.\arabic{equation}}
\numberwithin{equation}{subsection}
%IM Lecturers may have numbered items before the first subsection so
%IM     \numberwithin (which only resets \equation on seeing a 
%IM     \subsection) must be overridden so a \section also resets it.
\@addtoreset{equation}{section}

%IM force hyperref to add the subsection to its shadow equation counter
%IM    set to \theHsection.\arabic{equation}
%IM to avoid lots of duplicate dests and non-working links.
\newcommand{\theHequation}{\theHsection.\theHsubsection.\arabic{equation}}

%IM numbering of figures and tables (as well as everything else) uses the 
%         same format based on the equation counter
\let\c@figure\c@equation
\let\c@table\c@equation
\renewcommand{\thefigure}{\thesubsection.\arabic{equation}}
\renewcommand{\thetable}{\thesubsection.\arabic{equation}}
\else
%IM the equation counter is used to number everything (including figures and tables)
%         equation numbers as section.equation
%         resetting with each section
%IM toc lists sections
%\renewcommand{\theequation}{\thesection.\arabic{equation}}
\numberwithin{equation}{section}
\setcounter{tocdepth}{1}
%IM force hyperref to add the section to its shadow equation counter
%IM to avoid lots of duplicate dests and non-working links.
\newcommand{\theHequation}{\theHsection.\arabic{equation}}

%IM numbering of figures and tables (as well as everything else) uses the 
%         same format based on the equation counter
\let\c@figure\c@equation
\let\c@table\c@equation
\renewcommand{\thefigure}{\thesection.\arabic{equation}}
\renewcommand{\thetable}{\thesection.\arabic{equation}}
\fi 

%IM customization of floats, mainly figures and tables
\RequirePackage{float}
%IM try to get floats places where they occur in the source if possible
%         with plan to correct any bad pages in final editing pass.
\floatplacement{figure}{h!tpb}
\floatplacement{table}{h!tpb}

%IM reduce excessive vertical space around most floats with plan to
%         tweak bad looking examples by hand in final pass
\setlength{\textfloatsep}{10pt plus 5pt minus 3pt}
\setlength{\floatsep}{8pt plus 4pt minus 2.5pt}
\setlength{\intextsep}{8pt plus 4pt minus 2.5pt}

%IM prevent display skips from stretching when leading increases
\RequirePackage[nodisplayskipstretch]{setspace}
% 
%IM Last resort tracking adjustment to make displays #4 fit by a local 
% 			reduction of the #1#2#3 types of spaces: standard values ignoring
%           stretch are 5/3.5/3. Plugging in 3.5/2.5/2 is tight but not ugly.
\newcommand{\fitmath}[4]{%
\begingroup%
\thickmuskip=#1mu%
\medmuskip=#2mu%
\thinmuskip=#3mu%
{%
#4%
}%
\endgroup%
}

%IM loosen linespacing to allow most inline math to be set without
%         triggering unevenly spaced lines
\newcommand{\loosespread}{\setstretch{1.15}}
\newcommand{\bibspread}{\setstretch{1.02}\normalfont\selectfont}
\loosespread
%IM live dangerously by coercing inline grid spacing a bit
% 		to prevent most ragged linespacing at rish of allowing "collisions": 
% 		I check for and cure these in final proofing
\setlength\lineskiplimit{-3pt} 
\setlength\normallineskiplimit{-3pt} 
\everydisplay\expandafter{\the\everydisplay \setlength\lineskiplimit{0pt} 
\setlength\normallineskiplimit{0pt}}
%IM slightly more open llook to tabular environments too
\renewcommand{\arraystretch}{1.2}
%IM prevent bad widows and orphans caused by big displays with
%         plan to correct bad breaks by hand in final pass
\allowdisplaybreaks

%IM less stretch above skips (plus .4 versus .7 in amsmath) and
% \belowdisplayshortskip likewise \medskipamount not \smallskipamount
\def\@adjustvertspacing{%
  \bigskipamount.7\baselineskip plus.3\baselineskip
  \medskipamount.4\baselineskip plus.15\baselineskip
  \smallskipamount\medskipamount \divide\smallskipamount\tw@
  \abovedisplayskip\smallskipamount
  \belowdisplayskip\medskipamount
  \abovedisplayshortskip\smallskipamount
  \belowdisplayshortskip\medskipamount
  \jot\baselineskip \divide\jot 4 \relax
}


%IM design of headers
\RequirePackage{titlesec}
%IM \large bold section titles with generous offset
\titlespacing{\section}{0pt}{1.2\linespacing plus0.5\linespacing minus0.1\linespacing}{0.5\linespacing plus0.2\linespacing}
\titleformat{\section}{\normalfont\large\bfseries\filcenter}{\thesection.}{0.5em}{}[\kern0.em]
%IM runin bold section and subsection titles
\titleformat{\subsection}[runin]{\normalfont\bfseries}{\thesubsection.}{0.25em}{}[\kern0.5em]
\titleformat{\subsubsection}[runin]{\normalfont\bfseries}{\thesubsubsection.}{0.25em}{}[\kern0.5em]

%IM set up indentations for formatting of toc
\renewcommand*\l@section{\@tocline{1}{0pt}{0em}{1.75em}{}}
\renewcommand*\l@subsection{\@tocline{2}{0pt}{1.75em}{2em}{}} 
\renewcommand\contentsnamefont{\bfseries\large}

%IM set running heads
\def\ps@normal{\def\@oddhead{\small \hfill \leftmark \hfill\thepage }
\def\@evenhead{\small \thepage \hfill \rightmark \hfill}
\def\@oddfoot{}
\def\@evenfoot{}}

%IM customization of amsrefs: needs to be executed after
%IM        the amsrefs package is loaded so it does not get overwritten
\long\def\customizeamsrefs{%
%IM  Set running head in references in lower case not upper
\def\bib@div@mark##1{%
 \@mkboth{{##1}}{{##1}}%
	}
%IM use leftarrow instead of uparrow to mark backrefs
\def\print@backrefs##1{%
 \space\SentenceSpace$\leftarrow${\csname br@##1\endcsname}
}
%IM  color the prefixing MR in MathRevs links to match the rest
%           and to use \texttt
\def\MRhref##1##2{%
 \begingroup
 \parse@MR##1 ()\@empty\@nil%
  \href{\MR@url}{\texttt{\@tempd\vphantom{()}}}%
  \ifx\@tempe\@empty
  \else
   \ \href{\MR@url}{\texttt{(\@tempe)}}%
  \fi
 \endgroup
}%
\def\MR##1{%
 \relax\ifhmode\unskip\spacefactor3000 \space\fi
 \begingroup
 \strip@MRprefix##1\@nil
  \edef\@tempa{\@nx\MRhref{MR\@tempa}{\@tempa}}%
 \@xp\endgroup
 \@tempa
}
%IM reset eprint command: will fill in as links by providing
%         author macros for pointing to arXiv and other urls
\renewcommand{\eprint}[1]{##1}
\newcommand{\bibarxiv}[1]{\href{https://arxiv.org/abs/##1}{{{\texttt{arXiv:##1}}}}}
\newcommand{\biburl}[1]{\texttt{\url{##1}}}
}%IM customizeamsrefs


%IM Allow authors to use colors in drafts of their lectures (e.g. for links)
%IM     via \drafttrue but make everything black for the AMS via draftfalse.
%IM     For examples see the definitions of linkblue and linkred in 
%IM     PCMILecturerTemplate.tex
\newif\ifdraft
\draftfalse

%IM setup PCMI anniversary logo for the title page of Guide
\newcommand\PCMIlogo{\hbox{}\vskip-72pt\centerline{\includegraphics[scale=0.5]{PCMILogo.pdf}}\vskip48pt}

%IM quick commentout macro for use in hiding sections of author files while debugging
\long\def\commentout#1{}

%% AMS: Moved pagestyle and \raggedbottom commands to their proper
%% place at the bottom of pcmims.cls
\AtBeginDocument{%
\pagestyle{normal}
\raggedbottom
\ifproofs\linenumbers\fi
}
%% AMS: This is unnecessary in our production system, but it's harmless.
\AtEndDocument{%
%IM Permit final versions to match paging they will have
%%%			in the published volume so they can be rolled up
%%%			and shuffled to produce spreads for checking AMS proofs
\ifdraft\else\clearpage{\thispagestyle{empty}\cleardoublepage}\fi 
}

\endinput% end of pcmi.cls
