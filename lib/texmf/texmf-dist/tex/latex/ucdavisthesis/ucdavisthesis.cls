%%
%% This is file `ucdavisthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ucdavisthesis.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2007, 2008, 2009, 2010, 2013, 2016 by Ryan Scott
%% 
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
\ProvidesClass{ucdavisthesis}
    [2016/04/23 v1.3 UCDavis thesis class]
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\RequirePackage{ifthen}
\newcommand\@ptsize{}
\newif\if@openright    % Set to true if openright option set
\newif\if@draft        % Set to true if draft option set
\@draftfalse
\newif\if@draftcls     % Set to true if draft class option set
\@draftclsfalse
\newif\if@figures
\@figurestrue          % Make List of Figures
\newif\if@tables
\@tablestrue           % Make List of Tables
\newif\if@prelimpages   % Set to false after producing preliminary pages
\@prelimpagestrue
\def\@title{NO TITLE!?!}
\def\@author{NO AUTHOR!?!}
\def\@authordegrees{NO DEGREES!?!}
\def\@memberone{ }\def\@membertwo{ }\def\@memberthree{ }\def\@memberfour{ }\def\@memberfive{ }
\def\@titlesize{\large}
\renewcommand{\title}[1]{\def\@title{#1}}
\renewcommand{\author}[1]{\def\@author{#1}}
\newcommand{\titlesize}[1]{\def\@titlesize{#1}}
\newcommand{\authordegrees}[1]{\def\@authordegrees{#1}}
\newcommand{\committee}[5]{\def\@memberone{#1}\def\@membertwo{#2}\def\@memberthree{#3}\def\@memberfour{#4}\def\@memberfive{#5}}
\def\@officialmajor{NO OFFICIAL MAJOR!?!}
\newcommand{\officialmajor}[1]{\def\@officialmajor{#1}}
\def\@graduateprogram{NO GRADUATE PROGRAM!?!}
\newcommand{\graduateprogram}[1]{\def\@graduateprogram{#1}}
\newcommand{\thesis}[1]
   {\def\@thesisname{thesis}
    \def\@Thesisname{Thesis}
    \def\@degreename{#1}
   }
\newcommand{\dissertation}[1]
   {\def\@thesisname{dissertation}
    \def\@Thesisname{Dissertation}
    \def\@degreename{#1}
   }
\dissertation{Doctor of Philosophy} % default
\def\@degreeyear{\number\year} % default is current year
\def\@degreemonth{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi}
\def\@copyrightyear{\number\year} % default is current year
\newif\if@cyrset
\@cyrsetfalse
\newcommand{\degreeyear}[1]
   {\def\@degreeyear{#1}\if@cyrset\else\def\@copyrightyear{#1}\fi}
\newcommand{\degreemonth}[1]{\def\@degreemonth{#1}}
\newcommand{\copyrightyear}[1]{\def\@copyrightyear{#1}\@cyrsettrue}
\DeclareOption{PhD}{}      % default -- nothing more to do
\DeclareOption{DEngr}{\dissertation{Doctor of Engineering}}
\DeclareOption{MA}{\thesis{Master of Arts}}
\DeclareOption{MS}{\thesis{Master of Science}}
\DeclareOption{ME}{\thesis{Master of Engineering}}
\DeclareOption{10pt}{\renewcommand\@ptsize{10}}
\DeclareOption{11pt}{\renewcommand\@ptsize{11}}
\DeclareOption{12pt}{\renewcommand\@ptsize{12}} % default size
\DeclareOption{13pt}{\renewcommand\@ptsize{13}}
\DeclareOption{nofigureslist}{\@figuresfalse}
\DeclareOption{notableslist}{\@tablesfalse}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\def\@singlespacing{1.0}
\def\@doublespacing{1.5} % see LaTeX manual for explanation of value
\let\@spacing=\@doublespacing
\newcommand{\@titlespacing}{1.2} % Spacing to use in chapter and section titles
\DeclareOption{single}{\let\@spacing=\@singlespacing%
                       \let\@titlespacing=\@singlespacing}
\DeclareOption{double}{\let\@spacing=\@doublespacing}
\newcommand{\setstretch}[1]{%
  \def\baselinestretch{#1}%
  \@currsize}%
\newcommand{\SetSinglespace}[1]{%
  \def\setspace@singlespace{#1}}
\SetSinglespace{1}
\newcommand{\singlespacing}{%
  \setstretch {\setspace@singlespace}%  normally 1
  \vskip \baselineskip} % Correction for coming into |\singlespacing|
\def\@setsize#1#2#3#4{%
  \@nomath#1%
  \let\@currsize#1%
  \baselineskip #2%
  \baselineskip \baselinestretch\baselineskip
  \parskip \baselinestretch\parskip
  \setbox\strutbox \hbox{%
    \vrule height.7\baselineskip
           depth.3\baselineskip
           width\z@}%
  \skip\footins \baselinestretch\skip\footins
  \normalbaselineskip\baselineskip#3#4}
\DeclareOption{draft}{\setlength{\overfullrule}{5pt}\@drafttrue\@draftclstrue}
\DeclareOption{draftcls}{\setlength{\overfullrule}{5pt}\@draftfalse\@draftclstrue}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{final}{\setlength{\overfullrule}{0pt}\@draftfalse\@draftclsfalse}
\def\@chapternamesize{\Huge}
\newcommand{\chapternamesize}[1]{\def\@chapternamesize{#1}}
\def\@chapternamefont{\bfseries}
\newcommand{\chapternamefont}[1]{\def\@chapternamefont{#1}}
\def\@chaptertitlesize{\huge}
\newcommand{\chaptertitlesize}[1]{\def\@chaptertitlesize{#1}}
\def\@chaptertitlefont{\bfseries}
\newcommand{\chaptertitlefont}[1]{\def\@chaptertitlefont{#1}}
\def\@secfontsize{\bfseries\Large}
\newcommand{\secfontsize}[1]{\def\@secfontsize{#1}}
\def\@subsecfontsize{\bfseries\large}
\newcommand{\subsecfontsize}[1]{\def\@subsecfontsize{#1}}
\def\@ssubsecfontsize{\bfseries\normalsize}
\newcommand{\ssubsecfontsize}[1]{\def\@ssubsecfontsize{#1}}
\newboolean{hyphenatetitles}
\setboolean{hyphenatetitles}{true}
\DeclareOption{nohyphenatetitles}{\setboolean{hyphenatetitles}{false}}
\DeclareOption{hyphenatetitles}{\setboolean{hyphenatetitles}{true}}
\ExecuteOptions{double,12pt,oneside,final,openany}
\ProcessOptions\relax
\renewcommand{\cleardoublepage}{\clearpage%
  \if@twoside
    \ifodd\c@page
    \else
      \null\thispagestyle{empty}\newpage% make a blank page
    \fi
  \fi}
\setlength{\paperheight}{11in}
\setlength{\paperwidth}{8.5in}
\if@twoside % twoside is non-conforming to UC format
  \setlength{\oddsidemargin}{0.1in}  % these are added to
  \setlength{\evensidemargin}{0.1in} % LaTeX's 1 inch left margin
\else % Note that \oddsidemargin = \evensidemargin
  \setlength{\oddsidemargin}{0.1in}  % these are added to LaTeX's
  \setlength{\evensidemargin}{0.1in} % 1 inch left margin.
\fi
\setlength{\topmargin}{-0.6in}
\setlength{\headheight}{0.2in}
\setlength{\headsep}{0.5in}
\setlength{\footskip}{0.6in}
\setlength{\textheight}{8.8in}
\setlength{\textwidth}{6.3in}
\input{ucdthesis\@ptsize.clo} % \@ptsize is determined by the class option
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{titlepage}
    {%
      \newpage
      \thispagestyle{prelim}%
    }%
    {\newpage
     \if@twoside\else
     \fi
    }
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\part{%
  \if@openright
    \cleardoublepage  % Starts new page.
  \else
    \clearpage
  \fi
  \thispagestyle{thshead}   % Page style of part page is 'thshead'
    \@tempswafalse          % @tempswa := false
  \null\vfil                % Add fil glue to center title
  \bgroup  \centering       % BEGIN centering
  \secdef\@part\@spart}
\def\@part[#1]#2{\ifnum \c@secnumdepth >-2\relax  % IF secnumdepth > -2
     \refstepcounter{part}%                    %   THEN step part counter
     \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}% add toc line
  \else                      %   ELSE add unnumbered line
     \addcontentsline{toc}{part}{#1}%
  \fi        % End if
  \markboth{}{}
  \ifnum \c@secnumdepth >-2\relax  % IF secnumdepth > -2
    \normalsize\bfseries Part\thepart   %  THEN Print 'Part' and number
    \par                                %  in \normalsize bold.
    \vskip 20\p@              % Add space before title.
  \fi
  \huge\bfseries #2\par\@endpart}   % Print Title in \huge bold.
\def\@spart#1{\normalsize\bfseries #1\par\@endpart} %
\def\@endpart{\vfil\newpage              % End page with 1fil glue.
  \if@twoside
    \if@openright
      \null
      \thispagestyle{empty}%
      \newpage
    \fi
   \fi
   \if@tempswa                % IF @tempswa = true
     \twocolumn               % THEN \twocolumn
   \fi}
\newcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi  % Starts new page.
   \if@prelimpages          % Are we on preliminary pages?
     \thispagestyle{prelim} % if yes, format for preliminary pages
   \else
     \thispagestyle{thshead} % Otherwise it is the main text
   \fi
   \global\@topnum\z@   % Prevents figures at top of first page in chapter.
   \@afterindentfalse            % Suppress indent in first paragraph,
   \secdef\@chapter\@schapter}   % change to \@afterindenttrue to indent.
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}%
              {\protect\numberline{\thechapter}#1}%
      \else
        \addcontentsline{toc}{chapter}{#1}%
      \fi
   \chaptermark{#1}%
   \addtocontents{lof}{\protect\addvspace{10\p@}}% Adds between-chapter space
   \addtocontents{lot}{\protect\addvspace{10\p@}}% to lists of figs & tables.
    \@makechapterhead{#2}%
    \@afterheading}    % Routine called after chapter and section heading.
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\renewcommand\baselinestretch{\@titlespacing}% set spacing for chapter title
   \parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \@chapternamefont\@chapternamesize \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \@chaptertitlefont\@chaptertitlesize #1\par\nobreak
    \vskip 40\p@
  }\renewcommand\baselinestretch{\@spacing}\@normalsize}% return to \@spacing
\def\@schapter#1{\@makeschapterhead{#1}\@afterheading}
\def\@makeschapterhead#1{%           % Heading for \chapter* command
   \vspace*{-30\p@}%                   % Space at top of page.
   {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \centering \large \scshape%  % Title font.
    #1\par\nobreak            % Title and TeX penalty to prevent page break.
    \vskip 20\p@              % Space between title and text.
  }}
\ifthenelse{\boolean{hyphenatetitles}}{%
    \newcommand{\TitleHyphenation}{}%
    }{%
    \newcommand{\TitleHyphenation}{%
        \pretolerance=10000%
        \hyphenpenalty=200%
        \raggedright}%
    }
\newcommand\section{\@startsection {section}{1}{\z@}%
                    {-2.0ex \@plus -.5ex \@minus -.2ex}%
                    {.75ex \@plus.1ex}%
                    {\normalfont\renewcommand\baselinestretch{\@titlespacing}%
                    \@secfontsize\TitleHyphenation}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                       {-1.5ex\@plus -.5ex \@minus -.2ex}%
                       {.5ex \@plus .1ex}%
                       {\normalfont\renewcommand\baselinestretch{\@titlespacing}%
                       \@subsecfontsize\TitleHyphenation}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                          {-1.0ex\@plus -.3ex \@minus -.1ex}%
                          {.5ex \@plus .1ex}%
                          {\normalfont\renewcommand\baselinestretch{\@titlespacing}%
                          \@ssubsecfontsize\TitleHyphenation}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {.75ex \@plus.2ex \@minus.1ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{4}{\parindent}%
                                       {.75ex \@plus.2ex \@minus .1ex}%
                                       {-1em}%
                                       {\normalfont\normalsize\bfseries}}
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{3}
\newcommand\appendix{\par%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}
\setlength\leftmargini  {2.5em}
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}  % > \labelsep + width of `(m)'
\setlength\leftmarginiii {1.87em} % > \labelsep + width of `vii.'
\setlength\leftmarginiv  {1.7em}  % > \labelsep + width of `M.'
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\parsep 5pt plus 2.5pt minus 1pt
\def\@listI{\leftmargin\leftmargini}
\let\@listi\@listI
\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii\advance\labelwidth-\labelsep
   \topsep 5pt plus 2.5pt minus 1pt
   \parsep 2.5pt plus 1pt minus 1pt
   \itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
    \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
    \topsep 2.5pt plus 1pt minus 1pt
    \parsep \z@ \partopsep 1pt plus 0pt minus 1pt
    \itemsep \topsep}
\def\@listiv{\leftmargin\leftmarginiv
     \labelwidth\leftmarginiv\advance\labelwidth-\labelsep}
\def\@listv{\leftmargin\leftmarginv
     \labelwidth\leftmarginv\advance\labelwidth-\labelsep}
\def\@listvi{\leftmargin\leftmarginvi
     \labelwidth\leftmarginvi\advance\labelwidth-\labelsep}
\newcommand\@pnumwidth{1.75em}
\newcommand\@tocrmarg{2.75em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
    \renewcommand\baselinestretch{\@spacing}\@normalsize\@starttoc{toc}%
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
  \if@figures\chapter*{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
   \addcontentsline{toc}{section}{\listfigurename}%
    \@starttoc{lof}%
  \fi}
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
  \if@tables\chapter*{\listtablename}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \addcontentsline{toc}{section}{\listtablename}%
    \@starttoc{lot}%
  \fi}
\let\l@table\l@figure
%%    \begin{macrocode}
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \@mkboth{\bibname}{\bibname}%
      \renewcommand\baselinestretch{1}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}
            \renewcommand\baselinestretch{\@singlespacing}\@normalsize % enforce single spacing for each entry
      }%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \renewcommand\baselinestretch{\@spacing}\@normalsize % return to original line spacing
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newif\if@restonecol % used to restore one-column format after index
                     %(two column not used outside the index environment)
\newenvironment{theindex}
                {\@restonecoltrue
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\indexname}%
                        {\indexname}%
                \thispagestyle{thshead}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}  % Numbers footnotes within chapters
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\setcounter{topnumber}{4}
\renewcommand\topfraction{.9}
\setcounter{bottomnumber}{4}
\renewcommand\bottomfraction{.7}
\setcounter{totalnumber}{10}
\renewcommand\textfraction{.1}
\renewcommand\floatpagefraction{.66}
\setcounter{dbltopnumber}{4}
\renewcommand\dbltopfraction{.66}
\renewcommand\dblfloatpagefraction{.66}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{6\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \renewcommand{\baselinestretch}{1.0}
  \small
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1. #2}%
  \ifdim \wd\@tempboxa >0.9\hsize%
          \hskip.05\hsize\parbox{0.9\hsize}{#1. #2}%\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \normalsize
  \vskip\belowcaptionskip
  }
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{%
\figurename\nobreakspace\thefigure}% Text with caption figure number
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\mark{{}{}}   % Initializes TeX's marks
\def\ps@prelim{%
  \if@draftcls % If 'draftcls' option
    \if@twoside % If 'twoside' option
      \def\@oddhead{\hfil\textsc{\footnotesize DRAFT \quad\rightmark}}
      \def\@evenhead{\textsc{\footnotesize DRAFT \quad\leftmark\hfil}}
    \else
      \def\@oddhead{\textsc{\footnotesize DRAFT \quad\rightmark\hfil}}
      \let\@evenhead\@oddhead
    \fi
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {{%
         \@chapapp\ \thechapter. \ %
        ##1}}{}}%
    \def\@oddfoot{\hfil\textrm{-\thepage -}\hfil}
    \let\@evenfoot\@oddfoot
  \else
    \def\@oddhead{}
    \def\@evenhead{}
    \def\@oddfoot{\hfil\textrm{-\thepage -}\hfil}
    \let\@evenfoot\@oddfoot
  \fi}
\newlength{\UMIfoliosep}
\setlength{\UMIfoliosep}{0.25in}
\def\ps@thshead{\def\@oddfoot{\hfil\thepage\hfil}%
\def\@evenfoot{\hfil\thepage\hfil}%
\if@twoside % If `twoside' option
  \if@draftcls % If `draftcls' option
    \def\@oddhead{\hbox to\textwidth{% Heading on odd (right) pages.
    {\hfil\textsc{\footnotesize DRAFT \quad\rightmark}\hfil}}}%
    \def\@evenhead{\hbox to\textwidth{% Heading on even (left) pages.
      {\footnotesize DRAFT \quad\leftmark}\hfil}}
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {{%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}
  \else
    \def\@oddhead{\hbox to\textwidth{}}% Heading on odd (right) pages.
    \def\@evenhead{\hbox to\textwidth{}}% Heading on even (left) pages.
  \fi
\else
  \if@draftcls % If 'draft' option
    \def\@oddhead{\hbox to\textwidth{%
    {\textsc{\footnotesize DRAFT \quad\rightmark}\hfil}}}%
    \let\@evenhead\@oddhead
    \def\chaptermark##1{\markright {{\ifnum \c@secnumdepth >\m@ne
         \@chapapp\ \thechapter. \ \fi ##1}}}
  \else
    \def\@oddhead{\hbox to\textwidth{}}%
    \let\@evenhead\@oddhead
  \fi
\fi}
\def\ps@UMIheadings{% UMI Abstract Heading for page 2
\def\@oddfoot{\hfil -\thepage -\hfil}%
\def\@evenfoot{\hfil -\thepage -\hfil}%
\def\@oddhead{\hbox to\textwidth{}}% Header for odd pages
\let\@evenhead\@oddhead} % Even pages same as odd pages
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\@addtoreset {equation}{chapter}% Makes \chapter reset 'equation' counter.
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\acknowledgename{Acknowledgments}
\newcommand\dedicationname{Dedication}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\begingroup \catcode `|=0 \catcode `[= 1
\catcode`]=2 \catcode `\{=12 \catcode `\}=12
\catcode`\\=12 |gdef|@xcode#1\end{code}[#1|end[code]]
|endgroup
\def\code{\par\renewcommand\baselinestretch{1}\@normalsize\@verbatim
\frenchspacing\@vobeyspaces \@xcode}
\def\endcode{\renewcommand\baselinestretch{\@spacing}\@normalsize\endtrivlist}
\long\def\@footnotetext#1{\insert\footins{\renewcommand\baselinestretch{1}
    \footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}\renewcommand\baselinestretch{\@spacing}}}
\ps@plain                   % 'plain' page style
\pagenumbering{arabic}      % Arabic page numbers
\onecolumn                  % Single-column.
\if@twoside\else\raggedbottom\fi % Ragged bottom unless twoside option.
\def\@stdsinglespacing{1.0}
\ifx\@singlespacing\@stdsinglespacing
  % Spacing has already been set (in ucdavisthesis.cls).
\else
  % Spacing was not set, set it here as if we were ucdavisthesis.cls.
  % \typeout{Spacing not set.}
  \def\@singlespacing{1.0}
  \def\@doublespacing{1.5}      % see above for explanation of value
  \let\@spacing=\@singlespacing
\fi
\newif\if@ColumnSaveValue
\newcommand{\ColumnSave}{
  \if@twocolumn
    \@ColumnSaveValuetrue
  \else
    \@ColumnSaveValuefalse
  \fi
  \pagebreak
  \onecolumn
}
\newcommand{\ColumnSaveHeading}[1]{
  \if@twocolumn
    \@ColumnSaveValuetrue
    \pagebreak
    \twocolumn[#1]
  \else
    \@ColumnSaveValuefalse
    \pagebreak
    #1
  \fi
}
\newcommand{\ColumnRestore}{\if@ColumnSaveValue\twocolumn\fi}
\newcommand\@maketitlepage{
   \begin{titlepage}
      \renewcommand\baselinestretch{\@singlespacing}
      \ColumnSave
      \ifx\@memberfour\empty
        \def\@titleskip{\bigskip}
      \else
        \def\@titleskip{\medskip}
      \fi
      \begin {center}
         \vspace*{-40\p@}
         \leavevmode\vfil
         \@titlesize{\@title} \\ \@titleskip
         \normalsize By \\ \@titleskip
         \textsc{\@author} \\
         \@authordegrees \\ \@titleskip
         \textsc{\@Thesisname} \\ \@titleskip
         Submitted in partial satisfaction of the requirements
         for the degree of \\ \@titleskip
         \textsc{\@degreename} \\ \@titleskip
         in \\ \@titleskip
         \@officialmajor \\ \@titleskip
         in the \\ \@titleskip
         \textsc{Office of Graduate Studies} \\ \@titleskip
         of the \\ \@titleskip
         \textsc{University of California} \\ \@titleskip
         \textsc{Davis} \\ \@titleskip
         Approved: \\ \vspace{18pt}
         \rule{3in}{1pt} \\
         \textrm{\@memberone}, Chair\\ \vspace{18pt}
         \rule{3in}{1pt} \\
         \textrm{\@membertwo}\\ \vspace{18pt}
         \rule{3in}{1pt} \\
         \textrm{\@memberthree}\\
         \ifx\@memberfour\empty
            \bigskip
         \else
            \vspace{18pt}
            \rule{3in}{1pt} \\
            \textrm{\@memberfour}\\
            \ifx\@memberfive\empty
                \bigskip
            \else
                \vspace{18pt}
                \rule{3in}{1pt} \\
                \textrm{\@memberfive}\\ \bigskip
            \fi
         \fi
         Committee in Charge \\ \bigskip
         \@degreeyear \\
         \vfil
       \end {center}
      \ColumnRestore
   \end{titlepage}
}
\newif\if@copyright
\@copyrighttrue
\newcommand\nocopyright{\@copyrightfalse}
\def\@copyrightinfo{All rights reserved.}
\newcommand\copyrightinfo[1]{\def\@copyrightinfo{#1}}
\newcommand\@makecopyrightpage{%
   \if@copyright
     \thispagestyle{empty}
     \ColumnSave
     \null
     \vfill
        \begin{center}
          \normalsize \normalfont Copyright \copyright\
          \ifx\@copyrightyear\@degreeyear \@degreeyear\else
          \@copyrightyear \fi\ by \\
          \@author \\
          \emph{\@copyrightinfo}
        \end{center}
     \ColumnRestore
     % Increment page number if oneside
     \if@twoside\else\addtocounter{page}{-1}\fi
   \else
     \relax % don't create copyright page
   \fi
}
\newif\if@dedication
\def\@dedication{}
\newcommand\dedication[1]{\@dedicationtrue\def\@dedication{#1}}
\newcommand\@makededication{
   \if@dedication
      \@mkboth{\dedicationname}{\dedicationname}
      \ColumnSave
      \par
      \renewcommand\baselinestretch{\@spacing}\@normalsize\normalfont
      \vspace*{0pt}     % force spacing at top of page
      \vfill
      \begin{center}
       \@dedication
      \end{center}
      \vfill\vfill % put about 1:2 (above:below) dedication
      \ColumnRestore
   \fi
}
\newif\if@abstract
\def\@abstract{}
\newcommand\abstract[1]{\@abstracttrue\def\@abstract{#1}}
\newcommand{\@makeabstractpage}[1]{%
   \if@abstract
      \@mkboth{\abstractname}{\abstractname}
      \addcontentsline{toc}{section}{\abstractname}%
      \ColumnSave
      \par
      \begin{center}
        \textsc{\large \abstractname}\\ \bigskip
        \textbf{\@title} % \textsb?
      \end{center}
      \ifx\@spacing\@doublespacing\bigskip\smallskip\else\bigskip\fi
      \renewcommand\baselinestretch{#1}\@normalsize
      %
      % Set up spacing.
      % If it's single spacing, indent the margins.
      % If double spacing is required than things are already
      % ugly enough (and we loose enough space) that we may
      % as well use the whole |\textwidth|.
      \ifthenelse{\equal{#1}{\@stdsinglespacing}}{%
        \begin{center}
          \begin{minipage}{4.75in}
             \setlength{\parindent}{1.5em}
             \@abstract
          \end{minipage}
        \end{center}
       }{%
      \@abstract
      }
      \vfill
      \renewcommand\baselinestretch{\@spacing}\@normalsize
      \ColumnRestore
  \else
      \typeout{No abstract.}
  \fi\newpage
}
\newif\if@acks
\def\@acknowledgments{}
\newcommand\acknowledgments[1]{\@ackstrue\def\@acknowledgments{#1}}
\newcommand\@makeackheading{%
  {
    \centering
    \textsc{\large \acknowledgename}
    \vskip 12pt
  }
}
\newcommand\@makeacknowledgments{%
   \if@acks
      \@mkboth{\acknowledgename}{\acknowledgename}
      \addcontentsline{toc}{section}{\acknowledgename}%
      \ColumnSaveHeading{\@makeackheading}
      \par
      \renewcommand\baselinestretch{\@spacing}\@normalsize
      \noindent \normalsize \normalfont \@acknowledgments
      \vfill
      \ColumnRestore
   \fi\newpage
}
\newcommand\makeintropages{%
  % Preliminary page style (lowercase roman numbers at bottom of page)
  \pagenumbering{roman}\pagestyle{prelim}
  \@maketitlepage
  % If we're printing two sided and there is no copyright page,
  % insert a blank page for the back of the title page.
  % NOTE:  This extra page makes the output non-conforming
  % to the UCD Format, unless you throw it away.
  \if@twoside
     \if@copyright
     \else
        \typeout{Two-side detected, blank page added after title page.}
        \null\thispagestyle{empty}\newpage % the back side of the title page
     \fi
  \fi
  \@makecopyrightpage
  \@makededication
  \tableofcontents
  \listoffigures\newpage
  \listoftables\newpage
  \@makeabstractpage{\@doublespacing}
  \@makeacknowledgments
  \@prelimpagesfalse\newpage % end of preliminary pages, start a new page
  \if@twoside
     \ifthenelse{\isodd{\value{page}}}%
     {}
     % create a blank page if prelim pages has an odd number of pages
     {\thispagestyle{empty}\null\newpage}
  \fi
  % change pagestyle to thshead (arabic page number in upper right)
  \pagenumbering{arabic}\pagestyle{thshead}
}
\newcounter{UMIpagetemp}
\newenvironment{UMImargins}{%
  \begin{list}{}{%
    \setlength{\topsep}{0pt}%
    \setlength{\leftmargin}{0in}%
    \setlength{\rightmargin}{0in}%
    \setlength{\listparindent}{\parindent}%
    \setlength{\itemindent}{\parindent}%
    \setlength{\parsep}{\parskip}%
  }%
  \item[]}{\end{list}}
\newcommand\UMIabstract[1][\@abstract]{%
\if@twoside
  \typeout{Two-side detected, UMI Abstract not printed in this mode.}
  \relax
\else
   \newpage % begin abstract on a new page
      \setcounter{UMIpagetemp}{\value{page}} % save the current page number
      \setcounter{page}{1} %  number pages in the abstract starting at 1
      \pagestyle{UMIheadings} % page numbers in upper right with surrounding dashes
      \thispagestyle{empty} % no page number on the first page
   \begin{UMImargins}
      \begin{flushright}
         \renewcommand\baselinestretch{\@singlespacing}
         \normalsize \normalfont \@author \\
         \@degreemonth\ \@degreeyear \\
         \@graduateprogram \\ \bigskip
      \end{flushright}
      \begin{center}
          \@title \\ \bigskip
          \textbf{\underline{Abstract}}
      \end{center}
      \renewcommand\baselinestretch{%
      \@doublespacing}\noindent#1 % Doublespaced abstract
   \end{UMImargins}
   \renewcommand\baselinestretch{%
   %return to previous spacing, clear rest of page
   \@spacing}\@normalsize\newpage
   \pagestyle{thshead} % return to standard page headings
   % return the page counter to previous value
   \setcounter{page}{\value{UMIpagetemp}}
\fi}
\endinput
%%
%% End of file `ucdavisthesis.cls'.
