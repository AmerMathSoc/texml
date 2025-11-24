%%
%% This is file `articleingud.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% articleingud.dtx  (with options: `cls')
%% 
%% -------------------------------------------------------------------
%%                           LICENSE
%% -------------------------------------------------------------------
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2012-2015 by Omar Salazar
%% osalazarm@correo.udistrital.edu.co
%% Laboratory for Automation and Computational Intelligence (LAMIC)
%% Engineering Department
%% Universidad Distrital Francisco Jose de Caldas
%% Bogota, Colombia
%% http://www.udistrital.edu.co/
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.2 of this license or (at your option) any later
%% version. The latest version of this license is in:
%% http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of
%% LaTeX version 1999/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Omar Salazar.
%% 
%% This work consists of the source files:
%%  - articleingud.dtx (documented LaTeX file)
%%  - articleingud.ins (installer)
%% 
%% -------------------------------------------------------------------
%%                           LICENCIA
%% -------------------------------------------------------------------
%% 
%% Este es un archivo generado.
%% 
%% Derechos de autor (C) 2012-2015 por Omar Salazar
%% osalazarm@correo.udistrital.edu.co
%% Laboratorio de Automatica e Inteligencia Computacional (LAMIC)
%% Facultad de Ingenieria
%% Universidad Distrital Francisco Jose de Caldas
%% Bogota, Colombia.
%% http://www.udistrital.edu.co/
%% 
%% Este archivo puede ser redistribuido y/o modificado
%% bajo las condiciones de la Licencia Publica del Proyecto LaTeX,
%% version 1.2 o cualquier version superior (a su opcion).
%% La ultima version de esta licencia se encuentra en
%% http://www.latex-project.org/lppl.txt
%% y la version 1.2 o superior es parte de todas las distribuciones
%% de LaTeX version 1999/12/01 o superior.
%% 
%% Este trabajo tiene el estado LPPL de `mantenido'.
%% 
%% El responsable del mantenimiento de este trabajo es Omar Salazar.
%% 
%% Este trabajo consiste de los archivos fuente:
%%  - articleingud.dtx (archivo LaTeX documentado)
%%  - articleingud.ins (instalador)
%% 
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{articleingud}%
[2015/10/10 v0.3 Article for INGENIERIA UD]%
\newif\ifINGUD@peerreview\INGUD@peerreviewfalse
\newif\ifINGUD@correspondenceauthor\INGUD@correspondenceauthorfalse
\newif\ifINGUD@endofbiography\INGUD@endofbiographytrue
\newcommand{\INGUD@internalmargin}{25mm}%
\newcommand{\INGUD@externalmargin}{25mm}%
\newcommand{\INGUD@topmargin}{25mm}%
\newcommand{\INGUD@bottommargin}{25mm}%
\newcommand{\INGUD@headmargin}{15mm}%
\newcommand{\INGUD@footmargin}{15mm}%
\newcommand{\INGUD@photosep}{5\p@}%
\newcommand{\INGUD@reviewname}{ingenier\'\i a}%
\newcommand{\INGUD@reviewvolume}{}%
\newcommand{\INGUD@reviewnumber}{}%
\newcommand{\INGUD@reviewissn}{0121-750x}%
\newcommand{\INGUD@revieweissn}{2344-8393}%
\newcommand{\INGUD@udname}{universidad distrital
                           francisco jos\'e de caldas}%
\newcommand{\INGUD@separator}{\hskip 2\p@ \@plus 0.5\p@ \@minus 0.5\p@%
                              $\scriptstyle\bullet$%
                              \hskip 2\p@ \@plus 0.5\p@ \@minus 0.5\p@}%
\newcommand{\INGUD@reviewinfo}{%
\begingroup
  \normalfont\scriptsize\scshape
  {\bfseries\INGUD@reviewname}\INGUD@separator
  \ifINGUD@peerreview
    draft, paper for peer review \INGUD@separator
  \else
    vol.\kern 1\p@   \INGUD@reviewvolume \INGUD@separator
    no.\kern 1\p@    \INGUD@reviewnumber \INGUD@separator
    issn\kern 1\p@   \INGUD@reviewissn   \INGUD@separator
    e-issn\kern 1\p@ \INGUD@revieweissn  \INGUD@separator
  \fi
  \INGUD@udname
\endgroup}%
\newcommand{\INGUD@authorinfo}{}%
\newcommand{\INGUD@paperinfo}{}%
\newcommand{\INGUD@secondtitle}{%
  \ClassError{articleingud}%
             {No \noexpand\title given}%
             {See documentation for details}}%
\newcommand{\INGUD@citeinfo}{%
  \ClassError{articleingud}%
             {No \noexpand\INGUDsetciteinfo given}%
             {See documentation for details}}%
\newcommand{\INGUD@typeofpaper}{}%
\DeclareOption{ingudpaper}{%
  \OptionNotUsed
  \ClassWarning{articleingud}%
               {Unused option `\CurrentOption'}}%
\DeclareOption{titlepage}{%
  \OptionNotUsed
  \ClassWarning{articleingud}%
               {Unused option `\CurrentOption'}}%
\DeclareOption{notitlepage}{%
  \OptionNotUsed
  \ClassWarning{articleingud}%
               {Unused option `\CurrentOption'}}%
\DeclareOption{peerreview}{%
  \global\INGUD@peerreviewtrue}%
\DeclareOption{rightcolauthor}{%
  \OptionNotUsed
  \ClassWarning{articleingud}%
               {Unused option `\CurrentOption'}}%
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}}%
\ProcessOptions\relax
\LoadClass{article}%
\setlength{\headheight}{12\p@}%
\setlength{\voffset}{\z@}%
\setlength{\headsep}{\INGUD@topmargin}%
\addtolength{\headsep}{-\INGUD@headmargin}%
\addtolength{\headsep}{-\headheight}%
\setlength{\textheight}{\paperheight}%
\addtolength{\textheight}{-\INGUD@topmargin}%
\addtolength{\textheight}{-\INGUD@bottommargin}%
\setlength{\footskip}{\INGUD@bottommargin}%
\addtolength{\footskip}{-\INGUD@footmargin}%
\setlength{\topmargin}{\INGUD@headmargin}%
\addtolength{\topmargin}{-1in}%
\addtolength{\topmargin}{-\voffset}%
\setlength{\hoffset}{\z@}%
\setlength{\oddsidemargin}{\INGUD@internalmargin}%
\addtolength{\oddsidemargin}{-1in}%
\addtolength{\oddsidemargin}{-\hoffset}%
\setlength{\evensidemargin}{\INGUD@externalmargin}%
\addtolength{\evensidemargin}{-1in}%
\addtolength{\evensidemargin}{-\hoffset}%
\setlength{\textwidth}{\paperwidth}%
\addtolength{\textwidth}{-\INGUD@internalmargin}%
\addtolength{\textwidth}{-\INGUD@externalmargin}%
\setlength{\columnsep}{5mm}%
\setlength{\columnseprule}{\z@}%
\setlength{\parskip}{\z@}%
\setlength{\parindent}{3mm}%
\newcommand{\INGUD@hangcarryover}{%
  \edef\INGUD@next{\hangafter=\the\hangafter
                   \hangindent=\the\hangindent}%
  \par\INGUD@next
  \edef\INGUD@next{\prevgraf=\the\prevgraf}%
  \indent\INGUD@next}%
\def\title{\@ifnextchar[\INGUD@titlei\INGUD@titleii}%
\def\INGUD@titlei[#1]#2#3#4{%
  \gdef\INGUD@paperinfo{#1}%
  \gdef\@title{#2}%
  \gdef\INGUD@secondtitle{#3}%
  \gdef\INGUD@typeofpaper{#4}}%
\def\INGUD@titleii#1#2#3{%
  \gdef\INGUD@paperinfo{#1}%
  \gdef\@title{#1}%
  \gdef\INGUD@secondtitle{#2}%
  \gdef\INGUD@typeofpaper{#3}}%
\def\author{\@ifnextchar[\INGUD@authori\INGUD@authorii}%
\def\INGUD@authori[#1]#2{%
  \ifINGUD@peerreview
    \global\let\INGUD@authorinfo\@empty
    \global\let\@author\@empty
  \else
    \gdef\INGUD@authorinfo{\begingroup
                             \let\thanks\INGUD@gobblethanks
                             \let\and\INGUD@separator
                             \let\\\space
                             #1\relax
                           \endgroup}%
    \gdef\@author{#2}%
  \fi}%
\def\INGUD@authorii#1{%
  \ifINGUD@peerreview
    \global\let\INGUD@authorinfo\@empty
    \global\let\@author\@empty
  \else
    \gdef\INGUD@authorinfo{\begingroup
                             \let\thanks\INGUD@gobblethanks
                             \let\and\INGUD@separator
                             \let\\\space
                             #1\relax
                           \endgroup}%
    \gdef\@author{#1}%
  \fi}%
\renewcommand{\and}{,\space}%
\def\thanks{\@ifnextchar[\INGUD@thanksi\INGUD@thanksii}%
\def\INGUD@gobblethanks{%
  \@ifnextchar[\INGUD@gobblethanksi\INGUD@gobblethanksii}%
\def\INGUD@gobblethanksi[#1]{\INGUD@gobblethanksii}%
\def\INGUD@gobblethanksii#1#2{}%
\def\INGUD@thanksi[#1]{%
  \ifINGUD@correspondenceauthor\else
    \global\INGUD@correspondenceauthortrue
    \@textsuperscript{\normalfont\footnotesize
                      \INGUD@correspondencechar ,}%
    \gdef\INGUD@correspondenceinfo{%
       \@textsuperscript{\normalfont\footnotesize
                         \INGUD@correspondencechar}#1}%
  \fi
  \INGUD@thanksii}%
\def\INGUD@thanksii#1#2{%
  \if\INGUD@instring{#1}{\INGUD@authorlabel}\else
      \ifx\INGUD@authorlabel\@empty\else
        \g@addto@macro\@thanks{,\space}%
      \fi
      \g@addto@macro\INGUD@authorlabel{#1}%
      \g@addto@macro\@thanks{%
         \@textsuperscript{\normalfont\footnotesize#1}#2}%
  \fi
  \@textsuperscript{\normalfont\footnotesize#1}}%
\def\INGUD@instring#1#2{\fi\begingroup
  \edef\x{\endgroup\noexpand\in@{#1}{#2}}\x\ifin@}%
\def\INGUD@correspondenceinfo{}%
\def\INGUD@authorlabel{}%
\def\INGUD@correspondencechar{*}%
\def\@thanks{}%
\renewenvironment{titlepage}{}{}%
\def\maketitle{%
\begingroup
  \newpage
  \global\@topnum\z@
  \thispagestyle{titlepageingud}%
  \@twocolumnfalse
  \col@number\@ne
  \noindent
  \@maketitle
  \global\let\@title\@empty
  \global\let\INGUD@secondtitle\@empty
  \global\let\INGUD@correspondenceinfo\@empty
  \global\let\INGUD@correspondencechar\@empty
  \global\let\INGUD@authorlabel\@empty
  \global\let\INGUD@typeofpaper\@empty
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\maketitle\relax
  \global\let\title\relax
  \global\let\date\relax
  \global\let\INGUDsetciteinfo\relax
  \global\let\INGUDsetvolume\relax
  \global\let\INGUDsetnumber\relax
  \global\let\INGUDsetinitialpage\relax
  \global\let\author\relax
  \global\let\and\relax
  \global\let\thanks\relax
\endgroup}%
\def\endmaketitle{%
  \@tempdima\INGUD@topmargin
  \advance\@tempdima-\INGUD@headmargin
  \enlargethispage{\@tempdima}%
  \ifINGUD@peerreview\else
    \table[!b]%
      \normalfont\scriptsize
      \INGUD@citeinfo
    \endtable
  \fi
  \global\let\INGUD@citeinfo\@empty
  \global\let\endmaketitle\relax}%
\def\@maketitle{%
  \normalfont\normalsize
  \parskip\z@
  \parindent\z@
  \raggedright
  {\bfseries\INGUD@typeofpaper\par\nobreak}%
  \vskip 0.5em \@plus 0.1em\@minus 0.1em\nobreak
  {\LARGE\bfseries\@title\par\nobreak}%
  {\Large\slshape\INGUD@secondtitle\par\nobreak}%
  \vskip 0.25em \@plus 0.1em\@minus 0.1em\nobreak
  {\large\bfseries\slshape\@author\par\nobreak}%
  \vskip 0.25em \@plus 0.1em\@minus 0.1em\nobreak
  {\footnotesize\@thanks\par\nobreak
   \vskip 0.25em \@plus 0.1em\@minus 0.1em\nobreak
   \INGUD@correspondenceinfo\par\nobreak}%
   \vskip 0.25em \@plus 0.1em\@minus 0.1em\nobreak
  {\centering\scriptsize\@date\par\nobreak}}%
\newcommand*{\INGUDsetvolume}[1]{\gdef\INGUD@reviewvolume{#1}}%
\newcommand*{\INGUDsetnumber}[1]{\gdef\INGUD@reviewnumber{#1}}%
\newcommand*{\INGUDsetinitialpage}[1]{\global\setcounter{page}{#1}}%
\newcommand*{\INGUDsetciteinfo}[1]{\gdef\INGUD@citeinfo{#1}}%
\renewenvironment{abstract}{%
  \removelastskip
  \par\nobreak
  \vfil\penalty\z@\vfilneg
  \vtop\bgroup
  \normalfont\small
  \centerline{\bfseries\abstractname}}%
  {\par\xdef\tpd{\the\prevdepth}\egroup
   \prevdepth=\tpd}%
\newenvironment{INGUDstructured}[1]{%
 \removelastskip
 \par\nobreak
 \noindent\textbf{#1:}\nobreakspace}{\par}%
\renewcommand{\thetable}{\@Roman\c@table}%
\setlength{\abovecaptionskip}{\z@}%
\setlength{\belowcaptionskip}{\z@}%
\renewcommand{\@makecaption}[2]{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{{\footnotesize\textbf{#1.} #2}}%
  \ifdim\wd\@tempboxa >\hsize
    {\footnotesize\textbf{#1.} #2 \par}%
  \else
    \global\@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}%
\def\@citex[#1]#2{%
  \let\@citea\@empty
  \@cite{\@for\@citeb:=#2\do
    {\@citea\def\@citea{], [}%
     \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
       \G@refundefinedtrue
       \@latex@warning
         {Citation `\@citeb' on page \thepage \space undefined}}%
       {\hbox{\csname b@\@citeb\endcsname}}}}{#1}}%
\def\citepunct{], [}%
\def\citedash{]--[}%
\setlength{\floatsep}{\baselineskip}%
\setlength{\textfloatsep}{\baselineskip}%
\setlength{\intextsep}{\baselineskip}%
\setlength{\dblfloatsep}{\baselineskip}%
\setlength{\dbltextfloatsep}{\baselineskip}%
\setlength{\@fptop}{\z@}%
\setlength{\@fpsep}{\baselineskip}%
\setlength{\@fpbot}{\z@ \@plus 1fil}%
\setlength{\@dblfptop}{\z@}%
\setlength{\@dblfpsep}{\baselineskip}%
\setlength{\@dblfpbot}{\z@ \@plus 1fil}%
\if@twoside
  \def\ps@plainingud{%
      \def\@oddfoot{\INGUD@reviewinfo\hfil{\bfseries\thepage}}%
      \def\@evenfoot{{\bfseries\thepage}\hfil\INGUD@reviewinfo}%
      \def\@oddhead{\vbox{\hb@xt@\textwidth{\hfil
                                            {\normalfont\footnotesize
                                             \INGUD@authorinfo}}%
                          \vskip2\p@
                          \hrule \@height0.4\p@
                                 \@width\textwidth
                                 \@depth\z@}}%
      \def\@evenhead{\vbox{\hb@xt@\textwidth{{\normalfont\footnotesize
                                              \INGUD@paperinfo}%
                                             \hfil}%
                           \vskip2\p@
                           \hrule \@height0.4\p@
                                  \@width\textwidth
                                  \@depth\z@}}%
      \let\@mkboth\markboth
    \def\sectionmark##1{}%
    \def\subsectionmark##1{}}%
\else
  \def\ps@plainingud{%
    \def\@oddfoot{\INGUD@reviewinfo\hfil{\bfseries\thepage}}%
    \def\@oddhead{\vbox{\hb@xt@\textwidth{\hfil{\normalfont\footnotesize
                                                \INGUD@authorinfo}}%
                        \vskip2\p@
                        \hrule \@height0.4\p@
                               \@width\textwidth
                               \@depth\z@}}%
    \let\@mkboth\markboth
    \def\sectionmark##1{}}%
\fi
\if@twoside
  \def\ps@titlepageingud{%
  \advance\footskip\headheight
  \advance\footskip\headsep
  \headsep\z@
  \headheight\z@
    \def\@oddfoot{\INGUD@reviewinfo\hfil{\bfseries\thepage}}%
    \def\@evenfoot{{\bfseries\thepage}\hfil\INGUD@reviewinfo}%
      \def\@oddhead{}%
      \let\@evenhead\@oddhead
      \let\@mkboth\markboth
    \def\sectionmark##1{}%
    \def\subsectionmark##1{}}%
\else
  \def\ps@titlepageingud{%
    \advance\footskip\headheight
    \advance\footskip\headsep
    \headsep\z@
    \headheight\z@
    \def\@oddfoot{\hb@xt@\textwidth{\INGUD@reviewinfo
                                    \hfil
                                    {\bfseries\thepage}}}%
    \def\@oddhead{}%
    \let\@mkboth\markboth
    \def\sectionmark##1{}}%
\fi
\let\INGUD@thebibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
  \INGUD@thebibliography{#1}%
  \itemsep\z@
  \parsep\z@
  \parskip\z@
  \footnotesize}%
\ifINGUD@peerreview
  \def\biography{%
    \let\do\@makeother
    \dospecials
    \INGUD@clearbiography}%
  \def\endbiography{}%
\begingroup
  \catcode`[=1   \catcode`]=2   \catcode`|=0
  \catcode`\{=12 \catcode`\}=12 \catcode`\\=12
  |long|gdef|INGUD@clearbiography#1\end{biography}[|end[biography]]%
|endgroup
\else
  \def\biography{%
    \removelastskip
    \addpenalty\@highpenalty
    \@ifnextchar[\INGUD@biographyphoto\INGUD@biographynophoto}%
  \def\endbiography{\par}%
  \def\INGUD@biographyphoto[#1]#2{%
    \INGUD@biographyauthorname{#2}%
    \par \nobreak \noindent
    \normalfont \footnotesize
    \global\INGUD@endofbiographyfalse
    \sbox\@tempboxa{#1}%
    \@tempdima\wd\@tempboxa
    \advance \@tempdima by \INGUD@photosep
    \@tempdimb\ht\@tempboxa
    \advance \@tempdimb by \dp\@tempboxa
    \advance \@tempdimb by \INGUD@photosep
    \divide \@tempdimb by \baselineskip
    \@tempcnta\@tempdimb
    \hangindent\@tempdima
    \hangafter-\@tempcnta
    \INGUD@checkendofbiography
    \def\INGUD@searchpar##1\par{##1\ifINGUD@endofbiography
                                     \par\null
                                   \else
                                     \INGUD@hangcarryover
                                     \csname INGUD@searchpar\endcsname
                                   \fi}%
    \INGUD@searchpar
    \hb@xt@\z@{\hss
               \vbox to\baselineskip{\box\@tempboxa
                                     \hrule \@width\z@
                                            \@height\z@
                                            \@depth\z@}%
               \hskip\INGUD@photosep}%
    \ignorespaces}%
  \newcommand{\INGUD@biographyauthorname}[1]{%
    \begingroup
    \parindent\z@ \parskip\z@
    \par \nobreak
    \sbox\@tempboxa{\normalfont\bfseries #1}%
    \ifdim\wd\@tempboxa >\hsize
      \vrule \@width\hsize
             \@height 0.4\p@
             \@depth\z@
    \else
      \vrule \@width\wd\@tempboxa
             \@height 0.4\p@
             \@depth\z@
    \fi
    \par\nobreak
    {\normalfont\bfseries #1}\par\nobreak
    \vskip 5\p@
  \endgroup}%
  \long\def\INGUD@checkendofbiography#1\end#2{%
    \def\INGUD@biographyname{biography}%
    \def\INGUD@secondargument{#2}%
    \ifx\INGUD@biographyname\INGUD@secondargument
      \global\let\INGUD@keepchecking\relax
      \long\gdef\INGUD@firstargument##1{%
        ##1\global\INGUD@endofbiographytrue\par}%
    \else
      \global\let\INGUD@keepchecking\INGUD@checkendofbiography
      \long\gdef\INGUD@firstargument##1{##1}%
    \fi
    \INGUD@firstargument{#1}%
    \global\let\INGUD@firstargument\@empty
    \end{#2}%
    \INGUD@keepchecking}%
  \def\INGUD@biographynophoto#1{%
    \INGUD@biographyauthorname{#1}%
    \par \nobreak \noindent
    \normalfont \footnotesize \ignorespaces}%
\fi
\renewcommand{\sfdefault}{phv}%
\renewcommand{\rmdefault}{ptm}%
\renewcommand{\ttdefault}{pcr}%
\pagestyle{plainingud}%
\endinput
%%
%% End of file `articleingud.cls'.
