%% This is file `sugconf.cls' for SAS(R) User Group conference papers
%% RJF2 2003-Jul-14 A Guide to LaTeX  by Kopka and Daly
%% RJF2 2003-Jul-14 The LaTeX Companion 2e, by Goossens and Mittelbach
%% RJF2 2004-Feb-27 polishing for SUGI29 template
%% RJF2 2004-Aug-05 added SASisRegisteredTrademark paragraph
%% RJF2 2006-Apr-22 added TextWidth, TextWsmall
%% RJF2 2006-Aug-05 polishing for submission to CTAN
%% License type: Free, LaTeX project public license
%%               http://www.latex-project.org/lppl/
%%
%% usage: see sugconf-example.tex
%% \documentclass{sugconf}
%% %\documentclass[nopagenumbers]{sugconf}
%% \pdfoutput=0%out=jobname.dvi
%% \pdfoutput=1%out=jobname.pdf
%% \sugconfpapernumber{Paper 999-99}%
%% \sugconfsubject{writing paper using sugconf class}%
%% %\sugconfpapernumber{\relax}%note: no paper number: warning in log
%% \sugconfkeywords{word1 word2}
%%
%% see also SUGpaper.tex in the SAS-L archives of Tue, 13 Jan 2004
%% http://www.listserv.uga.edu/cgi-bin/wa?A2=ind0401B&L=sas-l&P=R20636

\NeedsTeXFormat{LaTeX2e}
\pagestyle{plain}%see boolean PageNumbers

\usepackage{ifthen%for newboolean PageNumbers
           }%end usepackage

\newboolean{PageNumbers}%%K&D pg 203
\setboolean{PageNumbers}{true}
\let\SUGconfSubject\relax%
\newcommand{\sugconfsubject}[1]{\def\SUGconfSubject{#1}}
\let\SUGconfKeywords\relax%
\newcommand{\sugconfkeywords}[1]{\def\SUGconfKeywords{#1}}
\let\@papernumber\relax%
\newcommand{\sugconfpapernumber}[1]{\def\@papernumber{#1}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{nopagenumbers}{\setboolean{PageNumbers}{false}%
                                  \pagestyle{empty}}%
\ProcessOptions
\LoadClass[10pt]{article}
\AtBeginDocument{\maketitle%
        \ifthenelse{\boolean{PageNumbers}}%%K&D pg 335
                   {\relax}%
                   %LaTeX Companion pg 92: maketitle -> #1
                   {\thispagestyle{empty}}%no page number#1
        \if\@papernumber\relax%
            \@latex@warning{sugconf: You need to specify
                        a paper identifier
                        using the 'papernumber' macro in the preamble.}
            \fi%
                }%end AtBeginDocument
%\AtEndDocument{%\label{LastPage}%
%              }%end AtEndDocument

%\fontencoding{OT1}%default
%\fontencoding{T1}
%                              %LaTeX2e font selection fntguide.html
%\renewcommand{\rmdefault}{pag}%Adobe Avantgar  san-serif
%\renewcommand{\rmdefault}{pbk}%Adobe Bookman       serif
%\renewcommand{\rmdefault}{pbk}%Adobe Courier   san-serif
\renewcommand{\rmdefault}{phv}%Adobe Helvetica san-serif
%\renewcommand{\rmdefault}{pnc}%Adobe Ncntrsbk       serif
%\renewcommand{\rmdefault}{ppl}%Adobe Palatino      serif
%\renewcommand{\rmdefault}{put}%Adobe Utopia        serif
%\renewcommand{\rmdefault}{ptm}%Adobe Times         serif
\renewcommand{\sfdefault}{phv}%Helvetica
\renewcommand{\ttdefault}{pcr}%Courier          monospace

\newcommand{\SASregistered}%
           {SAS\textsuperscript{\scriptsize\textregistered}\ }
\newcommand{\SASisRegisteredTrademark}%
           {SAS and all other SAS Institute Inc. product or service %
            names are registered trademarks or trademarks of %
            SAS Institute Inc. in the USA and other countries. %®
            \textregistered\/ indicates USA registration.}
\newcommand{\OtherTrademarks}%
           {Other brand and product names are trademarks
            of their respective companies.}%

\newlength {\TextWidth}%
\settowidth{\TextWidth}%72 chars per line is between 1.5 and 2* alphabet
{ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQ}%RSTUVWXYZ}
%. . . . . . . . . . . . . 12345678901234567890123456
%. . . . . . . . . . . . . 1.0  1.25   1.5   1.75   2.0
% letter Q : 17/26=1.65
%
\renewcommand{\refname}{\flushleft\normalsize\bfseries REFERENCES}
%% acmconf.cls: places floats where they should go; per R Pursifull
\renewcommand{\bottomfraction}{1} \setcounter{topnumber}   {10}
\renewcommand{\textfraction}  {0} \setcounter{bottomnumber}{10}
%
\setcounter{secnumdepth}{-1}%turn off numbering of headings
%
\setlength{\hoffset}       {-0.375in} \setlength{\voffset}     {-0.25in}
\setlength{\textwidth}     {7.0in}    \setlength{\textheight}   {9.25in}
%
\setlength{\headheight}    {0pt}      \setlength{\headsep}      {0pt}
\setlength{\topskip   }    {0pt}      \setlength{\topmargin}    {0pt}
\setlength{\evensidemargin}{0pt}      \setlength{\oddsidemargin}{0pt}
\setlength{\columnsep}     {0.5in} %space between two columns
\setlength{\columnseprule} {0pt}   %width vertical rule between columns
\setlength{\parindent}     {0pt}   %paragraph indent
\setlength{\parskip}       {1.0ex plus 0.125ex minus 0.125ex}
%\setlength{\parskip}       {0.1\baselineskip}
%
\newlength{\runInHead}%LaTeX Comp, pg 27
\setlength{\runInHead}{- \fontdimen2\font plus  \fontdimen3\font
                                          minus \fontdimen4\font}
\newlength  {\TextWsmall}%
\setlength  {\TextWsmall}{\textwidth}
\addtolength{\TextWsmall}{-\TextWidth}
%\addtolength{\TextWsmall}{-\columnsep}
\addtolength{\TextWsmall}{-1.618em}
%% build title
\def\@maketitle{%
   \begin{center}%
      \if\@papernumber\relax\else%
      \fontsize{10}{18}\selectfont{\bf\@papernumber\\}\medskip
      \fi%
      \fontsize{14}{18}\selectfont{\bf\@title      \\}
      \fontsize{12}{14}\selectfont{   \@author       }
   \end{center}%
}%end maketitle

%% Guide to LaTeX  pg 348 C.3.3 Reprogramming the sectioning commands
%% LaTeX Companion pg  24 2.3.2 Formatting Headings
\renewcommand{\section}{\@startsection
              {section}%                        %name
              {1}%                              %level
              {0pt}%                            %indent
              {\baselineskip}%                  %beforeskip
              {0.125\baselineskip}%             %afterskip
              {\large\bfseries\uppercase}%      %style
             }%end section definition
\renewcommand{\subsection}{\@startsection
              {subsection}{2}{0pt}{0.5\baselineskip}{1sp}%
              {\normalsize\bfseries\uppercase}%
             }%end section definition
\renewcommand{\subsubsection}{\@startsection
              {subsubsection}{3}{0pt}{0.5\baselineskip}{\runInHead}%
              {\bfseries}%
             }%end section definition
\renewcommand{\paragraph}{\@startsection
              {paragraph}{4}{0pt}{0.5\baselineskip}{\runInHead}%
              {\bfseries}%
             }%end section definition
\renewcommand{\subparagraph}{\@startsection
              {subparagraph}{5}{0pt}{0.5\baselineskip}{\runInHead}%
              {\bfseries}%
             }%end section definition

\renewenvironment{abstract}{\section{ABSTRACT}}{}

\endinput %% SUGconf.cls
