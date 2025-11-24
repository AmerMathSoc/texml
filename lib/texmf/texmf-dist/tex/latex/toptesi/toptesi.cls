%%
%% This is file `toptesi.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% toptesi.dtx  (with options: `class')
%%   ______________________________________________________
%%   The TOPtesi package
%%   Copyright (C) 2015 Claudio Beccari
%%   All rights reserved
%% 
%%   License information appended
%% 
\NeedsTeXFormat{LaTeX2e}[2015/01/01]
\ProvidesClass{toptesi}[%
2016/06/29 v.5.92
Class for typesetting university theses]
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{titlepage}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{a4paper,titlepage}
\ProcessOptions\relax
\LoadClass{report}
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[english,italian]{babel}
\else
  \RequirePackage{polyglossia}
  \setmainlanguage{italian}
  \setotherlanguage{english}
  \renewcommand*{\iflanguage}[1]{\ifnum\the\language=\csname l@#1\endcsname
  \expandafter\@firstoftwo\else
  \expandafter\@secondoftwo\fi}
\fi
\RequirePackage{toptesi}
%% 
%% Copyright 2005-2015 Claudio Beccari
%% 
%% Distributable under the LaTeX Project Public License,
%% version 1.3c or higher (your choice). The latest version of
%% this license is at: http://www.latex-project.org/lppl.txt
%% 
%% This work is "author-maintained"
%% 
%% This work consists of this file toptesi.dtx, a README file
%% and the derived files:
%% 
%% toptesi.cls, toptesi.sty, topfront.sty, topcommand.sty,
%% toptesi.cfg, and the English documentation toptesi.pdf.
%% 
%% Furthermore the bundle contains the documentation source
%% file toptesi-it-pdftex.tex and the derived file
%% toptesi-it-pdftex.pdf.
%% 
%% The toptesi-example.tex source file is just an example
%% that shows how to use the various commands; by commenting
%% or uncommenting certain source lines it is possible to
%% typeset different kind of theses and their front pages.
%% 
%% The topfront-example.tex source file is an example of how
%% to produce just the title page with TOPtesi and the external
%% package frontespizio.
%% 
%% The toptesi.cfg file is a sample of a local configuration
%% file that can be copied to another file and its copy freely
%% edited and customized.
%% 
%% By running pdflatex on toptesi.dtx the user gets the class,
%% sty and cfg files and the English documentation file in
%% pdf format.
%% 
%% The source file of the Italian documentation file
%% toptesi-it-pdftex.pdf is another example of how to use TOPtesi.
%% In spite of its name, toptesi-it-pdftex.tex may be typeset
%% with pdfLaTeX, XeLaTeX, and LuaLateX; see the first comment
%% lines of the file for how-to information.
%%
%% End of file `toptesi.cls'.
