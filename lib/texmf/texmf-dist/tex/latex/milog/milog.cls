%%
%% This is file `milog.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% milog.dtx  (with options: `class')
%% 
%% Copyright (C) 2016 by:
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
\ProvidesClass{milog}[2016/07/01 class for MiLoG documentation v1.0]%
\RequirePackage{xkeyval}%
\RequirePackage{xkvltxp}%
\newcommand*\MLG@JK@define@key[4]%
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
\MLG@JK@define@key{MLG@JK}{milog}{color}{gray!40}%
\MLG@JK@define@key{MLG@JK}{milog}{companyname}{Firma}%
\MLG@JK@define@key{MLG@JK}{milog}{company}{}%
\MLG@JK@define@key{MLG@JK}{milog}{namename}{Name, Vorname}%
\MLG@JK@define@key{MLG@JK}{milog}{name}{}%
\MLG@JK@define@key{MLG@JK}{milog}{idname}{Geburtsdatum/Personalnummer}%
\MLG@JK@define@key{MLG@JK}{milog}{id}{}%
\MLG@JK@define@key{MLG@JK}{milog}{monthname}{Monat/Jahr}%
\MLG@JK@define@key{MLG@JK}{milog}{month}{}%
\MLG@JK@define@key{MLG@JK}{milog}{heading}{Arbeitszeitnachweis nach %
dem Mindestlohngesetz (\S 17 MiLoG)}%
\MLG@JK@define@key{MLG@JK}{milog}{cc}{false}%
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}%
\ExecuteOptionsX{color,companyname,company,namename,name,idname,id,%
                 monthname,month,heading,cc}%
\ProcessOptionsX*\relax%
\LoadClass{article}%
\RequirePackage[margin={2cm,2cm}]{geometry}%
\RequirePackage{tabularx}%
\RequirePackage{booktabs}%
\RequirePackage{colortbl}%
\RequirePackage{xifthen}%
\RequirePackage[pages=some]{background}%
\RequirePackage{transparent}%
\RequirePackage{pgfplotstable}%
\setlength{\parindent}{0pt}%
\pagestyle{empty}%
\newcommand*\MLG@JK@heading@font@size{\Large}%
\newcommand*\MLG@JK@heading@font@style{\bfseries}%
\newcommand*\MLG@JK@idtab@topskip{\vfill}%
\newcommand*\MLG@JK@csvtab@topskip{\vfill}%
\newcommand*\MLG@JK@signaturebox@topskip{\vfill\vfill}%
\newcommand*\MLG@JK@idtab@width{13cm}%
\newcommand*\MLG@JK@idtab@as{1.3}%
\newcommand*\MLG@JK@csvtab@as{1.15}%
\newcommand*\MLG@JK@csvtab@opacity{0.5}%
\newcommand*\MLG@JK@bgopt@contents{Kopie}%
\newcommand*\MLG@JK@bgopt@color{gray!30}%
\newcommand*\MLG@JK@bgopt@opacity{0.5}%
\newcommand*\MLG@JK@bgopt@scale{25}%
\newcommand*\MLG@JK@signaturebox@space{3cm}%
\newcommand*\MLG@JK@signature@width{6cm}%
\newcommand*\MLG@JK@signature@labelskip{2ex}%
\newcommand*\MLG@JK@signature@employee{Arbeitnehmer}%
\newcommand*\MLG@JK@signature@employer{Arbeitgeber}%
\pgfplotstableset%
{%
  columns/tag/.style={string type,%
                      column name={Tag},%
                      string replace={nan}{\space}},%
  columns/beginn/.style={string type,%
                         column name={Arbeitsbeginn},%
                         string replace={nan}{\space}},%
  columns/pause/.style={string type,%
                        column name={Unbezahlte Pause},%
                        string replace={nan}{\space}},%
  columns/ende/.style={string type,%
                       column name={Arbeitsende},%
                       string replace={nan}{\space}},%
  columns/dauer/.style={string type,%
                        column name={Arbeitsdauer},%
                        string replace={nan}{\space}},%
  columns/bemerkung/.style={string type,%
                            column name={Bemerkung},%
                            string replace={nan}{\space}},%
  empty cells with={--},%
  every head row/.style={before row=\toprule,after row=\midrule},%
  every even row/.style={before row={\rowcolor{\MLG@JK@color}}},%
  every last row/.style={before row=\bottomrule}%
}%
\newcommand*\MLG@JK@colortbl@transparent%
{%
  \def\CT@@do@color%
  {%
    \global\let\CT@do@color\relax%
    \@tempdima\wd\z@%
    \advance\@tempdima\@tempdimb%
    \advance\@tempdima\@tempdimc%
    \kern-\@tempdimb%
    \transparent{\MLG@JK@csvtab@opacity}%
    \leaders\vrule%
    \hskip\@tempdima\@plus 1fill%
    \kern-\@tempdimc%
    \hskip-\wd\z@ \@plus -1fill%
  }%
}%
\pgfplotstableread{%
tag  beginn  pause  ende  dauer  bemerkung
1    nan     nan    nan   nan    nan
2    nan     nan    nan   nan    nan
3    nan     nan    nan   nan    nan
4    nan     nan    nan   nan    nan
5    nan     nan    nan   nan    nan
6    nan     nan    nan   nan    nan
7    nan     nan    nan   nan    nan
8    nan     nan    nan   nan    nan
9    nan     nan    nan   nan    nan
10   nan     nan    nan   nan    nan
11   nan     nan    nan   nan    nan
12   nan     nan    nan   nan    nan
13   nan     nan    nan   nan    nan
14   nan     nan    nan   nan    nan
15   nan     nan    nan   nan    nan
16   nan     nan    nan   nan    nan
17   nan     nan    nan   nan    nan
18   nan     nan    nan   nan    nan
19   nan     nan    nan   nan    nan
20   nan     nan    nan   nan    nan
21   nan     nan    nan   nan    nan
22   nan     nan    nan   nan    nan
23   nan     nan    nan   nan    nan
24   nan     nan    nan   nan    nan
25   nan     nan    nan   nan    nan
26   nan     nan    nan   nan    nan
27   nan     nan    nan   nan    nan
28   nan     nan    nan   nan    nan
29   nan     nan    nan   nan    nan
30   nan     nan    nan   nan    nan
31   nan     nan    nan   nan    nan
nan  nan     nan    nan   nan    nan
}\Formular%
\AtBeginDocument%
{%
  \IfFileExists{milog.cfg}%
  {%
    \input{milog.cfg}%
  }{}%
}%
\newcommand*\MLG@JK@idtab%
{%
  \MLG@JK@idtab@topskip%
  \renewcommand{\arraystretch}{\MLG@JK@idtab@as}%
  \begin{tabularx}{\MLG@JK@idtab@width}{>{\bfseries}r<{:}X}%
  \MLG@JK@companyname & \MLG@JK@company \\%
  \MLG@JK@namename & \MLG@JK@name \\%
  \ifthenelse{\equal{\MLG@JK@id}{}}%
  {}%
  {\MLG@JK@idname & \MLG@JK@id \\}%
  \MLG@JK@monthname & \MLG@JK@month%
  \end{tabularx}%
}%
\newcommand*\MLG@JK@csvtab[1]%
{%
  \MLG@JK@csvtab@topskip%
  \renewcommand{\arraystretch}{\MLG@JK@csvtab@as}%
  \pgfplotstabletypeset{#1}%
}%
\newcommand*\MLG@JK@signature[1]%
{%
  \parbox{\MLG@JK@signature@width}%
  {%
    \dotfill\\[\MLG@JK@signature@labelskip]%
    \centering\footnotesize Datum,  Unterschrift (#1)%
  }%
}%
\newcommand*\MLG@JK@signaturebox%
{%
  \MLG@JK@signaturebox@topskip%
  \MLG@JK@signature{\MLG@JK@signature@employee}%
  \hspace{\MLG@JK@signaturebox@space}%
  \MLG@JK@signature{\MLG@JK@signature@employer}%
}%
\newcommand*\MLG@JK@doc@body[1]%
{%
  {\MLG@JK@heading@font@size\MLG@JK@heading@font@style\MLG@JK@heading}%
  \MLG@JK@idtab%
  \MLG@JK@csvtab{#1}%
  \MLG@JK@signaturebox%
}%
\newcommand*\milogsetup[1]%
{%
  \setkeys{milog.cls}{#1}%
}%
\newcommand\milog[2][]%
{%
  \centering%
  \backgroundsetup%
  {%
    contents=\MLG@JK@bgopt@contents,%
    color=\MLG@JK@bgopt@color,%
    opacity=\MLG@JK@bgopt@opacity,%
    scale=\MLG@JK@bgopt@scale%
  }%
  \begingroup%
    \setkeys{milog}{#1}%
    \MLG@JK@colortbl@transparent%
    \MLG@JK@doc@body{#2}%
    \ifthenelse{\equal{\MLG@JK@cc}{true}}%
    {%
      \newpage%
      \BgThispage%
      \MLG@JK@doc@body{#2}%
    }%
    {}%
  \endgroup%
}%
\endinput
%%
%% End of file `milog.cls'.
