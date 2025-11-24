%% $Id: cnbwp.cls 67 2013-12-18 20:44:49Z zw $
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cnbwp}[2013/12/18 LaTeX class for working papers of CNB]

% Figure and table numbering, hierarchical is the default

\newif\ifCNB@simplenum
\DeclareOption{hierarchicalnumbering}{\CNB@simplenumfalse}
\DeclareOption{simplenumbering}{\CNB@simplenumtrue}
\DeclareOption{centeredcaptions}{\def\CNB@defaultcaptiontype{\CNB@makecenteredcaption}}
\DeclareOption{standardcaptions}{\def\CNB@defaultcaptiontype{\CNB@makestandardcaption}}

% Ignore size options (even without warning)

\DeclareOption{10pt}{}
\DeclareOption{11pt}{}
\DeclareOption{12pt}{}

% Ignore one-/twoside

\DeclareOption{oneside}{}
\DeclareOption{twoside}{}

% Ignore paper sizes

\DeclareOption{a4paper}{}
\DeclareOption{a5paper}{}
\DeclareOption{b5paper}{}
\DeclareOption{letterpaper}{}
\DeclareOption{legalpaper}{}
\DeclareOption{executivepaper}{}
\DeclareOption{landscape}{}

% Pass all global options to the "article" class

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{simplenumbering,standardcaptions,12pt}
\ProcessOptions

% Load the class with default options

\LoadClass[twoside,a4paper,11pt]{article}

\input{cnbwpsizes.clo}

\setlength\partopsep{2\p@ \@plus 1\p@ \@minus 1\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@ \@plus2\p@ \@minus\p@
            \topsep 8\p@ \@plus2\p@ \@minus4\p@
            \itemsep4\p@ \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    4\p@ \@plus2\p@ \@minus\p@
              \parsep    2\p@ \@plus\p@  \@minus\p@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    2\p@ \@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}

% Skips
\bigskipamount\baselineskip
\medskipamount.5\baselineskip
\smallskipamount\medskipamount

% Paper size A4 (all margins 25mm)

\IfFileExists{ifpdf.sty}{\RequirePackage{ifpdf}}{\newif\ifpdf}
\AtBeginDocument{\ifpdf
  \pdfpagewidth\paperwidth \pdfpageheight\paperheight
\else
  \special{papersize=\the\paperwidth,\the\paperheight}\fi}

\oddsidemargin -.4mm
\evensidemargin \oddsidemargin
\textwidth 16cm
\topmargin -1mm

\headheight 14pt
\headsep 8mm
\advance\topmargin -\headheight
\advance\topmargin -\headsep
\footskip \z@

\textheight\paperheight
\advance\textheight -5cm
\advance\textheight -\topskip
\divide\textheight by \baselineskip
\count@ \textheight
\textheight \count@\baselineskip
\advance\textheight \topskip

% \raggedbottom
\advance\topskip 100sp minus 500sp % safety compensation

\parindent\z@
\parskip\baselineskip
\clubpenalty\@M
\widowpenalty\@M
\emergencystretch 1em


\renewcommand\@makefntext[1]{\parindent\z@
    \noindent\@makefnmark\,\ignorespaces#1}

% Sectioning

\let\CNB@xsect\@xsect

\def\@xsect#1{\@tempskipa #1
  \ifdim\@tempskipa>\z@
    \par \nobreak
    \advance\@tempskipa-14\p@
    \advance\@tempskipa-\parskip
    \vskip \@tempskipa
    \@afterheading
  \else
    \CNB@xsect{\@tempskipa}\fi}

\def\section{\@startsection {section}{1}{\z@}%
                            {9pt minus 5pt}%
                            {27pt}% minus 8pt}%
                            {\normalfont\Large\bfseries}}
\def\subsection{\@startsection{subsection}{2}{\z@}%
                              {8pt minus 2pt}%
                              {20pt}%
                              {\normalfont\large\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                 {-3pt minus 2pt}%
                                 {17pt}%
                                 {\normalfont\normalsize\itshape\bfseries}}
\def\paragraph{\@startsection{paragraph}{4}{\z@}%
                             {1sp minus 2pt}%
                             {-\fontdimen 2 \font}%
                             {\normalfont\normalsize\bfseries}}
\def\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                {1sp minus 2pt}%
                                {-\fontdimen 2 \font}%
                                {\normalfont\normalsize\bfseries}}

\newenvironment{nontechsummary}{\CNB@clearpage
      \section*{Nontechnical Summary}}{\clearpage}

\let\CNB@appendix\appendix
\def\appendix{\clearpage\CNB@appendix
    \def\CNB@section@prefix{\appendixname\CNB@fixed@space\ignorespaces}%
    \def\CNB@section@maybedot{:}}

% Numbering and captions

\def\theequation{\thesection.\arabic{equation}}
\def\@seccntformat#1{\csname CNB@#1@prefix\endcsname \csname the#1\endcsname
                     \csname CNB@#1@maybedot\endcsname\CNB@fixed@space \relax}
\def\CNB@section@maybedot{.}
\def\CNB@fixed@space{\hskip \fontdimen 2 \font \relax}

\ifCNB@simplenum
  \def\thefigure{\arabic{figure}}
  \def\thetable{\arabic{table}}
\else
  \def\thefigure{\thesection.\arabic{figure}}
  \def\thetable{\thesection.\arabic{table}}
  \@addtoreset{figure}{section}
  \@addtoreset{table}{section}
\fi

\abovecaptionskip\baselineskip
\belowcaptionskip\baselineskip

\def\@makecaption{\let\CNB@makecaption\CNB@makedefaultcaption
    \let\CNB@makedefaultcaption\CNB@defaultcaptiontype
    \CNB@makecaption}

\long\def\CNB@makecenteredcaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\itshape \bfseries #1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    {\itshape \bfseries #1: #2}\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\def\CNB@makestandardcaption#1#2{\vskip\abovecaptionskip
  {\itshape \bfseries #1: #2\par}\vskip\belowcaptionskip}

\let\CNB@makedefaultcaption\CNB@defaultcaptiontype

\def\centeredcaption{\let\CNB@makedefaultcaption\CNB@makecenteredcaption \caption}
\def\standardcaption{\let\CNB@makedefaultcaption\CNB@makestandardcaption \caption}

% Note, Source
\newdimen\CNB@tempdima
\newbox\CNB@tempbox

\def\Note{\CNB@notesource{Note}}
\def\Source{\CNB@notesource{Source}}
\def\CNB@notesource#1#2{\ifhmode \par \fi  {\Footnotesize
    \setbox\CNB@tempbox=\hbox{\textit{\textbf{#1:}} }\CNB@tempdima=\wd\CNB@tempbox
    \noindent \llap{\box\CNB@tempbox}\ignorespaces #2\unskip \leftskip\CNB@tempdima \par}}

% Page style

\def\CNB@psrule{\vskip -9pt \vrule height .5pt width \textwidth}
\def\CNB@pshskip{\hskip 8pt }
\def\ps@cnbwp{\def\@oddfoot{}\let\@evenfoot\@oddfoot
    \def\@evenhead{\let\thanks\@gobble\normalfont\normalsize
        \setbox\CNB@tempbox=\hbox{\thepage\CNB@pshskip}%
        \CNB@tempdima=\textwidth \advance\CNB@tempdima -\wd\CNB@tempbox
        \vbox to \headheight{\hsize\textwidth \vss
           \hbox to \textwidth{\vbox{\hsize\wd\CNB@tempbox \box\CNB@tempbox}\hss
               \vbox{\hsize\CNB@tempdima \raggedright \textit{\the\CNB@authors}}}\CNB@psrule}}%
    \def\@oddhead{\let\thanks\@gobble\normalfont\normalsize
        \setbox\CNB@tempbox=\hbox{\CNB@pshskip\thepage}%
        \CNB@tempdima=\textwidth \advance\CNB@tempdima -\wd\CNB@tempbox
        \vbox to \headheight{\hsize\textwidth \vss
           \hbox to \textwidth{\vbox{\hsize\CNB@tempdima \CNB@raggedleft \textit{\CNB@tit}}\hss
               \vbox{\hsize\wd\CNB@tempbox \box\CNB@tempbox}}\CNB@psrule}}}

\def\CNB@raggedleft{\parfillskip \z@ \leftskip 0pt plus .3\textwidth \relax \hskip 0mm plus .5\textwidth}
\pagestyle{cnbwp}

% Title page
\newtoks\CNB@autaddress
\newtoks\CNB@authors
\def\CNB@lastauthor{}

\def\CNB@add@address#1#2{\ifcat$\the\CNB@autaddress$
    \else \CNB@autaddress\expandafter{\the\CNB@autaddress\\}\fi
    \CNB@autaddress\expandafter{\the\CNB@autaddress #1\CNB@comma #2}}

\def\CNB@add@author@with@delim#1{\ifcat$\the\CNB@authors$
      \ifcat$\CNB@lastauthor$ \else \CNB@authors\expandafter{\CNB@lastauthor}\fi
    \else
      \ifcat$\CNB@lastauthor$ \else
        \CNB@authors\expandafter\expandafter\expandafter
        {\expandafter\the\expandafter\CNB@authors #1}% add delimiter
        \CNB@authors\expandafter\expandafter\expandafter
        {\expandafter\the\expandafter\CNB@authors\CNB@lastauthor}% expanded stored author
        \let\CNB@and\CNB@comma@and
      \fi
    \fi}

\def\author#1#2{\CNB@add@address{#1}{#2}\CNB@add@author@with@delim\CNB@comma
    \def\CNB@lastauthor{#1}}

\def\CNB@comma{\unskip, \ignorespaces}
\def\CNB@and{\unskip\space and \ignorespaces}
\def\CNB@comma@and{\unskip, and \ignorespaces}

\def\title#{\def\CNB@tit}
\long\def\acknowledge#1{\def\CNB@ack{\\#1}}
\def\CNB@ack{}

\def\maketitle{\CNB@add@author@with@delim\CNB@and
  \thispagestyle{empty}\vspace*{-8.8mm}\begingroup
  \def\thefootnote{\fnsymbol{footnote}}\let\thanks\footnote
  \begin{center}\normalfont\Large\bfseries
    \CNB@tit
  \end{center}
  \vskip 25pt plus .333fil
  \begin{center}
    \let\@makefnmark\@gobble
    \large\the\CNB@authors\,$^*$\footnotetext{\the\CNB@autaddress \CNB@ack}
  \end{center}
  \endgroup\setcounter{footnote}{0}%
}

\def\CNB@indentenv #1#2:{\begingroup \parskip\z@ \leftskip 30mm \parindent -25mm
    \rightskip \leftskip \advance\rightskip \parindent
    \aftergroup#1\normalfont
    \leavevmode\hbox to -\parindent{\bfseries #2:\hfil}\catcode`\.13 \CNB@getarg}

\def\CNB@getarg#1{\ignorespaces #1\CNB@punct.\par\endgroup}

\def\JEL{\CNB@indentenv \relax JEL Codes:}
\def\Keywords{\CNB@indentenv \CNB@clearpage Keywords:}

\renewenvironment{abstract}{\leftskip 5mm \rightskip\leftskip \vskip 25pt plus .333fil
  \normalfont \small
  \centerline{\large\bfseries Abstract}}{\par}

\newenvironment{abstrakt}{\begin{otherlanguage}{czech}\leftskip 5mm \rightskip\leftskip
  \vskip 14pt plus .333fil \normalfont \small
  \centerline{\large\bfseries Abstrakt}}{\par\end{otherlanguage}\vskip 48pt \relax}

\let\CNB@clearpage\clearpage

% Required packages

\RequirePackage[T1]{fontenc}
\RequirePackage[czech,english]{babel}
\RequirePackage{mathptmx}
\RequirePackage{url}[2004/03/15]
\let\CNBurl\url
\AtBeginDocument{\let\url\CNBurl}

% Bibliography (references}

\RequirePackage{natbib,keyval}
\bibhang 35pt % indentation

\def\CNB@actchars{\catcode`\?13 \catcode`\!13 \catcode`\.13 }
{\catcode`\?13
\expandafter}\expandafter\def\noexpand?{?\CNB@maybepunct}
{\catcode`\!13
\expandafter}\expandafter\def\noexpand!{!\CNB@maybepunct}
{\catcode`\.13
\expandafter}\expandafter\def\noexpand.{.\CNB@maybepunct}

\DeclareRobustCommand\CNB@maybepunct{\def\CNB@space{}\futurelet\next\CNB@ifpunct}
\futurelet\CNB@sptok{ }
\def\CNB@ifpunct{\ifx\next\CNB@sptok
    \def\CNB@space{\unskip\space}\def\next{\CNB@xifpunct:}%
    \else\ifx\next\CNB@egroup
      \def\CNB@afterpunct{\/\egroup}\def\next\CNB@egroup{\CNB@xifpunct: }%
    \else\ifx\next\CNB@punct
      \def\next\CNB@punct##1{\CNB@afterpunct\space}%
    \else
      \def\next{\CNB@space\CNB@afterpunct}\fi\fi\fi
    \next}
\def\CNB@xifpunct: {\futurelet\next\CNB@ifpunct}
\def\CNB@afterpunct{}
\def\CNB@punct#1{\unskip#1\CNB@afterpunct\space}
\def\CNB@egroup{\def\CNB@afterpunct{\/\egroup}}

% Keys
\define@key{CNBbib}{address}{\def\CNBbib@address{#1}}
\define@key{CNBbib}{author}{\def\CNBbib@author{#1}}
\define@key{CNBbib}{booktitle}{\def\CNBbib@booktitle{#1}}
\define@key{CNBbib}{chapter}{\def\CNBbib@chapter{#1}}
\define@key{CNBbib}{edition}{\def\CNBbib@edition{#1}}
\define@key{CNBbib}{editor}{\def\CNBbib@editor{#1}}
\define@key{CNBbib}{howpublished}{\def\CNBbib@howpublished{#1}}
\define@key{CNBbib}{institution}{\def\CNBbib@institution{#1}}
\define@key{CNBbib}{journal}{\def\CNBbib@journal{#1}}
\define@key{CNBbib}{month}{\def\CNBbib@month{#1}}
\define@key{CNBbib}{note}{\def\CNBbib@note{#1}}
\define@key{CNBbib}{number}{\def\CNBbib@number{#1}}
\define@key{CNBbib}{organization}{\def\CNBbib@organization{#1}}
\define@key{CNBbib}{pages}{\def\CNBbib@pages{#1}}
\define@key{CNBbib}{publisher}{\def\CNBbib@publisher{#1}}
\define@key{CNBbib}{school}{\def\CNBbib@school{#1}}
\define@key{CNBbib}{series}{\def\CNBbib@series{#1}}
\define@key{CNBbib}{title}{\def\CNBbib@title{#1}}
\define@key{CNBbib}{type}{\def\CNBbib@type{#1}}
\define@key{CNBbib}{volume}{\def\CNBbib@volume{#1}}
\define@key{CNBbib}{year}{\def\CNBbib@year{#1}}

\let\CNB@thebibliography\thebibliography

\def\thebibliography{\clearpage
    \DeclareUrlCommand\url{\def\UrlLeft{(}\def\UrlRight{)}\urlstyle{rm}}%
    \CNB@thebibliography}


% Formatting macros
\newtoks\CNB@toks
\newif\ifCNB@inserted
\def\CNB@extra{}
\def\CNB@addtoks#1{\global\CNB@toks\expandafter{\the\CNB@toks #1}}

\newcommand*\CNB@usekey[2][\CNB@nostyle]{\expandafter
            \ifx\csname CNBbib@#2\endcsname\relax\CNB@insertedfalse
            \else
            \@temptokena\expandafter\expandafter\expandafter{\csname CNBbib@#2\endcsname}%
            \CNB@addtoks{#1}\CNB@insertedtrue
            \expandafter\CNB@addtoks\expandafter{\expandafter{\the\@temptokena}}\fi}

\newcommand*\CNB@ifkey[3][\CNB@nostyle]{\expandafter
            \ifx\csname CNBbib@#2\endcsname\relax\CNB@insertedfalse
            \else \CNB@usekey[#1]{#3}\fi}

\def\CNB@nostyle#1{#1}% just to suppress superfluous groups
\def\CNB@block#1{\newblock #1}% see the note above
\def\CNB@qblock#1{\newblock \bgroup\aftergroup\CNB@rquote ``#1\CNB@egroup}
\def\CNB@rquote{''}
\def\CNB@quoted#1{\bgroup\aftergroup\CNB@rquote ``#1\CNB@egroup}
\def\CNB@style #1 #2{\bgroup\csname #1\endcsname #2\CNB@egroup}
\def\CNB@paren#1{ (#1)}
\def\CNB@nbsp#1{#1~}
\def\CNB@of #1 #2{#1~#2 of }
\def\CNB@edition#1{#1 edition}
\def\CNB@maybeblock{\def\CNB@bstyle{\let\CNB@bstyle\CNB@block\CNB@nostyle}}
\def\CNB@maybedot{\ifCNB@inserted\CNB@addpunct.\fi}
\def\CNB@maybecomma{\ifCNB@inserted\CNB@addpunct,\fi}
\def\CNB@maybecolon{\ifCNB@inserted\CNB@addpunct:\fi}
\def\CNB@addpunct#1{\CNB@addtoks{\CNB@punct#1}}

\def\CNB@inititem{\@ifnextchar[\CNB@xbibitem\CNB@bibitem}
\def\CNB@xbibitem[#1]#2{\bibitem[#1]{#2}\CNB@formatbibitem}
\def\CNB@bibitem#1{\bibitem{#1}\CNB@formatbibitem}
\def\CNB@setkeys{\setkeys{CNBbib}}

\def\CNB@formatbibitem{\global\CNB@toks{\normalsize\normalfont}\begingroup
    \CNB@actchars\CNB@argbibitem}
\def\CNB@argbibitem#1{\expandafter\CNB@setkeys\expandafter{\CNB@extra,#1}\CNB@bibformat
    \endgroup\gdef\CNB@extra{}\the\CNB@toks}

\def\CNB@insauthors{\CNB@usekey[\CNB@style scshape ]{author}\CNB@addpunct\relax}
\def\CNB@inseditors{\CNB@usekey[\newblock In \CNB@nostyle]{editor}%
    \ifCNB@inserted\CNB@addtoks{, editors}\fi}
\def\CNB@insnote{\CNB@usekey[\CNB@block]{note}}%\CNB@maybedot}
\def\CNB@insyear{\CNB@usekey[\CNB@paren]{year}}
\newcommand*\CNB@insmonthyear[1][\CNB@punct,]{%\ifCNB@inserted
    \CNB@usekey[#1\CNB@nostyle]{month}%
    \ifCNB@inserted
      \CNB@usekey[ \CNB@nostyle]{year}%
    \else
      \CNB@usekey[#1\CNB@nostyle]{year}%
    \fi}
%  \else
%    \CNB@usekey[ \CNB@nostyle]{month}%
%    \CNB@usekey[ \CNB@nostyle]{year}%
%  \fi}

\def\CNB@insyear{\CNB@usekey[\CNB@paren]{year}}
\def\CNB@year{\ifCNB@inserted \let\next\expandafter \else \let\next\relax \fi
    \next\CNB@insyear \ifCNB@inserted \CNB@addpunct:\fi}

\def\CNB@okdot{\ifCNB@inserted \def\next{\CNB@addpunct.}\fi}

% Definitions of the entry types

\def\mastersthesisItem{\gdef\CNB@extra{type=Master's thesis}\let\CNB@bibformat
    \CNB@thesis\CNB@inititem}
\def\phdthesisItem{\gdef\CNB@extra{type=PhD thesis}\let\CNB@bibformat\CNB@thesis
    \CNB@inititem}
\def\CNB@thesis{\CNB@insauthors \CNB@year \CNB@usekey[\CNB@qblock]{title}\CNB@maybedot
    \CNB@usekey[\CNB@block]{type}%
    \CNB@usekey[, \CNB@nostyle]{school}%
    \CNB@usekey[, \CNB@nostyle]{address}\CNB@addpunct.\CNB@insnote}

\def\miscItem{\let\CNB@bibformat\CNB@misc\CNB@inititem}
\def\CNB@misc{\CNB@addtoks{\CNB@maybeblock}%
    \CNB@usekey[\CNB@bstyle{}\CNB@style scshape ]{author}\CNB@year
    \CNB@usekey[\CNB@bstyle{}\CNB@quoted]{title}\CNB@maybedot
    \CNB@usekey[\CNB@bstyle]{howpublished}\CNB@maybedot\CNB@insnote}

\def\unpublishedItem{\let\CNB@bibformat\CNB@unpublished\CNB@inititem}
\def\CNB@unpublished{\CNB@insauthors\CNB@year\CNB@usekey[\CNB@qblock]{title}\CNB@maybedot
    \CNB@insnote}

\def\manualItem{\let\CNB@bibformat\CNB@manual\CNB@inititem}
\def\CNB@manual{\CNB@addtoks{\CNB@maybeblock}%
    \CNB@usekey[\CNB@bstyle{}\CNB@style scshape ]{author}\CNB@year %%%%%%%
    \CNB@usekey[\CNB@bstyle{}\CNB@style em ]{title}\CNB@maybedot
    \let\next\relax
    \CNB@usekey[\CNB@bstyle]{organization}\CNB@okdot
    \CNB@usekey[, \CNB@nostyle]{address}% address without organization makes no sense
    \CNB@okdot
    \ifx\next\relax
      \CNB@usekey[\CNB@bstyle{}\CNB@edition]{edition}% no organization
    \else
      \CNB@usekey[, \CNB@edition]{edition}% organization used
    \fi \CNB@okdot
    \next
    \CNB@insnote}

\def\techreportItem{\let\CNB@bibformat\CNB@techreport
    \gdef\CNB@extra{type=Technical report}\CNB@inititem}
\def\CNB@techreport{\CNB@insauthors \CNB@year
    \CNB@usekey[\CNB@qblock]{title}\CNB@maybedot
    \CNB@usekey[\CNB@block]{type}%
    \CNB@usekey[\unskip~\CNB@nostyle]{number}%
    \CNB@usekey[, \CNB@nostyle]{institution}%
    \CNB@usekey[, \CNB@nostyle]{address}\CNB@maybedot\CNB@insnote}

\def\bookletItem{\let\CNB@bibformat\CNB@booklet\CNB@inititem}
\def\CNB@booklet{\CNB@addtoks{\CNB@maybeblock}%
    \CNB@usekey[\CNB@bstyle{}\CNB@style scshape ]{author}\CNB@year
    \CNB@usekey[\CNB@bstyle{}\CNB@quoted]{title}%
    \CNB@usekey[, \CNB@edition]{edition}\CNB@addpunct.%
    \CNB@usekey[\CNB@bstyle]{howpublished}%
    \CNB@usekey[, \CNB@nostyle]{address}\CNB@maybedot
    \CNB@insnote}

\def\proceedingsItem{\let\CNB@bibformat\CNB@proceedings\CNB@inititem}
\def\CNB@proceedings{\CNB@addtoks{\CNB@maybeblock}%
    \CNB@usekey[\CNB@bstyle{}\CNB@style scshape ]{editor}%
    \ifCNB@inserted\CNB@addtoks{\CNB@punct,editors}\fi\CNB@year
    \CNB@usekey[\CNB@bstyle{}\CNB@style em ]{title}%
    \CNB@usekey[\CNB@punct,volume~]{volume}%
    \CNB@usekey[\CNB@punct,number~]{number}%
    \CNB@usekey[\CNB@punct,in ]{series}%
    \CNB@usekey[\CNB@punct,]{address}%
    \CNB@addpunct.%
    \CNB@usekey{organization}%
    \ifCNB@inserted
      \CNB@usekey[\CNB@punct,]{publisher}\CNB@addpunct.%
    \else
      \CNB@usekey{publisher}\CNB@maybedot
    \fi \CNB@insnote}

\def\inproceedingsItem{\let\CNB@bibformat\CNB@inproceedings\CNB@inititem}
\def\CNB@inproceedings{\CNB@insauthors \CNB@year
    \CNB@usekey[\CNB@qblock]{title}\CNB@maybedot
    \CNB@inseditors
    \ifCNB@inserted
      \CNB@usekey[\CNB@punct,\CNB@style em ]{booktitle}%
    \else
      \CNB@usekey[\CNB@block{In} \CNB@style em ]{booktitle}%
    \fi
    \CNB@usekey[\CNB@punct,volume~]{volume}%
    \CNB@usekey[\CNB@punct,number~]{number}%
    \CNB@usekey[\CNB@punct,in ]{series}%
    \CNB@usekey[\CNB@punct,]{address}%
    \CNB@addpunct.%
    \CNB@usekey{organization}%
    \ifCNB@inserted
      \CNB@usekey[\CNB@punct,]{publisher}\CNB@addpunct.%
    \else
      \CNB@usekey{publisher}\CNB@maybedot
    \fi \CNB@insnote}
\let\conferenceItem\inproceedingsItem

\def\bookItem{\let\CNB@bibformat\CNB@book\CNB@inititem}
\def\CNB@book{\CNB@insauthors
    \ifCNB@inserted \else
      \CNB@usekey[\CNB@bstyle{}\CNB@style scshape ]{editor}%
      \ifCNB@inserted\CNB@addtoks{, {\normalfont editors}. }\fi
    \fi
    \CNB@year
    \CNB@usekey[\newblock\CNB@style em ]{title}%
    \CNB@usekey[\CNB@punct,\CNB@of volume ]{volume}%
    \CNB@usekey[\CNB@punct,\CNB@of number ]{number}%
    \CNB@usekey[\CNB@style em ]{series}\CNB@addpunct.%
    \CNB@usekey[\CNB@block]{publisher}%
    \CNB@usekey[\CNB@punct,\CNB@nostyle]{address}%
    \CNB@usekey[\CNB@punct,\CNB@edition]{edition}\CNB@addpunct.\CNB@insnote}

\def\inbookItem{\gdef\CNB@extra{type=chapter}\let\CNB@bibformat\CNB@inbook\CNB@inititem}
\def\CNB@inbook{\CNB@insauthors
    \ifCNB@inserted \else
      \CNB@usekey[\CNB@bstyle{}\CNB@style scshape ]{editor}%
      \ifCNB@inserted\CNB@addtoks{, {\normalfont editors}. }\fi
    \fi
    \CNB@year
    \CNB@usekey[\newblock\CNB@style em ]{title}%
    \CNB@usekey[\CNB@punct,\CNB@of volume ]{volume}%
    \CNB@usekey[\CNB@punct,\CNB@of number ]{number}%
    \CNB@usekey[\CNB@style em ]{series}%
    \CNB@ifkey[\CNB@punct,\CNB@nbsp]{chapter}{type}\CNB@usekey{chapter}%
    \CNB@usekey[\CNB@punct,pages~]{pages}\CNB@addpunct.%
    \CNB@usekey[\CNB@block]{publisher}%
    \CNB@usekey[\CNB@punct,\CNB@nostyle]{address}%
    \CNB@usekey[\CNB@punct,\CNB@edition]{edition}\CNB@addpunct.\CNB@insnote}

\def\incollectionItem{\gdef\CNB@extra{type=chapter}\let\CNB@bibformat\CNB@incollection\CNB@inititem}
\def\CNB@incollection{\CNB@insauthors \CNB@year
    \CNB@usekey[\newblock\CNB@style em ]{title}\CNB@maybedot\CNB@inseditors
    \ifCNB@inserted
      \CNB@usekey[\CNB@punct,\CNB@style em ]{booktitle}%
    \else
      \CNB@usekey[\newblock In \CNB@style em ]{booktitle}%
    \fi
    \CNB@usekey[\CNB@punct,\CNB@of volume ]{volume}%
    \CNB@usekey[\CNB@punct,\CNB@of number ]{number}%
    \CNB@usekey[\CNB@style em ]{series}%
    \CNB@ifkey[\CNB@punct,\CNB@nbsp]{chapter}{type}\CNB@usekey{chapter}%
    \CNB@usekey[\CNB@punct,pages~]{pages}\CNB@addpunct.%
    \CNB@usekey[\CNB@block]{publisher}%
    \CNB@usekey[\CNB@punct,\CNB@nostyle]{address}%
    \CNB@usekey[\CNB@punct,\CNB@edition]{edition}\CNB@addpunct.\CNB@insnote}

\def\articleItem{\let\CNB@bibformat\CNB@article\CNB@inititem}
\def\CNB@article{\CNB@insauthors \CNB@year
    \CNB@usekey[\CNB@qblock]{title}\CNB@maybedot
    \CNB@usekey[\newblock\CNB@style em ]{journal}%
    \CNB@usekey[\CNB@punct,\CNB@nostyle]{volume}%
    \ifCNB@inserted
      \CNB@usekey[\penalty0(\CNB@nostyle]{number}\ifCNB@inserted\CNB@addtoks)\fi
      \CNB@usekey[:\penalty0 \CNB@nostyle]{pages}%
    \else
      \CNB@usekey[\CNB@punct,(\CNB@nostyle]{number}%
      \ifCNB@inserted
        \CNB@usekey[):\penalty0 \CNB@nostyle]{pages}%
      \else
        \CNB@usekey[\CNB@punct,\CNB@nostyle]{pages}%
      \fi
    \fi
    \CNB@addpunct.\CNB@insnote}
