% last change   : 09.11.2007 18:56:07
% status        : 0.91 beta
% created       : 2001/06/28 17:49:53
%
% subject       : typesetting german phd thesis law
%
% © Axel Sodtalbers (juramisc@sodtalbers.de)


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jurabook}[2007/11/09 V0.91 (beta) juridical books (AS)]

% new styles:   chapter   (all chapter/appendix headings, def: \huge\bfseries
%			    partintro ('Kapitel X:', def: \huge\bfseries
%		        part	    ('Einleitung', def: \Huge\bfseries
%
% new option:   showpagenumber
%
% change:       \rn works with option 'norunners' turned on
%
% bug fixed:    \dumpoptions broken (showed obsolete options) 
% bug fixed:    correct chapter display in toc
% bug fixed:    \settowidth{\@tempdima}{\bfseries 99.\space}
%
% for a change history cf. 
% doc/jmgerdoc.tex (\subsubsection{Versionsgeschichte})


%========================================
%               
% Required packages
%
%========================================

\RequirePackage{jurabase}% calc, ifthen, xspace
\RequirePackage{remreset}
\RequirePackage{fancyhdr}
\RequirePackage{multicol}
% fancyhdr muss aktuell (>V.2) sein, da es aber keine Versionsinformation
% besitzt, versuchen wir es so:
\@ifundefined{fancyhead}%
  {\ClassError{jurabook}%
     {You are using an outdated version of fancyhdr!\MessageBreak
      jurabook needs fancyhdr version 2 or higher.}%
     {Get fanyhdr's current version from CTAN.}%
  }%   
  {\relax}


%========================================
%               
% jurabook version information
%
%========================================

\newcommand*{\jurabookversion}{V0.91 (beta)}
\newcommand*{\jurabookdate}{2007/10/15}


%========================================
%               
% Class options 
%
%========================================

\iffalse

  allowhyphens
  ==================
  Trennungn in Chapter und Section? 
  -> default: false

\fi

\newif\if@allowhyphens
\@allowhyphensfalse

\DeclareOption{allowhyphens}{\@allowhyphenstrue}
    


\iffalse

  indexpagenumbers
  ==================
  Sollen Seitenzahlen in den Index aufgenommen werden (statt der Randnummern)? 
  -> default: false

\fi

\newif\if@indexpagenumbers 
\@indexpagenumbersfalse
\DeclareOption{indexpagenumbers}{\@indexpagenumberstrue}

  
\iffalse 

 norunners
 ===============
 Sollen KEINE Randnummern ausgegeben werden?
 -> default: false
 
 (wenn gewaehlt, wird auch indexpagenumbers auf true geschaltet)

\fi

\newif\if@dorunners
\@dorunnerstrue
\DeclareOption{norunners}{%
  \@dorunnersfalse%
  \@indexpagenumberstrue}


\iffalse
 
 rnrefbold
 ===============
 Sollen in Verweisen mit \mnref{Marke} die Randnummern fett ausgegeben werden? 
 -> default: false
 
 Hinweis: Die Randnummern im Text selbst werden _stets_ fett ausgegeben!

\fi

\newif\if@rnrefbold% rn = runners
\@rnrefboldfalse
\DeclareOption{rnrefbold}{\@rnrefboldtrue}

  
\iffalse

  rnintoc  (rn in toc)
  ===============

  Sollen auch die Randnummern in das Inhaltsverzeichnis
  mit aufgenommen werden? (funktioniert noch nicht!)

\fi

\iffalse

  oldfootnotes
  ===============
  Altes Fussnotenlayout? 
  -> default: false
  
  Wenn *nicht* angegeben:
  __________________________
  999 Hier Fussnotentext ...
      Zweite Zeile ...
\fi

\newif\if@oldfootnotes
\@oldfootnotesfalse
\DeclareOption{oldfootnotes}{\@oldfootnotestrue}

\iffalse

  fncontinued
  ===============
  Fussnoten werden auch nach chapter weitergezaehlt 
  -> default: false
  
\fi


\newif\if@fncontinued
\@fncontinuedfalse
\DeclareOption{fncontinued}{\@fncontinuedtrue}


\iffalse

  showpagenumber
  ===============
  Footers of the first page of a part / chaper contains the page number
  Fussnoten werden auch nach chapter weitergezaehlt 
  -> default: false
  
\fi


\newif\if@showpagenumber
\@showpagenumberfalse
\newcommand{\jubo@thispagestyle@empty}%
  {\thispagestyle{empty}}
  
\DeclareOption{showpagenumber}{%
  \@showpagenumbertrue%
  \renewcommand{\jubo@thispagestyle@empty}%
    {\thispagestyle{plain}}%
}

\iffalse

  suppresswebdates
  ================
  Ausgabe des Abrufdatums in citeweb-Befehlen unterdruecken?
  -> default: false

\fi

\newif\if@suppresswebdates
\@suppresswebdatesfalse
\DeclareOption{suppresswebdates}{\@suppresswebdatestrue}

\iffalse

  longfnrule
  ==========
  Lange Linie ueber den Fussnoten? 
  -> default: false

  Hinweis: wie in den neuen Buechern von C.H. Beck.
\fi

\newif\if@longfnrule
\@longfnrulefalse
\DeclareOption{longfnrule}{\@longfnruletrue}


\iffalse

  classiclayout
  =============
  Eher konservativeres / klassisches Layout? 
  -> default: false

\fi

\newif\if@classiclayout
\@classiclayoutfalse
\DeclareOption{classiclayout}{\@classiclayouttrue}


\iffalse

  centeredpartsintoc
  ==================
  Sollen die 'parts' (nur) im Inhaltsverzeichnis zentriert werden?
  -> default: false

  centeredlayout
  ==================
  Sollen die 'parts' und chapter im Inhaltsverzeichnis
  UND im Text zentriert werden?
  -> default: false

\fi


\newif\if@centeredpartsintoc
\@centeredpartsintocfalse
\DeclareOption{centeredpartsintoc}{\@centeredpartsintoctrue}

  
\newif\if@centeredlayout
\@centeredlayoutfalse
\DeclareOption{centeredlayout}{%
  \@centeredlayouttrue%
  \@centeredpartsintoctrue}


\iffalse

  compact
  =======
  Keine eigenen Seiten fuer parts?
  -> default: false

\fi

\iffalse

  screenmode
  ==========
  output for screen (not print), hyperref and co
  -> default: false
\fi
  
\newif\ifjscreen
\jscreenfalse
\DeclareOption{screenmode}{\@jscreentrue}

\newif\if@compactlayout
\@compactlayoutfalse
\DeclareOption{compact}{%
  \@compactlayouttrue%
  \if@centeredlayout%
  \else%
    \ClassWarningNoLine{jurabook}%
      {If you're using the 'compact' option,\MessageBreak%
       it is maybe a good idea to use\MessageBreak%
       the 'centeredlayout' option, too ..}%
  \fi%
}


\iffalse

  decisionhints
  =============
  
  Sollen die Anmerkungen zu den Entscheidungen in der 
  Entscheidungsliste nicht mit ausgegeben werden? 
  -> default: false (= Anmerkungen werden NICHT ausgegeben)

\fi

\newif\if@decisionhints 
\@decisionhintsfalse
\DeclareOption{decisionhints}{\@decisionhintstrue}


\iffalse

  overviewwithsec
  ===============
  Sollen auch die 'sections' in den Ueberblick ('\overview') genommen werden?
  -> default: false

\fi
  
\newif\if@secinovw
\@secinovwfalse
\DeclareOption{overviewwithsec}{\@secinovwtrue}


\iffalse

  seminar
  ========
  Output without chapters? (for smaller papers, e.g. used in a seminar)
  -> default: false
\fi
  
\newif\if@seminar
\@seminarfalse
\DeclareOption{seminar}{\@seminartrue}

\iffalse

  chapterprefix
  ===============
  Erst 'Kapitel', dann die Kapitelummer?
  (ergibt: 'Kapitel 1')
  
  -> default: true

\fi
  
\newif\if@chapterprefix
\@chapterprefixtrue
\DeclareOption{chapterprefix}{\@chapterprefixtrue\@chaptersuffixfalse}

\iffalse

  chaptersuffix
  ===============
  Erst Kapitelnummer, dann 'Kapitel'?
  (ergibt: '1. Kapitel')
  
  -> default: false

\fi
  
\newif\if@chaptersuffix
\@chaptersuffixfalse
\DeclareOption{chaptersuffix}{\@chaptersuffixtrue\@chapterprefixfalse}


\iffalse

  fixtocindent
  ===============
  sections werden um eine fixe Breite (jb@defaulttocindent@length=1.5em)
  eingerueckt.
  
  -> default: false

\fi
  
\newif\if@fixtocindent
\@fixtocindentfalse
\DeclareOption{fixtocindent}{\@fixtocindenttrue}


\iffalse

  printmaketime
  =============
  Soll das Erstellungsdatum ('\today') in den Fusszeilen ausgegeben werden?
  -> default: false
\fi


\newif\if@printmaketime
\@printmaketimefalse
\DeclareOption{maketime}{\@printmaketimetrue}



\newif\if@ruwtitle
\@ruwtitlefalse

\DeclareOption{ruwtitle}{%
  \@ruwtitletrue%
  \newsavebox{\titlepublisherbox}%
  \savebox{\titlepublisherbox}{}%
}


\iffalse

  all other options will be passed to LaTeX-book class ...
  
  (Begleiter 489)
\fi

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}   
\ProcessOptions\relax


% chapters titles' justification
% this is experimental and not completed 
%
% if you want ragged right justification, try
%   \let\jubo@csalign@hook\raggedright

\newcommand{\jubo@csalign@hook}{\relax}
\if@allowhyphens%
  \RequirePackage{ragged2e}%
  \let\jubo@csalign@hook\RaggedRight%
\else
\fi


\iffalse
  Output of all options (for debugging purposes)
\fi

\newcommand{\@jb@oo@screenandlog}[1]{%
  \wlog{#1}\typeout{#1}%
}
\newcommand{\@jb@oo@document}[1]{#1\newline}

\newcommand{\@jb@checkopt}[1]{
  \def\@@jb@check{#1}
  \csname if@\@@jb@check\endcsname
    \@jb@oo{\@@jb@check :\space on}
  \else
    \@jb@oo{\@@jb@check :\space off}
  \fi    
}

\iffalse
  \dumpoptions[out]
               #1
  #1-> '0' Output in logfile only (default)
  #1-> '1' Output on screen only 
  #1-> '2' Output in logfile and on screen 
  #1-> '3' Output in document
  
\fi

\newcommand{\dumpoptions}[1][0]{%
  \let\@jb@oo\wlog
  \ifthenelse{#1 = 1}{\let\@jb@oo\typeout}{\relax}%
  \ifthenelse{#1 = 2}{\let\@jb@oo\@jb@oo@screenandlog}{\relax}%
  \ifthenelse{#1 = 3}{\let\@jb@oo\@jb@oo@document}{\relax}%
  \@jb@checkopt{indexpagenumbers}
  \if@dorunners \@jb@oo{norunners: off}\else\@jb@oo{norunners: on}\fi
  \@jb@checkopt{rnrefbold}
  \@jb@checkopt{oldfootnotes}
  \@jb@checkopt{fncontinued}
  \@jb@checkopt{showpagenumber}
  \@jb@checkopt{longfnrule}
  \@jb@checkopt{classiclayout}
  \@jb@checkopt{centeredlayout}
  \@jb@checkopt{centeredpartsintoc}
  \if@compactlayout \@jb@oo{compact: off}\else\@jb@oo{compact: on}\fi
  \@jb@checkopt{decisionhints}  
  \if@secinovw \@jb@oo{overviewwithsec: off}\else\@jb@oo{overviewwithsec: on}\fi
  \@jb@checkopt{chapterprefix}  
  \@jb@checkopt{chaptersuffix}  
  \@jb@checkopt{fixtocindent}  
  \if@printmaketime \@jb@oo{maketime: off}\else\@jb@oo{maketime: on}\fi
}

%========================================
%               
% Further preparations ...
%
%========================================

% loading jurabook's basis
\LoadClass{book}

\if@fncontinued%
  \@removefromreset{footnote}{chapter}%
\fi

% pdf support
\newif\ifjpdf
\jpdffalse

% somewhat complicate construction, but:
% no if ... constructions allowd inside IfFileExists

\newif\if@ifpdfloaded
\@ifpdfloadedfalse

\IfFileExists{ifpdf.sty}%
  {\usepackage{ifpdf}%
   \@ifpdfloadedtrue}%
  {\relax}

\if@ifpdfloaded
  \ifpdf\jpdftrue\else\jpdffalse\fi
\else
  \ClassWarningNoLine{jurabook}%
    {Cannot load 'ifpdf.sty' - please get this\MessageBreak
     package from CTAN. Now I'll use a poor man's\MessageBreak
     solution to detect pdftex usage in pdf mode..}%
  \@ifundefined{pdfoutput}%
    {\jpdffalse}% 
    {\ifcase\pdfoutput\jpdffalse\else\jpdftrue\fi}% we're using pdfLaTeX in pdf mode
\fi


% this will be set in FinalJuboSettings
\newif\if@jurabibloaded
\@jurabibloadedfalse
\newif\if@hyperrefloaded
\@hyperrefloadedfalse


% which language is loaded?
% jb@languageloaded = -1 -> undefinied
%                   =  0 -> german (babel)
%                   =  1 -> ngerman (babel)
%                   =  2 -> german (package)
%                   =  3 -> ngerman (package)

\newcounter{jb@languageloaded}
\setcounter{jb@languageloaded}{\m@ne}

\newcommand{\jb@detectlanguage}{
  \@ifpackageloaded{babel}%
    {\iflanguage{german}%
      {\setcounter{jb@languageloaded}{0}%
      }%
      {\iflanguage{ngerman}%
        {\setcounter{jb@languageloaded}{1}%
        }%
        {\ClassWarningNoLine{jurabook}%
          {This class is designed for german documents only,\MessageBreak
           so please select 'german' or 'ngerman' language option}%
        }%
      }%
    }%
    {\@ifpackageloaded{german}%
       {\setcounter{jb@languageloaded}{2}%
       }%
       {\@ifpackageloaded{ngerman}%
         {\setcounter{jb@languageloaded}{3}%
         }%
         {\ClassWarningNoLine{jurabook}%
            {This class is designed for german documents only,\MessageBreak
             so please use 'german', 'ngerman' or 'babel' package.\MessageBreak
             I will proceed, but results will be unpredictable}%
         }%
       }% 
    }%
}


% Folgender Trick notwendig, sonst bleiben Kopfzeilen kuerzer bei Verwendung
% von a4wide.sty o. ae. Geruempel

\AtBeginDocument{\Kickst@rt}

\newcommand{\Kickst@rt}{%
  \jb@detectlanguage%
  \ifcase\value{jb@languageloaded}%
    \addto\captionsgerman{\renewcommand{\partname}{Teil:}}%
    \selectlanguage{german}%
  \or%
    \addto\captionsngerman{\renewcommand{\partname}{Teil:}}%
    \selectlanguage{ngerman}%
  \else%
    \renewcommand{\partname}{Teil:}% german or ngerman package loaded
  \fi%
  \setchaptername{\textsection}%
  \SetJuboPagestyle%
  \if@longfnrule%   Paketoption 'longfnrule' = TRUE? 
    \renewcommand{\footnoterule}{%
      \kern-3\p@%
      \hrule\@width\columnwidth%
      \kern2.6\p@}%
  \fi%
  \@ifpackageloaded{jurabib}{\@jurabibloadedtrue}{\@jurabibloadedfalse}%
  \@ifpackageloaded{hyperref}{\@hyperrefloadedtrue}{\@hyperrefloadedfalse}%
  \@ifundefined{url}%
    {\ClassWarningNoLine{jurabook}%
       {You should either load the 'jurabib' package\MessageBreak
        or the 'url' package. Now, I will use a faked and\MessageBreak
        improper version of the \string\url\space command}%
       \providecommand{\url}[1]{{\ttfamily ##1}}%
       \providecommand{\urldef}[2]{\@gobble{##1}\@gobble{##2}}% huh?
    }%
    {\relax}%
  \renewcommand{\@pnumwidth}{2em}% statt 1.55
  \renewcommand{\@tocrmarg}{4em}%  statt 2.55
  \setlength{\jb@proofmodetextwidth@length}{.77\textwidth}%
  \setlength{\jb@proofmodeleftmargin@length}{\z@}%
}


% some report output:
\AtEndDocument{%
  \wlog{--------------}
  \wlog{jurabook info:}
  \wlog{--------------}
  \ifjpdf
    \wlog{The document was set using pdftex in pdf mode.}
  \else
    \wlog{The document was set using tex/pdftex in dvi mode.}
  \fi  
  \wlog{\therealchapters\space chapters, \thetotalsections\space sections.}
  \wlog{\therunner\space paragraphs with runner.}
  \wlog{\thetotalfootnotes\space footnotes.}
  \wlog{\thetotaldcs\space decisions (\thetotaldecisions\space mentioned, \thetotalnotyets\space not mentioned).}%
  \wlog{\thetotalwebcites\space WWW cites within document.}
  \if@dorunners
    \wlog{You are using runners.}
  \else
    \wlog{No runners used.}
  \fi
  \if@indexpagenumbers
    \wlog{Pagenumbers written to index.}
  \else
    \wlog{Runners written to index.}
  \fi%
  \if@compactlayout
    \wlog{Compact layout used.}
  \fi
  \if@centeredlayout
    \wlog{Centered layout used.}
  \fi  
}

%================================================================================
%               
% Hier beginnen die eigentlichen Befehle 
%
%================================================================================


%============================================
%  Support Macros
%============================================

% used by commands with two optional arguments
\newcommand{\@@firstopt}{}


% style commands
%
% every style command has the following format:
%  \jb @ element @ style 
%
% Example: \jb@title@style


% \setjbookstyle{elemt}{styledef}
%                #1     #2


\newcommand{\setjbookstyle}[2]{%
  \@ifundefined{jb@#1@style}%
    {\ClassWarningNoLine{jurabook}%
     {You are trying to set the element\MessageBreak
      '#1'\MessageBreak
      using the \protect\setjbookstyle\space command,\MessageBreak
      but jurabook does not know this element}}%
    {\expandafter\def\csname jb@#1@style\endcsname{#2}%
     \ClassInfo{jurabook}{redefining #1 style (-> \protect #2)}}%
}


% length command
%
% every length has the following format:
%  \jb @ element @ length 
%
% Example: \jb@chapterbefore@length


% \setjbooklength{element}{lengthvalue}
%                 #1       #2

\newcommand{\setjbooklength}[2]{%
  \@ifundefined{jb@#1@length}%
    {\ClassWarningNoLine{jurabook}%
     {You are trying to set the element\MessageBreak
      '#1'\MessageBreak
      using the \protect\setjbooklength\space command,\MessageBreak
      but jurabook does not know this element}}%
    {\csname jb@#1@length\endcsname=#2%
     \ClassInfo{jurabook}{redefining #1 length (-> #2)}}%
}

% set text command
%
% every text has the following format:
%  \jb @ element @ text
%
% Example: \jb@maketime@text


% \setjbooktext{element}{textstring}
%               #1       #2

\newcommand{\setjbooktext}[2]{%
  \@ifundefined{jb@#1@text}%
    {\ClassWarningNoLine{jurabook}%
     {You are trying to set the element\MessageBreak
      '#1'\MessageBreak
      using the \protect\setjbooktext\space command,\MessageBreak
      but jurabook does not know this element}}%
    {\expandafter\def\csname jb@#1@text\endcsname{#2}%
     \ClassInfo{jurabook}{Setting #1 text (-> "#2")}}%
}

%============================================
%               
%  titles
%
%============================================


\iffalse

  Three ways to set a title
  
  1. Standard title - used as ususal, with some extra fields (see below)
  2. RuW title - switched on with option 'ruwtitle' (not documentated)
  3. Official title in external file - use with \officaltitle

  Some extra fields
    
  \subtitle{text}
            #1
            
  A subtitle is optional. We don't use exactly
  the same code as in latex.ltx, because
  latex.ltx fails if \@title is not set.
  

  \publishinfo{text}
               #1
            
  To print out the publishing company, typeset in the lower margin.
              
\fi


\newcommand*{\jb@officialtitle@style}{\large}

\if@classiclayout
  \newcommand*{\jb@title@style}{\LARGE}
  \newcommand*{\jb@subtitle@style}{\large}
  \newcommand*{\jb@author@style}{\large}
  \newcommand*{\jb@titledate@style}{\large}
\else
  \newcommand*{\jb@title@style}{\Huge\bfseries}
  \newcommand*{\jb@subtitle@style}{\Large}
  \newcommand*{\jb@author@style}{\Large}
  \newcommand*{\jb@titledate@style}{\large}
\fi
\newcommand*{\jb@publishinfo@style}{\Large}
\newcommand*{\jb@publishplace@style}{\Large}
\newcommand*{\jb@thanks@style}{\normalsize}
\newcommand*{\jb@from@style}{\normalsize}
\newcommand*{\jb@subauthor@style}{\jb@from@style}
  
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\@subtitle{}
\def\subauthor#1{\gdef\@subauthor{#1}}
\def\@subauthor{}
\def\publishinfo#1{\gdef\@publishinfo{#1}}
\def\@publishinfo{}
\def\birthplace#1{\gdef\@birthplace{#1}}
\def\@birthplace{}
\def\publishplace#1{\gdef\@publishplace{#1}}
\def\@publishplace{}
\def\publishyear#1{\gdef\@publishyear{#1}}
\def\@publishyear{\the\year}

\newcommand*{\firstexaminername}{Berichterstatter:}
\newcommand*{\secondexaminername}{Mitberichterstatter:}
\def\firstexaminer#1{\gdef\@firstexaminer{#1}}
\def\@firstexaminer{}
\def\secondexaminer#1{\gdef\@secondexaminer{#1}}
\def\@secondexaminer{}
\def\examdate#1{\gdef\@examdate{#1}}
\def\@examdate{\today}


\newcommand{\@use@title@standard}{%
  \renewcommand{\maketitle}{%
    \begin{titlepage}%
      \let\footnotesize\small
      \let\footnoterule\relax
      \let \footnote \thanks
      \null\vfil%
      %\vskip 60\p@
      \begin{center}%
      \if@classiclayout% original definition: 
        {\jb@title@style\@title\par}%
        \ifx\@subtitle\@empty% \ifthenelse funzt hier nicht wg. moegl. '\\'
        \else%
          {\jb@subtitle@style\vskip 4ex\@subtitle\par}%
        \fi%
        {\jb@author@style%
         \vskip 8ex von\par
         \vskip 1ex%
         \lineskip .75em%
         \begin{tabular}[t]{c}%
           \@author
         \end{tabular}\par%
        }% 
        \ifx\@subauthor\@empty% 
        \else%
          {\jb@subauthor@style%
           \vskip 1ex
           \begin{tabular}[t]{c}%
             \@subauthor
           \end{tabular}\par}%
        \fi%
        \vskip 1.5em%
        {\jb@titledate@style\@date\par}%
      \else % slightly modernized:
        {\jb@title@style\vskip 2ex \@title\par}%
        \ifx\@subtitle\@empty% \ifthenelse funzt hier nicht wg. moegl. '\\'
        \else
          {\jb@subtitle@style\vskip 4ex\@subtitle \par}%
        \fi%
        {\jb@from@style\vskip 8ex von\par}%
        {\jb@author@style
         \vskip 1ex%
         \lineskip .75em%
         \begin{tabular}[t]{c}%
           \@author
         \end{tabular}\par%
        } 
        \ifx\@subauthor\@empty% 
        \else%
          {\jb@subauthor@style%
           \vskip 1ex
           \begin{tabular}[t]{c}%
             \@subauthor
           \end{tabular}\par}%
        \fi%
        \vskip 1.5em% 
        {\jb@titledate@style\@date\par}%     
      \fi%
      \end{center}\par  
      {\jb@thanks@style\@thanks\par}
      \ifx\@publishinfo\@empty%
        {\vfil\null}%
      \else% 
        \vfill%
        {\hfil\jb@publishinfo@style\@publishinfo\hfil}%
        \ifx\@publishplace\@empty%
        \else%
          {\vskip 1ex\hfil\jb@publishplace@style\@publishplace\hfil}%
        \fi%
      \fi%
      \@emptytitles  
    \end{titlepage}%
  }%
}

\newcommand{\@use@title@ruw}{%
  \renewcommand{\maketitle}{%
    \begin{titlepage}%
      \let\footnotesize\small
      \let\footnoterule\relax
      \let \footnote \thanks
      {\centering%
        \vspace*{\jb@chapterbefore@length}%
        {\jb@title@style\@title\par}%
        \ifx\@subtitle\@empty% \ifthenelse funzt hier nicht wg. moegl. '\\'
        \else
          {\jb@subtitle@style\vskip 4ex\@subtitle \par}%
        \fi%
        {\jb@from@style\vskip 8ex von\par}%
        {\jb@author@style
         \vskip 1ex%
         \lineskip .75em%
         \begin{tabular}[t]{c}%
           \@author
         \end{tabular}\par%
        } 
        \ifx\@subauthor\@empty% 
        \else%
          {\jb@subauthor@style%
           \vskip 1ex
           \begin{tabular}[t]{c}%
             \@subauthor
           \end{tabular}\par}%
        \fi%
        \vfill
        \begin{tabular}[t]{c}%
          \usebox{\titlepublisherbox}
        \end{tabular}%
      \par}  
    \@emptytitles%
    \end{titlepage}%
  }%
}

\newcommand{\officaltitle}[1]{% 
  \InputIfFileExists{jb#1.clo}%
    {\relax % information is given within the clo-file
    }%
    {\ClassError{jurabook}%
        {You request an official titlepage,\MessageBreak
         but I cannot find the corresponding\MessageBreak
         file 'jb#1.clo'}%
        {Get 'jb#1.clo' from CTAN or www.sodtalbers.de/tex\MessageBreak
         or use another title format.}%
    }%
}

\if@titlepage%
  \if@ruwtitle% 
     \@use@title@ruw%
   \else%
     \@use@title@standard
  \fi% 
\else % option 'notitlepage' is set - jurabook will terminate!
  \ClassError{jurabook}%
    {jurabook does not support the 'notitlepage' option.}%
    {Remove 'notitlepage' option or use the original book class.}%
\fi

\newcommand{\@emptytitles}{%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\@subtitle\@empty
  \global\let\@publishinfo\@empty  
  \global\let\@birthplace\@empty
  \global\let\@publishplace\@empty
  \global\let\@publishyear\@empty
  \global\let\@firstexaminer\@empty
  \global\let\@secondexaminer\@empty
  \global\let\@examdate\@empty
  \global\let\subtitle\relax
  \global\let\publishinfo\relax  
  \global\let\birthplace\relax
  \global\let\publishplace\relax
  \global\let\publishyear\relax
  \global\let\firstexaminer\relax
  \global\let\secondexaminer\relax  
  \global\let\examdate\relax%
}
  

%============================================
%               
%  Seitenlayout
%
%============================================


%========================================
% Umschalten auf 1 1/2 Zeilenabstand
%========================================

\iffalse
 vgl. Begleiter 90, 52
 
 linespread statt baselinestretch?
\fi

\providecommand{\onehalfspacing}{% 
  \normalsize
  \ifthenelse{\@ptsize = 0}% 10pt
    {\renewcommand{\baselinestretch}{1.25}}%
    {}
  \ifthenelse{\@ptsize = 1}% 11pt
    {\renewcommand{\baselinestretch}{1.21}}%
    {}
  \ifthenelse{\@ptsize = 2}% 12pt
    {\renewcommand{\baselinestretch}{1.24}}%
    {}
  \normalsize  
}

\providecommand{\onespacing}{% den Spass wieder zurueck auf einzeilig
  \renewcommand{\baselinestretch}{\m@ne}%
  \normalsize}


%========================================
% Fussnoten
%========================================

\newcounter{totalfootnotes}\setcounter{totalfootnotes}{\z@}
\newif\if@infootnote
\@infootnotefalse

\newlength{\fnlabelwidth}
\if@fncontinued
  \settowidth{\fnlabelwidth}{\footnotesize 9999}%
\else%
  \settowidth{\fnlabelwidth}{\footnotesize 999}%
\fi   

\if@oldfootnotes% Paketoption 'oldfootnotes' = TRUE?
% hier das 'altmodische' Layout
% identisch mit LaTeX-Vorgabe, aber einzeilig
  \renewcommand{\@makefntext}[1]{%
    \stepcounter{totalfootnotes}%
    \renewcommand{\baselinestretch}{\@ne}% (nur) dieses hinzugefuegt fuer einzeilige Ausgabe
    \parindent 1em%
    \noindent%
    \@infootnotetrue%
    \hb@xt@1.8em{\hss\@makefnmark}#1%
    \@infootnotefalse}
\else%
  \newlength{\fnmarksep} % Platz zwischen Fussnote und Fussnotentext
  \setlength{\fnmarksep}{3pt}%
  \renewcommand{\@makefntext}[1]{%
    \stepcounter{totalfootnotes}%
    \renewcommand{\baselinestretch}{\@ne}%
    \setlength{\parindent}{\z@}%
    \begin{list}{}{%
      \setlength{\labelwidth}{\fnlabelwidth}%
      \setlength{\leftmargin}{\labelwidth}%
      \addtolength{\leftmargin}{\fnmarksep}%
      \setlength{\labelsep}{\leftmargin}%
      \addtolength{\labelsep}{-\labelwidth}%
      \setlength{\itemsep}{\z@}%
      \setlength{\itemindent}{\z@}%
      \setlength{\parsep}{\z@}%
      \setlength{\topsep}{\z@}%
      \setlength{\partopsep}{\z@}%
      \footnotesize}%
      \item[\hfill\@makefnmark]\@infootnotetrue #1\@infootnotefalse%
    \end{list}%
    }
\fi

\let\fussnote=\footnote % for historic reasons! :-)


%============================================
%               
%  Kopf- und Fusszeilen / Kolummentitel
%
%============================================

\iffalse
  mit fancyhdr-Paket
  
 (Begleiter 96f., Loesung S. 99 Abb 4.6
 

 twoside
 =======
  
 | Even:                           | Odd			                  |
 |                                 |                                  |
 | PageNo     § x chapter          |           II. section     PageNo |
 ----------------------------------------------------------------------
 |                                 |                                  |
 
 
 oneside (e.g. pdf screen versions)
 =======

 |                                 | 
 |                                 | 
 |            § x chapter          | 
 -----------------------------------
 |                                 |  
 |                                 |
 -----------------------------------
 |                                 |
 |            PageNo               |


 
 (P): \pagestyle{fancyplain} setzt jedes mal die Kolumnentitel neu
 \renewcommand innerhalb eines \newcommand klappt nicht,
 deshalb Rueckgriff auf ##1 !

\fi

\newcommand*{\jb@maketime@text}{\today}
\newcommand*{\jb@maketimename@text}{Stand:}
\newcommand*{\jb@maketime@style}{\small\itshape}

\newcommand{\setmaketime}[1]{%
  \ClassError{jurabook}%
    {\protect\setmaketime is obsolete, please use \protect\setjbooktext{maketime}{mytext}}
    {Use \protect\setjbooktext{maketime}{mytext}}
}


\newcommand{\SetJuboPagestyle}{%
  \pagestyle{fancy}%
  \if@classiclayout
    \fancyhead{}
    \if@printmaketime
      \fancyhead[LE,RO]{\jb@maketime@style\jb@maketimename@text\space\jb@maketime@text}
    \fi
    \fancyfoot{}
    \fancyfoot[LE,RO]{\thepage}
    \renewcommand{\headrulewidth}{0pt}%
  \else% 
    \if@seminar
      \def\sectionmark##1{\markboth{\thesection\space ##1}{\thesection\space ##1}}%
      \def\subsectionmark##1{\markright{\thesubsection\space ##1}}%
    \else%
      \def\chaptermark##1{\markboth{\jubo@chaptercomplete\quad ##1}{}}%
      \def\sectionmark##1{\markright{\thesection\space ##1}}%
    \fi%
    \fancyhead{}
    \if@twoside
      \fancyhead[LE,RO]{\thepage}
      \fancyhead[CE]{\leftmark}
      \fancyhead[CO]{\rightmark}
      \fancyfoot{}
      \if@printmaketime
        \fancyfoot[LE,RO]{\jb@maketime@style\jb@maketimename@text\space\jb@maketime@text}
      \fi
%     \headrulewidth (Strich in der Kopfzeile) bleibt auf default wert 0.4pt
    \else
      \chead{\leftmark}
      \cfoot{\thepage}
      \if@printmaketime
        \rfoot{\jb@maketime@style\jb@maketimename@text\space\jb@maketime@text}
      \fi
    \fi
  \fi%
}

\iffalse
 Vergroessern der Kopfhoehe, um Fehlermeldungen von 'fanychdr' zu vermeiden
 (vgl.  fanychdr.dvi, p. 12)
 bei 10pt ist das nicht notwendig
\fi

\ifthenelse{\@ptsize = 1}%            11pt? (gilt fuer ec-Schrift)
  {\addtolength{\headheight}{1.6\p@}}% otherwise 'Overfull \vbox (1.59999pt too high) ...'
  {}
\ifthenelse{\@ptsize = 2}%            12pt?
  {\addtolength{\headheight}{2.5\p@}}% otherwise 'Overfull \vbox (2.49998pt too high) ...'
  {}


\iffalse
  Folgender Trick ist unmittelbar geklaut aus:
  Kloeckl, 3.4.3, S. 116 ff.
  fancyhdr.pdf, chapter 14
  
  Bewirkt, dass leere Seiten nach \chapter
  keine Kolumnentitel enthalten.
  
  Wird implizit von \chapter aufgerufen.
\fi


\renewcommand{\cleardoublepage}{%
  \clearpage%
  \if@twoside%
    \ifodd\c@page%
    \else%
      \jubo@thispagestyle@empty%
      \mbox{}\newpage%
      \if@twocolumn\mbox{}\newpage\fi % really necessary?!
    \fi%
  \fi%
}



%========================================
% Runners
%========================================

% (siehe auch Begleiter 74)

% Randnummernzaehler:
\newcounter{runner}
\renewcommand{\therunner}{\arabic{runner}}

% Zaehler fuer nachtraeglich eingefuegte Rn.
\newcounter{extrarunner}[runner]
\renewcommand{\theextrarunner}{\therunner\alph{extrarunner}}

% Wird beim Referenzieren benoetigt:
\newcommand*{\jb@rn@text}{Rn.}
\newcommand*{\jp@page@text}{S.} 

% extraspace between text and runner
%   text text text|--|12

\newlength{\jb@runnersspace@length}
\setlength{\jb@runnersspace@length}{.5em}%= 0.5quad

\iffalse Randnnummer setzen

  \rn[marke]{Erstes} Wort, denn hier faengt der Absatz an
      #1     #2
  
  #1: Marke (optional, default: keine Marke)
  #2: Das Wort, mit dem der Absatz eingeleitet wird.

\fi

\newcommand*{\rn}[2][]{%
  \if@dorunners%
    \stepcounter{runner}%
    #2\marginpar%
      [\hfill{\bfseries\therunner}\hspace*{\jb@runnersspace@length}]%
      {\hspace*{\jb@runnersspace@length}{\bfseries\therunner}\hfill}%
    \protected@edef\@currentlabel{\therunner}%
  \else%
    #2
  \fi% do NOT delete the percentage sign
  \ifthenelse{\equal{#1}{\@empty}}%
    {}% nix
    %else
    {\label{#1}}%
}


\iffalse nachtraeglich Randnummer einfuegen (fuer 2. Auflage, sonst sinnlos)

  \extrarn[marke]{Erstes} Wort, denn hier faengt der Absatz an
           #1     #2

  #1: Marke (optional, default: keine Marke)
  #2: Das Wort, mit dem der Absatz eingeleitet wird.
  
  Der stepcounter-Befehl muss auch hier am Anfang erscheinen,
  Weil sonst es nicht auf 'a' gesetzt wird (0<>a).
  
  UNGETESTET!
\fi

\newcommand*{\extrarn}[2][]{%
  \stepcounter{extrarunner}#2\marginpar%
  [\hfill{\bfseries\theextrarunner}\hspace*{\jb@runnersspace@length}]%
  {\hspace*{\jb@runnersspace@length}{\bfseries\theextrarunner}\hfill}%
% hiermit entsprechender Eintrag in toc:
  \protected@edef\@currentlabel{\therunner\theextrarunner}
  \ifthenelse{\equal{#1}{\@empty}}%
    {}% nix!
  %else
    {\label{#1}}%
  }
  

\iffalse Randnummer referenzieren

  \mnref{marke}
         #1

  #1: Bezeichnung der Marke, auf die verwiesen wird
  
  \mnreff setzt autom. ein 'f.' dahinter,
  \mnrefff ein 'ff.'
\fi

\newcommand{\rnref}[1]{%
  \if@dorunners%
    \if@rnrefbold% Paketoption 'rnefbold' = TRUE? 
      {\bfseries\jb@rn@text~\ref{#1}}%
    \else%
      \jb@rn@text~\ref{#1}%
    \fi
  \else
    \jb@page@text~\ref{#1}%  
  \fi%
  }
  
\newcommand{\rnreff}[1]{%
  \rnref{#1}~f.}

\newcommand{\rnrefff}[1]{%
  \rnref{#1}~ff.}

\newcommand*{\dnrefname}{unten}
\newcommand*{\uprefname}{oben}

\newcommand*{\autornref}[1]{%
}    
   
%========================================
%               
% Bucheinteilungen (Matters)
%
%========================================

% Am Buchanfang wird immer mit grossen Roemischen Zahlen paginiert:

\renewcommand{\frontmatter}{%
  \cleardoublepage%
  \@mainmatterfalse%
  \pagenumbering{Roman}%
}

% main matter faengt nicht wieder bei 1 an.???

\renewcommand{\mainmatter}{%
  \@ifstar{\jb@mainmatters}{\jb@mainmatter}
}
  
\newcommand{\jb@mainmatter}{%
  \cleardoublepage%
  \@mainmattertrue%
  \setcounter{page}{\@ne}% 
  \pagenumbering{arabic}%
}


\newif\if@jubo@proofmode
\@jubo@proofmodefalse
\newlength{\jb@proofmodetextwidth@length}
\newlength{\jb@proofmodeleftmargin@length}

\newlength{\jb@textwidth}
\newlength{\jb@columnwidth}
\newlength{\jb@hsize}
\newlength{\jb@linewidth}
\newlength{\jb@headwidth}
\newlength{\jb@evensidemargin}
\newlength{\jb@oddsidemargin}

\newcommand{\jb@mainmatters}{%
  \jb@mainmatter%
  \ClassWarningNoLine{jurabook}%
     {\protect\mainmatter* command is switching to proof mode,\MessageBreak
      text will by typeset in a rather small column.\MessageBreak
      (textwidth=\the\jb@proofmodetextwidth@length)\MessageBreak
      From now on, EVERYTHING can happen ..}%
  \if@twoside
    \ClassWarningNoLine{jurabook}%
     {When using \protect\mainmatter*, please\MessageBreak
      use the 'oneside' option also}%
  \fi    
  \@jubo@proofmodetrue%   
  % don't try this at home ... =:O
  \setlength{\jb@textwidth}{\textwidth}%
  \setlength{\jb@columnwidth}{\columnwidth}%
  \setlength{\jb@hsize}{\hsize}%
  \setlength{\jb@linewidth}{\textwidth}%
  \setlength{\jb@headwidth}{\headwidth}%
  \setlength{\jb@evensidemargin}{\evensidemargin}%
  \setlength{\jb@oddsidemargin}{\oddsidemargin}%
  \setlength{\textwidth}{\jb@proofmodetextwidth@length}%
  \setlength{\columnwidth}{\textwidth}%
  \setlength{\hsize}{\textwidth}%
  \setlength{\linewidth}{\textwidth}% 
  \setlength{\headwidth}{\textwidth}%
  \setlength{\evensidemargin}{\jb@proofmodeleftmargin@length}%
  \setlength{\oddsidemargin}{\jb@proofmodeleftmargin@length}%
}

\renewcommand{\backmatter}{%
  \if@jubo@proofmode%
    \ClassWarningNoLine{jurabook}%
      {Leaving proof mode, switching back to\MessageBreak
       normal textwidth}%
    \setlength{\textwidth}{\jb@textwidth}%
    \setlength{\columnwidth}{\jb@columnwidth}%
    \setlength{\hsize}{\jb@hsize}%
    \setlength{\linewidth}{\jb@linewidth}% 
    \setlength{\headwidth}{\jb@headwidth}%
    \setlength{\evensidemargin}{\jb@evensidemargin}%
    \setlength{\oddsidemargin}{\jb@oddsidemargin}%
  \fi%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse%
  \@jubo@proofmodefalse%
}


%==============================================
%               
% Inhaltsverzeichnis und (optionale) Uebersicht
%
%==============================================

\iffalse
  alles wie im original book.cls, 
  aber ohne die \MakeUppercase Befehle
\fi

\renewcommand{\tableofcontents}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \@chapter@withoutnumber@notoc{\contentsname}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi%
}


%====================================================
% Ausgabe der Inhaltsuebersicht 
%====================================================

\iffalse
 Grds.: werden hier nur die Chapter aufgelistet
 Ausn.: 'overviewwithsec'-Option gesetzt, dann
        auch Sections.

 (zur Loesung Begleiter 37 ff.)
\fi

\newcommand*{\jb@overview@text}{Inhalts\"ubersicht}
\newcommand{\overview}{% geklaut aus book.cls, ohne \makeuppercase
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi%
  \@chapter@withoutnumber@notoc{\jb@overview@text}%
  \@starttoc{ovw}%
  \if@restonecol\twocolumn\fi%
}


%========================================
%               
% Parts and Chapters 
%
%========================================


% putting linefeeds into headings
\newcommand{\hnewline}{\relax}
\newcommand{\@@part@hnewline}{\par}
\if@centeredlayout
  \newcommand{\@@chapter@hnewline}{\par}
\else
  \newcommand{\@@chapter@hnewline}{\newline}
\fi


\iffalse
 copied from book.tex and modified:
 
 \part{Einfuehrung} -> 'Erster Teil: Einfuehrung'
 
\fi

%========================================
% Parts
%========================================

\renewcommand{\thepart}{%
  \ifcase\value{part} 
  \or Erster%
  \or Zweiter%
  \or Dritter%
  \or Vierter%
  \or F\"unfter%
  \or Sechster%
  \or Siebter%
  \or Achter%
  \or Neunter%
  \or Zehnter%
  \or Elfter%
  \or Zw\"olfter%
  \else%
    \ClassError{jurabook}%
      {Too many parts.}%
      {Contact juramisc@sodtalbers.de!}
  \fi%
}


% soll chapter-Befehl einen Seitenwechsel ausloesen?
% abhaengig von Option 'compact': 
%   wenn 'compact'=TRUE, 
%     dann nach part nicht auf eigene Seite

\newif\if@chapterclearpage 
\@chapterclearpagetrue


%  \part[intext]{text}
%        #1      #2
%
%  'text' (#2) is put into the toc in any case
%  pagestyle is 'empty' (not 'plain', as in book.cls)    

\renewcommand{\part}{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \chapterlevel%
  \jubo@thispagestyle@empty%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi%
  \if@compactlayout%
    \@chapterclearpagefalse%
  \else%
    \@chapterclearpagetrue%
    \null\vfil%
  \fi% 
  \secdef\@part\@spart%
}
  
  
\newcommand{\jb@partintro@style}{\huge\bfseries}
\newcommand{\jb@part@style}{\Huge\bfseries}

% opt         #1: title in text, possibly incl. \hnewline = \par
%             #2: title

\renewcommand{\@part}[2][]{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \if@centeredpartsintoc%
      \addtocontents{toc}{\protect\@partlinecenter{\thepart\space\partname}{#2}}%
      \addtocontents{ovw}{\protect\@partlinecenter{\thepart\space\partname}{#2}}%
    \else%
      \addcontentsline{toc}{part}{\thepart\space\partname\space #2}%
      \addcontentsline{ovw}{part}{\thepart\space\partname\space #2}%
    \fi%
  \else%
     \addcontentsline{toc}{part}{#2}%
     \addcontentsline{ovw}{part}{#2}%
  \fi%
  \markboth{}{}%
  \begingroup%
    \centering%
    \interlinepenalty \@M%
    \normalfont%
    \ifnum \c@secnumdepth >-2\relax
      \jb@partintro@style\thepart~\partname\ 
      \par
      \vskip 20\p@
    \fi
    \jb@part@style%
    \ifthenelse{\equal{#1}{\@empty}}%
      {#2\par}%
      {\let\hnewline\@@part@hnewline%
       #1\par}%
  \endgroup
  \@endpart%
}

\renewcommand{\@endpart}{%
  \if@compactlayout%
    \vskip \baselineskip%
  \else%
    \vfil\vfil% one more vfil than in original book.cls
    \newpage%
    \if@twoside%
      \null%
      \jubo@thispagestyle@empty%
      \newpage%
    \fi%
  \fi%
  \if@tempswa%
    \twocolumn%
  \fi%
}


%========================================
% Grundlegende Einstellungen fuer
% chapter, sections, subsections ...
%========================================

\newlength{\chapternumwidth}
\newlength{\sectionnumwidth}
\newlength{\subsectionnumwidth}
\newlength{\subsubsectionnumwidth}
\newlength{\subthreesectionnumwidth}
\newlength{\subfoursectionnumwidth}
\newlength{\subfivesectionnumwidth}
\newlength{\subsixsectionnumwidth}
\newlength{\subsevensectionnumwidth}
\newlength{\subeightsectionnumwidth}

\newlength{\sectiontocindent}
\newlength{\subsectiontocindent}
\newlength{\subsubsectiontocindent}
\newlength{\subthreesectiontocindent}
\newlength{\subfoursectiontocindent}
\newlength{\subfivesectiontocindent}
\newlength{\subsixsectiontocindent}
\newlength{\subsevensectiontocindent}
\newlength{\subeightsectiontocindent}
\newlength{\paragraphtocindent}
\newlength{\subparagraphtocindent}

\newlength{\jb@defaulttocindent@length}
\setlength{\jb@defaulttocindent@length}{1.5em}


% Folgendes wird auf jeden Fall in 
% \Kickst@rt / AtBeginDocument aufgerufen:

\newcommand{\jubo@settocindents}{%
  \if@chapterprefix%
    \settowidth{\chapternumwidth}{\chaptername~999\chapterextra\space}% warum drei x 9? zweimal ist zu knapp
  \else% chaptersuffix:
    \settowidth{\chapternumwidth}{999.~\chaptername\chapterextra\space}%
  \fi%
  \settowidth{\sectionnumwidth}{VIII.\ }%
  \settowidth{\subsectionnumwidth}{88.\ }%
  \settowidth{\subsubsectionnumwidth}{b)\ }%
  \settowidth{\subthreesectionnumwidth}{bb)\ }%
  \settowidth{\subfoursectionnumwidth}{bbb)\ }%
  \settowidth{\subfivesectionnumwidth}{(88)\ }%
  \settowidth{\subsixsectionnumwidth}{(b)\ }%
  \settowidth{\subsevensectionnumwidth}{(bb)\ }%
  \settowidth{\subeightsectionnumwidth}{(bbb)\ }%
  \if@chapterprefix%
    \setlength{\sectiontocindent}{\chapternumwidth}%
  \else%
    \settowidth{\@tempdima}{\bfseries 99.\space}%
    \setlength{\sectiontocindent}{\@tempdima}%  
  \fi  
  \if@fixtocindent%
    \setlength{\sectiontocindent}{\jb@defaulttocindent@length}% = 1.5em per default
  \fi%  
  \setlength{\subsectiontocindent}{\sectiontocindent}%
  \addtolength{\subsectiontocindent}{\sectionnumwidth}%
  \setlength{\subsubsectiontocindent}{\subsectiontocindent}%
  \addtolength{\subsubsectiontocindent}{\subsectionnumwidth}%
  \setlength{\subthreesectiontocindent}{\subsubsectiontocindent}%
  \addtolength{\subthreesectiontocindent}{\subsubsectionnumwidth}%
  \setlength{\subfoursectiontocindent}{\subthreesectiontocindent}%
  \addtolength{\subfoursectiontocindent}{\subthreesectionnumwidth}%
  \setlength{\subfivesectiontocindent}{\subfoursectiontocindent}%
  \addtolength{\subfivesectiontocindent}{\subfoursectionnumwidth}%
  \setlength{\subsixsectiontocindent}{\subfivesectiontocindent}%
  \addtolength{\subsixsectiontocindent}{\subfivesectionnumwidth}%
  
  \setlength{\subsevensectiontocindent}{\subsixsectiontocindent}%
  \addtolength{\subsevensectiontocindent}{\subsixsectionnumwidth}%
  
  \setlength{\subeightsectiontocindent}{\subsevensectiontocindent}%
  \addtolength{\subeightsectiontocindent}{\subsevensectionnumwidth}%
  
  \setlength{\paragraphtocindent}{\subeightsectiontocindent}%
  \addtolength{\paragraphtocindent}{\subeightsectionnumwidth}%
  
  \setlength{\subparagraphtocindent}{\paragraphtocindent}%
  \addtolength{\subparagraphtocindent}{\jb@defaulttocindent@length}%
}  


%========================================               
% Chapters 
%========================================

\iffalse
  Neudefinition der Kapitelueberschriften (aus 'book.cls'):
  - kein einzelnes "Kapitel X" mehr
  - stattdessen: § 2 (...) (default)
  - bringt *stets* die lange Kapitel-Ueberschrift ins Inhaltsverzeichnis
  - pagestyle ist empty (nicht: plain)
  
  \renewcommand*{\chaptername}{\textsection} -> oben in AtBeginDocument
  
  Siehe auch oben die Neudefinition von \cleardoublepage{}

  Kloeckl S. 90: Format der Ueberschriften und der Nummern  
 
  \@makechapterhead{text}
                    #1

  \@chapapp   -> \chaptername -> '\textsection' -> '§'
  \thechapter =  Kapitelnummer.
  #1          =  Ueberschrift
 
\fi

\newcommand{\chapterextra}{}

% \setchaptername[#1]{#2}
% #1 -> prefix
% #2 -> chaptername (default: \textsection)

\newcommand{\setchaptername}[2][]{%
  \ifcase\value{jb@languageloaded}%
    \addto\captionsgerman{\renewcommand{\chaptername}{#2}}%
    \selectlanguage{german}%
  \or%
    \addto\captionsngerman{\renewcommand{\chaptername}{#2}}%
    \selectlanguage{ngerman}%
  \else%
    \renewcommand{\chaptername}{#2}%
  \fi%
  \renewcommand{\chapterextra}{#1}%
  \jubo@settocindents%
} 

\renewcommand{\thechapter}{\arabic{chapter}}

\newcounter{realchapters}
\setcounter{realchapters}{\z@}

\newcommand{\jubo@chaptercomplete}{}
\newcommand{\make@jubo@chaptercomplete}{%
  \if@chapterprefix%
    \renewcommand{\jubo@chaptercomplete}{\@chapapp~\thechapter\chapterextra}
  \else%
    \renewcommand{\jubo@chaptercomplete}{\thechapter.~\@chapapp\chapterextra}
  \fi%
  }
\newlength{\@chaptercompletelength}


\renewcommand{\chapter}{%
  \if@chapterclearpage%
    \if@openright\cleardoublepage\else\clearpage\fi%
  \else%
    \@chapterclearpagetrue%
  \fi%
  \chapterlevel%
  \jubo@thispagestyle@empty%
  \global\@topnum\z@%
  \@afterindentfalse
  \secdef\@chapter\@schapter%
}


\renewcommand{\@chapter}[1][]{%
  \renewcommand{\@@firstopt}{#1}%
  \@@chapter%
}


% opt @@firstopt: shorttitle
% opt         #1: title in text, possibly incl. \hnewline = \par
%             #2: title

\newcommand{\@@chapter}[2][]{%
  \stepcounter{realchapters}%
  \setcounter{current@level}{\z@}%
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \make@jubo@chaptercomplete%
      \refstepcounter{chapter}%
      \if@chapterprefix%
        \typeout{Chapter\space\thechapter\chapterextra}%
      \else
        \typeout{\thechapter.\space Chapter\chapterextra}%
      \fi  
      \addcontentsline{toc}{chapter}{%
         \protect\numberline{\jubo@chaptercomplete}#2}%
      \addcontentsline{ovw}{ovwchapter}{% Overview
         \protect\numberline{\jubo@chaptercomplete}#2}%
    \else%
      \addcontentsline{toc}{chapter}{#2}%
      \addcontentsline{ovw}{ovwchapter}{#2}% 
    \fi%
  \else%
    \addcontentsline{toc}{chapter}{#2}%
    \addcontentsline{ovw}{chapter}{#2}%
  \fi
  \ifthenelse{\equal{\@@firstopt}{\@empty}}%
    {\chaptermark{#2}}% else
    {\chaptermark{\@@firstopt}}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn%
    \ifthenelse{\equal{#1}{\@empty}}%
      {\@topnewpage[\@makechapterhead{#2}]}%
      {\let\hnewline\@@chapter@hnewline%
       \@topnewpage[\@makechapterhead{#1}]}  
  \else%
    \ifthenelse{\equal{#1}{\@empty}}%
      {\@makechapterhead{#2}}%
      {\let\hnewline\@@chapter@hnewline%
       \@makechapterhead{#1}}%
    \@afterheading%
  \fi%
}


% this is inserted before chapter's title is given out ...
\newlength{\jb@chapterbefore@length}
\setlength{\jb@chapterbefore@length}{50\p@}

\newcommand{\chapterstartspace}{
  \vspace*{\jb@chapterbefore@length}%
}
  
% ... and this after chapter's title
\newlength{\jb@chapterafter@length}
\setlength{\jb@chapterafter@length}{40\p@}

\newcommand{\jb@chapter@style}{\huge\bfseries}

\renewcommand{\@makechapterhead}[1]{%
  \make@jubo@chaptercomplete%
  \chapterstartspace%
  \if@centeredlayout%
    {\centering \normalfont%
     \ifnum \c@secnumdepth >\m@ne
       \if@mainmatter
         \begingroup
           \jb@chapter@style\jubo@chaptercomplete\quad 
           #1\par
         \endgroup%
       \fi%
     \else%    
       \jb@chapter@style #1%
     \fi%  
    }%
  \else%
    \settowidth{\@chaptercompletelength}{\jb@chapter@style\jubo@chaptercomplete\quad}%
    {\parindent \z@ \jubo@csalign@hook \normalfont%
      \ifnum \c@secnumdepth >\m@ne% 
        \if@mainmatter%
          \begingroup%
            \hangindent=\@chaptercompletelength%
            \jb@chapter@style\jubo@chaptercomplete\quad%
            {\raggedright #1\par}%
          \endgroup%
        \fi%
      \else%
        \jb@chapter@style #1%
      \fi%
    }%
  \fi%
  \vspace*{\jb@chapterafter@length}%  
}  


% the following is need (at least) by 'theindex' environment (see below)

\renewcommand{\@makeschapterhead}[1]{%
  \chapterstartspace%
  {\parindent \z@ \jubo@csalign@hook
    \normalfont
    \interlinepenalty\@M
    \jb@chapter@style #1\par\nobreak
    \vspace*{\jb@chapterafter@length}%
  }}

%=====================================
%               
% \@chapter@withoutnumber{heading}
%                         #1
%
% put #1 ...
%   ... as chapter heading
%   ... in the headline
%   ... into toc / ovw
%=====================================


\newcommand{\@chapter@withoutnumber}[1]{%
  \typeout{#1}%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \chapterlevel%
  \jubo@thispagestyle@empty%
  \global\@topnum\z@%
  \@afterindentfalse%
  \addcontentsline{toc}{extrajubostuff}{\protect\numberline{}#1}%
  \addcontentsline{ovw}{extrajubostuff}{\protect\numberline{}#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \markboth{#1}{#1}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead@withoutnumber{#1}]%
  \else
    \@makechapterhead@withoutnumber{#1}%
    \@afterheading%
  \fi%
}


%=====================================
%               
% \@chapter@withoutnumber@notoc{heading}
%           #1
%
% put #1 ...
%   ... as chapter heading
%   ... in the headline
%=====================================

\newcommand{\@chapter@withoutnumber@notoc}[1]{%
  \typeout{#1}%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \chapterlevel%
  \jubo@thispagestyle@empty%
  \global\@topnum\z@%
  \@afterindentfalse%
  \markboth{#1}{#1}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead@withoutnumber{#1}]%
  \else
    \@makechapterhead@withoutnumber{#1}%
    \@afterheading%
  \fi%
}  
\let\@schapter\@chapter@withoutnumber@notoc%


\newcommand{\@makechapterhead@withoutnumber}[1]{%
  \chapterstartspace%
  \if@centeredlayout%
    {\centering\normalfont\jb@chapter@style #1\par}%
  \else%
    {\normalfont\jb@chapter@style\noindent #1\par}%
  \fi%
  \vspace*{\jb@chapterafter@length}%%
}


\newcommand{\changestarchapters}{%
  \let\@schapter\@chapter@withoutnumber
}

\newcommand{\resetstarchapters}{%
  \let\@schapter\@chapter@withoutnumber@notoc%
}


%=====================================
%               
% Appendix / Anhang
%
%=====================================   

\iffalse

  Hier befinden sich die Makros fuer chapter im Anhang. 
  Auf diese Definitionen wird umgeschaltet durch den
  \appendix Befehl.

  (sind zum grossen Teil identisch mit obigen Makros,
  liess sich jedoch nicht ohne Chaos abkuerzen ...)
    
\fi


\renewcommand{\appendix}{%
  \par
  \setcounter{chapter}{\z@}%
  \setcounter{section}{\z@}%
  \renewcommand{\thechapter}{\Alph{chapter}}%
  \renewcommand{\chaptermark}[1]{%
    \markboth{\appendixname\space\thechapter\space ##1}{\appendixname\space\thechapter\space ##1}%
  }%
  \let\chapter\appendixchapter%
}


% lonelyappendix = appendix without a counter ('Appendix' instead of 'Appendix A')
\newif\if@lonely@appchap
\@lonely@appchapfalse

\newcommand{\appendixchapter}{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \chapterlevel%
  \jubo@thispagestyle@empty%
  \global\@topnum\z@%
  \@afterindentfalse
  \secdef\@appendixchapter\@schapter%
}


\newcommand{\lonelyappendixchapter}{%
  \if@lonely@appchap%
    \ClassWarning{jurabook}%
      {You are using \protect\lonelyappendixchapter, but the\MessageBreak%
       appendix contains more than one chapter. Better\MessageBreak%
       use a simple \protect\chapter\space command}%
  \else%
  \fi%
  \@lonely@appchaptrue%
  \renewcommand{\chaptermark}[1]{%
    \markboth{\appendixname\space ##1}{\appendixname\space ##1}%
  }%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \chapterlevel%
  \jubo@thispagestyle@empty%
  \global\@topnum\z@%
  \@afterindentfalse
  \secdef\@appendixchapter\@schapter%
}


\newcommand{\@appendixchapter}[1][]{%
  \renewcommand{\@@firstopt}{#1}%
  \@@appendixchapter%
}

% opt @@firstopt: shorttitle
% opt         #1: title in text, possibly incl. \hnewline = \par
%             #2: title

\newcommand{\@@appendixchapter}[2][]{%
  \if@lonely@appchap%
    \typeout{Lonely Appendix ('\appendixname\space #2')}%
    \addcontentsline{toc}{extrajubostuff}{%
      \protect\numberline{}\appendixname\space #2}%
    \addcontentsline{ovw}{extrajubostuff}{% Overview
      \protect\numberline{}\appendixname\space #2}%
  \else%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{chapter}%
      \typeout{Appendix\space\thechapter}%
      \addcontentsline{toc}{appendixchapter}{%
        \protect\numberline{\appendixname\space\thechapter}#2}%
      \addcontentsline{ovw}{ovwappendixchapter}{% Overview
        \protect\numberline{\appendixname\space\thechapter}#2}%
    \else%
      \addcontentsline{toc}{appendixchapter}{#2}%
      \addcontentsline{ovw}{ovwappendixchapter}{#2}%
    \fi%
  \fi
  \ifthenelse{\equal{\@@firstopt}{\@empty}}%
    {\chaptermark{#2}}%
    {\chaptermark{\@@firstopt}}
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn
    \ifthenelse{\equal{#1}{\@empty}}%
      {\@topnewpage[\@makeappendixchapterhead{#2}]}%
      {\let\hnewline\@@chapter@hnewline%
       \@topnewpage[\@makeappendixchapterhead{#1}]}%
  \else
    \ifthenelse{\equal{#1}{\@empty}}%
      {\@makeappendixchapterhead{#2}}%
      {\let\hnewline\@@chapter@hnewline%
       \@makeappendixchapterhead{#1}}%
    \@afterheading%
  \fi%
}


\newcommand{\@makeappendixchapterhead}[1]{%
  \chapterstartspace%
  \if@centeredlayout%
    {\centering \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \if@mainmatter
         \begingroup
         \jb@chapter@style%
           \if@lonely@appchap%
             \appendixname\quad%
           \else%
             \appendixname~\thechapter\quad%
           \fi%  
         #1\par
         \endgroup
       \fi
     \else    
       \jb@chapter@style #1
     \fi%  
    }%
  \else%
    {\if@lonely@appchap%
       \settowidth{\@chaptercompletelength}{\jb@chapter@style\appendixname\quad}%
     \else%
       \settowidth{\@chaptercompletelength}{\jb@chapter@style\appendixname~\thechapter\quad}%
     \fi%
     \begingroup%
       \parindent \z@ \jubo@csalign@hook \normalfont%
       \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
           \begingroup%
             \hangindent=\@chaptercompletelength%
             \if@lonely@appchap
               \jb@chapter@style\appendixname\quad%
             \else%
               \jb@chapter@style\appendixname~\thechapter\quad%
             \fi%
             {\raggedright #1\par}%
           \endgroup  
         \fi
       \else
         \jb@chapter@style #1  
       \fi%
     \endgroup%
     \vspace*{\jb@chapterafter@length}%
    }%
  \fi%
}

  
%========================================
%               
% Sections 
%
%========================================

\iffalse

 sections werden mit roemischen Ziffern gezaehlt:
  I. Einleitung
 II. Grundlagen der Produzentenhaftung

 Falls overviewwithsec als Paket-Option mit angegeben wurde,
 wird der \section Eintrag (und nur der) in die ovw. Datei 
 geschrieben. 
\fi


\newcounter{totalsections}%
\setcounter{totalsections}{\z@}

\renewcommand*{\thesection}{\Roman{section}.}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \stepcounter{totalsections}%
  \setcounter{current@level}{#2}%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M \jubo@csalign@hook #8\@@par}% linksbuendig!!!! NEU
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi%
      \ifx #8\@empty% Achtes Argument leer? 
        #7%           dann das siebente (= das laengere)
      \else%
        #8%           sonst ist hier das laengere gespeichert
      \fi}%
    \ifnum #2=1% section?
      \if@secinovw% Option overviewwithsections = TRUE?
        \addcontentsline{ovw}{#1}{% Overview-Datei
          \ifnum #2>\c@secnumdepth \else
            \protect\numberline{\csname the#1\endcsname}%
          \fi%
          \ifx #8\@empty% achtes Argument leer?
            #7% dann das siebente (= das laengere)
          \else
            #8% sonst ist hier das laengere gespeichert
          \fi}%  
      \fi%
    \fi%    
  \else%
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi%
        \ifx #8\@empty% achtes Argument leer?
          #7% dann das siebente (= das laengere)
        \else%
          #8% sonst ist hier das laengere gespeichert
        \fi}%    
      \ifnum #2=1 % section?
        \if@secinovw % Option overviewwithsections = TRUE?
          \addcontentsline{ovw}{#1}{% 
            \ifnum #2>\c@secnumdepth \else
              \protect\numberline{\csname the#1\endcsname}%
            \fi%
            \ifx #8\@empty% 
              #7% dann das siebente (= das laengere)
            \else%
              #8% sonst ist hier das laengere gespeichert
            \fi}%
        \fi%
      \fi}%
  \fi%
  \@xsect{#5}%
}

\setcounter{secnumdepth}{9}
\setcounter{tocdepth}{9}


%========================================
% subsection ("1. Blabla")
%========================================

\renewcommand{\thesubsection}{\arabic{subsection}.}


%========================================
% subsubsection ("a. Blubb")
%========================================

\renewcommand{\thesubsubsection}{\alph{subsubsection})}


%==================================================
% subsubsubsection = subthreesection ("aa. lalala")
%==================================================

\newcounter{subthreesection}[subsubsection]
\renewcommand{\thesubthreesection}{\alph{subthreesection}\alph{subthreesection})}
\let\subthreesectionmark\@gobble

\newcommand{\subthreesection}{\@startsection%
  {subthreesection}%
  {4}%
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\let\subsubsubsection\subthreesection


%======================================================
% subsubsubsubsection = subfoursection ("aaa. blubber")
%======================================================

\newcounter{subfoursection}[subthreesection]
\renewcommand{\thesubfoursection}%
  {\alph{subfoursection}\alph{subfoursection}\alph{subfoursection})}
\let\subfoursectionmark\@gobble

\newcommand*{\subfoursection}{\@startsection%
  {subfoursection}%
  {5}%
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\let\subsubsubsubsection\subfoursection


%======================================================
% subfivesection ("(1) blubber")
%======================================================

\newcounter{subfivesection}[subfoursection]
\renewcommand{\thesubfivesection}%
  {(\arabic{subfivesection})}
\let\subfivesectionmark\@gobble

\newcommand*{\subfivesection}{\@startsection%
  {subfivesection}%
  {6}%
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\let\subsubsubsubsubsection\subfivesection


%======================================================
% subsixsection ("(a) blubber")
%======================================================

\newcounter{subsixsection}[subfivesection]
\renewcommand{\thesubsixsection}%
  {(\alph{subsixsection})}
\let\subsixsectionmark\@gobble

\newcommand*{\subsixsection}{\@startsection%
  {subsixsection}%
  {7}%
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\let\subsubsubsubsubsubsection\subsixsection



%======================================================
% subsevensection ("(aa) blubber")
%======================================================

\newcounter{subsevensection}[subsixsection]
\renewcommand{\thesubsevensection}%
  {(\alph{subsevensection}\alph{subsevensection})}
\let\subsevensectionmark\@gobble

\newcommand*{\subsevensection}{\@startsection%
  {subsevensection}%
  {8}%
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\let\subsubsubsubsubsubsubsection\subsevensection


%======================================================
% subeightsection ("(aaa) blubber")
%======================================================

\newcounter{subeightsection}[subsevensection]
\renewcommand{\thesubeightsection}%
  {(\alph{subeightsection}\alph{subeightsection}\alph{subeightsection})}
\let\subeightsectionmark\@gobble

\newcommand*{\subeightsection}{\@startsection%
  {subeightsection}%
  {9}%
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\let\subsubsubsubsubsubsubsubsection\subeightsection


%=======================================================
% paragraph 
%
% Setzt neue Gliedererungsstufe 10 
% kommt nicht ins toc, tocdepth=5
%=======================================================

\@removefromreset{paragraph}{subsubsection}%
\let\paragraphmark\@gobble
\renewcommand{\theparagraph}%
  {\@arabic\c@paragraph}

\renewcommand{\paragraph}{\@startsection%
  {paragraph}% #1
  {10}% #2
  {\z@}% #3
  {3.25ex \@plus1ex \@minus.2ex}% #4
  {-1em}% #5
  {\normalfont\normalsize\bfseries}}% #6
% #7: [arg]
% #8: {partitlearg}
                               

%=======================================================
% subparagraph 
%
% Setzt neue Gliedererungsstufe 11 (kommt nicht ins toc)
%=======================================================

\renewcommand{\subparagraph}{\@startsection%
  {subparagraph}%
  {11}%
  {\z@}%
  {3.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}}
                                      

%=====================================
%               
% toc/sub/levelup/leveldown  
%
%=====================================

\newcounter{current@level}
% 0 = chapter
% 1 = section
% 2 = subsection
% 3 = subsubsection
% 4 = subthreesection
% 5 = subfoursection
% 6 = subfivesection
% 7 = subsixsection
% 8 = subsevensection
% 9 = subeightsection

\newcommand{\toc}[2][]{%
  \ifcase \value{current@level}%
    \chapter[#1]{#2}%
  \or \section[#1]{#2}%
  \or \subsection[#1]{#2}%
  \or \subsubsection[#1]{#2}%
  \or \subthreesection[#1]{#2}%
  \or \subfoursection[#1]{#2}%
  \or \subfivesection[#1]{#2}%
  \or \subsixsection[#1]{#2}%
  \or \subsevensection[#1]{#2}%
  \or \subeightsection[#1]{#2}%
  \else%
    \ClassError{jurabook}%
      {Too many \protect\sub\space commands\MessageBreak
       (you are already on subeightsection level)}%
      {Use \protect\levelup\space or contact juramisc@sodtalbers.de.}%   
  \fi%
}  
  
\newcommand{\levelup}{%
  \addtocounter{current@level}{\m@ne}%
  \ifthenelse{\value{current@level}<\z@}%
    {\ClassError{jurabook}%
      {You are on chapter level, you cannot use \protect\levelup}%
      {Use \protect\part\space or check your sectioning.}%
    }%  
    {\relax}%
}

\newcommand{\leveldown}{%
  \ifthenelse{\value{current@level}=9}%
    {\ClassError{jurabook}%
      {You are on the lowest level, you cannot use \protect\sub\space or \protect\leveldown\space here}
      {Check your sectioning, use \protect\levelup\space or contact juramisc@sodtalbers.de.}%
    }%
    {\stepcounter{current@level}%
    }%
}

\newcommand{\sub}[2][]{%
  \leveldown%
  \toc[#1]{#2}%  
}  

\newcommand{\chapterlevel}{%
  \setcounter{current@level}{\z@}%
}  
   

%======================================
%               
% \l@... Makros fuer Inhaltsverzeichnis
%
%======================================

\renewcommand*{\l@part}[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \parindent \z@ \rightskip \@tocrmarg % statt: \@pnumwidth
      \parfillskip -\@tocrmarg
      {\leavevmode
       {\large \bfseries #1}\hfil \hb@xt@\@tocrmarg{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup%
  \fi% 
}


\iffalse
  
  Zentrierte Ausgabe der parts im Inhaltsverzeichnis / Uebersicht
  
  \@partlinecenter{welcherteil}{text}
                   #1           #2

  welcherteil = 'Erster Teil:' (usw)

  vgl. Kloeckl 166; Begleiter 34
\fi

\newcommand{\@partlinecenter}[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{6ex}%
    \begingroup
      \centering \normalfont 
      {\large\bfseries #1\par}
      \addvspace{2ex}
      {\large\bfseries #2\par}
      \addvspace{2ex}
    \endgroup
    \nopagebreak
  \fi
}

\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength{\@tempdima}{\chapternumwidth}% statt 1.5em (Rest identisch)
    \begingroup
      \parindent \z@%
      \rightskip \@tocrmarg % statt \@pnumwidth
      \parfillskip -\@tocrmarg
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      {\bfseries #1}\nobreak\leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont #2}%
     \par%
     \penalty\@highpenalty%
    \endgroup
  \fi}
        

\iffalse
 Fuer den Ueberblick (overview): 
 
 alles wie \l@chapter, aber: 
 
 Im Inhaltsueberblick Kapitelueberschriften nur dann 
 fett ausgeben, wenn auch sections ausgegeben werden.
\fi

\newcommand*\l@ovwchapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{\chapternumwidth}% statt 1.5em (s.o.)
    \begingroup
      \parindent \z@ \rightskip \@tocrmarg % statt \@pnumwidth
      \parfillskip -\@tocrmarg
      \leavevmode 
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \if@secinovw%
        {\bfseries #1}%
      \else%
        #1%
      \fi%
      \nobreak\leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont #2}%
     \par%
     \penalty\@highpenalty%
    \endgroup
  \fi}


% appendix chapter
\newcommand{\l@appendixchapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \settowidth{\@tempdima}{\bfseries\appendixname~XX\space}%
    \begingroup
      \parindent \z@ \rightskip \@tocrmarg % statt \@pnumwidth
      \parfillskip -\@tocrmarg
      \leavevmode%
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      {\bfseries #1}\nobreak\leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont #2}%
     \par%
     \penalty\@highpenalty%
    \endgroup
  \fi}

\newcommand{\l@ovwappendixchapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \if@secinovw%
      \settowidth\@tempdima{\bfseries\appendixname~XX\space}%
    \else%
      \settowidth\@tempdima{\appendixname~XX\space}%
    \fi%
    \begingroup
      \parindent \z@ \rightskip \@tocrmarg% statt \@pnumwidth
      \parfillskip -\@tocrmarg
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \if@secinovw%
        {\bfseries #1}%
      \else%
        #1%
      \fi%
      \nobreak\leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont #2}%
     \par%
     \penalty\@highpenalty%
    \endgroup
  \fi}

\renewcommand*{\l@section}{\@dottedtocline{1}{\sectiontocindent}{\sectionnumwidth}}
\renewcommand*{\l@subsection}{\@dottedtocline{2}{\subsectiontocindent}{\subsectionnumwidth}}
\renewcommand*{\l@subsubsection}{\@dottedtocline{3}{\subsubsectiontocindent}{\subsubsectionnumwidth}}
\newcommand*{\l@subthreesection}{\@dottedtocline{4}{\subthreesectiontocindent}{\subthreesectionnumwidth}}
\newcommand*{\l@subfoursection}{\@dottedtocline{5}{\subfoursectiontocindent}{\subfoursectionnumwidth}}
\newcommand*{\l@subfivesection}{\@dottedtocline{6}{\subfivesectiontocindent}{\subfivesectionnumwidth}}
\newcommand*{\l@subsixsection}{\@dottedtocline{7}{\subsixsectiontocindent}{\subsixsectionnumwidth}}
\newcommand*{\l@subsevensection}{\@dottedtocline{8}{\subsevensectiontocindent}{\subsevensectionnumwidth}}
\newcommand*{\l@subeightsection}{\@dottedtocline{9}{\subeightsectiontocindent}{\subeightsectionnumwidth}}
\renewcommand*\l@paragraph{\@dottedtocline{10}{\paragraphtocindent}{0em}}
\renewcommand*\l@subparagraph{\@dottedtocline{11}{\subparagraphtocindent}{0em}}

\iffalse

  Mit '\l@extrajubostuff' werden
  Literatur-, Entscheidungs-, Website- und Stichwortverzeichnis
  in das Inhaltsverzeichnis gebracht. 
  
\fi

\newcommand{\jb@tocextras@style}{\normalfont\mdseries}

\newcommand*{\l@extrajubostuff}[2]{%
  \addpenalty{-\@highpenalty}%
  \vskip 1.0em \@plus\p@%
  \setlength{\@tempdima}{\z@}% ??? okay?
  \begingroup
     \parindent \z@%
     \rightskip \@tocrmarg % not: \@pnumwidth
     \parfillskip -\@tocrmarg
     \leavevmode
     \advance\leftskip\@tempdima
     \hskip -\leftskip
     {\jb@tocextras@style #1}\nobreak\leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\jb@tocextras@style #2}%
     \par%
     \penalty\@highpenalty%
   \endgroup%
}
    
            
%=====================================
%               
% Verschiedenes  
%
%=====================================

\iffalse

  \TODO{Hinweis}
        #1

  Eine Markierung fuer Anmerkungen im Text fuer Sachen, die noch bearbeitet 
  werden muessen. Wird umrahmt im Rand ausgedruckt.      
\fi

\newcommand{\TODO}[1]{%
  \marginpar{\framebox{\parbox{\marginparwidth}{\bfseries #1}}}%
  \ClassWarning{jurabook}%
    {There is still something to do}% 'on input line no ...'
}  


\newcommand{\xref}[1]{% vereinfacht Zitierungen
  \ref{#1} auf S.~\pageref{#1}}

 

%========================================
%               
% Index 
%
%========================================

% TLC 11.1.7 (p. 653); Begleiter 361 f.

\newcommand{\Index}[1]{#1\index{#1}}

% this is currently *not* working:
\newcommand{\findexproofmode}{%
  \ClassWarningNoLine{jurabook}%
    {You switched to footnote index proofmode\MessageBreak
     no index entries will be produced}
  \renewcommand{\index}[1]{%
    \if@infootnote
      \ClassWarning{jurabook}%
        {\protect\index\space inside a footnote}
    \else    
    \fi}%
  \renewcommand{\Index}[1]{%
    \if@infootnote
      \ClassWarning{jurabook}%
        {\protect\Index\space inside a footnote}
    \else
    \fi}
}

\newcommand{\FIndex}[1]{%
  \if@infootnote%
    #1\index{#1|textit}%
  \else%
    \ClassError{jurabook}%
      {\protect\FIndex outside a footnote}%
      {Use \protect\Index\space instead.}%
  \fi}

\newcommand{\findex}[1]{%
  \if@infootnote%
    \index{#1|textit}%
  \else%
    \ClassError{jurabook}%
      {\protect\findex outside a footnote}%
      {Use \protect\index\space instead.}%
  \fi}

\newcommand{\MIndex}[1]{#1\index{#1|textbf}}

\newcommand{\seealso}[2]{\emph{\alsoname} #1}


% The following code is taken from:
% index.sty 2004/01/20 v4.2beta Improved index support (dmj)
% by David M. Jones,
% MIT Laboratory for Computer Science, Cambridge, MA 02139, USA
%
% and 
% 
% manmac.tex (cf. TeXBook p. 423)


\def\special@jb@hat{\ifmmode\def\jb@next{^}\else\let\jb@next=\index\fi\jb@next}
%\def\special@jb@underscore{\ifmmode\def\jb@next{_}\else\let\jb@next=\Index\fi\jb@next}

\newif\if@shortindexing

\begingroup
  \catcode`\^\active
% \catcode`\_\active

  \gdef\shortindexingon{%
     \@shortindexingtrue
     \chardef\old@jb@hatcode\catcode`\^\relax
%    \chardef\old@jb@underscorecode\catcode`\_\relax
     \catcode`\^\active
%    \catcode`\_\active
     \let\old@jb@hat ^%
%    \let\old@jb@underscore _%
     \let^\special@jb@hat
%    \let_\special@jb@underscore%
}

  \gdef\shortindexingoff{%
     \if@shortindexing
       \@shortindexingfalse
       \let^\old@jb@hat
%      \let_\old@jb@underscore
       \catcode`\^\old@jb@hatcode
%      \catcode`\_\old@jb@underscorecode
     \fi}
\endgroup


\if@indexpagenumbers%
% leave everything as it is ...  
\else
% The following code puts the numbers of the runners into the index
  \renewcommand{\@wrindex}[1]{%
     \protected@write\@indexfile{}%
        {\string\indexentry{#1}{\therunner}}% instead of \thepage
   \endgroup
   \@esphack}%
\fi


% setting the index prologue

\if@indexpagenumbers%
  \newcommand{\jb@indexprologue@text}{Die Zahlen beziehen sich auf die jeweiligen Seiten.}
\else  
  \newcommand{\jb@indexprologue@text}{Die Zahlen verweisen auf die Randnummern.}
\fi  
\newcommand{\jb@indexprologue@style}{\normalsize\itshape}
\newcommand{\@indexprologue}{%
   \begingroup
     \jb@indexprologue@style%
     \jb@indexprologue@text%
     \vspace{\bigskipamount}\vspace{\bigskipamount}\par
   \endgroup}

\newcommand{\combinemarks}{%
  \ifthenelse{\equal{\leftmark}{\rightmark}}%
    {\rightmark}% if equal
    {\rightmark--\leftmark}}% if not equal

\newcommand{\@currentindexletter}{}
\newcommand{\newindexletter}[1]{%
  \renewcommand{\@currentindexletter}{#1}%
  {\bfseries\large\hfill #1\hfill\smallskip}%
}

\renewcommand{\@idxitem}%
  {\par\hangindent 40\p@\markboth{\@currentindexletter}{\@currentindexletter}}

\iffalse
  Hier die entsprechende Umdefinierung 
  der 'index'-Umgebung, so dass der
  index prologue integriert wird.
  
  vgl. a. Begleiter 378
\fi

\newcommand{\jb@indextext@style}{\normalsize}

\renewenvironment{theindex}%
  {\columnseprule \z@
   \columnsep 35\p@
   \@chapter@withoutnumber{\indexname}%
   \@indexprologue%
   \pagestyle{fancy}%
   \chead{\indexname\space (\combinemarks)}
   \begin{multicols}{2}
     \parindent\z@
     \parskip\z@ \@plus .3\p@\relax
     \jb@indextext@style%
     \let\item\@idxitem%
  }%
  {\end{multicols}%
  }  



\iffalse

 Folgendes Kommando bringt Eintrag fuer Literaturverzeichnis 
 in das Inhaltsverzeichnis.
 
 Kommt auch (bzw gerade) mit jurabib zurecht.
 
 Zu Risiken und Nebenwirkungen ...
   
\fi

\newcommand{\bibtotoc}{%
  \if@jurabibloaded%
    \@ifundefined{bib@heading}%
      {\ClassError{jurabook}%
        {You are using an outdated version of the package 'jurabib'.}%
        {Get the latest version (>=0.6) of 'jurabib' from www.jurabib.org}%
      }%
      {\ClassInfo{jurabook}{Redefining jurabib's \protect\bib@heading\space command}%
       \let\oldbib@heading\bib@heading%
       \renewcommand{\bib@heading}{%
         \@chapter@withoutnumber{\bibname}%
        }%
      }%
  \else%    
    \ClassInfo{jurabook}{Changing LaTeX's `thebibliography' environment}%
    \renewenvironment{thebibliography}[1]% stolen from book.cls
      {\@chapter@withoutnumber{\bibname}%
       \list{\@biblabel{\@arabic\c@enumiv}}%
            {\settowidth\labelwidth{\@biblabel{##1}}%
             \leftmargin\labelwidth
             \advance\leftmargin\labelsep
             \@openbib@code
             \usecounter{enumiv}%
             \let\p@enumiv\@empty
             \renewcommand\theenumiv{\@arabic\c@enumiv}}%
       \sloppy
       \clubpenalty4000
       \@clubpenalty \clubpenalty
       \widowpenalty4000%
       \sfcode`\.\@m%
      }%
      {\def\@noitemerr
        {\@latex@warning{Empty `thebibliography' environment}}%
       \endlist%
      }%
  \fi% 
}%

\iffalse
  this put a nomenclature list
  created with nomencl.sty into the toc / ovw
  
  tested with '2000/12/03 v3.1a Nomenclature package (BS)'
\fi

\newcommand{\nomencltotoc}{%
  \@ifundefined{@nomenclature}%
    {\ClassError{jurabook}%
       {\protect\nomencltotoc\space without 'nomencl' package}%
       {Use 'nomencl' package or don't use \protect\nomencltotoc}%
    }%
    {\ClassInfo{jurabook}{Changing nomencl's \protect\theglossary\space command}%
     \renewcommand{\theglossary}{%
       \@chapter@withoutnumber{\nomname}%
       \nompreamble
       \list{}{%
         \labelwidth\nom@tempdim
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \itemsep\nomitemsep
         \let\makelabel\nomlabel}%
      }%
    }%
}

    
%=====================================================
%               
% Zitieren von Websites / Verzeichnis der Webadressen 
%
%===================================================== 

\iffalse
 Naehere Informationen: Begleiter 37 ff.
\fi

\newcounter{totalwebcites}

\newcommand*{\jb@cwrevisionopen@text}{(}%   oeffnendes Zeichen fuer den Stand
\newcommand*{\jb@cwrevision@text}{Stand:}
\newcommand*{\jb@cwrevisionclose@text}{)}%  schliessendes Zeichen fuer den Stand

\iffalse

  \citeweb[abrufdatum]{url}{beschreibung}
           #1          #2   #3

  * =  kein Eintrag in low
\fi

\newcommand{\citeweb}{%
  \@ifstar{\@@cws}{\@@cw}%
}
 
\newcommand{\@@cw}[3][]{%  
  \@citeweb[#1]{#2}%
  \if@dorunners%
    \addtocontents{low}{\protect\lowcontentsline{#2}{#3}{\therunner}}%
  \else%
    \addtocontents{low}{\protect\lowcontentsline{#2}{#3}{\thepage}}%
  \fi%
}

\newcommand{\@@cws}[3][]{%
  \@gobble{#3}% Beschreibung wird hier nicht benoetigt 
  \@citeweb[#1]{#2}%
}

\newcommand{\@citeweb}[2][]{%
  \stepcounter{totalwebcites}%
  \url{#2}%
  \if@suppresswebdates%
    \@gobble{#1}%
  \else%
    \space\jb@cwrevisionopen@text\jb@cwrevision@text\space
    \ifthenelse{\equal{#1}{\@empty}}% 
      {\ClassWarning{jurabook}{No date in web citation -- replaced by current date}%
       \number\day.~\number\month. \number\year\jb@cwrevisionclose@text%
      }% don't delete this percent character!
    % else    
      {#1\jb@cwrevisionclose@text}%
    % fi
  \fi%  
}

% \citewebwithx[date]{urldef}{description}
%               #1    #2      #3
 
\newcommand{\citewebx}[3][]{%
  \stepcounter{totalwebcites}%
  \@ifundefined{#2}%
    {\ClassError{jurabook}%
      {Try to cite webaddress containing \#,\MessageBreak
       but #2 not (url-)defined!}%
      {Use \protect\urldef\space from url.sty.}%
    }%   
    {\relax}%
  \csname #2\endcsname%
  \if@suppresswebdates%
    \@gobble{#1}%
  \else%
    \space\jb@cwrevisionopen@text\jb@cwrevision@text\space
    \ifthenelse{\equal{#1}{\@empty}}% 
      {\ClassWarning{jurabook}{No date in web citation -- replaced by current date}%
       \number\day.~\number\month. \number\year\jb@cwrevisionclose@text%
      }% don't delete this percent character!
    % else    
      {#1\jb@cwrevisionclose@text}%
    % fi
  \fi%
  \if@dorunners%
    \addtocontents{low}{\protect\lowcontentslinex{#2}{#3}{\therunner}}%
  \else%
    \addtocontents{low}{\protect\lowcontentslinex{#2}{#3}{\thepage}}%
  \fi%
}



\iffalse

  \addextrawebcite{url}
                   #1

  fuegt einen extra Eintrag in die Liste:
\fi

\newcommand{\addextrawebcite}[1]{%
  \addtocontents{low}{\protect\lowcontentsline{#1}}%
}


\newcommand{\lowcontentsline}[3]{%
  \begingroup%
    \interlinepenalty\@M
    \url{#1}\space\dotfill~#3\par%
    {\setlength{\rightskip}{3em}#2\par}\smallskip%
  \endgroup% 
}


\newcommand{\lowcontentslinex}[3]{%
  \begingroup%
    \interlinepenalty\@M
    \csname #1\endcsname\space\dotfill~#3\par%
    {\setlength{\rightskip}{3em}#2}\par\smallskip%
  \endgroup% 
}


\newcommand*{\jb@lowprologue@style}{\normalsize\itshape}

\if@indexpagenumbers%
  \newcommand*{\jb@lowprologue@text}{Die Zahlen beziehen sich auf die jeweiligen Seiten.}
\else  
  \newcommand*{\jb@lowprologue@text}{Die Zahlen verweisen auf die Randnummern.}
\fi

\newcommand{\@lowprologue}{%
   \begingroup
     \jb@lowprologue@style%
     \jb@lowprologue@text%
     \vspace{\bigskipamount}\vspace{\bigskipamount}\par
   \endgroup%
}


\newcommand*{\jb@lowname@text}{Quellen im World Wide Web}
\newcommand*{\jb@lowtext@style}{\normalsize}

\newcommand{\tableofwebcites}{% geklaut aus book.cls, ohne \makeuppercase
   \if@twocolumn
     \@restonecoltrue\onecolumn
   \else
     \@restonecolfalse
   \fi
   \@chapter@withoutnumber{\jb@lowname@text}%
   \@lowprologue%
   \begin{sloppypar}%
     \jb@lowtext@style%
     \setlength{\parindent}{0pt}
     \@starttoc{low}%
   \end{sloppypar}  
   \if@restonecol\twocolumn\fi%
}


%========================================
%               
% Liste der Entscheidungen 
%
%========================================

\newif\if@indecisionlist    % sind wir innerhalb der Entsch-Liste?
\@indecisionlistfalse
\newif\if@notfinalsw        % Entsch nicht rechtskaeftig?
\@notfinalswfalse

\newcommand*{\jb@decisionsep@text}{--}
\newcommand*{\jb@decisionlist@text}{Zitierte Entscheidungen}
\newcommand*{\jb@notfinal@text}{(nicht rechtskr.)}

\newcounter{totaldcs}
\newcounter{totaldecisions}
\newcounter{totalnotyets}

\newcommand{\decisionentry}[2]{}    % wird von \@starttoc benoetigt
\@starttoc{dcs}                     % oeffnet \jobname.dcs


\iffalse Befehl fuer Zitat innerhalb des Textes:

  \@dcs[nrkr]{gericht}{fundstelle}{stichwort}
       #1    #2       #3          #4

  #1: nicht rechtskraeftig  (Optional)
  ----------------
  #2: Gericht
  #3: Fundstelle
  #4: Stichwort
  
  Prozentzeichen nicht vergessen!
\fi

\newcommand{\@dcs}[4][]{%
  {\itshape #2}\space #3%
  \ifthenelse{\equal{#4}{\@empty}}%
    {\ClassInfo{jurabook}{No keyword in \protect\dcs}}%
    {\space\jb@decisionsep@text\space #4}%
  \ifthenelse{\equal{#1}{\@empty}}%
    {\relax}%
    {\space\jb@notfinal@text}%
  \if@dorunners%
    \addtocontents{dcs}{\protect\decisionentry{#4}{\therunner}}%
  \else
    \addtocontents{dcs}{\protect\decisionentry{#4}{\thepage}}%
  \fi%  
}

\newcommand{\dcs}{\@ifstar{\@@dcss}{\@@dcs}}

\newcommand{\@@dcs}[3]{%
  \@dcs{#1}{#2}{#3}{}%
}  

\newcommand{\@@dcss}[3]{%
  \@dcs[nrkr]{#1}{#2}{#3}%
}


\newcommand{\jb@decisionprologue@style}{\normalsize\itshape}
\newcommand{\jb@decisionprologue@text}{}

\newcommand{\@decisionprologue}{%
  \begingroup
    \jb@decisionprologue@style%
    \jb@decisionprologue@text%
    \vspace{\bigskipamount}\vspace{\bigskipamount}\par
  \endgroup%
}


\newcommand{\jb@decisiontext@style}{\small\raggedright}

\newenvironment{decisionlist}
  {\@indecisionlisttrue
   \@chapter@withoutnumber{\jb@decisionlist@text}%
   \@decisionprologue
   \jb@decisiontext@style
   \begin{list}%
     {}%
     {\setlength{\leftmargin}{\z@}
      \setlength{\rightmargin}{\z@}
      \setlength{\itemsep}{1ex}}%
  }
  {\end{list}%
   \@indecisionlistfalse%
  }
 

\iffalse fuegt eine Entscheidung in die EntscheidungsLISTE ein:

 \@decision{gericht}{fundstelle}{stichwort}{datum}{az}{anmerkung}{nichtrechtskraeftig}{extra}

 #1: Gericht
 #2: Fundstelle
 #3: Stichwort
 #4: Datum der Entscheidung
 #5: Aktenzeichen
 #6: Anmerkungen (werden nur dann NICHT ausgegeben, wenn Option 'decisionsfinal' eingeschaltet)
 #7: Urteil oder Beschluss (vom ...)
 #8: Entscheidung rechtskraeftig? (ja, wenn arg leer, sonst \jb@notfinal@text)
 #9: Extratext am Ende (fuer Randnummern zB)
  
\fi

\newcommand*{\jb@decision@text}{Urt.}
\newcommand*{\jb@decree@text}{Beschl.}
\newcommand*{\jb@decisionfrom@text}{v.}

\newcommand*{\jb@decisionemph@style}{\bfseries}% emphasize dcs

\newcommand{\@decision}[9]{%
  \if@indecisionlist%
    \stepcounter{totaldcs}%
    \stepcounter{totaldecisions}%
    \ifthenelse{\equal{#8}{\@empty}}{\@notfinalswfalse}{\@notfinalswtrue}
    \item {\jb@decisionemph@style #1}, #7\space\jb@decisionfrom@text\space #4~\jb@decisionsep@text~#5\if@notfinalsw{\space\jb@notfinal@text ,}\else{,}\fi\space{\jb@decisionemph@style #2}%
    \ifthenelse{\equal{#3}{\@empty}}%
      {\ClassInfo{jurabook}{No keyword in \protect\dcs}}%
      {\space\mbox{\jb@decisionsep@text\space #3}}%
    \ifthenelse{\equal{#9}{\@empty}}%
      {}%
      {\space #9}%
    \if@decisionhints%
      \ifthenelse{\equal{#6}{\@empty}}%
        {\relax}%
        {\footnote{#6}}%
    \fi%
    \par%
    \if@notfinalsw
      \ifthenelse{\equal{#1}{BGH}}%
        {\ClassWarning{jurabook}{Eine nicht rechtskraeftige Entscheidung des BGH??!}}{}
    \fi  
  \else
    \ClassError{jurabook}%
      {\protect\decision\space or \protect\decree\space used in text (instead of \protect\dcs)}%
      {Use the \protect\dcs\space command!}%
  \fi%
}


\iffalse
   \decision[Versaumnisurt.]{BGH}{NJW 2001, 964}{Kindertee IV}{12.12.2000}{VI ZR 345/99}{extra}
             #1              #2   #3             #4            #5          #6            #7
    {Kv.
    Verjaehrung, gilt fuer jedes Organ der Gesellschaft separat.
    = ZIP 2001, 379??? mit Anm. Brueggemeier (Kv).}
    #8
\fi

\newcommand{\decision}{\@ifstar{\@@decs}{\@@dec}}  

\newcommand{\@@dec}[8][\jb@decision@text]{%
  \@decision{#2}{#3}{#4}{#5}{#6}{#8}{#1}{}{#7}%
}

\newcommand{\@@decs}[8][\jb@decision@text]{%
  \@decision{#2}{#3}{#4}{#5}{#6}{#8}{#1}{nrkr}{#7}%
}


\iffalse
   \decree{BGH}{NJW 2001, 964}{Kindertee IV}{12.12.2000}{VI ZR 345/99}{extra}{
   {
            #1  #2             #3            #4          #5            #6
    Kv.
    Verjaehrung, gilt fuer jedes Organ der Gesellschaft separat.
    = ZIP 2001, 379??? mit Anm. Brueggemeier (Kv).}
    #7
\fi

\newcommand{\decree}{\@ifstar{\@@dcrs}{\@@dcr}}

\newcommand{\@@dcr}[7]{%
  \@decision{#1}{#2}{#3}{#4}{#5}{#7}{\jb@decree@text}{}{#6}%
}

\newcommand{\@@dcrs}[7]{%
  \@decision{#1}{#2}{#3}{#4}{#5}{#7}{\jb@decree@text}{nrkr}{#6}%
}  

\newcommand{\@@notyet}[8][marillion]{%
  \ClassInfo{jurabook}{decision in list but not cited in text}% 'on inpute line xx'
  \stepcounter{totaldcs}%
  \stepcounter{totalnotyets}%
}  

% this seems to be ridiculous ...
\newcommand{\notyet}{\@ifstar{\@@notyet}{\@@notyet}}
  
% Separierung verschiedener Gerichte  
\newcommand{\newcourt}{%
  \space\bigskip%
}


% visual formatting, TLC2 p. 234
\newcommand{\longpage}[1][1]{\enlargethispage{#1\baselineskip}}
\newcommand{\shortpage}[1][1]{\enlargethispage{-#1\baselineskip}}

\endinput
% end of jurabook.cls
