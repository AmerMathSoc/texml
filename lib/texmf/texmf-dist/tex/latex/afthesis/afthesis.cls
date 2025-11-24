%% NEW AFIT THESIS STYLE -- 
%% Adapted by the work of Mark Roth et al
%%
%% Joel Young  --- jdyoung@afit.af.mil
%
%
%  Needs:
%
%     report.cls
%     captions2.sty
%
%   included:
%     afthes10.tex   (10pt support)
%     afthes11.tex   (11pt support)
%     afthes12.tex   (12pt support)
%
%     usethesis.tex provides some documentation
%     README provides some other info...
%
%
%% 

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{afthesis}[1996/12/14 v2.7 -- AFIT THESIS STYLE]
\typeout{by Joel Young adapted from work by Mark Roth}

\LoadClassWithOptions{report}

\RequirePackage[hang]{caption2}
\renewcommand\captionlabeldelim{\hspace{12pt}}

\input{afthes1\@ptsize.sty}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Date: Sat, 30 Jul 1994 17:58:55 PST
%From: Donald Arseneau <asnd@erich.triumf.ca>
%
%From removefr.tex at
% CTAN::  macros/latex/contrib/other/fragments/removefr.tex
%
%  \@removefromreset{FOO}{BAR} : Removes counter FOO from the list of
%                       counters \cl@BAR to be reset when counter BAR
%                       is stepped.  The opposite of \@addtoreset.
\def\@removefromreset#1#2{\let\@tempb\@elt
   \expandafter\let\expandafter\@tempa\csname c@#1\endcsname
   \def\@elt##1{\expandafter\ifx\csname c@##1\endcsname\@tempa\else
         \noexpand\@elt{##1}\fi}%
   \expandafter\edef\csname cl@#2\endcsname{\csname cl@#2\endcsname}%
   \let\@elt\@tempb}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\thechapter       {\Roman{chapter}}
\renewcommand\thesection       {\arabic{chapter}.\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}

% NUMBER BY CHAPTER
%  if the user specifies \numberbychapter then pages, figures, tables
%  and equations will all be numbered by chapter.  Here we set a flag to
%  test in other commands.  Also we increase pnumwidth and tocrmarg for
%  the number by chapter option since the page numbers will be much 
%  larger.
\def\ch@ptnum{seq}
\def\ch@ptnumflag{seq}
\def\numberbychapter{\def\ch@ptnum{byc}}

% set up for numberbychapter option:
\ifx\ch@ptnum\ch@ptnumflag 
  \def\thefigure{\arabic{figure}}
  \def\thetable{\arabic{table}}
  \def\theequation{\arabic{equation}}
  \@removefromreset{figure}{chapter}
  \@removefromreset{table}{chapter}
  \@removefromreset{equation}{chapter}
  \gdef\@pnumwidth{3.5em}
  \gdef\@tocrmarg{4em}
\else
  \gdef\@pnumwidth{2em}
  \gdef\@tocrmarg{2.5em}
\fi


% NO SECTION NUMBERS
%  if the user specifies \nosectionnumbers then section numbers are not
%  used in the text and in the table of contents. A flag is set so that
%  it can be tested when we change the section numbering scheme in
%  the appendices
\newif\if@nosectnum \@nosectnumfalse
\def\nosectionnumbers{\@nosectnumtrue
  \def\thesection{\hskip-1em}   %the negative hskip is to counteract the
                                %space which normally appears after the
                                %section number and before the section 
				%title
  \def\thesubsection{\hskip-1em}
  \def\thesubsubsection{\hskip-1em}

  \def\l@section{\@dottedtocline{1}{3.5em}{2.3em}}
  \def\l@subsection{\@dottedtocline{2}{5.5em}{3.2em}}
  \def\l@subsubsection{\@dottedtocline{3}{7.5em}{4.1em}}
  \def\l@paragraph{\@dottedtocline{4}{9.5em}{5em}}
  \def\l@subparagraph{\@dottedtocline{5}{11.5em}{6em}} 
}

% UNDERLINE OPTION
%  if the user specifies \underlineoption then underlining is used 
%  instead of italics for emphasized text, including chapter, 
%  section, etc.  headings
\newif\if@uloption \@uloptionfalse
\def\underlineoption{
  \@uloptiontrue
  \RequirePackage{ulem}
  \if@compatibility\else
    \newcount\@clb
  \fi
}

%    **************************************
%    *         APPENDIX                   *
%    **************************************
%
\newcommand\appfl@g{\appendixname}  %used to test \@chapapp 
%
\renewcommand\appendix{\par\clearpage
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\Alph{chapter}}
  \if@nosectnum\else
    \renewcommand\thesection{\Alph{chapter}.\arabic{section}}
  \fi 
}


% FIGURE
%   redefine the @caption command to put a period after the figure or 
%   table number in the lof and lot tables
\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname.}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

% QUOTATION
%   Fills lines
%   Indents paragraph
%   Singlespace 
\renewenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \medskip\singlespace\item\relax}
               {\endlist}

% modify \@endparenv to get rid of \addvspace which isn't needed in a
% doublespaced document
\def\@endparenv{\addpenalty\@endparpenalty\@endpetrue}

% QUOTE -- same as quotation except no paragraph indentation,
%
\renewenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \smallskip\singlespace\item\relax}
               {\endlist}


%    ****************************************
%    *         TABLE OF CONTENTS, ETC.      *
%    ****************************************

\renewcommand\contentsname{Table of Contents}

\newif\if@toc \@tocfalse
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \begingroup% temporarily set if@toc so that \@schapter will not
               % put Table of Contents in the table of contents.
      \@toctrue
      \chapter*{\contentsname}
    \endgroup
    \thispagestyle{afittoc}
    \baselineskip=18pt plus .5pt minus .5pt
    {\raggedleft Page \par\vskip-\parskip} 
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi 
    \baselineskip=\normalbaselineskip
  }

\def\l@appendix{\pagebreak[3]
 \vskip 1.0em plus 1pt % space above appendix line
  \@dottedtocline{0}{0em}{8em}}

\def\l@chapter{\pagebreak[3]
 \vskip 1.0em plus 1pt % space above appendix line
  \@dottedtocline{0}{0em}{4em}}

\if@nosectnum\else
  \renewcommand\l@section{\@dottedtocline{1}{5.5em}{2.4em}}
  \renewcommand\l@subsection{\@dottedtocline{2}{8.5em}{3.2em}}
  \renewcommand\l@subsubsection{\@dottedtocline{3}{11em}{4.1em}}
  \renewcommand\l@paragraph{\@dottedtocline{4}{13.5em}{5em}}
  \renewcommand\l@subparagraph{\@dottedtocline{5}{16em}{6em}}
\fi
 
% LIST OF FIGURES
%
\def\listoffigures{%
  \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listfigurename}%
  \thispagestyle{afitlof}%
  \baselineskip=18pt plus .5pt minus .5pt%
  {\hbox to \hsize{Figure\hfil Page} \par\vskip-\parskip}%
  \@starttoc{lof}%
  \if@restonecol\twocolumn\fi%
  \baselineskip=\normalbaselineskip}%

\def\l@figure{\@dottedtocline{1}{1em}{4.0em}}

% LIST OF TABLES
%
\def\listoftables{%
  \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listtablename}%
  \thispagestyle{afitlot}%
  \baselineskip=18pt plus .5pt minus .5pt%
  {\hbox to \hsize{Table\hfil Page} \par\vskip-\parskip}%
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi%
  \baselineskip=\normalbaselineskip}%
 
\let\l@table\l@figure

% LIST OF SYMBOLS
%
\newcommand\listsymbolname{List of Symbols}
 
\def\listofsymbols{%
  \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listsymbolname}%
  \thispagestyle{afitlos}%
  \baselineskip=18pt plus .5pt minus .5pt%
  {\hbox to \hsize{Symbol\hfil Page} \par\vskip-\parskip}%
  \@starttoc{los}%
  \if@restonecol\twocolumn\fi%
  \baselineskip=\normalbaselineskip}%

%add symbol to los and in text with optional definition in the los
 \def\symbol{\@ifnextchar[{\@symboldef}{\@symbolnodef}}
 \def\@symboldef[#1]#2{#2\addcontentsline{los}{figure}{#2\ #1}}
 \def\@symbolnodef#1{#1\addcontentsline{los}{figure}{#1}}

% LIST OF ABBREVIATIONS
%
\newcommand\listabbrevename{List of Abbreviations}

\def\listofabbreviations{%
  \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listabbrevename}%
  \thispagestyle{afitloa}%
  \baselineskip=18pt plus .5pt minus .5pt%
  {\hbox to \hsize{Abbreviation\hfil Page} \par\vskip-\parskip}%
  \@starttoc{loa}%
  \if@restonecol\twocolumn\fi% 
  \baselineskip=\normalbaselineskip}%

%add abbreviation to loa and in text with optional definition in the loa
 \def\abbreviation{\@ifnextchar[{\@abbreviationdef}{\@abbreviationnodef}}
 \def\@abbreviationdef[#1]#2{#2\addcontentsline{loa}{figure}{#2\ #1}}
 \def\@abbreviationnodef#1{#1\addcontentsline{loa}{figure}{#1}}
 
%    ****************************************
%    *             BIBLIOGRAPHY             *
%    ****************************************
%
\def\@cite#1#2{({#1\if@tempswa :#2\fi})}
\def\@biblabel#1{#1.\hfill}  %change from the default [#1]

\renewenvironment{thebibliography}[1]
  {
   \chapter*{\bibname
        \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
   \ifx\ch@ptnum\ch@ptnumflag{}
   \else\gdef\thepage{BIB-\arabic{page}}
        \setcounter{page}{1}\fi
   \vspace{2.5ex}
   \singlespace
   \list{\@biblabel{\arabic{enumiv}}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \usecounter{enumiv}%
	 \itemsep 0.02in
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\arabic{enumiv}}%
	}
   \sloppy\clubpenalty4000\widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

%    ****************************************
%    *            PAGE STYLES               *
%    ****************************************
%
\def\ps@afittoc{%
      \let\@mkboth\@gobbletwo
      \def \@oddhead{}
      \def \@oddfoot{\rm 
            \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afittocn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}
\def\ps@afittocn{\let\@mkboth\@gobbletwo
      \def \@oddhead{\rm \hfil\raisebox{10pt}{Page}}
      \def \@oddfoot{\rm 
            \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afittocn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}

\def\ps@afitlof{\let\@mkboth\@gobbletwo
      \def \@oddhead{}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitlofn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}
\def\ps@afitlofn{\let\@mkboth\@gobbletwo
      \def \@oddhead{\rm 
           \raisebox{10pt}{Figure}\hfil\raisebox{10pt}{Page}}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitlofn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}

\def\ps@afitlot{\let\@mkboth\@gobbletwo
      \def \@oddhead{}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitlotn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}
\def\ps@afitlotn{\let\@mkboth\@gobbletwo
      \def \@oddhead{\rm 
           \raisebox{10pt}{Table}\hfil\raisebox{10pt}{Page}}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitlotn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}

\def\ps@afitlos{\let\@mkboth\@gobbletwo
      \def \@oddhead{}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitlosn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}
\def\ps@afitlosn{\let\@mkboth\@gobbletwo
      \def \@oddhead{\rm 
           \raisebox{10pt}{Symbol}\hfil\raisebox{10pt}{Page}}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitlosn}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}

\def\ps@afitloa{\let\@mkboth\@gobbletwo
      \def \@oddhead{}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitloan}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}
\def\ps@afitloan{\let\@mkboth\@gobbletwo
      \def \@oddhead{\rm 
           \raisebox{10pt}{Abbreviation}\hfil\raisebox{10pt}{Page}}
      \def \@oddfoot{\rm
           \hfil\raisebox{-9pt}{\thepage}\hfil\thispagestyle{afitloan}}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}

\def\ps@afitplain{\let\@mkboth\@gobbletwo
      \def \@oddhead{}
      \def \@oddfoot{\rm \hfil\raisebox{-9pt}{\thepage}\hfil}
      \let \@evenhead\@oddhead \let \@evenfoot\@oddfoot}


%    ****************************************
%    *            DOUBLESPACE               *
%    ****************************************
%
%The following taken from doublespace.sty, it allows the thesis to be
%double spaced and still look fairly decent

\def\setstretch#1{\renewcommand{\baselinestretch}{#1}}

\def\@newbaseline{%
    \baselineskip\f@baselineskip\relax%
    \baselineskip\baselinestretch\baselineskip
    \setbox\strutbox\hbox{\vrule\@height.7\baselineskip
    \@depth.3\baselineskip \@width\z@}%
    \normalbaselineskip\baselineskip}%  -MAR

%---Increase the space between last line of text and footnote rule.
%   This is a very untidy way to do it!

\skip\footins 20pt plus4pt minus4pt

%---Reset baselinestretch within footnotes and floats. Originally stolen
%   from Stanford thesis style.

\let\latex@xfloat=\@xfloat
\def\@xfloat #1[#2]{%
  \latex@xfloat #1[#2]%
  \singlespace
  \normalsize
}

\long\def\@footnotetext#1{\insert\footins{\def\baselinestretch{1}\footnotesize
    \interlinepenalty\interfootnotelinepenalty 
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}

\def\singlespace{%
  \def\baselinestretch{1}%
  \ifx\undefined\selectfont
    \ifx\@currsize\normalsize\normalsize\else\@currsize\fi%
  \else %else new font selection scheme is invoked-MAR
    \@newbaseline %include new baselinestretch-MAR
  \fi %-MAR
}
\def\endsinglespace{\par}

\def\spacing#1{\par%
 \begingroup  %  moved from \endspacing by PGBR 1-29-91
 \def\baselinestretch{#1}%  
 \def\str@tchamount{#1}
 \ifx\undefined\selectfont %then new font selection scheme not invoked-MAR
 \ifx\@currsize\normalsize\normalsize\else\@currsize\fi
 \else %else new font selection scheme is invoked-MAR
 \@newbaseline %include new baselinestretch-MAR
 \fi %-MAR
}

\def\endspacing{\par%
 \vskip \parskip%
 \vskip \baselineskip%
 \endgroup%
 \vskip -\parskip%
 \vskip -\baselineskip%
}   %\begingroup used to be here, PGBR 1-29-91

% one and a half spacing is 1.5 x pt size
\def\onehalfspace{\ifcase \@ptsize \relax  % 10pt
     \spacing{1.25}
   \or % 11pt
     \spacing{1.213}
   \or % 12pt
     \spacing{1.241}
   \fi}
\let\endonehalfspace=\endspacing


\def\doublespace{%
  \if case \@ptsize \relax % 10pt
    \spacing{1.667}
  \or % 11pt
    \spacing{1.618}
  \or % 12pt
    \spacing{1.655}
  \fi
}
\let\enddoublespace=\endspacing


\everydisplay{
   \abovedisplayskip \baselinestretch\abovedisplayskip%
   \belowdisplayskip \abovedisplayskip%
   \abovedisplayshortskip \baselinestretch\abovedisplayshortskip%
   \belowdisplayshortskip  \baselinestretch\belowdisplayshortskip}


%
%    ****************************************
%    *   THESIS TYPE AND DEFAULT VALUES     *
%    ****************************************
%
\def\TH@SISTYPE{THESIS}\def\th@sistype{thesis}
\def\pr@viousdegrees{}
\def\pr@viousdegreestwo{}
\def\d@gree{}
\def\gr@duationdate{\ifcase\month\or
	March\or March\or March\or June\or June\or June\or September\or
	September\or September\or December\or December\or December\fi
	\ \number\year}
\def\r@nk{}
\def\sch@ol{}
\def\ti@tle{}
\def\sqti@tle{}
\def\disclaim@r{The views expressed in this \th@sistype\ are those of
                the \if@twoauthor authors \else author \fi and do not 
		reflect the official policy or position of the 
		Department of Defense or the United States Government.}
\def\d@stribution{Approved for public release; distribution unlimited}
\def\d@signator{}
\def\d@an{}

\def\diss@flag{dissertation}
\def\report@flag{report}
\def\thesis@flag{thesis}

\def\mastersreport{\def\TH@SISTYPE{REPORT}\def\th@sistype{report}}
\def\dissertation{\def\TH@SISTYPE{DISSERTATION}\def\th@sistype{dissertation}}

%
%    ****************************************
%    *     DATA OF AUTHOR AND THESIS        *
%    ****************************************
%
\newif\if@twoauthor \@twoauthorfalse
\def\twoauthor{\@twoauthortrue}
\newif\if@flyleafframe \@flyleafframefalse
\def\flyleafframe{\@flyleafframetrue}
\def\author#1{\def\auth@r{#1}}
\def\authortwo#1{\def\auth@rtwo{#1}}
\def\designator#1{\def\d@signator{#1}}
\def\rank#1{\def\r@nk{#1}}
\def\ranktwo#1{\def\r@nktwo{#1}}
\def\dean#1{\def\d@an{#1}}
\def\school#1{\def\sch@ol{#1}}
\def\distribution#1{\def\d@stribution{#1}}
\def\bl@nk{}
\def\title#1{\def\ti@tle{#1}\ifx\sqti@tle\bl@nk\def\sqti@tle{#1}\fi}
\def\flytitle#1{\def\sqti@tle{#1}}
\def\previousdegrees#1{\def\pr@viousdegrees{#1}}
\def\previousdegreestwo#1{\def\pr@viousdegreestwo{#1}}
\def\degree#1{\def\d@gree{#1}}
\def\graduationdate#1{\def\gr@duationdate{#1}}
\def\address#1{\def\addr@ss{#1}}
\def\addresstwo#1{\def\addr@sstwo{#1}}


%
%    **************************************
%    *        COMPONENTS OF THESIS        *
%    **************************************
%
%
%  APPROVAL PAGE
%
% Comma delimited list of committee members is the parameter.
% e.g.
%\committee{Dr. Eugene Santos Jr\\Committee Chair,
%	   Dr. Lamont\\Committee Member,
%	   Maj. Banks\\Committee Member}
%
\def\appr@val{\leftline{Approved:\hfill}\bigskip}

\def\committee#1{\gdef\@committee{#1}}

%prints out signaturelines in aproval page
\def\sign@turelines{\@ifundefined{@committee}%
  {\@warning{Missing \string\committee\space command!}%
   \def\@comem{MEMBER HERE\\TITLE HERE}%
   \sign@line\sign@line\sign@line}%
  {\@for \@comem:=\@committee \do{\sign@line}}%
}

% format of signature line...
\def\sign@line{\par 
  \begingroup%
    \singlespace%
    \setlength{\parskip}{0pt}
    \hskip 65pt%
    \hbox to 3in{\hrulefill}%
    \hskip 10pt%
    \hbox to 1.2in{\hrulefill}\par%
    \hskip 65pt%
    \parbox[t]{3in}{\raggedright \@comem}%
    \hskip 10pt Date%
    \par%
    \bigskip\bigskip%
  \endgroup
}

% The approval page itself...
\def\approvalpage{%
  \thispagestyle{empty}%
  \newpage%
  \typeout{^^JApproval Page.}
  \leftline{\d@signator\hfill}
  \vspace*{40pt}
  \baselineskip=22.5pt plus .5pt minus .2 pt
  \begin{center}%
    \large\rm\ti@tle\\[\bigskipamount] \normalsize
    \auth@r\ifx\pr@viousdegrees\@empty\else, \pr@viousdegrees\fi%
    \\[\medskipamount] \r@nk
  \end{center}
  \vfill
  \appr@val\bigskip\medskip
  \sign@turelines
  \ifx\th@sistype\diss@flag
    \begingroup
      \singlespace
      \vspace{40pt}
      \leftline{\hskip 2in\hskip 15pt\hbox to 3in{\hrulefill}\hfil} 
      \leftline{\hskip 2in\hskip 15pt\d@an\hfil} 
      \leftline{\hskip 2in\hskip 15pt Dean\hfil} 
    \endgroup
  \fi
  \vspace{100pt}\newpage
}


%  FLYLEAF
%
\def\newheadline{\protect\\}
\def\flyleaf{\thispagestyle{empty}
    \typeout{^^JFly Leaf.}
    \leftline{\d@signator\hfill}
    \vspace{4.08in}
    \centerline{%
    \if@flyleafframe\framebox[4.00in]{\fi
    \vbox to 2in{
	\baselineskip=22.5pt plus .5pt minus 10pt
        \begin{center} \sqti@tle \end{center} \vfill
        \begin{center} \TH@SISTYPE  \end{center} \vfill
	\baselineskip=18.5pt plus .5pt minus 6pt
	\if@twoauthor
	  \centerline{
	  \begin{minipage}[t]{2in}\singlespace
	    \centerline{\auth@r}
	    \centerline{\r@nk}
	  \end{minipage} 
	  \begin{minipage}[t]{2in}\singlespace
	    \centerline{\auth@rtwo}
	    \centerline{\r@nktwo}
	  \end{minipage} 
	  }
	\else\singlespace
	  \centerline{\auth@r}
	  \centerline{\r@nk}
	\fi
	\vfill
	\begin{center}\d@signator\end{center}
    }%end vbox
    \if@flyleafframe}\fi %end framebox
    }%end centerline
    \vfill
    \begin{center}\singlespace\d@stribution\end{center}%
    \newpage\baselineskip=\normalbaselineskip}

%  DISCLAIMER
%
\def\disclaimerpage{%
   \typeout{^^JDisclaimer Page.}
   \thispagestyle{empty}
   \ \vfill
   \noindent\disclaim@r
   \vfill \newpage
   }

%  TITLEPAGE
%
\def\titlepage{\setcounter{page}{1}
   \typeout{^^JTitle Page.}
   \thispagestyle{empty}
   \leftline{\d@signator\hfill}
        \vspace*{5pt}\vfill
	\begin{center} \baselineskip 22.5pt\large\rm\ti@tle \end{center} 
        \vspace*{30pt}
        \begin{center} \baselineskip 22.5pt
        \TH@SISTYPE\\[30pt] Presented to the Faculty of the \sch@ol\\
	of the Air Force Institute of Technology\\
	Air University\\
	In Partial Fulfillment of the\\
	Requirements for the Degree of\\
	\d@gree
	\end{center}\vfill\baselineskip 22.5pt
	\if@twoauthor
	  \begin{minipage}[t]{.49\textwidth}
            \centerline{\auth@r\ifx\pr@viousdegrees\@empty%
                               \else, \pr@viousdegrees\fi}
            \centerline{\r@nk} 
	  \end{minipage} 
	  \begin{minipage}[t]{.49\textwidth}
            \centerline{\auth@rtwo\ifx\pr@viousdegreestwo\@empty%
                                  \else, \pr@viousdegreestwo\fi}
	    \centerline{\r@nktwo}
	  \end{minipage} 
	\else
          \centerline{\auth@r\ifx\pr@viousdegrees\@empty%
                             \else, \pr@viousdegrees\fi}
          \centerline{\r@nk} 
	\fi
	\vfill
	\centerline{\gr@duationdate} 
	\vfill
        \begin{center}\singlespace\d@stribution\end{center}%
	\newpage\baselineskip=\normalbaselineskip}

%  ACKNOWLEDGEMENTS OR PREFACE
%
\newenvironment{acknowledgements}{\ackhead}{\acktail}
\newenvironment{acknowledgments}{\ackhead}{\acktail} %for upward compatibility
\def\ackhead{\chapter*{Acknowledgements}
       \setstretch{\str@tchamount}\normalsize} %back to doublespace 
\def\acktail{\par\bigskip\bigskip \leftline{\hfill\auth@r}
\if@twoauthor\leftline{\hfill\auth@rtwo}\fi}

\newenvironment{preface}{\prefacehead}{\acktail}
\def\prefacehead{\chapter*{Preface} 
       \setstretch{\str@tchamount}\normalsize} %back to doublespace

%  ABSTRACT
%
\renewenvironment{abstract}{\abshead}{\abstail}
\def\abshead{%
       \clearpage%
       \typeout{^^JAbstract.}%
       \thispagestyle{afitplain}%
       \leftline{\d@signator\hfill}%
       \addcontentsline{toc}{chapter}{Abstract}%
       \vspace*{18pt}%
       \centerline{\large{\em Abstract}}\par\par\nobreak%
       \setstretch{\str@tchamount}\normalsize}
\def\abstail{\par}

%  VITA
%
\newif\if@vitatwo \@vitatwofalse
\newenvironment{vita}{\vitahead}{\vitatail}
\def\vitahead{%
	\clearpage%
        \typeout{^^JVita.}%
	\ifx\ch@ptnum\ch@ptnumflag{}\else%
        \gdef\thepage{VITA-\arabic{page}}%
        \if@vitatwo\else\setcounter{page}{1}\fi\fi%
	\centerline{\large{\em Vita}}\par\par\nobreak%
        \setstretch{\str@tchamount}\normalsize%
        \if@vitatwo\else\addcontentsline{toc}{chapter}{Vita}\fi%
}%end vitahead
\def\vitatail{\vfill%\par\vspace{50pt}\par
    \singlespace
    \hfill Permanent address: 
    \begin{tabular}[t]{l}
      \if@twoauthor
        \if@vitatwo \addr@sstwo
	\else
	  \addr@ss
	  \global\@vitatwotrue %set so next time vita prints 2nd author's addr
        \fi
      \else \addr@ss
      \fi
    \end{tabular}
}%end vitatail

%    ****************************************
%    *           INITIALIZATION             *
%    ****************************************
%
% Default initializations

\ps@afitplain          % 'afitplain' page style with lowered page nos.
\onecolumn             % Single-column.
\pagenumbering{roman}  % the first chapter will change pagenumbering
                       % to arabic
\setcounter{page}{1}   % in case a titlepage is not requested
                       % otherwise titlepage sets page to 1 since the
                       % flyleaf is not counted as a page
\widowpenalty 10000    % completely discourage widow lines
\clubpenalty 10000     % completely discourage club (orphan) lines
\raggedbottom          % don't force alignment of bottom of pages

\endinput
