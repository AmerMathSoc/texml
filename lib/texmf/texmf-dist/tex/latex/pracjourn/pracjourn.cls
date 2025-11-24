%%
%% This is file `pracjourn.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pracjourn.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2004 TeX Users Group.
%% 
%%     This program is free software; you can redistribute it and/or modify
%%     it under the terms of the GNU General Public License as published by
%%     the Free Software Foundation; either version 2 of the License, or
%%     (at your option) any later version.
%% 
%%     This program is distributed in the hope that it will be useful,
%%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%     GNU General Public License for more details.
%% 
%%     You should have received a copy of the GNU General Public License
%%     along with this program; if not, write to the Free Software
%%     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{pracjourn}
    [2007/08/25 v0.4n PracTeX Journal Class]
\let\ExecuteOptions@ltx\ExecuteOptions
\def\ExecuteOptions#1{%
 \ExecuteOptions@ltx{letterpaper,12pt,oneside,onecolumn,final}%
}%
\LoadClassWithOptions{article}
\let\ExecuteOptions\ExecuteOptions@ltx
\linespread{1.069}
\setlength\textwidth{432pt}
\setlength\oddsidemargin{18pt}% xx depend on letter/a4
\setlength\evensidemargin{18pt}
\IfFileExists{lmodern.sty}{%
  \RequirePackage{lmodern}
  \usepackage[T1]{fontenc}}{}
\IfFileExists{mathpazo.sty}
             {\RequirePackage[sc]{mathpazo}}
             {\renewcommand\rmdefault{ppl}}
\IfFileExists{microtype.sty}{%
  \RequirePackage[protrusion=true,expansion=false]{microtype}}{}
\RequirePackage{textcomp}
\RequirePackage{color,hyperref,graphicx}
\definecolor{linkcolour}{rgb}{0,0.2,0.6}
\hypersetup{colorlinks,breaklinks,
            linkcolor=linkcolour,citecolor=linkcolour,
            filecolor=linkcolour, urlcolor=linkcolour}
\IfFileExists{switcheml.sty}
             {\RequirePackage{switcheml}
              \AtBeginDocument{\@ifx@undefined{\typesetemail}{\obfuscateemail}{}}}
             {\AtBeginDocument{\@ifx@undefined{\typesetemail}{\hyperlinkemail}{}}}
\renewcommand\maketitle{\par
  \iftpj@noabstract\else
    \@ifx@undefined{\tpj@info@\string\abstract}
      {\ClassError{pracjourn}
        {Please specify an \string\abstract\space before \string\maketitle}
        {It is a PracTeX Journal requirement to include an abstract.   \MessageBreak
                                                                       \MessageBreak
         If you have exceptional reasons for not having one in this    \MessageBreak
         article, write \string\noabstract\space somewhere before \string\maketitle.}}{}
  \fi
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    \thispagestyle{titlepage}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}%
\def\@maketitle{%
  \newpage
  \null
  \write@ID@aux\read@issue
  \begin{flushleft}
    \let\footnote\thanks
    \begingroup\LARGE \@title  \par\endgroup
    \vspace{2ex}%
    \begingroup\large \@author \par\endgroup
  \end{flushleft}
  \tpj@optional@author@info
  \iftpj@noabstract\else
    \vspace{2ex}%
    \tpj@info@container{\abstractname}{\abstract}
  \fi}
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                     {-3.5ex \@plus -1ex \@minus -.2ex}%
                                     {2.3ex \@plus.2ex}%
                                     {\normalfont\Large\raggedright}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\large\raggedright}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\raggedright}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                     {3.25ex \@plus1ex \@minus.2ex}%
                                     {-1em}%
                                     {\normalfont\normalsize\itshape}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                     {3.25ex \@plus1ex \@minus .2ex}%
                                     {-1em}%
                                     {\normalfont\normalsize\itshape}}
\let\tpj@itemize\itemize
\let\tpj@enditemize\enditemize
\let\tpj@enum\enumerate
\let\tpj@endenum\endenumerate
\let\tpj@desc\description
\let\tpj@enddesc\enddescription
\renewenvironment{itemize}
  {\tpj@itemize\parskip0pt}{\tpj@enditemize}
\renewenvironment{enumerate}
  {\tpj@enum\parskip0pt}{\tpj@endenum}
\renewenvironment{description}
  {\tpj@desc\parskip0pt\parindent1.8em}{\tpj@enddesc}
\let\itemise\itemize
\let\enditemise\enditemize
\renewcommand\labelitemi{\normalfont\bfseries\textendash}
\renewcommand\labelitemii{\normalfont\bfseries\textperiodcentered}
\renewcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\itshape #1}
\def\@makefntext#1{%
  \parindent 0em\relax
  \makebox[1.5em][l]{\normalfont\footnotesize\@thefnmark.}#1}
\def\@ifx@empty#1{% Implicit #2#3
  \ifx#1\@empty
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi}%
\def\@ifx@undefined#1{% Implicit #2#3
  \ifx#1\@undefined
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi}%
\def\@ifeof#1{% Implicit #2#3
 \ifeof#1
   \expandafter\@firstoftwo
 \else
   \expandafter\@secondoftwo
 \fi}%
\def\boolean@true#1{\let#1\@firstoftwo}%
\def\boolean@false#1{\let#1\@secondoftwo}%
\def\ps@titlepage{%
  \def\@oddhead{\titlepage@head\hfil}%
  \let\@evenhead\@oddhead
  \def\@oddfoot{\hfil\titlepage@foot}%
  \let\@evenfoot\@oddfoot}%
\def\titlepage@head{\footnotesize
  \parbox{\linewidth}{%
    \@ifx@empty\@TPJissue{For submission to \TPJ}{\@TPJissue}\par
    \@ifx@empty\@TPJissue
       {\@ifx@empty\@TPJrevision{Draft of \today}{Article revision \@TPJrevision}}%
       {\@ifx@empty\@TPJrevision
          {\ClassError{pracjourn}
            {\string\TPJrevision\space must be defined if
             \string\TPJissue\space is also}
            {It is a requirement for PracTeX Journal articles to contain\MessageBreak
             revision information for version tracking. Please input this\MessageBreak
             information, or omit \protect\TPJissue.}}
          {Article revision \@TPJrevision}}}}%
\def\titlepage@foot{%
  \vtop{\raggedleft\footnotesize\@TPJcopyright}}%
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
\newcommand\addinfo[2][]{%
  \def\@tempa{\new@addinfo{#1}{#2}}%
  \lowercase{\expandafter\@tempa\expandafter{\csname#2\endcsname}}}
\newcommand\new@addinfo[3]{%
  \tpj@define@info@block{#3}%
  \expandafter\newcommand
    \csname\expandafter\@gobble\string#3name\endcsname{#2}%
  \g@addto@macro\tpj@optional@author@info{%
    \tpj@info@container[#1]{\csname\expandafter\@gobble\string#3name\endcsname}{#3}}}
\newcommand\newinfo[1]{%
  \@ifnextchar[{\@newinfo{#1}}{\@newinfo{#1}[]}}
\def\@newinfo#1[#2]#3{%
  \tpj@define@info@block{#1}%
  \expandafter\newcommand
    \csname\expandafter\@gobble\string#1name\endcsname{#3}%
  \g@addto@macro\tpj@optional@author@info{%
    \tpj@info@container[#2]{%
      \csname\expandafter\@gobble\string#1name\endcsname}{#1}}}
\newcommand\addinfospace[1]{\g@addto@macro\tpj@optional@author@info{\vspace{#1}}}
\newcommand\tpj@define@info@block[1]{%
  \newcommand#1[1]{\expandafter\def\csname tpj@info@\string#1\endcsname{##1}}}
\newcommand\clearinfo{\let\tpj@optional@author@info\@empty}
\clearinfo
\addinfo[\typesetemail]{Email}
\addinfo[\url]{Website}
\addinfo[\linespread{0.9}\selectfont]{Address}
\let\abstract\relax
\tpj@define@info@block\abstract
\def\abstractname{Abstract}
\newif\iftpj@noabstract
\newcommand\noabstract{\tpj@noabstracttrue}
\def\endabstract{%
  \ClassError{pracjourn}
   {Please input the abstract with \string\abstract{...}, before \string\begin{document}}
   {Instead of the \string\begin{abstract}...\string\end{abstract} \MessageBreak
    environment, use \string\abstract{...}. Paragraphs are allowed!\MessageBreak
                                                                   \MessageBreak
    Because the abstract is typeset with the title block,          \MessageBreak
    it must be input before the \string\begin{document}\space command.}}
\newcommand{\TPJissue}[2]{\gdef\@TPJissue{\TPJ, #1, No.\,#2}}%
\newcommand{\TPJrevision}[3]{\gdef\@TPJrevision{#1/#2/#3}}%
\newcommand{\TPJcopyright}[1]{\gdef\@TPJcopyright{#1}}%
\let\@TPJissue\@empty
\let\@TPJrevision\@empty
\let\@TPJcopyright\@empty
\let\license\TPJcopyright
\newcommand\tpj@info@container[3][]{%
  \gdef#3{\ClassError{pracjourn}{#2 must be defined BEFORE \string\maketitle}{}}
  \expandafter\ifx\csname tpj@info@\string#3\endcsname\relax\else
    \noindent\small
    \begin{minipage}[t]{0.15\textwidth}
      \noindent\hfill\sffamily#2
    \end{minipage}\hfill
    \begin{minipage}[t]{0.825\textwidth}
      \linespread{1.0}\selectfont
      \setlength\parindent{1.5em}%
      \noindent\ignorespaces
      \expandafter#1\expandafter{\csname tpj@info@\string#3\endcsname}
    \end{minipage}\par
  \fi}
\newcommand\obfuscateemail{%
  \def\typesetemail##1{\ttfamily\switchemail{##1}}}
\newcommand\hyperlinkemail{%
  \def\typesetemail##1{\ttfamily\tpj@compose@mailto{##1}{Re: PracTeX Journal article}{##1}}}
\newcommand\tpj@compose@mailto[3]{%
  \edef\@tempa{mailto:#1?subject=#2 }%
  \edef\@tempb{\expandafter\html@spaces\@tempa\@empty}%
  \href{\@tempb}{#3}}

\catcode`\%=11
\def\html@spaces#1 #2{#1%20\ifx#2\@empty\else\expandafter\html@spaces\fi#2}
\catcode`\%=14
\newcommand\note[1]{\unskip\footnote{#1}}
\DeclareRobustCommand\dash{%
  \unskip\nobreak\thinspace\textemdash\thinspace\ignorespaces}
\pdfstringdefDisableCommands{\renewcommand{\dash}{ - }}
\newcommand\ctanfile[1]{%
  \href{http://www.ctan.org/get?fn=/#1}
       {\path{CTAN:#1}}}
\newcommand\ctanloc[1]{%
  \href{http://www.ctan.org/tex-archive/#1}
       {\path{CTAN:#1}}}
\newcommand\tpj@deflogo{\@dblarg\tpj@@deflogo}
\newcommand\tpj@@deflogo[3][\@nil]{%
  \expandafter\DeclareRobustCommand\csname#2\endcsname{#3}%
  \pdfstringdefDisableCommands{%
    \expandafter\def\csname#2\endcsname{#1}}}
\tpj@deflogo{TeX}{T\kern-.15em\lower.5ex\hbox{E}\kern-.07em X\spacefactor1000\relax}
\tpj@deflogo{LaTeX}{L\kern-.32em\raise.37ex\hbox{\scalebox{0.76}{A}}\kern-.15em\TeX}
\tpj@deflogo{LaTeXe}{\LaTeX2$_{\textstyle\varepsilon}$}
\tpj@deflogo{BibTeX}{B{\textsc i\kern-.025em\textsc b}\kern-.08em\TeX}
\DeclareRobustCommand\logofamily{%
  \not@math@alphabet\logofamily\relax
  \fontencoding{U}\fontfamily{logo}\selectfont}
\DeclareTextFontCommand{\textlogo}{\logofamily}
\tpj@deflogo[MetaFont]{MF}{\textlogo{META}\@dischyph\textlogo{FONT}\@}
\tpj@deflogo[MetaPost]{MP}{\textlogo{META}\@dischyph\textlogo{POST}\@}
\tpj@deflogo{ConTeXt}{C\kern-.03em on\-\kern-.10em\TeX\kern-0.04em t}%
\tpj@deflogo{pdfTeX}{pdf\/\TeX}
\tpj@deflogo{pdfLaTeX}{pdf\/\LaTeX}
\newcommand\PS{PostScript}
\tpj@deflogo{PracTeX}{Prac\kern-0.07em\TeX}
\newcommand\TPJ{The \PracTeX\ Journal}
\tpj@deflogo{XeTeX}{%
      X\lower.5ex\hbox{\kern-.07em\reflectbox{E}}%
      \kern-.15em\TeX}
\tpj@deflogo{ExTeX}{\textrm{\relax
 \ensuremath{\textstyle\varepsilon_{\kern-0.15em\mathcal{X}}}\relax
 \kern-.15em\TeX}}
\def\write@ID@aux{%
 \@ifx@empty\@TPJrevision{}{%
  \begingroup
   \let\thanks\@gobble
   \immediate\openout\ID@aux _rev.tex
   \immediate\write\ID@aux{\@TPJrevision}%
   \immediate\closeout\ID@aux
  \endgroup
 }%
}%
\newwrite\ID@aux
\def\read@issue{%
 \openin\@inputcheck _iss.tex
 \@ifeof\@inputcheck{}
   {\ifx\@TPJissue\@empty\else
      \typeout{---------^^J
               pracjourn: \protect\TPJissue\space info overwritten due to _iss.tex file^^J
               ---------}
    \fi
    \read\@inputcheck to\@TPJissue
    \closein\@inputcheck
    \expandafter\parse@iss\@TPJissue\@nil}}
\def\parse@iss TPJ #1 No #2, #3-#4-#5\@nil{%
  \@tempcnta#2\relax
  \protected@xdef\@TPJissue{\TPJ, #1, No.\,\the\@tempcnta}}
\def\set@pdfpage{%
 \@ifx@undefined\pdfoutput{}{%
  \pdfpagewidth =\paperwidth
  \pdfpageheight=\paperheight
  \relax}}
\AtBeginDocument{\set@pdfpage}
\endinput
%%
%% End of file `pracjourn.cls'.
