%%
%% This is file `maatext.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% maatext.dtx 
%% This is a generated file.
%% 
%% Copyright 2018, 2019, 2022 American Mathematical Society.
%% 
%% American Mathematical Society
%% Technical Support
%% Publications Technical Group
%% 201 Charles Street
%% Providence, RI 02904
%% USA
%% tel: (401) 455-4080
%%      (800) 321-4267 (USA and Canada only)
%% fax: (401) 331-3842
%% email: tech-support@ams.org
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is the American Mathematical
%% Society.
%% 
%% ========================================================================
%% 
\NeedsTeXFormat{LaTeX2e}[2016/03/31]
\ProvidesClass{maatext}[2020/09/23 v1.04]
\RequirePackage{xcolor}
\def\maa@trimsize{7x10}
\DeclareOption{5.5x8.5}{%
    \ClassWarning{maatext}{%
        5.5x8.5 trim size is not supported. Using default size 7x10.
    }
}
\DeclareOption{6x9}{\def\maa@trimsize{6x9}}
\DeclareOption{7x10}{\def\maa@trimsize{7x10}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{maabook}}
\ProcessOptions\relax
\LoadClass[\maa@trimsize]{maabook}[2020/08/11]
\def\titlepage@series{Textbooks}
\definecolor{chaptergrey}{gray}{0.6}
\def\@makechapterhead#1{%
    \begingroup
        \null
        \vskip 21bp % Fudge factor
        \normalfont
        \sffamily
        \bfseries
        \fontsize{24}{27.5}%
        \selectfont
        \raggedleft
        \ifnum \c@secnumdepth >\m@ne
            \ifappendix
                \begingroup
                    \fontsize{18}{18}\selectfont
                    \color{chaptergrey}%
                    \appendixname\space
                \endgroup
            \fi
            \begingroup
                \normalfont
                \bfseries
                \fontsize{100}{100}\selectfont
                \color{chaptergrey}%
                \thechapter\par
            \endgroup
        \fi
        \bb@space 3.5 pc
        #1\par
    \endgroup
    \bb@space 4.5pc
}
\def\section{%
    \@startsection{section}%
        {1}%
        \z@
        {-3pc\@minus-0.6pc}%
        {.5pc}%
        {\normalfont\sffamily\bfseries\fontsize{16}{18pt}\selectfont}%
}
\endinput
%%
%% End of file `maatext.cls'.
