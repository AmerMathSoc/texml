% ----------------------------------------------------------
% -                                                        -
% -           Turabian LaTeX v0.1.0 [2015/02/16]           -
% -                  By Wesley A. Surber                   -
% -          Liberty Baptist Theological Seminary          -
% -                                                        -
% -                  Get the latest version                -
% -                 http://www.overleaf.com                -
% -                                                        -
% - NOTE: Some professors still require papers submitted   -
% - in Microsoft Word format.  Consult your grading rubric -
% - and professor's personal preference before utilizing   -
% - this tool.                                             -
% -                                                        -
% ----------------------------------------------------------

% This material is subject to the LATEX Project Public License.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{turabian}[2015/02/16 v0.1.0 Turabian LaTeX document class]
\renewcommand{\normalsize}{\fontsize{12}{12}\selectfont}
\LoadClass[a4paper,oneside,12pt]{report}
\usepackage{lipsum} % Provides options for creating the demo template.
\usepackage[hmargin=1in,vmargin=1in]{geometry} % Sets margins and page layout.
\usepackage{times} % Changes font to Times New Roman.
\usepackage{fancyhdr} % Enables header modifications for Turabian format.
\usepackage{setspace} % Enables double-spaced line support for Turabian format.
\usepackage{tocloft} % Enables Table of Contents customization for Turabian format.
\usepackage{cjhebrew} % Enables Hebrew support.  Refer to user guide for code sequence.
\usepackage{scrextend} % Enables footnote modification for Turabian format.
\usepackage{indentfirst} % Indents first paragraph line after section headers.
\usepackage[none]{hyphenat} % Prohibits LaTeX from hyphenating words.
\usepackage{titlesec} % Enables section header modifications.
\usepackage{graphicx} % Enables image support.
\usepackage[greek,english]{babel} % Enables Greek text support.

\batchmode % Enables TeXworks to continue LaTeX compiling on error.

\deffootnote[3em]{0em}{1em}{\thefootnotemark . }  % Enables Turabian formatted footnotes.

\titleformat{\section}
  {\normalfont\normalsize\bfseries\centering}{}{0em}{} % Custom Turabian section header.

\setlength{\headheight}{15pt} % Custom header height.  Avoids compiling errors.

\makeatletter
\renewcommand\lips@dolipsum{%
  \ifnum\value{lips@count}<\lips@max\relax
    \addtocounter{lips@count}{1}%
    \csname lipsum@\romannumeral\c@lips@count\endcsname
    \lips@dolipsum
  \fi
}
\makeatother

% ---- TABLE OF CONTENTS ----

\newcommand{\papercontents}{
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[R]{\thepage} % Aligns page number to right of header.  
    \renewcommand{\headrulewidth}{0pt}
    
    \section{Table of Contents}
    
    }  
    
% ---- MAIN CONTENT ----

\newcommand{\content}{
    \openup 1em
    \raggedright
    \parindent=1.5em
    }
    
% ---- BIBLIOGRAPHY ----
    
\renewcommand{\bibliography}{
    \section{Bibliography}
	\vspace{5mm}

    \openup -1em
    \vspace{-5mm}
    \parindent=0em
    }

\newcommand{\bibline}{
    \hangindent=1.5em
    \hangafter=1 
    }