\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tools-overview}
  [2006/06/02 Overview for packages of latex/tools]
%
% Copyright 2006 Heiko Oberdiek
%
% This file is part of project `latex-tds'.
%
% It may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Heiko Oberdiek.
%
% See `README' for a list of all files belonging to the
% project `latex-tds' and additional information.
%
\nofiles
\LoadClass[a4paper,12pt]{article}

% page layout
\RequirePackage[
  ignoreall,
  hmargin=1in,
  vmargin={.75in,1in},
]{geometry}

\pagestyle{empty}

\RequirePackage{calc}[2005/08/06]

\RequirePackage{hyperref}
\hypersetup{
  colorlinks,
  filecolor=blue,
  pdftitle={LaTeX's Tools Bundle},
  pdfsubject={Overview},
  pdfauthor={Heiko Oberdiek},
  pdfcreator={Project `latex-tds'},
}
\title{Contents of \LaTeX's Tools Bundle}

\let\TO@document\document
\let\TO@enddocument\enddocument
\def\document{%
  \TO@document
  \maketitle
  \toks@={}%
  \setlength{\maxlen}{0pt}%
}
\newlength{\maxlen}
\def\enddocument{%
  \begin{list}{}{%
    \setlength{\leftmargin}{\maxlen + \labelsep}%
    \setlength{\labelwidth}{\maxlen}%
    \setlength{\partopsep}{0pt}%
  }%
    \the\toks@
  \end{list}%
  \TO@enddocument
}
\newcommand{\entry}[2]{%
  \outline{#1}%
  \toks@\expandafter{%
    \the\toks@
    \item[%
      \href{file:#1.pdf}{\printpackage{#1}}%
      \hfill
    ]%
    #2%
  }%
  \setlength{\maxlen}{%
    \maxof{\maxlen}{\widthof{\printpackage{#1}}}%
  }%
  \global\maxlen\maxlen
}
\newcommand*{\printpackage}[1]{%
  \textbf{\large #1:}%
}
\newcommand*{\outline}[1]{%
  \pdfoutline
    attr {/C[0 0 1]}
    user {%
      <<%
        /S/GoToR%
        /F(#1.pdf)%
        /NewWindow true%
        /D[0/XYZ null null null]%
      >>%
    }%
  {[#1]}\relax
}
\renewcommand*{\maketitle}{%
  \begingroup
    \par
    \centering
    \bfseries
    \LARGE
    \@title
    \par
  \endgroup
  \vspace{2em}%
}

\providecommand*{\cs}[1]{%
  \texttt{\textbackslash#1}%
}
\endinput
