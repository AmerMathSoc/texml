%%
%% This is file `bookcover.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ./bookcover.dtx  (with options: `class')
%% This is a generated file.
%% Copyright (C) 2015 Tibor Tomacs
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.2 of this license or (at your option) any later
%% version. The latest version of this license is in:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of
%% LaTeX version 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{bookcover}[2016/06/08 v1.1.1 class for book covers and dust jackets]
%%
%% OPTIONS
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=bookcover,prefix=bookcover@}
\DeclareVoidOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareVoidOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareVoidOption{12pt}{\PassOptionsToClass{12pt}{article}}
\DeclareVoidOption{grid}{\PassOptionsToPackage{grid}{eso-pic}}
\DeclareStringOption[170mm]{coverwidth}
\DeclareStringOption[240mm]{coverheight}
\DeclareStringOption[5mm]{spinewidth}
\DeclareStringOption[0mm]{flapwidth}
\DeclareStringOption[10mm]{marklength}
\DeclareStringOption[.4pt]{markthick}
\DeclareStringOption[5mm]{bleedwidth}
\DeclareStringOption[red]{markcolor}
\DeclareBoolOption[false]{trimmed}
\DeclareBoolOption[false]{bgtikznodes}
\DeclareBoolOption[false]{bgtikzclip}
\ProcessKeyvalOptions{bookcover}

%% LOADING CLASS AND PACKAGES
\LoadClass{article}
\RequirePackage{geometry,graphicx,calc,xcolor,ifthen,tikz,eso-pic}
\RequirePackage[absolute]{textpos}

%% PAGE STYLE IS EMPTY
\pagestyle{empty}

%% USER LENGTHS
\newlength{\coverwidth}
\newlength{\coverheight}
\newlength{\spinewidth}
\newlength{\flapwidth}
\newlength{\marklength}
\newlength{\markthick}
\newlength{\bleedwidth}

%% INTERNAL LENGTHS
\newlength{\bookcover@xpos@}
\newlength{\bookcover@ypos@}
\newlength{\bookcover@partwidth@}
\newlength{\bookcover@partheight@}
\newlength{\bookcover@bgtikz@trimmed@part@width@minus}
\newlength{\bookcover@bgtikz@trimmed@part@push@right}

%% USER LENGTHS SETTING
\setlength{\coverwidth}{\bookcover@coverwidth}
\setlength{\coverheight}{\bookcover@coverheight}
\setlength{\spinewidth}{\bookcover@spinewidth}
\setlength{\flapwidth}{\bookcover@flapwidth}
\setlength{\marklength}{\bookcover@marklength}
\setlength{\markthick}{\bookcover@markthick}
\setlength{\bleedwidth}{\bookcover@bleedwidth}
\setlength{\paperwidth}{2\marklength+2\bleedwidth+2\coverwidth+2\flapwidth+\spinewidth}
\setlength{\paperheight}{2\marklength+2\bleedwidth+\coverheight}
\setlength{\parindent}{0pt}

%% GRID
\ifESO@grid
    \setlength{\markthick}{2pt}
    \def\bookcover@markcolor{red}\fi

%% COMMANDS FOR INTERNAL LENGTHS SETTING
\def\bookcover@xpos#1{\setlength{\bookcover@xpos@}{#1}}
\def\bookcover@ypos#1{\setlength{\bookcover@ypos@}{#1}}
\def\bookcover@partwidth#1{\setlength{\bookcover@partwidth@}{#1}}
\def\bookcover@partheight#1{\setlength{\bookcover@partheight@}{#1}}
\def\bookcover@bgtikz@trimmed@part@param#1#2{%
    \setlength{\bookcover@bgtikz@trimmed@part@width@minus}{#1}%
    \setlength{\bookcover@bgtikz@trimmed@part@push@right}{#2}}

%% MACROS FOR OUTPUTS OF PARTS
%% bgcolor
\def\bookcover@bgcolor#1{
    \begin{textblock*}{\bookcover@partwidth@}(\bookcover@xpos@,\bookcover@ypos@)
        \tikz\expandafter\fill#1 (0,0) rectangle (\bookcover@partwidth@,\bookcover@partheight@);
    \end{textblock*}}
%% bgpic
\def\bookcover@bgpic#1{
    \begin{textblock*}{\bookcover@partwidth@}(\bookcover@xpos@,\bookcover@ypos@)
        \includegraphics[width=\bookcover@partwidth@,height=\bookcover@partheight@]{#1}
    \end{textblock*}}
%% bgtikz
\def\bookcover@bgtikz#1{
    \begin{textblock*}{\bookcover@partwidth@}(\bookcover@xpos@,\bookcover@ypos@)
        \ifbookcover@bgtikzclip\bookcover@bgtikznodestrue\fi
        \ifbookcover@bgtikznodes
            \begin{tikzpicture}[overlay,yshift=-\bookcover@partheight@]
            \begin{scope}[transparent,line width=0pt]
                \pgfset{minimum width=\bookcover@partwidth@,minimum height=\bookcover@partheight@}
                \pgfnode{rectangle}{south west}{}{current part}{\pgfusepath{draw}}
                \pgfset{minimum width=\bookcover@partwidth@-\bookcover@bgtikz@trimmed@part@width@minus,
                        minimum height=\bookcover@partheight@-2\bleedwidth}
                \pgftransformshift{\pgfpoint{\bookcover@bgtikz@trimmed@part@push@right}{\bleedwidth}}
                \pgfnode{rectangle}{south west}{}{current trimmed part}{\pgfusepath{draw}}
            \end{scope}
            \ifbookcover@bgtikzclip
                \clip (current part.south west) rectangle (current part.north east);\fi
        \else\begin{tikzpicture}\fi
            #1
        \end{tikzpicture}
    \end{textblock*}}
%% fg
\def\bookcover@fg#1{
    \begin{textblock*}{\bookcover@partwidth@}(\bookcover@xpos@,\bookcover@ypos@)
        \parbox[t][\bookcover@partheight@][t]{\bookcover@partwidth@}{#1}
    \end{textblock*}}
%% remark
\def\bookcover@remark#1{
    \begin{textblock*}{\bookcover@partwidth@}(\bookcover@xpos@,\bookcover@ypos@)
        \parbox[t][\bookcover@partheight@][c]{\bookcover@partwidth@}
            {\centering#1\par}
    \end{textblock*}}

%% MACROS FOR MARKS
%% vertical mark
\def\bookcover@vmark{
    \begin{textblock*}{\bookcover@partwidth@}(\bookcover@xpos@,\bookcover@ypos@)
        {\color{\bookcover@markcolor}\rule[0pt]{\markthick}{\marklength}}
    \end{textblock*}}
%% horizontal mark
\def\bookcover@hmark{
    \begin{textblock*}{\bookcover@partwidth@}(\bookcover@xpos@,\bookcover@ypos@)
        {\color{\bookcover@markcolor}\rule[0pt]{\marklength}{\markthick}}
    \end{textblock*}}

%% MACRO FOR TRIMMING
\def\bookcover@trimming{
    \begin{textblock*}{\paperwidth}(0mm,0mm)
        \begin{tikzpicture}
            \begin{scope}[color=white]
                \fill(0,0)--
                     (\paperwidth,0)--
                     (\paperwidth,\marklength+\bleedwidth)--
                     (0,\marklength+\bleedwidth)--cycle;
                \fill(0,\paperheight)--
                     (\paperwidth,\paperheight)--
                     (\paperwidth,\paperheight-\marklength-\bleedwidth)--
                     (0,\paperheight-\marklength-\bleedwidth)--cycle;
                \fill(0,0)--
                     (\marklength+\bleedwidth,0)--
                     (\marklength+\bleedwidth,\paperheight)--
                     (0,\paperheight)--cycle;
                \fill(\paperwidth-\marklength-\bleedwidth,0)--
                     (\paperwidth,0)--
                     (\paperwidth,\paperheight)--
                     (\paperwidth-\marklength-\bleedwidth,\paperheight)--cycle;
            \end{scope}
            \draw[color=\bookcover@markcolor,line width=\markthick]
                 (\marklength+\bleedwidth,\marklength+\bleedwidth)--
                 (\paperwidth-\marklength-\bleedwidth,\marklength+\bleedwidth)--
                 (\paperwidth-\marklength-\bleedwidth,\paperheight-\marklength-\bleedwidth)--
                 (\marklength+\bleedwidth,\paperheight-\marklength-\bleedwidth)--cycle;
        \end{tikzpicture}
    \end{textblock*}
    \bookcover@ypos{\bleedwidth}
    \bookcover@partwidth{\markthick}
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth-.5\markthick}
        \bookcover@vmark
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth-.5\markthick}
        \bookcover@vmark\fi
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth-.5\markthick}
    \bookcover@vmark
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth-.5\markthick}
    \bookcover@vmark
    \bookcover@ypos{\paperheight-\marklength-\bleedwidth}
    \bookcover@partwidth{\markthick}
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth-.5\markthick}
        \bookcover@vmark
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth-.5\markthick}
        \bookcover@vmark\fi
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth-.5\markthick}
    \bookcover@vmark
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth-.5\markthick}
    \bookcover@vmark}

%% RESET DATAS
\def\bookcover@reset{
    \def\bookcover@bgcolor@whole{}
    \def\bookcover@bgcolor@wholewf{}
    \def\bookcover@bgcolor@back{}
    \def\bookcover@bgcolor@front{}
    \def\bookcover@bgcolor@backflap{}
    \def\bookcover@bgcolor@frontflap{}
    \def\bookcover@bgcolor@spine{}
    \def\bookcover@bgpic@whole{}
    \def\bookcover@bgpic@wholewf{}
    \def\bookcover@bgpic@back{}
    \def\bookcover@bgpic@front{}
    \def\bookcover@bgpic@backflap{}
    \def\bookcover@bgpic@frontflap{}
    \def\bookcover@bgpic@spine{}
    \def\bookcover@bgtikz@whole{}
    \def\bookcover@bgtikz@wholewf{}
    \def\bookcover@bgtikz@back{}
    \def\bookcover@bgtikz@front{}
    \def\bookcover@bgtikz@backflap{}
    \def\bookcover@bgtikz@frontflap{}
    \def\bookcover@bgtikz@spine{}
    \def\bookcover@fgfirst@back{}
    \def\bookcover@fgfirst@front{}
    \def\bookcover@fgfirst@spine{}
    \def\bookcover@fgfirst@backflap{}
    \def\bookcover@fgfirst@frontflap{}
    \def\bookcover@fgfirst@abovefront{}
    \def\bookcover@fgfirst@belowfront{}
    \def\bookcover@fgfirst@aboveback{}
    \def\bookcover@fgfirst@belowback{}
    \def\bookcover@fgsecond@back{}
    \def\bookcover@fgsecond@front{}
    \def\bookcover@fgsecond@spine{}
    \def\bookcover@fgsecond@backflap{}
    \def\bookcover@fgsecond@frontflap{}}
\bookcover@reset

%% SETBOOKCOVER
\long\def\setbookcover#1#2#3{
    \ifthenelse{\equal{#1}{bgcolor}}{
        \ifthenelse{\equal{#2}{whole}}{\def\bookcover@bgcolor@whole{[#3]}}{}
        \ifthenelse{\equal{#2}{whole without flaps}}{\def\bookcover@bgcolor@wholewf{[#3]}}{}
        \ifthenelse{\equal{#2}{back}}{\def\bookcover@bgcolor@back{[#3]}}{}
        \ifthenelse{\equal{#2}{front}}{\def\bookcover@bgcolor@front{[#3]}}{}
        \ifthenelse{\equal{#2}{back flap}}{\def\bookcover@bgcolor@backflap{[#3]}}{}
        \ifthenelse{\equal{#2}{front flap}}{\def\bookcover@bgcolor@frontflap{[#3]}}{}
        \ifthenelse{\equal{#2}{spine}}{\def\bookcover@bgcolor@spine{[#3]}}{}}{}
    \ifthenelse{\equal{#1}{bgpic}}{
        \ifthenelse{\equal{#2}{whole}}{\def\bookcover@bgpic@whole{#3}}{}
        \ifthenelse{\equal{#2}{whole without flaps}}{\def\bookcover@bgpic@wholewf{#3}}{}
        \ifthenelse{\equal{#2}{back}}{\def\bookcover@bgpic@back{#3}}{}
        \ifthenelse{\equal{#2}{front}}{\def\bookcover@bgpic@front{#3}}{}
        \ifthenelse{\equal{#2}{back flap}}{\def\bookcover@bgpic@backflap{#3}}{}
        \ifthenelse{\equal{#2}{front flap}}{\def\bookcover@bgpic@frontflap{#3}}{}
        \ifthenelse{\equal{#2}{spine}}{\def\bookcover@bgpic@spine{#3}}{}}{}
    \ifthenelse{\equal{#1}{bgtikz}}{
        \ifthenelse{\equal{#2}{whole}}{\def\bookcover@bgtikz@whole{#3}}{}
        \ifthenelse{\equal{#2}{whole without flaps}}{\def\bookcover@bgtikz@wholewf{#3}}{}
        \ifthenelse{\equal{#2}{back}}{\def\bookcover@bgtikz@back{#3}}{}
        \ifthenelse{\equal{#2}{front}}{\def\bookcover@bgtikz@front{#3}}{}
        \ifthenelse{\equal{#2}{back flap}}{\def\bookcover@bgtikz@backflap{#3}}{}
        \ifthenelse{\equal{#2}{front flap}}{\def\bookcover@bgtikz@frontflap{#3}}{}
        \ifthenelse{\equal{#2}{spine}}{\def\bookcover@bgtikz@spine{#3}}{}}{}
    \ifthenelse{\equal{#1}{fgfirst}}{
        \ifthenelse{\equal{#2}{back}}{\def\bookcover@fgfirst@back{#3}}{}
        \ifthenelse{\equal{#2}{front}}{\def\bookcover@fgfirst@front{#3}}{}
        \ifthenelse{\equal{#2}{spine}}{\def\bookcover@fgfirst@spine{#3}}{}
        \ifthenelse{\equal{#2}{back flap}}{\def\bookcover@fgfirst@backflap{#3}}{}
        \ifthenelse{\equal{#2}{front flap}}{\def\bookcover@fgfirst@frontflap{#3}}{}
        \ifthenelse{\equal{#2}{remark}}{\def\bookcover@fgfirst@abovefront{#3}}{}% for version 1.0
        \ifthenelse{\equal{#2}{above front}}{\def\bookcover@fgfirst@abovefront{#3}}{}
        \ifthenelse{\equal{#2}{below front}}{\def\bookcover@fgfirst@belowfront{#3}}{}
        \ifthenelse{\equal{#2}{above back}}{\def\bookcover@fgfirst@aboveback{#3}}{}
        \ifthenelse{\equal{#2}{below back}}{\def\bookcover@fgfirst@belowback{#3}}{}}{}
    \ifthenelse{\equal{#1}{fgsecond}}{
        \ifthenelse{\equal{#2}{back}}{\def\bookcover@fgsecond@back{#3}}{}
        \ifthenelse{\equal{#2}{front}}{\def\bookcover@fgsecond@front{#3}}{}
        \ifthenelse{\equal{#2}{spine}}{\def\bookcover@fgsecond@spine{#3}}{}
        \ifthenelse{\equal{#2}{back flap}}{\def\bookcover@fgsecond@backflap{#3}}{}
        \ifthenelse{\equal{#2}{front flap}}{\def\bookcover@fgsecond@frontflap{#3}}{}}{}}

%% MAKEBOOKCOVER
\def\makebookcover{
%% background parameters
\bookcover@ypos{\marklength}
\bookcover@partheight{\coverheight+2\bleedwidth}
%% {bgcolor}{whole}
\ifx\bookcover@bgcolor@whole\@empty\else
    \bookcover@xpos{\marklength}
    \bookcover@partwidth{2\coverwidth+2\bleedwidth+2\flapwidth+\spinewidth}
    \bookcover@bgcolor{\bookcover@bgcolor@whole}\fi
%% {bgcolor}{whole without flaps}
\ifx\bookcover@bgcolor@wholewf\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
        \bookcover@partwidth{2\coverwidth+\spinewidth}
    \else
        \bookcover@xpos{\marklength}
        \bookcover@partwidth{2\coverwidth+2\bleedwidth+\spinewidth}\fi
    \bookcover@bgcolor{\bookcover@bgcolor@wholewf}\fi
%% {bgcolor}{back flap}
\ifx\bookcover@bgcolor@backflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength}
    \bookcover@partwidth{\flapwidth+\bleedwidth}
    \bookcover@bgcolor{\bookcover@bgcolor@backflap}\fi\fi
%% {bgcolor}{back}
\ifx\bookcover@bgcolor@back\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
        \bookcover@partwidth{\coverwidth}
    \else
        \bookcover@xpos{\marklength}
        \bookcover@partwidth{\coverwidth+\bleedwidth}\fi
    \bookcover@bgcolor{\bookcover@bgcolor@back}\fi
%% {bgcolor}{spine}
\ifx\bookcover@bgcolor@spine\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth}
    \bookcover@partwidth{\spinewidth}
    \bookcover@bgcolor{\bookcover@bgcolor@spine}\fi
%% {bgcolor}{front}
\ifx\bookcover@bgcolor@front\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth}
        \bookcover@partwidth{\coverwidth}
    \else
        \bookcover@xpos{\marklength+\bleedwidth+\coverwidth+\spinewidth}
        \bookcover@partwidth{\coverwidth+\bleedwidth}\fi
    \bookcover@bgcolor{\bookcover@bgcolor@front}\fi
%% {bgcolor}{front flap}
\ifx\bookcover@bgcolor@frontflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth}
    \bookcover@partwidth{\flapwidth+\bleedwidth}
    \bookcover@bgcolor{\bookcover@bgcolor@frontflap}\fi\fi
%% {bgpic}{whole}
\ifx\bookcover@bgpic@whole\@empty\else
    \bookcover@xpos{\marklength}
    \bookcover@partwidth{2\coverwidth+2\bleedwidth+2\flapwidth+\spinewidth}
    \bookcover@bgpic{\bookcover@bgpic@whole}\fi
%% {bgpic}{whole without flaps}
\ifx\bookcover@bgpic@wholewf\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
        \bookcover@partwidth{2\coverwidth+\spinewidth}
    \else
        \bookcover@xpos{\marklength}
        \bookcover@partwidth{2\coverwidth+2\bleedwidth+\spinewidth}\fi
    \bookcover@bgpic{\bookcover@bgpic@wholewf}\fi
%% {bgpic}{back flap}
\ifx\bookcover@bgpic@backflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength}
    \bookcover@partwidth{\flapwidth+\bleedwidth}
    \bookcover@bgpic{\bookcover@bgpic@backflap}\fi\fi
%% {bgpic}{back}
\ifx\bookcover@bgpic@back\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
        \bookcover@partwidth{\coverwidth}
    \else
        \bookcover@xpos{\marklength}
        \bookcover@partwidth{\coverwidth+\bleedwidth}\fi
    \bookcover@bgpic{\bookcover@bgpic@back}\fi
%% {bgpic}{spine}
\ifx\bookcover@bgpic@spine\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth}
    \bookcover@partwidth{\spinewidth}
    \bookcover@bgpic{\bookcover@bgpic@spine}\fi
%% {bgpic}{front}
\ifx\bookcover@bgpic@front\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth}
        \bookcover@partwidth{\coverwidth}
    \else
        \bookcover@xpos{\marklength+\bleedwidth+\coverwidth+\spinewidth}
        \bookcover@partwidth{\coverwidth+\bleedwidth}\fi
    \bookcover@bgpic{\bookcover@bgpic@front}\fi
%% {bgpic}{front flap}
\ifx\bookcover@bgpic@frontflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth}
    \bookcover@partwidth{\flapwidth+\bleedwidth}
    \bookcover@bgpic{\bookcover@bgpic@frontflap}\fi\fi
%% {bgtikz}{whole}
\ifx\bookcover@bgtikz@whole\@empty\else
    \bookcover@xpos{\marklength}
    \bookcover@partwidth{2\coverwidth+2\bleedwidth+2\flapwidth+\spinewidth}
    \bookcover@bgtikz@trimmed@part@param{2\bleedwidth}{\bleedwidth}
    \bookcover@bgtikz{\bookcover@bgtikz@whole}\fi
%% {bgtikz}{whole without flaps}
\ifx\bookcover@bgtikz@wholewf\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
        \bookcover@partwidth{2\coverwidth+\spinewidth}
        \bookcover@bgtikz@trimmed@part@param{0pt}{0pt}
    \else
        \bookcover@xpos{\marklength}
        \bookcover@partwidth{2\coverwidth+2\bleedwidth+\spinewidth}
        \bookcover@bgtikz@trimmed@part@param{2\bleedwidth}{\bleedwidth}\fi
    \bookcover@bgtikz{\bookcover@bgtikz@wholewf}\fi
%% {bgtikz}{back flap}
\ifx\bookcover@bgtikz@backflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength}
    \bookcover@partwidth{\flapwidth+\bleedwidth}
    \bookcover@bgtikz@trimmed@part@param{\bleedwidth}{\bleedwidth}
    \bookcover@bgtikz{\bookcover@bgtikz@backflap}\fi\fi
%% {bgtikz}{back}
\ifx\bookcover@bgtikz@back\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
        \bookcover@partwidth{\coverwidth}
        \bookcover@bgtikz@trimmed@part@param{0pt}{0pt}
    \else
        \bookcover@xpos{\marklength}
        \bookcover@partwidth{\coverwidth+\bleedwidth}
        \bookcover@bgtikz@trimmed@part@param{\bleedwidth}{\bleedwidth}\fi
    \bookcover@bgtikz{\bookcover@bgtikz@back}\fi
%% {bgtikz}{spine}
\ifx\bookcover@bgtikz@spine\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth}
    \bookcover@partwidth{\spinewidth}
    \bookcover@bgtikz@trimmed@part@param{0pt}{0pt}
    \bookcover@bgtikz{\bookcover@bgtikz@spine}\fi
%% {bgtikz}{front}
\ifx\bookcover@bgtikz@front\@empty\else
    \ifdim\flapwidth>0mm
        \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth}
        \bookcover@partwidth{\coverwidth}
        \bookcover@bgtikz@trimmed@part@param{0pt}{0pt}
    \else
        \bookcover@xpos{\marklength+\bleedwidth+\coverwidth+\spinewidth}
        \bookcover@partwidth{\coverwidth+\bleedwidth}
        \bookcover@bgtikz@trimmed@part@param{\bleedwidth}{0pt}\fi
    \bookcover@bgtikz{\bookcover@bgtikz@front}\fi
%% {bgtikz}{front flap}
\ifx\bookcover@bgtikz@frontflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth}
    \bookcover@partwidth{\flapwidth+\bleedwidth}
    \bookcover@bgtikz@trimmed@part@param{\bleedwidth}{0pt}
    \bookcover@bgtikz{\bookcover@bgtikz@frontflap}\fi\fi
%% foreground parameters
\bookcover@ypos{\marklength+\bleedwidth}
\bookcover@partheight{\coverheight}
%% {fgsecond}{back flap}
\ifx\bookcover@fgsecond@backflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth}
    \bookcover@partwidth{\flapwidth}
    \bookcover@fg{\bookcover@fgsecond@backflap}\fi\fi
%% {fgsecond}{back}
\ifx\bookcover@fgsecond@back\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
    \bookcover@partwidth{\coverwidth}
    \bookcover@fg{\bookcover@fgsecond@back}\fi
%% {fgsecond}{spine}
\ifx\bookcover@fgsecond@spine\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth}
    \bookcover@partwidth{\spinewidth}
    \bookcover@fg{\bookcover@fgsecond@spine}\fi
%% {fgsecond}{front}
\ifx\bookcover@fgsecond@front\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth}
    \bookcover@partwidth{\coverwidth}
    \bookcover@fg{\bookcover@fgsecond@front}\fi
%% {fgsecond}{front flap}
\ifx\bookcover@fgsecond@frontflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth}
    \bookcover@partwidth{\flapwidth}
    \bookcover@fg{\bookcover@fgsecond@frontflap}\fi\fi
%% {fgfirst}{back flap}
\ifx\bookcover@fgfirst@backflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth}
    \bookcover@partwidth{\flapwidth}
    \bookcover@fg{\bookcover@fgfirst@backflap}\fi\fi
%% {fgfirst}{back}
\ifx\bookcover@fgfirst@back\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
    \bookcover@partwidth{\coverwidth}
    \bookcover@fg{\bookcover@fgfirst@back}\fi
%% {fgfirst}{spine}
\ifx\bookcover@fgfirst@spine\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth}
    \bookcover@partwidth{\spinewidth}
    \bookcover@fg{\bookcover@fgfirst@spine}\fi
%% {fgfirst}{front}
\ifx\bookcover@fgfirst@front\@empty\else
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth}
    \bookcover@partwidth{\coverwidth}
    \bookcover@fg{\bookcover@fgfirst@front}\fi
%% {fgfirst}{front flap}
\ifx\bookcover@fgfirst@frontflap\@empty\else\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth}
    \bookcover@partwidth{\flapwidth}
    \bookcover@fg{\bookcover@fgfirst@frontflap}\fi\fi
%% {fgfirst}{above front} = {fgfirst}{remark} in version 1.0
\ifx\bookcover@fgfirst@abovefront\@empty\else\ifdim\marklength>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth}
    \bookcover@ypos{0mm}
    \bookcover@partwidth{\coverwidth}
    \bookcover@partheight{\marklength}
    \bookcover@remark{\bookcover@fgfirst@abovefront}\fi\fi
%% {fgfirst}{below front}
\ifx\bookcover@fgfirst@belowfront\@empty\else\ifdim\marklength>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth}
    \bookcover@ypos{\marklength+2\bleedwidth+\coverheight}
    \bookcover@partwidth{\coverwidth}
    \bookcover@partheight{\marklength}
    \bookcover@remark{\bookcover@fgfirst@belowfront}\fi\fi
%% {fgfirst}{above back}
\ifx\bookcover@fgfirst@aboveback\@empty\else\ifdim\marklength>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
    \bookcover@ypos{0mm}
    \bookcover@partwidth{\coverwidth}
    \bookcover@partheight{\marklength}
    \bookcover@remark{\bookcover@fgfirst@aboveback}\fi\fi
%% {fgfirst}{below back}
\ifx\bookcover@fgfirst@belowback\@empty\else\ifdim\marklength>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth}
    \bookcover@ypos{\marklength+2\bleedwidth+\coverheight}
    \bookcover@partwidth{\coverwidth}
    \bookcover@partheight{\marklength}
    \bookcover@remark{\bookcover@fgfirst@belowback}\fi\fi
%% mark top parameters
\bookcover@ypos{0mm}
\bookcover@partwidth{\markthick}
%% mark top 1
\bookcover@xpos{\marklength+\bleedwidth-.5\markthick}
\bookcover@vmark
%% mark top 2
\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth-.5\markthick}
    \bookcover@vmark\fi
%% mark top 3
\bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth-.5\markthick}
\bookcover@vmark
%% mark top 4
\bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth-.5\markthick}
\bookcover@vmark
%% mark top 5
\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth-.5\markthick}
    \bookcover@vmark\fi
%% mark top 6
\bookcover@xpos{\marklength+\bleedwidth+2\flapwidth+2\coverwidth+\spinewidth-.5\markthick}
\bookcover@vmark
%% mark bottom parameters
\bookcover@ypos{\paperheight-\marklength}
\bookcover@partwidth{\markthick}
%% mark bottom 1
\bookcover@xpos{\marklength+\bleedwidth-.5\markthick}
\bookcover@vmark
%% mark bottom 2
\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth-.5\markthick}
    \bookcover@vmark\fi
%% mark bottom 3
\bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth-.5\markthick}
\bookcover@vmark
%% mark bottom 4
\bookcover@xpos{\marklength+\bleedwidth+\flapwidth+\coverwidth+\spinewidth-.5\markthick}
\bookcover@vmark
%% mark bottom 5
\ifdim\flapwidth>0mm
    \bookcover@xpos{\marklength+\bleedwidth+\flapwidth+2\coverwidth+\spinewidth-.5\markthick}
    \bookcover@vmark\fi
%% mark bottom 6
\bookcover@xpos{\marklength+\bleedwidth+2\flapwidth+2\coverwidth+\spinewidth-.5\markthick}
\bookcover@vmark
%% mark left parameters
\bookcover@xpos{0mm}
\bookcover@partwidth{\marklength}
%% mark left 1
\bookcover@ypos{\marklength+\bleedwidth-.5\markthick}
\bookcover@hmark
%% mark left 2
\bookcover@ypos{\marklength+\bleedwidth+\coverheight-.5\markthick}
\bookcover@hmark
%% mark right parameters
\bookcover@xpos{\paperwidth-\marklength}
\bookcover@partwidth{\marklength}
%% mark right 1
\bookcover@ypos{\marklength+\bleedwidth-.5\markthick}
\bookcover@hmark
%% mark right 2
\bookcover@ypos{\marklength+\bleedwidth+\coverheight-.5\markthick}
\bookcover@hmark
%% trimming
\ifbookcover@trimmed
    \bookcover@trimming\fi
%% new book cover
\mbox{}
\newpage
\bookcover@reset}
\endinput
%%
%% End of file `bookcover.cls'.
