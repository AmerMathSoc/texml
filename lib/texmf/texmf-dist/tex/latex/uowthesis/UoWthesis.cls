%% UoWthesis.cls
%%   Document class to use with LaTeX 2e.
%% Copyright (C) 2007 Lei Ye
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `author-maintained'.
% 
% This work consists of the file UoWthesis.cls
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This document class to use with LaTeX2e is built on the standard 
%%   report class for preparation of PhD and other higher degree 
%%   research theses in compliance with the specifications of UoW 
%%   theses in the "Guidelines for Preparation and Submission of  
%%   Higher Degree Research Theses" (March 2006), by Research Student 
%%   Centre, Research & Innovation Division, UoW (the "Guidelines"). 
%%   However, this work is of no official status. It is created and 
%%   made available in the hope that it would be useful.
%%
%%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% REVISION HISTORY:
%%   
%% v1.0: 30/03/2007 (Lei Ye)
%%     - Initial version
%% v1.0a: 26/05/2007 (Lei Ye)
%%     - Bug fix: added space "\ " to avoid "no line here to end"
%%                error caused by the absence of \degreeHeld in
%%                \maketitle
%% 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% USAGE:  \documentclass{UoWthesis}
%%         \documentclass[...options...]{UoWthesis}
%%
%%                       (Only to be used in this LaTeX2e native mode)
%%
%% The default settings produce a PhD dissertation (12pt font, 
%%   single-sided, double-spaced, hyper-linked)
%%
%% Thesis Class Options:
%%   * Degrees
%% 		   phd/master/other       (Default: phd)
%%         (master and other in fact are the same)
%%   * Filfulment requirement
%% 		   full/partial           (Default: full for phd            )
%%                              (         partial for master/other)
%%   * Line spacing for body text: 
%%       doublespacing/onehalfspacing 
%%                              (Default: doublespacing)
%%   * Hypertext in PDF
%%       nohyper/hyper          (Default: hyper)
%%   * Copyright Page
%%       copyright              (Default: null for no copyright page)
%%
%% LaTeX2e Document Class Options:
%%    Acceptable options pertaining to the 
%%      requirements of the "Guidelines"
%%
%%   * Font Size: 
%%      12/11/10 pt            (Default: 12pt - altered from report)
%%   * Printing Sides:
%%      oneside/twoside        (Default: oneside)
%%   * Page Openning:
%%      openany/openright      (Default: openany for oneside 
%%                                              - altered from report)
%%                             (         openright for twoside 
%%                                              - altered from report)
%%
%% Thesis Class Micros and Commands (Preamble only):
%%    \degree{...}             (Required for master/other. Default: 
%%                              Master of Computer Science - Research)
%%                             (Not used for phd)
%%       Specify the name of the degree
%%    \unit{...}               (Required. Default: School of Computer
%%                                   Science and Software Engineering)
%%       Specify the name of the academic unit.
%%    \faculty{...}            (Required. Default: Faculty of 
%%                                                        Informatics)
%%       Specify the name of the faculty.
%%    \degreeHeld{...}         (Optional. Default: null)
%%       Specify the degrees held, that will appear under your name 
%%         on the title page
%%    \submissionDate{...}{...}{...}
%%                             (Required. Default: The 1st Fools' Day)
%%       Specify the date of graduation
%%    \keywords{...}           (Required. Default: null)
%%       Keywords to appear on the Abstract page
%%    \dedication{...}         (Optional. Default: null)
%%       Recipients to appear on the Dedication page
%% 
%%    \dedicationtrue          (Optional)
%%       Turn on the dedication page
%%    \noListOfTables          (Optional)
%%       Turn off the List of Tables
%%    \noListOfFigures         (Optional)
%%       Turn off the List of Fifures
%%
%% Thesis Class Environments
%%    \begin{abstract} ... end{abstract}
%%                             (Required)
%%       Produce the abstract page
%%    \begin{acknowledgements} ... end{acknowledgements}
%%                             (Everybody has one)
%%       Produce the acknowledgements page
%%
%% The following class and packages are loaded:
%%
%%   Any customisation should be done through them if possible, 
%%     direct access to TeX is discouraged to maintain compatibility.
%%     
%%   Class users can use options and commands from these packages  
%%     to alter the document design to suit specific needs.
%%
%%     graphicx                         %   Manaul: http://www.ctan.org/tex-archive/macros/latex/required/graphics/grfguide.pdf
%%     fancyhdr                         % Required instalation with MikTeX basic installation
%%                                      %   Manual: http://www.tex.ac.uk/tex-archive/macros/latex/contrib/fancyhdr/fancyhdr.pdf
%%     hyperref (if hyper)              %   Manual: ftp://tug.ctan.org/pub/tex-archive/macros/latex/contrib/hyperref/doc/manual.pdf
%%
%%   Classes for internal use:
%%
%%     setspace                         % Required instalation with MikTeX basic installation
%%     nextpage (if twoside/openright)  % Required instalation with MikTeX basic installation
%%     geometry                         %   Manual: ftp://tug.ctan.org/pub/tex-archive/macros/latex/contrib/geometry/manual.pdf
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% INFORMATION for potential authors who may  contribute to bugfixes 
%%                                   or further feature developments
%%                       and hackers who may adapt it for other uses
%%
%% In order to maintain compatibility with other packages and
%%   accessability through LaTeX2e and future versions' interfaces, 
%%   LaTeX2e package and classs programming guidelines are followed
%%   to create a robust and protable class, which provents it from 
%%   clashing with the kernel, other packages or future updates.
%% 
%% Info on LaTeX2e classs and package programming can be found:
%%
%%   * "LaTeX2e for Class and Package Writers" by The LaTeX3 
%%     Project, http://www.latex-project.org/guides/clsguide.pdf.
%%   * "LaTeX Programming", Appendix D, "Guide to LaTeX", 4th Ed, 
%%     by H Kopka and P. Daly, Addison-Wesley, 2004
%%   * "A LaTeX Overview for Preamble, Package, and Class Writers", 
%%     Appendix A, "The LaTeX Companion", 2nd Ed, Addison-Wesley, 2004
%%     
%% Notes:
%%
%%   * Do not cut-n-paste from other thesis classes and packages. 
%%     Most of them were created before LaTeX2e time and took very
%%     different designs and approaches from this class, most of which  
%%     have programmed at the TeX level or used obsolete commands or 
%%     converted from legacy code with mixed commands, which makes 
%%     it unreliable to work with LaTeX2e packages. Please make 
%%     an effort to find the way to implement it with LaTeX2e if you 
%%     like some features in other pre-LaTeX2e codes.
%%
%%     Most relevent to this class is the way to set headers and page 
%%     layout. DO NOT directly set them from TeX commands. Use 
%%     commands provided by LaTeX2e packages and allow compatibility.
%%
%%  *  Programming at LaTeX2e level: As designed for LaTeX2e, various  
%%     packages available to LaTeX2e have been employed to accomplish  
%%     various taskes. Avoid programming at the TeX level. Take 
%%     advantages of LaTeX2e packages to create robust user-defined 
%%     micros and commands at high-level whenever possible and do not
%%     reinvent the wheel. Do not use undocumented commands not found 
%%     in Lamport official books, "LaTeX: A Document Preparation System"
%%
%%     In LaTeX 2.09, package developers had to resort to using 
%%     low-level commands since there was very little support for 
%%     writing .sty files. LaTeX2e provides high-level commands for 
%%     structuring packages and makes it much easier to build classes 
%%     and packages on top of each other. One of the largest differences 
%%     between LaTeX 2.09 and LaTeX2e is in the commands used to write 
%%     packages and classes.
%%
%%  *  EXCLUSIVELY use LaTeX constructs to take advantage of LaTeX's
%%     consistency cheking and portability to future versions of LaTeX.
%%     Primitive TeX commands do not test for possible conflicts with 
%%     other packages. 
%%
%%
%%  *  The following information is found in "LaTeX Programming", 
%%     Appendix D, "Guide to LaTeX", 4th Ed, by H Kopka and P. Daly, 
%%     Addison-Wesley, 2004
%%
%%     - Rule of Thumb: a command with @ IS NOT part of supported LaTeX 
%%       language and its behaviour may change in future releases. 
%%       Use them with care if you can not avoid. 
%%
%%         Use:                   Do Not Use:
%%            \newcommand           \def
%%            \renewcommand
%%            \newenvironment       \myenv...\endmyenv
%%            \renewenvironment
%%            \setlength
%%            \newlength
%%            \sbox,\mbox,\parbox   \setbox,\hbox,\vbox
%%            \Package(Class)Error(Warning)
%%                                  \@latexerr, \@warning 
%%         
%%     - Use current LaTeX2e commands: Avoid using obsolete commands
%%
%%         Use:                   Do Not Use:
%%            NFSS, eg. \textbf     TeX 2 letter declaration 
%                                     eg. \bf
%%                     
%%     - Useful Safe Commands
%%
%%       LaTeX Internal:
%%         \@namedef{cmd}{def}
%%         \@nameuse{cmd}
%%         \@ifdefined{cmd}{true}{false}
%%         \@ifnextcharchar{true}{false}
%%         \@ifstar{true}{false}
%%         \@for \obj := \list \do {cmds}
%%     
%%       TeX:                      LaTeX:
%%         \newif\ifflag         =  \newboolean{flag}
%%         \flagtrue             =  \setboolean{flag}{true}
%%         \flagfalse            =  \setboolean{flag}{false}
%%         \ifflag.. \else..\fi  =  \ifthenelse{\boolean{flag}{..}{..}
%%         \ifcase num text_0 \or text_1 \or ... \fi
%%         \endfile
%%                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%% IDENTIFICATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{UoWthesis}[2007/03/30 v1.0a,  
University of Wollongong Thesis Class, by Lei Ye]
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%% INITIAL CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%
%%%%% General (configurable) parameters for a thesis
%%
%%     Default values are provided
%%
%
%% Degree/academic unit{department,school}(unit)/faculty
\newcommand{\@degree}{Master of Computer Science - Research}
\newcommand{\degree}[1]{\renewcommand{\@degree}{#1}}
%
\newcommand{\@unit}{School of Computer Science and Software Engineering}
\newcommand{\unit}[1]{\renewcommand{\@unit}{#1}}
%
\newcommand{\@faculty}{Faculty of Informatics}
\newcommand{\faculty}[1]{\renewcommand{\@faculty}{#1}}
%
%% Degrees held
\newcommand{\@degreeHeld}{}
\newcommand{\degreeHeld}[1]{\renewcommand{\@degreeHeld}{#1}}
%
%% Univeristy name and logo
%%   Not supposed to be changed. 
%%   The presence of uni logo (***.png) is used as 
%%     the condition to include the logo,
%%     otherwise a thick rule will be printed in the place of the logo.
%%   The logo graphics will be stretched to \textlength  
%%   To produce output file with uni logo in DVI/PS, the logo in 
%%     eps format (***.eps) is to be provided along with png verison. 
%%     Do not remove the PNG file that is used as the condition test
%%   Hackers can change these values for other universities
%%     Please DO NOT forget save-as-ing the file with a new filename
%%     if you change the university name !!!
\newcommand{\@uni}{University of Wollongong}
\newcommand{\@unilogo}{UoWlogo}  %(filename without ext)
%
%%
%% Certificaiton text
%%   Not supposed to be changed
%%
%%   Dear hackers, this may need to be changed for your university
%%
\newcommand{\@certificatetext}{\noindent I, \@author, declare that this thesis, submitted in \ifpartial partial \fi fulfilment of the requirements for the award of \ifphd Doctor of Philosophy\else \@degree \fi , in the \@unit, \@faculty, \@uni, is wholly my own work unless otherwise referenced or acknowledged. The document has not been submitted for qualifications at any other academic institution. \par}
%
%%
%%%%% Layout parameters
%%
%%   Not supposed to be changed
%%
%%	 To meet the margin requirements, pp.7-8, Section 2.2, Guidelines
%%    
%%     left-hand > 40mm (1.57in)
%%     right-hand> 20mm (0.79in)
%%     top       > 30mm (1.18in)
%%     bottom    > 20mm (0.79in)
%%
%%   The following values for geometry are carefully selected for a4paper
%%     They are tricky for top and bottom sides:
%%         top    includes \headheight + headsep
%%         bottom includes \footskip
%%  
\newcommand{\@leftside}{36mm}   % there is a offset at the lefthand
\newcommand{\@rightside}{20mm}
\newcommand{\@topside}{1.65in}
\newcommand{\@bottomside}{1.25in}
%
%
%%%%%%%%%% DO NOT ALTER BELOW THIS LINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      unless you know what you are doing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%
%%%%% Micros 
%%
%
%% Submission Date, appears on title page and certification
\newcommand{\@submissionDay}{1}        % the default is the April Fools' Day, 1392,
\newcommand{\@submissionMonth}{April}  % considered as its origin
\newcommand{\@submissionYear}{1392}
\newcommand{\submissionDate}[3]{%    
  \renewcommand{\@submissionDay}{#1}%
  \renewcommand{\@submissionMonth}{#2}%
  \renewcommand{\@submissionYear}{#3}%
}
%
%% keywords
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}
%
%% dedication
\newcommand{\@dedication}{}
\newcommand{\dedication}[1]{\renewcommand{\@dedication}{#1}}
%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%% DECLARATION OF OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Invalid options - normally used in report.cls and others, but not here:
%%
%% page title
\DeclareOption{titlepage}{\ClassWarning{Thesis Class}{Option 'titlepage': Title page always generated. Option ignored.}}
\DeclareOption{notitlepage}{\ClassWarning{Thesis Class}{Option 'notitlepage': Not available for thesis.}}
%% paper size
\DeclareOption{a4paper}{\ClassWarning{Thesis Class}{Option 'a4paper': Mandatory requirement. Option ignored.}}
\DeclareOption{legalpaper}{\ClassWarning{Thesis Class}{Option 'legalpaper': Not available for thesis.}}
\DeclareOption{a5paper}{\ClassWarning{Thesis Class}{Option 'a5paper': Not available for thesis.}}
\DeclareOption{executivepaper}{\ClassWarning{Thesis Class}{Option 'executivepaper': Not available for thesis.}}
\DeclareOption{b5paper}{\ClassWarning{Thesis Class}{Option 'b5paper': Not available for thesis.}}
\DeclareOption{letterpaper}{\ClassWarning{Thesis Class}{Option 'letterpaper': Not available for thesis.}}
\DeclareOption{landscape}{\ClassWarning{Thesis Class}{Option 'landscape': Not available for thesis.}}
%
%% Determine the degree program: PhD or Masters by Research or others
\newif\ifphd
\DeclareOption{phd}{\phdtrue}
\DeclareOption{master}{\phdfalse \partialtrue}
\DeclareOption{other}{\phdfalse \partialtrue}
\ExecuteOptions{phd}               %Default: phd
%
%% Set condition for "partial" fulfilment on title
%%   page and certification
%%   "full" does nothing but omits the word "partial"
\newif\ifpartial
\DeclareOption{partial}{\partialtrue}
\DeclareOption{full}{\partialfalse}
\ExecuteOptions{full}               %Default: full
%
%% Define a parameter for fontsize to set default to 12pt
%%   report default was 10pt
%%   using \PassOptionsToClass and \ExecuteOptions{12pt} did not work
\newcommand\@fontSize{}
\DeclareOption{10pt}{\renewcommand\@fontSize{10pt}}
\DeclareOption{11pt}{\renewcommand\@fontSize{11pt}}
\DeclareOption{12pt}{\renewcommand\@fontSize{12pt}}
\ExecuteOptions{12pt}
%
%% Set line spacing
\newif\ifdouble
\DeclareOption{doublespacing}{\doubletrue}
\DeclareOption{onehalfspacing}{\doublefalse}
\ExecuteOptions{doublespacing}     %Default: doublespacing
%
%% Determine whether hyperlinks would be created in PDF
\newif\ifhyper
\DeclareOption{hyper}{\hypertrue}
\DeclareOption{nohyper}{\hyperfalse}
\ExecuteOptions{hyper}             %Default: hyper
%
%% Determine whether the copyright page would be created
%%   copyright page is not required by the "Guidelines"
%%
\newif\ifcopyright
\DeclareOption{copyright}{\copyrighttrue}
%
%% Determine whether openright for twosided priting
%%   defualt: openright for twoside
%%            openany   for oneside
%%   defaults different from report class defaults
\newif\ifopentwosideright
%% Use openright when two side printed
\DeclareOption{twoside}{%
  \opentwosiderighttrue \PassOptionsToClass{twoside, openright}{report}%
}
\DeclareOption{openany}{%
	 \opentwosiderightfalse \PassOptionsToClass{openany}{report}%
}
%
%%
%%%%% Switches 
%%
%
%% Dedication page is not required by the "Guidelines"
%%
\newif\ifdedication
\dedicationfalse      %Default: no dedication page
%
%% List of Figures/Tables are required by the "Guidelines"
%%   turn them off if no figures/tables in the thesis
\newif\ifListOfFigures
\ListOfFigurestrue    %Default: create List of Figures
\newif\ifListOfTables
\ListOfTablestrue     %Default: create List of Tables
%
%% Generate List of Figures/Tablles by default
%%
\newcommand{\noListOfTables}{\ListOfTablesfalse}
\newcommand{\noListOfFigures}{\ListOfFiguresfalse}
%
%% Pass the rest of options (not captured by \DeclareOption{})
%%   to report class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}%
}
%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%% EXECUTION OF OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%
%% Golobal options from \docoumentclass[...] will be automatically 
%%   passed to all required packages
\ProcessOptions
%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%% PACKAGE LOADING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
%%%%% Loading standard document report class
%%
%%    a4paper - The paper size has been forced to ISO A4 
%%              to meet the requirement, p.7, Section 2.2, the Guidelines
%
%% The papersize option will be overwritten by the option passed down  
%%   from the current class, otheroptions (eg. fontsize) will not. 
%% Specifying a letterpaper in \documentclass turned out to be fine, 
%%   thanks to the way the layout is set in this class
\LoadClass[a4paper, \@fontSize]{report}[2004/02/16]
%
%%
%%%%% Loading required packages
%%
%
%% To set the page layout
%%
%%     in goemetry:
%%       paperwidth  = left + width  + right
%%       paperheight = top  + height + bottom
%%         top    includes \headheight + headsep
%%         bottom includes \footskip
%%
%% The headheight must not < 14.49998pt for fancyhdr
%% marginparwidth=-1pt Please do not use margin notes
%%
\RequirePackage[left=\@leftside, right=\@rightside, top=\@topside, bottom=\@bottomside, headheight=14.5pt, marginparwidth=-1pt]{geometry}[2002/07/08] 
%
\newcommand{\@setLongPage}{%
	%\geometry{top=.75in}   %doesnt work here
	\setlength\topmargin{-.3in}    % move the top of text to the top of the head roughly 
	                               %                      = remove the headheight
	\enlargethispage{1.8cm}%
}%
\newcommand{\@setNormalPage}{%
  \setlength\topmargin{0in}      % set it back to top=\@topside 
}
%
%% To produce fancy headers
%%   See \frontmatter
\RequirePackage{fancyhdr}
%
%% For setting line space
\RequirePackage{setspace}[2000/12/01]
%
% required for loading the University logo
\RequirePackage{graphicx}[1999/02/16]      
%
%% To create a blank verso page for recto-verso (twoside/openright) printing
\ifopentwosideright%
  \RequirePackage{nextpage}[2000/02/20]%
  \renewcommand\cleardoublepage{\cleartooddpage[%
       \thispagestyle{empty}%
       \vfill%
       \begin{center}%
         (INTENTIONALLY BLANK)%
       \end{center}%
       \vfill]}%
\else%
  \renewcommand\cleardoublepage{\clearpage}      % if not twoside open right, clear one page only
\fi
%
%% To produce hypertext version of PDF;
%%
%%   loaded as the last package
%%   "plainpages" option false is used to avoid duplicate page identifiers
%%
%% "colorlinks" will be grayed when printed
%\ifhyper\RequirePackage[plainpages=false, colorlinks, bookmarks, bookmarksnumbered, breaklinks, linkcolor={blue}]{hyperref}\fi 
\ifhyper\RequirePackage[plainpages=false, pdfpagelabels, bookmarks, bookmarksnumbered, breaklinks]{hyperref}[2003/11/30]\fi
%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%% MAIN CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%
%%%%% Configuratons
%%
%
%% setting section numbering depth, 10 should be sufficient
\setcounter{secnumdepth}{10}
%%
%% Remove page number at the footer of \chapter pages, if you like
%\let\ps@plain=\ps@empty  
%
%%
%%
%%%%% Renew command: maketitle
%%
%%      Formated to meet the requirements
%%        Appendix I, Guidelines
\renewcommand{\maketitle}{%
  \thispagestyle{empty}%
  \@setLongPage%
  \IfFileExists{\@unilogo .png}{%
    \noindent\includegraphics[width=\textwidth]{\@unilogo}}%
    {\ClassWarning{Thesis Class}{The University logo file: \@unilogo .png is not present. %
      A rule is printed in the place of the logo.}%
     \rule{\linewidth}{2.5pt}}%
  \vspace{1.5cm}%
  \begin{center}%
     \Large \MakeUppercase{\textbf{\@title}}%
  \end{center}%
  \vfill%
  \begin{center}%
    A \ifphd Dissertation \else Thesis \fi Submitted in \ifpartial Partial \fi Fulfilment of \\%
    the Requirements for the Award of the Degree of \\%
    \vfill%
    \Large \ifphd Doctor of Philosophy \else \@degree \fi \\%
    \vfill%
    \normalsize%
    from\\%
    \vfill%
    \large \MakeUppercase{\@uni}%
  \end{center}%
  \vfill%
  \begin{center}%
    by\\%
    \vfill%
    \large \@author \\[0.2cm]%
    %%v1.0a A space "\ " added to handle empty \@degreeHeld that caused "no line here to end" error
    %\normalsize {\itshape\@degreeHeld}\\%
    \normalsize {\itshape\@degreeHeld}\ \\%
    \vfill%
    \@unit \\%
    \@faculty \\[0.5cm]%
    \@submissionYear%  
  \end{center}%     
  \rule\linewidth{1.5pt}% 
	\clearpage%
	\@setNormalPage%
}
%
%%
%%%%% New command: makecertificationpage 
%%
%%      Formatted to meet the requirements
%%        Appendix J, Guidelines
\newcommand{\@makecertificationpage}{%
  \thispagestyle{empty}%
  \begin{center}%
    \null\vspace{3cm}%
    \Large \textbf{CERTIFICATION}%
    \vspace{1cm}%
  \end{center}%
        
	\@certificatetext%
	
  \vspace{2.5cm}%
  \noindent\underline{~(Signature~~Required)~}\\[0.2cm]%
  \noindent\@author\\%
  \noindent\@submissionDay\ \@submissionMonth\ \@submissionYear %
  %\today%
  \cleardoublepage%
}
%
%%
%%%%% Renew abstract environment
%%
%%      Abstract is formated to meet the requriements
%%        
%%        p.18, Section 3.8, Guidelines
%%
\renewenvironment{abstract}{%
  \newpage%
  \@setLongPage%
  \pagestyle{empty}%
  \begin{center}%
      \large \textsc{\@title} \\%
      \vspace{0.3cm} %
      \normalsize \@author\\%
      \vspace{0.3cm}%
      A Thesis for \@degree \\%
      \vspace{0.2cm}%  
      \@unit \\%
      %\@faculty \\%
      \@uni \\%
      %\vspace{0.5cm}%
      \section*{ABSTRACT}    % placeholder for hypertext bookmark to work
      \addtocontents{toc}{\vspace{10pt}}  % add space after the LOT/LOF
 	    \addcontentsline{toc}{section}{ABSTRACT}% 
  \end{center}%
}{%
	\vfill%
	\begin{flushleft}%
    \textbf{KEYWORDS:}\ \ \@keywords%
  \end{flushleft}%
  \@setNormalPage%
  \cleardoublepage%
}
%
%%
%%%%% New command: makecopyrightpage
%%
%%      The IP right does not depend on whether this page is present
%%      See University policy on IP
\newcommand\@makecopyrightpage{%
	\newpage%
	\begin{doublespace}   % use pagacke setspace
	  \begin{center}%
	    \null\vfill%
	    \copyright\ Copyright\ \@submissionYear \\%
	    by\\%
	    \@author \\%
	    ALL RIGHTS RESERVED\\%
	    \vfill\null%
	  \end{center}%
	\end{doublespace}%
	\cleardoublepage%
}
%
%%
%%%%% New command: makededicationpage
%%
\newcommand\@makededicationpage{%
  \thispagestyle{empty}%
  \null\vfill%
  \begin{flushright}%
    \Large \itshape \textbf{Dedicated to}\hspace{2cm} \null\\[1cm]%
    \large \@dedication%
  \end{flushright}%
  \vfill\null%
  \cleardoublepage%
}
%
%%
%%%%% New envoronment: acknowledgements
%%
\newenvironment{acknowledgements}{%
  \pagestyle{plain}%
  \chapter*{Acknowledgements}  % To have the advantage of chapter headings
  \section*{}                  % placeholder for hypertext bookmark to work
	\addcontentsline{toc}{section}{Acknowledgements}%
  \vspace{-1cm}%
}{%
  \cleardoublepage%
}
%
%%
%%%%% Change the predefined heading text 
%%
%
%% Set the new title for \tableofcontents
%%    default was Contents
\renewcommand{\contentsname}{Table of Contents}
%
%% Set the new title for \bibliography
%%    default was Bibliography
\renewcommand{\bibname}{References}
%
%% Add a reference into TOC
\let\@ldbibliography\bibliography
\renewcommand{\bibliography}[1]{\@ldbibliography{#1} \addcontentsline{toc}{chapter}{\bibname}}
%
%% Good news for hackers
%%   To produce a thesis in a language other than English,
%%     the following preprogrammed heading text must be redefined, 
%%     plus other English words on title, copyright, certifiction, 
%%     dedication and blank pages
%% 
%%   eg.
%%     \providecomamnd*{\chaptername}{}
%%     \renewcommand*{\chapteranme}{Chpitre}
%% 
%%  \tableofcontents     -> \contentsname{Contents}
%%  \listoffigures       -> \listfigurename{List of Figures}
%%  \listoftables        -> \listtablename{List of Tables}
%%  \thebibliography     -> \bibname{Bibliography}
%%  \theindex            -> \indexname{Index}
%%
%%  \part                -> \partname{Part}
%%  \chapter             -> \chaptername{Chapter}
%%  \appendix            -> \appendixname{Appendix}
%%
%%  \begin{abstract}     -> \abstractname{Abstract}
%%  \begin{acknowledge}  -> \acknowledgename{Acknowledgments}
%%  \begin{figure}       -> \figurename{Figure}
%%  \begin{table}        -> \tablename{Table}
%
%%
%%%%% New command: frontmatter 
%%
%%      to create frontmatter
%%      CAUTION: the command frontmatter is also defined by the book class
%%               but not by the report class
%%
\newcommand\frontmatter{%
	%
	%% Setup PDF description
	%% This can not be put after maketitle, or the \@author etc 
	%%   will be blank, affected by clear{double}page
	\ifhyper\hypersetup{%
  	pdfauthor={\@author},%
  	pdftitle={\@title},%
  	pdfkeywords={\@keywords}}%
	\fi%
	%
	\pagestyle{empty}%
	\singlespacing%
	%% Use different page numbering to avoid warnings 
	%%   for duplicated page idnetifier from hyperref package
	\pagenumbering{alph}%  
	%
	\maketitle                 % Requried: Title Page
	%
	\ifcopyright \@makecopyrightpage \fi%
	\cleardoublepage%
	%
	\@makecertificationpage    % Required: Certification
	%
	\ifdedication \@makededicationpage \fi%  			
	%
	\pagestyle{headings}%
	\pagenumbering{roman}%
	\tableofcontents           % Required: Table of Contents
  %% if no \noListOfTables
	\ifListOfTables{%
  	\listoftables            % Required: List of Tables
  	\addcontentsline{toc}{section}{List of Tables}%
	}\fi%
  %% if no \noListOfFugures
	\ifListOfFigures{%
  	\listoffigures           % Required: List of Figures, Illustrations
  	\addcontentsline{toc}{section}{List of Figures/Illustrations}%
	}\fi%
	\cleardoublepage%
	%
	% not implemented: List of Special Names or Abbreviations                       
	                           % Required: List of Special Names or Abbreviations
 	                           %           Not everybody has it
} % end of frontmatter
%
%%
%%%%% New command: mainmatter
%%
%%      to set up style etc for the body text
%% 
\newcommand\mainmatter{%
  %
  \ifdouble\doublespacing \else\onehalfspacing\fi%
  \pagenumbering{arabic}%
  %
	%% Set fancy header for body pages
	\pagestyle{fancy}%
	%% Configure the header fields
  %%
  %% Stop changing all chapter and section in header to uppercase
  %%
  %% the following are suggested by Piet van Oostrum, the author of 
  %%   fancyhdr, in the doc "Page layout in LaTeX", March 2, 2004,  
  %%   found at http://www.tex.ac.uk/tex-archive/macros/latex/contrib/fancyhdr/.
  %%   But they didn't work. They caused errors.
	%%
	%% 1. p.9 
	%%    \renewcommand{\sectionmark}[1]{\markright{\thesection. \ #1}}
	%% 2. p.10 
  %%    \renewcommand{\chaptermark}[1]{%
  %%      \markboth{\chaptername
  %%      \ \thechapter.\ #1}{}}
  %%
  %% the following, no errors but no effect either
  %% 3. p.6
  %%    \lhead{\nouppercase{\leftmark}}
  %% I found the following working
	\let\@lmk\leftmark
	\renewcommand{\leftmark}{\textsl{\nouppercase\@lmk}}
	\let\@rmk\rightmark
	\renewcommand{\rightmark}{\textsl{\nouppercase\@rmk}}
  %% great!
	%
	\fancyfoot{}  % clear footer
	%
	\if@twoside{    % No panic! @twoside is a LaTeX switch, not TeX one as it appears to be
  	%%
  	%% \markboth{main-mark}{sub-mark}
  	%%   \leftmark <- main-mark
  	%%   \rightmark <- sub-mark
  	%% if main-mark <- \chapter or sub-mark <- \section
  	%% hence the following
  	%%
  	\fancyhead[RO,LE]{\thepage}%
  	\fancyhead[RE]{\leftmark}  % Chapter title
  	\fancyhead[LO]{\rightmark} % Section title  
	}\else{%
		\fancyhead[R]{\thepage}%
  	%\fancyhead[L]{\leftmark}  % Chapter title
  	\fancyhead[L]{\rightmark}  % Section title
	}\fi%
} % end of mainmatter
%
%%
\endinput  %Job done! Holiday time!!
%
%%%%% End of Class Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


