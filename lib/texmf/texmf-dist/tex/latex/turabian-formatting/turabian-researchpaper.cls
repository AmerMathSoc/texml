% Turabian Formatting for LaTeX
%
% Based on the Chicago Manual of Style (16th edition) and Kate Turabian's A
% Manual for Writers of Research Papers, Theses, and Dissertations (8th edition)
%
% ==============================
% Copyright 2013-2016 Omar Abdool
%
% This work may be distributed and/or modified under the conditions of the LaTeX
% Project Public License (LPPL), either version 1.3 of this license or (at your
% option) any later version.
%
% The latest version of this license is in:
%	http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% LPPL Maintenance Status: maintained (by Omar Abdool)
%
% This work consists of the files: turabian-formatting.sty,
% turabian-researchpaper.cls, turabian-thesis.cls, turabian-formatting-doc.tex,
% and turabian-formatting-doc.pdf (in addition to the README file).
%
% ==============================
%
%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{turabian-researchpaper}[2016/03/18 Turabian Research Paper]


% Default point size
\def\@@ptsize{12pt}


% Options for document class

\DeclareOption{raggedright}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{authordate}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{noadjustbib}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{endnotes}{%
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{twocolumn}{%
	\ClassWarningNoLine{turabian-researchpaper}{The '\CurrentOption' option is not supported.}
	\OptionNotUsed}

\DeclareOption{10pt}{\def\@@ptsize{10pt}}

\DeclareOption{11pt}{\def\@@ptsize{11pt}}

\DeclareOption{12pt}{\def\@@ptsize{12pt}}


% Deprecated options
\DeclareOption{emptymargins}{%
	\ClassWarningNoLine{turabian-researchpaper}{The '\CurrentOption' option has been deprecated}
	\PassOptionsToPackage{\CurrentOption}{turabian-formatting}}

\DeclareOption{endnotesonly}{%
	\ClassWarningNoLine{turabian-researchpaper}{The '\CurrentOption' option has been deprecated. Consider using the 'endnotes' option instead}
	\OptionNotUsed}


% Pass other options to article document class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax


% Build upon article document class
\LoadClass[titlepage,oneside,onecolumn,\@@ptsize]{article}


% Load turabian-formatting package
\RequirePackage{turabian-formatting}


