%%
%% LaTeX class file based on slides class.
%%
%% sslides.cls
%% Copyright 2013 Behzad Salimi
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Behzad Salimi
%  sites.google.com/site/quadratures
%
% This work consists of the files:
%
%        land-sample-slide.pdf
%        land-sample-slide.tex
%        port-sample-slide.pdf
%        port-sample-slide.tex
%        sslides.cls

%  This class file is to set up LaTeX-slides with header and footer.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sslides}[2010/08/22 Custom LaTeX minimal class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{slides}}
\ProcessOptions
\LoadClass{slides}

\newcommand{\oddh}[1]{\def\ohead{#1}}
\newcommand{\oddf}[1]{\def\ofoot{#1}}
\newcommand{\evenh}[1]{\def\ehead{#1}}
\newcommand{\evenf}[1]{\def\efoot{#1}}

\def\ps@headings{%
\def\ps@slide{\def\@oddhead{\ohead}\def\@oddfoot{\ofoot}%
\def\@evenhead{\ehead}\def\@evenfoot{\efoot}}%
\def\ps@overlay{\def\@oddhead{\ohead}\def\@oddfoot{\ofoot}%
\def\@evenhead{\ehead}\def\@evenfoot{\efoot}}%
\def\ps@note{\def\@oddhead{\ohead}\def\@oddfoot{\ofoot}%
\def\@evenhead{\ehead}\def\@evenfoot{\efoot}}}
% Initialize
\oddh{}\oddf{}\evenh{}\evenf{}
\pagestyle{headings}

