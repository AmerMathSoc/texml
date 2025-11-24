%%
%% This is file `emisa.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% emisa.dtx  (with options: `class')
%% 
%% If you absolutely have to change emisa.cls, please
%% do so in emisa.dtx (after altering the name, of course!).
%% 
%% Copyright (C) 2009,2010,2011,2012 by Martin Wilhelm Leidig
%% <mwl@moss.in-berlin.de>
%% Copyright (C) 2015,2016 by Enterprise Modelling and Information
%% Systems Architectures -- An International Journal (EMISA)
%% ------------------------------------------------------------------------
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version. The latest version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status) by
%% Stefan Strecker <stefan.strecker@fernuni-hagen.de> and
%% Martin Sievers <martin.sievers@schoenerpublizieren.de>.
%% 
%% This work consists of all files listed in manifest.txt.
%% ------------------------------------------------------------------------
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{emisa}%
[2016/03/31 2.1 LaTeX class EMISA]
\def\@clearglobaloption#1{%
  \def\@tempa{#1}%
  \def\@tempb{\@gobble}%
  \@for\next:=\@classoptionslist\do
    {\ifx\next\@tempa
       \message{Cleared  option \next\space from global list}%
     \else
       \edef\@tempb{\@tempb,\next}%
     \fi}%
  \let\@classoptionslist\@tempb
  \expandafter\ifx\@tempb\@gobble
    \let\@classoptionslist\@empty
  \fi}
\DeclareOption{british}{%
   \PassOptionsToPackage{british}{babel}
   \PassOptionsToPackage{english=british}{csquotes}
   \@clearglobaloption{british}}
\DeclareOption{UKenglish}{%
   \PassOptionsToPackage{british}{babel}
   \PassOptionsToPackage{english=british}{csquotes}
   \@clearglobaloption{british}}
\DeclareOption{american}{%
   \PassOptionsToPackage{american}{babel}
   \PassOptionsToPackage{english=american}{csquotes}
   \@clearglobaloption{american}}
\DeclareOption{USenglish}{%
   \PassOptionsToPackage{american}{babel}
   \PassOptionsToPackage{english=american}{csquotes}
   \@clearglobaloption{american}}
\newif\if@draft
\DeclareOption{draft}{%
  \@drafttrue
  \overfullrule 10pt
}%
\DeclareOption{final}{%
  \@draftfalse
  \overfullrule\z@
}%
\newif\if@referee
\DeclareOption{referee}{\@refereetrue}
\DeclareOption{noreferee}{\@refereefalse}
\DeclareOption{review}{\@refereetrue}
\DeclareOption{noreview}{\@refereefalse}
\newif\if@cover
\def\coveron{\@covertrue}
\def\coveroff{\@coverfalse}
\DeclareOption{cover}{\coveron}
\DeclareOption{nocover}{\coveroff}
\newif\if@microtype
\@microtypetrue
\DeclareOption{nomicrotype}{\@microtypefalse}
\PassOptionsToClass{a4paper,twoside,11pt}{article}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}%
\ExecuteOptions{british,final,noreferee,nocover,oneside,openany}%
\ProcessOptions*\relax%
\IfFileExists{latexrelease.sty}%
   {\RequirePackage[latest]{latexrelease}}%
   {\RequirePackage{fixltx2e}}%
\LoadClass{article}[2001/06/01]%
\RequirePackage[utf8]{inputenc}%
\RequirePackage[T1]{fontenc}%
\RequirePackage[full]{textcomp}%
\if@microtype
   \RequirePackage[final,tracking=smallcaps,expansion=alltext,protrusion=true]{microtype}%
   \SetTracking{encoding=*,shape=sc}{50}%
\else
   \ClassWarning{emisa}{Package `microtype' not loaded!%
      \MessageBreak Output will differ from final result in the journal!%
      \MessageBreak Please consult the documentation, if you%
      \MessageBreak get an error when loading microtype}
\fi%
\RequirePackage{babel}%
\RequirePackage{float}
\RequirePackage[font={small}]{caption}
\RequirePackage{graphicx}%
\RequirePackage[fixinclude,table]{xcolor}%
\RequirePackage{etoolbox}%
\RequirePackage[%
    style=emisa,%
    natbib=true,%
    backend=biber,%
]{biblatex}
\ExecuteBibliographyOptions{%
   maxcitenames=2,%
   maxbibnames=999,%
   terseinits=false,%
   isbn=false,%
   url=true,%
   doi=false,%
   eprint=false,%
   dashed=false,%
   bibencoding=inputenc,%
   sorting=anyt,%
   hyperref=true,%
   uniquename=minfull,%
   uniquelist=false%
}%
\RequirePackage[autostyle=once]{csquotes}
\RequirePackage{twoopt}%
\RequirePackage{environ}%
\RequirePackage[neveradjust,defblank,flushright]{paralist}%
\let\itemize\compactitem
\let\enditemize\endcompactitem
\let\enumerate\compactenum
\let\endenumerate\endcompactenum
\let\description\compactdesc
\let\enddescription\endcompactdesc
\setdefaultenum{1.}{a)}{i.}{A}%
\setdefaultleftmargin{1em}{0.9em}{0.7em}{0.5em}{0.4em}{0.3em}%
\setlength{\plitemsep}{3\p@}%
\setlength{\pltopsep}{6\p@}
\RequirePackage{afterpage,xspace,calc}%
\RequirePackage{geometry}%
\RequirePackage{eso-pic}%
\RequirePackage{placeins}%
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage[zerostyle=b,straightquotes]{newtxtt}
\if@microtype
   \UseMicrotypeSet[protrusion]{basicmath} % disable protrusion for tt fonts
\fi%
\InputIfFileExists{glyphtounicode}%
   {\ClassInfo{emisa}{Reading file `glyphtounicode.tex`}
    \pdfgentounicode=1}%
   {\ClassWarning{emisa}{Couldn't find file `glyphtounicode.tex`}}%
   \RequirePackage{booktabs}
   \RequirePackage{listings}
   \lstset{basicstyle=\ttfamily\small}
   \lstnewenvironment{java}[1][]
      {\lstset{language=Java,float=*htbp,#1}}
      {}
   \lstnewenvironment{java*}[1][]
      {\lstset{language=Java,float=htbp,#1}}
      {}
   \lstnewenvironment{sourcecode}[1][]
      {\lstset{float=*htbp,#1}}
      {}
   \lstnewenvironment{sourcecode*}[1][]
      {\lstset{float=htbp,#1}}
      {}
   \RequirePackage{amsmath}
   \RequirePackage[amsmath,standard,hyperref]{ntheorem}
\RequirePackage{url}
\urlstyle{same}
\RequirePackage[%
  colorlinks,
  breaklinks,
  pdfview=Fit,
  bookmarksopen,
  bookmarksnumbered,
  linkcolor=black,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black,
  hyperfootnotes=false
  ]{hyperref}%
\RequirePackage{doclicense}
\begingroup
  \catcode`\Z=3
  \long\gdef\@M@T@#1#2Z#3#4#5\@nil{#4}
  \long\gdef\@ifempty#1{\@M@T@#1ZZ\@secondoftwo\@firstoftwo\@nil}
  \long\gdef\@ifarg#1{\@M@T@#1ZZ\@firstofone\@gobble\@nil}
  \long\gdef\@ifnoarg#1{\@M@T@#1ZZ\@gobble\@firstofone\@nil}
\endgroup
\geometry{%
  a4paper,%
  portrait,%
  twoside,%
  ignoreall,%
  hcentering,%
  textwidth      = 162.5mm,%
  textheight     = 220mm,%
  heightrounded,%
  columnsep      = 12.5mm,%
  top            = 47mm,%
  headheight     = 16mm,%
  headsep        = 13mm,%
  marginparwidth = 15mm,%
  marginparsep   = 5mm,%
  footskip       = 16mm%
  }%
\marginparpush 5mm%
\AtBeginDocument{\baselineskip=13.6pt plus 0.5pt}%
\parindent=4mm%
\smallskipamount=.5\baselineskip
\medskipamount=2\smallskipamount
\bigskipamount=2\medskipamount
\flushbottom
\abovedisplayskip=.5\baselineskip plus .33\baselineskip
                                  minus .33\baselineskip
\belowdisplayskip=\abovedisplayskip
\abovedisplayshortskip= 0pt plus .33\baselineskip
\belowdisplayshortskip=.5\baselineskip plus .33\baselineskip
                                       minus .33\baselineskip
\def\pageheadfont{\normalfont}%
\def\pagenumfont{\pageheadfont\bfseries}%
\def\pagefootfont{\pageheadfont}%
\def\authorfont{\normalfont\Large}%
\def\titlefont{\normalfont\bfseries\LARGE\boldmath}%
\def\subtitlefont{\normalfont\bfseries\Large\boldmath}%
\def\abstractfont{\normalfont\itshape}%
\def\affiliationfont{\normalfont}
\def\affiliationauthorfont{\bfseries}
\def\affiliationaddressfont{\mdseries}
\def\affiliationemailfont{\mdseries}%
\def\sectionfont{%
  \normalfont
  \bfseries
  \boldmath}%
\def\sec@font{\sectionfont\large}%
\def\para@font{\sectionfont}%
\def\captionfont{\normalfont\small\itshape}
\definecolor{coverbgcolor}{cmyk}{0.15,0.1,0.09,0}%
\definecolor{covertextcolor}{cmyk}{0.77,0.76,0.70,0.61}%
\definecolor{headtextcolor}{gray}{0.5}%
\definecolor{boxframecolor}{gray}{1}%
\definecolor{boxbgcolor}{gray}{0.8}%
\newcommand{\displayskipstretch}{\baselinestretch}
\newcommand{\setdisplayskipstretch}[1]{\def\displayskipstretch{#1}}
\newcommand{\setstretch}[1]{%
  \def\baselinestretch{#1}%
  \@currsize
}
\def\@setsize#1#2#3#4{%
  \@nomath#1%
  \let\@currsize#1%
  \baselineskip #2%
  \baselineskip=\baselinestretch\baselineskip
  \parskip=\baselinestretch\parskip
  \setbox\strutbox \hbox{%
    \vrule height.7\baselineskip
           depth.3\baselineskip
           width\z@}%
  \skip\footins=\baselinestretch\skip\footins
  \normalbaselineskip\baselineskip#3#4}
\everydisplay\expandafter{%
  \the\everydisplay
  \abovedisplayskip   \displayskipstretch\abovedisplayskip
  \belowdisplayskip   \displayskipstretch\belowdisplayskip
  \abovedisplayshortskip  \displayskipstretch\abovedisplayshortskip
  \belowdisplayshortskip  \displayskipstretch\belowdisplayshortskip
}
\def\journalname#1{\@bsphack\def\@journalname{#1}\@esphack}%
\journalname{Enterprise Modelling and Information Systems Architectures}%
\long\def\issn#1{\@bsphack\long\def\@issn{#1}\@esphack}%
\issn{%ISSN 1860-6059 (Print)\par
      ISSN 1866-3621 (Online)}%
\def\volume#1{\@bsphack\def\@volume{#1}\@esphack}%
\volume{\textcolor{red}{0}}%
\def\issue#1#2{\@bsphack
  \def\@issue{#1}%
  \def\@issuedate{#2}%
  \@esphack}%
\issue{\textcolor{red}{0}}{\textcolor{red}{month 0000}}%
\def\specialissuetitle{\@ifstar\@sspit\@spit}%
\newcommand{\@spit}[2][]{%
  \@bsphack
  \@ifempty{#2}%
   {\let\@specialissuetitle\relax}%
   {\@ifempty{#1}%
     {\def\@specialissuetitle{\@specialissuetitleprefix#2}}%
     {\def\@specialissuetitle{#1\space#2}}}%
  \@esphack}%
\newcommand{\@sspit}[2][]{%
  \@bsphack
  \@ifempty{#2}%
   {\let\@specialissuetitle\relax}%
   {\def\@specialissuetitle{#2}}%
  \@esphack}%
\newcommand{\specialissuetitleprefix}[1]{%
  \@bsphack
  \@ifempty{#1}%
     {\let\@specialissuetitleprefix\relax}%
     {\def\@specialissuetitleprefix{#1\space}}%
  \@esphack}%
\specialissuetitle{}%
\specialissuetitleprefix{Special Issue on}%
\def\copyrightyear#1{\@bsphack\def\@copyrightyear{#1}\@esphack}%
\copyrightyear{\the\year}%
\def\copyrightholder#1{\@bsphack\def\@copyrightholder{#1}\@esphack}%
\copyrightholder{\textcolor{red}{\copyright{}holder}}%
\renewcommandtwoopt*{\title}[3][][]{%
  \@bsphack
  \def\@title{#3}%
  \@ifempty{#1}{\def\@shorttitle{\@title}}{\def\@shorttitle{#1}}%
           \@ifempty{#2}{\def\@toctitle{\@shorttitle}}{\def\@toctitle{#2}}%
  \@esphack}%
\newcommandtwoopt*{\subtitle}[3][][]{%
  \@bsphack
  \def\@subtitle{#3}%
  \@ifempty{#1}{\def\@shortsubtitle{\@subtitle}}{\def\@shortsubtitle{#1}}%
  \@ifempty{#2}{\def\@tocsubtitle{\@shortsubtitle}}{\def\@tocsubtitle{#2}}%
  \@esphack}%
\def\email#1{%
   \ifx\@email\@empty
      \def\@email{#1}
   \else
      \ClassError{emisa}{There can only be one corresponding author!}{}
   \fi}%
\renewcommand{\author}{\@ifstar{\@authorstar}{\@authornostar}}
\newcommand*{\@authornostar}[1]{%
  \@bsphack
  \if@referee
    \def\@authors{}%
    \def\@shortauthors{}
  \else
      \gdef\@address@sep{}%
      \ifx\@authors\@empty
          \protected@xdef\@authors{#1}
          \protected@xappto\@shortauthors{#1}
      \else
          \protected@xappto\@authors{,\space #1}
          \protected@xappto\@shortauthors{,\space #1}
      \fi%
  \fi
  \@esphack}%
\newcommandtwoopt*{\@authorstar}[3][][]{%
    \@bsphack
    \if@referee
      \def\@authors{}%
      \def\@shortauthors{}%
      \def\@tocauthors{}%
      \def\@email{}%
    \else
      \gdef\@address@sep{}%
      \ifx\@authors\@empty
          \protected@xdef\@authors{#3\textsuperscript{*,}}
          \protected@xappto\@shortauthors{#3}
      \else
          \protected@xappto\@authors{,\space #3\textsuperscript{*,}}
          \protected@xappto\@shortauthors{,\space #3}
      \fi%
      \@ifempty{#1}{\def\@shortauthor{\@shortauthors}}{\def\@shortauthor{#1}}%
      \@ifempty{#2}{\def\@tocauthor{\@shortauthors}}{\def\@tocauthor{#2}}%
    \fi
    \@esphack
    \@ifnextchar\bgroup\email{\ClassError{emisa}{Please provide an email address for the corresponding author}{Use the second argument for the email address}}}%
\newcommand{\keywords}[1]{
   \@bsphack
   \def\and{\unskip\ \textbullet\ }%
   \def\@keywords{#1}%
   \@esphack}%
\newcommand{\authornote}[1]{
   \@bsphack
   \if@referee
      \def\@authornote{}%
   \else
      \def\@authornote{#1}%
   \fi%
   \@esphack}%
\newcommand{\editor}[1]{
   \@bsphack
   \def\@articleinfo@name{#1}%
   \@esphack}%
\newcommand{\received}[1]{
   \@bsphack
   \def\@articleinfo@rdate{#1}%
   \@esphack}%
\newcommand{\accepted}[2][]{
   \@bsphack
   \def\@articleinfo@rounds{#1}
   \def\@articleinfo@adate{#2}%
   \@esphack}%
\newcommand{\doitext}{DOI:}
\newcommand*{\outdoi}{%
  \begingroup
  \lccode`\~=`\#\relax
  \lowercase{\def~{\#}}%
  \lccode`\~=`\_\relax
  \lowercase{\def~{\_}}%
  \lccode`\~=`\<\relax
  \lowercase{\def~{\textless}}%
  \lccode`\~=`\>\relax
  \lowercase{\def~{\textgreater}}%
  \lccode`\~=0\relax
  \catcode`\#=\active
  \catcode`\_=\active
  \catcode`\<=\active
  \catcode`\>=\active
  \@outdoi
}
\def\@outdoi#1{%
  \let\#\relax
  \let\_\relax
  \let\textless\relax
  \let\textgreater\relax
  \edef\x{\toks0={{#1}}}%
  \x
  \edef\#{\@percentchar23}%
  \edef\_{_}%
  \edef\textless{\@percentchar3C}% instead of {\string<} for Apple
  \edef\textgreater{\@percentchar3E}% instead of {\string>} for Apple
  \edef\x{\toks1={\noexpand\href{http://dx.doi.org/#1}}}%
  \x
  \edef\x{\endgroup\doitext\the\toks1 \the\toks0}%
  \x
}
\newcommand*{\doi}[1]{
   \@bsphack
   \def\@doi{#1}
   \@esphack}%
\newcommand{\acknowledgements}[1]{
   \@bsphack
   \def\@acknowledgements{#1}
   \@esphack}%
\newif\if@licenseset
\newcommand{\licence}[1]{%
   \@bsphack
   \def\@licence{#1}
   \@esphack}%
\let\license\licence
\newcommand{\CCBYNCSAThree}{%
   \@licensesettrue%
   \def\doclicense@type{CC}%
   \def\doclicense@modifier@uppercase{BY-NC-SA}%
   \def\doclicense@versionUsed{3.0}%
}%
\newcommand{\CCBYNCSAFour}{%
   \@licensesettrue%
   \def\doclicense@type{CC}%
   \def\doclicense@modifier@uppercase{BY-NC-SA}%
   \def\doclicense@versionUsed{4.0}%
}%
\newcounter{addresses}
\renewcommand{\theaddresses}{\alph{addresses}}
\newcommand{\address}[2][]{%
  \@bsphack
  \if@referee
     \def\@addresses@list{}
  \else
      \@ifempty{#2}{%
          \@ifempty{#1}{}{%
               \protected@xappto\@authors{\textsuperscript{\@address@sep #1}}
               \gdef\address@sep{,}%
       }}{%
            \stepcounter{addresses}
            \protected@xappto\@authors{\textsuperscript{\@address@sep\theaddresses}}
            \gdef\@address@sep{,}%
            \ifx\@addresses@list\@empty
                \protected@xdef\@addresses@list{\textsuperscript{\theaddresses}\ #2}
            \else
                \protected@xappto\@addresses@list{\newline\textsuperscript{\theaddresses}\ #2}
            \fi}
  \fi
  \@esphack}%
\title{}%
\subtitle{}%
\author{}%
\address{}
\keywords{}%
\authornote{}%
\editor{}%
\received{}%
\accepted{}%
\doi{}%
\licence{}
\acknowledgements{}%
\def\abstract#1{\@bsphack\def\@abstract{#1}\@esphack}%
\abstract{}%
\def\@authors{}
\def\@shortauthor{}
\def\@shortauthors{}
\def\@tocauthor{}
\def\@tocauthors{}
\def\@email{}
\def\@addresses@list{}
\def\abstract#1{\@bsphack\def\@abstract{#1}\@esphack}%
\abstract{}%
\DeclareRobustCommand{\outputarticleappendix}{%
  {%
   \appendix
\@articleappendix
\global\let\@articleappendix\relax
  }%
}%
\long\def\@wrap@articleappendix#1{\gappto{\@articleappendix}{{#1}}}
\newenvironment{articleappendix}{%
  \gappto{\@articleappendix}{\clearpage}%
  \Collect@Body\@wrap@articleappendix}{}
\newenvironment{articleappendix*}{%
  \Collect@Body\@wrap@articleappendix}{}
\let\@articleappendix\relax
\def\@makefnmark{\textsu{\@thefnmark}\ }%
\renewcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent%
    \@makefnmark#1}%
\newlength{\headwidth}%
\newlength{\bleed}%
\newlength{\headmargin}%
\newlength{\footrulewidth}%
\newlength{\headfootruleheight}%
\setlength{\bleed}{3mm}%
\setlength{\headfootruleheight}{0.4mm}%
\AtBeginDocument{%
  \setlength{\headwidth}{\paperwidth+2\bleed}%
  \setlength{\headmargin}{0.5\headwidth-0.5\textwidth}%
  \setlength{\footrulewidth}{0.5\headwidth+0.5\textwidth}}%
\newcommand{\headbox}[8]{\bgroup%
  \setstretch{1}%
  \reset@font\pageheadfont
  \tabcolsep\z@
  \arrayrulewidth\headfootruleheight
  \hskip-\headmargin
  \begin{tabular*}{\headwidth}[b]%
    {@{\rule{\headmargin}{\z@}}%
    >{\rule[-1.25mm]{\z@}{5mm-\arrayrulewidth}}%
    l@{\extracolsep{\textwidth minus 1fill}}r%
    @{\rule{\headmargin}{\z@}}}
    #1 & #2\\
    \hline
    #3 & #4\\
    \hline
    #5 & #6\\
    \hline
    #7 & #8\\
  \end{tabular*}%
  \hskip-\headmargin
  \egroup
}%
\newcommand{\theheadvolume}{%
  \begingroup%
  \hypersetup{urlcolor=headtextcolor}%
  \textcolor{headtextcolor}{%
     Vol.\,\@volume, No.\,\@issue\ (\@issuedate).%
     \ifx\@doi\@empty\else\ \outdoi{\@doi}\fi}%
  \endgroup}%
\newlength{\headpageoffset}%
\setlength{\headpageoffset}{10mm}%
\def\theoddheadpage{%
  \rlap{\makebox[\headpageoffset][r]{\pagenumfont\thepage}}}%
\def\theevenheadpage{%
  \llap{\makebox[\headpageoffset][l]{\pagenumfont\thepage}}}%
\newif\if@footrule%
\def\footruleoff{\global\@footrulefalse}%
\def\footruleon{\global\@footruletrue}%
\def\footrule#1{%
  \if@footrule
    \makebox[\textwidth][#1]{%
      \reset@font
      \rule[\headfootruleheight]{\footrulewidth}{\headfootruleheight}%
      }\fi}%
\def\headmarkstyle#1{\@bsphack
  \def\@headmarkstyle{#1}%
  \@esphack}%
\headmarkstyle{\color{headtextcolor}}%
\def\markhead#1#2{\@bsphack
  \gdef\@evenmark{#1}%
  \gdef\@oddmark{#2}%
  \@esphack}%
\def\markarticle{\markhead{\@shortauthor}{\@shorttitle}}%
\def\markeditorial{\markhead{\@shorttitle}{\@shorttitle}}%
\def\ps@emisa{%
  \def\@oddhead{%
    \headbox{\@journalname}{}%
            {\theheadvolume}{}%
            {{\@headmarkstyle\@oddmark}}{\theoddheadpage}%
            {\ifx\@specialissuetitle\relax\else\textcolor{headtextcolor}{\@specialissuetitle}\fi}{}%
  }%
  \def\@evenhead{%
    \headbox{}{\@journalname}%
            {}{\theheadvolume}%
            {\theevenheadpage}{{\@headmarkstyle\@evenmark}}%
            {}{\ifx\@specialissuetitle\relax\else\textcolor{headtextcolor}{\@specialissuetitle}\fi}%
  }%
  \let\@oddmark\relax
  \let\@evenmark\relax
  \def\@oddfoot{\footrule{r}}%
  \def\@evenfoot{\footrule{l}}%
}%
\def\ps@emisaarticle{%
  \ps@emisa
  \markarticle
  \footruleoff
}%
\def\ps@emisaeditorial{%
  \ps@emisa
  \markeditorial
  \footruleon
}%
\AtEndOfClass{\pagestyle{emisa}}%
\def\basecoverfont{\normalfont\sffamily}%
\def\covervolumefont{%
  \basecoverfont\fontsize{6mm}{6mm}\selectfont}%
\def\covertitlefont{%
  \basecoverfont\bfseries\fontsize{11mm}{16.5mm}\selectfont}%
\def\coverIbgname{U1_bg}%
\def\coverIVbgname{U4_bg}%
\def\sigmobislogoname{SIG-MOBIS-logo-300}%
\def\sigEMISAlogoname{EMISA-Logo-svg}%
\def\gislogoname{GIS-logo_with_text-300}%
\newcommand{\AtPageDeadCenter}[1]{%
    \AtPageCenter{\makebox[\z@][c]{%
      \raisebox{-0.5\totalheight}[\z@][\z@]{#1}}}%
}%
\def\page@empty{\relax}%
\newcommand{\pagebg}[1]{%
  \AtPageDeadCenter{%
    \textcolor{#1}{\rule{\paperwidth+2\bleed}{\paperheight+2\bleed}}}}%
\newcommand{\thispagebackground}[2][]{%
  \@ifarg{#1}{\thispagestyle{#1}}%
  \AddToShipoutPicture*{%
    \unitlength 1mm\relax%
    {#2}%
}}%
\newcommand{\picturepage}[2][empty]{%
  \thispagebackground[#1]{#2}%
  \null\clearpage
}%
\newcommandtwoopt*{\inputpagegraphic}[3][empty][]{%
  \thispagebackground[#1]{\includegraphics[width=\paperwidth,#2]{#3}}%
  \null\clearpage
}%
\newcommand{\coverpage}[2][]{%
  \@ifarg{#1}{\setcounter{page}{#1}}%
  \picturepage{#2}%
}%
\newcommand{\thecovervolumeline}{%
  \parbox[t]{130mm}{%
    \raggedright
    \color{covertextcolor}\covervolumefont%
    Volume\space\@volume
    \enspace\rule[-1mm]{0.5mm}{6mm}\enspace
    No.\,\@issue\space\textbf{\@issuedate}\\[3mm]%
    \@specialissuetitle
  }%
}%
\def\thecovertitle{%
  \parbox[t][30mm][s]{174mm}{%
    \color{covertextcolor}%
    \covertitlefont
    \raggedright\@journalname\par
    \vskip8mm
    \covervolumefont
    \raggedleft
    \textbf{An International Electronic Journal\,}}}
\def\sigmobispage{%
  \makebox[\z@][c]{%
    \begin{minipage}[c][260mm][s]{\textwidth}
      \sigmobispagehead
      \medskip

      The GI-SIG-MoBIS portal provides numerous resources on enterprise
      modelling research, such as a full-text digital library, a
      bibliography, conference announcements, a glossary and evaluation
      reports.  It is intended to establish the premier forum for an
      international community in enterprise modelling.  The new version
      is based on a Content Management System allowing authorized users
      to conveniently upload content.  A \BibTeX{} interface allows for
      conveniently integrating bibliographic data.  Information about
      this journal, such as guidelines for authors, tables of content
      and full-text access to articles (for GI-SIG-MobIS members only)
      are also available on the~portal.
      \par
      \medskip

      \begin{center}
        \includegraphics{GI-SIG-MOBIS_portal}
      \end{center}

      \medskip

      GI encourages everybody who wants to participate in the
      evolution of this community knowledge base to contribute to any of
  the categories covered by the portal. Please contact Michael He\ss{}
  (\href{mailto:m.hess@uni-duisburg-essen.de}{m.hess@uni-duisburg-essen.de})
  for further~information.

      \vfill

      \sigmobispagefoot
    \end{minipage}%
  }%
}
\def\sigmobispagerule#1{%
\parbox[c][23mm][s]{\linewidth}{%
  \centering
  \textcolor{gray}{\rule{.92\linewidth}{1mm}}%
  \par\vfill
  \raisebox{-.4\height}[.5\totalheight][.5\totalheight]{\huge#1}%
  \par\vfill
  \textcolor{gray}{\rule{.92\linewidth}{1mm}}}\par}%
\def\sigmobispagehead{\sigmobispagerule{SIG-MoBIS Portal}}
\def\sigmobispagefoot{\sigmobispagerule{http://wi-mobis.gi-ev.de/}}
\def\coverI#1{\@ifempty{#1}%
   {\let\@coverI\relax}%
   {\def\@coverI{\coverpage[-2]{#1}}}}%
\def\coverII#1{\@ifempty{#1}%
   {\let\@coverII\relax}%
   {\def\@coverII{\coverpage[-1]{#1}}}}%
\def\coverIII#1{\@ifempty{#1}%
   {\let\@coverIII\relax}%
   {\def\@coverIII{\coverpage{#1}}}}%
\def\coverIV#1{\@ifempty{#1}%
   {\let\@coverIV\relax}%
   {\def\@coverIV{\coverpage{#1}}}}%
\coverI{%
  \pagebg{coverbgcolor}%
  \AtPageUpperLeft{%
    \raisebox{-\totalheight}{\includegraphics{\coverIbgname}}}%
  \AtPageUpperLeft{\put(17,-28){\mbox{%
    \includegraphics[height=19mm]{\sigmobislogoname}%
    \hspace{5mm}%
    \includegraphics[height=14.75mm]{\sigEMISAlogoname}%
    }}%
  }%
  \AtPageLowerLeft{\put(166,9){\includegraphics{\gislogoname}}}%
  \AtPageLowerLeft{\put(17,44){\thecovervolumeline}}%
  \AtTextLowerLeft{\put(-28,36){\framebox(200,62)[c]{}}}
  \AtPageLowerLeft{\put(17,112){\thecovertitle}}%
}%
\coverII{\page@empty}%
\coverIII{\AtPageCenter{\sigmobispage}}%
\coverIV{%
  \pagebg{coverbgcolor}%
  \AtPageLowerLeft{%
    \raisebox{167mm}{\includegraphics{\coverIVbgname}}}%
  \AtPageLowerLeft{%
    \put(6,9){\parbox[b]{10cm}{\raggedright\large\sffamily\@issn}}}%
  \AtPageLowerLeft{%
    \put(166,9){\includegraphics{GIS-logo_with_text-300}}}%
}%
\if@cover
  \AtBeginDocument{%
    \@coverI\@coverII
    \setcounter{page}{1}%
  }%
  \AtEndDocument{%
    \@coverIII\@coverIV
  }%
\fi
\graphicspath{{/figs_base/},{./figs_base/}}
\newcounter{article}%
\@addtoreset{section}{article}%
\@addtoreset{footnote}{article}%
\@addtoreset{figure}{article}%
\@addtoreset{table}{article}%
\newenvironment{article}[1]{%
  \clearpage
  \refstepcounter{article}%
  \pagestyle{emisaarticle}%
  \col@number=\tw@\relax
  #1\relax
  \l@article
  \begin{refsection}%
  \maketitle
  \ignorespaces
  }{%
  \end{refsection}%
  \outputarticleappendix\FloatBarrier\par%
  \vspace{\baselineskip}%
  \noindent\ignorespaces
  \if@licenseset
     \edef\doclicenseURL{%
        \doclicense@baseUrlCC/%
        licenses/%
        \doclicense@modifier/%
        \doclicense@versionUsed\doclicense@UrlLangPart%
     }
     \begin{minipage}{\columnwidth}
     \parbox[t]{\dimexpr 0.975\columnwidth-\doclicense@imagewidth\relax}{\vskip 0pt\raggedright\fontsize{9pt}{10.8pt}\selectfont%
        \doclicense@lang@thisDoc\space
        \href{\doclicenseURL}{\doclicenseLongType\space\enquote{\doclicense@longName}}%
        \doclicense@lang@word@license.}%
     \hfill%
     \parbox[t]{\doclicense@imagewidth}{\vskip 0pt\doclicenseImage}%
     \end{minipage}%
  \else
     \ifx\@licence\@empty\relax\else\par\noindent\@licence\fi%
  \fi%
  \onecolumn
  \ignorespacesafterend}%
\newcommandtwoopt{\edit@setup}[3][][]{%
  \title[#1][#2]{#3}
  \pagestyle{emisaeditorial}
  \def\sec@font{\sectionfont\Large}%
  \def\para@font{\sectionfont}%
  \setcounter{section}{0}%
}%
\newenvironment{editorialcontent}[1]{%
  \onecolumn
  \refstepcounter{article}%
  \edit@setup{#1}%
  \l@editorialcontent
  \raisebox{5.5mm}[10mm][0pt]{\sec@font\@title}\\
  \begin{refsection}%
  \ignorespaces
  }{%
  \end{refsection}%
  \onecolumn
  \ignorespacesafterend}%
\def\editorialname{Editorial Preface}%
\newenvironment{editorial}[1][\editorialname]{%
  \clearpage
  \edit@setup{#1}%
  \twocolumn[{\raisebox{5.5mm}[10mm][0pt]{\sec@font\@title}}]%
  \l@editorialcontent
  \begin{refsection}%
  \ignorespaces
  }{%
  \end{refsection}%
  \onecolumn
  \ignorespacesafterend}%
\def\cfpname{Call for Papers}%
\newenvironment{cfp}[1][\cfpname]%
 {\editorialcontent{#1}}%
 {\endeditorialcontent}%
\newcommandtwoopt{\imprint}[2][\@imprintname][\@imprintbody]{%
  \onecolumn
  \edit@setup[#1]{\@journalname}%
  \l@editorialcontent
  \raisebox{5.5mm}[10mm][0pt]{\sec@font\@title}\\
  \ignorespaces
  #2
  \onecolumn\ignorespacesafterend}%
\def\imprintname#1{\@bsphack\def\@imprintname{#1}\@esphack}%
\long\def\imprintbody#1{\@bsphack\def\@imprintbody{#1}\@esphack}%
\imprintname{Imprint}%
\imprintbody{%
  The journal \emph{\@journalname} is the official journal of the
  Special Interest Group on Modelling Business Information Systems
  within the German Informatics Society (GI-SIG MoBIS).

  The journal Enterprise Modelling and Information Systems
  Architectures is intended to provide a forum for those who prefer a
  design-oriented approach.  As the official journal of the German
  Informatics Society (GI-SIG-MoBIS), it is dedicated to promote the
  study and application of languages and methods for enterprise
  modelling -- bridging the gap between theoretical foundations and
  real world requirements.  The journal is not only aimed at
  researchers and students in Information Systems and Computer
  Science, but also at information systems professionals in industry,
  commerce and public administration who are interested in innovative
  and inspiring concepts.

  The journal's editorial board consists of scholars and practitioners
  who are renowned experts on various aspects of developing, analysing
  and deploying enterprise models.  Besides Information Systems, they
  cover various fields of Computer Science.

  \section*{Subscription Information}

  The journal is distributed free of charge for members of the
  GI-SIG-MoBIS. Membership can be acquired through the German
  Informatics Society (http://www.gi-ev.de/verein/mitgliedschaft/).
  Single issues, priced at EUR\,25 each (plus shipment), can be ordered
  online (http://www.fg-mobis.gi-ev.de/).}
\newsavebox{\@editorial@box}%
\newlength{\editorialboxmaxheight}%
\setlength{\editorialboxmaxheight}{\textheight+10mm}%
\newcommandtwoopt{\editorialboard}[2]%
 [\@editorialboardname][\@editorialboardbody]{%
  \clearpage
  \edit@setup[#1]{#1}%
  \l@editorialcontent
  \savebox{\@editorial@box}{%
    \vbox{\centering%
  \fboxsep=5mm
  \fcolorbox{boxframecolor}{boxbgcolor}{%
\begin{minipage}[t]{110mm}
  \raggedright
  #2
\end{minipage}}\\*
}%
  }%
  \raisebox{15mm-\totalheight}[5mm][0mm]{\makebox[\textwidth][c]{%
    \ifdim\ht\@editorial@box>\editorialboxmaxheight
  \resizebox{!}{\editorialboxmaxheight}{\usebox{\@editorial@box}}%
\else
  \usebox{\@editorial@box}%
\fi
  }}\\*
  \raisebox{-\textheight}[0mm][0mm]{\makebox[\textwidth][l]{%
  \parbox[t]{\textwidth}{\raggedleft\bfseries\@issn}%
}}%
  \onecolumn\ignorespacesafterend
}%
\def\editorialboardname#1{%
  \@bsphack\def\@editorialboardname{#1}\@esphack}%
\long\def\editorialboardbody#1{%
  \@bsphack\def\@editorialboardbody{#1}\@esphack}%
\editorialboardname{Editorial Board}%
\editorialboardbody{%
  \section*{\@title}\vskip1mm
  {\Large Editors in Chief\\[1mm]}
  Ulrich Frank, University of Duisburg-Essen\\
  Manfred Reichert, Ulm University\\[1mm]
  {\Large Associate Editors\\[1mm]}
  Wil van der Aalst, Eindhoven University of Technology\\
  Witold Abramowicz, Poznan University of Economics\\
  Colin Atkinson, University of Mannheim\\
  J\"org Becker, University of M\"unster\\
  J\"org Desel, University of Hagen\\
  Werner Esswein, Dresden University of Technology\\
  Fernand Feltz, Centre de Recherche Public Gabriel Lippmann\\
  Andreas Gadatsch, Bonn-Rhine-Sieg University of Applied Sciences\\
  Martin Glinz, University of Zurich\\
  Norbert Gronau, University of Potsdam\\
  Wilhelm Hasselbring, University of Kiel\\
  Brian Henderson-Sellers, University of Technology, Sydney\\
  Stefan Jablonski, University of Bayreuth\\
  Manfred Jeusfeld, Tilburg University\\
  Reinhard Jung, University of St.\,Gallen\\
  Dimitris Karagiannis, University of Vienna\\
  John Krogstie, University of Trondheim\\
  Thomas K\"uhne, Victoria University of Wellington\\
  Frank Leymann, University of Stuttgart\\
  Stephen W. Liddle, Brigham Young University\\
  Peter Loos, Johannes Gutenberg-University of Mainz\\
  Oscar Pastor L\'opez, Universidad Polit\`ecnica de Val\`encia\\
  Heinrich C. Mayr, University of Klagenfurt\\
  Jan Mendling, Vienna University of Economics and Business\\
  Markus N\"uttgens, University of Hamburg\\
  Andreas Oberweis, University of Karlsruhe\\
  Erich Ortner, Darmstadt University of Technology\\
  Erik Proper, Radboud University Nijmegen\\
  Michael Rebstock, University of Applied Sciences Darmstadt\\
  Stefanie Rinderle-Ma, University of Vienna\\
  Michael Rosemann, Queensland University of Technology\\
  Matti Rossi, Aalto University\\
  Elmar J. Sinz, University of Bamberg\\
  Friedrich Steimann, University of Hagen\\
  Stefan Strecker, University of Hagen\\
  Bernhard Thalheim, University of Kiel\\
  Oliver Thomas, University of Osnabr\"uck\\
  Juha-Pekka Tolvanen, University of Jyv\"askyl\"a\\
  Klaus Turowski, University of Augsburg\\
  Gottfried Vossen, University of M\"unster\\
  Mathias Weske, University of Potsdam\\
  Robert Winter, University of St.\,Gallen\\
  Heinz Z\"ullighoven, University of Hamburg}%
\newcommandtwoopt{\guidelines}[2]%
 [\@guidelinesname][\@guidelinesbody]{%
  \onecolumn
  \edit@setup{#1}%
  \l@editorialcontent
  \raisebox{5.5mm}[10mm][0pt]{\sec@font\@title}\\
  \ignorespaces
  #2
  \onecolumn\ignorespacesafterend}%
\def\guidelinesname#1{%
  \@bsphack\def\@guidelinesname{#1}\@esphack}%
\long\def\guidelinesbody#1{%
  \@bsphack\def\@guidelinesbody{#1}\@esphack}%
\guidelinesname{Guidelines for Authors}%
\guidelinesbody{%
  The journal serves to publish results of innovative research on all
  facets of creating and analysing enterprise models and information
  systems architectures.  For research papers, it is required to
  satisfy academic standards in terms of originality, level of
  abstraction and justification of results.  Experience reports serve
  to describe and analyse success stories as well as practical
  obstacles and resulting research challenges.  Topics covered by the
  journal include, but are not restricted to the following subjects:
  \begin{itemize}
    \item  Languages and Methods for Enterprise Modelling
    \item  Reusable Domain Models (Reference Models)
    \item  Analysis and Design Patterns
    \item  Modelling of Business Processes and Workflows
    \item  Process-Oriented System Architectures
    \item  Component-Oriented System Architectures
    \item  Conceptual Modelling for Component-Oriented Design
    \item  Ontologies for Enterprise Modelling
    \item  Modelling for Enterprise Application Integration
    \item  Modelling for Data Warehouses
    \item  Modelling to support Knowledge Management
    \item  Model-Driven Development
    \item  Aspect-Oriented Design
    \item  Agile Methods for Enterprise Modelling
  \end{itemize}
  Authors are asked for electronic submissions, which have to be sent
  to the editor in chief as e-mail attachment.  In case of multiple
  authors, it is required to name one author who acts as contact
  person.  The submission should include a cover page with the paper's
  title and the names, affiliations and e-mail addresses of all
  authors.  The first page of the paper starts with the title and does
  not carry the authors' names.  A manuscript must be either in MS
  Word or PDF format.  It should not exceed 5.000 words -- this
  includes an abstract of around 150 words.

  Submitted papers will be reviewed within no more than two months.
  The review process is double blind.  Authors who submit a manuscript
  guarantee that it has not been published elsewhere, nor is intended
  to be published elsewhere.  Papers that were accepted for
  publication must be written according to the style defined for the
  journal.  A comprehensive description as well as a corresponding
  Word template is provided on the web portal of the GI-SIG-MobIS
  (http://www.fg-mobis.gi-ev.de/).}
\def\maketitle{%
   \begingroup
   \let\footnoterule\relax
   \let\footnote\thanks
   \let\thefootnote\relax
   \def\@makefnmark{\textsuperscript{\@thefnmark}}%
   \ifnum\col@number=\@ne
      \@maketitle
   \else
      \twocolumn[\@maketitle]%
   \fi
   \global\@topnum\z@
   \@thanks
  \endgroup
  \setcounter{footnote}{0}%
}%
\def\@maketitle{%
  \bgroup
  \normalfont
  \pretolerance=9999
  \parskip\z@
  \parindent\z@
    \if!\@title!
    \else
    {\raggedright
        \titlefont\ignorespaces
        \strut\@title\strut\par}%
    \vskip2mm\relax
    \fi
  \if!\@subtitle!
  \vskip5mm\relax
  \else
    {\makebox[\textwidth][r]{%
      \begin{minipage}{\textwidth-15mm}
          \raggedright
          \subtitlefont\ignorespaces
          \strut\@subtitle\strut
        \end{minipage}}%
        \par}%
    \vskip5mm\relax
  \fi
  \if!\@authors!
  \else
  {\raggedright
   \authorfont\ignorespaces
   \strut\@authors
   \ifx\@email\@empty
       \ClassError{emisa}{There has to be one corresponding author!}{Please use \string\author* and provide an e-mail address}
   \else
      \ignorespaces\makebox[0pt][l]{\footnote{*~Corresponding author.\newline E-mail.\ \url{\@email}}}%
   \fi%
   \ifx\@acknowledgements\@empty
   \else
      \ignorespaces\makebox[0pt][l]{\footnote{\@acknowledgements}}%
   \fi%
   \strut\par}%
  \vskip2mm\relax
  \fi
  \if!\@addresses@list!
  \else
    {\raggedright
     \footnotesize\ignorespaces
     \strut\@addresses@list\strut\par}%
    \vskip8mm\relax
  \fi
  \if!\@authornote!
  \else
    \let\thefootnote\relax
    \ignorespaces\makebox[0pt][l]{\footnote{Note: \@authornote}}%
  \fi
  \if!\@abstract!
  \else
   {\abstractfont\ignorespaces
    \strut\textup{Abstract.\ }\@abstract\strut\par}%
    \vskip5mm\relax
  \fi
  \if!\@keywords!
    \vskip3mm\relax
  \else
   {\raggedright
    \ignorespaces
    \strut Keywords.\ \@keywords\strut\par}
    \vskip3mm\relax
  \fi
  \if!\@articleinfo@name!
    \if!\@articleinfo@rdate!
      \if!\@articleinfo@adate!
        \vskip\baselineskip\relax
      \fi
    \fi
  \else
   {\raggedright
    \small
    \ignorespaces
    \strut Communicated by\ \@articleinfo@name.%
    \if!\@articleinfo@rdate!%
    \else
       \space Received\ \@articleinfo@rdate.%
    \fi%
    \if!\@articleinfo@adate!%
    \else
       \space Accepted\ %
       \if!\@articleinfo@rounds!%
       \else%
         \ifnum\@articleinfo@rounds=1
            after \@articleinfo@rounds{} revision\space%
         \else
            after \@articleinfo@rounds{} revisions\space%
         \fi%
       \fi%
       on \@articleinfo@adate.
    \fi%
    \strut\par}
    \vskip5mm\relax
  \fi
  \egroup
}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{\noindent%
         \@hangfrom{\hskip #3\relax\@svsec}%
          \raggedright
          \interlinepenalty\@M
          \strut#8\strut
          \@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{\noindent%
        \hskip #1\relax
        \noindent%
        \parbox[t]{\linewidth}{%
          \raggedright\interlinepenalty\@M#5\strut}\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\def\@seccntformat#1{%
  \csname the#1\endcsname%
  \relax\ \ }%
\def\section{\@startsection{section}%
  {1}{\z@}%
  {-1\baselineskip plus -2mm minus -2mm}%
  {.5\baselineskip plus .25\baselineskip minus .125\baselineskip}%
  {\sec@font}}%
\def\subsection{\@startsection{subsection}%
  {2}{\z@}%
  {-3mm plus -2mm minus -1.5mm}%
  {.25\baselineskip  plus .125\baselineskip minus .125\baselineskip}%
  {\sec@font}}%
\def\subsubsection{\@startsection{subsubsection}%
  {3}{\z@}%
  {-3mm plus -2mm minus -1mm}%
  {1sp}%
  {\sec@font}}%
\def\paragraph{\@startsection{paragraph}%
  {4}{\z@}%
  {-1.5mm plus -1mm minus -0.75mm}%
  {1sp}%
  {\para@font}}%
\def\subparagraph{\@startsection{subparagraph}%
  {5}{\z@}%
  {-1.5mm}%
  {-1em}%
  {\para@font}}%
\def\tableofcontents{%
  \onecolumn
  \pagestyle{emisaeditorial}%
  \footruleon
  \title{Table of Contents}%
  \null
  \vskip10mm
  \maketitle
  \vskip15mm
  \bgroup
    \parindent\z@
    \parskip\z@
    \@starttoc{toc}%
  \egroup
  \onecolumn
  }
\newcommand*\l@article{%
  \if!\@subtitle!
    \addtocentry{\@tocauthor}{\thepage}{\@toctitle}%
  \else
    \addtocentry{\@tocauthor}{\thepage}{\@toctitle\ --\ \@tocsubtitle}%
  \fi}%
\newcommand*\l@editorialcontent{%
  \addtocentry{\@toctitle}{\thepage}{}}%
\newcommand*\addtocentry[4][toc]{%
  \addtocontents{#1}{\string\emisa@tocentry{#2}{#3}{#4}}}%
\newcommand{\emisa@tocentry}[3]{%
  \makebox[\textwidth][l]{%
    \parbox[t]{72.5mm-\@pnumwidth}{\raggedright\textbf{#1}}%
    \makebox[\@pnumwidth][r]{\textbf{#2}}%
    \hfill
    \parbox[t]{85mm}{\raggedright#3}}%
  \vspace{3mm}}%
\setcounter{tocdepth}{-2}
\newcommand*{\emisa@abbrv}[1]{#1\@\xspace}
\newcommand*{\emisaabbrv}[2]{\gdef#1{\emisa@abbrv{#2}}}
\newcommand*{\emisa@initialism}[1]{\textsc{#1}\xspace}
\newcommand*{\emisainitialism}[2]{\gdef#1{\emisa@initialism{#2}}}
\newcommand*{\ie}{\emisa@abbrv{i.\,e.}}
\newcommand*{\eg}{\emisa@abbrv{e.\,g.}}
\newcommand*{\cf}{\emisa@abbrv{cf.}}
\newcommand*{\etal}{\emisa@abbrv{et~al.}}
\newcommand*{\OMG}{\emisa@initialism{omg}}
\newcommand*{\BPM}{\emisa@initialism{bpm}}
\newcommand*{\BPMN}{\emisa@initialism{bpmn}}
\newcommand*{\UML}{\emisa@initialism{uml}}
\newcommand{\meta}[1]{{\ttfamily\small #1}} % designate a meta type (meta class)
\newcommand{\type}[1]{\textsf{#1}} % designate a type (class)
\def\@tempa#1\do\addbibresource#2\nil{%
    \ifx\relax#2\relax
    \else
    \def\@tempa##1\do\addbibresource##2\nil{\def\@preamblecmds{##1##2}}%
    \expandafter\@tempa\@preamblecmds\nil
    \fi
}
\expandafter\@tempa\@preamblecmds\do\addbibresource\nil
\AfterEndPreamble{%
   \DeclareRobustCommand{\bibliography}[1]{%
      \addbibresource{#1}}%
}%
\renewcommand{\fps@figure}{htbp}
\renewcommand{\fps@table}{htbp}
\tolerance 1414
\hbadness 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\widowpenalty=10000
\displaywidowpenalty=10000
\clubpenalty=5000
\interfootnotelinepenalty=9999
\brokenpenalty=2000
\vfuzz \hfuzz
\endinput
%%
%% End of file `emisa.cls'.
