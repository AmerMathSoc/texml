%%
%% This is file `cams-l.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cams-l.dtx 
%% This is a generated file.
%% 
%% Copyright 2021 American Mathematical Society.
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
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cams-l}[2021/06/17 v1.00 beta CAMS article documentclass (NOT FOR DISTRIBUTION)]
\RequirePackage{ifxetex}
\RequirePackage{ifpdf}
\DeclareOption{cmr}{\chardef\AMS@MAA@fontset=\z@}
\DeclareOption{stix2}{\chardef\AMS@MAA@fontset=\tw@}

\ifxetex
    \ExecuteOptions{stix2}
\else
    \ExecuteOptions{cmr}
\fi
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}

\ProcessOptions\relax

\LoadClass[e-only,7x10]{amsart}[2020/06/16]
\def\publname{COMMUNICATIONS OF THE\newline
  AMERICAN MATHEMATICAL SOCIETY}
\copyrightinfo{0000}%    % copyright year
  {American Mathematical Society}% copyright holder
\def\ISSN{2692-3688}
\ifnum\AMS@MAA@fontset>\z@
    \IfFileExists{amstix2.sty}{%
        \RequirePackage{amstix2}%
    }{%
    \ClassWarningNoLine{\@classname}{%
        I can't find the amstix2 package.\MessageBreak
        Plead for intercession from PTG}%
    }
\fi
\endinput
%%
%% End of file `cams-l.cls'.
