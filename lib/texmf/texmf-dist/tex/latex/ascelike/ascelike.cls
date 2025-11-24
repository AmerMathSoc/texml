%% File: ascelike.cls
%%
%% Version 2.3
%%
%% An unofficial LaTeX class file for preparing review manuscripts and
%% camera-ready manuscripts for ASCE journals and conference proceedings
%%
%% =============================================
%% IMPORTANT NOTICE:
%% See the copyright and distribution conditions below.
%%
%% Copyright 2011:
%%  Matthew R Kuhn
%%  Donald P. Shiley School of Engineering
%%  University of Portland
%%  5000 N Willamette Blvd
%%  Portland OR  97203
%%  USA
%%  E-mail: kuhn@up.edu
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed, available from the CTAN
%% archives; either version 1.1 of the License, or any later version.  
%% Most importantly, you may modify this file, but only if you rename it.
%%
%% This is a contributed file to the LaTeX2e system.
%%
%% This program consists of the files ascelike.cls and ascelike.bst
%%
%% -----------------------------------
%%
%% This document class produces manuscripts that roughly comply with
%% the guidelines of the American Society of Civil Engineers.  However,
%% it was not produced by ASCE, its agents, or employees; nor is it in
%% any way sanctioned or approved by that organization.
%%
%% -----------------------------------
%%
%% Please note the following usage:
%%
%%   1) This is a LATEX2E class file; it will not work with LaTeX 2.09.
%%
%%   2) It requires the following supplementary files:
%%        ifthen.sty    (part of the standard latex release)
%%        setspace.sty  (produces doubles spacing for journal manuscripts)
%%        endfloat.sty  (places figures and tables at the end of the manuscript)
%%        lineno.sty    (places line numbers alongside the text)
%%      Without these files, it won't work.  All three files are available 
%%      from the CTAN archive, currently at //http:www.tug.org/ctan.html
%%
%%   3) The following files can be used with the tool bibtex to produce 
%%      ASCE-like reference citations and entries (with the weird use of 
%%      quotation marks around titles, etc.)
%%        ascelike.bst
%%        ascelike.bib  (an example bibliographic database for use with bibtex)
%%
%%   3) There are several options.  The two main options are
%%         Journal or Proceedings:
%%         - "Journal" produces double-spaced manuscripts for ASCE journals.
%%           It places tables and figures at the end of the manuscript, 
%%           produces a list of table and list of figures.  Numbers the
%%           appendices with Roman numerals.  Produces proper headings for 
%%           sections, subsections, subsubsections, appendices, and abstract.  
%%           Produces the proper page margins, and numbers the pages, 
%%         - "Proceedings" produces older-sytle camera-ready single-
%%           spaced manuscripts for ASCE conference proceedings.  It places
%%           figures and tables within the text.  It produces proper headings
%            for sections, subsections, subsubsections, appendices, and
%            abstract. Produces the proper page margins, and numbers the pages.
%%         - "NewProceedings" produces camera-ready single-spaced manuscripts
%%           for ASCE conference proceedings, according to website 
%%           instructions of Feb 14, 2013.  It places figures and tables
%%           within the text.  It produces proper headings for 
%%           sections, subsections, subsubsections, appendices, and abstract.  
%%           Produces the proper page margins, and numbers the pages.
%%           This style of proceedings differs from the older style
%%           ("Proceedings") in the fonts for headings
%%
%%       The remaining option override the defaults that are set by the
%%       above formats:
%%         - BackFigs or InsideFigs:
%%           These can be used to override the default placement of tables
%%           and figures for the Journal and Proceeding formats.
%%         - SingleSpace or DoubleSpace:
%%           These can be used to override the default text spacing for
%%           the Journal and Proceeding formats.
%%         - 10pt, 11pt, or 12pt:
%%           These can be used to override the default text size (12pt).
%%         - NoLists suppresses the inclusion of lists of figures and tables
%%         - NoPageNumbers suppressesthe printing of page numbers
%%         - SectionNumbers produces the numbering of sections and subsections,
%            unlike the ASCE convention.
%%
%% A few standard Latex options have been removed, as they don't seem to apply
%%   in the ASCE environment: landscape, titlepage, openbib, leqno, fleqn
%%
%% As for preparing the document file: except for the new options, you
%%   should just use standard sequencing of LaTeX commands.  
%%
%% The only new command that I've added is the \NameTag command which 
%%   prints your name in the bottom right corner of every page (as with 
%%   the ASCE shiny, camera-ready paper).  Insert it in the preamble of
%%   your document file:  \NameTag{<your name>}.
%%
%% Please contact Matthew Kuhn by email for suggestions, etc.
%%
\typeout{}
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{ascelike}
     [2013/2/14 Version 2.3 ASCE-like manuscripts (Am. Soc. Civ. Engr.)]
\typeout{}
\RequirePackage{ifthen}[1994/11/16]
%
\newboolean{Proceedings}
\newboolean{NewProceedings}%                                     02-14-13
\newboolean{Journal}
\newboolean{BackFigs}
\newboolean{InsideFigs}
\newboolean{SingleSpace}
\newboolean{DoubleSpace}
\newboolean{NoPageNumbers}
\newboolean{NoLists}%                                            11-21-02
\newboolean{SectionNumbers}%                                     12-28-02
\newboolean{NoLineNumbers}%                                      12-16-11
\newboolean{LineNumbers}%                                        12-16-11
\newcommand{\ptsize}{}
%
\DeclareOption{Proceedings}%
              {\setboolean{Proceedings}{true}%
               \setboolean{Journal}{false}%
               \setboolean{NewProceedings}{false}}%              02-14-13
\DeclareOption{Journal}%
              {\setboolean{Journal}{true}%
               \setboolean{Proceedings}{false}%
               \setboolean{NewProceedings}{false}}%              02-14-13
\DeclareOption{NewProceedings}%                                  02-14-13
              {\setboolean{NewProceedings}{true}%                02-14-13
               \setboolean{Journal}{false}%                      02-14-13
               \setboolean{Proceedings}{false}}%                 02-14-13
%
\DeclareOption{BackFigs}%
              {\setboolean{BackFigs}{true}\setboolean{InsideFigs}{false}}
\DeclareOption{InsideFigs}%
              {\setboolean{InsideFigs}{true}\setboolean{BackFigs}{false}}
%
\DeclareOption{DoubleSpace}%
              {\setboolean{DoubleSpace}{true}\setboolean{SingleSpace}{false}}
\DeclareOption{SingleSpace}%
              {\setboolean{SingleSpace}{true}\setboolean{DoubleSpace}{false}}
%
\DeclareOption{NoLineNumbers}%
              {\setboolean{NoLineNumbers}{true}\setboolean{LineNumbers}{false}}
\DeclareOption{LineNumbers}%
              {\setboolean{LineNumbers}{true}\setboolean{NoLineNumbers}{false}}
%
% Declare text size options so that 12pt can be made the default option
\DeclareOption{10pt}{\renewcommand{\ptsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\ptsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\ptsize}{12pt}}
%
\DeclareOption{NoPageNumbers}{\setboolean{NoPageNumbers}{true}}
%
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{titlepage}{\OptionNotUsed}
\DeclareOption{openbib}{\OptionNotUsed}
\DeclareOption{leqno}{\OptionNotUsed}
\DeclareOption{fleqn}{\OptionNotUsed}
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
%
\DeclareOption{NoLists}{\setboolean{NoLists}{true}}%                   11-21-02
\DeclareOption{SectionNumbers}{\setboolean{SectionNumbers}{true}}%     11-21-02
%
% Make 12pt and Journal the default options
\ExecuteOptions{12pt,Journal}
\ProcessOptions\relax
%
\LoadClass[oneside,onecolumn,letterpaper,final,\ptsize]{article}[1994/12/09]
%
% These *.sty packages must be installed along this *.cls file. Note that 
%   the package endfloat.sty is also required further below in order to
%   place figures at the end of the paper.
%
%
% Use these defaults
%   For Journal manuscripts:     
%            1) place figures at the end of the manuscript
%               (can be changed with the InsideFigs option)
%            2) double spacing of text
%               (can be changed with the SingleSpace option)
%            3) line numbers
%               (can be changed with the NoLineNumbers option)
%
%   For Proceedings manuscripts: 
%            1) place figures within the text,
%               (can be changed with the BackFigs option)
%            2) single spacing of text
%               (can be changed with the DoubleSpace option)
%            3) no line numbers
%               (can be changed with the LineNumbers option)
%
\ifthenelse{\boolean{Journal}}
  {\ifthenelse{\boolean{InsideFigs}}{}{\setboolean{BackFigs}{true}}}
  {\ifthenelse{\boolean{BackFigs}}{}{\setboolean{InsideFigs}{true}}}
%
\ifthenelse{\boolean{Journal}}
  {\ifthenelse{\boolean{SingleSpace}}{}{\setboolean{DoubleSpace}{true}}}
  {\ifthenelse{\boolean{DoubleSpace}}{}{\setboolean{SingleSpace}{true}}}
%
\ifthenelse{\boolean{Journal}}
  {\ifthenelse{\boolean{NoLineNumbers}}{}{\setboolean{LineNumbers}{true}}}
  {\ifthenelse{\boolean{LineNumbers}}{}{\setboolean{NoLineNumbers}{true}}}
%
%
% Various messages displayed on the screen:
\typeout{}
\ifthenelse{\boolean{Journal}}
{\typeout{(1) A "Journal" style manuscript will be produced}}
{\ifthenelse{\boolean{Proceedings}}%                                   02-14-13
 {\typeout{(1) A "Proceedings" old-style manuscript will be produced}}%02-14-13
 {\typeout{(1) A "NewProceedings" new-style manuscript will be produced}}}
%
\ifthenelse{\boolean{BackFigs}}
{\typeout{%
  (2) Figures and Tables will be placed together at the end of the manuscript
  (change with the 'InsideFigs' option)}}
{\typeout{%
  (2) Figures and Tables will be placed within the text of the manuscript
  (change with the 'BackFigs' option)}}
%
\ifthenelse{\boolean{DoubleSpace}}
{\typeout{%
  (3) Text will be double spaced (change with the 'SingleSpace' option)}}
{\typeout{%
  (3) Text will be single spaced (change with the 'DoubleSpace' option)}}
%
\typeout{(4) Text will be \ptsize 
 \space(change with the '10pt', '11pt', & '12pt' options)}
%
\ifthenelse{\boolean{LineNumbers}}%                                    12-16-11
{\typeout{%
  (5) Line numbers will be placed alonside the text (change with the
  'NoLineNumbers' option)}}
{\typeout{%
  (5) Line numbers will not be placed alonside the text (change with the
  'LineNumbers' option)}}
\typeout{}
%
% Delay the possible loading of these packages until the beginning of   7-18-00
% the document.  This should avoid conflicts with user-load versions    7-18-00
% of the same packages.                                                 7-18-00
\AtBeginDocument{%                                                      7-18-00
\ifthenelse{\boolean{BackFigs}}
  {\ifthenelse{\boolean{NoLists}}%                                     11-21-02
    {\RequirePackage[nolists,noheads,nomarkers,tablesfirst]{endfloat}}%11-21-02
    {\RequirePackage[lists,noheads,nomarkers,tablesfirst]{endfloat}}
  }
  {}
%
\ifthenelse{\boolean{DoubleSpace}}
{\RequirePackage{setspace}\doublespacing}{}
%                                                                      7-18-00
\ifthenelse{\boolean{LineNumbers}}
{\RequirePackage{lineno}\linenumbers%
\setlength{\linenumbersep}{0.3in}%
\linenumberdisplaymath}{}
}%
%
% Page layout for Proceedings manuscripts:
\ifthenelse{\boolean{Proceedings}}
{\setlength{\topmargin}     {0.25in}
 \setlength{\headheight}    {0.00in}
 \setlength{\headsep}       {0.00in}
 \setlength{\textheight}    {8.83in}
 \setlength{\footskip}      {0.40in}
 \setlength{\oddsidemargin} {0.45in}
 \setlength{\textwidth}     {5.71in}
 \setlength{\marginparsep}  {0.00in}
 \setlength{\marginparwidth}{0.00in}
 \setlength{\marginparpush} {0.00in}}
%
{\ifthenelse{\boolean{Journal}}
% Page layout for Journal manuscripts:
 {\setlength{\topmargin}     {0.00in}
  \setlength{\headheight}    {0.00in}
  \setlength{\headsep}       {0.00in}
  \setlength{\textheight}    {9.00in}
  \setlength{\footskip}      {0.50in}
  \setlength{\oddsidemargin} {0.00in}
  \setlength{\textwidth}     {6.50in}
  \setlength{\marginparsep}  {0.00in}
  \setlength{\marginparwidth}{0.00in}
  \setlength{\marginparpush} {0.00in}}
%
% Page layout for NewProceedings manuscripts:
 {\setlength{\topmargin}     {0.00in}
  \setlength{\headheight}    {0.00in}
  \setlength{\headsep}       {0.00in}
  \setlength{\textheight}    {9.00in}
  \setlength{\footskip}      {0.40in}
  \setlength{\oddsidemargin} {0.38in}
  \setlength{\textwidth}     {5.75in}
  \setlength{\marginparsep}  {0.00in}
  \setlength{\marginparwidth}{0.00in}
  \setlength{\marginparpush} {0.00in}}}
%
%
% Author-year citations in the ASCE style.  The following code was
%   adopted from the chicago.sty package.  I removed the 'long citation 
%   style' to make all citations in the short style used by ASCE (i.e., 
%   using "et. al" for multiple authors).  
%
% Here's an adaptation of chicago.sty notes for the various citation
%   options that I've included:
%
%  \cite{key}
%    which produces citations with full author list and year.
%    eg. (Brown 1978; Jarke et al. 1985)
%  \citeNP{key}
%    which produces citations with full author list and year, but without
%    enclosing parentheses:
%    eg. Brown 1978; Jarke et. al 1985
%  \citeA{key}
%    which produces citations with only the full author list.
%    eg. (Brown; Jarke et. al)
%  \citeN{key}
%    which produces citations with the full author list and year, but
%    can be used as nouns in a sentence; no parentheses appear around
%    the author names, but only around the year.
%      eg. Shneiderman (1978) states that......
%    \citeN should only be used for a single citation.
%  \citeyear{key}
%    which produces the year information only, within parentheses.
%  \citeyearNP{key}
%    which produces the year information only.
%
% `NP' means `no parentheses'.
%
\let\@internalcite\cite
%
% Place commas in-between citations in the same \citeyear, \citeyearNP,
%  or \citeN command.
% Use something like \citeN{ref1,ref2,ref3} and \citeN{ref4} for a list.
%
\newcommand{\citedata}%
   {\@ifnextchar [{\@tempswatrue\@citedatax}%
                  {\@tempswafalse\@citedatax[]}}
%
\def\@citedatax[#1]#2{%
\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi%
  \def\@citea{}\@cite{\@for\@citeb:=#2\do%
    {\@citea\def\@citea{, }\@ifundefined% by Young
       {b@\@citeb}{{\bf ?}%
       \@warning{Citation `\@citeb' on page \thepage \space undefined}}%
{\csname b@\@citeb\endcsname}}}{#1}}%
%
\def\@citex[#1]#2{%
\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi%
  \def\@citea{}\@cite{\@for\@citeb:=#2\do%
    {\@citea\def\@citea{; }\@ifundefined% by Young
       {b@\@citeb}{{\bf ?}%
       \@warning{Citation `\@citeb' on page \thepage \space undefined}}%
{\csname b@\@citeb\endcsname}}}{#1}}%
%
\renewcommand{\cite}%
   {\def\@citeseppen{-1000}%
    \def\@cite##1##2{(##1\if@tempswa , ##2\fi)}%
    \def\citeauthoryear##1##2##3{##2 ##3}\@internalcite}
\newcommand{\citeNP}%
   {\def\@citeseppen{-1000}%
    \def\@cite##1##2{##1\if@tempswa , ##2\fi}%
    \def\citeauthoryear##1##2##3{##2 ##3}\@internalcite}
\newcommand{\citeN}%
   {\def\@citeseppen{-1000}%
    \def\@cite##1##2{##1\if@tempswa , ##2)\else{)}\fi}%
    \def\citeauthoryear##1##2##3{##2 (##3}\citedata}
\newcommand{\citeA}%
   {\def\@citeseppen{-1000}%
    \def\@cite##1##2{(##1\if@tempswa , ##2\fi)}%
    \def\citeauthoryear##1##2##3{##2}\@internalcite}
\newcommand{\citeyear}%
   {\def\@citeseppen{-1000}%
    \def\@cite##1##2{(##1\if@tempswa , ##2\fi)}%
    \def\citeauthoryear##1##2##3{##3}\citedata}
\newcommand{\citeyearNP}%
   {\def\@citeseppen{-1000}%
    \def\@cite##1##2{##1\if@tempswa , ##2\fi}%
    \def\citeauthoryear##1##2##3{##3}\citedata}
%
%
% An ASCE-like title on the first page
\renewcommand{\maketitle}{
  \begingroup
    \renewcommand{\thefootnote}{\arabic{footnote}}%
    \ifthenelse{\boolean{@twocolumn}}
      {\ifthenelse{\equal{\col@number}{\@ne}}
                  {\@maketitle}
                  {\twocolumn[\@maketitle]}}%
      {\newpage
       \global\@topnum\z@   % Prevents figures from going at top of page.
       \@maketitle}
    \@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}}
%
\renewcommand{\@maketitle}{%
  \newpage
  \null
% \begin{center}%
    \ifthenelse{\boolean{Journal}}
               {\vspace{0.00in}}
               {\ifthenelse{\boolean{NewProceedings}}%               02-14-13
                 {\vspace{1.40in}}%                                  02-14-13
                 {\vspace{1.40in}}}
    \centering
    {\large\bfseries\@title\par}%
     \vspace{1.0em}%
    {\normalsize\normalfont
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
% \end{center}%
  \par
  \vspace{0.5em}}%
%
%
% An ASCE-like abstract
\renewcommand{\abstractname}{ABSTRACT}
\renewenvironment{abstract}
  {\ifthenelse{\boolean{Proceedings}}
     {\section*{\small\abstractname}\small}%
     {\section*{\abstractname}}%
  }
  {\normalsize}
%
%
% ASCE-like section, subsection, and subsubsection headings
\ifthenelse{\boolean{SectionNumbers}}%                               12-29-02
           {\setcounter{secnumdepth}{2}}%                            12-29-02
           {\setcounter{secnumdepth}{0}}%                            12-29-02
\renewcommand{\section}{\secdef\Section\sSection}
\newcommand{\SectionNumber}{}
\setcounter{section}{-1}
\newcommand{\Section}[2][?]{%
   \refstepcounter{section}%
   \ifthenelse{\boolean{SectionNumbers}} %                           12-29-02
              {\renewcommand{\SectionNumber}{\thesection\hspace{1em}}}
              {}
   \par{\flushleft\normalsize\bfseries%
        \ifthenelse{\boolean{NewProceedings}}%                       02-14-13
         {\rmfamily}%                                                02-14-13
         {\sffamily}%
        \uppercase%
        {\SectionNumber#2}\par}%
        \nopagebreak}
\newcommand{\sSection}[1]{%
   \refstepcounter{section}%
   \par{\flushleft\bfseries%
        \ifthenelse{\boolean{NewProceedings}}%                       02-14-13
         {\rmfamily}%                                                02-14-13
         {\sffamily}%
        \uppercase{#1}\par}\nopagebreak}
%
\renewcommand{\subsection}{\@startsection{subsection}{2}{0in}%
                            {1.00ex\@plus 1ex \@minus .2ex}%
                            {0.2ex \@plus .2ex}%
                            {\normalfont\normalsize\bfseries}}
%
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0in}%
                               {1.00ex\@plus 1ex \@minus .2ex}%
                               {0.2ex \@plus .2ex}%
                               {\normalfont\normalsize\itshape}}
%
\newcommand{\RefSectionType}{\section*}
\ifthenelse{\boolean{Journal}}{\renewcommand{\RefSectionType}{\section}}{}%
%
%
% ASCE-like appendix headings.  In order to get appendix heading such as
%   'Appendix II: Notation' you must insert the line '\appendix' in your
%   document *.tex file at the start of the appendices.
%
\renewcommand{\appendixname}{APPENDIX}
\renewcommand{\appendix}{%
  \renewcommand{\section}{%
    \ifthenelse{\boolean{Journal}}
      {\newpage}{}%
    \secdef\Appendix\sAppendix}%
  \setcounter{section}{0}%
  \renewcommand{\thesection}{\Roman{section}}%
}
\newcommand{\Appendix}[2][]{%
   \refstepcounter{section}%
   {%
    \flushleft\normalsize\bfseries
    \ifthenelse{\boolean{NewProceedings}}%                           02-14-13
      {\rmfamily}%                                                   02-14-13
      {\sffamily}%
    \appendixname\ %
    \thesection. \uppercase{#1}\par}\nopagebreak}%
\newcommand{\sAppendix}[1]{%
   {\flushleft\normalsize\bfseries%
    \ifthenelse{\boolean{NewProceedings}}%                           02-14-13
      {\rmfamily}%                                                   02-14-13
      {\sffamily}%
    \uppercase{#1}\par}\nopagebreak}%
%
%
% An ASCE-like "enumerate" environment for numbered lists
\newcounter{enumnoo}
\renewenvironment{enumerate}
{\begin{list}
             {\arabic{enumnoo}.}%
             {\usecounter{enumnoo}%
              \setlength{\labelwidth}{2em}%
              \setlength{\labelsep}{0.7em}%
              \setlength{\itemindent}{0em}%
              \setlength{\listparindent}{1.5em}%                     12-29-02
              \setlength{\leftmargin}{3em}%
              \setlength{\rightmargin}{0em}%
              \setlength{\parsep}{0ex}%
              \setlength{\topsep}{2ex}%
              \setlength{\itemsep}{0ex}%
             }%
}
{\end{list}}%
%
%
% An ASCE-like "itemize" environment for 'bulleted' items
\renewenvironment{itemize}
{\begin{list}
             {\labelitemi}%
             {\setlength{\labelwidth}{1em}%
              \setlength{\labelsep}{0.7em}%
              \setlength{\itemindent}{0em}%
              \setlength{\listparindent}{3em}%
              \setlength{\leftmargin}{3em}%
              \setlength{\rightmargin}{0em}%
              \setlength{\parsep}{0ex}%
              \setlength{\topsep}{2ex}%
              \setlength{\itemsep}{0ex}%
             }%
}
{\end{list}}%
%
%
% ASCE-like figure labels
\renewcommand{\figurename}%
             {\ifthenelse{\boolean{NewProceedings}}%                02-14-13
               {Figure}%                                            02-14-13
               {FIG.}}
\renewcommand{\tablename}%
             {\ifthenelse{\boolean{NewProceedings}}%                02-14-13
               {Table}%                                             02-14-13
               {TABLE}}
\newsavebox{\TempBoxb}
\newlength{\TempBoxl}
\setlength{\belowcaptionskip}{1.5ex}
\newlength{\Abovecaptionrule}
\ifthenelse{\boolean{Journal}\and\boolean{BackFigs}}%
  {\setlength{\Abovecaptionrule}{0.75in}}
  {\setlength{\Abovecaptionrule}{0.05in}}
\renewcommand{\@makecaption}[2]{%
  \vspace{\Abovecaptionrule}
  \savebox{\TempBoxb}{%
     \rule{0em}{3ex}%
       \ifthenelse{\boolean{NewProceedings}}%                        02-14-13
         {\rmfamily}%                                                02-14-13
         {\sffamily}%
       \bfseries\normalsize#1.%
     \makebox[1ex]{}%
       \ifthenelse{\boolean{NewProceedings}}%                        02-14-13
         {\rmfamily}%                                                02-14-13
         {\sffamily}%
       \bfseries\normalsize#2}%
  \settowidth{\TempBoxl}{\usebox{\TempBoxb}}
  \ifthenelse{\lengthtest{\TempBoxl > \textwidth}}
    {\ifthenelse{\boolean{NewProceedings}}%                          02-14-13
       {\rmfamily}%                                                  02-14-13
       {\sffamily}%
     \bfseries\normalsize#1.\makebox[1ex]{}%
     \ifthenelse{\boolean{NewProceedings}}%                          02-14-13
       {\rmfamily}%                                                  02-14-13
       {\sffamily}%
     \bfseries\normalsize#2\par}%
    {\centering \usebox{\TempBoxb}}
  \vskip\belowcaptionskip}%
%
%
% Float parameters suggested by G. Granger in TUGboat 15(2)
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{2}
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.5}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.8}
\renewcommand{\dbltopfraction}{0.9}
\renewcommand{\dblfloatpagefraction}{0.8}
%
%
% An ASCE-like layout of the bibliographic items
\renewcommand{\refname}{REFERENCES}
\def\@biblabel#1{}
\bibindent=1.0em
\renewenvironment{thebibliography}[1]
     {\par%
      \RefSectionType{\refname%
        \@mkboth{\refname}{\refname}}%
      \list{[\arabic{enumiv}]}%
           {%\settowidth\labelwidth{\@biblabel{#1}}%
            \setlength{\labelwidth}{0em}
            \leftmargin\labelwidth
            \setlength{\labelsep}{0.in}
            \advance\leftmargin\labelsep
            \advance\leftmargin\bibindent
            \itemindent -\bibindent
            \listparindent \itemindent
            \setlength{\itemsep}{0ex}%
            \setlength{\topsep}{0ex}%
            \parsep \z@
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand{\theenumiv}{\arabic{enumiv}}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\renewcommand{\newblock}{}
%
% A new commond for "tagging" the author's name on the bottom right
%   corner of the page (as per the ASCE shiny, camera-ready blank paper)
\newcommand{\NameTag}[1]
  {\ifthenelse{\boolean{NoPageNumbers}}%                              02-14-13
    {\@latex@warning{Oops! Can not use NameTag with NoPageNumbers}}%  02-14-13
    {\newlength{\LeftFootSpace}
     \settowidth{\LeftFootSpace}{#1}
     \renewcommand{\@oddfoot}{\hspace{\LeftFootSpace}\hfill\thepage\hfill#1}}
  }
\newcommand{\KeyWordName}{Keywords}
\newcommand{\KeyWords}[1]
  {\par\noindent\rule{0em}{3ex}%
   \ifthenelse{\boolean{NewProceedings}}%                           02-14-13
     {\rmfamily}%                                                   02-14-13
     {\sffamily}%
   \bfseries\KeyWordName: %
   \normalfont#1}
%
% ASCE asks for the lists of tables and figures to be double-spaces
\ifthenelse{\boolean{BackFigs}}
{\renewcommand\listoftables{%
    \section*{\listtablename
      \@mkboth{%
          \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
      \ifthenelse{\boolean{DoubleSpace}}%                           02-14-13
        {\doublespacing\@starttoc{lot}\singlespacing}%              02-14-13
        {\@starttoc{lot}}}
 \renewcommand\listoffigures{%
    \section*{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
      \ifthenelse{\boolean{DoubleSpace}}%                           02-14-13
        {\doublespacing\@starttoc{lof}\singlespacing}%              02-14-13
        {\@starttoc{lof}}}
    }{}
%
\AtEndOfClass
  {\bibliographystyle{ascelike}
   \ifthenelse{\boolean{NoPageNumbers}}
      {\pagestyle{empty}}
      {\pagestyle{plain}}
  }
%
