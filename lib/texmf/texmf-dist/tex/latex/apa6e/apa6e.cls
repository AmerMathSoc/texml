%%
%% This is file `apa6e.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% apa6e.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2011 by Nathaniel J. Smith <njs@pobox.com>
%% 
%% Redistribution and use in source and binary forms, with or without
%% modification, are permitted provided that the following conditions are
%% met:
%% 
%%    1. Redistributions of source code must retain the above copyright
%%       notice, this list of conditions and the following disclaimer.
%% 
%%    2. Redistributions in binary form must reproduce the above
%%       copyright notice, this list of conditions and the following
%%       disclaimer in the documentation and/or other materials provided
%%       with the distribution.
%% 
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%% ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
%% A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
%% HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
%% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
%% LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
%% DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
%% THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
%% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apa6e}
    [2011/03/03 v0.3 APA 6e manuscript formatting]
\DeclareOption{endnotes}{\def\apaSIXe@endnotes\relax}
\DeclareOption{leavefloats}{\def\apaSIXe@leavefloats\relax}
\DeclareOption{floatmarkers}{\def\apaSIXe@floatmarkers\relax}
\DeclareOption*{%
\PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass[12pt]{article}
\RequirePackage{times}
\RequirePackage{mathptmx}
\RequirePackage[margin=1in,headheight=15pt]{geometry}
\RequirePackage[document]{ragged2e}
\setlength{\RaggedRightParindent}{0.5in}
\newcommand{\@doublespacing}{\linespread{1.655}}
\@doublespacing
\RequirePackage{fancyhdr}
\setlength{\headheight}{15.2pt}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\rhead{\thepage}
\fancypagestyle{titlepage}{\lhead{Running head: \MakeUppercase{\@shorttitle}}}
\fancypagestyle{otherpage}{\lhead{\MakeUppercase{\@shorttitle}}}
\pagestyle{otherpage}
\newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}
\renewcommand{\title}[1]{\def\@title{#1}}
\renewcommand{\author}[1]{\def\@author{#1}}
\newcommand{\authornote}[1]{\def\@authornote{#1}}
\renewcommand{\abstract}[1]{\def\@abstract{#1}}
\renewcommand{\maketitle}{%
\thispagestyle{titlepage}%
\vspace*{1in}%
\Centering\@title\\\@author%
\vfill%
\ifdefined%
  \apaSIXe@leavefloats%
  {\large\textbf{\textit{A helpful reminder, courtesy \texttt{apa6e.cls}:} Figures and tables are currently mixed in with
      your text for easier reading. Don't forget to remove the
      \texttt{leavefloats} option before you submit!}\vfill}%
\fi
Author Note\par\RaggedRight\@authornote%
\mspart{Abstract}%
\@abstract%
\mspart{\@title}}
\AtBeginDocument{\def\st@rtbibsection{\mspart{References}}}
\RequirePackage{float}
\floatstyle{plaintop}
\restylefloat{table}
\floatstyle{plain} % This puts captions below the figure
\restylefloat{figure}
\RequirePackage[singlelinecheck=off,justification=RaggedRight]{caption}
\DeclareCaptionLabelFormat{tablelabel}{\hspace{-\RaggedRightParindent}#1 #2}
\DeclareCaptionLabelFormat{figurelabel}{\hspace{-\RaggedRightParindent}\textit{#1 #2}}
\DeclareCaptionTextFormat{tabletext}{\hspace{-\RaggedRightParindent}\textit{#1}}
\captionsetup[table]{position=above,labelformat=tablelabel,labelsep=newline,
                     textformat=tabletext}
\captionsetup[figure]{position=below,labelformat=figurelabel}
\setcounter{secnumdepth}{0}
\renewcommand{\section}{\@startsection {section}{1}{\z@}%
    {0.2\baselineskip \@plus 0.2ex \@minus 0.2ex}%
    {0.2\baselineskip \@plus .2ex}%
    {\Centering\normalfont\normalsize\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
    {0.2\baselineskip \@plus 0.2ex \@minus 0.2ex}%
    {0.2\baselineskip \@plus 0.2ex}%
    {\normalfont\normalsize\bfseries}}
\renewcommand{\subsubsection}[1]{\@startsection{subsubsection}{3}{\parindent}%
    {0\baselineskip \@plus 0.2ex \@minus 0.2ex}%
    {-\z@}%
    {\normalfont\normalsize\bfseries}{#1}\textbf{.}\hspace{0.2em}}
\renewcommand{\paragraph}[1]{\@startsection{paragraph}{4}{\parindent}%
    {0\baselineskip \@plus 0.2ex \@minus 0.2ex}%
    {-\z@}%
    {\normalfont\normalsize\bfseries\itshape}{#1}\textbf{\textit{.}}\hspace{0.2em}}
\renewcommand{\subparagraph}[1]{\@startsection{subparagraph}{5}{\parindent}%
    {0\baselineskip \@plus 0.2ex \@minus 0.2ex}%
    {-\z@}%
    {\normalfont\normalsize\itshape}{#1}\textit{.}\hspace{0.2em}}
\newcommand{\mspart}{\newpage\@startsection {section}{1}{\z@}%
    {-0.2\baselineskip \@plus -0.2ex \@minus -0.2ex}%
    {0.2\baselineskip \@plus .2ex}%
    {\Centering\normalfont\normalsize}}
\RequirePackage{ifthen}
\renewcommand{\appendix}{\setcounter{section}{0}
    \renewcommand{\section}[1]{\addtocounter{section}{1}
        \ifthenelse{\equal{\value{section}}{2}}
            {\label{apaSIXe@has@multiple@appendices}}
            {}
        \apaSIXe@appendixfloats@setup{\Alph{section}}
        \def\@currentlabel{\Alph{section}}
        \ifdefined\r@apaSIXe@has@multiple@appendices
          \mspart{Appendix \Alph{section}}
        \else
          \mspart{Appendix}
        \fi}}
\newcommand{\apaSIXe@appendixfloats@figureson}[1]{%
    \setcounter{figure}{0}%
    \renewcommand{\thefigure}{#1\arabic{figure}}}
\newcommand{\apaSIXe@appendixfloats@tableson}[1]{%
    \setcounter{table}{0}%
    \renewcommand{\thetable}{#1\arabic{table}}}
\ifdefined\apaSIXe@endnotes
    \RequirePackage{endnotes}
    \renewcommand{\enoteheading}{\mspart{Footnotes}}
    \def\enotesize{\normalsize}
    \renewcommand{\footnote}[1]{\def\apaSIXe@hasendnotes\relax{}\endnote{#1}}
    \AtEndDocument{\ifdefined \apaSIXe@hasendnotes \theendnotes \fi}
\fi
\ifdefined\apaSIXe@leavefloats
    \newcommand{\apaSIXe@appendixfloats@setup}[1]{%
      \apaSIXe@appendixfloats@tableson{#1}%
      \apaSIXe@appendixfloats@figureson{#1}%
    }
\else
    \ifdefined\apaSIXe@floatmarkers
        \relax
    \else
        \PassOptionsToPackage{nomarkers}{endfloat}
    \fi
    \RequirePackage[nolists,noheads,tablesfirst]{endfloat}
    \AtBeginDelayedFloats{\@doublespacing}
    \newcommand{\apaSIXe@appendixfloats@setup}[1]{%
        \setcounter{postfig}{0}%
        \renewcommand{\thepostfig}{#1\arabic{postfig}}%
        \setcounter{posttbl}{0}%
        \renewcommand{\theposttbl}{#1\arabic{posttbl}}%
        \efloat@iwrite{fff}{%
            \string\makeatletter\string\apaSIXe@appendixfloats@figureson{#1}\string\makeatother}%
        \efloat@iwrite{ttt}{%
            \string\makeatletter\string\apaSIXe@appendixfloats@tableson{#1}\string\makeatother}}
\fi
\endinput
%%
%% End of file `apa6e.cls'.
