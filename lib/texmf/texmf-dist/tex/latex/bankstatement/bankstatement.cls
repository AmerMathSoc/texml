%%
%% This is file `bankstatement.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% bankstatement.dtx  (with options: `class')
%% 
%% Copyright (C) 2015 by:
%% Josef Kleber
%% <josef.kleber@gmx.de>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "maintained".
%% 
%% The Current Maintainer of this work is Josef Kleber.
%% 
%% This work consists of all files listed in manifest.txt.
%% 
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{bankstatement}[2015/11/14 class for csv based bank statements v0.9.2]%
\RequirePackage{xkeyval}%
\RequirePackage{xkvltxp}%
\newcommand*\STM@JK@define@key[4]%
{%
  \expandafter\gdef\csname#1@#3\endcsname{#4}%
  \define@key{#2.cls}{#3}[#4]%
  {%
    \expandafter\gdef\csname#1@#3\endcsname{##1}%
  }%
  \define@key{#2}{#3}%
  {%
    \expandafter\def\csname#1@#3\endcsname{##1}%
  }%
}%
\STM@JK@define@key{STM@JK}{bankstatement}{format}{csv-mt940}%
\STM@JK@define@key{STM@JK}{bankstatement}{language}{english}%
\STM@JK@define@key{STM@JK}{bankstatement}{title}{}%
\STM@JK@define@key{STM@JK}{bankstatement}{logo}{}%
\STM@JK@define@key{STM@JK}{bankstatement}{logowidth}{4cm}%
\STM@JK@define@key{STM@JK}{bankstatement}{holder}{}%
\STM@JK@define@key{STM@JK}{bankstatement}{bic}{}%
\STM@JK@define@key{STM@JK}{bankstatement}{iban}{}%
\STM@JK@define@key{STM@JK}{bankstatement}{referencewidth}{11cm}%
\STM@JK@define@key{STM@JK}{bankstatement}{negativecolor}{red}%
\STM@JK@define@key{STM@JK}{bankstatement}{sort}{PostingDate}%
\STM@JK@define@key{STM@JK}{bankstatement}{openingbalance}{none}%
\STM@JK@define@key{STM@JK}{bankstatement}{closingbalance}{none}%
\STM@JK@define@key{STM@JK}{bankstatement}{left}{2cm}%
\STM@JK@define@key{STM@JK}{bankstatement}{right}{2cm}%
\STM@JK@define@key{STM@JK}{bankstatement}{top}{2cm}%
\STM@JK@define@key{STM@JK}{bankstatement}{bottom}{2cm}%
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}%
\ExecuteOptionsX{format,language,title,logo,logowidth,holder,bic,iban,%
                 referencewidth,negativecolor,sort,openingbalance,%
                 closingbalance,left,right,top,bottom}%
\ProcessOptionsX*\relax%
\LoadClass{article}%
\RequirePackage[left=\STM@JK@left,right=\STM@JK@right,top=\STM@JK@top,%
                bottom=\STM@JK@bottom]{geometry}%
\RequirePackage{longtable}%
\RequirePackage{tabularx}%
\RequirePackage{xcolor}%
\RequirePackage{graphicx}%
\RequirePackage{booktabs}%
\RequirePackage{datatool}%
\RequirePackage{calc}%
\RequirePackage{ifthen}%
\RequirePackage{siunitx}%
\newcommand*\STM@JK@dbkeys{}%
\newcommand*\STM@JK@DTLforeach{}%
\newcommand*\STM@JK@holdername{}%
\newcommand*\STM@JK@bicname{}%
\newcommand*\STM@JK@ibanname{}%
\newcommand*\STM@JK@firstcolumnheading{}%
\newcommand*\STM@JK@secondcolumnheading{}%
\newcommand*\STM@JK@thirdcolumnheading{}%
\newcommand*\STM@JK@openingbalancename{}%
\newcommand*\STM@JK@closingbalancename{}%
\newcommand*\STM@JK@headingsep{0.5cm}%
\newcommand*\STM@JK@noheader{false}%
\newcounter{STM@JK@count}%
\input{\STM@JK@format.def}%
\input{stm\STM@JK@language.def}%
\newcommand*\STM@JK@includelogo%
{%
  \ifthenelse{\equal{\STM@JK@logo}{}}%
  {}%
  {\hfill\includegraphics[width=\STM@JK@logowidth]{\STM@JK@logo}}%
}%
\newcommand*\STM@JK@header%
{%
  \noindent%
  \begin{tabularx}{\textwidth}{XXr}%
    \multicolumn{3}{l}{\Huge{}\hspace{.22em}\STM@JK@title\STM@JK@includelogo}\\%
    &  &\\%
    \begin{tabular}{l}\textbf{\STM@JK@holdername}\\\STM@JK@holder\end{tabular} &%
    \begin{tabular}{l}\textbf{\STM@JK@bicname}\\\STM@JK@bic\end{tabular} &%
    \begin{tabular}{l}\textbf{\STM@JK@ibanname}\\\STM@JK@iban\end{tabular}\\%
  \end{tabularx}%
  \vspace{\STM@JK@headingsep}%
}%
\newcommand\bankstatement[2][]%
{%
  \begingroup%
    \setkeys{bankstatement}{#1}%
    \stepcounter{STM@JK@count}%
    \xdef\STM@JK@dbname{stm\arabic{STM@JK@count}}%
    \ifthenelse{\equal{\STM@JK@noheader}{false}}%
    {\DTLloadrawdb[keys={\STM@JK@dbkeys},noheader=false]{\STM@JK@dbname}{#2}}%
    {\DTLloadrawdb[keys={\STM@JK@dbkeys},noheader=true]{\STM@JK@dbname}{#2}}%
    \ifthenelse{\equal{\STM@JK@sort}{}}%
    {}%
    {\DTLsort{\STM@JK@sort}{\STM@JK@dbname}}%
    \STM@JK@header%
    \begin{longtable}{llr}%
    \toprule%
    \STM@JK@firstcolumnheading &%
    \STM@JK@secondcolumnheading &%
    \STM@JK@thirdcolumnheading%
    \\\toprule%
    \endhead%
    \ifthenelse{\equal{\STM@JK@openingbalance}{none}}%
    {}%
    { & & \\ & \STM@JK@openingbalancename &%
      \DTLifStartsWith{\STM@JK@openingbalance}{-}%
      {\textcolor{\STM@JK@negativecolor}{\num{\STM@JK@openingbalance}}}%
      {\num{\STM@JK@openingbalance}} \\\midrule}%
    \STM@JK@DTLforeach%
    \end{longtable}%
  \endgroup%
}%
\AtBeginDocument{\disable@keys{bankstatement}%
                              {format,language,left,right,top,bottom}}%
\endinput
%%
%% End of file `bankstatement.cls'.
