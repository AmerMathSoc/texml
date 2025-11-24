%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% LaTeX class file in conformance with the specifications set by the 
%% University of Michigan for dissertations
%% This class loads the standard book class and then modifies it as little as %% possible. Many of the modifications were taken from the beavtex class and
%% the umdiss.cls
%%
%%%%%%              NEWLY DEFINED COMMANDS
%% The goal with this class is to use standard LaTeX commands such as author
%% and title as much as possible, but several new commands were also necessary
%% COMMANDS
%% \makecopyright
%% \degree{doctor of philosophy or whater}
%% \program{name of program}
%% \committeemember{one for each normal committee member}
%% \chaircommitteemember{for your chair}
%% \cochaircommitteemember{use two of these if you have co-chairs}
%% \listofappendices - generates list of appendices 
%%     - only use if you have more than one appendix
%%  
%% NAMES - for most commands and environments, there is also an associated
%% name, e.g. the preface environment uses the command \prefacename to
%% determine how it should be labeled. If you would prefer 'Prologue' instead
%% of 'Preface', you can change this by redefining \prefacename in the 
%% preamble of your LaTeX file, like so:
%%  \renewcommand{\prefacename}{Prologue}
%%
%%%%%%%%                 NEWLY DEFINED ENVIRONMENTS
%% frontispiece    - vertically centered, and horizontally centered, but
%%                   uses a flushright environment for typesetting quotes 
%% dedication      - vertically and horizontally centered
%% acknowledgments - for typesetting acknowledgements
%% preface         - typesets the preface
%% abstract        - typesets the abstract as it should be included in the 
%%                   dissertation
%% finalabstract   - formatted according to Rackham guidelines for the 
%%                   separate abstract
%%  
%%%%%%              DEPENDENCIES (REQUIRED PACKAGES)                  
%% This class requires several standard LaTeX packages
%% setspace  - easily and consistently set line spacing
%% ifthen    - required for internal class commands
%% hyperref  - provides support for all sorts of nifty and handy things, such 
%%             as pdf bookmarks and thumbnails, links from the table of 
%%             contents and links for references, citations, and indexing
%%
%%%%%%              PACKAGES KNOWN TO BE COMPATIBLE
%% natbib - better formatting for bibliographies
%% sectsty - for changing formatting of section headings
%% graphics, graphicx - for including graphics files
%%                      note that regular latex can only include .eps files
%%                      pdflatex can import .png, .jpg, .pdf, but not .eps
%%                      To include .eps with pdflatex use the epstopdf package
%%                        and run as 'pdflatex --shell-escape' (requires gs)
%% tipa               - for phonetic fonts
%% tabularx           - advanced tabular environments

%%%%%%              INCOMPATIBILITIES
%% fncycchap
%% titlesec
%%%%%%                    ACKNOWLEDGEMENTS                             
%% Thanks to Heiko Oberdiek for a tip on how to get bookmarks right for the 
%% appendix (posted on groups.google.com/group/comp.text.tex)
%% Thanks also to Jon Hanson, who pointed out some flaws, and made several 
%% suggestions for improvements
%% And thanks to the writers of the umdiss.cls, umich-thesis.cls, and the 
%% beavtex.cls, from which much of this was stolen
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%foo
\newcommand{\filename}{umthesis}
\newcommand{\fileversion}{$Revision: 55 $}
\newcommand{\filedate}{2008/02/14}
\newcommand{\fileauthor}{$Author: robfelty $}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\filename}[\filedate \fileversion %
  : University of Michigan thesis class - based on book]

\RequirePackage{setspace} %for spacing
\RequirePackage{ifthen} % advanced control structures
\RequirePackage{etex} % enable advanced tex features, particularly don't limit the number of dimensions to 256

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% These are the default options.
\ExecuteOptions{12pt,openany,oneside}
\ProcessOptions\relax

\PassOptionsToClass{oneside,openany}{book}

\LoadClass[letterpaper]{book}

\renewcommand\l@chapter{\protect\vskip1em \@dottedtocline{0}{0em}{1.5em}}
\newcommand\prefacename{Preface}
\newcommand\abstractname{Abstract}
\newcommand\dedicationname{Dedication}
\renewcommand\contentsname{Table of Contents}
\newcommand\acknowledgmentsname{Acknowledgments}
\newcommand\listappendixname{List of Appendices}
\renewcommand\appendixname{Appendix} % JH uncommented and amended this
\newcommand\appendicesname{Appendices}
% -------------------------------------------------------------------------------
% Set up page layout.

% \evensidemargin is used when [twoside] is set (by [preprint]).
%\setlength{\oddsidemargin}{\@lmarwidth}
%\setlength{\evensidemargin}{\@smarwidth}
\pagestyle{plain}
\setlength{\textwidth}{6in}
\setlength{\textheight}{9in}
% Other margins. T.G.: all other margins must be at least 1 inch.
\setlength{\topmargin}{0in}
\setlength{\headheight}{0in}
\setlength{\headsep}{0in}
\setlength{\footskip}{.5in}
\onehalfspacing

% -------------------------------------------------------------------------------
% Font size for headings. T.G. : headings may be either 14pt only if all
% headings are 14pt. I assume you want them all be 14 pt (at least I do).  For
% 12pt headings, you need:
% \renewcommand{\heading}{\fontsize{12}{14.5}\selectfont}

% Note: commands like \large etc are proportional to normal font size (which can
% be 10, 11 or 12), and should be avoided. Use \heading when you typeset a
% heading.
\newcommand{\heading}{\huge \bf}

%-------------------------------------------------------------------------------
\newif\if@appendix
\newcommand{\ext@toc}{toc}
\newif\if@appendices \@appendicesfalse
    % JH: added appendices flag above to handle multiple appendices.  Becomes true if \listofappendicies is called.
% Authors: use \mainmatter before the main content
%\renewcommand{\mainmatter}{%
%  \cleardoublepage%
%  \@mainmattertrue%
%  \pagestyle{plain}
%  \setcounter{page}{1}%
%  \pagenumbering{arabic}%
%}
\renewcommand\appendix{%
  \phantomsection
  \if@twocolumn
    \onecolumn
  \fi
  \clearpage%
  \@appendixtrue%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand{\chaptername}{}
  \gdef\@chapapp{\appendixname}%
  \if@appendices % JH added this line
  \else % JH added this line
  	\setcounter{chapter}{\m@ne}% JH added this line to make appendix unnumbered
  \fi % JH added this line 	
  \gdef\thechapter{\@Alph\c@chapter}% JH added this line

  % the hypersetup command will tell hyperref to make bookmarks based on the 
  % list of appendices
  \hypersetup{bookmarkstype={loa}} 
  \def\ext@toc{loa}%
  \if@appendices % JH added this
  	\addcontentsline{toc}{chapter}{\textbf{\appendicesname}}% original line
  	\appendixpage % JH remove this line and uncomment line below if appendix page is required/desired even when only one appendix
  \else	% JH added this
  	\addcontentsline{toc}{chapter}{\textbf{\appendixname}}% JH added this
  \fi % JH added this
  %\appendixpage% JH: uncomment this line if appendix page is required/desired even when only one apendix
}

%% T.G. : An appendix page is required before the appendices.
\newcommand{\appendixpage}{%
  \thispagestyle{plain}
  \vspace*{\fill}
  \begin{center}{\heading \if@appendices \appendicesname \else \appendixname \fi}\end{center}% JH added appendixname alternative
  \vspace*{\fill}
  \clearpage%
}
%
%% Redefine \@chapter, so that appendices are added in .loa file if [seploa] is
%% set. Also, I commented out the lines adding space between figures/tables of
%% different chapters. I am not sure yet if it is necessary. The following code
%% is pretty much copied from book.cls. If it looks messy, don't blame me :P
\def\@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \refstepcounter{chapter}
      \typeout{\@chapapp\space\thechapter.}
      \addcontentsline{\ext@toc}{\if@appendix chapter\else chapter\fi}{\if@appendix \chaptername\ \protect\numberline{\thechapter}#1\else \textbf{\chaptername\ \protect\numberline{\thechapter}#1}\fi}
    \else
      \addcontentsline{\ext@toc}{chapter}{#1}
    \fi
  \else
    \addcontentsline{\ext@toc}{chapter}{#1}
  \fi
  \chaptermark{#1}
% Gap between figures/tables of different chapters or not?
   \addtocontents{\ext@figure}{\protect\addvspace{10\p@}}
   \addtocontents{\ext@table}{\protect\addvspace{10\p@}}
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]
  \else
    \@makechapterhead{#2}
    \@afterheading
  \fi
}
%
%% For separate listings of appendices ([seploa] is set), every appendix is
%% listed the same as a chapter, otherwise it is like a section. not sure if it's
%% the optimal solution. but it looks nice for now.
\def\l@app#1#2{%
%  \l@chapter{#1}{#2}
  %\else{\vskip 4pt {\baselineskip 14.5pt%
    \@dottedtocline{1}{1pc}{2em}{#1}{#2}%
%}}
}

% Chapter heading. centered, and 2 in top margin. We like them \huge \bf as well
\renewcommand{\@makechapterhead}[1]{%
  \begin{singlespacing}
  \vspace*{.5in}%
  {
    \begin{center}
      \normalfont \heading %\huge \bf
      \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter\bf\@chapapp\ \thechapter\\[.5em] \fi
      \fi
      \bf #1\\[1em]
    \end{center}
  }
  \end{singlespacing}
}

%this sets the style for starred chapter \chapter*
\renewcommand{\@makeschapterhead}[1]{%
  \begin{singlespacing}
  \vspace*{.5in}%
  {
    \begin{center}
      \normalfont \heading %\huge \bf
      \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter\bf\@chapapp\ \thechapter\\[1em] \fi
      \fi
      \bf #1\\[2em]
    \end{center}
  }
  \end{singlespacing}
}
\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
  \begin{singlespacing}
    \addcontentsline{toc}{chapter}{\textbf{\listtablename}}%
      \@mkboth{\listtablename}\listtablename{}
    \vskip 1em
    {\parindent \z@ \raggedright \bf Table{}\par}
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
  \end{singlespacing}
    }
\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
  \begin{singlespacing}
    \addcontentsline{toc}{chapter}{\textbf{\listfigurename}}%
      \@mkboth{\listfigurename}{\listfigurename}
    \vskip 1em
    {\parindent \z@ \raggedright \bf Figure{}\par}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
  \end{singlespacing}
    }
\newcommand\listofappendices{%
    \@appendicestrue % JH appendix code
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listappendixname}%
  \begin{singlespacing}
    \addcontentsline{toc}{chapter}{\textbf{\listappendixname}}%
      \@mkboth{\listappendixname}\listappendixname{}
    \vskip 1em
    {\parindent \z@ \raggedright \bf \appendixname{}\par}
  %% the setcounter lines can be used if you wish to not list sections in the 
  %% list of appendices. This is a bit of a hack
  %\setcounter{tocdepth}{0}
    \@starttoc{loa}%
  %\setcounter{tocdepth}{4}
    \if@restonecol\twocolumn\fi
  \end{singlespacing}
    }

%this redefines the section headings somewhat, most importantly whether to include sections in the appendix in the list of appendices instead of in the table of contents
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
  \singlespacing
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{\ext@toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{\ext@toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
      %\fi
  \fi
  \@xsect{#5}
}
% Make quote environment single-spaced.
\let\oldquote\quote
\let\oldendquote\endquote
\renewenvironment{quote}{\oldquote\singlespace}{\oldendquote}

% Make quotation environment single-spaced.
\let\oldquotation\quotation
\let\oldendquotation\endquotation
\renewenvironment{quotation}{\oldquotation\singlespace}{\oldendquotation}

%% this is mostly copied from umdiss.cls. It defines the additional necessary
% commands for creating the title page and other frontmatter material, e.g.
% preface, copyright.  
%% for the committemembers, the commands allow an optional
% argument, to specify the institution for outside members

%%DJM: added to detect when have gotten to second or later cochairs, for
%% use in abstract page.  not fixed for special members...
%% RAF 2007.03.19 fixed this for special members

\newif\iffirstcochair\firstcochairtrue

\newtoks\chairtokenlist
\newtoks\committeetokenlist
\newtoks\abstokenlist
\chairtokenlist{}
\committeetokenlist{}
\abstokenlist{}

\def\chaircommitteemember{
  \@ifnextchar[{\@spchaircm}{\@regchaircm}}

\def\cochaircommitteemember{
  \@ifnextchar[{\@spcochaircm}{\@regcochaircm}}

\def\committeemember{%
  \@ifnextchar[{\@spcm}{\@regcm}}

\def\@spchaircm[#1]#2#3{%
   \def\abschairname{Chair:}%
   \addto@hook{\chairtokenlist}{& #3 #2, Chair, #1\\}%
   \addto@hook{\abstokenlist}{& #3 #2, #1}}

\def\@regchaircm#1#2{%
   \def\abschairname{Chair:}%
   \addto@hook{\chairtokenlist}{& #2 #1, Chair\\}%
   \addto@hook{\abstokenlist}{& #1\\}}

\def\@spcochaircm[#1]#2#3{%
   \def\abschairname{Co-Chairs:}%
   \addto@hook{\chairtokenlist}{& #3 #2, Co-Chair, #1\\}%
   \iffirstcochair\addto@hook{\abstokenlist}{& #1 }
        \else\addto@hook{\abstokenlist}{and #2 }\fi
   \firstcochairfalse}

\def\@regcochaircm#1#2{%
   \def\abschairname{Co-Chairs:}%
   \addto@hook{\chairtokenlist}{& #2 #1, Co-Chair\\}%
   \iffirstcochair\addto@hook{\abstokenlist}{& #1 }
        \else\addto@hook{\abstokenlist}{and #1 }\fi
   \firstcochairfalse}

\def\@spcm[#1]#2#3{\addto@hook{\committeetokenlist}{& #3 #2, #1\\}}
\def\@regcm#1#2{\addto@hook{\committeetokenlist}{& #2 #1\\}}

\def\committee{
        \begin{tabular}{p{0.5in}l}
        \multicolumn{2}{l}{Doctoral Committee:}\\
        \the\chairtokenlist
        \the\committeetokenlist
        \end{tabular}}


\newcommand\degree[1]{\gdef\@degree{#1}}
\newcommand\program[1]{\gdef\@program{#1}}


\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\contentsname}\contentsname{}}%
  \begin{singlespacing}
  \pdfbookmark[0]{\contentsname}{contents}
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
  \end{singlespacing}
    }
\renewcommand\maketitle{
  \pdfbookmark[0]{Title}{title}
  \begin{titlepage}%
   \singlespacing
   \let\footnotesize\small
   \let\footnoterule\relax
   \setcounter{page}{-1}%
   \vspace*{1in}
   \begin{center}%
      {\huge \bf \@title \par}%
   \end{center}
   \vfill
   \centerline{\bf by}
   \vspace{1ex}
   \begin{center}%
      {\large \bf \@author}
   \end{center}
   \vfill
   \begin{center}%
      A dissertation submitted in partial fulfillment\@centercr
      of the requirements for the degree of\@centercr
      \@degree\@centercr
      (\@program)\@centercr
    in The University of Michigan\@centercr
        \number\year\@centercr
 \end{center}
 \vfill
 \committee
\vspace*{\fill}
\null
\end{titlepage}%
\setcounter{footnote}{0}%
%\gdef\@thanks{}\let\maketitle\relax
}

\newcommand{\makecopyright}{
\begin{titlepage}
  \vspace*{\fill}
  \begin{center}
  \begin{minipage}{.4\textwidth}
  \begin{center}
   \copyright\ \@author\@centercr
   \vspace*{.5em}
   \hrule
   \vspace*{.5em}
   All Rights Reserved\@centercr
   \number\year\\%
  \end{center}
  \end{minipage}
  \end{center}
  \vspace*{\fill}
\end{titlepage}
}

\newenvironment{frontispiece}{%
  \begin{titlepage}%
  \vspace*{\fill}
  %\hspace*{\fill}
  \begin{minipage}{.7\textwidth}
  \begin{flushright}
  }{%
  \end{flushright}
  \end{minipage}
  \vspace*{\fill}
  %\hspace*{\fill}
  \end{titlepage}%
}
\newenvironment{finalabstract}{%
   \pagestyle{empty}
   \setcounter{page}{0}%
  \begin{titlepage}
  \begin{center}
      {\large\bf \abstractname}\@centercr
      \vspace{0.25in}
      {\large \@title}\@centercr
      \vspace*{0.25in}
      by\@centercr
      \vspace*{0.15in}
      {\large \@author}
  \end{center}
   \vspace{0.5in}
   \noindent\begin{tabular}{ll}
       \abschairname
       \the\abstokenlist
       \end{tabular}
    \vspace{0.25in}\par
  \begin{doublespacing}
}{%

\end{doublespacing}
  \end{titlepage}
}

\newenvironment{dedication}{%
   \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\else\newpage\fi%
   \thispagestyle{plain}
   \setcounter{page}{2}%
   \addcontentsline{toc}{chapter}{\textbf{\dedicationname}}%
   \vspace*{\fill}
   \begin{center}
  }{%
  \end{center}
\vspace*{\fill}
  \if@restonecol\twocolumn \else \newpage \fi}

\newenvironment{acknowledgments}{
   \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\else\newpage\fi%
  \chapter*{\acknowledgmentsname\@mkboth{\acknowledgmentsname}\acknowledgmentsname{}}
  \addcontentsline{toc}{chapter}{\textbf{\acknowledgmentsname}}
}{
  \if@restonecol\twocolumn \else \newpage \fi%
}

\newenvironment{preface}{%
   \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\else\newpage\fi%
  \chapter*{\prefacename\@mkboth{\prefacename}\prefacename{}}
  \addcontentsline{toc}{chapter}{\textbf{\prefacename}}
}{
  \if@restonecol\twocolumn \else \newpage \fi%
}

\newenvironment{abstract}{%
   \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn\else\newpage\fi%
  \chapter*{\abstractname\@mkboth{\abstractname}{\abstractname}}
  \addcontentsline{toc}{chapter}{\textbf{\abstractname}}
}{
  \if@restonecol\twocolumn \else \newpage \fi%
}
\renewenvironment{thebibliography}[1]{
\def\ext@toc{toc}
      \phantomsection %makes sure it points to the right page
     \clearpage
\hypersetup{bookmarkstype={toc}}
  \begin{singlespacing}
      \if@appendices
        \clearpage%
        \phantomsection
        \thispagestyle{plain}
        \addcontentsline{toc}{chapter}{\textbf{Bibliography}}
	\vspace*{\fill}
	\begin{center}{\heading \bibname}\end{center}%
	\vspace*{\fill}
	\clearpage
      \else
        \chapter*{\bibname}%
        \addcontentsline{toc}{chapter}{\textbf{Bibliography}}
      \fi
     %\chapter*{\bibname}%
     % \addcontentsline{toc}{chapter}{Bibliography}
      \@mkboth{\bibname}{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
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
      \endlist
  \end{singlespacing}
}
% natbib is a commonly used package for formatting bibliographies. 
% If using natbib, then we must redefine some things in this way
\AtBeginDocument{%
  \@ifpackageloaded{natbib}{
    \renewcommand{\bibsection}{
      \hypersetup{bookmarkstype={toc}}
      \@mkboth{\bibname}{\bibname}%
      % if we use an a half page for appendices, then we also do so for 
      % bibliography
      \if@appendices
        \clearpage%
        \phantomsection
        \thispagestyle{plain}
        \addcontentsline{toc}{chapter}{\textbf{Bibliography}}
	\vspace*{\fill}
	\begin{center}{\heading \bibname}\end{center}%
	\vspace*{\fill}
	\clearpage
      \else
        \chapter*{\bibname}%
        \addcontentsline{toc}{chapter}{\textbf{Bibliography}}
      \fi
    }
    \newcommand{\bibpreamble}{%
      \singlespacing
    }
  }{}
}
% makes lists single spaced, and more compact
% copying from tweaklist.sty

\def\enumhook{}
\def\enumhooki{}
\def\enumhookii{}
\def\enumhookiii{}
\def\enumhookiv{}
\def\itemhook{}
\def\itemhooki{}
\def\itemhookii{}
\def\itemhookiii{}
\def\itemhookiv{}
\def\descripthook{}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}%
          \enumhook \csname enumhook\romannumeral\the\@enumdepth\endcsname}%
  \fi}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}%
        \itemhook \csname itemhook\romannumeral\the\@itemdepth\endcsname}%
  \fi}

\renewenvironment{description}
                 {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                          \let\makelabel\descriptionlabel\descripthook}}
                 {\endlist}
\renewcommand{\itemhook}{\setstretch{1}
  \setlength{\topsep}{0pt}%
  \setlength{\parskip}{0pt}%
  \setlength{\partopsep}{.5\baselineskip}%
  \setlength{\parsep}{0pt}%
  \setlength{\itemsep}{0pt}%
}

% enumerate environment lengths
\renewcommand{\enumhook}{\setstretch{1}
  \setlength{\topsep}{0pt}%
  \setlength{\parskip}{0pt}%
  \setlength{\partopsep}{0pt}%
  \setlength{\parsep}{0pt}%
  \setlength{\itemsep}{0pt}%
}

%%%%% hyperref must be loaded last, because it redefines lots of internals. 
%% So far there do not seem to be any conflicts though
\RequirePackage{hyperref}
