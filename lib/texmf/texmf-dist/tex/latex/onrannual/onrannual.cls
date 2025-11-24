%% onrannual.cls
%% Copyright 2009-2010 Adam R. Maxwell
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is A. R. Maxwell.
%
% This work consists of the file onrannual.cls.

%
% Document class for ONR Ocean Battlespace Sensing annual reports, following format
% from http://www.onr.navy.mil/sci_tech/32/reports/annual/ as of Sept 2009.
% Developed and maintained by Adam R. Maxwell, adam.maxwell@pnl.gov
%

\ProvidesClass{onrannual}[2010/03/13 v1.1 ONR annual report document class]
\NeedsTeXFormat{LaTeX2e}

%
% This class is a modification of the standard article class.  The primary
% documentation is the skeleton.tex file available at CTAN:
%
% http://mirror.ctan.org/macros/latex/contrib/onrannual/skeleton.tex
%
% Lacking that, note that the following three new commands are provided:
%
% \distribution{xxx} where xxx is the appropriate distribution statement A or B
% \awardnumber{N00014-xxx} where the argument is your award number
% \projecturl{\url{http:foo}} which is an optional project URL
%

%% This technique was copied from latex.ltx, since I couldn't find any documented
%% way to use commands in the preamble.
\let\@awardnumber\@empty
\def\awardnumber#1{\def\@awardnumber{#1}}

\let\@projecturl\@empty
\def\projecturl#1{\def\@projecturl{#1}}

\let\@distribution\@empty
\def\distribution#1{\def\@distribution{#1}}

% Times and Helvetica
% XeTeX should be an alternative here, but it wasn't producing a bold title,
% and I didn't want to spend time figuring out why.
\RequirePackage{mathptmx}

% Remaining packages require article to be loaded
\LoadClass[12pt]{article}

% margins given in style guide; different from Word template...
\RequirePackage[margin=0.8in, bottom=1.0in]{geometry}

% block format for author/address
\RequirePackage[blocks]{authblk}

% get rid of section numbers
\setcounter{secnumdepth}{-2}

% no paragraph indentation; everything has to be flushleft
\setlength{\parindent}{\z@}

\fontsize{12}{14}
\selectfont

% use a single line to separate paragraphs
\setlength{\parskip}{\baselineskip}
\RequirePackage{parskip}

% change font and justification for captions
\RequirePackage{caption}
\captionsetup{font={bf,it}, justification=centering}

% reference list name for bibliography command
\renewcommand{\refname}{REFERENCES}

% This is sort of nasty; we have to adjust skip around the headings, as well
% as the font size, since the parskip package won't fix them.
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-10pt}% no skip above the heading
                                   {7pt}% if positive, is the skip below; else is the skip to right of run-in
                                   {\normalfont\bfseries\MakeUppercase}} % bold, normal size, uppercase
      
%% ONR reports don't allow for a subsection or subsubsection, conceptually, so redefine
%% to print an error message instead of allowing headings that look stupid.                               
\renewcommand\subsection{\PackageError{onrannual}{Subsections not available for ONR reports}{ONR reports do not include sub or lower sectioning.}}  
\renewcommand\subsubsection{\subsection}                        
                                   
%% Copied \maketitle definition from article.cls.  Most adjustments here are for spacing, but
%% also to avoid printing the date.
\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \setlength\parskip{\z@}%
  \newpage
  \begin{center}%
  {\footnotesize\textit{\@distribution}}
  \vskip 2\baselineskip
  \let \footnote \thanks
    % title font is 14 pt bold
    {\fontsize{14}{\f@baselineskip}\fontseries{b}\selectfont \@title}%
    \vskip \baselineskip
    \setlength{\affilsep}{\z@}%
    {\begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip \baselineskip
    Award Number: \@awardnumber \par
    \@projecturl
  \end{center}%
  \par
  \vskip 1.5em}

% ONR wants active hyperlinks colored blue, based on email correspondence, so we'll load it last
% after mucking about with sectioning
\RequirePackage[colorlinks=true, pdfborder={0 0 0}, linkcolor=black, citecolor=black, urlcolor=blue, bookmarks=false]{hyperref}

%% now for anything that has to be set as late as possible
\AtBeginDocument{%

    % this is really gruesome, since I don't understand how natbib changes the heading
    \@ifpackageloaded{natbib}{%
      \renewcommand\bibsection{%
       \section{\refname\@mkboth{\MakeUppercase{\refname}}{\MakeUppercase{\refname}}\vspace{7pt}}%
      }%
    }{}%
      
    % for some reason, they want it to look as if a typewriter was used...
    \raggedright%
    
    % don't use Courier for URLs; this works for hyperref also
    \@ifpackageloaded{url}{\urlstyle{rm}}{}%
}
