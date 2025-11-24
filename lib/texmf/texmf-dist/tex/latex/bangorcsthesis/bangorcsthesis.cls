%%
%% This is file `bangorcsthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% bangorcsthesis.dtx  (with options: `bangorcsthesis.cls,package')
%% 
%%  bangorcsthesis.dtx
%%  Copyright 2014-15 Cameron Gray/Bangor University <c.gray@bangor.ac.uk>
%% 
%%  This work may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either version 1.3
%%  of this license of (at your option) any later version.
%%  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%%  and version 1.3 or later is part of all distributions of LaTeX
%%  version 2005/12/01 or later.
%% 
%%  This work has the LPPL maintenance status `maintained'.
%% 
%%  The Current Maintainer of this work is Cameron Gray <c.gray@bangor.ac.uk>.
%% 
%%  This work consists of the files bangorcsthesis.dtx and bangorcsthesis.ins and the derived
%%  file bangorcsthesis.cls.
%% 
%%  The Bangor University Logo has a separate licence and whilst
%%  a representation is included in this package, no further licence
%%  is granted to use, modify or include this logo without explicit
%%  written approval from the University; except for students enrolled
%%  in the University using this class to prepare their thesis.
%% 
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
\def\version{1.5.0}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{bangorcsthesis}[2016/01/20 \version C. Gray]


\def\degreeScheme#1{\def\@scheme{#1}}
\RequirePackage{fifo-stack}
\FSCreate{supervisors}{}
\def\supervisor#1{\FSPush{supervisors}{#1}}

\RequirePackage{ifthen}
\RequirePackage{xkeyval}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[T1]{fontenc} % font types and character verification
\RequirePackage[UKenglish]{babel}
\RequirePackage[UKenglish]{isodate}
\RequirePackage[utf8]{inputenc}
\RequirePackage{xparse}

\DeclareOption{bsc}{
\newcommand{\degree}{Bachelor of Science}
}
\DeclareOption{ba}{
\newcommand{\degree}{Bachelor of Arts}
}
\DeclareOption{msc}{
\newcommand{\degree}{Master of Science}
}
\DeclareOption{mscres}{
\newcommand{\degree}{Master of Science by Research}
}
\DeclareOption{mres}{
\newcommand{\degree}{Master of Research}
}
\DeclareOption{mphil}{
\newcommand{\degree}{Master of Philosophy}
}
\DeclareOption{phd}{
\newcommand{\degree}{Doctor of Philosophy}
\newcommand{\phd}{\relax}
}
\DeclareOption{pgcert}{
\newcommand{\degree}{Postgraduate Certificate}
\newcommand{\pgcert}{\relax}
}

\newboolean{@draft}
\setboolean{@draft}{false}
\DeclareOption{draft}{\setboolean{@draft}{true}}

\newboolean{@nohyphen}
\setboolean{@nohyphen}{false}
\DeclareOption{nohyphen}{\setboolean{@nohyphen}{true}}

\newboolean{@noindent}
\setboolean{@noindent}{false}
\DeclareOption{noindent}{\setboolean{@noindent}{true}}

\newboolean{@centredcaptions}
\setboolean{@centredcaptions}{true}
\DeclareOption{nocentredcaptions}{\setboolean{@centredcaptions}{false}}

\define@choicekey*{bangorcs}{figuresep}{none,colon,period,space,quad,newline,endash}[colon]{\def\bangorcs@figuresep{#1}}
\setkeys{bangorcs}{figuresep=colon}

\newboolean{@sansserif}
\setboolean{@sansserif}{true}
\DeclareOption{serif}{\setboolean{@sansserif}{false}}

\newboolean{@sansserifheadings}
\setboolean{@sansserifheadings}{true}
\DeclareOption{serifheadings}{\setboolean{@sansserifheadings}{false}}

\DeclareOption{twoside}{
\PassOptionsToClass{\CurrentOption}{report}
}

\ProcessOptions\relax

\ifx\degree\undefined
    \ClassError{bangorcsthesis}{A degree type option has not been defined; use ba,bsc,msc,mscres,mres,mphil or phd in the class options.}
\fi

\LoadClass[12pt]{report}

\if@nohyphen
    \tolerance=1
    \sloppy
    \emergencystretch=\maxdimen
    \hyphenpenalty=10000
    \hbadness=10000
\fi

\RequirePackage{parskip}
\setlength{\parskip}{1.5em}

\if@noindent
    \setlength{\parindent}{0in}
\else
    \setlength{\parindent}{15pt}
    \RequirePackage{indentfirst}
\fi

\RequirePackage[scaled]{berasans} % Font: Bera Sans, a a version of Bitstream Vera Sans slightly enhanced
\ifthenelse{\boolean{@sansserif}}%
{%
    % Using sans-serif fonts
\renewcommand*\familydefault{\sfdefault}%
\newcommand{\tgherosfont}{\fontfamily{fvs}\selectfont}
}{%
\usepackage{newtxtext,newtxmath} % font set: New TX
\newcommand{\tgherosfont}{\fontfamily{bch}\selectfont}
}
\ifthenelse{\boolean{@sansserifheadings}}%
{%
\newcommand{\tgherosfontfoot}{\fontfamily{fvs}\selectfont}
}{%
\newcommand{\tgherosfontfoot}{\fontfamily{bch}\selectfont}
}

\RequirePackage{graphicx,url,csquotes,fixltx2e,microtype,setspace,fancyhdr,enumitem,amsmath}
\RequirePackage[hidelinks,bookmarks=true,colorlinks=false]{hyperref}
\RequirePackage[nameinlink,capitalize]{cleveref}

\RequirePackage[ % page layout modifications
    %showframe,
paper=a4paper, %  - use A4 paper size
nohead, %  - no header
includefoot, %  - include footer space
includemp, %  - include side note space
bindingoffset=0.5cm, %  - binding correction
top=1.5cm, %  - total body: top margin
left=3.2cm, %  - total body: left margin (odd pages)
right=0.75cm, %  - total body: right margin (odd pages)
bottom=1.5cm, %  - total body: bottom margin
marginparwidth=1.75cm, %  - width for side note
marginparsep=10pt, %  - space between notes and body text (content)
footskip=1cm %  - footer skip size
]{geometry}

\RequirePackage{draftwatermark}
\if@draft
    \SetWatermarkText{DRAFT}
    \SetWatermarkScale{1}
\else
    \SetWatermarkText{}
\fi

\DeclareDocumentCommand{\bibliographySetup}{ O{} }{%
     \ifthenelse{\equal{#1}{compressed}}{%
         \RequirePackage[     % use biblatex for bibliography
             backend=biber, %  - use biber backend (bibtex replacement) or bibtex
             bibencoding=utf8, %  - use auto file encode
             natbib=true,     %  - allow natbib commands
             hyperref=true, %  - activate hyperref support
             backref=true, %  - activate backrefs
             urldate=long, %  - display type for dates
             style=ieee,
             citestyle=numeric,%
             sorting=nyt
        ]{biblatex}
     }{%
     \RequirePackage[     % use biblatex for bibliography
         backend=biber, %  - use biber backend (bibtex replacement) or bibtex
         bibencoding=utf8, %  - use auto file encode
         natbib=true,     %  - allow natbib commands
         hyperref=true, %  - activate hyperref support
         backref=true, %  - activate backrefs
         urldate=long, %  - display type for dates
         style=ieee,
         sorting=nyt
    ]{biblatex}
     }

    \DefineBibliographyStrings{english} {
        backrefpage  = {p.}, % for single page number
        backrefpages = {pp.},% for multiple page numbers
        bibliography = {References}
    }
}

\DeclareDocumentCommand{\references}{ O{} }{%
    \appendix
    {
        \ifthenelse{\equal{#1}{small}}{%
         \renewcommand*{\bibfont}{\footnotesize}
     \linespread{1.0}
     \setlength\itemsep{1ex}
     \setlength\bibitemsep{0.7\itemsep}
     }{}
        \pagestyle{maincontentstyle}
        \printbibliography[heading=bibnumbered]
    }
}

\setstretch{1.5} % value for line spacing, use \setstretch{} or
                                  % \singlespacing or \onehalfspacing or \doublespacing
\clubpenalty = 10000 % prevent single lines at the beginning of a paragraph
\widowpenalty = 10000 % prevent single lines at the end of a paragraph
\displaywidowpenalty = 10000 %

\definecolor{coloursgraylight}{gray}{.8}

\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{%
\markboth{%
\footnotesize%
{#1}%
}{}%
}
\renewcommand{\sectionmark}[1]{%
\markright{%
\footnotesize%
{\textbf{\thesection}}%
\quad%
{#1}%
}%
}
\fancypagestyle{plain} {
    \fancyfoot{}
    \fancyhead{}
     \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}

    \fancyfootoffset[RO]{1.75cm}
    \fancyfoot[RO]{%
        \tgherosfontfoot\footnotesize%
        \hspace*{9pt}\makebox[1.4cm][l]{\textbf{\thepage}}%
    }

     \fancyfootoffset[LE]{1.75cm}
    \fancyfoot[LE]{%
        \tgherosfontfoot\footnotesize%
        \makebox[1.4cm][l]{\textbf{\thepage}}\hspace*{9pt}
    }
}

\fancypagestyle{maincontentstyle} {
    \fancyfoot{}
    \fancyhead{}
     \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}

\fancyfootoffset[RO]{1.75cm}
    \fancyfoot[RO]{%
        \tgherosfontfoot\footnotesize%
        \leftmark\hspace*{9pt}\makebox[1.4cm][l]{\textbf{\thepage}}%
    }

     \fancyfootoffset[LE]{1.75cm}
    \fancyfoot[LE]{%
        \tgherosfontfoot\footnotesize%
        \makebox[1.4cm][l]{\textbf{\thepage}}\hspace*{9pt}\rightmark
    }
}

\ifthenelse{\boolean{@centredcaptions}}
{
\RequirePackage[ % modify figure and table captions
font={small},  %  - small font size
labelfont={bf,sf},             %  - label in bold, sans-serif and accessory colour
labelsep=\bangorcs@figuresep, %  - separator: none, colon, period, space, quad, newline, endash
singlelinecheck=true %  - no centred single-lined captions
]{caption}
}
{
\RequirePackage[ % modify figure and table captions
font={small},  %  - small font size
labelfont={bf,sf},             %  - label in bold, sans-serif and accessory colour
labelsep=\bangorcs@figuresep, %  - separator: none, colon, period, space, quad, newline, endash
singlelinecheck=false %  - no centred single-lined captions
]{caption}
}

\newcommand*{\ctSetFont}[3]{%
arg1=#1, arg2=#2, arg3=#3%
}

\newcommand{\helv}{\tgherosfontfoot\fontsize{9}{11}\selectfont}
\newcommand{\book}{\tgherosfontfoot\fontseries{m}\fontsize{11}{13}\selectfont}

\newcommand{\thesispartlabelfont}{\book\fontsize{60}{60}\selectfont}
\newcommand{\thesispartfont}{\huge \tgherosfont\selectfont}
\newcommand{\thesischapterfont}{\huge \tgherosfontfoot\selectfont}
\newcommand{\thesissectionfont}{\LARGE\bfseries \tgherosfontfoot}
\newcommand{\thesissubsectionfont}{\Large \tgherosfontfoot}
\newcommand{\thesisparagraphfont}{\tgherosfont\small\bfseries}

%% **************************************************
%% Sectioning
%% **************************************************
%%
%% -- modifications regarding sectioning (structural) commands,
%%    i.e. \part, \chapter, \section, \subsection, \subsubsection, \paragraph
%%
%%
%% The package titlesec enables us to modify (style) the sectioning commands
%% -- usage: \titlespacing{\command}{left}{before-sep}{after-sep}[right-sep]
%% -- usage: \titleformat{\command}[shape]{format}{label}{sep}{before}[after]
%% -- usage: \titleclass{\command}{class}
%%    -- classes: page (single page), top (like chapters),
%%                straight (title in the middle)
\RequirePackage{titlesec}

\titleformat{\chapter}[display]
{\raggedright\huge\thesischapterfont}{\chaptertitlename\ \thechapter}{-4mm}{\Huge}

\titlespacing*{\chapter} {0pt}{2mm}{10mm}

\RequirePackage{tocloft}
\cftsetindents{figure}{0em}{3em}
\cftsetindents{table}{0em}{3em}

\renewcommand{\cfttoctitlefont}{\thesischapterfont}
\renewcommand{\cftloftitlefont}{\thesischapterfont}
\renewcommand{\cftlottitlefont}{\thesischapterfont}

\newcommand{\hugequote}{%
{\book\fontsize{75}{80}\selectfont%
\hspace*{-.475em}\color{coloursgraylight}%
\textit{\glqq}%
\vskip -.26em}%
}
\newcommand{\chapterquote}[3]{%
\begin{minipage}{.865\textwidth}%
\begin{flushright}
\begin{minipage}{.65\textwidth}%
\begin{flushleft}
{\hugequote}\textit{#1}
\end{flushleft}
     \begin{flushright}
         \if\relax\detokenize{#2}\relax\else
     --- \textbf{#2} \\
     \fi
     #3
     \end{flushright}
    \end{minipage}%
\end{flushright}
\end{minipage}%
\bigskip
}

\RequirePackage{tikz,forloop}
\newcommand{\bangorlogo}{%
\definecolor{c231f20}{RGB}{35,31,32}
\definecolor{cb91930}{RGB}{185,25,48}
\definecolor{cf9ae0c}{RGB}{249,174,12}
\definecolor{cffffff}{RGB}{255,255,255}

\begin{tikzpicture}[y=0.80pt,x=0.80pt,yscale=-1, inner sep=0pt, outer sep=0pt]
\begin{scope}[cm={{1.25,0.0,0.0,-1.25,(0.0,672.2875)}}]
  \begin{scope}[scale=0.100]
    \path[fill=c231f20,nonzero rule] (220.1760,1227.1600) -- (305.4800,1227.1600) ..
      controls (366.6990,1227.1600) and (415.9960,1242.8100) .. (451.9730,1273.7300)
      .. controls (487.7930,1304.4500) and (505.9380,1346.6400) ..
      (505.9380,1399.0600) .. controls (505.9380,1454.2700) and (488.1640,1497.7700)
      .. (453.0860,1528.2600) .. controls (417.8120,1558.9200) and
      (367.1480,1574.4700) .. (302.5270,1574.4700) -- (220.1760,1574.4700) --
      (220.1760,1227.1600) -- cycle(220.1760,1186.9100) -- (220.1760,945.0000) ..
      controls (220.1760,891.6600) and (226.1520,854.9610) .. (238.0080,835.9300) ..
      controls (249.4410,817.5120) and (272.1480,808.1800) .. (305.4490,808.1800) --
      (377.0510,808.1800) .. controls (425.8910,808.1800) and (466.2700,824.2300) ..
      (497.0700,855.9100) .. controls (527.8710,887.6290) and (543.5160,930.8200) ..
      (543.5160,984.3320) .. controls (543.5160,1045.2100) and (521.0470,1094.6800)
      .. (476.7190,1131.4000) .. controls (432.1480,1168.2400) and
      (372.0510,1186.9100) .. (298.0660,1186.9100) -- (220.1760,1186.9100) --
      (220.1760,1186.9100) -- cycle(402.1680,767.9410) -- (0.0000,767.9410) --
      (0.0000,800.3090) -- (4.0312,800.3090) .. controls (39.3555,800.3090) and
      (64.0430,809.5120) .. (77.3945,827.6290) .. controls (91.0547,846.1720) and
      (97.9688,880.3910) .. (97.9688,929.3710) -- (97.9688,1452.5500) .. controls
      (97.9688,1502.5100) and (91.3867,1537.1000) .. (78.4570,1555.4100) .. controls
      (65.8008,1573.2800) and (40.7617,1582.3400) .. (4.0312,1582.3400) --
      (0.0000,1582.3400) -- (0.0000,1614.7000) -- (329.9410,1614.7000) .. controls
      (423.6910,1614.7000) and (498.6520,1595.5800) .. (552.6880,1557.8900) ..
      controls (607.1880,1519.8400) and (634.8050,1468.8800) .. (634.8050,1406.3800)
      .. controls (634.8050,1316.8100) and (577.9800,1252.4800) ..
      (465.8590,1215.0000) .. controls (528.5860,1201.3000) and (580.6250,1172.9600)
      .. (620.7810,1130.7400) .. controls (662.8050,1086.5200) and
      (684.1410,1034.8800) .. (684.1410,977.3590) .. controls (684.1410,914.2500)
      and (657.8980,862.9800) .. (606.1910,824.9020) .. controls (554.8240,787.1020)
      and (486.1910,767.9410) .. (402.1680,767.9410) -- (402.1680,767.9410);
    \path[fill=c231f20,nonzero rule] (1242.3600,1167.1000) -- (1474.7100,1167.1000)
      -- (1357.8800,1506.0300) -- (1242.3600,1167.1000) -- (1242.3600,1167.1000) --
      cycle(1818.8300,767.9410) -- (1506.6200,767.9410) -- (1506.6200,800.3090) --
      (1510.6600,800.3090) .. controls (1557.9600,800.3090) and (1580.9400,815.4100)
      .. (1580.9400,846.4410) .. controls (1580.9400,855.4800) and
      (1578.7900,865.8520) .. (1574.5700,877.3200) -- (1495.2400,1107.5700) --
      (1223.5800,1107.5700) -- (1165.5700,941.8520) .. controls (1151.0600,899.8790)
      and (1143.7300,869.2300) .. (1143.7300,850.7420) .. controls
      (1143.7300,817.6910) and (1164.7700,801.2110) .. (1208.0500,800.3090) --
      (1211.9900,800.2110) -- (1211.9900,767.9410) -- (980.8010,767.9410) --
      (980.8010,799.8200) -- (984.3090,800.2700) .. controls (1015.2300,804.3910)
      and (1039.5500,814.4490) .. (1056.5600,830.0510) .. controls
      (1073.6700,845.7620) and (1091.4100,879.1910) .. (1109.3200,929.4690) --
      (1348.2000,1621.2600) -- (1349.1100,1623.9800) -- (1443.7700,1623.9800) --
      (1444.6900,1621.2800) -- (1695.5300,898.6520) .. controls (1709.9400,857.0700)
      and (1725.0100,829.9610) .. (1740.2300,818.0820) .. controls
      (1755.4100,806.2620) and (1780.4900,800.3090) .. (1814.8000,800.3090) --
      (1818.8300,800.3090) -- (1818.8300,767.9410);
    \path[fill=c231f20,nonzero rule] (2901.6500,774.1410) -- (2869.2600,774.1410) --
      (2868.0500,775.5590) -- (2263.1200,1496.4000) -- (2263.1200,918.4300) ..
      controls (2263.1200,878.1990) and (2271.5100,849.1210) .. (2288.1300,832.1210)
      .. controls (2304.6800,815.1290) and (2333.0600,806.5200) ..
      (2372.5000,806.5200) -- (2376.5200,806.5200) -- (2376.5200,774.1410) --
      (2106.2900,774.1410) -- (2106.2900,806.5200) -- (2110.3200,806.5200) ..
      controls (2150.4700,806.5200) and (2177.8600,816.6210) .. (2191.7400,836.6020)
      .. controls (2205.9400,857.0820) and (2213.0900,894.0000) ..
      (2213.0900,946.3200) -- (2213.0900,1437.2600) .. controls
      (2213.0900,1488.9400) and (2203.4000,1526.4600) .. (2184.2600,1548.8000) ..
      controls (2165.1400,1570.9700) and (2132.9900,1584.3900) ..
      (2088.5900,1588.5700) -- (2084.9600,1588.9200) -- (2084.9600,1620.8900) --
      (2312.5600,1620.8900) -- (2313.7700,1619.4500) -- (2849.4100,975.2110) --
      (2849.4100,1454.5700) .. controls (2849.4100,1504.9000) and
      (2842.1200,1540.3100) .. (2827.7300,1559.7800) .. controls
      (2813.5800,1578.8600) and (2786.8000,1588.5500) .. (2748.1100,1588.5500) --
      (2744.0600,1588.5500) -- (2744.0600,1620.8900) -- (3012.8500,1620.8900) --
      (3012.8500,1588.5500) -- (3008.8100,1588.5500) .. controls
      (2968.5200,1588.5500) and (2940.3000,1579.4100) .. (2924.9800,1561.3400) ..
      controls (2909.4900,1543.1600) and (2901.6500,1509.1200) ..
      (2901.6500,1460.2900) -- (2901.6500,774.1410);
    \path[fill=c231f20,nonzero rule] (3863.7500,747.1990) .. controls
      (3703.9600,747.1990) and (3577.5800,786.0120) .. (3488.1300,862.5510) ..
      controls (3398.5000,939.2700) and (3353.0500,1041.8300) ..
      (3353.0500,1167.3800) .. controls (3353.0500,1254.9000) and
      (3372.9300,1334.9600) .. (3412.1300,1405.2700) .. controls
      (3451.3100,1475.6400) and (3506.8400,1532.2000) .. (3577.0900,1573.3900) ..
      controls (3647.3200,1614.5500) and (3722.9900,1635.4100) ..
      (3801.9100,1635.4100) .. controls (3849.1800,1635.4100) and
      (3901.3300,1627.1600) .. (3956.9500,1610.9300) .. controls
      (3991.7800,1601.0900) and (4018.6700,1596.1100) .. (4036.8200,1596.1100) ..
      controls (4059.8000,1596.1100) and (4074.4900,1604.4100) ..
      (4081.7400,1621.5600) -- (4082.7900,1624.0000) -- (4116.7200,1624.0000) --
      (4116.7200,1368.5300) -- (4084.9000,1368.5300) -- (4084.3900,1371.9700) ..
      controls (4074.7700,1439.2500) and (4042.9500,1493.8000) ..
      (3989.8200,1534.1600) .. controls (3936.5200,1574.6800) and
      (3873.3200,1595.2100) .. (3801.9100,1595.2100) .. controls
      (3712.2500,1595.2100) and (3637.7100,1559.9800) .. (3580.3700,1490.4800) ..
      controls (3522.8300,1420.7600) and (3493.6700,1329.3500) ..
      (3493.6700,1218.8400) .. controls (3493.6700,1097.3800) and
      (3527.4200,995.2890) .. (3593.9800,915.4220) .. controls (3660.3700,835.7190)
      and (3744.9600,795.3090) .. (3845.3500,795.3090) .. controls
      (3940.2700,795.3090) and (3986.3900,823.2810) .. (3986.3900,880.8320) --
      (3986.3900,971.8710) .. controls (3986.3900,1022.3600) and
      (3979.5900,1058.0000) .. (3966.1100,1077.7900) .. controls
      (3952.9900,1097.0800) and (3929.2000,1106.8500) .. (3895.4300,1106.8500) --
      (3858.2600,1106.8500) -- (3858.2600,1139.2300) -- (4216.1300,1139.2300) --
      (4216.1300,1106.8500) -- (4212.1100,1106.8500) .. controls
      (4175.1400,1106.8500) and (4148.4600,1098.7100) .. (4132.8900,1082.6500) ..
      controls (4117.2700,1066.5600) and (4109.3600,1037.9600) ..
      (4109.3600,997.6910) -- (4109.3600,768.8790) -- (4106.3300,768.1210) ..
      controls (4086.0000,762.8320) and (4047.7100,757.9800) .. (3992.5800,753.6720)
      .. controls (3937.5000,749.3910) and (3894.1600,747.1990) ..
      (3863.7500,747.1990) -- (3863.7500,747.1990);
    \path[fill=c231f20,nonzero rule] (5040.9800,1595.1900) .. controls
      (4941.5800,1595.1900) and (4860.9800,1558.4300) .. (4801.4300,1485.8500) ..
      controls (4741.6600,1413.0400) and (4711.4100,1314.8000) ..
      (4711.4100,1193.8000) .. controls (4711.4100,1072.8100) and
      (4741.3100,973.6910) .. (4800.3700,899.2300) .. controls (4859.1600,825.0310)
      and (4937.4000,787.4220) .. (5032.8700,787.4220) .. controls
      (5129.3200,787.4220) and (5208.6500,825.8710) .. (5268.6900,901.7300) ..
      controls (5328.9600,977.8520) and (5359.5100,1074.1900) ..
      (5359.5100,1188.0800) .. controls (5359.5100,1310.4800) and
      (5329.5700,1410.0900) .. (5270.5300,1484.1200) .. controls
      (5211.7400,1557.8500) and (5134.5300,1595.1900) .. (5040.9800,1595.1900) --
      (5040.9800,1595.1900) -- cycle(5034.3600,747.1990) .. controls
      (4905.2100,747.1990) and (4794.5100,790.8910) .. (4705.3100,877.0510) ..
      controls (4616.0400,963.2420) and (4570.7600,1070.2900) ..
      (4570.7600,1195.2300) .. controls (4570.7600,1320.2100) and
      (4615.8000,1425.9500) .. (4704.6100,1509.5800) .. controls
      (4793.3600,1593.0800) and (4905.5300,1635.4400) .. (5038.0100,1635.4400) ..
      controls (5166.6000,1635.4400) and (5276.9300,1592.4600) ..
      (5365.9600,1507.7500) .. controls (5454.9800,1423.0000) and
      (5500.1400,1317.8500) .. (5500.1400,1195.2300) .. controls
      (5500.1400,1070.2900) and (5454.6300,963.2420) .. (5364.8400,877.0120) ..
      controls (5275.1600,790.8910) and (5163.9800,747.1990) .. (5034.3600,747.1990)
      -- (5034.3600,747.1990);
    \path[fill=c231f20,nonzero rule] (6057.1700,1199.2500) -- (6159.2000,1199.2500)
      .. controls (6221.1500,1199.2500) and (6270.3500,1216.6700) ..
      (6305.5300,1251.0300) .. controls (6340.6100,1285.3300) and
      (6358.4200,1331.5200) .. (6358.4200,1388.3200) .. controls
      (6358.4200,1443.5300) and (6338.7100,1488.8200) .. (6299.7700,1522.9200) ..
      controls (6260.7000,1557.1200) and (6208.2000,1574.4700) ..
      (6143.7100,1574.4700) -- (6057.1700,1574.4700) -- (6057.1700,1199.2500) --
      cycle(6668.4200,767.9410) -- (6485.7800,767.9410) -- (6484.5900,769.3520) ..
      controls (6448.4000,811.6600) and (6403.9300,874.7190) .. (6352.4000,956.7500)
      .. controls (6297.9700,1042.3200) and (6254.8000,1097.6900) ..
      (6224.1200,1121.1900) .. controls (6193.8100,1144.4100) and
      (6159.8000,1156.1700) .. (6123.0900,1156.1700) -- (6057.1700,1156.1700) --
      (6057.1700,929.5120) .. controls (6057.1700,880.9690) and (6064.1800,846.8090)
      .. (6078.0900,828.0000) .. controls (6091.7000,809.6410) and
      (6116.5400,800.3090) .. (6151.8200,800.3090) -- (6155.8600,800.3090) --
      (6155.8600,767.9410) -- (5836.9900,767.9410) -- (5836.9900,800.3090) --
      (5841.0200,800.3090) .. controls (5877.7100,800.3090) and (5902.7700,809.5700)
      .. (5915.4100,827.9100) .. controls (5928.3800,846.7300) and
      (5934.9600,880.8520) .. (5934.9600,929.3710) -- (5934.9600,1455.3900) ..
      controls (5934.9600,1503.9000) and (5928.5200,1537.6700) ..
      (5915.7800,1555.7800) .. controls (5903.3600,1573.4100) and
      (5878.2200,1582.3400) .. (5841.0200,1582.3400) -- (5836.9900,1582.3400) --
      (5836.9900,1614.7000) -- (6195.2500,1614.7000) .. controls
      (6283.1300,1614.7000) and (6354.4500,1593.6100) .. (6407.2900,1551.9700) ..
      controls (6460.3300,1510.1300) and (6487.2300,1456.0300) ..
      (6487.2300,1391.1900) .. controls (6487.2300,1289.1200) and
      (6429.1400,1219.4300) .. (6314.4900,1183.8800) .. controls
      (6338.3400,1167.9600) and (6361.8400,1146.8500) .. (6384.4300,1121.0500) ..
      controls (6409.3600,1092.6300) and (6442.3400,1044.9000) ..
      (6482.6200,979.1210) .. controls (6527.3400,906.7890) and (6562.7500,858.7500)
      .. (6587.8100,836.2620) .. controls (6612.4400,814.2110) and
      (6638.3000,802.1210) .. (6664.6500,800.2700) -- (6668.4200,800.0120) --
      (6668.4200,767.9410);
    \path[fill=c231f20,nonzero rule] (1239.5500,0.0000) .. controls
      (1200.1800,0.0000) and (1168.7200,11.6211) .. (1146.0300,34.5703) .. controls
      (1123.3700,57.5117) and (1111.8800,88.1211) .. (1111.8800,125.5620) --
      (1111.8800,300.2890) .. controls (1111.8800,320.6990) and (1109.2000,334.9610)
      .. (1103.8700,342.6720) .. controls (1098.8300,349.9800) and
      (1088.6500,353.6910) .. (1073.6100,353.6910) -- (1070.4000,353.6910) --
      (1070.4000,370.4100) -- (1209.0700,370.4100) -- (1209.0700,353.6910) --
      (1205.8500,353.6910) .. controls (1190.5900,353.6910) and (1180.2400,350.0900)
      .. (1175.0900,342.9220) .. controls (1169.7200,335.4610) and
      (1166.9700,321.3200) .. (1166.9700,300.8910) -- (1166.9700,121.0120) ..
      controls (1166.9700,92.9609) and (1174.9400,70.6406) .. (1190.6900,54.6797) ..
      controls (1206.4000,38.7109) and (1228.7000,30.6406) .. (1257.0200,30.6406) ..
      controls (1298.8300,30.6406) and (1332.8800,49.7617) .. (1358.2800,87.4609) --
      (1358.2800,300.2890) .. controls (1358.2800,320.2890) and (1355.5900,334.3090)
      .. (1350.3000,341.8910) .. controls (1345.2000,349.1600) and
      (1335.8000,353.1410) .. (1322.3500,353.6910) -- (1319.2900,353.8200) --
      (1319.2900,370.4100) -- (1454.8400,370.4100) -- (1454.8400,353.6910) --
      (1451.6400,353.6910) .. controls (1437.2200,353.6910) and (1427.1900,349.9610)
      .. (1421.8200,342.5900) .. controls (1416.2200,334.9220) and
      (1413.3700,320.6800) .. (1413.3700,300.2500) -- (1413.3700,78.6719) ..
      controls (1413.3700,58.6289) and (1416.1700,44.5117) .. (1421.6700,36.6914) ..
      controls (1426.9100,29.2891) and (1437.0100,25.5195) .. (1451.6400,25.5195) --
      (1454.8400,25.5195) -- (1454.8400,8.8008) -- (1358.2800,8.8008) --
      (1358.2800,53.3711) .. controls (1324.6600,17.9414) and (1284.7500,0.0000) ..
      (1239.5500,0.0000) -- (1239.5500,0.0000);
    \path[fill=c231f20,nonzero rule] (1977.5500,8.7812) -- (1961.6200,8.7812) --
      (1960.6700,9.9414) -- (1707.1300,312.0700) -- (1707.1300,71.4023) .. controls
      (1707.1300,54.7812) and (1710.5700,42.8086) .. (1717.2900,35.8906) .. controls
      (1724.0100,29.0000) and (1735.6600,25.5000) .. (1751.9600,25.5000) --
      (1755.1700,25.5000) -- (1755.1700,8.7812) -- (1637.7100,8.7812) --
      (1637.7100,25.5000) -- (1640.9400,25.5000) .. controls (1657.4000,25.5000) and
      (1668.5800,29.5820) .. (1674.1600,37.6094) .. controls (1679.9700,46.0312) and
      (1682.9300,61.3594) .. (1682.9300,83.2188) -- (1682.9300,291.1520) .. controls
      (1682.9300,312.6720) and (1678.9500,328.2190) .. (1671.0800,337.3790) ..
      controls (1663.2300,346.4800) and (1649.9500,351.9690) .. (1631.5600,353.6910)
      -- (1628.6400,353.9800) -- (1628.6400,370.4100) -- (1727.2900,370.4100) --
      (1728.2600,369.2500) -- (1952.4200,99.6406) -- (1952.4200,298.4690) ..
      controls (1952.4200,319.4690) and (1949.4400,334.1410) .. (1943.5500,342.1020)
      .. controls (1937.8900,349.8200) and (1926.9400,353.6910) ..
      (1911.0400,353.6910) -- (1907.8100,353.6910) -- (1907.8100,370.4100) --
      (2024.6600,370.4100) -- (2024.6600,353.6910) -- (2021.4600,353.6910) ..
      controls (2004.8400,353.6910) and (1993.2900,350.0120) .. (1987.1000,342.7110)
      .. controls (1980.7500,335.3090) and (1977.5500,321.2110) ..
      (1977.5500,300.8910) -- (1977.5500,8.7812);
    \path[fill=c231f20,nonzero rule] (2341.4800,8.7812) -- (2203.4300,8.7812) --
      (2203.4300,25.5000) -- (2206.6400,25.5000) .. controls (2221.5100,25.5000) and
      (2231.6500,29.1211) .. (2236.8100,36.2617) .. controls (2242.1700,43.7305) and
      (2244.9300,58.0000) .. (2244.9300,78.6719) -- (2244.9300,300.2110) .. controls
      (2244.9300,321.2500) and (2242.2300,335.6600) .. (2236.9400,343.0390) ..
      controls (2231.8900,350.1290) and (2221.6900,353.6910) .. (2206.6400,353.6910)
      -- (2203.4300,353.6910) -- (2203.4300,370.4100) -- (2341.4800,370.4100) --
      (2341.4800,353.6910) -- (2338.2700,353.6910) .. controls (2323.8600,353.6910)
      and (2313.8400,349.9610) .. (2308.4600,342.5900) .. controls
      (2302.8700,334.9410) and (2300.0200,320.6990) .. (2300.0200,300.2110) --
      (2300.0200,78.6719) .. controls (2300.0200,58.2188) and (2302.8700,44.0195) ..
      (2308.4400,36.5000) .. controls (2313.8100,29.1914) and (2323.8200,25.5000) ..
      (2338.2700,25.5000) -- (2341.4800,25.5000) -- (2341.4800,8.7812);
    \path[fill=c231f20,nonzero rule] (2711.8500,3.9414) -- (2697.0700,3.9414) --
      (2696.2800,5.9922) -- (2582.9800,294.2700) .. controls (2572.5700,320.3520)
      and (2563.6100,336.8910) .. (2556.3400,343.4690) .. controls
      (2549.2800,349.8590) and (2538.8300,353.3200) .. (2525.3000,353.6910) --
      (2522.1900,353.7810) -- (2522.1900,370.4100) -- (2661.4800,370.4100) --
      (2661.4800,353.6910) -- (2658.2800,353.6910) .. controls (2632.4700,353.6910)
      and (2629.4700,341.8710) .. (2629.4700,332.9800) .. controls
      (2629.4700,328.1410) and (2630.7600,322.5510) .. (2633.3000,316.3200) --
      (2719.8600,94.7617) -- (2801.8700,308.3520) .. controls (2805.2100,317.4220)
      and (2806.9400,325.3320) .. (2806.9400,331.7500) .. controls
      (2806.9400,341.1910) and (2803.8800,353.6910) .. (2777.4100,353.6910) --
      (2774.2000,353.6910) -- (2774.2000,370.4100) -- (2887.3000,370.4100) --
      (2887.3000,353.0820) -- (2884.0900,353.0820) .. controls (2858.8300,353.0820)
      and (2837.4700,330.5590) .. (2820.6200,286.1290) -- (2712.6200,5.9922) --
      (2711.8500,3.9414) -- (2711.8500,3.9414);
    \path[fill=c231f20,nonzero rule] (3298.9200,8.7812) -- (3029.6400,8.7812) --
      (3029.6400,25.5000) -- (3032.8500,25.5000) .. controls (3048.0900,25.5000) and
      (3058.2900,29.1719) .. (3063.2500,36.4023) .. controls (3068.4600,43.9805) and
      (3071.1000,58.0195) .. (3071.1000,78.0625) -- (3071.1000,300.2110) .. controls
      (3071.1000,321.0310) and (3068.3800,335.4100) .. (3063.0100,342.9100) ..
      controls (3057.8300,350.0510) and (3047.6900,353.6910) .. (3032.8500,353.6910)
      -- (3029.6400,353.6910) -- (3029.6400,370.4100) -- (3299.6200,370.4100) --
      (3299.6200,304.6410) -- (3286.9600,304.6410) -- (3286.4100,307.1410) ..
      controls (3282.8400,323.3200) and (3277.8200,334.0390) .. (3271.4700,339.1020)
      .. controls (3265.1300,344.1600) and (3250.5400,346.7300) ..
      (3228.0900,346.7300) -- (3125.8900,346.7300) -- (3125.8900,201.1720) --
      (3224.9800,201.1720) .. controls (3238.0100,201.1720) and (3246.8600,203.3200)
      .. (3251.3100,207.5510) .. controls (3255.8700,211.8520) and
      (3259.2700,220.5200) .. (3261.4300,233.2810) -- (3261.8700,235.9490) --
      (3278.7200,235.9490) -- (3278.7200,143.2420) -- (3262.1100,143.2420) --
      (3261.4800,145.6410) .. controls (3256.8700,163.4490) and (3251.8500,169.9610)
      .. (3248.4400,172.2620) .. controls (3244.9400,174.6210) and
      (3236.0200,177.4800) .. (3213.4500,177.4800) -- (3125.8900,177.4800) --
      (3125.8900,53.4688) .. controls (3125.8900,45.6016) and (3127.5900,40.0898) ..
      (3130.9200,37.0703) .. controls (3134.3500,34.0000) and (3140.6100,32.4609) ..
      (3149.4900,32.4609) -- (3213.4500,32.4609) .. controls (3235.9100,32.4609) and
      (3251.5800,33.6484) .. (3259.9900,35.9688) .. controls (3268.1100,38.2188) and
      (3275.0300,42.4609) .. (3280.6400,48.5312) .. controls (3286.4400,54.8594) and
      (3292.7500,65.3086) .. (3299.4200,79.6602) -- (3300.3000,81.5195) --
      (3317.3700,81.5195) -- (3316.3500,77.5000) -- (3299.5200,11.1914) --
      (3298.9200,8.7813) -- (3298.9200,8.7813);
    \path[fill=c231f20,nonzero rule] (3608.0000,194.5120) -- (3649.7400,194.5120) ..
      controls (3675.6000,194.5120) and (3696.0600,201.7110) .. (3710.6200,215.9690)
      .. controls (3725.1900,230.1910) and (3732.5900,249.3910) ..
      (3732.5900,273.0200) .. controls (3732.5900,295.9920) and (3724.3800,314.8200)
      .. (3708.2500,328.8590) .. controls (3692.0000,343.1600) and
      (3670.1300,350.3710) .. (3643.1700,350.3710) -- (3608.0000,350.3710) --
      (3608.0000,194.5120) -- cycle(3866.9000,8.7812) -- (3787.3500,8.7812) --
      (3786.4000,9.9219) .. controls (3770.9300,27.9805) and (3752.0600,54.7188) ..
      (3730.2600,89.4688) .. controls (3707.3100,125.5820) and (3689.1300,148.9020)
      .. (3676.3200,158.7300) .. controls (3663.7800,168.3200) and
      (3649.6600,173.2190) .. (3634.4400,173.2190) -- (3608.0000,173.2190) --
      (3608.0000,78.7109) .. controls (3608.0000,58.5117) and (3610.9100,44.3711) ..
      (3616.5900,36.6016) .. controls (3622.0600,29.2500) and (3632.1600,25.5000) ..
      (3646.5900,25.5000) -- (3649.8100,25.5000) -- (3649.8100,8.7813) --
      (3511.7900,8.7813) -- (3511.7900,25.5000) -- (3514.9900,25.5000) .. controls
      (3529.9900,25.5000) and (3540.1900,29.2109) .. (3545.2400,36.5391) .. controls
      (3550.5400,44.2305) and (3553.2500,58.4102) .. (3553.2500,78.6719) --
      (3553.2500,301.4220) .. controls (3553.2500,321.6910) and (3550.6000,335.6990)
      .. (3545.4200,343.0820) .. controls (3540.4600,350.1290) and
      (3530.2100,353.6910) .. (3514.9900,353.6910) -- (3511.7900,353.6910) --
      (3511.7900,370.4100) -- (3665.0100,370.4100) .. controls (3702.5900,370.4100)
      and (3733.1200,361.3590) .. (3755.7300,343.5310) .. controls
      (3778.6000,325.5000) and (3790.1700,302.1800) .. (3790.1700,274.2300) ..
      controls (3790.1700,231.1910) and (3766.2200,201.5200) .. (3718.9200,185.9490)
      .. controls (3728.2300,179.3710) and (3737.3700,170.9690) ..
      (3746.2600,160.8520) .. controls (3756.9200,148.6720) and (3770.9700,128.3520)
      .. (3787.9800,100.5000) .. controls (3806.8800,70.0000) and
      (3821.7700,49.7617) .. (3832.2600,40.3320) .. controls (3842.4100,31.2617) and
      (3853.0800,26.2812) .. (3863.9200,25.5000) -- (3866.9000,25.2695) --
      (3866.9000,8.7812);
    \path[fill=c231f20,nonzero rule] (4134.2500,0.0000) .. controls
      (4117.3700,0.0000) and (4095.6500,4.5508) .. (4069.6800,13.4922) .. controls
      (4056.9200,17.8516) and (4052.2000,18.7617) .. (4050.4800,18.7617) .. controls
      (4048.8000,18.7617) and (4043.6800,18.7617) .. (4039.4600,7.2617) --
      (4038.6800,5.1523) -- (4022.3300,5.1523) -- (4022.3300,107.5510) --
      (4039.6200,107.5510) -- (4039.6400,104.3710) .. controls (4039.8700,78.9805)
      and (4048.4900,58.3711) .. (4065.2400,43.1602) .. controls (4082.0600,27.8320)
      and (4102.0000,20.0703) .. (4124.5800,20.0703) .. controls (4145.9100,20.0703)
      and (4163.1300,25.6016) .. (4175.8300,36.5586) .. controls (4188.4300,47.3789)
      and (4194.8100,62.0508) .. (4194.8100,80.1719) .. controls (4194.8100,93.6914)
      and (4189.5000,106.8520) .. (4179.0500,119.3320) .. controls
      (4168.3300,132.1210) and (4145.4000,148.9800) .. (4110.9300,169.4300) ..
      controls (4082.3100,186.5590) and (4062.8800,200.3520) .. (4053.1300,210.4220)
      .. controls (4043.3100,220.6020) and (4035.9500,231.9690) ..
      (4031.2600,244.0820) .. controls (4026.5700,256.2300) and (4024.2100,269.7420)
      .. (4024.2100,284.1720) .. controls (4024.2100,312.2620) and
      (4033.8400,335.4100) .. (4052.8400,352.8910) .. controls (4071.7900,370.3710)
      and (4096.7100,379.2110) .. (4126.9200,379.2110) .. controls
      (4143.3900,379.2110) and (4161.5900,376.0120) .. (4180.9500,369.6410) ..
      controls (4191.6100,366.2810) and (4196.4700,365.5590) .. (4198.6600,365.5590)
      .. controls (4201.5100,365.5590) and (4202.1200,366.2620) ..
      (4202.1200,366.2620) .. controls (4202.4100,366.6020) and (4203.3900,367.9800)
      .. (4204.9100,373.2620) -- (4205.6000,375.5590) -- (4221.4900,375.5590) --
      (4221.4900,285.8520) -- (4204.4600,285.8520) -- (4204.1900,288.7300) ..
      controls (4201.8100,310.8010) and (4193.5100,328.2620) .. (4179.5400,340.5820)
      .. controls (4165.5400,352.8910) and (4147.6300,359.1410) ..
      (4126.3000,359.1410) .. controls (4107.3700,359.1410) and (4091.9800,354.5120)
      .. (4080.5600,345.3320) .. controls (4069.2100,336.1720) and
      (4063.6800,324.3090) .. (4063.6800,309.0590) .. controls (4063.6800,294.9220)
      and (4068.4700,281.8710) .. (4077.9400,270.2110) .. controls
      (4087.6100,258.2620) and (4109.1700,242.5000) .. (4141.9600,223.4100) ..
      controls (4180.7900,200.9100) and (4207.3100,180.9100) .. (4220.8300,163.9020)
      .. controls (4234.5200,146.6410) and (4241.4700,126.5820) ..
      (4241.4700,104.3520) .. controls (4241.4700,75.6992) and (4230.8700,50.8906)
      .. (4209.9700,30.5625) .. controls (4189.0900,10.2891) and (4163.6400,0.0000)
      .. (4134.2500,0.0000) -- (4134.2500,0.0000);
    \path[fill=c231f20,nonzero rule] (4577.2800,8.7812) -- (4439.2100,8.7812) --
      (4439.2100,25.5000) -- (4442.4300,25.5000) .. controls (4457.2600,25.5000) and
      (4467.4100,29.1211) .. (4472.5900,36.2617) .. controls (4477.9600,43.7617) and
      (4480.7100,58.0391) .. (4480.7100,78.6719) -- (4480.7100,300.2110) .. controls
      (4480.7100,321.2500) and (4478.0200,335.6600) .. (4472.7200,343.0390) ..
      controls (4467.6700,350.1290) and (4457.4700,353.6910) .. (4442.4300,353.6910)
      -- (4439.2100,353.6910) -- (4439.2100,370.4100) -- (4577.2800,370.4100) --
      (4577.2800,353.6910) -- (4574.0500,353.6910) .. controls (4559.6400,353.6910)
      and (4549.6000,349.9610) .. (4544.2300,342.5900) .. controls
      (4538.6200,334.9220) and (4535.7700,320.6800) .. (4535.7700,300.2110) --
      (4535.7700,78.6719) .. controls (4535.7700,58.2617) and (4538.6200,44.0820) ..
      (4544.1900,36.4609) .. controls (4549.5800,29.1914) and (4559.6000,25.5000) ..
      (4574.0500,25.5000) -- (4577.2800,25.5000) -- (4577.2800,8.7812);
    \path[fill=c231f20,nonzero rule] (4993.5800,8.7812) -- (4857.7400,8.7812) --
      (4857.7400,25.5000) -- (4860.9500,25.5000) .. controls (4875.8100,25.5000) and
      (4885.9500,29.3516) .. (4891.0800,36.9922) .. controls (4896.4700,44.9805) and
      (4899.2100,59.0195) .. (4899.2100,78.6719) -- (4899.2100,346.7300) --
      (4849.3800,346.7300) .. controls (4824.8300,346.7300) and (4806.8100,342.9410)
      .. (4795.8500,335.4800) .. controls (4785.1900,328.1990) and
      (4779.1100,315.8520) .. (4777.7600,298.8200) -- (4777.5300,295.8710) --
      (4760.4200,295.8710) -- (4760.4200,383.7300) -- (4775.7900,383.7300) --
      (4776.7100,382.9220) .. controls (4785.8300,374.6210) and (4803.5600,370.4100)
      .. (4829.4200,370.4100) -- (5021.2600,370.4100) .. controls
      (5048.0400,370.4100) and (5066.8800,374.6600) .. (5077.2400,383.0390) --
      (5078.1200,383.7300) -- (5094.0100,383.7300) -- (5094.0100,295.8710) --
      (5081.0800,295.8710) -- (5080.5000,298.3520) .. controls (5076.1400,316.9490)
      and (5068.4100,329.7620) .. (5057.4900,336.4410) .. controls
      (5046.3000,343.2620) and (5029.0700,346.7300) .. (5006.2800,346.7300) --
      (4953.9900,346.7300) -- (4953.9900,76.8516) .. controls (4953.9900,56.1914)
      and (4956.5300,42.2617) .. (4961.4900,35.4102) .. controls (4966.2000,28.8203)
      and (4975.9500,25.5000) .. (4990.3800,25.5000) -- (4993.5800,25.5000) --
      (4993.5800,8.7813);
    \path[fill=c231f20,nonzero rule] (5497.5900,8.7812) -- (5357.6700,8.7812) --
      (5357.6700,25.5000) -- (5360.8700,25.5000) .. controls (5377.7600,25.5000) and
      (5389.0100,29.3320) .. (5394.2900,36.8711) .. controls (5399.7800,44.7812) and
      (5402.5700,58.8789) .. (5402.5700,78.7109) -- (5402.5700,189.6990) --
      (5325.1300,306.6720) .. controls (5312.5100,325.8710) and (5302.1600,338.5310)
      .. (5294.3700,344.3320) .. controls (5286.8300,349.9800) and
      (5276.1000,353.1210) .. (5262.4700,353.6910) -- (5259.4200,353.8200) --
      (5259.4200,370.4100) -- (5408.9900,370.4100) -- (5408.9900,353.6910) --
      (5405.7900,353.6910) .. controls (5382.9000,353.6910) and (5371.2800,349.1910)
      .. (5371.2800,340.2500) .. controls (5371.2800,335.8910) and
      (5373.6000,330.1720) .. (5378.2300,323.3010) -- (5447.8400,219.6990) --
      (5503.1000,304.8200) .. controls (5511.2400,317.5120) and (5515.3800,328.4100)
      .. (5515.3800,337.2190) .. controls (5515.3800,344.3090) and
      (5513.1900,353.6910) .. (5494.3700,353.6910) -- (5491.1600,353.6910) --
      (5491.1600,370.4100) -- (5598.0200,370.4100) -- (5598.0200,353.8790) --
      (5594.9900,353.6910) .. controls (5582.1000,352.9610) and (5572.1000,350.2110)
      .. (5565.2400,345.6020) .. controls (5558.2700,340.9300) and
      (5549.4800,330.5820) .. (5539.1700,314.8590) -- (5457.3300,189.6990) --
      (5457.3300,78.7109) .. controls (5457.3300,57.8516) and (5460.0300,43.5312) ..
      (5465.3200,36.1484) .. controls (5470.4000,29.1016) and (5480.1700,25.5000) ..
      (5494.3700,25.5000) -- (5497.5900,25.5000) -- (5497.5900,8.7812);
    \path[fill=c231f20,nonzero rule] (1372.7400,2141.4400) .. controls
      (1384.1800,2137.9800) and (1398.2900,2136.2500) .. (1414.7400,2136.2500) ..
      controls (1441.2700,2136.2500) and (1462.4200,2142.9200) ..
      (1477.6600,2156.0500) .. controls (1492.7700,2169.0800) and
      (1500.4200,2187.2000) .. (1500.4200,2209.9600) .. controls
      (1500.4200,2234.6000) and (1492.7500,2255.1900) .. (1477.5900,2271.1500) ..
      controls (1462.5000,2287.0700) and (1441.3600,2295.1500) ..
      (1414.7400,2295.1500) -- (1372.7400,2295.1500) -- (1372.7400,2141.4400) --
      cycle(1414.2200,1953.5700) -- (1276.1400,1953.5700) -- (1276.1400,1970.2900)
      -- (1279.3600,1970.2900) .. controls (1293.9600,1970.2900) and
      (1304.0500,1974.1200) .. (1309.3200,1981.6700) .. controls
      (1314.8400,1989.5500) and (1317.6400,2003.2000) .. (1317.6400,2022.2200) --
      (1317.6400,2245.0300) .. controls (1317.6400,2265.4200) and
      (1314.8400,2279.6600) .. (1309.3500,2287.4000) .. controls
      (1304.0800,2294.7400) and (1293.9800,2298.4900) .. (1279.3600,2298.4900) --
      (1276.1400,2298.4900) -- (1276.1400,2315.2300) -- (1412.8500,2315.2300) ..
      controls (1457.0100,2315.2300) and (1492.5500,2305.5000) ..
      (1518.4800,2286.4200) .. controls (1544.6800,2267.0700) and
      (1557.9800,2241.7500) .. (1557.9800,2211.1700) .. controls
      (1557.9800,2180.7000) and (1546.2900,2156.9300) .. (1523.2500,2140.5200) ..
      controls (1500.5600,2124.3700) and (1467.7100,2116.1900) ..
      (1425.6500,2116.1900) .. controls (1410.4700,2116.1900) and
      (1392.6900,2117.2600) .. (1372.7400,2119.4500) -- (1372.7400,2023.5100) ..
      controls (1372.7400,2002.8700) and (1375.5000,1988.5900) ..
      (1380.9900,1981.1100) .. controls (1386.2200,1973.9200) and
      (1396.3400,1970.2900) .. (1410.9900,1970.2900) -- (1414.2200,1970.2900) --
      (1414.2200,1953.5700);
    \path[fill=c231f20,nonzero rule] (1833.0600,2139.2700) -- (1874.7400,2139.2700)
      .. controls (1900.5800,2139.2700) and (1921.0600,2146.5000) ..
      (1935.6600,2160.7400) .. controls (1950.2100,2175.0300) and
      (1957.6100,2194.2100) .. (1957.6100,2217.8100) .. controls
      (1957.6100,2240.7200) and (1949.4300,2259.5500) .. (1933.2800,2273.7100) ..
      controls (1917.0000,2287.9200) and (1895.1000,2295.1500) ..
      (1868.1800,2295.1500) -- (1833.0600,2295.1500) -- (1833.0600,2139.2700) --
      cycle(2091.9400,1953.5700) -- (2012.3700,1953.5700) -- (2011.4000,1954.6800)
      .. controls (1995.9600,1972.7300) and (1977.0800,1999.5100) ..
      (1955.3000,2034.2500) .. controls (1932.3400,2070.3500) and
      (1914.1600,2093.6300) .. (1901.3200,2103.4700) .. controls
      (1888.7300,2113.1400) and (1874.6500,2118.0000) .. (1859.4600,2118.0000) --
      (1833.0600,2118.0000) -- (1833.0600,2023.5100) .. controls
      (1833.0600,2003.2400) and (1835.9300,1989.1000) .. (1841.6000,1981.4200) ..
      controls (1847.0700,1974.0400) and (1857.1700,1970.2900) ..
      (1871.6200,1970.2900) -- (1874.8200,1970.2900) -- (1874.8200,1953.5700) --
      (1736.7600,1953.5700) -- (1736.7600,1970.2900) -- (1739.9800,1970.2900) ..
      controls (1755.0000,1970.2900) and (1765.2100,1974.0200) ..
      (1770.2500,1981.3200) .. controls (1775.5700,1989.0200) and
      (1778.2600,2003.2000) .. (1778.2600,2023.4300) -- (1778.2600,2246.2500) ..
      controls (1778.2600,2266.4600) and (1775.6300,2280.4800) ..
      (1770.4400,2287.8900) .. controls (1765.4500,2294.9000) and
      (1755.2100,2298.4900) .. (1739.9800,2298.4900) -- (1736.7600,2298.4900) --
      (1736.7600,2315.2300) -- (1890.0100,2315.2300) .. controls
      (1927.5900,2315.2300) and (1958.1200,2306.1700) .. (1980.7500,2288.3300) ..
      controls (2003.6000,2270.3100) and (2015.2000,2246.9900) ..
      (2015.2000,2219.0200) .. controls (2015.2000,2175.9700) and
      (1991.2500,2146.2600) .. (1943.9300,2130.7600) .. controls
      (1953.2500,2124.1400) and (1962.4200,2115.7200) .. (1971.2800,2105.6200) ..
      controls (1981.8900,2093.5100) and (1995.9400,2073.2200) ..
      (2013.0100,2045.3100) .. controls (2031.8500,2014.8000) and
      (2046.7400,1994.5500) .. (2057.2900,1985.1700) .. controls
      (2067.4700,1976.0300) and (2078.1300,1971.0300) .. (2088.9400,1970.2900) --
      (2091.9400,1970.0700) -- (2091.9400,1953.5700);
    \path[fill=c231f20,nonzero rule] (2406.2600,1953.5700) -- (2268.1800,1953.5700)
      -- (2268.1800,1970.2900) -- (2271.4200,1970.2900) .. controls
      (2286.2700,1970.2900) and (2296.4200,1973.9000) .. (2301.5400,1981.0900) ..
      controls (2306.9200,1988.5700) and (2309.6600,2002.8300) ..
      (2309.6600,2023.4300) -- (2309.6600,2245.0300) .. controls
      (2309.6600,2266.0500) and (2306.9900,2280.4200) .. (2301.7000,2287.8500) ..
      controls (2296.6500,2294.9000) and (2286.4500,2298.4900) ..
      (2271.4200,2298.4900) -- (2268.1800,2298.4900) -- (2268.1800,2315.2300) --
      (2406.2600,2315.2300) -- (2406.2600,2298.4900) -- (2403.0500,2298.4900) ..
      controls (2388.6000,2298.4900) and (2378.5500,2294.7400) ..
      (2373.1900,2287.3800) .. controls (2367.6100,2279.6600) and
      (2364.7800,2265.4400) .. (2364.7800,2245.0300) -- (2364.7800,2023.4300) ..
      controls (2364.7800,2003.0200) and (2367.6100,1988.8000) ..
      (2373.1900,1981.2600) .. controls (2378.5300,1973.9800) and
      (2388.5700,1970.2900) .. (2403.0500,1970.2900) -- (2406.2600,1970.2900) --
      (2406.2600,1953.5700);
    \path[fill=c231f20,nonzero rule] (2759.5400,1953.5700) -- (2621.4800,1953.5700)
      -- (2621.4800,1970.2900) -- (2624.7200,1970.2900) .. controls
      (2639.3700,1970.2900) and (2649.4500,1973.9600) .. (2654.7200,1981.2300) ..
      controls (2660.2100,1988.8000) and (2662.9600,2003.0200) ..
      (2662.9600,2023.4300) -- (2662.9600,2245.0300) .. controls
      (2662.9600,2265.6800) and (2660.2200,2279.9600) .. (2654.8400,2287.5300) ..
      controls (2649.6800,2294.8000) and (2639.5600,2298.4900) ..
      (2624.7200,2298.4900) -- (2621.4800,2298.4900) -- (2621.4800,2315.2300) --
      (2879.0200,2315.2300) -- (2879.0200,2245.8000) -- (2864.7900,2245.8000) --
      (2864.2400,2248.3300) .. controls (2860.4300,2266.3800) and
      (2855.4900,2278.2400) .. (2849.6100,2283.5700) .. controls
      (2845.6300,2287.1800) and (2835.1500,2291.5200) .. (2807.8000,2291.5200) --
      (2717.7600,2291.5200) -- (2717.7600,2149.2500) -- (2809.9800,2149.2500) ..
      controls (2821.9300,2149.2500) and (2830.8000,2152.1400) ..
      (2836.3800,2157.8300) .. controls (2842.0800,2163.6300) and
      (2845.8700,2173.9800) .. (2847.6700,2188.5100) -- (2848.0100,2191.3600) --
      (2864.0600,2191.3600) -- (2864.0600,2085.0000) -- (2847.7700,2085.0000) --
      (2847.6300,2088.0600) .. controls (2846.4600,2113.0600) and
      (2834.5400,2125.2500) .. (2811.2300,2125.2500) -- (2717.7600,2125.2500) --
      (2717.7600,2023.5100) .. controls (2717.7600,2003.0400) and
      (2720.5900,1988.8200) .. (2726.1700,1981.2800) .. controls
      (2731.5300,1973.9800) and (2741.6600,1970.2900) .. (2756.3200,1970.2900) --
      (2759.5400,1970.2900) -- (2759.5400,1953.5700);
    \path[fill=c231f20,nonzero rule] (3297.8400,1953.5700) -- (3157.9000,1953.5700)
      -- (3157.9000,1970.2900) -- (3161.1200,1970.2900) .. controls
      (3178.0300,1970.2900) and (3189.2500,1974.1200) .. (3194.4900,1981.6700) ..
      controls (3200.0200,1989.5500) and (3202.8100,2003.6300) ..
      (3202.8100,2023.5100) -- (3202.8100,2134.4500) -- (3125.3700,2251.5000) ..
      controls (3112.7300,2270.6600) and (3102.3900,2283.3000) ..
      (3094.6200,2289.1200) .. controls (3087.0700,2294.7600) and
      (3076.3400,2297.9100) .. (3062.7300,2298.4900) -- (3059.6600,2298.6300) --
      (3059.6600,2315.2300) -- (3209.2500,2315.2300) -- (3209.2500,2298.4900) --
      (3206.0300,2298.4900) .. controls (3183.1300,2298.4900) and
      (3171.5100,2293.9600) .. (3171.5100,2285.0500) .. controls
      (3171.5100,2280.6600) and (3173.8500,2274.9600) .. (3178.4500,2268.0600) --
      (3248.1000,2164.4700) -- (3303.3700,2249.5800) .. controls
      (3311.5100,2262.3000) and (3315.6400,2273.2400) .. (3315.6400,2282.0500) ..
      controls (3315.6400,2289.1000) and (3313.4800,2298.4900) ..
      (3294.6200,2298.4900) -- (3291.4100,2298.4900) -- (3291.4100,2315.2300) --
      (3398.2900,2315.2300) -- (3398.2900,2298.6700) -- (3395.2600,2298.4900) ..
      controls (3382.3900,2297.7300) and (3372.3700,2295.0100) ..
      (3365.5000,2290.4100) .. controls (3358.5100,2285.7000) and
      (3349.7400,2275.3500) .. (3339.4000,2259.6600) -- (3257.6000,2134.4900) --
      (3257.6000,2023.5100) .. controls (3257.6000,2002.6700) and
      (3260.3000,1988.3300) .. (3265.5900,1980.9500) .. controls
      (3270.6300,1973.8600) and (3280.3900,1970.2900) .. (3294.6200,1970.2900) --
      (3297.8400,1970.2900) -- (3297.8400,1953.5700);
    \path[fill=c231f20,nonzero rule] (3659.7200,1944.7800) .. controls
      (3642.7800,1944.7800) and (3621.0400,1949.3500) .. (3595.1500,1958.2800) ..
      controls (3582.3500,1962.6700) and (3577.6500,1963.5700) ..
      (3575.9300,1963.5700) .. controls (3571.4200,1963.5700) and
      (3567.7200,1959.6800) .. (3564.9500,1952.0300) -- (3564.1900,1949.9000) --
      (3547.7800,1949.9000) -- (3547.7800,2052.3800) -- (3565.1300,2052.3800) --
      (3565.1500,2049.1600) .. controls (3565.3400,2023.7500) and
      (3573.9200,2003.1400) .. (3590.6900,1987.9200) .. controls
      (3607.5500,1972.6100) and (3627.5100,1964.8400) .. (3650.0100,1964.8400) ..
      controls (3671.3000,1964.8400) and (3688.5400,1970.3900) ..
      (3701.3000,1981.3200) .. controls (3714.0500,1992.3000) and
      (3720.2400,2006.5600) .. (3720.2400,2024.9800) .. controls
      (3720.2400,2038.4700) and (3714.9500,2051.6400) .. (3704.5200,2064.0800) ..
      controls (3693.8000,2076.9100) and (3670.8700,2093.7600) ..
      (3636.3800,2114.1900) .. controls (3607.3300,2131.6200) and
      (3588.4300,2145.0300) .. (3578.6000,2155.2300) .. controls
      (3568.7800,2165.4100) and (3561.4200,2176.7100) .. (3556.7100,2188.8600) ..
      controls (3552.0400,2200.9500) and (3549.6600,2214.4500) ..
      (3549.6600,2229.0000) .. controls (3549.6600,2257.0700) and
      (3559.2900,2280.1700) .. (3578.3100,2297.6500) .. controls
      (3597.1600,2315.1300) and (3622.1000,2323.9800) .. (3652.3500,2323.9800) ..
      controls (3668.8400,2323.9800) and (3687.0200,2320.7600) ..
      (3706.4000,2314.4300) .. controls (3717.0400,2311.0700) and
      (3721.9000,2310.3900) .. (3724.0900,2310.3900) .. controls
      (3726.9400,2310.3900) and (3727.5700,2311.0500) .. (3727.6100,2311.0500) ..
      controls (3727.8600,2311.3600) and (3728.8400,2312.7700) ..
      (3730.3800,2318.0400) -- (3731.0400,2320.3700) -- (3746.9600,2320.3700) --
      (3746.9600,2230.6600) -- (3729.9500,2230.6600) -- (3729.6400,2233.5300) ..
      controls (3727.2400,2255.6000) and (3718.9400,2273.0200) ..
      (3704.9900,2285.3700) .. controls (3690.9900,2297.6900) and
      (3673.0600,2303.9400) .. (3651.7500,2303.9400) .. controls
      (3632.7800,2303.9400) and (3617.4300,2299.2700) .. (3606.0400,2290.0900) ..
      controls (3594.6600,2280.9700) and (3589.1300,2269.1000) ..
      (3589.1300,2253.8400) .. controls (3589.1300,2239.7400) and
      (3593.9200,2226.6600) .. (3603.4100,2215.0000) .. controls
      (3613.0800,2203.0600) and (3634.6000,2187.3200) .. (3667.4100,2168.2400) ..
      controls (3706.2800,2145.6600) and (3732.8200,2125.6400) ..
      (3746.2800,2108.7100) .. controls (3759.9700,2091.4000) and
      (3766.9200,2071.3400) .. (3766.9200,2049.1400) .. controls
      (3766.9200,2020.5000) and (3756.3400,1995.6800) .. (3735.4400,1975.3700) ..
      controls (3714.5800,1955.0900) and (3689.0900,1944.7800) ..
      (3659.7200,1944.7800) -- (3659.7200,1944.7800);
    \path[fill=c231f20,nonzero rule] (4178.8200,1944.7800) .. controls
      (4110.7700,1944.7800) and (4056.9200,1961.3400) .. (4018.7400,1994.0200) ..
      controls (3980.4200,2026.7700) and (3961.0300,2070.6000) ..
      (3961.0300,2124.2300) .. controls (3961.0300,2161.5800) and
      (3969.4800,2195.7200) .. (3986.2000,2225.7200) .. controls
      (4002.9000,2255.7600) and (4026.5900,2279.9200) .. (4056.6300,2297.5100) ..
      controls (4086.6300,2315.0900) and (4118.9400,2323.9800) ..
      (4152.6100,2323.9800) .. controls (4172.7800,2323.9800) and
      (4195.0300,2320.4600) .. (4218.7000,2313.5700) .. controls
      (4233.2900,2309.4500) and (4244.5400,2307.3600) .. (4252.1200,2307.3600) ..
      controls (4261.1600,2307.3600) and (4266.9000,2310.5600) ..
      (4269.7200,2317.1800) -- (4270.5600,2319.1200) -- (4287.4500,2319.1200) --
      (4287.4500,2207.9200) -- (4271.1400,2207.9200) -- (4270.7500,2210.6800) ..
      controls (4266.7500,2238.7300) and (4253.4700,2261.5200) ..
      (4231.3000,2278.3900) .. controls (4208.9700,2295.3300) and
      (4182.4900,2303.9400) .. (4152.6100,2303.9400) .. controls
      (4115.1100,2303.9400) and (4083.9600,2289.1900) .. (4059.9700,2260.1300) ..
      controls (4035.8300,2230.8700) and (4023.5800,2192.5100) ..
      (4023.5800,2146.0700) .. controls (4023.5800,2095.0000) and
      (4037.7600,2052.0800) .. (4065.7100,2018.4900) .. controls
      (4093.5300,1985.0900) and (4128.9400,1968.1600) .. (4171.0100,1968.1600) ..
      controls (4210.1900,1968.1600) and (4229.2500,1979.5100) ..
      (4229.2500,2002.8900) -- (4229.2500,2041.4400) .. controls
      (4229.2500,2062.5500) and (4226.4400,2077.3600) .. (4220.9100,2085.4400) ..
      controls (4215.6300,2093.1800) and (4205.9900,2097.1000) ..
      (4192.2200,2097.1000) -- (4174.9700,2097.1000) -- (4174.9700,2113.8400) --
      (4329.5400,2113.8400) -- (4329.5400,2097.1000) -- (4326.3400,2097.1000) ..
      controls (4311.1000,2097.1000) and (4300.1700,2093.8000) ..
      (4293.8800,2087.3200) .. controls (4287.5500,2080.8000) and
      (4284.3300,2069.0200) .. (4284.3300,2052.3800) -- (4284.3300,1954.2900) --
      (4281.9400,1953.6700) .. controls (4273.1700,1951.4000) and
      (4257.3300,1949.4100) .. (4233.5100,1947.5000) .. controls
      (4210.1500,1945.6800) and (4191.7500,1944.7800) .. (4178.8200,1944.7800) --
      (4178.8200,1944.7800);
    \path[fill=c231f20,nonzero rule] (4711.4900,2303.9400) .. controls
      (4669.8700,2303.9400) and (4636.1400,2288.5300) .. (4611.2200,2258.1600) ..
      controls (4586.1400,2227.6100) and (4573.4100,2186.3200) ..
      (4573.4100,2135.4400) .. controls (4573.4100,2084.5500) and
      (4586.0100,2042.8900) .. (4610.7900,2011.6200) .. controls
      (4635.4000,1980.5600) and (4668.1300,1964.8200) .. (4708.0800,1964.8200) ..
      controls (4748.4700,1964.8200) and (4781.6500,1980.9300) ..
      (4806.7700,2012.6900) .. controls (4832.0800,2044.6200) and
      (4844.9100,2085.0900) .. (4844.9100,2133.0000) .. controls
      (4844.9100,2184.5500) and (4832.3100,2226.4000) .. (4807.5700,2257.4400) ..
      controls (4782.9400,2288.2800) and (4750.6200,2303.9400) ..
      (4711.4900,2303.9400) -- (4711.4900,2303.9400) -- cycle(4708.7000,1944.7800)
      .. controls (4653.6200,1944.7800) and (4606.3600,1963.4300) ..
      (4568.2700,2000.1900) .. controls (4530.1700,2036.9700) and
      (4510.8700,2082.6500) .. (4510.8700,2136.0500) .. controls
      (4510.8700,2189.4300) and (4530.0700,2234.5800) .. (4568.0200,2270.2700) ..
      controls (4605.8300,2305.9100) and (4653.7200,2323.9800) ..
      (4710.2600,2323.9800) .. controls (4765.1700,2323.9800) and
      (4812.2400,2305.6400) .. (4850.1900,2269.5100) .. controls
      (4888.2100,2233.3000) and (4907.4900,2188.3900) .. (4907.4900,2136.0500) ..
      controls (4907.4900,2082.6900) and (4888.0600,2036.9900) ..
      (4849.7000,2000.1900) .. controls (4811.4600,1963.4300) and
      (4764.0100,1944.7800) .. (4708.7000,1944.7800) -- (4708.7000,1944.7800);
    \path[fill=c231f20,nonzero rule] (5367.9600,1953.5300) -- (5097.1800,1953.5300)
      -- (5097.1800,1970.2900) -- (5100.4200,1970.2900) .. controls
      (5114.3800,1970.2900) and (5123.9700,1974.2900) .. (5129.7600,1982.5300) ..
      controls (5135.6500,1991.0300) and (5138.6600,2005.8000) ..
      (5138.6600,2026.4600) -- (5138.6600,2250.1700) .. controls
      (5138.6600,2268.5700) and (5135.8900,2281.4000) .. (5130.4400,2288.3500) ..
      controls (5125.2200,2295.0700) and (5115.1100,2298.4700) ..
      (5100.4200,2298.4700) -- (5097.1800,2298.4700) -- (5097.1800,2315.2300) --
      (5234.6400,2315.2300) -- (5234.6400,2298.4700) -- (5231.4200,2298.4700) ..
      controls (5217.8200,2298.4700) and (5208.4300,2294.6400) ..
      (5202.6500,2286.7700) .. controls (5196.7700,2278.6900) and
      (5193.7800,2264.8400) .. (5193.7800,2245.6600) -- (5193.7800,2008.2600) ..
      controls (5193.7800,1996.1900) and (5196.2800,1987.9400) ..
      (5201.2200,1983.7500) .. controls (5206.3200,1979.4500) and
      (5216.6700,1977.2600) .. (5232.0400,1977.2600) -- (5304.7200,1977.2600) ..
      controls (5326.3000,1977.2600) and (5341.4600,1980.8200) ..
      (5349.7200,1987.8700) .. controls (5358.1300,1994.9400) and
      (5366.3000,2010.9100) .. (5374.0100,2035.2500) -- (5374.7400,2037.5100) --
      (5392.2800,2037.5100) -- (5391.0600,2033.3900) -- (5368.6200,1955.8700) --
      (5367.9600,1953.5300) -- (5367.9600,1953.5300);
    \path[fill=c231f20,nonzero rule] (3334.2200,2731.4100) .. controls
      (3579.8200,2731.4100) and (3861.2900,2847.2500) .. (4087.1500,3041.2400) ..
      controls (4328.3200,3248.4500) and (4466.6600,3512.5400) ..
      (4466.6600,3765.8300) -- (4466.6600,5378.3300) -- (2201.7600,5378.3300) --
      (2201.7600,3765.8300) .. controls (2201.7600,3512.5400) and
      (2340.0800,3248.4500) .. (2581.2900,3041.2400) .. controls
      (2807.1100,2847.2500) and (3088.5700,2731.4100) .. (3334.2200,2731.4100) --
      (3334.2200,2731.4100);
    \path[fill=cb91930,nonzero rule] (3730.0000,4217.1400) -- (4423.5390,4217.1400)
      -- (4423.5390,5335.8200) -- (3730.0000,5335.8200) -- (3730.0000,4217.1400) --
      cycle;
    \path[fill=cb91930,nonzero rule] (2243.6800,4180.2900) -- (2937.8300,4180.2900)
      -- (2937.8300,2864.9100) .. controls (2572.7100,3025.8100) and
      (2243.6800,3380.2000) .. (2243.6800,3765.8300) -- (2243.6800,4180.2900);
    \path[fill=cf9ae0c,nonzero rule] (2244.3000,4217.1400) -- (2937.8270,4217.1400)
      -- (2937.8270,5335.8200) -- (2244.3000,5335.8200) -- (2244.3000,4217.1400) --
      cycle;
    \path[fill=cf9ae0c,nonzero rule] (3730.0000,4180.2900) -- (3730.0000,2864.9100)
      .. controls (4095.1200,3025.8100) and (4424.1400,3380.2000) ..
      (4424.1400,3765.8300) -- (4424.1400,4180.2900) -- (3730.0000,4180.2900);
    \path[fill=cffffff,nonzero rule] (3389.5300,2976.5100) .. controls
      (3381.4100,2980.4500) and (3371.9100,2984.0500) .. (3370.1400,2984.1400) ..
      controls (3367.9900,2983.9700) and (3348.4400,2975.7700) ..
      (3348.4400,2952.5000) .. controls (3348.4400,2926.9800) and
      (3361.1500,2913.4800) .. (3385.1600,2913.4800) .. controls
      (3406.8800,2913.4800) and (3411.4500,2929.5600) .. (3411.4500,2943.0600) ..
      controls (3411.4500,2964.0900) and (3401.9300,2970.4300) ..
      (3389.5300,2976.5100) -- cycle(3584.8200,2959.7900) -- (3575.6300,2947.0600)
      -- (3574.7900,2945.8900) -- (3558.0700,2945.8900) .. controls
      (3556.1700,2945.8900) and (3555.7200,2945.6500) .. (3555.6600,2945.6200) ..
      controls (3555.6100,2945.4100) and (3555.5100,2944.3400) ..
      (3555.5100,2942.5600) -- (3555.5100,2925.2200) .. controls
      (3555.5100,2916.4200) and (3555.5100,2916.4200) .. (3562.6600,2914.4000) --
      (3574.1200,2911.1000) -- (3576.1500,2910.5200) -- (3576.1500,2900.4900) --
      (3510.6400,2900.4900) -- (3510.6400,2910.4700) -- (3512.6400,2911.0800) --
      (3526.1500,2915.1600) .. controls (3530.2700,2916.2400) and
      (3530.2700,2916.2400) .. (3530.2700,2924.7100) -- (3530.2700,2941.5500) ..
      controls (3530.2700,2943.2900) and (3530.2700,2945.2700) ..
      (3530.0400,2945.7500) .. controls (3530.0400,2945.7300) and
      (3530.0400,2945.7300) .. (3529.9800,2945.7300) .. controls
      (3529.8400,2945.7300) and (3529.1400,2945.8900) .. (3527.2100,2945.8900) --
      (3461.3900,2945.8900) -- (3460.5900,2946.5800) -- (3458.5700,2948.3500) --
      (3457.2900,2949.5000) -- (3457.7000,2951.1600) -- (3462.0500,2968.5000) ..
      controls (3465.9400,2974.9300) and (3469.5900,2981.2600) ..
      (3473.5400,2988.1400) .. controls (3478.8700,2997.3900) and
      (3484.8800,3007.8800) .. (3491.9900,3018.8100) .. controls
      (3507.8500,3043.1400) and (3521.5600,3062.6100) .. (3526.4800,3069.1700) --
      (3527.0300,3069.9000) -- (3527.8900,3070.1700) -- (3549.5900,3076.7900) --
      (3550.9800,3077.2300) -- (3552.1300,3076.3400) -- (3554.4300,3074.5600) --
      (3555.5100,3073.7100) -- (3555.5100,2970.5900) .. controls
      (3555.5100,2969.6900) and (3555.5100,2966.9600) .. (3555.8400,2966.3700) ..
      controls (3555.8400,2966.3700) and (3555.8600,2966.3900) ..
      (3555.9000,2966.3900) .. controls (3556.0700,2966.3900) and
      (3556.8200,2966.2700) .. (3558.5900,2966.2700) -- (3582.3800,2966.2700) --
      (3583.2200,2965.1700) -- (3584.7900,2963.1200) -- (3586.0400,2961.4700) --
      (3584.8200,2959.7900) -- cycle(3376.7600,2897.1900) .. controls
      (3344.8400,2897.1900) and (3325.7800,2916.4300) .. (3325.7800,2948.6800) ..
      controls (3325.7800,2974.1100) and (3342.2200,2983.5800) ..
      (3351.0400,2988.6600) .. controls (3353.1500,2989.8700) and
      (3355.7600,2991.3900) .. (3356.1900,2992.1100) -- (3356.1100,2992.1100) ..
      controls (3355.6900,2992.1100) and (3354.0400,2993.1300) ..
      (3352.8000,2993.8700) .. controls (3346.0200,2998.0100) and
      (3333.4100,3005.7200) .. (3333.4100,3030.7700) .. controls
      (3333.4100,3061.0700) and (3359.5500,3076.9100) .. (3385.4100,3076.9100) ..
      controls (3414.0200,3076.9100) and (3429.7900,3061.6400) ..
      (3429.7900,3033.8500) .. controls (3429.7900,3012.9000) and
      (3415.7000,3003.6100) .. (3408.1300,2998.6300) .. controls
      (3407.2300,2998.0300) and (3406.1700,2997.3300) .. (3405.4300,2996.7600) ..
      controls (3406.4600,2996.1500) and (3408.2000,2995.3400) ..
      (3409.6900,2994.6500) .. controls (3419.3000,2990.2600) and
      (3437.1700,2982.0800) .. (3437.1700,2953.7900) .. controls
      (3437.1700,2918.8700) and (3414.0200,2897.1900) .. (3376.7600,2897.1900) --
      cycle(3244.7000,2897.1700) .. controls (3212.7800,2897.1700) and
      (3193.7200,2916.4300) .. (3193.7200,2948.6900) .. controls
      (3193.7200,2974.1100) and (3210.1700,2983.5600) .. (3219.0000,2988.6600) ..
      controls (3221.1000,2989.8800) and (3223.7200,2991.3900) ..
      (3224.1400,2992.1100) -- (3224.0700,2992.1100) .. controls
      (3223.6400,2992.1100) and (3221.9900,2993.1200) .. (3220.7300,2993.8800) ..
      controls (3213.9600,2998.0300) and (3201.3600,3005.7300) ..
      (3201.3600,3030.7900) .. controls (3201.3600,3061.0800) and
      (3227.5200,3076.9300) .. (3253.3600,3076.9300) .. controls
      (3281.9600,3076.9300) and (3297.7300,3061.6200) .. (3297.7300,3033.8300) ..
      controls (3297.7300,3012.9100) and (3283.6600,3003.6000) ..
      (3276.1000,2998.6300) .. controls (3275.1800,2998.0300) and
      (3274.1200,2997.3300) .. (3273.4000,2996.7700) .. controls
      (3274.4100,2996.1600) and (3276.1700,2995.3500) .. (3277.6600,2994.6500) ..
      controls (3287.2800,2990.2500) and (3305.1500,2982.0600) ..
      (3305.1500,2953.7800) .. controls (3305.1500,2918.8600) and
      (3281.9600,2897.1700) .. (3244.7000,2897.1700) -- cycle(3168.5600,2900.4900)
      -- (3088.5000,2900.4900) -- (3088.5000,2910.5500) -- (3090.6000,2911.0900) --
      (3108.1900,2915.6900) .. controls (3115.5300,2917.6200) and
      (3115.5300,2918.0300) .. (3115.5300,2924.9400) -- (3115.5300,3041.9900) ..
      controls (3115.5300,3050.9000) and (3115.5300,3051.2500) ..
      (3107.8200,3051.4500) -- (3086.9200,3051.6900) -- (3084.6600,3051.7100) --
      (3084.2300,3053.9600) -- (3083.2100,3059.0500) -- (3082.7200,3061.5400) --
      (3085.1600,3062.2600) -- (3134.0900,3076.8100) -- (3135.4500,3077.2200) --
      (3136.5600,3076.3800) -- (3139.6300,3074.0900) -- (3140.7600,3073.2400) --
      (3140.7600,2923.9500) .. controls (3140.7600,2918.7200) and
      (3141.0700,2917.2700) .. (3148.8000,2915.4500) -- (3166.4400,2911.1100) --
      (3168.5600,2910.5700) -- (3168.5600,2900.4900) -- cycle(3693.1400,5334.2400)
      -- (3693.1400,5335.8200) -- (2974.6900,5335.8200) -- (2974.6900,5334.2400) --
      (2972.8000,5334.2400) -- (2972.8000,2850.5300) .. controls
      (3065.5700,2812.9700) and (3160.0300,2788.0300) .. (3251.5100,2778.4400) ..
      controls (3352.7400,2765.6100) and (3442.8300,2773.8500) ..
      (3539.2200,2799.8100) .. controls (3590.5100,2812.2300) and
      (3642.0700,2828.8900) .. (3693.1400,2849.4400) -- (3693.1400,2852.5000) ..
      controls (3693.9800,2852.8400) and (3694.7900,2853.1500) ..
      (3695.6300,2853.5000) -- (3695.6300,5334.2400) -- (3693.1400,5334.2400) --
      cycle(3484.6100,2968.8300) .. controls (3484.6100,2966.6300) and
      (3484.6100,2966.2700) .. (3491.0000,2966.2700) -- (3527.7100,2966.2700) ..
      controls (3529.5500,2966.2700) and (3529.9600,2966.6100) ..
      (3529.9600,2966.6100) .. controls (3530.2700,2967.0000) and
      (3530.2700,2969.0900) .. (3530.2700,2970.5900) -- (3530.2700,3048.2800) ..
      controls (3525.6300,3042.2300) and (3514.4500,3025.0200) ..
      (3501.3300,3002.1100) .. controls (3488.1400,2979.5700) and
      (3484.6100,2970.5900) .. (3484.6100,2968.8300) -- cycle(3259.2500,3003.0100)
      .. controls (3262.0300,3003.0100) and (3275.0500,3010.5800) ..
      (3275.0500,3032.0700) .. controls (3275.0500,3049.4000) and
      (3264.3500,3060.6100) .. (3247.7700,3060.6100) .. controls
      (3230.6800,3060.6100) and (3227.1100,3047.8600) .. (3227.1100,3037.1600) ..
      controls (3227.1100,3008.9700) and (3258.9400,3003.0100) ..
      (3259.2500,3003.0100) -- cycle(3257.5100,2976.5100) .. controls
      (3249.1700,2980.5300) and (3239.8600,2984.0400) .. (3238.0900,2984.1300) ..
      controls (3235.9500,2983.9700) and (3216.4200,2975.7700) ..
      (3216.4200,2952.5000) .. controls (3216.4200,2926.9800) and
      (3229.1100,2913.5000) .. (3253.1200,2913.5000) .. controls
      (3274.8200,2913.5000) and (3279.3800,2929.5800) .. (3279.3800,2943.0700) ..
      controls (3279.3800,2964.1100) and (3269.9100,2970.4300) ..
      (3257.5100,2976.5100) -- cycle(3391.3100,3002.9900) .. controls
      (3394.0800,3002.9900) and (3407.1300,3010.5700) .. (3407.1300,3032.0800) ..
      controls (3407.1300,3049.4200) and (3396.3900,3060.6200) ..
      (3379.8000,3060.6200) .. controls (3362.7300,3060.6200) and
      (3359.1400,3047.8700) .. (3359.1400,3037.1500) .. controls
      (3359.1400,3008.9900) and (3390.9800,3003.0100) .. (3391.3100,3002.9900);
    \path[fill=c231f20,nonzero rule] (3904.9200,4879.7000) .. controls
      (3903.8700,4862.3100) and (3893.1800,4877.5400) .. (3893.1800,4877.5400) ..
      controls (3893.1800,4877.5400) and (3866.0900,4903.7900) ..
      (3866.0900,4941.5400) .. controls (3873.9600,4946.2500) and
      (3877.6400,4963.0300) .. (3880.7800,4964.5900) .. controls
      (3883.9300,4966.1700) and (3905.9400,4976.6600) .. (3905.9400,4987.6600) ..
      controls (3905.9400,4998.6700) and (3875.0200,5066.8200) ..
      (3875.0200,5092.5100) -- (3848.7900,5055.8000) -- (3828.3600,5091.4600) --
      (3812.1100,5049.0000) -- (3795.3300,5068.9200) .. controls
      (3795.3300,5068.9200) and (3787.1900,5007.4200) .. (3790.1400,4996.3200) ..
      controls (3798.1600,4966.2700) and (3811.5800,4969.8400) ..
      (3811.5800,4959.3500) .. controls (3811.5800,4943.1100) and
      (3783.1100,4931.1200) .. (3783.1100,4931.1200) .. controls
      (3786.3700,4922.4600) and (3802.5600,4844.5100) .. (3814.3200,4806.8800) ..
      controls (3827.7900,4763.8600) and (3837.2700,4760.1500) ..
      (3846.1900,4741.8100) .. controls (3853.4600,4726.8300) and
      (3856.6800,4693.5900) .. (3874.4900,4693.5900) .. controls
      (3892.3000,4693.5900) and (3941.0700,4711.3900) .. (3941.0700,4711.3900) ..
      controls (3924.8000,4695.6800) and (3917.4800,4536.8400) ..
      (3891.2700,4536.8400) .. controls (3873.5000,4536.8400) and
      (3828.3800,4535.5300) .. (3828.3800,4535.5300) .. controls
      (3828.3800,4535.5300) and (3808.6500,4504.2700) .. (3792.7100,4441.9500) --
      (3831.5000,4464.4900) -- (3819.9800,4403.1600) -- (3867.1500,4438.2800) --
      (3886.5400,4378.0000) -- (3903.8500,4406.3100) .. controls
      (3903.8500,4406.3100) and (3899.5500,4419.8000) .. (3913.8100,4438.8100) ..
      controls (3926.3900,4455.5800) and (3945.7800,4483.3600) ..
      (3945.7800,4483.3600) -- (3969.9000,4477.0800) .. controls
      (3969.9000,4477.0800) and (3982.9900,4495.4300) .. (3979.3400,4513.7700) --
      (3986.2300,4515.4700) -- (3993.7100,4531.8900) -- (4004.5500,4561.2000) ..
      controls (4008.3400,4570.2600) and (4049.2600,4676.2700) ..
      (4061.5800,4708.3200) .. controls (4063.8100,4714.1200) and
      (4071.1300,4733.2000) .. (4069.1200,4742.7700) .. controls
      (4068.0100,4748.1200) and (4066.6200,4754.7600) .. (4066.6200,4764.8900) ..
      controls (4066.6200,4774.7600) and (4075.0400,4793.2100) ..
      (4091.4300,4809.0000) .. controls (4091.4100,4808.7300) and
      (4091.4100,4808.4600) .. (4091.4100,4808.1800) .. controls
      (4091.4100,4796.9300) and (4099.6100,4793.9600) .. (4103.9500,4793.9600) ..
      controls (4108.3000,4793.9600) and (4111.3500,4796.1000) ..
      (4114.0400,4797.9900) .. controls (4118.5500,4801.1800) and
      (4126.9700,4807.1000) .. (4144.2600,4807.1000) .. controls
      (4146.4600,4807.1000) and (4148.4800,4807.0400) .. (4150.3300,4806.8800) ..
      controls (4133.2600,4800.2900) and (4112.4600,4779.6100) ..
      (4112.4600,4740.6100) .. controls (4112.4600,4713.1900) and
      (4123.9100,4682.5400) .. (4132.2700,4660.1700) .. controls
      (4134.6700,4653.7300) and (4137.5200,4646.1000) .. (4138.7900,4641.5700) ..
      controls (4137.4600,4640.5300) and (4135.9400,4639.3600) ..
      (4134.5700,4638.3000) .. controls (4117.3200,4625.0200) and
      (4099.9800,4610.8900) .. (4094.0600,4596.8100) .. controls
      (4093.9500,4596.5400) and (4093.8300,4596.2800) .. (4093.7100,4596.0100) ..
      controls (4067.2900,4591.8100) and (4040.6600,4588.7300) ..
      (4040.6600,4588.7300) -- (4000.7200,4517.0400) -- (4025.9800,4525.3000) --
      (4001.8800,4471.8400) -- (4050.1000,4491.7600) .. controls
      (4050.1000,4491.7600) and (4039.1000,4455.0600) .. (4050.1000,4441.4300) ..
      controls (4051.6200,4442.6200) and (4067.2900,4453.5500) ..
      (4067.2900,4453.5500) .. controls (4067.2900,4453.5500) and
      (4075.4900,4473.0000) .. (4080.6100,4478.1200) .. controls
      (4085.7200,4483.2500) and (4115.6300,4513.7700) .. (4115.6300,4513.7700) --
      (4122.9700,4495.4300) .. controls (4159.2200,4513.4600) and
      (4225.9000,4598.8300) .. (4227.8100,4613.9000) .. controls
      (4227.8100,4628.5800) and (4201.6000,4651.6400) .. (4201.6000,4685.7200) ..
      controls (4201.6000,4705.6400) and (4209.4700,4713.5100) ..
      (4209.4700,4713.5100) .. controls (4209.4700,4689.3900) and
      (4267.1300,4634.8700) .. (4272.3600,4619.6700) .. controls
      (4259.2600,4612.3200) and (4234.1000,4536.8400) .. (4230.9600,4526.3600) ..
      controls (4220.4500,4526.6400) and (4165.6100,4513.9700) ..
      (4165.6100,4513.9700) .. controls (4165.6100,4513.9700) and
      (4133.8700,4480.1700) .. (4125.0600,4439.8600) -- (4169.1000,4448.7700) --
      (4161.5000,4397.2200) -- (4180.9800,4401.3100) .. controls
      (4180.9800,4401.3100) and (4199.3900,4432.0400) .. (4229.9000,4433.5600) --
      (4257.1700,4388.4800) -- (4275.5300,4408.9300) .. controls
      (4275.5300,4408.9300) and (4277.6200,4467.1200) .. (4287.5800,4473.9300) --
      (4309.0800,4465.5500) .. controls (4368.3800,4508.8500) and
      (4376.4800,4664.7800) .. (4368.3800,4669.6400) .. controls
      (4363.2600,4672.7100) and (4361.2100,4666.5700) .. (4345.8600,4686.0200) ..
      controls (4320.7000,4717.8700) and (4324.6100,4789.7400) ..
      (4300.7800,4815.0700) .. controls (4300.7800,4815.0700) and
      (4303.3000,4817.3000) .. (4314.3200,4817.3000) .. controls
      (4325.3300,4817.3000) and (4367.4000,4832.5000) .. (4367.7900,4882.3000) ..
      controls (4368.2600,4944.4200) and (4317.0100,4966.6200) ..
      (4317.0100,4966.6200) .. controls (4317.0100,4966.6200) and
      (4322.7000,4976.7500) .. (4322.7000,4991.3300) .. controls
      (4322.7000,5037.4600) and (4271.7400,5037.5400) .. (4270.8000,5044.2900) ..
      controls (4295.4500,5049.5200) and (4321.2100,5077.9300) ..
      (4323.2200,5098.8000) .. controls (4328.9600,5157.9800) and
      (4262.7300,5191.3700) .. (4234.6300,5163.2800) .. controls
      (4243.5400,5155.4300) and (4265.0400,5146.5000) .. (4265.0400,5124.4900) ..
      controls (4265.0400,5086.7400) and (4223.6100,5067.3500) ..
      (4223.6100,5067.3500) .. controls (4223.6100,5067.3500) and
      (4230.9600,5082.0300) .. (4230.9600,5100.3800) .. controls
      (4230.9600,5118.7200) and (4220.4900,5150.1800) .. (4180.6400,5150.1800) ..
      controls (4130.8400,5150.1800) and (4118.7900,5106.6600) ..
      (4118.7900,5106.6600) .. controls (4131.3700,5106.6600) and
      (4170.6800,5110.8600) .. (4170.6800,5087.2700) .. controls
      (4170.6800,5057.3900) and (4120.3500,5039.5700) .. (4120.3500,4990.2900) ..
      controls (4120.3500,4941.0100) and (4163.4600,4904.9500) ..
      (4212.0900,4901.7000) .. controls (4225.0600,4900.8200) and
      (4227.3200,4899.9900) .. (4236.7200,4899.9900) .. controls
      (4246.1100,4899.9900) and (4252.0900,4888.5900) .. (4272.3800,4888.5900) ..
      controls (4297.5400,4888.5900) and (4303.3200,4900.1200) ..
      (4311.7000,4900.1200) .. controls (4320.0800,4900.1200) and
      (4320.0800,4891.7300) .. (4320.0800,4887.0200) .. controls
      (4320.0800,4882.3000) and (4321.6600,4869.7200) .. (4290.7200,4869.7200) ..
      controls (4257.7000,4869.7200) and (4198.4600,4886.4900) ..
      (4145.0000,4886.4900) .. controls (4102.9700,4886.4900) and
      (4097.2900,4885.7100) .. (4094.9400,4882.6600) .. controls
      (4097.5400,4887.5400) and (4104.0200,4900.7500) .. (4104.0200,4911.4600) ..
      controls (4094.1200,4916.5100) and (4085.7600,4944.1600) ..
      (4080.5100,4944.1600) .. controls (4125.6600,4985.0700) and
      (4119.1000,5020.9800) .. (4119.5100,5029.1200) .. controls
      (4116.4500,5039.3600) and (4109.8600,5041.1300) .. (4098.8700,5041.1300) ..
      controls (4087.8500,5041.1300) and (4081.5600,5036.4200) ..
      (4081.5600,5036.4200) .. controls (4081.5600,5036.4200) and
      (4078.6900,5075.4100) .. (4072.4000,5088.5200) .. controls
      (4057.8100,5110.5400) and (3986.3900,5125.3900) .. (3958.7300,5083.4000) ..
      controls (3958.7300,5083.4000) and (3948.4000,5057.9100) ..
      (3944.2200,5050.0400) .. controls (3921.8600,5058.8200) and
      (3909.5700,5047.5500) .. (3909.5700,5047.5500) .. controls
      (3909.5700,5047.5500) and (3910.4300,5036.3000) .. (3910.6600,5028.0300) ..
      controls (3910.8400,5021.2200) and (3909.0800,5010.2000) ..
      (3909.0800,5000.7700) .. controls (3909.0800,4991.3300) and
      (3928.4800,4956.7300) .. (3928.4800,4956.7300) .. controls
      (3917.5000,4940.5400) and (3879.8000,4922.6800) .. (3879.8000,4922.6800) ..
      controls (3893.6900,4908.8000) and (3904.9200,4879.7000) ..
      (3904.9200,4879.7000);
    \path[fill=cf9ae0c,nonzero rule] (4227.0500,4514.3100) .. controls
      (4201.8900,4509.6700) and (4168.3400,4502.0200) .. (4168.3400,4502.0200) --
      (4139.7100,4454.7100) -- (4173.8500,4461.9000) .. controls
      (4176.9100,4478.1700) and (4178.7300,4487.2800) .. (4186.0900,4493.8200) ..
      controls (4200.2300,4506.4300) and (4222.5600,4507.1200) ..
      (4227.0500,4514.3100) -- cycle(3869.3000,4967.6700) .. controls
      (3874.7500,4977.2200) and (3895.9200,4981.3300) .. (3895.2300,4990.2000) ..
      controls (3894.5500,4999.0700) and (3869.9800,5054.3800) ..
      (3869.3000,5068.0300) -- (3853.5900,5039.3600) .. controls
      (3853.5900,5039.3600) and (3876.8000,5006.5900) .. (3876.8000,4995.6600) ..
      controls (3876.8000,4984.7300) and (3867.9300,4982.0000) ..
      (3869.3000,4967.6700) -- cycle(3805.5300,4885.4000) .. controls
      (3805.0600,4864.0200) and (3832.7300,4854.6900) .. (3834.4900,4844.1600) ..
      controls (3836.2500,4833.6300) and (3812.9900,4850.8400) ..
      (3813.4200,4847.6700) .. controls (3817.3200,4818.2800) and
      (3841.6200,4815.2900) .. (3850.2700,4799.4000) .. controls
      (3855.5500,4789.7600) and (3827.8300,4803.1800) .. (3828.3400,4800.2900) ..
      controls (3834.2800,4765.9400) and (3870.2000,4778.9100) ..
      (3876.6000,4756.4100) .. controls (3880.1800,4743.8500) and
      (3854.1600,4763.5400) .. (3853.3600,4752.5000) .. controls
      (3852.8100,4745.1600) and (3866.9500,4706.3800) .. (3874.8400,4704.6200) ..
      controls (3882.7500,4702.8700) and (3908.2000,4712.5200) ..
      (3919.6100,4716.9100) .. controls (3931.0200,4721.2900) and
      (3952.9500,4725.6900) .. (3955.5900,4736.2200) .. controls
      (3943.3000,4755.5200) and (3910.8200,4800.2900) .. (3906.4500,4841.5200) ..
      controls (3881.0000,4868.7300) and (3855.5500,4908.2200) ..
      (3855.5500,4940.6900) .. controls (3855.5500,4973.1600) and
      (3865.2000,4999.4900) .. (3865.2000,4999.4900) -- (3829.2200,5067.0500) --
      (3822.2100,5036.3500) .. controls (3822.2100,5036.3500) and
      (3855.5300,5004.7500) .. (3854.6700,4994.2200) .. controls
      (3853.7900,4983.7000) and (3845.0200,4951.2200) .. (3845.0200,4951.2200) ..
      controls (3838.8700,4942.4500) and (3840.6300,4993.3500) ..
      (3840.6300,4993.3500) -- (3802.0100,5042.5000) .. controls
      (3802.0100,5042.5000) and (3800.2300,5010.0600) .. (3802.4000,5000.1000) ..
      controls (3806.5200,4981.1600) and (3823.9500,4972.2700) ..
      (3823.9500,4960.8800) .. controls (3823.9500,4949.4700) and
      (3809.0400,4930.1600) .. (3801.1300,4925.7800) .. controls
      (3799.3800,4911.7300) and (3826.5800,4897.6900) .. (3827.4600,4885.4000) ..
      controls (3820.4500,4877.5200) and (3805.6400,4890.9500) ..
      (3805.5300,4885.4000) -- cycle(3847.0900,4509.8800) .. controls
      (3847.0900,4509.8800) and (3870.6400,4515.5900) .. (3889.0800,4525.2400) ..
      controls (3869.6300,4523.1800) and (3837.2100,4523.1800) ..
      (3837.2100,4523.1800) -- (3808.7300,4463.5800) -- (3836.8200,4479.3900) ..
      controls (3836.8200,4479.3900) and (3836.5600,4506.3700) ..
      (3847.0900,4509.8800) -- cycle(4050.9000,4564.8400) .. controls
      (4058.8100,4571.8600) and (4075.8200,4574.7500) .. (4085.4700,4584.4000) ..
      controls (4064.5700,4579.1800) and (4044.7700,4574.4000) ..
      (4044.7700,4574.4000) -- (4020.1800,4536.5000) -- (4039.6300,4544.7000) ..
      controls (4039.6300,4544.7000) and (4043.0100,4557.8200) ..
      (4050.9000,4564.8400) -- cycle(4134.6100,4550.1700) .. controls
      (4140.7400,4558.0700) and (4150.4100,4530.8700) .. (4150.4100,4530.8700) ..
      controls (4174.9800,4552.8100) and (4147.8100,4564.6800) ..
      (4155.6800,4571.2300) .. controls (4166.2100,4580.0200) and
      (4183.7500,4565.9700) .. (4183.7500,4565.9700) .. controls
      (4196.9100,4577.3800) and (4176.3300,4589.2800) .. (4182.0100,4596.6800) ..
      controls (4193.4200,4611.6000) and (4196.9100,4597.5600) ..
      (4204.8200,4601.0700) .. controls (4212.7100,4604.5900) and
      (4221.4800,4611.6000) .. (4212.7100,4623.0100) .. controls
      (4203.9500,4634.4200) and (4175.8600,4684.4400) .. (4200.4300,4721.2900) ..
      controls (4200.4300,4721.2900) and (4184.6300,4716.0400) ..
      (4181.1100,4702.8700) .. controls (4177.6200,4689.7100) and
      (4190.7800,4623.0100) .. (4190.7800,4613.3600) -- (4118.8100,4551.9300) ..
      controls (4118.8100,4551.9300) and (4113.5500,4557.1900) ..
      (4123.2000,4569.4800) .. controls (4132.8500,4581.7700) and
      (4178.5000,4619.5000) .. (4178.5000,4619.5000) .. controls
      (4167.0900,4634.4200) and (4183.7500,4672.1500) .. (4160.9400,4686.2000) ..
      controls (4154.7900,4688.8300) and (4137.6000,4694.0300) ..
      (4152.1700,4704.6200) .. controls (4161.8200,4711.6400) and
      (4177.6200,4708.1400) .. (4177.6200,4739.7300) .. controls
      (4177.6200,4771.3200) and (4148.6500,4773.9500) .. (4148.6500,4773.9500) ..
      controls (4152.1700,4783.6100) and (4177.6000,4780.9700) ..
      (4184.6300,4790.6200) .. controls (4171.4600,4796.7700) and
      (4171.4600,4797.6400) .. (4161.8200,4797.6400) .. controls
      (4152.1700,4797.6400) and (4124.0800,4783.6100) .. (4124.0800,4740.6100) ..
      controls (4124.0800,4697.6100) and (4156.1100,4641.8900) ..
      (4150.4100,4636.1800) .. controls (4144.7100,4630.4600) and
      (4111.8000,4608.9800) .. (4104.7700,4592.3000) .. controls
      (4097.7500,4575.6300) and (4059.1000,4550.8400) .. (4059.1000,4550.8400) --
      (4022.2900,4490.4900) -- (4046.8600,4504.5500) .. controls
      (4046.8600,4504.5500) and (4055.8800,4533.9600) .. (4070.3500,4542.6400) ..
      controls (4090.8400,4554.9400) and (4109.8600,4576.8100) ..
      (4112.9900,4573.5200) .. controls (4116.1100,4570.2100) and
      (4096.8800,4544.0400) .. (4076.6800,4533.5000) .. controls
      (4070.5500,4521.2100) and (4055.6300,4476.4600) .. (4057.3800,4466.8100) ..
      controls (4057.3800,4466.8100) and (4101.2700,4519.4600) ..
      (4113.5500,4524.7300) .. controls (4125.8400,4529.9900) and
      (4130.2100,4514.2000) .. (4130.2100,4514.2000) .. controls
      (4146.8900,4526.4800) and (4128.4600,4542.2700) .. (4134.6100,4550.1700) --
      cycle(4180.3300,4952.2600) .. controls (4186.6600,4940.8700) and
      (4238.4800,4944.0700) .. (4238.4800,4992.3800) .. controls
      (4238.4800,5017.7700) and (4217.0900,5023.1800) .. (4217.0900,5030.2000) ..
      controls (4217.0900,5047.7600) and (4311.8800,5054.7700) ..
      (4311.8800,5100.4100) .. controls (4311.8800,5124.1100) and
      (4304.8600,5135.5200) .. (4304.8600,5135.5200) .. controls
      (4304.8600,5135.5200) and (4306.6200,5099.5300) .. (4295.2100,5099.5300) ..
      controls (4277.6600,5099.5300) and (4293.4600,5120.5900) ..
      (4293.4600,5131.1300) .. controls (4293.4600,5169.7500) and
      (4252.2100,5160.9600) .. (4252.2100,5160.9600) .. controls
      (4252.2100,5160.9600) and (4276.7800,5160.0800) .. (4276.7800,5121.4800) ..
      controls (4276.7800,5072.3300) and (4204.8200,5042.5000) ..
      (4199.5500,5047.7600) .. controls (4194.3000,5053.0100) and
      (4218.8700,5069.7000) .. (4218.8700,5096.9000) .. controls
      (4218.8700,5110.0600) and (4213.5900,5138.1400) .. (4185.5100,5138.1400) ..
      controls (4152.1700,5138.1400) and (4130.2100,5115.3300) ..
      (4143.3800,5117.0800) .. controls (4156.5400,5118.8400) and
      (4182.8700,5110.0600) .. (4182.8700,5087.2500) .. controls
      (4182.8700,5048.6300) and (4131.9700,5038.9800) .. (4131.9700,4989.8300) ..
      controls (4131.9700,4928.3900) and (4194.3000,4913.4800) ..
      (4213.5900,4913.4800) .. controls (4232.9100,4913.4800) and
      (4237.2900,4916.1200) .. (4237.2900,4916.1200) .. controls
      (4232.9100,4922.2700) and (4233.7700,4935.4200) .. (4233.7700,4935.4200) ..
      controls (4233.7700,4935.4200) and (4223.2400,4931.9200) ..
      (4210.9600,4931.9200) .. controls (4163.5700,4931.9200) and
      (4158.3000,4967.8900) .. (4158.3000,4980.1800) .. controls
      (4158.3000,4992.4700) and (4170.7000,5016.4700) .. (4189.9000,5014.4100) ..
      controls (4230.2100,5010.0700) and (4205.9600,4965.7700) ..
      (4180.3300,4952.2600) -- cycle(4242.9700,4934.2500) .. controls
      (4242.9700,4920.2100) and (4249.9400,4899.8600) .. (4271.6400,4899.8600) ..
      controls (4296.7000,4899.8600) and (4297.6800,4911.6800) ..
      (4311.7200,4911.6800) .. controls (4325.7600,4911.6800) and
      (4332.2100,4900.2700) .. (4332.2100,4887.0900) .. controls
      (4332.2100,4873.9400) and (4325.3700,4858.4200) .. (4291.2500,4858.4200) ..
      controls (4230.6800,4858.4200) and (4214.7700,4874.8800) ..
      (4142.5000,4874.8800) .. controls (4074.1200,4874.8800) and
      (4079.7700,4847.6800) .. (4035.8800,4803.8100) .. controls
      (3992.0100,4759.9300) and (3957.3400,4727.4400) .. (3957.3400,4727.4400) --
      (3959.9800,4720.4200) .. controls (3938.9300,4698.4800) and
      (3928.3800,4590.5400) .. (3917.8500,4552.8100) .. controls
      (3907.3200,4515.0700) and (3849.3900,4499.2700) .. (3849.3900,4499.2700) --
      (3836.2500,4426.4300) -- (3864.3200,4451.0100) .. controls
      (3864.3200,4451.0100) and (3862.5600,4456.2700) .. (3861.6800,4472.0700) ..
      controls (3860.8200,4487.8700) and (3904.6900,4520.3400) ..
      (3925.7400,4533.5000) .. controls (3922.2300,4513.3200) and
      (3873.0900,4473.8200) .. (3873.0900,4473.8200) .. controls
      (3873.0900,4473.8200) and (3877.4800,4460.6600) .. (3878.3600,4445.7400) ..
      controls (3879.2400,4430.8200) and (3889.7700,4403.6200) ..
      (3889.7700,4403.6200) -- (3892.4600,4408.0000) .. controls
      (3892.4600,4408.0000) and (3894.1800,4424.8000) .. (3897.2900,4431.0200) ..
      controls (3904.3000,4445.0500) and (3940.6600,4494.0100) ..
      (3940.6600,4494.0100) -- (3964.3600,4490.4900) .. controls
      (3976.6400,4509.8100) and (3959.9800,4528.2300) .. (3955.5900,4539.6400) ..
      controls (3965.2300,4549.3000) and (3970.5100,4544.0300) ..
      (3981.9100,4533.5000) .. controls (3990.7000,4554.5700) and
      (3982.7900,4556.3100) .. (3975.7600,4572.9900) .. controls
      (3968.7500,4589.6600) and (3981.9100,4586.1600) .. (4000.3300,4576.5000) ..
      controls (4007.3600,4587.9000) and (4005.6100,4597.5700) ..
      (3995.0800,4621.2600) .. controls (3984.5500,4644.9500) and
      (4007.3600,4633.5400) .. (4017.8900,4625.6400) .. controls
      (4025.8000,4637.9200) and (4022.2900,4640.5600) .. (4012.6400,4665.1400) ..
      controls (4002.9900,4689.7100) and (4017.8900,4686.2000) ..
      (4034.5700,4673.9200) .. controls (4045.1200,4701.9900) and
      (4036.3300,4696.7300) .. (4029.3200,4715.1500) .. controls
      (4022.2900,4733.5900) and (4039.8400,4731.8300) .. (4053.0100,4720.4200) ..
      controls (4065.2900,4731.8300) and (4055.0000,4735.9200) ..
      (4055.0000,4764.8900) .. controls (4055.0000,4786.0600) and
      (4079.7500,4826.4000) .. (4122.7500,4842.2000) .. controls
      (4137.6600,4827.2800) and (4103.0300,4824.8400) .. (4103.0300,4808.1800) ..
      controls (4103.0300,4798.5200) and (4110.0400,4818.7100) ..
      (4144.2600,4818.7100) .. controls (4178.5000,4818.7100) and
      (4180.2500,4802.0400) .. (4189.0200,4802.0400) .. controls
      (4197.7900,4802.0400) and (4189.9000,4826.6100) .. (4189.9000,4826.6100) ..
      controls (4230.2700,4826.6100) and (4216.2300,4787.1100) ..
      (4216.2300,4737.9700) .. controls (4216.2300,4688.8300) and
      (4283.7900,4642.3200) .. (4285.5500,4615.1100) .. controls
      (4261.1700,4600.4900) and (4254.6900,4538.5700) .. (4232.5200,4504.7500) ..
      controls (4220.2300,4491.1000) and (4205.2100,4489.7300) ..
      (4189.9000,4483.4800) -- (4174.9800,4421.1700) .. controls
      (4187.2700,4434.3300) and (4218.8700,4443.1100) .. (4218.8700,4443.1100) ..
      controls (4203.9500,4472.9500) and (4223.2400,4480.8500) ..
      (4231.1300,4487.8700) .. controls (4239.0400,4494.8900) and
      (4272.3800,4537.8900) .. (4272.3800,4537.8900) -- (4277.6600,4532.6200) ..
      controls (4277.6600,4532.6200) and (4260.9800,4485.2300) ..
      (4234.6500,4472.9500) .. controls (4227.6400,4458.0200) and
      (4252.2100,4418.5400) .. (4258.3400,4408.8900) .. controls
      (4260.8600,4412.5300) and (4264.0200,4415.3600) .. (4264.0200,4415.3600) ..
      controls (4264.0200,4415.3600) and (4266.7400,4468.3000) ..
      (4275.0200,4477.3400) .. controls (4284.6700,4487.8700) and
      (4287.3000,4486.9900) .. (4305.7400,4479.9600) .. controls
      (4313.6300,4487.8700) and (4309.2400,4508.9300) .. (4302.2300,4522.0900) ..
      controls (4310.1200,4537.0100) and (4322.4200,4507.5000) ..
      (4326.3300,4512.7700) .. controls (4340.3300,4531.6400) and
      (4313.6300,4546.6600) .. (4322.4200,4565.1000) .. controls
      (4322.4200,4565.1000) and (4337.1900,4551.2200) .. (4340.8400,4553.6900) ..
      controls (4344.4900,4556.1500) and (4342.6000,4566.8400) ..
      (4339.0800,4576.5000) .. controls (4320.7600,4620.2900) and
      (4348.4000,4591.3400) .. (4351.3700,4593.1800) .. controls
      (4357.4600,4596.9400) and (4350.5500,4625.1400) .. (4342.6400,4632.1500) ..
      controls (4338.2600,4619.8800) and (4311.8800,4572.1100) ..
      (4297.8300,4538.7700) .. controls (4295.3900,4532.9300) and
      (4282.0500,4530.8700) .. (4300.4700,4587.9100) .. controls
      (4322.4000,4655.7800) and (4346.9900,4644.9500) .. (4357.5200,4641.4500) ..
      controls (4356.6400,4673.0300) and (4325.0400,4675.6600) ..
      (4322.4200,4696.7300) .. controls (4290.8200,4709.8900) and
      (4317.1500,4817.8400) .. (4252.2100,4844.1600) -- (4333.8300,4850.3000) ..
      controls (4318.0300,4834.5100) and (4287.3000,4839.7700) ..
      (4287.3000,4839.7700) .. controls (4287.3000,4839.7700) and
      (4287.3000,4830.1200) .. (4311.8800,4830.1200) .. controls
      (4336.4600,4830.1200) and (4356.0900,4852.9700) .. (4356.0900,4883.6900) ..
      controls (4356.0900,4906.3500) and (4328.6900,4955.5200) ..
      (4302.5000,4955.5200) .. controls (4280.7800,4955.5200) and
      (4271.7400,4922.2000) .. (4266.6000,4924.7700) .. controls
      (4253.6500,4931.2500) and (4262.7000,4937.0300) .. (4267.4600,4945.2700) ..
      controls (4284.0600,4973.9600) and (4311.6400,4967.4800) ..
      (4311.7200,4990.8800) .. controls (4311.8900,5034.9600) and
      (4255.1800,5036.5800) .. (4247.0500,5028.4400) .. controls
      (4240.3100,5021.7000) and (4273.1100,5028.0000) .. (4272.4200,5000.4300) ..
      controls (4272.3000,4995.2300) and (4288.8100,5014.8600) ..
      (4288.8100,5013.3800) .. controls (4288.8100,4993.0100) and
      (4242.9700,4977.5500) .. (4242.9700,4934.2500) -- cycle(3935.6100,5006.9700)
      .. controls (3935.6100,5022.7700) and (3947.2900,5024.1300) ..
      (3950.7000,5024.1300) .. controls (3959.6300,5024.1300) and
      (3958.9500,4997.3500) .. (3963.0700,4991.1800) .. controls
      (3967.1900,4985.0000) and (3978.8500,4987.7300) .. (3980.9200,4983.6200) ..
      controls (3977.4800,4978.1400) and (3965.8000,4971.2600) ..
      (3965.8000,4963.0300) .. controls (3965.8000,4954.7900) and
      (3973.3600,4952.0300) .. (3976.8000,4952.0300) .. controls
      (3981.6000,4952.0300) and (4002.2100,4957.5400) .. (4002.2100,4969.8900) ..
      controls (4002.2100,4976.0700) and (3997.4800,4979.4100) ..
      (3995.3300,4983.6200) .. controls (3993.1800,4987.8300) and
      (3993.6100,4992.8900) .. (3991.8900,4993.9300) .. controls
      (4000.1400,4994.6100) and (4008.3800,4997.3500) .. (4014.5500,4997.3500) ..
      controls (4020.7400,4997.3500) and (4021.4300,4993.2400) ..
      (4021.4300,4987.7400) .. controls (4021.4300,4982.2400) and
      (4009.7500,4978.1400) .. (4009.7500,4972.6400) .. controls
      (4009.7500,4967.1400) and (4024.8600,4952.7300) .. (4029.6700,4952.7300) ..
      controls (4034.4700,4952.7300) and (4045.4500,4956.8500) ..
      (4045.4500,4964.4100) .. controls (4045.4500,4971.9500) and
      (4041.0000,4981.2200) .. (4045.4500,4985.6900) .. controls
      (4048.2000,4988.4300) and (4054.3800,4982.9300) .. (4054.3800,4982.9300) ..
      controls (4063.6500,4992.2100) and (4069.4900,5011.0900) ..
      (4088.0300,5013.1400) .. controls (4106.5600,4980.8800) and
      (4068.1100,4968.5200) .. (4068.1100,4968.5200) -- (4053.0100,4974.6900) ..
      controls (4058.8900,4956.0400) and (4042.8900,4949.6900) ..
      (4043.4000,4942.4300) .. controls (4044.8600,4921.6300) and
      (4040.6400,4915.0700) .. (4033.1100,4908.0900) .. controls
      (4028.3000,4909.4700) and (4017.9900,4910.1600) .. (4017.3000,4906.0400) ..
      controls (4026.9100,4888.8700) and (3998.0900,4870.3400) ..
      (4001.5000,4862.7800) .. controls (3997.4000,4865.5200) and
      (3987.7700,4886.1200) .. (3984.3600,4890.2500) .. controls
      (3980.9200,4894.3600) and (3987.3200,4900.3600) .. (3983.6700,4910.1600) ..
      controls (3981.6000,4915.6400) and (3969.2400,4909.4700) ..
      (3967.8700,4919.0900) .. controls (3966.5000,4928.7000) and
      (3969.6700,4948.7900) .. (3957.9900,4955.6600) .. controls
      (3957.9900,4975.5700) and (3935.6100,4988.4400) .. (3935.6100,5006.9700) --
      cycle(4003.5500,5044.7300) -- (4005.6300,5039.9300) .. controls
      (4000.8200,5038.5500) and (4000.1400,5012.4600) .. (3987.7700,5012.4600) ..
      controls (3972.6800,5012.4600) and (3984.3400,5031.0000) ..
      (3972.6800,5034.4300) .. controls (3972.6800,5034.4300) and
      (3994.6300,5036.5000) .. (4003.5500,5044.7300) -- cycle(4020.7200,5042.6700)
      .. controls (4026.2100,5035.1200) and (4039.2800,5025.5100) ..
      (4048.8900,5033.7400) .. controls (4053.0100,5032.3800) and
      (4054.3600,5031.0000) .. (4049.5700,5025.5000) .. controls
      (4044.7700,5020.0100) and (4044.7300,5006.1700) .. (4035.1600,5006.9700) ..
      controls (4018.6700,5008.3400) and (4025.5300,5032.3800) ..
      (4019.3600,5037.8700) -- (4020.7200,5042.6700) -- cycle(3917.7000,4887.9600)
      .. controls (3922.4600,4891.8500) and (3935.6300,4912.2000) ..
      (3948.2800,4912.2000) .. controls (3947.2100,4904.8300) and
      (3928.2400,4889.0200) .. (3921.9100,4876.3600) .. controls
      (3915.6100,4863.7100) and (3926.1300,4851.0600) .. (3931.4100,4841.5700) ..
      controls (3930.3500,4850.0100) and (3950.3900,4863.7100) ..
      (3956.7000,4871.0900) .. controls (3963.0300,4878.4700) and
      (3968.2200,4875.9700) .. (3964.0800,4866.8700) .. controls
      (3958.8100,4855.2700) and (3942.2500,4843.2000) .. (3941.9500,4825.7600) ..
      controls (3941.7800,4816.4300) and (3948.9500,4809.8100) ..
      (3957.7500,4804.6700) .. controls (3957.7500,4804.6700) and
      (3960.9200,4835.2500) .. (3973.5700,4826.8200) .. controls
      (3978.6900,4823.4000) and (3953.5400,4776.2100) .. (3973.5700,4758.2900) ..
      controls (3976.7400,4771.9900) and (4007.3000,4795.1800) ..
      (4007.3000,4801.5200) .. controls (4007.3000,4807.8400) and
      (3996.7600,4828.9200) .. (4007.3000,4828.9200) .. controls
      (4013.6300,4828.9200) and (4018.9100,4809.9500) .. (4023.1300,4809.9500) ..
      controls (4027.3400,4809.9500) and (4035.7600,4814.1600) ..
      (4035.7600,4821.5400) .. controls (4035.7600,4828.9300) and
      (4016.8000,4860.5500) .. (4028.4000,4860.5500) .. controls
      (4033.7700,4860.5500) and (4046.3100,4839.4700) .. (4049.4700,4839.4700) ..
      controls (4052.6400,4839.4700) and (4055.8000,4841.5700) ..
      (4058.9600,4858.4400) .. controls (4062.1300,4875.3000) and
      (4044.2000,4881.6400) .. (4050.5300,4898.5100) .. controls
      (4050.5300,4898.5100) and (4067.4000,4890.0700) .. (4072.6800,4880.5900) ..
      controls (4077.9500,4871.0900) and (4088.4800,4897.4500) ..
      (4089.5300,4905.8800) .. controls (4086.2700,4909.7100) and
      (4082.5600,4923.1800) .. (4076.8900,4931.1800) .. controls
      (4071.6000,4938.6600) and (4064.2400,4940.7400) .. (4064.2400,4942.7900) ..
      controls (4064.2400,4946.9900) and (4070.5700,4948.0500) ..
      (4091.6600,4971.2500) .. controls (4112.7300,4994.4400) and
      (4109.5300,5021.0100) .. (4109.5700,5025.0200) .. controls
      (4096.9300,5036.6100) and (4086.3900,5019.7400) .. (4075.8400,5025.0200) ..
      controls (4065.2900,5030.2900) and (4070.5700,5062.9600) ..
      (4067.4000,5074.5700) .. controls (4067.4000,5074.5700) and
      (4053.6900,5052.4200) .. (4050.5300,5055.5800) .. controls
      (4047.3800,5058.7500) and (4051.5800,5068.2400) .. (4054.7500,5078.7800) ..
      controls (4057.9100,5089.3200) and (4040.0000,5094.6000) ..
      (4040.0000,5094.6000) .. controls (4040.0000,5094.6000) and
      (4035.7600,5072.4500) .. (4028.4000,5073.5100) .. controls
      (4021.0200,5074.5700) and (4023.1300,5095.6600) .. (4023.1300,5095.6600) ..
      controls (4023.1300,5095.6600) and (4008.3600,5104.0900) ..
      (4005.2000,5086.1700) .. controls (4001.4600,5064.9800) and
      (3991.4800,5083.0000) .. (3986.2300,5092.4800) .. controls
      (3978.8500,5089.3200) and (3981.9900,5065.0700) .. (3981.9900,5056.6400) ..
      controls (3981.9900,5048.2100) and (3967.2500,5064.0200) ..
      (3959.8800,5067.1800) .. controls (3961.9700,5059.8000) and
      (3953.6100,5048.8100) .. (3953.6100,5040.3900) .. controls
      (3953.6100,5031.9500) and (3926.1300,5045.0100) .. (3919.8000,5038.6700) ..
      controls (3919.7500,5035.3800) and (3915.8800,5008.7100) ..
      (3921.1700,4993.6100) .. controls (3927.9900,4974.2000) and
      (3938.9300,4965.6100) .. (3938.9300,4954.0200) .. controls
      (3938.9300,4943.2600) and (3922.1300,4937.9000) .. (3891.7000,4918.7100) ..
      controls (3905.5900,4916.7300) and (3906.1100,4878.4700) ..
      (3917.7000,4887.9600);
    \path[fill=c231f20,nonzero rule] (2432.0500,3859.9900) .. controls
      (2431.0000,3842.5900) and (2420.3100,3857.8300) .. (2420.3100,3857.8300) ..
      controls (2420.3100,3857.8300) and (2393.2200,3884.0700) ..
      (2393.2200,3921.8200) .. controls (2401.0900,3926.5300) and
      (2404.7700,3943.3100) .. (2407.9100,3944.8800) .. controls
      (2411.0500,3946.4500) and (2433.0700,3956.9400) .. (2433.0700,3967.9400) ..
      controls (2433.0700,3978.9500) and (2402.1400,4047.1000) ..
      (2402.1400,4072.7900) -- (2375.9200,4036.0900) -- (2355.4900,4071.7500) --
      (2339.2400,4029.2800) -- (2322.4600,4049.2000) .. controls
      (2322.4600,4049.2000) and (2314.3200,3987.7000) .. (2317.2700,3976.6000) ..
      controls (2325.2900,3946.5600) and (2338.7100,3950.1300) ..
      (2338.7100,3939.6300) .. controls (2338.7100,3923.3900) and
      (2310.2300,3911.4000) .. (2310.2300,3911.4000) .. controls
      (2313.5000,3902.7500) and (2329.6900,3824.7900) .. (2341.4500,3787.1600) ..
      controls (2354.9100,3744.1500) and (2364.3900,3740.4300) ..
      (2373.3100,3722.0900) .. controls (2380.5900,3707.1100) and
      (2383.8000,3673.8700) .. (2401.6200,3673.8700) .. controls
      (2419.4300,3673.8700) and (2468.1900,3691.6800) .. (2468.1900,3691.6800) ..
      controls (2451.9300,3675.9600) and (2444.6000,3517.1200) ..
      (2418.3900,3517.1200) .. controls (2400.6300,3517.1200) and
      (2355.5100,3515.8100) .. (2355.5100,3515.8100) .. controls
      (2355.5100,3515.8100) and (2335.7800,3484.5600) .. (2319.8400,3422.2400) --
      (2358.6300,3444.7800) -- (2347.1000,3383.4400) -- (2394.2800,3418.5600) --
      (2413.6700,3358.2800) -- (2430.9800,3386.5900) .. controls
      (2430.9800,3386.5900) and (2426.6800,3400.0800) .. (2440.9400,3419.0900) ..
      controls (2453.5200,3435.8600) and (2472.9100,3463.6500) ..
      (2472.9100,3463.6500) -- (2497.0300,3457.3600) .. controls
      (2497.0300,3457.3600) and (2510.1200,3475.7100) .. (2506.4600,3494.0500) --
      (2513.3600,3495.7600) -- (2520.8400,3512.1800) -- (2531.6800,3541.4800) ..
      controls (2535.4700,3550.5400) and (2576.3900,3656.5500) ..
      (2588.7100,3688.6000) .. controls (2590.9400,3694.4100) and
      (2598.2500,3713.4900) .. (2596.2500,3723.0500) .. controls
      (2595.1400,3728.4000) and (2593.7400,3735.0400) .. (2593.7400,3745.1700) ..
      controls (2593.7400,3755.0400) and (2602.1700,3773.4900) ..
      (2618.5500,3789.2900) .. controls (2618.5400,3789.0100) and
      (2618.5400,3788.7500) .. (2618.5400,3788.4600) .. controls
      (2618.5400,3777.2100) and (2626.7400,3774.2400) .. (2631.0600,3774.2400) ..
      controls (2635.4300,3774.2400) and (2638.4800,3776.3800) ..
      (2641.1700,3778.2800) .. controls (2645.6800,3781.4600) and
      (2654.1000,3787.3800) .. (2671.3900,3787.3800) .. controls
      (2673.5800,3787.3800) and (2675.6100,3787.3200) .. (2677.4600,3787.1600) ..
      controls (2660.3900,3780.5700) and (2639.5900,3759.9000) ..
      (2639.5900,3720.8900) .. controls (2639.5900,3693.4800) and
      (2651.0400,3662.8200) .. (2659.3900,3640.4500) .. controls
      (2661.8000,3634.0200) and (2664.6500,3626.3800) .. (2665.9200,3621.8600) ..
      controls (2664.5900,3620.8200) and (2663.0700,3619.6400) ..
      (2661.7000,3618.5800) .. controls (2644.4500,3605.3100) and
      (2627.1100,3591.1700) .. (2621.1900,3577.0900) .. controls
      (2621.0700,3576.8200) and (2620.9600,3576.5600) .. (2620.8400,3576.2900) ..
      controls (2594.4100,3572.0900) and (2567.7900,3569.0200) ..
      (2567.7900,3569.0200) -- (2527.8500,3497.3200) -- (2553.1100,3505.5900) --
      (2529.0000,3452.1200) -- (2577.2300,3472.0400) .. controls
      (2577.2300,3472.0400) and (2566.2200,3435.3400) .. (2577.2300,3421.7200) ..
      controls (2578.7500,3422.9000) and (2594.4100,3433.8300) ..
      (2594.4100,3433.8300) .. controls (2594.4100,3433.8300) and
      (2602.6100,3453.2900) .. (2607.7300,3458.4100) .. controls
      (2612.8500,3463.5300) and (2642.7500,3494.0500) .. (2642.7500,3494.0500) --
      (2650.1000,3475.7100) .. controls (2686.3500,3493.7500) and
      (2753.0300,3579.1200) .. (2754.9400,3594.1800) .. controls
      (2754.9400,3608.8600) and (2728.7300,3631.9300) .. (2728.7300,3666.0100) ..
      controls (2728.7300,3685.9200) and (2736.6000,3693.7900) ..
      (2736.6000,3693.7900) .. controls (2736.6000,3669.6700) and
      (2794.2600,3615.1500) .. (2799.4900,3599.9500) .. controls
      (2786.3900,3592.6000) and (2761.2300,3517.1200) .. (2758.0900,3506.6400) ..
      controls (2747.5800,3506.9300) and (2692.7300,3494.2500) ..
      (2692.7300,3494.2500) .. controls (2692.7300,3494.2500) and
      (2660.9900,3460.4500) .. (2652.1900,3420.1400) -- (2696.2300,3429.0500) --
      (2688.6300,3377.5000) -- (2708.1000,3381.6000) .. controls
      (2708.1000,3381.6000) and (2726.5200,3412.3200) .. (2757.0300,3413.8500) --
      (2784.3000,3368.7600) -- (2802.6500,3389.2100) .. controls
      (2802.6500,3389.2100) and (2804.7500,3447.4000) .. (2814.7100,3454.2200) --
      (2836.2000,3445.8300) .. controls (2895.5100,3489.1300) and
      (2903.6100,3645.0600) .. (2895.5100,3649.9300) .. controls
      (2890.3900,3653.0000) and (2888.3400,3646.8600) .. (2872.9800,3666.3100) ..
      controls (2847.8300,3698.1500) and (2851.7300,3770.0200) ..
      (2827.9100,3795.3600) .. controls (2827.9100,3795.3600) and
      (2830.4300,3797.5800) .. (2841.4500,3797.5800) .. controls
      (2852.4500,3797.5800) and (2894.5300,3812.7800) .. (2894.9100,3862.5800) ..
      controls (2895.3900,3924.7000) and (2844.1400,3946.9100) ..
      (2844.1400,3946.9100) .. controls (2844.1400,3946.9100) and
      (2849.8200,3957.0300) .. (2849.8200,3971.6200) .. controls
      (2849.8200,4017.7500) and (2798.8700,4017.8200) .. (2797.9300,4024.5700) ..
      controls (2822.5700,4029.8000) and (2848.3300,4058.2100) ..
      (2850.3500,4079.0800) .. controls (2856.0900,4138.2600) and
      (2789.8500,4171.6600) .. (2761.7600,4143.5600) .. controls
      (2770.6600,4135.7100) and (2792.1700,4126.7800) .. (2792.1700,4104.7800) ..
      controls (2792.1700,4067.0200) and (2750.7400,4047.6300) ..
      (2750.7400,4047.6300) .. controls (2750.7400,4047.6300) and
      (2758.0900,4062.3100) .. (2758.0900,4080.6600) .. controls
      (2758.0900,4099.0000) and (2747.6200,4130.4600) .. (2707.7700,4130.4600) ..
      controls (2657.9700,4130.4600) and (2645.9100,4086.9400) ..
      (2645.9100,4086.9400) .. controls (2658.4900,4086.9400) and
      (2697.8100,4091.1400) .. (2697.8100,4067.5500) .. controls
      (2697.8100,4037.6700) and (2647.4800,4019.8500) .. (2647.4800,3970.5700) ..
      controls (2647.4800,3921.2900) and (2690.5800,3885.2300) ..
      (2739.2200,3881.9800) .. controls (2752.1900,3881.1100) and
      (2754.4500,3880.2700) .. (2763.8400,3880.2700) .. controls
      (2773.2300,3880.2700) and (2779.2200,3868.8700) .. (2799.5100,3868.8700) ..
      controls (2824.6700,3868.8700) and (2830.4400,3880.4100) ..
      (2838.8300,3880.4100) .. controls (2847.2100,3880.4100) and
      (2847.2100,3872.0100) .. (2847.2100,3867.3000) .. controls
      (2847.2100,3862.5800) and (2848.7800,3850.0000) .. (2817.8500,3850.0000) ..
      controls (2784.8200,3850.0000) and (2725.5900,3866.7700) ..
      (2672.1200,3866.7700) .. controls (2630.1000,3866.7700) and
      (2624.4100,3865.9900) .. (2622.0700,3862.9400) .. controls
      (2624.6700,3867.8300) and (2631.1400,3881.0300) .. (2631.1400,3891.7400) ..
      controls (2621.2500,3896.7900) and (2612.8800,3924.4400) ..
      (2607.6400,3924.4400) .. controls (2652.7900,3965.3600) and
      (2646.2300,4001.2700) .. (2646.6400,4009.4000) .. controls
      (2643.5700,4019.6400) and (2636.9900,4021.4200) .. (2625.9900,4021.4200) ..
      controls (2614.9800,4021.4200) and (2608.6900,4016.7000) ..
      (2608.6900,4016.7000) .. controls (2608.6900,4016.7000) and
      (2605.8200,4055.6900) .. (2599.5300,4068.8000) .. controls
      (2584.9300,4090.8200) and (2513.5100,4105.6700) .. (2485.8600,4063.6800) ..
      controls (2485.8600,4063.6800) and (2475.5300,4038.2000) ..
      (2471.3500,4030.3300) .. controls (2448.9800,4039.1000) and
      (2436.7000,4027.8400) .. (2436.7000,4027.8400) .. controls
      (2436.7000,4027.8400) and (2437.5600,4016.5900) .. (2437.7800,4008.3100) ..
      controls (2437.9700,4001.5000) and (2436.2100,3990.4800) ..
      (2436.2100,3981.0500) .. controls (2436.2100,3971.6200) and
      (2455.6100,3937.0200) .. (2455.6100,3937.0200) .. controls
      (2444.6300,3920.8300) and (2406.9200,3902.9600) .. (2406.9200,3902.9600) ..
      controls (2420.8100,3889.0800) and (2432.0500,3859.9900) ..
      (2432.0500,3859.9900);
    \path[fill=cf9ae0c,nonzero rule] (2754.1800,3494.5900) .. controls
      (2729.0200,3489.9500) and (2695.4700,3482.3000) .. (2695.4700,3482.3000) --
      (2666.8400,3435.0000) -- (2700.9700,3442.1800) .. controls
      (2704.0400,3458.4500) and (2705.8600,3467.5600) .. (2713.2100,3474.1100) ..
      controls (2727.3600,3486.7200) and (2749.6900,3487.4000) ..
      (2754.1800,3494.5900) -- cycle(2396.4300,3947.9500) .. controls
      (2401.8800,3957.5000) and (2423.0400,3961.6100) .. (2422.3600,3970.4800) ..
      controls (2421.6800,3979.3600) and (2397.1100,4034.6600) ..
      (2396.4300,4048.3200) -- (2380.7100,4019.6400) .. controls
      (2380.7100,4019.6400) and (2403.9300,3986.8700) .. (2403.9300,3975.9400) ..
      controls (2403.9300,3965.0100) and (2395.0600,3962.2900) ..
      (2396.4300,3947.9500) -- cycle(2332.6600,3865.6800) .. controls
      (2332.1900,3844.3000) and (2359.8600,3834.9700) .. (2361.6100,3824.4400) ..
      controls (2363.3700,3813.9200) and (2340.1200,3831.1200) ..
      (2340.5500,3827.9500) .. controls (2344.4500,3798.5600) and
      (2368.7400,3795.5700) .. (2377.4000,3779.6800) .. controls
      (2382.6800,3770.0400) and (2354.9600,3783.4600) .. (2355.4700,3780.5700) ..
      controls (2361.4100,3746.2300) and (2397.3200,3759.1900) ..
      (2403.7300,3736.6900) .. controls (2407.2900,3724.1400) and
      (2381.2900,3743.8200) .. (2380.4900,3732.7800) .. controls
      (2379.9400,3725.4400) and (2394.0800,3686.6600) .. (2401.9700,3684.9100) ..
      controls (2409.8700,3683.1500) and (2435.3300,3692.8100) ..
      (2446.7400,3697.1900) .. controls (2458.1300,3701.5800) and
      (2480.0700,3705.9700) .. (2482.7100,3716.5000) .. controls
      (2470.4300,3735.8100) and (2437.9500,3780.5700) .. (2433.5600,3821.8000) ..
      controls (2408.1300,3849.0100) and (2382.6800,3888.5000) ..
      (2382.6800,3920.9700) .. controls (2382.6800,3953.4500) and
      (2392.3200,3979.7700) .. (2392.3200,3979.7700) -- (2356.3500,4047.3400) --
      (2349.3300,4016.6400) .. controls (2349.3300,4016.6400) and
      (2382.6600,3985.0300) .. (2381.7900,3974.5100) .. controls
      (2380.9200,3963.9800) and (2372.1500,3931.5000) .. (2372.1500,3931.5000) ..
      controls (2366.0000,3922.7300) and (2367.7500,3973.6300) ..
      (2367.7500,3973.6300) -- (2329.1400,4022.7800) .. controls
      (2329.1400,4022.7800) and (2327.3600,3990.3500) .. (2329.5300,3980.3800) ..
      controls (2333.6500,3961.4400) and (2351.0700,3952.5600) ..
      (2351.0700,3941.1600) .. controls (2351.0700,3929.7600) and
      (2336.1600,3910.4400) .. (2328.2600,3906.0600) .. controls
      (2326.5000,3892.0200) and (2353.7100,3877.9700) .. (2354.5900,3865.6800) ..
      controls (2347.5700,3857.8000) and (2332.7700,3871.2400) ..
      (2332.6600,3865.6800) -- cycle(2374.2200,3490.1600) .. controls
      (2374.2200,3490.1600) and (2397.7700,3495.8700) .. (2416.2100,3505.5200) ..
      controls (2396.7600,3503.4700) and (2364.3300,3503.4700) ..
      (2364.3300,3503.4700) -- (2335.8600,3443.8600) -- (2363.9500,3459.6700) ..
      controls (2363.9500,3459.6700) and (2363.6900,3486.6600) ..
      (2374.2200,3490.1600) -- cycle(2578.0300,3545.1300) .. controls
      (2585.9300,3552.1400) and (2602.9400,3555.0300) .. (2612.6000,3564.6800) ..
      controls (2591.6900,3559.4600) and (2571.8800,3554.6800) ..
      (2571.8800,3554.6800) -- (2547.3000,3516.7900) -- (2566.7600,3524.9800) ..
      controls (2566.7600,3524.9800) and (2570.1300,3538.1000) ..
      (2578.0300,3545.1300) -- cycle(2661.7400,3530.4500) .. controls
      (2667.8700,3538.3500) and (2677.5400,3511.1500) .. (2677.5400,3511.1500) ..
      controls (2702.1100,3533.0900) and (2674.9400,3544.9700) ..
      (2682.8000,3551.5200) .. controls (2693.3300,3560.3000) and
      (2710.8800,3546.2500) .. (2710.8800,3546.2500) .. controls
      (2724.0400,3557.6700) and (2703.4600,3569.5600) .. (2709.1300,3576.9700) ..
      controls (2720.5400,3591.8800) and (2724.0400,3577.8400) ..
      (2731.9500,3581.3500) .. controls (2739.8400,3584.8700) and
      (2748.6100,3591.8800) .. (2739.8400,3603.3000) .. controls
      (2731.0600,3614.7000) and (2702.9800,3664.7300) .. (2727.5600,3701.5800) ..
      controls (2727.5600,3701.5800) and (2711.7500,3696.3200) ..
      (2708.2400,3683.1500) .. controls (2704.7500,3669.9900) and
      (2717.9100,3603.3000) .. (2717.9100,3593.6400) -- (2645.9400,3532.2100) ..
      controls (2645.9400,3532.2100) and (2640.6800,3537.4800) ..
      (2650.3300,3549.7700) .. controls (2659.9800,3562.0500) and
      (2705.6200,3599.7900) .. (2705.6200,3599.7900) .. controls
      (2694.2200,3614.7000) and (2710.8800,3652.4400) .. (2688.0700,3666.4800) ..
      controls (2681.9100,3669.1100) and (2664.7300,3674.3100) ..
      (2679.2900,3684.9100) .. controls (2688.9400,3691.9300) and
      (2704.7500,3688.4200) .. (2704.7500,3720.0100) .. controls
      (2704.7500,3751.6100) and (2675.7800,3754.2300) .. (2675.7800,3754.2300) ..
      controls (2679.2900,3763.8900) and (2704.7300,3761.2500) ..
      (2711.7600,3770.9100) .. controls (2698.5900,3777.0600) and
      (2698.5900,3777.9200) .. (2688.9400,3777.9200) .. controls
      (2679.2900,3777.9200) and (2651.2100,3763.8900) .. (2651.2100,3720.8900) ..
      controls (2651.2100,3677.8900) and (2683.2400,3622.1700) ..
      (2677.5400,3616.4600) .. controls (2671.8400,3610.7500) and
      (2638.9200,3589.2600) .. (2631.8900,3572.5800) .. controls
      (2624.8800,3555.9100) and (2586.2200,3531.1200) .. (2586.2200,3531.1200) --
      (2549.4100,3470.7800) -- (2573.9800,3484.8300) .. controls
      (2573.9800,3484.8300) and (2583.0100,3514.2400) .. (2597.4800,3522.9300) ..
      controls (2617.9700,3535.2200) and (2636.9800,3557.0900) ..
      (2640.1100,3553.8000) .. controls (2643.2400,3550.4900) and
      (2623.9900,3524.3200) .. (2603.8100,3513.7800) .. controls
      (2597.6800,3501.4900) and (2582.7400,3456.7400) .. (2584.5100,3447.0900) ..
      controls (2584.5100,3447.0900) and (2628.3900,3499.7400) ..
      (2640.6700,3505.0100) .. controls (2652.9700,3510.2700) and
      (2657.3400,3494.4800) .. (2657.3400,3494.4800) .. controls
      (2674.0200,3506.7700) and (2655.5900,3522.5500) .. (2661.7400,3530.4500) --
      cycle(2707.4600,3932.5400) .. controls (2713.7900,3921.1500) and
      (2765.6000,3924.3600) .. (2765.6000,3972.6700) .. controls
      (2765.6000,3998.0600) and (2744.2200,4003.4600) .. (2744.2200,4010.4800) ..
      controls (2744.2200,4028.0400) and (2839.0000,4035.0600) ..
      (2839.0000,4080.6900) .. controls (2839.0000,4104.3900) and
      (2831.9800,4115.8000) .. (2831.9800,4115.8000) .. controls
      (2831.9800,4115.8000) and (2833.7500,4079.8100) .. (2822.3300,4079.8100) ..
      controls (2804.7900,4079.8100) and (2820.5900,4100.8700) ..
      (2820.5900,4111.4200) .. controls (2820.5900,4150.0300) and
      (2779.3400,4141.2500) .. (2779.3400,4141.2500) .. controls
      (2779.3400,4141.2500) and (2803.9100,4140.3600) .. (2803.9100,4101.7600) ..
      controls (2803.9100,4052.6100) and (2731.9500,4022.7800) ..
      (2726.6800,4028.0400) .. controls (2721.4200,4033.3000) and
      (2746.0000,4049.9800) .. (2746.0000,4077.1800) .. controls
      (2746.0000,4090.3400) and (2740.7200,4118.4200) .. (2712.6400,4118.4200) ..
      controls (2679.2900,4118.4200) and (2657.3400,4095.6100) ..
      (2670.5100,4097.3600) .. controls (2683.6700,4099.1300) and
      (2710.0000,4090.3500) .. (2710.0000,4067.5300) .. controls
      (2710.0000,4028.9100) and (2659.1000,4019.2700) .. (2659.1000,3970.1100) ..
      controls (2659.1000,3908.6800) and (2721.4200,3893.7600) ..
      (2740.7200,3893.7600) .. controls (2760.0300,3893.7600) and
      (2764.4100,3896.4100) .. (2764.4100,3896.4100) .. controls
      (2760.0300,3902.5500) and (2760.9000,3915.7000) .. (2760.9000,3915.7000) ..
      controls (2760.9000,3915.7000) and (2750.3700,3912.2000) ..
      (2738.0900,3912.2000) .. controls (2690.7000,3912.2000) and
      (2685.4300,3948.1700) .. (2685.4300,3960.4600) .. controls
      (2685.4300,3972.7500) and (2697.8300,3996.7500) .. (2717.0200,3994.6900) ..
      controls (2757.3400,3990.3600) and (2733.0900,3946.0500) ..
      (2707.4600,3932.5400) -- cycle(2770.1000,3914.5300) .. controls
      (2770.1000,3900.4900) and (2777.0700,3880.1400) .. (2798.7700,3880.1400) ..
      controls (2823.8300,3880.1400) and (2824.8000,3891.9600) ..
      (2838.8500,3891.9600) .. controls (2852.8900,3891.9600) and
      (2859.3400,3880.5500) .. (2859.3400,3867.3800) .. controls
      (2859.3400,3854.2200) and (2852.5000,3838.7000) .. (2818.3700,3838.7000) ..
      controls (2757.8100,3838.7000) and (2741.8900,3855.1600) ..
      (2669.6300,3855.1600) .. controls (2601.2500,3855.1600) and
      (2606.8800,3827.9600) .. (2563.0100,3784.0900) .. controls
      (2519.1300,3740.2100) and (2484.4700,3707.7200) .. (2484.4700,3707.7200) --
      (2487.1100,3700.7000) .. controls (2466.0400,3678.7600) and
      (2455.5100,3570.8300) .. (2444.9800,3533.0900) .. controls
      (2434.4500,3495.3500) and (2376.5200,3479.5600) .. (2376.5200,3479.5600) --
      (2363.3700,3406.7200) -- (2391.4500,3431.2900) .. controls
      (2391.4500,3431.2900) and (2389.6900,3436.5600) .. (2388.8100,3452.3500) ..
      controls (2387.9500,3468.1500) and (2431.8200,3500.6200) ..
      (2452.8700,3513.7800) .. controls (2449.3600,3493.6000) and
      (2400.2100,3454.1100) .. (2400.2100,3454.1100) .. controls
      (2400.2100,3454.1100) and (2404.6100,3440.9500) .. (2405.4900,3426.0200) ..
      controls (2406.3700,3411.1000) and (2416.8900,3383.9000) ..
      (2416.8900,3383.9000) -- (2419.5900,3388.2900) .. controls
      (2419.5900,3388.2900) and (2421.3100,3405.0900) .. (2424.4100,3411.3000) ..
      controls (2431.4300,3425.3400) and (2467.7900,3474.2900) ..
      (2467.7900,3474.2900) -- (2491.4800,3470.7800) .. controls
      (2503.7700,3490.0900) and (2487.1100,3508.5100) .. (2482.7100,3519.9200) ..
      controls (2492.3600,3529.5800) and (2497.6400,3524.3100) ..
      (2509.0400,3513.7800) .. controls (2517.8200,3534.8500) and
      (2509.9200,3536.6000) .. (2502.8900,3553.2700) .. controls
      (2495.8800,3569.9400) and (2509.0400,3566.4400) .. (2527.4600,3556.7800) ..
      controls (2534.4800,3568.1800) and (2532.7300,3577.8500) ..
      (2522.2100,3601.5400) .. controls (2511.6800,3625.2300) and
      (2534.4900,3613.8200) .. (2545.0200,3605.9300) .. controls
      (2552.9200,3618.2000) and (2549.4100,3620.8400) .. (2539.7600,3645.4200) ..
      controls (2530.1100,3669.9900) and (2545.0200,3666.4800) ..
      (2561.7000,3654.2000) .. controls (2572.2400,3682.2800) and
      (2563.4600,3677.0200) .. (2556.4400,3695.4300) .. controls
      (2549.4100,3713.8700) and (2566.9600,3712.1100) .. (2580.1300,3700.7000) ..
      controls (2592.4100,3712.1100) and (2582.1300,3716.2100) ..
      (2582.1300,3745.1700) .. controls (2582.1300,3766.3400) and
      (2606.8800,3806.6800) .. (2649.8700,3822.4800) .. controls
      (2664.7900,3807.5600) and (2630.1500,3805.1300) .. (2630.1500,3788.4700) ..
      controls (2630.1500,3778.8100) and (2637.1700,3798.9900) ..
      (2671.3900,3798.9900) .. controls (2705.6300,3798.9900) and
      (2707.3700,3782.3200) .. (2716.1500,3782.3200) .. controls
      (2724.9100,3782.3200) and (2717.0200,3806.8900) .. (2717.0200,3806.8900) ..
      controls (2757.3900,3806.8900) and (2743.3600,3767.4000) ..
      (2743.3600,3718.2500) .. controls (2743.3600,3669.1100) and
      (2810.9200,3622.6000) .. (2812.6800,3595.4000) .. controls
      (2788.3000,3580.7800) and (2781.8200,3518.8600) .. (2759.6500,3485.0300) ..
      controls (2747.3600,3471.3900) and (2732.3400,3470.0100) ..
      (2717.0200,3463.7600) -- (2702.1100,3401.4500) .. controls
      (2714.3900,3414.6100) and (2746.0000,3423.3900) .. (2746.0000,3423.3900) ..
      controls (2731.0600,3453.2300) and (2750.3700,3461.1300) ..
      (2758.2600,3468.1500) .. controls (2766.1700,3475.1700) and
      (2799.5100,3518.1700) .. (2799.5100,3518.1700) -- (2804.7900,3512.9100) ..
      controls (2804.7900,3512.9100) and (2788.1100,3465.5200) ..
      (2761.7800,3453.2300) .. controls (2754.7700,3438.3100) and
      (2779.3300,3398.8200) .. (2785.4700,3389.1700) .. controls
      (2787.9800,3392.8100) and (2791.1500,3395.6400) .. (2791.1500,3395.6400) ..
      controls (2791.1500,3395.6400) and (2793.8700,3448.5800) ..
      (2802.1500,3457.6200) .. controls (2811.8000,3468.1500) and
      (2814.4300,3467.2800) .. (2832.8700,3460.2500) .. controls
      (2840.7600,3468.1500) and (2836.3700,3489.2100) .. (2829.3600,3502.3800) ..
      controls (2837.2500,3517.2900) and (2849.5400,3487.7900) ..
      (2853.4500,3493.0500) .. controls (2867.4600,3511.9200) and
      (2840.7600,3526.9500) .. (2849.5400,3545.3800) .. controls
      (2849.5400,3545.3800) and (2864.3200,3531.5000) .. (2867.9700,3533.9700) ..
      controls (2871.6100,3536.4400) and (2869.7300,3547.1200) ..
      (2866.2100,3556.7800) .. controls (2847.8900,3600.5700) and
      (2875.5300,3571.6300) .. (2878.5000,3573.4600) .. controls
      (2884.5900,3577.2200) and (2877.6700,3605.4200) .. (2869.7700,3612.4400) ..
      controls (2865.3800,3600.1600) and (2839.0000,3552.3900) ..
      (2824.9600,3519.0500) .. controls (2822.5200,3513.2100) and
      (2809.1700,3511.1500) .. (2827.6000,3568.1900) .. controls
      (2849.5300,3636.0600) and (2874.1100,3625.2300) .. (2884.6400,3621.7300) ..
      controls (2883.7600,3653.3200) and (2852.1700,3655.9500) ..
      (2849.5400,3677.0200) .. controls (2817.9400,3690.1700) and
      (2844.2800,3798.1200) .. (2779.3300,3824.4400) -- (2860.9500,3830.5900) ..
      controls (2845.1600,3814.7900) and (2814.4300,3820.0600) ..
      (2814.4300,3820.0600) .. controls (2814.4300,3820.0600) and
      (2814.4300,3810.4000) .. (2839.0000,3810.4000) .. controls
      (2863.5800,3810.4000) and (2883.2200,3833.2500) .. (2883.2200,3863.9700) ..
      controls (2883.2200,3886.6300) and (2855.8100,3935.8100) ..
      (2829.6200,3935.8100) .. controls (2807.9100,3935.8100) and
      (2798.8600,3902.4900) .. (2793.7300,3905.0500) .. controls
      (2780.7800,3911.5400) and (2789.8200,3917.3100) .. (2794.5900,3925.5500) ..
      controls (2811.1900,3954.2400) and (2838.7600,3947.7600) ..
      (2838.8500,3971.1600) .. controls (2839.0100,4015.2500) and
      (2782.3000,4016.8700) .. (2774.1800,4008.7300) .. controls
      (2767.4400,4001.9900) and (2800.2300,4008.2800) .. (2799.5500,3980.7100) ..
      controls (2799.4200,3975.5100) and (2815.9400,3995.1400) ..
      (2815.9400,3993.6600) .. controls (2815.9400,3973.3000) and
      (2770.1000,3957.8400) .. (2770.1000,3914.5300) -- cycle(2462.7200,3987.2500)
      .. controls (2462.7200,4003.0500) and (2474.4000,4004.4100) ..
      (2477.8300,4004.4100) .. controls (2486.7600,4004.4100) and
      (2486.0700,3977.6300) .. (2490.2000,3971.4600) .. controls
      (2494.3200,3965.2800) and (2505.9800,3968.0200) .. (2508.0500,3963.9000) ..
      controls (2504.6100,3958.4200) and (2492.9300,3951.5400) ..
      (2492.9300,3943.3100) .. controls (2492.9300,3935.0700) and
      (2500.4900,3932.3100) .. (2503.9300,3932.3100) .. controls
      (2508.7300,3932.3100) and (2529.3300,3937.8200) .. (2529.3300,3950.1800) ..
      controls (2529.3300,3956.3500) and (2524.6100,3959.6900) ..
      (2522.4600,3963.9000) .. controls (2520.3100,3968.1100) and
      (2520.7400,3973.1800) .. (2519.0200,3974.2100) .. controls
      (2527.2700,3974.8900) and (2535.5100,3977.6300) .. (2541.6800,3977.6300) ..
      controls (2547.8700,3977.6300) and (2548.5500,3973.5200) ..
      (2548.5500,3968.0200) .. controls (2548.5500,3962.5200) and
      (2536.8800,3958.4200) .. (2536.8800,3952.9200) .. controls
      (2536.8800,3947.4200) and (2551.9900,3933.0100) .. (2556.8000,3933.0100) ..
      controls (2561.6000,3933.0100) and (2572.5800,3937.1300) ..
      (2572.5800,3944.6900) .. controls (2572.5800,3952.2400) and
      (2568.1300,3961.5000) .. (2572.5800,3965.9700) .. controls
      (2575.3300,3968.7200) and (2581.5000,3963.2200) .. (2581.5000,3963.2200) ..
      controls (2590.7700,3972.4900) and (2596.6100,3991.3700) ..
      (2615.1600,3993.4300) .. controls (2633.6900,3961.1600) and
      (2595.2300,3948.8000) .. (2595.2300,3948.8000) -- (2580.1400,3954.9800) ..
      controls (2586.0200,3936.3200) and (2570.0100,3929.9800) ..
      (2570.5300,3922.7100) .. controls (2571.9900,3901.9100) and
      (2567.7700,3895.3600) .. (2560.2200,3888.3700) .. controls
      (2555.4300,3889.7500) and (2545.1200,3890.4400) .. (2544.4300,3886.3200) ..
      controls (2554.0400,3869.1600) and (2525.2100,3850.6200) ..
      (2528.6300,3843.0600) .. controls (2524.5200,3845.8100) and
      (2514.9000,3866.4100) .. (2511.4700,3870.5300) .. controls
      (2508.0500,3874.6400) and (2514.4500,3880.6400) .. (2510.8000,3890.4400) ..
      controls (2508.7300,3895.9200) and (2496.3700,3889.7500) ..
      (2495.0000,3899.3700) .. controls (2493.6200,3908.9800) and
      (2496.7900,3929.0700) .. (2485.1200,3935.9400) .. controls
      (2485.1200,3955.8500) and (2462.7200,3968.7200) .. (2462.7200,3987.2500) --
      cycle(2530.6800,4025.0200) -- (2532.7500,4020.2100) .. controls
      (2527.9500,4018.8400) and (2527.2700,3992.7400) .. (2514.9000,3992.7400) ..
      controls (2499.7900,3992.7400) and (2511.4600,4011.2800) ..
      (2499.7900,4014.7100) .. controls (2499.7900,4014.7100) and
      (2521.7600,4016.7800) .. (2530.6800,4025.0200) -- cycle(2547.8500,4022.9500)
      .. controls (2553.3400,4015.4000) and (2566.4100,4005.7900) ..
      (2576.0100,4014.0200) .. controls (2580.1300,4012.6600) and
      (2581.4800,4011.2800) .. (2576.6900,4005.7800) .. controls
      (2571.8900,4000.2900) and (2571.8600,3986.4500) .. (2562.2800,3987.2500) ..
      controls (2545.7900,3988.6300) and (2552.6600,4012.6600) ..
      (2546.4800,4018.1500) -- (2547.8500,4022.9500) -- cycle(2444.8200,3868.2400)
      .. controls (2449.5900,3872.1300) and (2462.7500,3892.4900) ..
      (2475.4000,3892.4900) .. controls (2474.3400,3885.1100) and
      (2455.3600,3869.3000) .. (2449.0400,3856.6400) .. controls
      (2442.7200,3844.0000) and (2453.2600,3831.3400) .. (2458.5400,3821.8500) ..
      controls (2457.4800,3830.2900) and (2477.5100,3844.0000) ..
      (2483.8300,3851.3800) .. controls (2490.1600,3858.7500) and
      (2495.3500,3856.2500) .. (2491.2100,3847.1500) .. controls
      (2485.9400,3835.5600) and (2469.3800,3823.4800) .. (2469.0800,3806.0400) ..
      controls (2468.9100,3796.7100) and (2476.0700,3790.1000) ..
      (2484.8800,3784.9500) .. controls (2484.8800,3784.9500) and
      (2488.0500,3815.5300) .. (2500.6900,3807.1000) .. controls
      (2505.8200,3803.6900) and (2480.6600,3756.4900) .. (2500.6900,3738.5700) ..
      controls (2503.8700,3752.2800) and (2534.4300,3775.4600) ..
      (2534.4300,3781.8000) .. controls (2534.4300,3788.1200) and
      (2523.8900,3809.2000) .. (2534.4300,3809.2000) .. controls
      (2540.7600,3809.2000) and (2546.0400,3790.2300) .. (2550.2400,3790.2300) ..
      controls (2554.4600,3790.2300) and (2562.8900,3794.4400) ..
      (2562.8900,3801.8300) .. controls (2562.8900,3809.2100) and
      (2543.9300,3840.8300) .. (2555.5200,3840.8300) .. controls
      (2560.9000,3840.8300) and (2573.4400,3819.7500) .. (2576.6000,3819.7500) ..
      controls (2579.7700,3819.7500) and (2582.9300,3821.8500) ..
      (2586.0900,3838.7200) .. controls (2589.2600,3855.5900) and
      (2571.3300,3861.9200) .. (2577.6600,3878.7900) .. controls
      (2577.6600,3878.7900) and (2594.5300,3870.3500) .. (2599.7900,3860.8700) ..
      controls (2605.0800,3851.3800) and (2615.6100,3877.7300) ..
      (2616.6600,3886.1700) .. controls (2613.4000,3889.9900) and
      (2609.6900,3903.4600) .. (2604.0100,3911.4600) .. controls
      (2598.7300,3918.9400) and (2591.3700,3921.0300) .. (2591.3700,3923.0700) ..
      controls (2591.3700,3927.2800) and (2597.6900,3928.3300) ..
      (2618.7800,3951.5300) .. controls (2639.8600,3974.7200) and
      (2636.6500,4001.2900) .. (2636.7000,4005.3000) .. controls
      (2624.0500,4016.8900) and (2613.5100,4000.0200) .. (2602.9700,4005.3000) ..
      controls (2592.4200,4010.5700) and (2597.6900,4043.2500) ..
      (2594.5300,4054.8500) .. controls (2594.5300,4054.8500) and
      (2580.8200,4032.7000) .. (2577.6600,4035.8600) .. controls
      (2574.5000,4039.0400) and (2578.7100,4048.5300) .. (2581.8800,4059.0600) ..
      controls (2585.0400,4069.6000) and (2567.1200,4074.8800) ..
      (2567.1200,4074.8800) .. controls (2567.1200,4074.8800) and
      (2562.8900,4052.7300) .. (2555.5200,4053.7900) .. controls
      (2548.1400,4054.8500) and (2550.2400,4075.9400) .. (2550.2400,4075.9400) ..
      controls (2550.2400,4075.9400) and (2535.4900,4084.3700) ..
      (2532.3200,4066.4500) .. controls (2528.5900,4045.2700) and
      (2518.6100,4063.2800) .. (2513.3600,4072.7700) .. controls
      (2505.9700,4069.6000) and (2509.1200,4045.3600) .. (2509.1200,4036.9200) ..
      controls (2509.1200,4028.4900) and (2494.3800,4044.3000) ..
      (2487.0000,4047.4700) .. controls (2489.1000,4040.0800) and
      (2480.7300,4029.1000) .. (2480.7300,4020.6700) .. controls
      (2480.7300,4012.2300) and (2453.2600,4025.2900) .. (2446.9300,4018.9500) ..
      controls (2446.8800,4015.6600) and (2443.0100,3988.9900) ..
      (2448.3000,3973.8900) .. controls (2455.1200,3954.4800) and
      (2466.0500,3945.8900) .. (2466.0500,3934.3000) .. controls
      (2466.0500,3923.5400) and (2449.2600,3918.1800) .. (2418.8300,3899.0000) ..
      controls (2432.7100,3897.0200) and (2433.2300,3858.7500) ..
      (2444.8200,3868.2400);
    \path[fill=c231f20,nonzero rule] (2421.4500,4881.5500) .. controls
      (2420.3900,4864.2100) and (2409.7500,4879.3900) .. (2409.7500,4879.3900) ..
      controls (2409.7500,4879.3900) and (2382.7600,4905.5400) ..
      (2382.7600,4943.1600) .. controls (2390.6100,4947.8500) and
      (2394.2600,4964.5700) .. (2397.3900,4966.1300) .. controls
      (2400.5300,4967.7100) and (2422.4600,4978.1500) .. (2422.4600,4989.1200) ..
      controls (2422.4600,5000.0900) and (2391.6400,5067.9900) ..
      (2391.6400,5093.5900) -- (2365.5300,5057.0200) -- (2345.1600,5092.5400) --
      (2328.9600,5050.2300) -- (2312.2500,5070.0800) .. controls
      (2312.2500,5070.0800) and (2304.1300,5008.8000) .. (2307.0800,4997.7500) ..
      controls (2315.0700,4967.8100) and (2328.4400,4971.3600) ..
      (2328.4400,4960.9100) .. controls (2328.4400,4944.7200) and
      (2300.0600,4932.7800) .. (2300.0600,4932.7800) .. controls
      (2303.3200,4924.1600) and (2319.4400,4846.4800) .. (2331.1700,4808.9800) ..
      controls (2344.5800,4766.1200) and (2354.0400,4762.4200) ..
      (2362.9200,4744.1400) .. controls (2370.1700,4729.2200) and
      (2373.3700,4696.0900) .. (2391.1200,4696.0900) .. controls
      (2408.8900,4696.0900) and (2457.4600,4713.8400) .. (2457.4600,4713.8400) ..
      controls (2441.2700,4698.1800) and (2433.9500,4539.9100) ..
      (2407.8300,4539.9100) .. controls (2390.1400,4539.9100) and
      (2345.1800,4538.6000) .. (2345.1800,4538.6000) .. controls
      (2345.1800,4538.6000) and (2325.5300,4507.4600) .. (2309.6400,4445.3700) --
      (2348.2800,4467.8200) -- (2336.8000,4406.7100) -- (2383.8100,4441.7000) --
      (2403.1400,4381.6400) -- (2420.3700,4409.8500) .. controls
      (2420.3700,4409.8500) and (2416.0900,4423.2900) .. (2430.3000,4442.2300) ..
      controls (2442.8300,4458.9400) and (2462.1600,4486.6300) ..
      (2462.1600,4486.6300) -- (2486.1900,4480.3700) .. controls
      (2486.1900,4480.3700) and (2499.2400,4498.6500) .. (2495.5900,4516.9300) --
      (2502.4600,4518.6200) -- (2509.9200,4534.9800) -- (2520.7200,4564.1800) ..
      controls (2524.4900,4573.2100) and (2565.2500,4678.8400) ..
      (2577.5400,4710.7800) .. controls (2579.7700,4716.5600) and
      (2587.0500,4735.5700) .. (2585.0600,4745.1000) .. controls
      (2583.9500,4750.4300) and (2582.5600,4757.0500) .. (2582.5600,4767.1400) ..
      controls (2582.5600,4776.9800) and (2590.9600,4795.3600) ..
      (2607.2900,4811.1000) .. controls (2607.2700,4810.8300) and
      (2607.2700,4810.5600) .. (2607.2700,4810.2700) .. controls
      (2607.2700,4799.0600) and (2615.4300,4796.1000) .. (2619.7500,4796.1000) ..
      controls (2624.1000,4796.1000) and (2627.1300,4798.2400) ..
      (2629.8000,4800.1300) .. controls (2634.3100,4803.3000) and
      (2642.7000,4809.2000) .. (2659.9200,4809.2000) .. controls
      (2662.1100,4809.2000) and (2664.1300,4809.1400) .. (2665.9800,4808.9800) ..
      controls (2648.9600,4802.4100) and (2628.2400,4781.8200) ..
      (2628.2400,4742.9500) .. controls (2628.2400,4715.6300) and
      (2639.6500,4685.0900) .. (2647.9800,4662.8000) .. controls
      (2650.3700,4656.3900) and (2653.2000,4648.7900) .. (2654.4700,4644.2700) ..
      controls (2653.1500,4643.2300) and (2651.6300,4642.0600) ..
      (2650.2700,4641.0100) .. controls (2633.0900,4627.7900) and
      (2615.8100,4613.7000) .. (2609.9100,4599.6600) .. controls
      (2609.7900,4599.3900) and (2609.6700,4599.1400) .. (2609.5500,4598.8700) ..
      controls (2583.2200,4594.6800) and (2556.7000,4591.6200) ..
      (2556.7000,4591.6200) -- (2516.8900,4520.1800) -- (2542.0700,4528.4100) --
      (2518.0500,4475.1400) -- (2566.1000,4495.0000) .. controls
      (2566.1000,4495.0000) and (2555.1400,4458.4200) .. (2566.1000,4444.8500) ..
      controls (2567.6200,4446.0200) and (2583.2200,4456.9200) ..
      (2583.2200,4456.9200) .. controls (2583.2200,4456.9200) and
      (2591.3900,4476.3100) .. (2596.4900,4481.4100) .. controls
      (2601.6000,4486.5100) and (2631.4000,4516.9300) .. (2631.4000,4516.9300) --
      (2638.7100,4498.6500) .. controls (2674.8200,4516.6200) and
      (2741.2700,4601.6800) .. (2743.1800,4616.7000) .. controls
      (2743.1800,4631.3200) and (2717.0600,4654.3100) .. (2717.0600,4688.2600) ..
      controls (2717.0600,4708.1100) and (2724.9000,4715.9400) ..
      (2724.9000,4715.9400) .. controls (2724.9000,4691.9100) and
      (2782.3500,4637.5900) .. (2787.5800,4622.4400) .. controls
      (2774.5100,4615.1200) and (2749.4400,4539.9100) .. (2746.3100,4529.4700) ..
      controls (2735.8400,4529.7600) and (2681.1900,4517.1200) ..
      (2681.1900,4517.1200) .. controls (2681.1900,4517.1200) and
      (2649.5600,4483.4500) .. (2640.8000,4443.2800) -- (2684.6800,4452.1600) --
      (2677.1100,4400.7900) -- (2696.5000,4404.8800) .. controls
      (2696.5000,4404.8800) and (2714.8600,4435.4900) .. (2745.2700,4437.0100) --
      (2772.4300,4392.0900) -- (2790.7100,4412.4600) .. controls
      (2790.7100,4412.4600) and (2792.7900,4470.4400) .. (2802.7200,4477.2300) --
      (2824.1400,4468.8800) .. controls (2883.2400,4512.0200) and
      (2891.3100,4667.4000) .. (2883.2400,4672.2400) .. controls
      (2878.1400,4675.3000) and (2876.1000,4669.1800) .. (2860.8000,4688.5600) ..
      controls (2835.7400,4720.2900) and (2839.6300,4791.9100) ..
      (2815.9000,4817.1400) .. controls (2815.9000,4817.1400) and
      (2818.4000,4819.3600) .. (2829.3800,4819.3600) .. controls
      (2840.3300,4819.3600) and (2882.2700,4834.5100) .. (2882.6600,4884.1200) ..
      controls (2883.1300,4946.0200) and (2832.0500,4968.1600) ..
      (2832.0500,4968.1600) .. controls (2832.0500,4968.1600) and
      (2837.7200,4978.2400) .. (2837.7200,4992.7800) .. controls
      (2837.7200,5038.7500) and (2786.9500,5038.8100) .. (2786.0200,5045.5400) ..
      controls (2810.5700,5050.7500) and (2836.2300,5079.0500) ..
      (2838.2500,5099.8500) .. controls (2843.9700,5158.8200) and
      (2777.9700,5192.0900) .. (2749.9700,5164.1100) .. controls
      (2758.8500,5156.2700) and (2780.2700,5147.3900) .. (2780.2700,5125.4500) ..
      controls (2780.2700,5087.8400) and (2739.0000,5068.5200) ..
      (2739.0000,5068.5200) .. controls (2739.0000,5068.5200) and
      (2746.3200,5083.1400) .. (2746.3200,5101.4300) .. controls
      (2746.3200,5119.7100) and (2735.8800,5151.0500) .. (2696.1700,5151.0500) ..
      controls (2646.5500,5151.0500) and (2634.5400,5107.6900) ..
      (2634.5400,5107.6900) .. controls (2647.0700,5107.6900) and
      (2686.2500,5111.8700) .. (2686.2500,5088.3600) .. controls
      (2686.2500,5058.5900) and (2636.1000,5040.8400) .. (2636.1000,4991.7300) ..
      controls (2636.1000,4942.6300) and (2679.0400,4906.7000) ..
      (2727.5200,4903.4500) .. controls (2740.4300,4902.5900) and
      (2742.6900,4901.7600) .. (2752.0500,4901.7600) .. controls
      (2761.4100,4901.7600) and (2767.3600,4890.3900) .. (2787.5900,4890.3900) ..
      controls (2812.6600,4890.3900) and (2818.4100,4901.8900) ..
      (2826.7600,4901.8900) .. controls (2835.1200,4901.8900) and
      (2835.1200,4893.5300) .. (2835.1200,4888.8300) .. controls
      (2835.1200,4884.1200) and (2836.6800,4871.6000) .. (2805.8600,4871.6000) ..
      controls (2772.9500,4871.6000) and (2713.9400,4888.3000) ..
      (2660.6500,4888.3000) .. controls (2618.7900,4888.3000) and
      (2613.1200,4887.5400) .. (2610.7800,4884.5000) .. controls
      (2613.3800,4889.3600) and (2619.8200,4902.5200) .. (2619.8200,4913.1800) ..
      controls (2609.9600,4918.2200) and (2601.6300,4945.7600) ..
      (2596.4100,4945.7600) .. controls (2641.4000,4986.5400) and
      (2634.8600,5022.3200) .. (2635.2700,5030.4300) .. controls
      (2632.2100,5040.6200) and (2625.6600,5042.4000) .. (2614.6900,5042.4000) ..
      controls (2603.7100,5042.4000) and (2597.4500,5037.7000) ..
      (2597.4500,5037.7000) .. controls (2597.4500,5037.7000) and
      (2594.5900,5076.5500) .. (2588.3300,5089.6100) .. controls
      (2573.7800,5111.5500) and (2502.6200,5126.3500) .. (2475.0600,5084.5100) ..
      controls (2475.0600,5084.5100) and (2464.7800,5059.1200) ..
      (2460.6000,5051.2800) .. controls (2438.3200,5060.0200) and
      (2426.0700,5048.7900) .. (2426.0700,5048.7900) .. controls
      (2426.0700,5048.7900) and (2426.9300,5037.5800) .. (2427.1600,5029.3400) ..
      controls (2427.3500,5022.5500) and (2425.6000,5011.5800) ..
      (2425.6000,5002.1800) .. controls (2425.6000,4992.7800) and
      (2444.9200,4958.3000) .. (2444.9200,4958.3000) .. controls
      (2433.9700,4942.1700) and (2396.4100,4924.3800) .. (2396.4100,4924.3800) ..
      controls (2410.2500,4910.5300) and (2421.4500,4881.5500) ..
      (2421.4500,4881.5500);
    \path[fill=cb91930,nonzero rule] (2742.4200,4517.4600) .. controls
      (2717.3400,4512.8400) and (2683.9300,4505.2100) .. (2683.9300,4505.2100) --
      (2655.3900,4458.0800) -- (2689.3900,4465.2400) .. controls
      (2692.4600,4481.4500) and (2694.2800,4490.5300) .. (2701.6000,4497.0500) ..
      controls (2715.7000,4509.6100) and (2737.9400,4510.3000) ..
      (2742.4200,4517.4600) -- cycle(2385.9400,4969.2000) .. controls
      (2391.3900,4978.7100) and (2412.4600,4982.8000) .. (2411.7900,4991.6400) ..
      controls (2411.1100,5000.4900) and (2386.6200,5055.6000) ..
      (2385.9400,5069.2000) -- (2370.2900,5040.6200) .. controls
      (2370.2900,5040.6200) and (2393.4200,5007.9700) .. (2393.4200,4997.0800) ..
      controls (2393.4200,4986.2000) and (2384.5900,4983.4800) ..
      (2385.9400,4969.2000) -- cycle(2322.4000,4887.2200) .. controls
      (2321.9300,4865.9200) and (2349.5100,4856.6200) .. (2351.2700,4846.1300) ..
      controls (2353.0100,4835.6400) and (2329.8400,4852.7800) ..
      (2330.2700,4849.6200) .. controls (2334.1600,4820.3400) and
      (2358.3600,4817.3600) .. (2367.0000,4801.5400) .. controls
      (2372.2500,4791.9200) and (2344.6400,4805.3000) .. (2345.1400,4802.4100) ..
      controls (2351.0500,4768.2000) and (2386.8600,4781.1200) ..
      (2393.2200,4758.6900) .. controls (2396.7900,4746.1800) and
      (2370.8800,4765.8000) .. (2370.0600,4754.8000) .. controls
      (2369.5200,4747.4800) and (2383.6100,4708.8500) .. (2391.4800,4707.0900) ..
      controls (2399.3600,4705.3500) and (2424.7300,4714.9700) ..
      (2436.0700,4719.3400) .. controls (2447.4400,4723.7100) and
      (2469.3000,4728.0900) .. (2471.9200,4738.5700) .. controls
      (2459.6900,4757.8100) and (2427.3200,4802.4100) .. (2422.9600,4843.5000) ..
      controls (2397.6100,4870.6200) and (2372.2500,4909.9600) ..
      (2372.2500,4942.3100) .. controls (2372.2500,4974.6700) and
      (2381.8600,5000.9000) .. (2381.8600,5000.9000) -- (2346.0200,5068.2300) --
      (2339.0200,5037.6300) .. controls (2339.0200,5037.6300) and
      (2372.2400,5006.1500) .. (2371.3700,4995.6600) .. controls
      (2370.5000,4985.1600) and (2361.7600,4952.8000) .. (2361.7600,4952.8000) ..
      controls (2355.6300,4944.0700) and (2357.3800,4994.7900) ..
      (2357.3800,4994.7900) -- (2318.9100,5043.7500) .. controls
      (2318.9100,5043.7500) and (2317.1400,5011.4400) .. (2319.3000,5001.5100) ..
      controls (2323.4100,4982.6400) and (2340.7600,4973.7900) ..
      (2340.7600,4962.4300) .. controls (2340.7600,4951.0600) and
      (2325.9000,4931.8200) .. (2318.0300,4927.4500) .. controls
      (2316.2800,4913.4600) and (2343.3800,4899.4700) .. (2344.2600,4887.2200) ..
      controls (2337.2700,4879.3600) and (2322.5200,4892.7500) ..
      (2322.4000,4887.2200) -- cycle(2363.8300,4513.0400) .. controls
      (2363.8300,4513.0400) and (2387.3000,4518.7300) .. (2405.6600,4528.3500) ..
      controls (2386.2800,4526.3100) and (2353.9600,4526.3100) ..
      (2353.9600,4526.3100) -- (2325.6100,4466.9100) -- (2353.5900,4482.6600) ..
      controls (2353.5900,4482.6600) and (2353.3400,4509.5500) ..
      (2363.8300,4513.0400) -- cycle(2566.8900,4567.8100) .. controls
      (2574.7700,4574.8000) and (2591.7200,4577.6800) .. (2601.3500,4587.3000) ..
      controls (2580.5100,4582.1000) and (2560.7800,4577.3400) ..
      (2560.7800,4577.3400) -- (2536.2900,4539.5700) -- (2555.6700,4547.7400) ..
      controls (2555.6700,4547.7400) and (2559.0300,4560.8200) ..
      (2566.8900,4567.8100) -- cycle(2650.3100,4553.1900) .. controls
      (2656.4300,4561.0700) and (2666.0500,4533.9600) .. (2666.0500,4533.9600) ..
      controls (2690.5400,4555.8200) and (2663.4600,4567.6600) ..
      (2671.3000,4574.1800) .. controls (2681.8000,4582.9300) and
      (2699.2800,4568.9400) .. (2699.2800,4568.9400) .. controls
      (2712.4000,4580.3100) and (2691.8800,4592.1600) .. (2697.5300,4599.5500) ..
      controls (2708.9000,4614.4100) and (2712.4000,4600.4100) ..
      (2720.2700,4603.9100) .. controls (2728.1300,4607.4100) and
      (2736.8800,4614.4100) .. (2728.1300,4625.7700) .. controls
      (2719.3900,4637.1400) and (2691.4100,4686.9900) .. (2715.8900,4723.7100) ..
      controls (2715.8900,4723.7100) and (2700.1400,4718.4600) ..
      (2696.6500,4705.3500) .. controls (2693.1600,4692.2300) and
      (2706.2700,4625.7700) .. (2706.2700,4616.1600) -- (2634.5700,4554.9500) ..
      controls (2634.5700,4554.9500) and (2629.3400,4560.1900) ..
      (2638.9500,4572.4400) .. controls (2648.5600,4584.6800) and
      (2694.0200,4622.2800) .. (2694.0200,4622.2800) .. controls
      (2682.6800,4637.1400) and (2699.2800,4674.7400) .. (2676.5400,4688.7300) ..
      controls (2670.4300,4691.3500) and (2653.2900,4696.5400) ..
      (2667.7900,4707.0900) .. controls (2677.4200,4714.0900) and
      (2693.1600,4710.5900) .. (2693.1600,4742.0700) .. controls
      (2693.1600,4773.5500) and (2664.3000,4776.1700) .. (2664.3000,4776.1700) ..
      controls (2667.7900,4785.8000) and (2693.1500,4783.1600) ..
      (2700.1600,4792.7900) .. controls (2687.0300,4798.9100) and
      (2687.0300,4799.7800) .. (2677.4200,4799.7800) .. controls
      (2667.7900,4799.7800) and (2639.8100,4785.8000) .. (2639.8100,4742.9500) ..
      controls (2639.8100,4700.1000) and (2671.7400,4644.5800) ..
      (2666.0500,4638.8900) .. controls (2660.3700,4633.2000) and
      (2627.5800,4611.7900) .. (2620.5900,4595.1800) .. controls
      (2613.5900,4578.5600) and (2575.0600,4553.8600) .. (2575.0600,4553.8600) --
      (2538.3800,4493.7300) -- (2562.8700,4507.7300) .. controls
      (2562.8700,4507.7300) and (2571.8800,4537.0400) .. (2586.2900,4545.7000) ..
      controls (2606.7000,4557.9500) and (2625.6400,4579.7400) ..
      (2628.7600,4576.4600) .. controls (2631.8800,4573.1600) and
      (2612.7000,4547.0900) .. (2592.6000,4536.5900) .. controls
      (2586.4800,4524.3400) and (2571.6000,4479.7500) .. (2573.3600,4470.1300) ..
      controls (2573.3600,4470.1300) and (2617.0800,4522.5900) ..
      (2629.3300,4527.8400) .. controls (2641.5700,4533.0900) and
      (2645.9400,4517.3500) .. (2645.9400,4517.3500) .. controls
      (2662.5600,4529.5900) and (2644.1800,4545.3200) .. (2650.3100,4553.1900) --
      cycle(2695.8700,4953.8400) .. controls (2702.1700,4942.5000) and
      (2753.8000,4945.6800) .. (2753.8000,4993.8200) .. controls
      (2753.8000,5019.1200) and (2732.5000,5024.5100) .. (2732.5000,5031.5100) ..
      controls (2732.5000,5049.0000) and (2826.9400,5055.9900) ..
      (2826.9400,5101.4600) .. controls (2826.9400,5125.0700) and
      (2819.9400,5136.4400) .. (2819.9400,5136.4400) .. controls
      (2819.9400,5136.4400) and (2821.7000,5100.5900) .. (2810.3300,5100.5900) ..
      controls (2792.8400,5100.5900) and (2808.5800,5121.5700) ..
      (2808.5800,5132.0700) .. controls (2808.5800,5170.5500) and
      (2767.4800,5161.7900) .. (2767.4800,5161.7900) .. controls
      (2767.4800,5161.7900) and (2791.9700,5160.9100) .. (2791.9700,5122.4500) ..
      controls (2791.9700,5073.4800) and (2720.2700,5043.7500) ..
      (2715.0200,5049.0000) .. controls (2709.7800,5054.2400) and
      (2734.2600,5070.8600) .. (2734.2600,5097.9600) .. controls
      (2734.2600,5111.0700) and (2729.0100,5139.0500) .. (2701.0400,5139.0500) ..
      controls (2667.7900,5139.0500) and (2645.9400,5116.3200) ..
      (2659.0500,5118.0700) .. controls (2672.1700,5119.8200) and
      (2698.4100,5111.0800) .. (2698.4100,5088.3400) .. controls
      (2698.4100,5049.8700) and (2647.6900,5040.2500) .. (2647.6900,4991.2800) ..
      controls (2647.6900,4930.0600) and (2709.7800,4915.2100) ..
      (2729.0100,4915.2100) .. controls (2748.2500,4915.2100) and
      (2752.6200,4917.8400) .. (2752.6200,4917.8400) .. controls
      (2748.2500,4923.9600) and (2749.1200,4937.0700) .. (2749.1200,4937.0700) ..
      controls (2749.1200,4937.0700) and (2738.6300,4933.5700) ..
      (2726.3900,4933.5700) .. controls (2679.1800,4933.5700) and
      (2673.9300,4969.4200) .. (2673.9300,4981.6600) .. controls
      (2673.9300,4993.9100) and (2686.2700,5017.8200) .. (2705.3900,5015.7700) ..
      controls (2745.5700,5011.4500) and (2721.4100,4967.3000) ..
      (2695.8700,4953.8400) -- cycle(2758.2800,4935.8900) .. controls
      (2758.2800,4921.9000) and (2765.2200,4901.6200) .. (2786.8500,4901.6200) ..
      controls (2811.8200,4901.6200) and (2812.7900,4913.4000) ..
      (2826.7900,4913.4000) .. controls (2840.7800,4913.4000) and
      (2847.2000,4902.0400) .. (2847.2000,4888.9100) .. controls
      (2847.2000,4875.8000) and (2840.3900,4860.3400) .. (2806.3800,4860.3400) ..
      controls (2746.0400,4860.3400) and (2730.1800,4876.7300) ..
      (2658.1800,4876.7300) .. controls (2590.0400,4876.7300) and
      (2595.6600,4849.6400) .. (2551.9300,4805.9200) .. controls
      (2508.2200,4762.2000) and (2473.6700,4729.8300) .. (2473.6700,4729.8300) --
      (2476.3100,4722.8300) .. controls (2455.3100,4700.9700) and
      (2444.8200,4593.4200) .. (2434.3300,4555.8200) .. controls
      (2423.8300,4518.2200) and (2366.1200,4502.4800) .. (2366.1200,4502.4800) --
      (2353.0100,4429.9100) -- (2381.0000,4454.3900) .. controls
      (2381.0000,4454.3900) and (2379.2400,4459.6300) .. (2378.3700,4475.3800) ..
      controls (2377.5000,4491.1100) and (2421.2100,4523.4700) ..
      (2442.2000,4536.5900) .. controls (2438.6900,4516.4700) and
      (2389.7300,4477.1200) .. (2389.7300,4477.1200) .. controls
      (2389.7300,4477.1200) and (2394.1000,4464.0200) .. (2394.9800,4449.1400) ..
      controls (2395.8600,4434.2800) and (2406.3500,4407.1700) ..
      (2406.3500,4407.1700) -- (2409.0400,4411.5400) .. controls
      (2409.0400,4411.5400) and (2410.7400,4428.2800) .. (2413.8300,4434.4700) ..
      controls (2420.8200,4448.4600) and (2457.0700,4497.2400) ..
      (2457.0700,4497.2400) -- (2480.6600,4493.7300) .. controls
      (2492.9100,4512.9800) and (2476.3100,4531.3300) .. (2471.9200,4542.7000) ..
      controls (2481.5400,4552.3200) and (2486.8000,4547.0800) ..
      (2498.1600,4536.5900) .. controls (2506.9100,4557.5800) and
      (2499.0400,4559.3200) .. (2492.0400,4575.9300) .. controls
      (2485.0400,4592.5400) and (2498.1600,4589.0500) .. (2516.5200,4579.4300) ..
      controls (2523.5200,4590.7900) and (2521.7700,4600.4200) ..
      (2511.2800,4624.0300) .. controls (2500.7800,4647.6300) and
      (2523.5200,4636.2700) .. (2534.0100,4628.4000) .. controls
      (2541.8800,4640.6400) and (2538.3800,4643.2700) .. (2528.7700,4667.7500) ..
      controls (2519.1600,4692.2300) and (2534.0100,4688.7300) ..
      (2550.6300,4676.5000) .. controls (2561.1300,4704.4700) and
      (2552.3700,4699.2300) .. (2545.3800,4717.5800) .. controls
      (2538.4000,4735.9500) and (2555.8800,4734.2000) .. (2568.9800,4722.8300) ..
      controls (2581.2300,4734.2000) and (2570.9800,4738.2800) ..
      (2570.9800,4767.1400) .. controls (2570.9800,4788.2400) and
      (2595.6400,4828.4300) .. (2638.4900,4844.1700) .. controls
      (2653.3400,4829.3100) and (2618.8300,4826.8900) .. (2618.8300,4810.2800) ..
      controls (2618.8300,4800.6600) and (2625.8200,4820.7700) ..
      (2659.9300,4820.7700) .. controls (2694.0400,4820.7700) and
      (2695.7800,4804.1600) .. (2704.5200,4804.1600) .. controls
      (2713.2600,4804.1600) and (2705.3900,4828.6400) .. (2705.3900,4828.6400) ..
      controls (2745.6300,4828.6400) and (2731.6400,4789.2900) ..
      (2731.6400,4740.3200) .. controls (2731.6400,4691.3500) and
      (2798.9600,4645.0100) .. (2800.7000,4617.9100) .. controls
      (2776.4300,4603.3400) and (2769.9500,4541.6400) .. (2747.8700,4507.9400) ..
      controls (2735.6300,4494.3400) and (2720.6600,4492.9700) ..
      (2705.3900,4486.7400) -- (2690.5400,4424.6600) .. controls
      (2702.7800,4437.7700) and (2734.2600,4446.5200) .. (2734.2600,4446.5200) ..
      controls (2719.3900,4476.2500) and (2738.6300,4484.1200) ..
      (2746.4900,4491.1200) .. controls (2754.3700,4498.1100) and
      (2787.6000,4540.9600) .. (2787.6000,4540.9600) -- (2792.8400,4535.7100) ..
      controls (2792.8400,4535.7100) and (2776.2300,4488.4900) ..
      (2750.0000,4476.2500) .. controls (2743.0100,4461.3800) and
      (2767.4800,4422.0300) .. (2773.6000,4412.4200) .. controls
      (2776.0900,4416.0500) and (2779.2800,4418.8700) .. (2779.2800,4418.8700) ..
      controls (2779.2800,4418.8700) and (2781.9600,4471.6200) ..
      (2790.2100,4480.6200) .. controls (2799.8200,4491.1100) and
      (2802.4600,4490.2500) .. (2820.8200,4483.2400) .. controls
      (2828.6900,4491.1100) and (2824.3200,4512.1100) .. (2817.3200,4525.2200) ..
      controls (2825.2000,4540.0900) and (2837.4400,4510.6800) ..
      (2841.3400,4515.9300) .. controls (2855.2900,4534.7300) and
      (2828.6900,4549.7000) .. (2837.4400,4568.0700) .. controls
      (2837.4400,4568.0700) and (2852.1700,4554.2400) .. (2855.8000,4556.7000) ..
      controls (2859.4300,4559.1600) and (2857.5600,4569.8100) ..
      (2854.0500,4579.4300) .. controls (2835.8000,4623.0600) and
      (2863.3300,4594.2200) .. (2866.2900,4596.0500) .. controls
      (2872.3600,4599.7900) and (2865.4600,4627.8900) .. (2857.6000,4634.8900) ..
      controls (2853.2200,4622.6400) and (2826.9400,4575.0500) ..
      (2812.9500,4541.8300) .. controls (2810.5100,4536.0200) and
      (2797.2200,4533.9600) .. (2815.5800,4590.8000) .. controls
      (2837.4200,4658.4300) and (2861.9100,4647.6300) .. (2872.4100,4644.1400) ..
      controls (2871.5300,4675.6200) and (2840.0600,4678.2400) ..
      (2837.4400,4699.2300) .. controls (2805.9600,4712.3400) and
      (2832.1900,4819.9000) .. (2767.4800,4846.1300) -- (2848.8100,4852.2600) ..
      controls (2833.0700,4836.5200) and (2802.4600,4841.7600) ..
      (2802.4600,4841.7600) .. controls (2802.4600,4841.7600) and
      (2802.4600,4832.1400) .. (2826.9400,4832.1400) .. controls
      (2851.4300,4832.1400) and (2871.0000,4854.9100) .. (2871.0000,4885.5200) ..
      controls (2871.0000,4908.1000) and (2843.6900,4957.0900) ..
      (2817.5900,4957.0900) .. controls (2795.9700,4957.0900) and
      (2786.9300,4923.8900) .. (2781.8400,4926.4500) .. controls
      (2768.9300,4932.9100) and (2777.9400,4938.6600) .. (2782.7000,4946.8700) ..
      controls (2799.2200,4975.4600) and (2826.7000,4969.0000) ..
      (2826.7900,4992.3200) .. controls (2826.9500,5036.2500) and
      (2770.4500,5037.8600) .. (2762.3400,5029.7500) .. controls
      (2755.6300,5023.0400) and (2788.3100,5029.3100) .. (2787.6400,5001.8400) ..
      controls (2787.5000,4996.6500) and (2803.9600,5016.2100) ..
      (2803.9600,5014.7300) .. controls (2803.9600,4994.4500) and
      (2758.2800,4979.0500) .. (2758.2800,4935.8900) -- cycle(2452.0100,5008.3600)
      .. controls (2452.0100,5024.0900) and (2463.6500,5025.4500) ..
      (2467.0600,5025.4500) .. controls (2475.9600,5025.4500) and
      (2475.2700,4998.7700) .. (2479.3800,4992.6200) .. controls
      (2483.4900,4986.4600) and (2495.1100,4989.1900) .. (2497.1700,4985.0900) ..
      controls (2493.7500,4979.6200) and (2482.1100,4972.7700) ..
      (2482.1100,4964.5700) .. controls (2482.1100,4956.3600) and
      (2489.6400,4953.6200) .. (2493.0700,4953.6200) .. controls
      (2497.8500,4953.6200) and (2518.3800,4959.1000) .. (2518.3800,4971.4100) ..
      controls (2518.3800,4977.5600) and (2513.6700,4980.9000) ..
      (2511.5300,4985.0900) .. controls (2509.3900,4989.2800) and
      (2509.8200,4994.3300) .. (2508.1100,4995.3600) .. controls
      (2516.3300,4996.0400) and (2524.5300,4998.7700) .. (2530.6800,4998.7700) ..
      controls (2536.8500,4998.7700) and (2537.5300,4994.6700) ..
      (2537.5300,4989.2000) .. controls (2537.5300,4983.7200) and
      (2525.9000,4979.6200) .. (2525.9000,4974.1400) .. controls
      (2525.9000,4968.6700) and (2540.9600,4954.3000) .. (2545.7400,4954.3000) ..
      controls (2550.5300,4954.3000) and (2561.4600,4958.4100) ..
      (2561.4600,4965.9400) .. controls (2561.4600,4973.4700) and
      (2557.0300,4982.7000) .. (2561.4600,4987.1500) .. controls
      (2564.2200,4989.8800) and (2570.3700,4984.4100) .. (2570.3700,4984.4100) ..
      controls (2579.6000,4993.6500) and (2585.4200,5012.4500) ..
      (2603.8900,5014.5100) .. controls (2622.3600,4982.3600) and
      (2584.0400,4970.0400) .. (2584.0400,4970.0400) -- (2569.0000,4976.2000) ..
      controls (2574.8600,4957.6000) and (2558.9100,4951.2900) ..
      (2559.4200,4944.0500) .. controls (2560.8800,4923.3200) and
      (2556.6800,4916.7900) .. (2549.1600,4909.8300) .. controls
      (2544.3800,4911.2000) and (2534.1100,4911.8900) .. (2533.4200,4907.7900) ..
      controls (2543.0100,4890.6800) and (2514.2800,4872.2100) ..
      (2517.6900,4864.6800) .. controls (2513.5900,4867.4200) and
      (2504.0000,4887.9400) .. (2500.5900,4892.0500) .. controls
      (2497.1700,4896.1500) and (2503.5500,4902.1300) .. (2499.9000,4911.8900) ..
      controls (2497.8500,4917.3600) and (2485.5300,4911.2000) ..
      (2484.1700,4920.7900) .. controls (2482.7900,4930.3600) and
      (2485.9500,4950.3800) .. (2474.3300,4957.2300) .. controls
      (2474.3300,4977.0700) and (2452.0100,4989.8900) .. (2452.0100,5008.3600) --
      cycle(2519.7300,5045.9800) -- (2521.7900,5041.1900) .. controls
      (2516.9900,5039.8300) and (2516.3100,5013.8200) .. (2504.0000,5013.8200) ..
      controls (2488.9500,5013.8200) and (2500.5800,5032.3000) ..
      (2488.9500,5035.7200) .. controls (2488.9500,5035.7200) and
      (2510.8400,5037.7700) .. (2519.7300,5045.9800) -- cycle(2536.8400,5043.9300)
      .. controls (2542.3000,5036.4000) and (2555.3100,5026.8300) ..
      (2564.8800,5035.0300) .. controls (2568.9800,5033.6700) and
      (2570.3500,5032.3000) .. (2565.5700,5026.8200) .. controls
      (2560.7800,5021.3500) and (2560.7500,5007.5600) .. (2551.2000,5008.3600) ..
      controls (2534.7900,5009.7300) and (2541.6200,5033.6700) ..
      (2535.4700,5039.1400) -- (2536.8400,5043.9300) -- cycle(2434.1800,4889.7700)
      .. controls (2438.9300,4893.6500) and (2452.0300,4913.9300) ..
      (2464.6400,4913.9300) .. controls (2463.5800,4906.5800) and
      (2444.6700,4890.8200) .. (2438.3800,4878.2100) .. controls
      (2432.0800,4865.6200) and (2442.5800,4853.0000) .. (2447.8300,4843.5500) ..
      controls (2446.7800,4851.9600) and (2466.7400,4865.6200) ..
      (2473.0500,4872.9700) .. controls (2479.3400,4880.3200) and
      (2484.5200,4877.8300) .. (2480.3900,4868.7600) .. controls
      (2475.1500,4857.2100) and (2458.6400,4845.1700) .. (2458.3400,4827.7900) ..
      controls (2458.1600,4818.5000) and (2465.3100,4811.9100) ..
      (2474.0900,4806.7800) .. controls (2474.0900,4806.7800) and
      (2477.2500,4837.2500) .. (2489.8400,4828.8500) .. controls
      (2494.9500,4825.4500) and (2469.8900,4778.4200) .. (2489.8400,4760.5600) ..
      controls (2493.0100,4774.2200) and (2523.4600,4797.3200) ..
      (2523.4600,4803.6400) .. controls (2523.4600,4809.9400) and
      (2512.9600,4830.9400) .. (2523.4600,4830.9400) .. controls
      (2529.7700,4830.9400) and (2535.0200,4812.0400) .. (2539.2200,4812.0400) ..
      controls (2543.4200,4812.0400) and (2551.8300,4816.2300) ..
      (2551.8300,4823.5900) .. controls (2551.8300,4830.9500) and
      (2532.9100,4862.4600) .. (2544.4700,4862.4600) .. controls
      (2549.8300,4862.4600) and (2562.3300,4841.4500) .. (2565.4900,4841.4500) ..
      controls (2568.6300,4841.4500) and (2571.7900,4843.5500) ..
      (2574.9400,4860.3600) .. controls (2578.0900,4877.1600) and
      (2560.2300,4883.4800) .. (2566.5300,4900.2800) .. controls
      (2566.5300,4900.2800) and (2583.3400,4891.8800) .. (2588.5900,4882.4200) ..
      controls (2593.8500,4872.9700) and (2604.3500,4899.2300) ..
      (2605.4000,4907.6300) .. controls (2602.1500,4911.4400) and
      (2598.4500,4924.8600) .. (2592.7900,4932.8400) .. controls
      (2587.5200,4940.2900) and (2580.2000,4942.3700) .. (2580.2000,4944.4000) ..
      controls (2580.2000,4948.5900) and (2586.4800,4949.6400) ..
      (2607.5000,4972.7600) .. controls (2628.5200,4995.8700) and
      (2625.3100,5022.3400) .. (2625.3600,5026.3300) .. controls
      (2612.7500,5037.8900) and (2602.2500,5021.0800) .. (2591.7600,5026.3300) ..
      controls (2581.2500,5031.5900) and (2586.4800,5064.1400) ..
      (2583.3400,5075.7100) .. controls (2583.3400,5075.7100) and
      (2569.6900,5053.6500) .. (2566.5300,5056.8000) .. controls
      (2563.3800,5059.9500) and (2567.5900,5069.4100) .. (2570.7400,5079.9100) ..
      controls (2573.8900,5090.4100) and (2556.0400,5095.6700) ..
      (2556.0400,5095.6700) .. controls (2556.0400,5095.6700) and
      (2551.8300,5073.6000) .. (2544.4700,5074.6500) .. controls
      (2537.1300,5075.7100) and (2539.2200,5096.7200) .. (2539.2200,5096.7200) ..
      controls (2539.2200,5096.7200) and (2524.5100,5105.1200) ..
      (2521.3700,5087.2700) .. controls (2517.6400,5066.1600) and
      (2507.7100,5084.1100) .. (2502.4600,5093.5600) .. controls
      (2495.1000,5090.4100) and (2498.2500,5066.2500) .. (2498.2500,5057.8500) ..
      controls (2498.2500,5049.4400) and (2483.5500,5065.2000) ..
      (2476.1900,5068.3600) .. controls (2478.3000,5061.0000) and
      (2469.9600,5050.0500) .. (2469.9600,5041.6400) .. controls
      (2469.9600,5033.2500) and (2442.5800,5046.2500) .. (2436.2800,5039.9400) ..
      controls (2436.2300,5036.6600) and (2432.3600,5010.0900) ..
      (2437.6400,4995.0400) .. controls (2444.4300,4975.7000) and
      (2455.3300,4967.1400) .. (2455.3300,4955.5900) .. controls
      (2455.3300,4944.8700) and (2438.5900,4939.5400) .. (2408.2700,4920.4200) ..
      controls (2422.1100,4918.4400) and (2422.6200,4880.3200) ..
      (2434.1800,4889.7700);
    \path[fill=c231f20,nonzero rule] (3899.8800,3858.0200) .. controls
      (3898.8100,3840.6800) and (3888.1600,3855.8600) .. (3888.1600,3855.8600) ..
      controls (3888.1600,3855.8600) and (3861.1900,3882.0100) ..
      (3861.1900,3919.6200) .. controls (3869.0200,3924.3200) and
      (3872.6800,3941.0400) .. (3875.8200,3942.6000) .. controls
      (3878.9500,3944.1700) and (3900.9000,3954.6200) .. (3900.9000,3965.5900) ..
      controls (3900.9000,3976.5600) and (3870.0600,4044.4600) ..
      (3870.0600,4070.0600) -- (3843.9500,4033.4900) -- (3823.5700,4069.0100) --
      (3807.3800,4026.7000) -- (3790.6600,4046.5500) .. controls
      (3790.6600,4046.5500) and (3782.5600,3985.2700) .. (3785.5100,3974.2100) ..
      controls (3793.5000,3944.2800) and (3806.8600,3947.8300) ..
      (3806.8600,3937.3800) .. controls (3806.8600,3921.1900) and
      (3778.5000,3909.2500) .. (3778.5000,3909.2500) .. controls
      (3781.7400,3900.6300) and (3797.8700,3822.9500) .. (3809.5900,3785.4500) ..
      controls (3823.0100,3742.5900) and (3832.4600,3738.8900) ..
      (3841.3500,3720.6100) .. controls (3848.5900,3705.6900) and
      (3851.8000,3672.5600) .. (3869.5500,3672.5600) .. controls
      (3887.3000,3672.5600) and (3935.9000,3690.3100) .. (3935.9000,3690.3100) ..
      controls (3919.6900,3674.6500) and (3912.3800,3516.3800) ..
      (3886.2700,3516.3800) .. controls (3868.5500,3516.3800) and
      (3823.6100,3515.0700) .. (3823.6100,3515.0700) .. controls
      (3823.6100,3515.0700) and (3803.9500,3483.9300) .. (3788.0700,3421.8400) --
      (3826.7200,3444.2900) -- (3815.2300,3383.1800) -- (3862.2300,3418.1700) --
      (3881.5600,3358.1100) -- (3898.8100,3386.3200) .. controls
      (3898.8100,3386.3200) and (3894.5100,3399.7600) .. (3908.7300,3418.7000) ..
      controls (3921.2500,3435.4100) and (3940.5900,3463.1000) ..
      (3940.5900,3463.1000) -- (3964.6100,3456.8400) .. controls
      (3964.6100,3456.8400) and (3977.6600,3475.1200) .. (3974.0000,3493.3900) --
      (3980.9000,3495.0900) -- (3988.3400,3511.4500) -- (3999.1400,3540.6500) ..
      controls (4002.9300,3549.6800) and (4043.6900,3655.3100) ..
      (4055.9800,3687.2500) .. controls (4058.2000,3693.0300) and
      (4065.4900,3712.0400) .. (4063.4800,3721.5700) .. controls
      (4062.3600,3726.9000) and (4060.9800,3733.5200) .. (4060.9800,3743.6100) ..
      controls (4060.9800,3753.4500) and (4069.3800,3771.8300) ..
      (4085.7000,3787.5700) .. controls (4085.6800,3787.3000) and
      (4085.6800,3787.0300) .. (4085.6800,3786.7400) .. controls
      (4085.6800,3775.5300) and (4093.8700,3772.5700) .. (4098.1800,3772.5700) ..
      controls (4102.5200,3772.5700) and (4105.5700,3774.7100) ..
      (4108.2400,3776.6000) .. controls (4112.7300,3779.7800) and
      (4121.1300,3785.6700) .. (4138.3400,3785.6700) .. controls
      (4140.5500,3785.6700) and (4142.5600,3785.6100) .. (4144.4100,3785.4500) ..
      controls (4127.4000,3778.8800) and (4106.6800,3758.2900) ..
      (4106.6800,3719.4200) .. controls (4106.6800,3692.1000) and
      (4118.0700,3661.5600) .. (4126.4100,3639.2700) .. controls
      (4128.7900,3632.8600) and (4131.6400,3625.2500) .. (4132.9100,3620.7400) ..
      controls (4131.5800,3619.7000) and (4130.0600,3618.5300) ..
      (4128.7100,3617.4800) .. controls (4111.5000,3604.2500) and
      (4094.2400,3590.1700) .. (4088.3400,3576.1300) .. controls
      (4088.2200,3575.8600) and (4088.1100,3575.6100) .. (4087.9900,3575.3400) ..
      controls (4061.6600,3571.1500) and (4035.1200,3568.0900) ..
      (4035.1200,3568.0900) -- (3995.3300,3496.6600) -- (4020.5100,3504.8800) --
      (3996.4800,3451.6100) -- (4044.5300,3471.4600) .. controls
      (4044.5300,3471.4600) and (4033.5500,3434.8900) .. (4044.5300,3421.3200) ..
      controls (4046.0400,3422.5000) and (4061.6600,3433.3900) ..
      (4061.6600,3433.3900) .. controls (4061.6600,3433.3900) and
      (4069.8200,3452.7800) .. (4074.9200,3457.8800) .. controls
      (4080.0200,3462.9800) and (4109.8200,3493.3900) .. (4109.8200,3493.3900) --
      (4117.1300,3475.1200) .. controls (4153.2600,3493.0900) and
      (4219.6900,3578.1500) .. (4221.6000,3593.1700) .. controls
      (4221.6000,3607.7900) and (4195.4900,3630.7800) .. (4195.4900,3664.7300) ..
      controls (4195.4900,3684.5800) and (4203.3200,3692.4100) ..
      (4203.3200,3692.4100) .. controls (4203.3200,3668.3800) and
      (4260.7800,3614.0600) .. (4266.0000,3598.9100) .. controls
      (4252.9500,3591.5900) and (4227.8700,3516.3800) .. (4224.7500,3505.9400) ..
      controls (4214.2800,3506.2300) and (4159.6100,3493.5900) ..
      (4159.6100,3493.5900) .. controls (4159.6100,3493.5900) and
      (4127.9900,3459.9200) .. (4119.2200,3419.7500) -- (4163.1100,3428.6300) --
      (4155.5300,3377.2600) -- (4174.9200,3381.3400) .. controls
      (4174.9200,3381.3400) and (4193.3000,3411.9600) .. (4223.6900,3413.4800) --
      (4250.8600,3368.5500) -- (4269.1400,3388.9400) .. controls
      (4269.1400,3388.9400) and (4271.2300,3446.9100) .. (4281.1500,3453.7000) --
      (4302.5800,3445.3500) .. controls (4361.6800,3488.4900) and
      (4369.7500,3643.8700) .. (4361.6800,3648.7100) .. controls
      (4356.5600,3651.7700) and (4354.5300,3645.6400) .. (4339.2200,3665.0300) ..
      controls (4314.1600,3696.7600) and (4318.0500,3768.3700) ..
      (4294.3200,3793.6100) .. controls (4294.3200,3793.6100) and
      (4296.8200,3795.8300) .. (4307.7900,3795.8300) .. controls
      (4318.7700,3795.8300) and (4360.6800,3810.9800) .. (4361.0700,3860.6000) ..
      controls (4361.5600,3922.5000) and (4310.4900,3944.6300) ..
      (4310.4900,3944.6300) .. controls (4310.4900,3944.6300) and
      (4316.1500,3954.7100) .. (4316.1500,3969.2500) .. controls
      (4316.1500,4015.2100) and (4265.3700,4015.2800) .. (4264.4300,4022.0100) ..
      controls (4288.9800,4027.2200) and (4314.6700,4055.5200) ..
      (4316.6800,4076.3200) .. controls (4322.4000,4135.2900) and
      (4256.3900,4168.5600) .. (4228.4000,4140.5800) .. controls
      (4237.2900,4132.7400) and (4258.6900,4123.8600) .. (4258.6900,4101.9200) ..
      controls (4258.6900,4064.3100) and (4217.4200,4044.9900) ..
      (4217.4200,4044.9900) .. controls (4217.4200,4044.9900) and
      (4224.7500,4059.6100) .. (4224.7500,4077.9000) .. controls
      (4224.7500,4096.1800) and (4214.3000,4127.5100) .. (4174.5900,4127.5100) ..
      controls (4124.9800,4127.5100) and (4112.9700,4084.1600) ..
      (4112.9700,4084.1600) .. controls (4125.4900,4084.1600) and
      (4164.6700,4088.3400) .. (4164.6700,4064.8300) .. controls
      (4164.6700,4035.0600) and (4114.5300,4017.3000) .. (4114.5300,3968.2000) ..
      controls (4114.5300,3919.1000) and (4157.4800,3883.1700) ..
      (4205.9400,3879.9200) .. controls (4218.8500,3879.0600) and
      (4221.1100,3878.2300) .. (4230.4700,3878.2300) .. controls
      (4239.8200,3878.2300) and (4245.8000,3866.8700) .. (4266.0200,3866.8700) ..
      controls (4291.0900,3866.8700) and (4296.8400,3878.3600) ..
      (4305.2000,3878.3600) .. controls (4313.5400,3878.3600) and
      (4313.5400,3870.0000) .. (4313.5400,3865.3000) .. controls
      (4313.5400,3860.6000) and (4315.1000,3848.0700) .. (4284.3000,3848.0700) ..
      controls (4251.3900,3848.0700) and (4192.3600,3864.7800) ..
      (4139.0800,3864.7800) .. controls (4097.2100,3864.7800) and
      (4091.5400,3864.0000) .. (4089.2000,3860.9700) .. controls
      (4091.8000,3865.8300) and (4098.2400,3878.9800) .. (4098.2400,3889.6500) ..
      controls (4088.3800,3894.6900) and (4080.0600,3922.2300) ..
      (4074.8200,3922.2300) .. controls (4119.8200,3963.0100) and
      (4113.3000,3998.7900) .. (4113.6900,4006.8900) .. controls
      (4110.6400,4017.0900) and (4104.0800,4018.8700) .. (4093.1100,4018.8700) ..
      controls (4082.1500,4018.8700) and (4075.8800,4014.1600) ..
      (4075.8800,4014.1600) .. controls (4075.8800,4014.1600) and
      (4073.0300,4053.0200) .. (4066.7600,4066.0800) .. controls
      (4052.2100,4088.0200) and (3981.0400,4102.8200) .. (3953.4800,4060.9800) ..
      controls (3953.4800,4060.9800) and (3943.2000,4035.5900) ..
      (3939.0200,4027.7500) .. controls (3916.7400,4036.4800) and
      (3904.4900,4025.2600) .. (3904.4900,4025.2600) .. controls
      (3904.4900,4025.2600) and (3905.3500,4014.0500) .. (3905.5900,4005.8100) ..
      controls (3905.7800,3999.0200) and (3904.0200,3988.0500) ..
      (3904.0200,3978.6500) .. controls (3904.0200,3969.2500) and
      (3923.3400,3934.7800) .. (3923.3400,3934.7800) .. controls
      (3912.4000,3918.6400) and (3874.8400,3900.8400) .. (3874.8400,3900.8400) ..
      controls (3888.6700,3887.0000) and (3899.8800,3858.0200) ..
      (3899.8800,3858.0200);
    \path[fill=cb91930,nonzero rule] (4220.8400,3493.9300) .. controls
      (4195.7800,3489.3100) and (4162.3400,3481.6800) .. (4162.3400,3481.6800) --
      (4133.8300,3434.5500) -- (4167.8300,3441.7100) .. controls
      (4170.8800,3457.9200) and (4172.7000,3467.0000) .. (4180.0200,3473.5200) ..
      controls (4194.1400,3486.0800) and (4216.3700,3486.7700) ..
      (4220.8400,3493.9300) -- cycle(3864.3800,3945.6600) .. controls
      (3869.8000,3955.1900) and (3890.9000,3959.2700) .. (3890.2100,3968.1200) ..
      controls (3889.5300,3976.9600) and (3865.0600,4032.0700) ..
      (3864.3800,4045.6700) -- (3848.7100,4017.0900) .. controls
      (3848.7100,4017.0900) and (3871.8600,3984.4400) .. (3871.8600,3973.5500) ..
      controls (3871.8600,3962.6700) and (3863.0100,3959.9500) ..
      (3864.3800,3945.6600) -- cycle(3800.8200,3863.6900) .. controls
      (3800.3700,3842.3900) and (3827.9500,3833.1000) .. (3829.6900,3822.6000) ..
      controls (3831.4300,3812.1100) and (3808.2800,3829.2500) ..
      (3808.6900,3826.0900) .. controls (3812.5800,3796.8100) and
      (3836.8000,3793.8300) .. (3845.4300,3778.0000) .. controls
      (3850.6600,3768.3900) and (3823.0700,3781.7700) .. (3823.5700,3778.8800) ..
      controls (3829.4700,3744.6600) and (3865.2700,3757.5900) ..
      (3871.6600,3735.1600) .. controls (3875.2100,3722.6500) and
      (3849.3000,3742.2700) .. (3848.5000,3731.2700) .. controls
      (3847.9500,3723.9500) and (3862.0300,3685.3200) .. (3869.9000,3683.5600) ..
      controls (3877.7700,3681.8200) and (3903.1400,3691.4400) ..
      (3914.5100,3695.8100) .. controls (3925.8600,3700.1800) and
      (3947.7100,3704.5600) .. (3950.3500,3715.0400) .. controls
      (3938.1100,3734.2800) and (3905.7600,3778.8800) .. (3901.3900,3819.9700) ..
      controls (3876.0400,3847.0800) and (3850.6600,3886.4300) ..
      (3850.6600,3918.7800) .. controls (3850.6600,3951.1400) and
      (3860.2900,3977.3700) .. (3860.2900,3977.3700) -- (3824.4300,4044.7000) --
      (3817.4400,4014.1000) .. controls (3817.4400,4014.1000) and
      (3850.6600,3982.6200) .. (3849.7900,3972.1200) .. controls
      (3848.9300,3961.6300) and (3840.1800,3929.2700) .. (3840.1800,3929.2700) ..
      controls (3834.0600,3920.5400) and (3835.8000,3971.2500) ..
      (3835.8000,3971.2500) -- (3797.3200,4020.2200) .. controls
      (3797.3200,4020.2200) and (3795.5700,3987.9100) .. (3797.7300,3977.9800) ..
      controls (3801.8400,3959.1100) and (3819.1800,3950.2500) ..
      (3819.1800,3938.9000) .. controls (3819.1800,3927.5300) and
      (3804.3400,3908.2900) .. (3796.4600,3903.9200) .. controls
      (3794.7100,3889.9300) and (3821.8200,3875.9400) .. (3822.7000,3863.6900) ..
      controls (3815.7000,3855.8300) and (3800.9600,3869.2200) ..
      (3800.8200,3863.6900) -- cycle(3842.2500,3489.5100) .. controls
      (3842.2500,3489.5100) and (3865.7200,3495.2000) .. (3884.1000,3504.8200) ..
      controls (3864.7100,3502.7800) and (3832.3800,3502.7800) ..
      (3832.3800,3502.7800) -- (3804.0200,3443.3800) -- (3832.0100,3459.1300) ..
      controls (3832.0100,3459.1300) and (3831.7600,3486.0200) ..
      (3842.2500,3489.5100) -- cycle(4045.3300,3544.2800) .. controls
      (4053.2000,3551.2700) and (4070.1400,3554.1600) .. (4079.7700,3563.7700) ..
      controls (4058.9300,3558.5700) and (4039.2000,3553.8000) ..
      (4039.2000,3553.8000) -- (4014.7100,3516.0400) -- (4034.1000,3524.2100) ..
      controls (4034.1000,3524.2100) and (4037.4600,3537.2900) ..
      (4045.3300,3544.2800) -- cycle(4128.7300,3529.6600) .. controls
      (4134.8600,3537.5400) and (4144.4700,3510.4300) .. (4144.4700,3510.4300) ..
      controls (4168.9600,3532.2900) and (4141.8900,3544.1300) ..
      (4149.7300,3550.6500) .. controls (4160.2100,3559.4000) and
      (4177.7000,3545.4100) .. (4177.7000,3545.4100) .. controls
      (4190.8200,3556.7800) and (4170.3100,3568.6300) .. (4175.9600,3576.0200) ..
      controls (4187.3200,3590.8700) and (4190.8200,3576.8800) ..
      (4198.6900,3580.3800) .. controls (4206.5600,3583.8800) and
      (4215.3100,3590.8700) .. (4206.5600,3602.2400) .. controls
      (4197.8100,3613.6100) and (4169.8200,3663.4600) .. (4194.3200,3700.1800) ..
      controls (4194.3200,3700.1800) and (4178.5700,3694.9300) ..
      (4175.0800,3681.8200) .. controls (4171.5800,3668.7000) and
      (4184.7100,3602.2400) .. (4184.7100,3592.6300) -- (4112.9900,3531.4200) ..
      controls (4112.9900,3531.4200) and (4107.7500,3536.6600) ..
      (4117.3800,3548.9100) .. controls (4126.9900,3561.1500) and
      (4172.4600,3598.7500) .. (4172.4600,3598.7500) .. controls
      (4161.0900,3613.6100) and (4177.7000,3651.2100) .. (4154.9800,3665.2000) ..
      controls (4148.8500,3667.8200) and (4131.7200,3673.0100) ..
      (4146.2300,3683.5600) .. controls (4155.8400,3690.5600) and
      (4171.5800,3687.0600) .. (4171.5800,3718.5400) .. controls
      (4171.5800,3750.0200) and (4142.7300,3752.6400) .. (4142.7300,3752.6400) ..
      controls (4146.2300,3762.2700) and (4171.5800,3759.6300) ..
      (4178.5700,3769.2600) .. controls (4165.4700,3775.3800) and
      (4165.4500,3776.2500) .. (4155.8400,3776.2500) .. controls
      (4146.2300,3776.2500) and (4118.2400,3762.2700) .. (4118.2400,3719.4200) ..
      controls (4118.2400,3676.5700) and (4150.1600,3621.0500) ..
      (4144.4700,3615.3700) .. controls (4138.7900,3609.6700) and
      (4106.0000,3588.2600) .. (4099.0000,3571.6500) .. controls
      (4092.0100,3555.0300) and (4053.5000,3530.3300) .. (4053.5000,3530.3300) --
      (4016.8200,3470.2000) -- (4041.2900,3484.2000) .. controls
      (4041.2900,3484.2000) and (4050.2900,3513.5100) .. (4064.7100,3522.1700) ..
      controls (4085.1200,3534.4100) and (4104.0600,3556.2100) ..
      (4107.1900,3552.9200) .. controls (4110.2900,3549.6200) and
      (4091.1300,3523.5500) .. (4071.0200,3513.0600) .. controls
      (4064.9000,3500.8100) and (4050.0400,3456.2200) .. (4051.7800,3446.6000) ..
      controls (4051.7800,3446.6000) and (4095.5100,3499.0600) ..
      (4107.7500,3504.3100) .. controls (4120.0000,3509.5600) and
      (4124.3600,3493.8200) .. (4124.3600,3493.8200) .. controls
      (4140.9800,3506.0600) and (4122.6200,3521.7900) .. (4128.7300,3529.6600) --
      cycle(4174.3000,3930.3100) .. controls (4180.5900,3918.9600) and
      (4232.2300,3922.1500) .. (4232.2300,3970.2900) .. controls
      (4232.2300,3995.5900) and (4210.9400,4000.9800) .. (4210.9400,4007.9800) ..
      controls (4210.9400,4025.4700) and (4305.3700,4032.4600) ..
      (4305.3700,4077.9200) .. controls (4305.3700,4101.5400) and
      (4298.3800,4112.9100) .. (4298.3800,4112.9100) .. controls
      (4298.3800,4112.9100) and (4300.1200,4077.0600) .. (4288.7500,4077.0600) ..
      controls (4271.2700,4077.0600) and (4287.0100,4098.0400) ..
      (4287.0100,4108.5400) .. controls (4287.0100,4147.0200) and
      (4245.9200,4138.2600) .. (4245.9200,4138.2600) .. controls
      (4245.9200,4138.2600) and (4270.3900,4137.3800) .. (4270.3900,4098.9200) ..
      controls (4270.3900,4049.9500) and (4198.6900,4020.2200) ..
      (4193.4400,4025.4700) .. controls (4188.2000,4030.7100) and
      (4212.6800,4047.3300) .. (4212.6800,4074.4300) .. controls
      (4212.6800,4087.5400) and (4207.4400,4115.5200) .. (4179.4500,4115.5200) ..
      controls (4146.2300,4115.5200) and (4124.3600,4092.7900) ..
      (4137.4800,4094.5400) .. controls (4150.5900,4096.2900) and
      (4176.8400,4087.5500) .. (4176.8400,4064.8100) .. controls
      (4176.8400,4026.3400) and (4126.1100,4016.7200) .. (4126.1100,3967.7500) ..
      controls (4126.1100,3906.5300) and (4188.2000,3891.6700) ..
      (4207.4400,3891.6700) .. controls (4226.6800,3891.6700) and
      (4231.0400,3894.3100) .. (4231.0400,3894.3100) .. controls
      (4226.6800,3900.4300) and (4227.5400,3913.5400) .. (4227.5400,3913.5400) ..
      controls (4227.5400,3913.5400) and (4217.0500,3910.0400) ..
      (4204.8200,3910.0400) .. controls (4157.6000,3910.0400) and
      (4152.3400,3945.8900) .. (4152.3400,3958.1300) .. controls
      (4152.3400,3970.3800) and (4164.7100,3994.2900) .. (4183.8300,3992.2400) ..
      controls (4224.0000,3987.9200) and (4199.8200,3943.7700) ..
      (4174.3000,3930.3100) -- cycle(4236.7200,3912.3600) .. controls
      (4236.7200,3898.3700) and (4243.6500,3878.1000) .. (4265.2700,3878.1000) ..
      controls (4290.2300,3878.1000) and (4291.2100,3889.8700) ..
      (4305.2100,3889.8700) .. controls (4319.2000,3889.8700) and
      (4325.6300,3878.5100) .. (4325.6300,3865.3800) .. controls
      (4325.6300,3852.2800) and (4318.8100,3836.8100) .. (4284.8000,3836.8100) ..
      controls (4224.4700,3836.8100) and (4208.5900,3853.2000) ..
      (4136.6000,3853.2000) .. controls (4068.4600,3853.2000) and
      (4074.0800,3826.1100) .. (4030.3700,3782.3900) .. controls
      (3986.6400,3738.6700) and (3952.1100,3706.3000) .. (3952.1100,3706.3000) --
      (3954.7300,3699.3000) .. controls (3933.7500,3677.4400) and
      (3923.2400,3569.8900) .. (3912.7500,3532.2900) .. controls
      (3902.2700,3494.6900) and (3844.5500,3478.9500) .. (3844.5500,3478.9500) --
      (3831.4300,3406.3800) -- (3859.4100,3430.8600) .. controls
      (3859.4100,3430.8600) and (3857.6600,3436.1000) .. (3856.8000,3451.8500) ..
      controls (3855.9200,3467.5800) and (3899.6300,3499.9400) ..
      (3920.6300,3513.0600) .. controls (3917.1300,3492.9400) and
      (3868.1600,3453.5900) .. (3868.1600,3453.5900) .. controls
      (3868.1600,3453.5900) and (3872.5400,3440.4800) .. (3873.4200,3425.6100) ..
      controls (3874.2800,3410.7500) and (3884.7700,3383.6400) ..
      (3884.7700,3383.6400) -- (3887.4600,3388.0100) .. controls
      (3887.4600,3388.0100) and (3889.1800,3404.7500) .. (3892.2500,3410.9400) ..
      controls (3899.2400,3424.9300) and (3935.4900,3473.7100) ..
      (3935.4900,3473.7100) -- (3959.1000,3470.2000) .. controls
      (3971.3300,3489.4500) and (3954.7300,3507.8000) .. (3950.3500,3519.1700) ..
      controls (3959.9600,3528.7900) and (3965.2100,3523.5500) ..
      (3976.5800,3513.0600) .. controls (3985.3300,3534.0500) and
      (3977.4600,3535.7900) .. (3970.4700,3552.4000) .. controls
      (3963.4600,3569.0100) and (3976.5800,3565.5200) .. (3994.9400,3555.9000) ..
      controls (4001.9300,3567.2600) and (4000.2000,3576.8900) ..
      (3989.7100,3600.5000) .. controls (3979.2200,3624.1000) and
      (4001.9500,3612.7300) .. (4012.4400,3604.8700) .. controls
      (4020.3100,3617.1000) and (4016.8200,3619.7400) .. (4007.1900,3644.2200) ..
      controls (3997.5800,3668.7000) and (4012.4400,3665.2000) ..
      (4029.0600,3652.9600) .. controls (4039.5500,3680.9400) and
      (4030.8000,3675.7000) .. (4023.8100,3694.0500) .. controls
      (4016.8200,3712.4200) and (4034.3000,3710.6700) .. (4047.4200,3699.3000) ..
      controls (4059.6700,3710.6700) and (4049.4100,3714.7500) ..
      (4049.4100,3743.6100) .. controls (4049.4100,3764.7100) and
      (4074.0600,3804.9000) .. (4116.9100,3820.6400) .. controls
      (4131.7800,3805.7800) and (4097.2700,3803.3500) .. (4097.2700,3786.7500) ..
      controls (4097.2700,3777.1300) and (4104.2600,3797.2400) ..
      (4138.3600,3797.2400) .. controls (4172.4600,3797.2400) and
      (4174.2000,3780.6200) .. (4182.9500,3780.6200) .. controls
      (4191.6800,3780.6200) and (4183.8300,3805.1100) .. (4183.8300,3805.1100) ..
      controls (4224.0400,3805.1100) and (4210.0600,3765.7600) ..
      (4210.0600,3716.7900) .. controls (4210.0600,3667.8200) and
      (4277.3800,3621.4800) .. (4279.1400,3594.3700) .. controls
      (4254.8400,3579.8100) and (4248.3800,3518.1100) .. (4226.2900,3484.4100) ..
      controls (4214.0400,3470.8100) and (4199.0800,3469.4400) ..
      (4183.8300,3463.2100) -- (4168.9600,3401.1300) .. controls
      (4181.2100,3414.2400) and (4212.6800,3422.9900) .. (4212.6800,3422.9900) ..
      controls (4197.8100,3452.7200) and (4217.0500,3460.5900) ..
      (4224.9200,3467.5900) .. controls (4232.7900,3474.5800) and
      (4266.0200,3517.4300) .. (4266.0200,3517.4300) -- (4271.2700,3512.1800) ..
      controls (4271.2700,3512.1800) and (4254.6500,3464.9600) ..
      (4228.4200,3452.7200) .. controls (4221.4300,3437.8500) and
      (4245.9000,3398.5000) .. (4252.0300,3388.8900) .. controls
      (4254.5300,3392.5200) and (4257.7000,3395.3400) .. (4257.7000,3395.3400) ..
      controls (4257.7000,3395.3400) and (4260.3900,3448.0900) ..
      (4268.6300,3457.0900) .. controls (4278.2600,3467.5800) and
      (4280.8800,3466.7100) .. (4299.2600,3459.7100) .. controls
      (4307.1100,3467.5800) and (4302.7500,3488.5700) .. (4295.7400,3501.6900) ..
      controls (4303.6100,3516.5600) and (4315.8600,3487.1500) ..
      (4319.7700,3492.4000) .. controls (4333.7300,3511.2000) and
      (4307.1100,3526.1700) .. (4315.8600,3544.5400) .. controls
      (4315.8600,3544.5400) and (4330.5900,3530.7100) .. (4334.2200,3533.1700) ..
      controls (4337.8500,3535.6200) and (4335.9800,3546.2800) ..
      (4332.4800,3555.9000) .. controls (4314.2200,3599.5300) and
      (4341.7600,3570.6900) .. (4344.7100,3572.5100) .. controls
      (4350.7800,3576.2600) and (4343.8900,3604.3700) .. (4336.0200,3611.3600) ..
      controls (4331.6400,3599.1200) and (4305.3700,3551.5200) ..
      (4291.3900,3518.3000) .. controls (4288.9300,3512.4900) and
      (4275.6400,3510.4300) .. (4294.0000,3567.2700) .. controls
      (4315.8400,3634.9000) and (4340.3500,3624.1000) .. (4350.8400,3620.6100) ..
      controls (4349.9600,3652.0800) and (4318.4800,3654.7100) ..
      (4315.8600,3675.7000) .. controls (4284.3800,3688.8100) and
      (4310.6300,3796.3700) .. (4245.9000,3822.6000) -- (4327.2300,3828.7300) ..
      controls (4311.4800,3812.9900) and (4280.8800,3818.2300) ..
      (4280.8800,3818.2300) .. controls (4280.8800,3818.2300) and
      (4280.8800,3808.6100) .. (4305.3700,3808.6100) .. controls
      (4329.8600,3808.6100) and (4349.4300,3831.3800) .. (4349.4300,3861.9900) ..
      controls (4349.4300,3884.5700) and (4322.1100,3933.5600) ..
      (4296.0200,3933.5600) .. controls (4274.3900,3933.5600) and
      (4265.3700,3900.3700) .. (4260.2500,3902.9100) .. controls
      (4247.3400,3909.3800) and (4256.3700,3915.1300) .. (4261.1100,3923.3400) ..
      controls (4277.6600,3951.9300) and (4305.1200,3945.4700) ..
      (4305.2100,3968.7900) .. controls (4305.3700,4012.7200) and
      (4248.8700,4014.3300) .. (4240.7600,4006.2200) .. controls
      (4234.0600,3999.5100) and (4266.7400,4005.7800) .. (4266.0500,3978.3100) ..
      controls (4265.9400,3973.1200) and (4282.3800,3992.6900) ..
      (4282.3800,3991.2000) .. controls (4282.3800,3970.9200) and
      (4236.7200,3955.5200) .. (4236.7200,3912.3600) -- cycle(3930.4300,3984.8200)
      .. controls (3930.4300,4000.5600) and (3942.0700,4001.9200) ..
      (3945.4900,4001.9200) .. controls (3954.3900,4001.9200) and
      (3953.6900,3975.2400) .. (3957.8100,3969.0900) .. controls
      (3961.9100,3962.9300) and (3973.5400,3965.6600) .. (3975.5900,3961.5600) ..
      controls (3972.1700,3956.0900) and (3960.5500,3949.2400) ..
      (3960.5500,3941.0400) .. controls (3960.5500,3932.8300) and
      (3968.0700,3930.0900) .. (3971.4800,3930.0900) .. controls
      (3976.2700,3930.0900) and (3996.8000,3935.5700) .. (3996.8000,3947.8800) ..
      controls (3996.8000,3954.0300) and (3992.0900,3957.3700) ..
      (3989.9600,3961.5600) .. controls (3987.8100,3965.7500) and
      (3988.2400,3970.8000) .. (3986.5400,3971.8300) .. controls
      (3994.7500,3972.5000) and (4002.9700,3975.2400) .. (4009.1200,3975.2400) ..
      controls (4015.2700,3975.2400) and (4015.9600,3971.1400) ..
      (4015.9600,3965.6700) .. controls (4015.9600,3960.1900) and
      (4004.3200,3956.0900) .. (4004.3200,3950.6200) .. controls
      (4004.3200,3945.1400) and (4019.3800,3930.7700) .. (4024.1600,3930.7700) ..
      controls (4028.9600,3930.7700) and (4039.9000,3934.8800) ..
      (4039.9000,3942.4100) .. controls (4039.9000,3949.9400) and
      (4035.4500,3959.1700) .. (4039.9000,3963.6200) .. controls
      (4042.6400,3966.3500) and (4048.7900,3960.8700) .. (4048.7900,3960.8700) ..
      controls (4058.0300,3970.1200) and (4063.8500,3988.9200) ..
      (4082.3200,3990.9800) .. controls (4100.7800,3958.8300) and
      (4062.4800,3946.5100) .. (4062.4800,3946.5100) -- (4047.4200,3952.6700) ..
      controls (4053.2800,3934.0700) and (4037.3400,3927.7600) ..
      (4037.8500,3920.5200) .. controls (4039.3200,3899.7900) and
      (4035.1000,3893.2600) .. (4027.5800,3886.3000) .. controls
      (4022.8100,3887.6700) and (4012.5400,3888.3600) .. (4011.8600,3884.2500) ..
      controls (4021.4300,3867.1500) and (3992.7000,3848.6800) ..
      (3996.1100,3841.1500) .. controls (3992.0100,3843.8900) and
      (3982.4400,3864.4100) .. (3979.0000,3868.5200) .. controls
      (3975.5900,3872.6200) and (3981.9900,3878.6000) .. (3978.3400,3888.3600) ..
      controls (3976.2700,3893.8300) and (3963.9600,3887.6700) ..
      (3962.6000,3897.2600) .. controls (3961.2300,3906.8300) and
      (3964.3800,3926.8500) .. (3952.7500,3933.7000) .. controls
      (3952.7500,3953.5400) and (3930.4300,3966.3600) .. (3930.4300,3984.8200) --
      cycle(3998.1400,4022.4600) -- (4000.2100,4017.6600) .. controls
      (3995.4100,4016.3000) and (3994.7500,3990.2900) .. (3982.4200,3990.2900) ..
      controls (3967.3600,3990.2900) and (3979.0000,4008.7600) ..
      (3967.3600,4012.1900) .. controls (3967.3600,4012.1900) and
      (3989.2600,4014.2400) .. (3998.1400,4022.4600) -- cycle(4015.2500,4020.4000)
      .. controls (4020.7200,4012.8700) and (4033.7500,4003.3000) ..
      (4043.3000,4011.5000) .. controls (4047.4200,4010.1400) and
      (4048.7700,4008.7600) .. (4044.0000,4003.2900) .. controls
      (4039.2200,3997.8200) and (4039.1800,3984.0300) .. (4029.6300,3984.8200) ..
      controls (4013.2000,3986.2000) and (4020.0600,4010.1400) ..
      (4013.8900,4015.6200) -- (4015.2500,4020.4000) -- cycle(3912.6000,3866.2400)
      .. controls (3917.3400,3870.1200) and (3930.4700,3890.4000) ..
      (3943.0700,3890.4000) .. controls (3942.0100,3883.0500) and
      (3923.1100,3867.2900) .. (3916.8000,3854.6800) .. controls
      (3910.5100,3842.0800) and (3921.0000,3829.4700) .. (3926.2500,3820.0200) ..
      controls (3925.2100,3828.4300) and (3945.1800,3842.0800) ..
      (3951.4600,3849.4400) .. controls (3957.7700,3856.7900) and
      (3962.9500,3854.3000) .. (3958.8100,3845.2300) .. controls
      (3953.5700,3833.6800) and (3937.0700,3821.6400) .. (3936.7600,3804.2600) ..
      controls (3936.5800,3794.9700) and (3943.7300,3788.3700) ..
      (3952.5200,3783.2500) .. controls (3952.5200,3783.2500) and
      (3955.6600,3813.7200) .. (3968.2800,3805.3200) .. controls
      (3973.3800,3801.9200) and (3948.3200,3754.8900) .. (3968.2800,3737.0300) ..
      controls (3971.4300,3750.6900) and (4001.8800,3773.7900) ..
      (4001.8800,3780.1100) .. controls (4001.8800,3786.4100) and
      (3991.3900,3807.4100) .. (4001.8800,3807.4100) .. controls
      (4008.1800,3807.4100) and (4013.4400,3788.5100) .. (4017.6400,3788.5100) ..
      controls (4021.8600,3788.5100) and (4030.2500,3792.7000) ..
      (4030.2500,3800.0600) .. controls (4030.2500,3807.4200) and
      (4011.3500,3838.9300) .. (4022.8900,3838.9300) .. controls
      (4028.2600,3838.9300) and (4040.7600,3817.9200) .. (4043.9100,3817.9200) ..
      controls (4047.0500,3817.9200) and (4050.2100,3820.0200) ..
      (4053.3600,3836.8300) .. controls (4056.5000,3853.6300) and
      (4038.6500,3859.9500) .. (4044.9600,3876.7500) .. controls
      (4044.9600,3876.7500) and (4061.7600,3868.3500) .. (4067.0100,3858.8900) ..
      controls (4072.2700,3849.4400) and (4082.7700,3875.7000) ..
      (4083.8300,3884.1000) .. controls (4080.5700,3887.9100) and
      (4076.8800,3901.3300) .. (4071.2100,3909.3100) .. controls
      (4065.9600,3916.7600) and (4058.6100,3918.8400) .. (4058.6100,3920.8700) ..
      controls (4058.6100,3925.0600) and (4064.9200,3926.1100) ..
      (4085.9400,3949.2300) .. controls (4106.9500,3972.3400) and
      (4103.7300,3998.8100) .. (4103.7900,4002.8000) .. controls
      (4091.1900,4014.3600) and (4080.6800,3997.5500) .. (4070.1800,4002.8000) ..
      controls (4059.6700,4008.0600) and (4064.9200,4040.6200) ..
      (4061.7600,4052.1800) .. controls (4061.7600,4052.1800) and
      (4048.1100,4030.1200) .. (4044.9600,4033.2700) .. controls
      (4041.8200,4036.4200) and (4046.0200,4045.8800) .. (4049.1600,4056.3800) ..
      controls (4052.3000,4066.8700) and (4034.4500,4072.1400) ..
      (4034.4500,4072.1400) .. controls (4034.4500,4072.1400) and
      (4030.2500,4050.0700) .. (4022.8900,4051.1200) .. controls
      (4015.5500,4052.1800) and (4017.6400,4073.1900) .. (4017.6400,4073.1900) ..
      controls (4017.6400,4073.1900) and (4002.9300,4081.5900) ..
      (3999.7900,4063.7400) .. controls (3996.0700,4042.6300) and
      (3986.1300,4060.5800) .. (3980.8800,4070.0300) .. controls
      (3973.5400,4066.8700) and (3976.6800,4042.7200) .. (3976.6800,4034.3200) ..
      controls (3976.6800,4025.9100) and (3961.9700,4041.6700) ..
      (3954.6300,4044.8200) .. controls (3956.7200,4037.4700) and
      (3948.3800,4026.5200) .. (3948.3800,4018.1200) .. controls
      (3948.3800,4009.7200) and (3921.0000,4022.7200) .. (3914.7100,4016.4100) ..
      controls (3914.6500,4013.1300) and (3910.8000,3986.5600) ..
      (3916.0700,3971.5100) .. controls (3922.8700,3952.1700) and
      (3933.7700,3943.6100) .. (3933.7700,3932.0600) .. controls
      (3933.7700,3921.3400) and (3917.0100,3916.0100) .. (3886.7000,3896.8900) ..
      controls (3900.5500,3894.9100) and (3901.0500,3856.7900) ..
      (3912.6000,3866.2400);
    \path[fill=c231f20,nonzero rule] (3357.3600,5024.1800) .. controls
      (3348.2100,5021.6800) and (3299.6000,5033.6100) .. (3294.2300,5054.0400) ..
      controls (3286.2000,5084.5700) and (3324.0800,5106.5500) ..
      (3324.0800,5160.6400) .. controls (3324.0800,5209.7400) and
      (3273.3200,5219.7300) .. (3259.1800,5219.7300) .. controls
      (3241.7000,5219.7300) and (3200.1000,5212.2400) .. (3200.1000,5172.2900) ..
      controls (3200.1000,5132.3500) and (3237.4600,5128.5300) ..
      (3237.4600,5128.5300) .. controls (3217.2700,5063.2700) and
      (3239.4400,5015.4000) .. (3268.0900,4995.7500) .. controls
      (3305.0500,4968.1900) and (3348.3700,4983.3200) .. (3348.4100,4968.7300) ..
      controls (3342.4900,4967.0400) and (3312.6600,4924.3900) ..
      (3299.3400,4908.9900) .. controls (3290.3300,4897.4800) and
      (3284.5900,4889.9100) .. (3284.5900,4883.7700) .. controls
      (3284.5900,4871.9300) and (3331.2300,4880.3500) .. (3361.2500,4886.3900) ..
      controls (3361.2500,4886.3900) and (3335.6000,4857.9100) ..
      (3305.2100,4855.1700) .. controls (3300.8700,4854.9000) and
      (3301.6400,4855.0300) .. (3298.3200,4855.0800) .. controls
      (3291.8100,4855.6800) and (3283.5700,4857.6200) .. (3279.9200,4861.2900) ..
      controls (3274.0500,4867.1400) and (3261.9300,4880.0600) ..
      (3272.8900,4909.0500) .. controls (3276.2400,4917.8900) and
      (3277.0500,4919.9800) .. (3284.1500,4929.9400) .. controls
      (3293.4300,4942.9500) and (3192.4200,4923.5000) .. (3203.1700,4836.1100) ..
      controls (3208.0600,4799.8500) and (3227.8100,4802.9900) ..
      (3212.9200,4795.9600) .. controls (3207.1300,4789.7600) and
      (3201.2000,4774.7400) .. (3201.2000,4774.7400) .. controls
      (3201.2000,4774.7400) and (3196.8600,4813.2900) .. (3192.2500,4853.0400) ..
      controls (3188.9400,4881.5700) and (3184.7900,4886.7300) ..
      (3183.1400,4914.4400) .. controls (3182.1700,4930.5900) and
      (3188.4200,4942.0400) .. (3203.4800,4942.7600) .. controls
      (3227.0100,4943.8800) and (3245.5800,4937.9100) .. (3239.0400,4989.9500) ..
      controls (3220.9700,5133.8800) and (3083.8900,5172.3800) ..
      (3080.5900,5170.0000) .. controls (3080.5900,5170.0000) and
      (3080.2100,5156.7100) .. (3095.2500,5138.1800) .. controls
      (3110.4500,5119.4400) and (3119.2200,5095.0800) .. (3119.2200,5080.1000) ..
      controls (3082.6200,5098.4500) and (3027.0900,5112.8200) ..
      (3027.0900,5112.8200) .. controls (3027.0900,5112.8200) and
      (3026.5800,5103.8100) .. (3027.0900,5099.3400) .. controls
      (3034.1200,5083.5100) and (3067.8900,5025.4600) .. (3072.4000,4989.4100) ..
      controls (3054.6800,5013.9400) and (3038.3200,5023.4800) ..
      (3038.3200,5023.4800) .. controls (3042.0200,5008.7100) and
      (3043.0700,4984.8400) .. (3043.5200,4921.0600) .. controls
      (3044.2400,4820.0400) and (3043.9600,4683.2400) .. (3083.5500,4606.5900) ..
      controls (3087.6800,4598.6200) and (3087.7700,4528.2300) ..
      (3119.3800,4528.2300) .. controls (3151.0000,4528.2300) and
      (3150.1800,4524.9000) .. (3150.1800,4524.9000) .. controls
      (3150.1800,4524.9000) and (3165.1500,4510.7600) .. (3172.6400,4511.5900) ..
      controls (3172.6400,4511.5900) and (3132.3600,4394.8400) ..
      (3098.6000,4278.9200) .. controls (3067.1500,4269.0600) and
      (3051.2500,4295.9500) .. (3039.6600,4296.8800) .. controls
      (3028.0700,4297.8000) and (3018.9800,4228.2200) .. (3053.3200,4156.6300) ..
      controls (3053.3200,4156.6300) and (3033.5500,4146.7400) ..
      (3033.5500,4120.1700) .. controls (3033.5500,4088.4800) and
      (3055.0800,4024.0400) .. (3105.1200,3990.3400) .. controls
      (3105.1200,3990.3400) and (3111.2500,3987.2800) .. (3107.1600,3999.5400) ..
      controls (3103.0700,4011.8100) and (3112.7300,4054.7500) ..
      (3118.5500,4062.2400) .. controls (3155.1600,4030.6200) and
      (3204.2700,4054.0600) .. (3204.2700,4054.0600) -- (3195.0700,4069.4000) ..
      controls (3195.0700,4069.4000) and (3184.8400,4062.9200) ..
      (3189.9600,4144.6700) .. controls (3197.6400,4142.2700) and
      (3198.2800,4124.2600) .. (3199.1000,4123.9400) .. controls
      (3203.3400,4123.1800) and (3207.0100,4122.8700) .. (3208.3400,4124.7500) ..
      controls (3215.1400,4134.4800) and (3235.9600,4189.3400) ..
      (3235.9600,4189.3400) .. controls (3237.9100,4197.3500) and
      (3249.3200,4193.8400) .. (3267.0500,4218.8400) .. controls
      (3274.2600,4228.1100) and (3277.8700,4246.0100) .. (3277.8700,4246.0100) ..
      controls (3306.4900,4256.2300) and (3307.5200,4298.1400) ..
      (3307.5200,4298.1400) .. controls (3316.7400,4298.1400) and
      (3329.5300,4334.5400) .. (3328.2000,4363.7800) .. controls
      (3331.3700,4376.4100) and (3337.8600,4377.9400) .. (3340.2200,4387.0700) ..
      controls (3346.3600,4377.8800) and (3401.5600,4349.2500) ..
      (3401.5600,4263.3800) .. controls (3401.5600,4201.0300) and
      (3373.9500,4200.9200) .. (3382.1300,4175.4700) .. controls
      (3382.9300,4172.9700) and (3369.4500,4161.2500) .. (3331.1900,4164.2800) ..
      controls (3306.5400,4166.2400) and (3281.8200,4187.7400) ..
      (3272.7500,4189.3400) .. controls (3249.5900,4193.4200) and
      (3250.9500,4181.1600) .. (3244.1400,4163.4400) .. controls
      (3237.3400,4145.7800) and (3207.2300,3949.7400) .. (3270.8200,3818.4400) ..
      controls (3247.5300,3823.4200) and (3174.9700,3820.6400) ..
      (3165.7600,3843.1300) .. controls (3158.8400,3860.0700) and
      (3184.9800,3882.9200) .. (3184.9800,3882.9200) .. controls
      (3184.9800,3882.9200) and (3178.5600,3913.4400) .. (3122.3200,3907.0200) ..
      controls (3076.3300,3901.7700) and (3042.8000,3874.2700) ..
      (3025.3300,3833.4900) -- (3039.5100,3831.1900) .. controls
      (3039.5100,3831.1900) and (3020.7100,3817.3400) .. (3018.3200,3796.8400) ..
      controls (3017.1600,3786.9400) and (3017.6400,3772.6300) ..
      (3017.6400,3772.6300) -- (3032.4300,3778.6800) .. controls
      (3032.4300,3778.6800) and (3031.4600,3768.9500) .. (3041.8200,3719.4300) ..
      controls (3049.9100,3675.4900) and (3067.3800,3665.0700) ..
      (3067.3800,3665.0700) .. controls (3067.3800,3665.0700) and
      (3068.4400,3673.2600) .. (3069.2200,3677.8700) -- (3077.5200,3727.7300) ..
      controls (3079.3900,3736.5800) and (3120.4500,3729.7800) ..
      (3120.4500,3729.7800) .. controls (3120.4500,3729.7800) and
      (3106.0100,3724.5800) .. (3095.8000,3718.5200) -- (3096.2400,3718.2500) ..
      controls (3092.5600,3714.9800) and (3088.2600,3698.6000) ..
      (3086.9100,3686.9900) -- (3086.9300,3686.9600) .. controls
      (3095.4500,3686.8800) and (3113.7100,3685.6700) .. (3134.7600,3679.5800) ..
      controls (3146.3700,3676.2200) and (3153.1400,3667.3100) ..
      (3167.4700,3663.2300) .. controls (3171.8200,3661.9800) and
      (3181.3200,3662.4400) .. (3185.8700,3661.1800) .. controls
      (3200.3900,3657.1500) and (3214.9200,3653.3300) .. (3231.0400,3649.5500) ..
      controls (3235.0400,3648.6100) and (3241.1000,3650.8300) ..
      (3245.1600,3649.9400) .. controls (3262.4600,3646.1400) and
      (3277.8700,3639.7200) .. (3302.4000,3640.7400) .. controls
      (3316.6600,3641.3300) and (3325.4200,3633.6000) .. (3339.8900,3632.8700) ..
      controls (3380.6100,3630.8300) and (3394.8000,3651.1800) ..
      (3411.4500,3644.5200) .. controls (3410.6100,3654.5100) and
      (3428.0900,3668.6600) .. (3387.3200,3701.1000) .. controls
      (3387.3200,3720.2400) and (3411.4500,3728.5600) .. (3411.4500,3728.5600) ..
      controls (3415.8600,3766.8200) and (3368.1600,3824.0600) ..
      (3368.1600,3824.0600) .. controls (3368.1600,3824.0600) and
      (3362.4200,3857.2900) .. (3359.0200,3890.8300) .. controls
      (3352.0600,3959.5700) and (3373.6100,4032.6000) .. (3373.6100,4032.6000) ..
      controls (3373.6100,4032.6000) and (3381.8000,4035.3500) ..
      (3387.3200,4036.4500) .. controls (3387.3200,4036.4500) and
      (3389.4700,4033.5900) .. (3384.8200,4022.2900) .. controls
      (3381.7000,4014.7300) and (3361.5200,3951.5700) .. (3388.9800,3865.8600) ..
      controls (3413.2600,3790.0400) and (3479.6700,3751.0300) ..
      (3479.6700,3709.4300) -- (3462.2100,3711.1000) .. controls
      (3423.9300,3672.8300) and (3425.0200,3484.9600) .. (3416.7000,3466.6600) ..
      controls (3410.2900,3466.1800) and (3403.1600,3463.5500) ..
      (3398.7900,3466.6600) .. controls (3380.2300,3479.7600) and
      (3369.8600,3494.2100) .. (3359.5300,3501.1000) .. controls
      (3356.8600,3502.8900) and (3350.5400,3509.7700) .. (3347.6700,3508.2000) ..
      controls (3343.3700,3508.4900) and (3325.2300,3493.3000) ..
      (3320.7000,3490.8700) .. controls (3268.7300,3462.9600) and
      (3265.8300,3383.8200) .. (3281.2100,3338.4800) .. controls
      (3283.7100,3338.3800) and (3297.1500,3358.4800) .. (3300.9200,3362.6300) ..
      controls (3300.9200,3362.6300) and (3311.3300,3253.2200) ..
      (3351.2600,3242.7500) -- (3355.9400,3250.2300) .. controls
      (3355.9400,3250.2300) and (3358.7300,3321.2000) .. (3372.4400,3315.4800) ..
      controls (3374.1000,3314.7800) and (3384.7300,3280.0200) ..
      (3396.0200,3269.8900) .. controls (3416.5600,3251.4600) and
      (3411.5200,3251.8900) .. (3431.3900,3243.1500) .. controls
      (3452.1500,3238.4300) and (3463.5500,3232.4400) .. (3463.5500,3232.4400) ..
      controls (3463.5500,3233.9500) and (3461.9300,3238.5700) ..
      (3459.9800,3244.7500) .. controls (3462.0500,3251.8100) and
      (3446.3300,3266.7400) .. (3454.7300,3288.3900) .. controls
      (3454.7300,3288.3900) and (3500.4700,3354.9600) .. (3501.3100,3368.2700) ..
      controls (3520.4500,3356.6200) and (3543.7900,3353.9900) ..
      (3543.7900,3353.9900) -- (3550.8000,3367.4500) .. controls
      (3550.8000,3367.4500) and (3538.5400,3386.5400) .. (3546.2500,3395.7400) ..
      controls (3557.4600,3409.1100) and (3571.7200,3437.3300) ..
      (3583.2800,3473.9600) .. controls (3584.5900,3478.1100) and
      (3582.6200,3485.6700) .. (3583.8900,3489.9700) .. controls
      (3589.1600,3507.7400) and (3597.4000,3523.4300) .. (3601.9500,3542.6300) ..
      controls (3603.4000,3548.6700) and (3610.9600,3557.8800) ..
      (3612.1900,3563.8600) .. controls (3613.2200,3568.9400) and
      (3610.8800,3578.5400) .. (3611.8000,3583.4700) .. controls
      (3620.8800,3632.2200) and (3623.4400,3672.4800) .. (3613.6500,3677.8200) ..
      controls (3625.2900,3680.3200) and (3632.7900,3686.9700) ..
      (3632.7900,3686.9700) .. controls (3632.7900,3686.9700) and
      (3618.6500,3689.4600) .. (3618.6500,3704.4400) .. controls
      (3618.6500,3719.4200) and (3642.7700,3736.9000) .. (3621.1300,3780.1700) ..
      controls (3606.1500,3770.1900) and (3602.8300,3769.3500) ..
      (3590.3500,3769.3500) .. controls (3569.1400,3769.3500) and
      (3549.6300,3845.3000) .. (3543.3600,3872.3000) -- (3547.9500,3877.2300) ..
      controls (3555.5900,3872.8100) and (3569.1800,3866.7100) ..
      (3586.1900,3866.7100) .. controls (3612.8100,3866.7100) and
      (3649.4300,3877.5200) .. (3649.4300,3959.9000) .. controls
      (3649.4300,4007.3300) and (3621.1300,4113.0000) .. (3621.1300,4113.0000) ..
      controls (3666.0700,4137.1300) and (3648.2200,4257.7200) ..
      (3642.7700,4272.7100) .. controls (3637.3200,4287.7000) and
      (3607.6000,4391.0500) .. (3633.6100,4462.4900) .. controls
      (3597.0500,4442.5500) and (3571.1500,4316.5200) .. (3571.1500,4316.5200) ..
      controls (3557.3400,4378.6700) and (3617.7700,4440.8200) ..
      (3621.1300,4543.2100) .. controls (3623.1100,4603.0900) and
      (3577.0300,4650.5500) .. (3577.0300,4650.5500) .. controls
      (3577.0300,4650.5500) and (3585.3700,4681.3300) .. (3601.1700,4681.3300) ..
      controls (3616.9700,4681.3300) and (3612.8100,4628.9200) ..
      (3612.8100,4628.9200) .. controls (3637.7700,4638.0700) and
      (3649.4300,4658.8700) .. (3649.4300,4687.9900) .. controls
      (3649.4300,4717.1100) and (3630.2900,4752.9000) .. (3578.6900,4752.9000) ..
      controls (3527.1100,4752.9000) and (3500.3700,4699.0800) ..
      (3500.3700,4656.6400) .. controls (3500.3700,4614.2000) and
      (3531.2700,4539.8800) .. (3531.2700,4539.8800) .. controls
      (3531.2700,4539.8800) and (3513.4600,4476.4300) .. (3511.6400,4445.4300) ..
      controls (3508.4400,4391.0600) and (3505.2300,4326.0000) ..
      (3527.6200,4243.9300) .. controls (3556.1100,4159.8800) and
      (3601.2300,4045.6200) .. (3601.2300,3964.8900) .. controls
      (3601.2300,3944.4400) and (3591.7000,3936.2700) .. (3591.7000,3936.2700) ..
      controls (3564.8000,3943.9500) and (3524.7100,4117.5700) ..
      (3509.7700,4266.2500) .. controls (3500.6100,4322.9300) and
      (3491.4100,4391.2300) .. (3490.1600,4430.7300) -- (3483.3400,4487.1500) --
      (3496.4100,4483.4000) .. controls (3497.1100,4485.4400) and
      (3497.8500,4487.2800) .. (3498.6100,4488.9300) .. controls
      (3495.9200,4506.2100) and (3488.8300,4553.9000) .. (3488.8300,4578.1600) ..
      controls (3488.8300,4608.1100) and (3492.1700,4748.7300) ..
      (3502.1500,4787.8500) .. controls (3514.6300,4767.0400) and
      (3575.3700,4763.7100) .. (3575.3700,4763.7100) .. controls
      (3538.7500,4837.7700) and (3558.7300,4922.6400) .. (3557.0700,4931.8000) ..
      controls (3590.3500,4924.3100) and (3608.6500,4947.6000) ..
      (3616.1500,4950.1000) .. controls (3577.8700,4974.2300) and
      (3582.0300,5018.3400) .. (3576.2100,5020.8400) .. controls
      (3576.2100,5020.8400) and (3594.6300,5028.4600) .. (3604.4900,5038.3100) ..
      controls (3610.5500,5044.3700) and (3622.8100,5076.5800) ..
      (3622.8100,5094.8900) .. controls (3622.8100,5113.2000) and
      (3617.8100,5139.0000) .. (3605.3300,5143.9800) .. controls
      (3615.3100,5153.1400) and (3621.9700,5166.4600) .. (3621.1300,5183.9300) ..
      controls (3638.6100,5200.5700) and (3641.9300,5255.5100) ..
      (3645.2700,5262.1600) .. controls (3631.9500,5249.6800) and
      (3580.3700,5203.9200) .. (3523.7900,5203.9200) .. controls
      (3502.9900,5203.9200) and (3495.4900,5207.2400) .. (3478.0100,5207.2400) ..
      controls (3438.9100,5207.2400) and (3416.4500,5180.6100) ..
      (3416.4500,5180.6100) .. controls (3375.6600,5180.6100) and
      (3333.2300,5166.4700) .. (3333.2300,5166.4700) .. controls
      (3333.2300,5151.2000) and (3332.8900,5068.2100) .. (3357.3600,5024.1800);
    \path[fill=cf9ae0c,nonzero rule] (3060.9800,4112.8600) .. controls
      (3060.9800,4112.8600) and (3050.7900,4114.7100) .. (3046.1600,4118.4100) ..
      controls (3045.2300,4103.5900) and (3056.6700,4058.9700) ..
      (3081.4600,4032.0300) .. controls (3059.9000,4079.4500) and
      (3060.9800,4095.2500) .. (3060.9800,4112.8600) -- cycle(3061.4600,4252.8200)
      -- (3045.6300,4265.2000) .. controls (3045.6300,4265.2000) and
      (3037.0300,4242.0600) .. (3050.2500,4206.2800) .. controls
      (3052.4200,4240.7700) and (3049.2700,4240.9600) .. (3061.4600,4252.8200) --
      cycle(3132.2600,4091.9800) .. controls (3127.8500,4103.4100) and
      (3122.9500,4113.0100) .. (3113.2900,4113.0100) .. controls
      (3103.6300,4113.0100) and (3101.0300,4111.9900) .. (3101.0300,4111.9900) ..
      controls (3112.8800,4093.5400) and (3132.3800,4069.4000) ..
      (3132.3800,4069.4000) .. controls (3132.3800,4069.4000) and
      (3158.2700,4066.6600) .. (3173.2600,4062.5800) .. controls
      (3156.5800,4072.2400) and (3136.6600,4080.5600) .. (3132.2600,4091.9800) --
      cycle(3048.5900,3840.0400) .. controls (3077.5200,3874.8300) and
      (3104.0900,3878.9200) .. (3104.0900,3878.9200) .. controls
      (3103.2000,3881.0500) and (3103.1200,3892.0900) .. (3085.2800,3884.8500) ..
      controls (3072.2700,3878.0400) and (3061.4700,3867.0000) ..
      (3048.5900,3840.0400) -- cycle(3155.2000,3876.5500) .. controls
      (3142.0900,3867.7200) and (3135.0400,3888.2100) .. (3113.5400,3879.1600) ..
      controls (3134.9600,3873.4500) and (3142.0900,3857.4000) ..
      (3156.1500,3850.3700) .. controls (3152.6400,3864.4200) and
      (3169.2400,3880.5900) .. (3169.2400,3880.5900) .. controls
      (3169.2400,3880.5900) and (3162.3400,3910.1000) .. (3116.6400,3894.8700) ..
      controls (3136.8600,3891.3500) and (3151.8700,3899.6200) ..
      (3155.2000,3876.5500) -- cycle(3261.4300,3652.6000) .. controls
      (3318.5400,3652.6000) and (3323.8100,3676.3200) .. (3329.9600,3676.3200) ..
      controls (3336.1100,3676.3200) and (3337.8800,3671.9200) ..
      (3337.8800,3668.4100) .. controls (3337.8800,3664.9000) and
      (3321.1700,3658.7500) .. (3320.2900,3650.8400) .. controls
      (3364.2200,3642.9200) and (3379.1600,3662.2600) .. (3396.7400,3661.3800) ..
      controls (3396.7400,3679.8400) and (3371.2500,3686.8600) ..
      (3371.2500,3701.8000) .. controls (3371.2500,3726.4100) and
      (3393.2200,3738.7100) .. (3393.2200,3738.7100) .. controls
      (3393.2200,3807.2500) and (3342.2800,3767.7100) .. (3342.2800,3912.7000) ..
      controls (3342.2800,3968.9300) and (3350.1900,4018.1400) ..
      (3361.5800,4023.4100) .. controls (3323.8100,4019.0200) and
      (3335.2300,3896.0000) .. (3335.2300,3896.0000) .. controls
      (3335.2300,3896.0000) and (3332.6100,3883.7000) .. (3327.3200,3885.4600) ..
      controls (3322.0500,3887.2200) and (3329.1100,3898.6400) ..
      (3315.9000,3898.6400) .. controls (3305.3600,3898.6400) and
      (3319.4200,3910.9300) .. (3325.5700,3908.3000) .. controls
      (3331.7200,3905.6600) and (3326.5200,3924.1200) .. (3321.1700,3924.1200) ..
      controls (3311.5000,3924.1200) and (3307.7300,3938.1800) ..
      (3321.1700,3938.1800) .. controls (3331.7200,3938.1800) and
      (3327.3200,3949.6000) .. (3322.0500,3953.1200) .. controls
      (3316.7800,3956.6300) and (3303.6000,3961.8900) .. (3320.2900,3968.0500) ..
      controls (3320.2900,3968.0500) and (3325.5700,3976.8500) ..
      (3317.6600,3979.4800) .. controls (3309.7500,3982.1100) and
      (3316.7800,3988.2600) .. (3315.9000,3997.0500) .. controls
      (3324.6900,3992.6600) and (3331.2500,3992.6400) .. (3330.8400,4005.8400) ..
      controls (3330.2000,4027.3300) and (3382.6800,4064.7200) ..
      (3398.5000,4048.0200) .. controls (3406.4100,4056.8000) and
      (3397.6200,4061.2100) .. (3397.6200,4073.5000) .. controls
      (3397.6200,4085.8000) and (3406.4100,4108.6500) .. (3406.4100,4108.6500) ..
      controls (3417.8300,4108.6500) and (3400.2500,4073.5000) ..
      (3412.5600,4073.5000) .. controls (3413.4400,4085.8000) and
      (3423.9800,4108.6400) .. (3417.8300,4116.5600) .. controls
      (3411.6800,4124.4700) and (3414.5500,4128.4000) .. (3407.5200,4144.2100) ..
      controls (3401.3700,4158.0300) and (3388.8900,4160.8700) ..
      (3388.8900,4160.8700) .. controls (3374.8200,4156.4700) and
      (3329.9600,4140.2800) .. (3267.5800,4178.9500) .. controls
      (3267.5800,4178.9500) and (3260.4900,4181.7400) .. (3256.1500,4168.4000) ..
      controls (3250.2000,4150.0800) and (3246.4800,4104.9100) ..
      (3246.4800,4012.8700) .. controls (3246.4800,3870.5200) and
      (3301.8500,3800.2100) .. (3301.8500,3789.6700) .. controls
      (3301.8500,3779.1300) and (3278.1300,3803.7300) .. (3256.1500,3803.7300) ..
      controls (3195.5200,3803.7300) and (3158.6100,3805.4900) ..
      (3119.0700,3866.1200) -- (3104.1400,3863.4800) -- (3138.6500,3825.0700) ..
      controls (3125.4700,3825.0700) and (3097.1100,3857.3300) ..
      (3097.1100,3857.3300) .. controls (3097.1100,3857.3300) and
      (3034.7100,3823.9700) .. (3034.7100,3802.8500) .. controls
      (3034.7100,3782.6500) and (3042.1300,3811.1400) .. (3059.3200,3809.8900) ..
      controls (3079.4900,3808.4200) and (3103.2500,3830.0900) ..
      (3109.4100,3826.5800) .. controls (3111.6600,3825.2900) and
      (3122.4600,3809.9300) .. (3141.9100,3801.9700) .. controls
      (3175.5400,3788.2300) and (3231.3500,3777.2700) .. (3224.5200,3775.6200) ..
      controls (3203.8500,3770.6200) and (3101.6700,3796.8400) ..
      (3089.5700,3801.5400) -- (3058.6500,3784.7300) .. controls
      (3067.1400,3782.4600) and (3132.2900,3765.5500) .. (3127.2200,3764.5700) ..
      controls (3106.3800,3760.5300) and (3052.3800,3780.4800) ..
      (3050.0500,3777.2100) .. controls (3050.0500,3714.3800) and
      (3061.6000,3694.3800) .. (3061.6000,3694.3800) .. controls
      (3065.8800,3725.3700) and (3068.6600,3750.6200) .. (3077.4700,3749.7700) ..
      controls (3099.3600,3747.6700) and (3146.3100,3746.7500) ..
      (3146.3100,3729.0400) .. controls (3146.3100,3714.1000) and
      (3099.7500,3713.2200) .. (3100.6300,3700.9200) .. controls
      (3112.9300,3699.1600) and (3152.4700,3693.0100) .. (3160.3700,3697.4100) ..
      controls (3168.2800,3701.8000) and (3187.6200,3709.7100) ..
      (3187.6200,3702.6800) .. controls (3187.6200,3688.6200) and
      (3157.7300,3687.7400) .. (3157.7300,3687.7400) .. controls
      (3157.7300,3687.7400) and (3170.0400,3677.1900) .. (3192.8800,3677.1900) ..
      controls (3215.7300,3677.1900) and (3216.6000,3689.5000) ..
      (3216.6000,3689.5000) .. controls (3251.7600,3689.5000) and
      (3205.2000,3672.8000) .. (3203.4400,3668.4100) .. controls
      (3213.9700,3666.6500) and (3250.0000,3662.2600) .. (3257.0300,3667.5300) ..
      controls (3264.0600,3672.8000) and (3281.6400,3683.3600) ..
      (3285.1600,3678.0800) .. controls (3288.6700,3672.8000) and
      (3267.5700,3659.6200) .. (3261.4300,3652.6000) -- cycle(3097.3600,4218.2900)
      .. controls (3086.6200,4184.2900) and (3072.3800,4148.5600) ..
      (3048.7800,4129.7700) .. controls (3048.7800,4129.7700) and
      (3058.4400,4128.8900) .. (3061.9500,4127.1300) .. controls
      (3068.9800,4132.4100) and (3089.2000,4168.4400) .. (3096.2300,4175.4600) ..
      controls (3094.4700,4165.8000) and (3077.7800,4126.2500) ..
      (3070.7400,4118.3400) .. controls (3071.6200,4102.5300) and
      (3087.4400,4047.1700) .. (3097.1100,4025.2000) .. controls
      (3097.1100,4043.6600) and (3102.3800,4074.4100) .. (3110.2900,4076.1700) ..
      controls (3097.1100,4088.4700) and (3095.3500,4113.0800) ..
      (3086.5600,4115.7100) .. controls (3097.1100,4138.5600) and
      (3115.5600,4190.4100) .. (3115.5600,4202.7000) .. controls
      (3115.5600,4215.0000) and (3125.6600,4250.5900) .. (3129.6300,4246.6400) ..
      controls (3133.5700,4242.6900) and (3115.5600,4152.6100) ..
      (3105.9000,4130.6400) -- (3116.4400,4125.3800) .. controls
      (3116.4400,4125.3800) and (3126.9700,4167.5600) .. (3139.2900,4193.9200) ..
      controls (3142.8100,4171.9500) and (3126.9700,4120.1000) ..
      (3126.9700,4120.1000) .. controls (3141.0400,4090.2200) and
      (3161.0500,4073.8800) .. (3176.0000,4072.1200) .. controls
      (3154.1900,4108.9200) and (3190.2500,4157.8900) .. (3178.8300,4185.1300) ..
      controls (3183.2200,4197.4300) and (3198.7700,4176.3200) ..
      (3201.8900,4162.9700) .. controls (3204.7500,4150.7200) and
      (3204.3200,4146.4600) .. (3204.3200,4146.4600) .. controls
      (3204.3200,4146.4600) and (3215.7400,4166.6800) .. (3215.7400,4194.8000) ..
      controls (3215.7400,4222.9100) and (3206.9500,4236.0900) ..
      (3206.9500,4245.7600) .. controls (3218.3800,4245.7600) and
      (3227.7800,4224.9400) .. (3227.7800,4212.5100) .. controls
      (3227.7800,4202.9700) and (3256.1500,4207.9700) .. (3262.3100,4251.9100) ..
      controls (3265.9600,4278.0100) and (3235.9400,4296.7200) ..
      (3235.9400,4296.7200) .. controls (3235.9400,4296.7200) and
      (3279.0000,4291.4500) .. (3278.1300,4267.7300) .. controls
      (3286.9100,4275.6300) and (3301.8600,4296.7200) .. (3281.6400,4325.7200) ..
      controls (3261.4300,4354.7200) and (3263.1900,4357.3600) ..
      (3278.1300,4350.3300) .. controls (3293.0700,4343.3000) and
      (3301.8500,4325.7300) .. (3301.8500,4316.0600) .. controls
      (3308.0100,4311.6700) and (3319.4200,4335.3900) .. (3314.1500,4360.8700) ..
      controls (3308.8900,4386.3600) and (3290.4300,4406.5700) ..
      (3290.4300,4406.5700) .. controls (3303.6000,4421.5000) and
      (3313.2800,4389.8700) .. (3323.8300,4388.1100) .. controls
      (3322.0700,4420.6200) and (3367.7500,4442.5900) .. (3367.7500,4442.5900) ..
      controls (3375.3100,4455.3400) and (3380.3300,4487.8300) ..
      (3391.4600,4504.1100) .. controls (3404.9000,4523.7200) and
      (3423.9800,4525.5200) .. (3423.9800,4516.4000) .. controls
      (3394.1000,4512.0100) and (3392.3600,4462.8000) .. (3387.9500,4453.1400) ..
      controls (3394.1000,4454.0200) and (3409.9200,4448.7500) ..
      (3398.5000,4442.5900) .. controls (3387.0700,4436.4500) and
      (3365.9800,4434.6800) .. (3360.7200,4417.1100) .. controls
      (3385.3100,4421.5000) and (3403.7700,4431.1700) .. (3404.6500,4416.2300) ..
      controls (3381.8000,4402.1800) and (3354.5700,4409.2000) ..
      (3354.5700,4391.6200) .. controls (3354.5700,4384.6000) and
      (3374.7700,4378.4500) .. (3374.7700,4378.4500) .. controls
      (3374.7700,4378.4500) and (3413.6700,4329.4100) .. (3413.6700,4268.7800) ..
      controls (3413.6700,4198.4900) and (3395.8600,4192.1500) ..
      (3395.8600,4180.7300) .. controls (3395.8600,4169.3100) and
      (3427.5000,4149.0900) .. (3423.9800,4125.3800) .. controls
      (3442.4200,4162.2900) and (3431.0200,4222.0400) .. (3440.6600,4229.0700) ..
      controls (3472.3000,4144.7100) and (3389.5300,4024.8200) ..
      (3389.5300,3970.3400) .. controls (3389.5300,3791.0600) and
      (3496.0400,3804.0600) .. (3496.0400,3686.9000) .. controls
      (3496.0400,3668.4400) and (3486.3700,3654.3800) .. (3486.3700,3654.3800) ..
      controls (3474.9400,3654.3800) and (3491.6400,3693.9300) ..
      (3470.5500,3694.8000) .. controls (3436.3300,3649.9300) and
      (3442.2500,3508.4200) .. (3427.9500,3455.1600) .. controls
      (3415.3100,3454.0500) and (3405.6600,3453.9300) .. (3398.6900,3454.9500) ..
      controls (3384.4100,3464.8100) and (3365.5700,3479.1300) ..
      (3356.7200,3486.2900) .. controls (3346.5100,3476.6000) and
      (3380.3700,3453.8100) .. (3374.8000,3453.8100) .. controls
      (3372.4400,3453.8100) and (3346.5700,3472.7700) .. (3343.3700,3471.1000) ..
      controls (3327.8900,3463.0400) and (3318.2200,3454.6000) ..
      (3304.8600,3432.5900) .. controls (3291.4800,3410.5800) and
      (3287.7100,3388.7000) .. (3287.9500,3365.5200) .. controls
      (3292.3000,3365.9200) and (3312.8400,3431.2200) .. (3336.3000,3446.3700) ..
      controls (3336.3000,3446.3700) and (3338.6800,3446.5600) ..
      (3343.3900,3446.6600) -- (3343.6400,3446.5100) -- (3362.4400,3445.5300) --
      (3362.4600,3445.4900) .. controls (3365.2700,3445.0800) and
      (3374.5900,3443.7800) .. (3384.2000,3444.3700) -- (3420.0800,3442.8600) ..
      controls (3420.0200,3442.7900) and (3419.6500,3437.3800) ..
      (3419.5900,3437.3300) .. controls (3402.8900,3441.7200) and
      (3358.6500,3433.9000) .. (3347.7200,3434.2500) .. controls
      (3350.5500,3427.2100) and (3359.5100,3416.5800) .. (3361.2700,3412.7000) ..
      controls (3372.1900,3412.7000) and (3402.9100,3419.7300) ..
      (3421.9900,3424.0300) .. controls (3419.3600,3409.0900) and
      (3362.7100,3402.5600) .. (3362.7100,3402.5600) .. controls
      (3313.2600,3373.8100) and (3342.2800,3269.3200) .. (3342.2800,3269.3200) ..
      controls (3342.2800,3269.3200) and (3348.0000,3286.1400) ..
      (3350.4500,3295.2200) .. controls (3352.3300,3302.2200) and
      (3353.6900,3325.7300) .. (3362.4600,3332.7600) .. controls
      (3371.2500,3339.7900) and (3378.2800,3358.2400) .. (3375.6400,3367.9000) ..
      controls (3449.4700,3411.8400) and (3446.8200,3447.8700) ..
      (3456.4800,3444.3600) .. controls (3456.4800,3411.8400) and
      (3386.9700,3359.1600) .. (3386.9700,3359.1600) -- (3406.0000,3344.0200) ..
      controls (3406.0000,3344.0200) and (3438.0300,3383.7300) ..
      (3442.4200,3383.7300) .. controls (3444.4100,3383.7300) and
      (3437.0500,3374.7400) .. (3430.6600,3364.8000) .. controls
      (3422.8500,3352.7000) and (3420.1000,3348.2500) .. (3410.8000,3337.1500) ..
      controls (3414.8000,3319.7100) and (3414.2400,3269.2700) ..
      (3445.7200,3255.3400) .. controls (3443.4600,3260.4700) and
      (3441.9300,3288.0200) .. (3444.7500,3310.2000) .. controls
      (3456.3700,3331.6900) and (3468.7900,3338.0300) .. (3474.0600,3352.9600) ..
      controls (3483.7300,3373.1900) and (3498.6700,3399.5400) ..
      (3498.6700,3399.5400) .. controls (3510.1000,3378.4600) and
      (3532.7900,3368.9200) .. (3532.7900,3368.9200) .. controls
      (3532.7900,3368.9200) and (3521.5200,3396.0300) .. (3539.9800,3411.8400) ..
      controls (3558.4200,3427.6500) and (3507.4600,3468.9600) ..
      (3507.4600,3468.9600) .. controls (3507.4600,3468.9600) and
      (3525.9200,3477.7500) .. (3536.4600,3464.5700) .. controls
      (3546.9900,3451.3900) and (3549.6300,3439.9700) .. (3554.0200,3438.2100) ..
      controls (3558.4200,3436.4500) and (3553.1400,3461.9300) ..
      (3561.9300,3470.7200) .. controls (3570.7400,3479.5000) and
      (3556.6600,3516.4200) .. (3529.4300,3520.8100) .. controls
      (3543.4800,3536.6200) and (3567.2100,3512.0200) .. (3576.8800,3512.0200) ..
      controls (3577.7500,3522.5600) and (3592.7000,3539.2600) ..
      (3581.2700,3552.4400) .. controls (3569.8600,3565.6200) and
      (3552.2700,3584.0700) .. (3552.2700,3584.0700) .. controls
      (3572.5000,3593.7400) and (3582.1500,3570.8900) .. (3595.3300,3573.5300) ..
      controls (3595.3300,3586.7100) and (3608.5200,3599.0200) ..
      (3590.9400,3615.7100) .. controls (3573.3800,3632.4000) and
      (3566.3500,3635.9100) .. (3566.3500,3635.9100) .. controls
      (3566.3500,3635.9100) and (3588.3000,3637.6700) .. (3606.7600,3625.3700) ..
      controls (3602.3600,3647.3400) and (3607.6400,3662.2900) ..
      (3595.3300,3675.4600) .. controls (3586.5400,3686.8800) and
      (3572.5000,3686.8800) .. (3572.5000,3686.8800) .. controls
      (3574.2600,3706.2200) and (3595.3300,3689.5100) .. (3605.0000,3693.0300) ..
      controls (3593.5700,3707.9700) and (3619.9400,3735.2200) ..
      (3612.0300,3758.9400) .. controls (3546.1100,3729.0600) and
      (3536.4600,3849.4500) .. (3525.9200,3855.6000) .. controls
      (3528.5500,3903.0500) and (3501.0500,4041.9700) .. (3498.6700,4075.2800) ..
      controls (3496.0400,4112.1800) and (3501.3100,4129.7600) ..
      (3504.8200,4103.3900) .. controls (3506.2700,4092.5500) and
      (3516.5000,4055.1600) .. (3521.5200,4012.8900) .. controls
      (3528.6700,3952.4000) and (3530.3100,3883.7100) .. (3581.2700,3883.7100) ..
      controls (3634.0000,3883.7100) and (3634.0000,3938.1900) ..
      (3634.0000,3963.6800) .. controls (3634.0000,3989.1600) and
      (3605.8800,4101.6300) .. (3605.8800,4119.2100) .. controls
      (3630.4900,4141.1800) and (3635.7600,4181.6100) .. (3636.6400,4213.2400) ..
      controls (3631.3700,4205.3200) and (3602.3600,4170.1800) ..
      (3602.3600,4160.5100) .. controls (3591.8200,4178.0900) and
      (3632.2500,4213.2300) .. (3631.3700,4235.2000) .. controls
      (3630.4900,4257.1700) and (3622.5600,4279.1400) .. (3622.5600,4279.1400) ..
      controls (3621.5200,4273.3800) and (3612.4400,4249.1500) ..
      (3606.7600,4229.0500) .. controls (3602.8900,4215.4000) and
      (3602.5600,4202.6900) .. (3599.7300,4202.6900) .. controls
      (3592.7000,4202.6900) and (3597.0900,4229.0600) .. (3600.6100,4241.3600) ..
      controls (3602.6000,4248.3300) and (3618.9100,4276.3000) ..
      (3619.0400,4302.8700) .. controls (3619.4900,4387.3000) and
      (3601.4100,4360.9700) .. (3614.3200,4409.7500) .. controls
      (3594.2400,4379.6200) and (3576.5400,4315.0500) .. (3576.5400,4249.1500) ..
      controls (3573.4800,4257.5900) and (3570.2300,4239.5300) ..
      (3567.7000,4247.4500) .. controls (3560.7800,4269.1400) and
      (3556.6600,4316.5500) .. (3556.6600,4346.8000) .. controls
      (3556.6600,4375.3800) and (3605.0000,4468.0700) .. (3605.0000,4541.8800) ..
      controls (3605.0000,4615.6900) and (3547.8700,4646.5200) ..
      (3545.2300,4676.3100) .. controls (3542.7100,4705.2000) and
      (3567.2100,4718.5000) .. (3567.2100,4718.5000) .. controls
      (3547.8700,4693.8900) and (3566.3300,4667.5300) .. (3566.3300,4667.5300) ..
      controls (3578.6300,4700.9200) and (3625.2000,4716.7400) ..
      (3624.3200,4657.8700) .. controls (3640.1600,4671.9200) and
      (3641.0400,4736.0600) .. (3576.8800,4736.0600) .. controls
      (3526.8000,4736.0600) and (3515.9000,4676.9100) .. (3515.9000,4653.1900) ..
      controls (3515.9000,4587.2900) and (3575.1400,4513.7500) ..
      (3575.1400,4475.9600) .. controls (3575.1400,4431.1500) and
      (3551.3900,4393.3800) .. (3552.2700,4381.0700) .. controls
      (3551.3900,4403.0300) and (3567.2100,4463.6600) .. (3566.3300,4481.2400) ..
      controls (3554.9000,4469.8200) and (3548.7500,4422.3800) ..
      (3543.4800,4412.7000) .. controls (3542.6200,4432.0300) and
      (3551.3900,4498.8200) .. (3556.6600,4510.2400) .. controls
      (3546.9900,4494.4200) and (3528.5500,4444.3300) .. (3530.3100,4430.2700) ..
      controls (3528.5500,4440.8200) and (3543.4800,4511.1200) ..
      (3545.2300,4532.2100) .. controls (3537.3400,4508.4800) and
      (3519.3600,4454.4300) .. (3519.3600,4370.0700) .. controls
      (3519.3600,4255.8400) and (3616.4300,4083.1800) .. (3616.4300,3966.3100) ..
      controls (3616.4300,3928.5300) and (3599.7300,3917.9800) ..
      (3590.9400,3917.9800) .. controls (3518.8900,3917.9800) and
      (3467.0500,4496.1800) .. (3467.0500,4496.1800) .. controls
      (3428.7100,4527.1200) and (3380.4300,4606.8000) .. (3380.4300,4606.8000) --
      (3372.5000,4609.7200) .. controls (3372.5000,4609.7200) and
      (3346.5900,4562.6400) .. (3314.1400,4534.8300) .. controls
      (3298.7900,4521.6600) and (3269.7300,4508.0800) .. (3250.9600,4496.0100) ..
      controls (3232.1500,4483.9000) and (3223.6400,4473.3200) ..
      (3223.6400,4473.3200) -- (3209.3800,4477.9500) .. controls
      (3209.3800,4477.9500) and (3233.3400,4503.0900) .. (3246.4100,4512.5000) ..
      controls (3259.4700,4521.9100) and (3270.2100,4548.8400) ..
      (3270.2100,4571.7300) .. controls (3270.2100,4594.8000) and
      (3261.2700,4628.4200) .. (3261.4300,4652.5800) .. controls
      (3261.6200,4684.5500) and (3276.0400,4709.3000) .. (3270.2700,4711.1200) ..
      controls (3252.3100,4716.8100) and (3226.4300,4726.3500) ..
      (3212.6600,4732.5300) .. controls (3203.2400,4708.6400) and
      (3185.9500,4711.3900) .. (3177.3600,4693.6400) .. controls
      (3166.4800,4671.1700) and (3165.0900,4640.3400) .. (3165.0900,4611.8700) ..
      controls (3165.0900,4569.6100) and (3182.8100,4556.5600) ..
      (3190.2600,4556.5600) .. controls (3194.4200,4566.2700) and
      (3197.2600,4596.9300) .. (3207.8300,4625.3800) .. controls
      (3217.3300,4650.9700) and (3234.7500,4668.8000) .. (3236.8200,4675.4600) ..
      controls (3242.0900,4666.6800) and (3222.9900,4646.0300) ..
      (3216.6200,4605.1600) .. controls (3207.8300,4548.9200) and
      (3159.0500,4437.1100) .. (3145.4500,4388.1100) .. controls
      (3131.8300,4339.0800) and (3105.6700,4237.0600) .. (3097.3600,4218.2900) --
      cycle(3402.8900,3333.6100) .. controls (3396.7400,3338.0000) and
      (3381.8000,3352.0600) .. (3381.8000,3352.0600) .. controls
      (3381.8000,3352.0600) and (3386.5800,3287.9600) .. (3411.2900,3272.5100) ..
      controls (3405.6400,3283.8500) and (3397.6200,3308.1300) ..
      (3402.8900,3333.6100) -- cycle(3293.9600,3439.3100) .. controls
      (3304.8000,3451.9900) and (3332.4600,3479.6800) .. (3343.2300,3489.5300) --
      (3318.2600,3479.0100) .. controls (3311.4500,3470.4000) and
      (3298.9300,3457.1200) .. (3293.9600,3439.3100) -- cycle(3353.1700,3407.7700)
      .. controls (3347.9000,3413.9200) and (3341.5400,3430.4900) ..
      (3338.0400,3431.3700) .. controls (3334.5200,3432.2500) and
      (3306.4300,3387.7800) .. (3319.0000,3332.7600) .. controls
      (3320.0200,3328.3100) and (3320.8100,3352.5800) .. (3322.1500,3359.5000) ..
      controls (3327.7800,3388.7300) and (3334.8600,3396.5000) ..
      (3353.1700,3407.7700) -- cycle(3062.1800,4168.2100) .. controls
      (3064.8100,4169.9100) and (3082.2700,4220.9100) .. (3082.6200,4223.4100) ..
      controls (3082.6200,4223.4100) and (3085.1600,4228.6500) ..
      (3089.4100,4234.5200) .. controls (3092.9400,4248.9500) and
      (3093.0800,4244.2400) .. (3097.7100,4264.4600) .. controls
      (3076.8400,4258.9300) and (3047.9900,4277.4100) .. (3047.9900,4277.4100) ..
      controls (3041.1400,4273.6800) and (3079.1200,4253.8500) ..
      (3075.3500,4249.5900) .. controls (3043.5600,4214.8300) and
      (3062.1800,4168.2100) .. (3062.1800,4168.2100) -- cycle(3062.1800,4168.2100)
      .. controls (3064.8100,4169.9100) and (3082.2700,4220.9100) ..
      (3082.6200,4223.4100) .. controls (3082.6200,4223.4100) and
      (3085.1600,4228.6500) .. (3089.4100,4234.5200) .. controls
      (3092.9400,4248.9500) and (3093.0800,4244.2400) .. (3097.7100,4264.4600) ..
      controls (3076.8400,4258.9300) and (3047.9900,4277.4100) ..
      (3047.9900,4277.4100) .. controls (3041.1400,4273.6800) and
      (3079.1200,4253.8500) .. (3075.3500,4249.5900) .. controls
      (3043.5600,4214.8300) and (3062.1800,4168.2100) .. (3062.1800,4168.2100) --
      cycle(3396.8800,4953.1000) .. controls (3386.4600,4955.5800) and
      (3381.2300,4961.2000) .. (3372.2500,4960.8800) .. controls
      (3362.6400,4960.5500) and (3357.5200,4953.2900) .. (3352.7800,4952.2300) ..
      controls (3371.7200,4949.2300) and (3380.3100,4940.6200) ..
      (3396.8800,4953.1000) -- cycle(3380.9800,5143.1100) .. controls
      (3382.1500,5147.9900) and (3388.7900,5145.4500) .. (3390.7400,5147.9900) ..
      controls (3393.4800,5136.8600) and (3376.4800,5129.8200) ..
      (3373.3600,5125.5200) .. controls (3370.2300,5121.2300) and
      (3370.8200,5115.3600) .. (3365.1600,5115.3600) .. controls
      (3359.4900,5115.3600) and (3360.4700,5118.8800) .. (3360.4700,5121.4200) ..
      controls (3360.4700,5123.9600) and (3363.4000,5128.6500) ..
      (3363.4000,5132.5600) .. controls (3363.4000,5136.4600) and
      (3360.0800,5138.8100) .. (3360.0800,5138.8100) .. controls
      (3364.5700,5142.1300) and (3378.2400,5142.5200) .. (3380.9800,5143.1100) --
      cycle(3448.8300,5153.0800) .. controls (3481.0700,5153.0800) and
      (3491.4300,5104.2300) .. (3520.7400,5111.6600) .. controls
      (3515.4500,5100.5200) and (3497.6800,5105.3900) .. (3491.8200,5102.4800) ..
      controls (3485.2000,5099.1500) and (3477.1700,5089.7700) ..
      (3458.6100,5089.7700) .. controls (3440.0400,5089.7700) and
      (3431.6400,5097.5900) .. (3414.0600,5097.5900) .. controls
      (3404.3000,5097.5900) and (3397.0700,5092.1100) .. (3397.0700,5092.1100) ..
      controls (3397.0700,5092.1100) and (3398.0500,5105.2100) ..
      (3415.2300,5105.2100) .. controls (3432.4200,5105.2100) and
      (3441.4100,5101.3000) .. (3458.6100,5101.3000) .. controls
      (3475.8000,5101.3000) and (3485.5700,5111.6600) .. (3485.5700,5111.6600) ..
      controls (3472.8700,5114.2000) and (3462.5200,5142.9100) ..
      (3447.6800,5142.9100) .. controls (3439.8400,5142.9100) and
      (3431.8400,5134.9000) .. (3431.8400,5134.9000) .. controls
      (3433.7900,5132.9500) and (3443.3800,5138.6200) .. (3448.4600,5138.6200) ..
      controls (3463.8900,5138.6200) and (3462.9100,5113.4100) ..
      (3465.0600,5112.4300) .. controls (3459.3900,5110.8800) and
      (3458.2000,5109.1200) .. (3445.5100,5109.1200) .. controls
      (3432.8100,5109.1200) and (3419.7300,5115.5600) .. (3417.5800,5114.9800) ..
      controls (3419.3400,5116.7400) and (3418.5500,5120.2500) ..
      (3424.2200,5120.2500) .. controls (3429.8800,5120.2500) and
      (3435.5500,5118.3000) .. (3435.5500,5122.9800) .. controls
      (3435.5500,5127.6800) and (3425.9800,5128.0600) .. (3426.9500,5130.6000) ..
      controls (3422.0700,5127.4800) and (3414.2600,5114.5800) ..
      (3407.4200,5114.5800) .. controls (3400.5900,5114.5800) and
      (3399.9800,5117.7100) .. (3399.9800,5117.7100) .. controls
      (3410.1600,5117.7100) and (3421.4800,5153.0800) .. (3448.8300,5153.0800) --
      cycle(3565.3500,5095.8200) .. controls (3569.7900,5093.7700) and
      (3579.3200,5095.4800) .. (3575.5700,5089.0100) .. controls
      (3571.8200,5082.5200) and (3566.0200,5071.6300) .. (3566.0200,5071.6300) ..
      controls (3566.0200,5071.6300) and (3569.7900,5068.2100) ..
      (3571.4800,5068.9000) .. controls (3573.1800,5069.5900) and
      (3584.7700,5066.8600) .. (3587.8300,5069.2300) .. controls
      (3585.8000,5063.7900) and (3582.0500,5040.2800) .. (3556.4800,5040.2800) ..
      controls (3541.4800,5040.2800) and (3538.7700,5053.9000) ..
      (3538.7700,5058.6800) .. controls (3538.7700,5074.0100) and
      (3565.3500,5091.7200) .. (3565.3500,5095.8200) -- cycle(3571.4800,5123.4100)
      .. controls (3578.9800,5123.4100) and (3582.7100,5120.3500) ..
      (3585.4500,5122.0500) .. controls (3582.7300,5116.2600) and
      (3562.9500,5094.4500) .. (3547.9700,5094.4500) .. controls
      (3544.2200,5094.4500) and (3542.8700,5096.5000) .. (3542.8700,5096.5000) ..
      controls (3545.9400,5106.7200) and (3563.9800,5123.4100) ..
      (3571.4800,5123.4100) -- cycle(3353.0800,5075.0400) .. controls
      (3360.1600,5038.1400) and (3431.0900,5073.6000) .. (3435.8600,4993.9400) ..
      controls (3438.2600,4953.8000) and (3402.8100,4936.3800) ..
      (3373.8500,4937.0600) .. controls (3348.9900,4937.6500) and
      (3344.5400,4943.1600) .. (3344.5400,4943.1600) .. controls
      (3344.5600,4943.1600) and (3337.7400,4930.6200) .. (3320.8800,4915.1100) ..
      controls (3309.2200,4904.3900) and (3303.1300,4894.3900) ..
      (3303.1300,4894.3900) .. controls (3303.1300,4894.3900) and
      (3308.0600,4888.4800) .. (3332.7700,4893.6500) .. controls
      (3368.4600,4901.1200) and (3386.1100,4925.1000) .. (3423.9300,4925.1000) ..
      controls (3435.5100,4925.1000) and (3436.8200,4906.3000) ..
      (3447.0500,4906.3000) .. controls (3445.5700,4911.9900) and
      (3453.7300,4923.7500) .. (3458.6900,4929.8800) .. controls
      (3463.6500,4936.0000) and (3468.6900,4949.0900) .. (3456.6400,4956.7900) ..
      controls (3458.6900,4967.3500) and (3473.0100,4965.3200) ..
      (3474.0200,4971.4500) .. controls (3474.0200,4971.4500) and
      (3440.2900,4997.0200) .. (3440.2900,5037.8900) .. controls
      (3440.2900,5046.7500) and (3448.4600,5052.2100) .. (3451.5200,5052.2100) ..
      controls (3454.5900,5052.2100) and (3461.7600,5051.5200) ..
      (3461.7600,5044.7000) .. controls (3461.7600,5037.8900) and
      (3452.5600,5036.5200) .. (3452.5600,5020.1800) .. controls
      (3452.5600,4988.1500) and (3489.3600,4977.5800) .. (3489.3600,4968.7200) ..
      controls (3489.3600,4959.8800) and (3472.3200,4957.1400) ..
      (3472.3200,4957.1400) -- (3471.3100,4905.0000) .. controls
      (3454.5900,4857.5800) and (3421.8900,4811.9800) .. (3408.2600,4800.7400) ..
      controls (3415.0800,4806.5400) and (3449.4300,4878.2400) ..
      (3445.7400,4880.8000) .. controls (3442.0300,4883.3900) and
      (3412.6600,4820.8000) .. (3387.8100,4806.8700) .. controls
      (3391.9100,4810.2700) and (3437.9100,4884.9000) .. (3432.7900,4888.6500) ..
      controls (3429.9600,4890.7300) and (3400.6600,4839.0800) ..
      (3354.0900,4801.0800) .. controls (3316.8200,4770.6800) and
      (3266.7000,4753.6000) .. (3223.2400,4745.8800) .. controls
      (3243.0100,4720.3200) and (3294.8000,4734.6300) .. (3294.8000,4725.0900) ..
      controls (3294.8000,4712.1400) and (3274.3600,4698.1800) ..
      (3274.3600,4666.4800) .. controls (3274.3600,4617.4100) and
      (3296.4900,4568.6900) .. (3272.3100,4526.7800) .. controls
      (3359.2000,4578.2300) and (3370.4500,4653.1900) .. (3374.5300,4664.0900) ..
      controls (3374.5300,4664.0900) and (3345.3000,4646.3800) ..
      (3304.3400,4646.3800) .. controls (3291.0500,4646.3800) and
      (3283.5500,4653.8700) .. (3283.5500,4656.9400) .. controls
      (3351.3600,4700.8900) and (3417.9100,4782.5800) .. (3421.9900,4791.7800) ..
      controls (3428.4800,4793.8200) and (3449.9400,4830.9700) ..
      (3464.5900,4861.6300) .. controls (3479.2400,4892.3000) and
      (3490.4900,4904.5700) .. (3487.7500,4899.1100) .. controls
      (3485.0400,4893.6600) and (3471.7600,4833.0100) .. (3418.9300,4764.5200) ..
      controls (3382.4600,4717.2200) and (3314.2200,4662.0500) ..
      (3314.2200,4662.0500) .. controls (3314.2200,4662.0500) and
      (3363.4800,4659.7100) .. (3384.5100,4681.3800) .. controls
      (3390.1800,4682.6000) and (3395.0800,4680.0100) .. (3395.0800,4675.5800) ..
      controls (3395.0800,4671.1500) and (3384.9400,4670.2300) ..
      (3385.0800,4654.8900) .. controls (3385.8800,4571.7300) and
      (3474.2600,4506.0900) .. (3486.2900,4503.6000) .. controls
      (3486.2900,4503.6000) and (3472.3200,4540.7500) .. (3472.3200,4589.1400) ..
      controls (3472.3200,4632.2700) and (3481.7800,4735.9800) ..
      (3490.8400,4795.8600) .. controls (3492.8500,4809.2400) and
      (3484.2200,4821.3900) .. (3486.7400,4828.5800) .. controls
      (3489.1600,4835.4500) and (3489.3600,4832.6700) .. (3492.2100,4832.6700) ..
      controls (3500.7200,4832.6700) and (3499.0000,4791.8900) ..
      (3550.4100,4782.1900) .. controls (3523.2400,4849.5200) and
      (3541.1100,4924.2200) .. (3541.1100,4927.9100) .. controls
      (3541.1100,4939.6100) and (3531.4100,4944.3900) .. (3535.8200,4955.3400) ..
      controls (3535.8200,4955.3400) and (3550.2300,4946.9300) ..
      (3567.6800,4946.9300) .. controls (3585.1400,4946.9300) and
      (3591.3500,4952.3600) .. (3591.3500,4952.3600) .. controls
      (3562.6400,4980.6800) and (3561.8800,5009.4000) .. (3561.8800,5014.2600) ..
      controls (3561.8800,5019.1100) and (3553.3200,5025.1300) ..
      (3553.3200,5029.2000) .. controls (3553.3200,5033.2700) and
      (3556.2300,5034.2500) .. (3556.2300,5034.2500) .. controls
      (3565.9400,5028.2300) and (3578.9100,5039.6700) .. (3587.4600,5039.1800) ..
      controls (3587.4600,5049.2400) and (3603.9800,5059.5200) ..
      (3605.9000,5095.3700) .. controls (3607.8500,5131.6600) and
      (3592.5200,5136.5000) .. (3580.2900,5136.5000) .. controls
      (3571.0000,5136.5000) and (3564.7900,5131.4600) .. (3560.7000,5138.2500) ..
      controls (3568.2800,5144.6500) and (3605.1400,5149.6600) ..
      (3605.1400,5179.9700) .. controls (3581.6600,5159.4000) and
      (3546.3500,5167.3500) .. (3523.2400,5157.4600) .. controls
      (3523.2400,5157.4600) and (3518.4000,5159.2100) .. (3518.4000,5163.4700) ..
      controls (3539.3600,5180.5500) and (3608.6100,5156.8200) ..
      (3620.8800,5224.2900) .. controls (3604.5300,5212.0200) and
      (3563.5400,5187.3400) .. (3526.1500,5187.3400) .. controls
      (3514.3000,5187.3400) and (3495.7600,5190.5500) .. (3478.7900,5190.5500) ..
      controls (3445.2100,5190.5500) and (3428.3600,5173.7600) ..
      (3425.3300,5164.9600) .. controls (3425.3300,5164.9600) and
      (3380.1800,5164.8400) .. (3354.0900,5156.8200) .. controls
      (3359.2000,5144.5500) and (3347.9600,5101.6200) .. (3353.0800,5075.0400) --
      cycle(3211.2900,4766.3300) .. controls (3211.2900,4758.2200) and
      (3239.4600,4747.5500) .. (3322.2800,4792.8000) .. controls
      (3405.0800,4838.0500) and (3427.7000,4904.6400) .. (3425.1400,4907.1900) ..
      controls (3423.8700,4908.4600) and (3410.1000,4883.1700) ..
      (3393.1300,4864.0900) .. controls (3375.8400,4844.6500) and
      (3355.3700,4831.4200) .. (3353.8700,4832.9200) .. controls
      (3352.2900,4834.5000) and (3371.2900,4851.0700) .. (3385.4300,4870.4900) ..
      controls (3398.1400,4887.8900) and (3406.2100,4908.3400) ..
      (3403.7900,4909.7600) .. controls (3400.4900,4911.7000) and
      (3357.2700,4838.5600) .. (3300.0800,4838.5600) .. controls
      (3264.6300,4838.5600) and (3239.6300,4881.5400) .. (3264.1600,4914.2500) ..
      controls (3259.4600,4918.9500) and (3215.0700,4904.7500) ..
      (3215.0700,4841.2900) .. controls (3215.0700,4801.5900) and
      (3241.6000,4804.7500) .. (3241.6000,4796.6400) .. controls
      (3226.6600,4791.0900) and (3211.2900,4774.4500) .. (3211.2900,4766.3300) --
      cycle(3087.2300,4944.5200) .. controls (3082.2700,4956.4200) and
      (3061.9500,4969.7900) .. (3061.4600,4979.7000) .. controls
      (3052.5500,4913.3200) and (3092.0500,4889.2400) .. (3087.7100,4882.6000) ..
      controls (3080.4200,4871.4200) and (3058.4600,4904.8100) ..
      (3058.4600,4904.8100) .. controls (3045.2700,4852.9700) and
      (3091.8400,4814.3000) .. (3091.8400,4814.3000) .. controls
      (3090.0800,4796.7300) and (3061.0900,4823.0800) .. (3061.0900,4823.0800) ..
      controls (3046.1500,4779.1500) and (3098.8800,4731.7000) ..
      (3098.8800,4731.7000) .. controls (3098.8800,4721.1600) and
      (3061.0900,4747.5200) .. (3061.0900,4747.5200) .. controls
      (3061.0900,4697.4300) and (3096.2300,4671.9400) .. (3096.2300,4664.9200) ..
      controls (3096.2300,4652.6200) and (3077.7800,4666.6800) ..
      (3077.7800,4666.6800) .. controls (3077.7800,4666.6800) and
      (3079.5400,4625.3800) .. (3122.6000,4593.7400) .. controls
      (3121.7200,4584.0800) and (3095.3500,4599.0200) .. (3095.3500,4599.0200) ..
      controls (3099.7600,4589.3500) and (3100.6300,4548.0500) ..
      (3118.2000,4544.5300) .. controls (3135.7800,4541.0200) and
      (3153.3600,4543.6500) .. (3158.6300,4539.2600) .. controls
      (3163.9100,4534.8700) and (3178.8300,4516.4100) .. (3183.2300,4537.5000) ..
      controls (3165.4100,4556.6600) and (3147.3600,4585.9200) ..
      (3147.3600,4630.9500) .. controls (3147.3600,4681.3800) and
      (3156.9100,4708.6400) .. (3191.8600,4734.4100) .. controls
      (3185.6900,4770.4400) and (3179.4300,4833.6000) .. (3171.5200,4864.3600) ..
      controls (3163.6100,4895.1100) and (3164.6300,4921.7000) ..
      (3166.5200,4990.0400) .. controls (3167.1000,5010.7200) and
      (3212.0000,5039.2600) .. (3212.0000,5039.2600) .. controls
      (3194.5100,5089.9300) and (3153.6300,5122.0700) .. (3135.8400,5132.3000) ..
      controls (3153.6700,5113.7900) and (3173.6000,5096.4100) ..
      (3196.0900,5056.5400) .. controls (3196.0900,5056.5400) and
      (3181.7800,5038.1400) .. (3176.6700,5042.2300) .. controls
      (3165.9400,5052.9600) and (3187.6800,5056.9600) .. (3174.3900,5073.3200) ..
      controls (3162.3000,5088.6200) and (3105.0500,5144.2700) ..
      (3105.1200,5143.4300) .. controls (3105.8000,5134.2800) and
      (3147.0300,5078.0000) .. (3133.2800,5060.7300) .. controls
      (3133.2800,5060.7300) and (3153.7300,5040.2900) .. (3156.8000,5028.0200) ..
      controls (3151.6900,5020.8600) and (3146.5800,4922.7300) ..
      (3143.5200,4911.4800) .. controls (3136.3500,4947.2600) and
      (3143.9600,5035.0700) .. (3143.9600,5035.0700) .. controls
      (3112.2700,5066.7600) and (3115.0500,5059.1900) .. (3085.4000,5074.5200) ..
      controls (3081.9000,5075.7000) and (3126.4300,5038.3300) ..
      (3123.2800,5039.0500) .. controls (3119.7400,5039.8600) and
      (3120.4500,4962.4900) .. (3112.2700,4983.9600) .. controls
      (3109.5700,4991.0400) and (3103.0700,5040.1800) .. (3103.0700,5040.1800) ..
      controls (3081.6000,5064.7200) and (3047.5400,5090.4500) ..
      (3046.8500,5092.3100) .. controls (3046.1700,5072.5900) and
      (3083.3000,5023.4800) .. (3094.7300,4946.8100) .. controls
      (3094.3700,4943.1500) and (3092.1700,4932.6400) .. (3087.2300,4944.5200) --
      cycle(3365.1000,5021.2500) .. controls (3387.5600,5018.8800) and
      (3407.4400,5012.4200) .. (3408.4600,5017.5700) .. controls
      (3403.8300,5031.0000) and (3398.2000,5034.1600) .. (3391.1900,5035.5500) ..
      controls (3374.8400,5038.8000) and (3375.7200,5022.8800) ..
      (3365.1000,5021.2500) -- cycle(3219.1200,4976.8800) .. controls
      (3218.5900,4975.3700) and (3202.8100,4968.7000) .. (3200.4300,4975.1800) ..
      controls (3199.7300,4977.1400) and (3209.3600,4982.3900) ..
      (3209.7900,4985.3800) .. controls (3211.1900,4995.1400) and
      (3207.4200,5005.3400) .. (3206.7500,5004.3900) .. controls
      (3195.8800,4988.9900) and (3178.5400,4998.6500) .. (3177.7600,4941.5400) ..
      controls (3186.4500,4968.8400) and (3220.2500,4958.3700) ..
      (3225.3600,4964.5000) .. controls (3230.4700,4970.6400) and
      (3220.7400,5019.2900) .. (3214.6100,5031.5600) .. controls
      (3213.8500,5023.4700) and (3220.7500,4981.5500) .. (3219.1200,4976.8800) --
      cycle(3244.3600,5140.4600) .. controls (3244.3600,5140.4600) and
      (3255.7200,5152.5500) .. (3247.7500,5152.5500) .. controls
      (3232.0600,5152.5500) and (3227.3300,5173.1800) .. (3238.9200,5171.8100) ..
      controls (3250.4900,5170.4500) and (3250.0600,5172.5400) ..
      (3240.9600,5181.3500) .. controls (3233.9300,5188.1600) and
      (3240.5900,5194.3000) .. (3255.5700,5194.3000) .. controls
      (3264.4300,5194.3000) and (3276.4100,5188.1600) .. (3276.4100,5174.5400) ..
      controls (3276.4100,5160.9100) and (3227.9400,5107.2400) ..
      (3246.1900,5050.7400) .. controls (3268.6900,4981.0500) and
      (3329.3400,4989.4100) .. (3360.2100,4983.0400) .. controls
      (3379.5100,4979.0600) and (3421.3300,4966.9100) .. (3419.2800,4971.0100) ..
      controls (3415.1400,4979.2900) and (3360.6600,4988.7300) ..
      (3370.2100,4990.7700) .. controls (3372.6000,4991.2800) and
      (3424.2800,4979.0300) .. (3422.7000,4981.2300) .. controls
      (3417.2300,4988.7300) and (3381.5200,5001.7700) .. (3376.1700,5004.0200) ..
      controls (3358.5000,5011.4600) and (3305.8800,5030.4800) ..
      (3300.6100,5028.3200) .. controls (3295.3300,5026.1400) and
      (3362.5800,5004.5300) .. (3361.5200,4999.7800) .. controls
      (3360.7600,4996.3500) and (3350.8100,4995.2500) .. (3326.0500,5002.8600) ..
      controls (3298.1100,5011.4600) and (3270.7200,5035.0500) ..
      (3270.7200,5069.8200) .. controls (3270.7200,5100.5600) and
      (3274.5500,5104.6800) .. (3276.1700,5115.4700) .. controls
      (3283.6700,5165.2300) and (3282.6000,5077.3900) .. (3287.0800,5082.7700) ..
      controls (3290.4900,5086.8600) and (3292.5000,5104.1900) ..
      (3296.6200,5115.4800) .. controls (3301.9800,5130.1800) and
      (3310.1900,5135.2400) .. (3310.1900,5156.1900) .. controls
      (3310.1900,5195.0400) and (3273.5300,5206.2800) .. (3255.7300,5206.2800) ..
      controls (3244.1600,5206.2800) and (3213.8900,5199.0300) ..
      (3216.4100,5169.4500) .. controls (3219.0200,5138.7700) and
      (3244.3600,5140.4600) .. (3244.3600,5140.4600);
  \end{scope}
\end{scope}

\end{tikzpicture}
}
\renewcommand{\maketitle}{%
\hypersetup{ % setup the hyperref-package options
pdftitle={\@title}, %  - title (PDF meta)
pdfsubject={\@scheme},%  - subject (PDF meta)
pdfauthor={\@author}, %  - author (PDF meta)
plainpages=false, %  -
pdfborder={0 0 0}, %  -
breaklinks=true, %  - allow line break inside links
bookmarksnumbered=true, %
bookmarksopen=true %
}

\pagenumbering{gobble} % gobble page numbing (invisible for empty page style)
\pagestyle{empty} % no header or footers
\begin{titlepage}

\pdfbookmark[0]{Title Page}{Title Page}
\centering

\scalebox{0.38}{\bangorlogo} \\
{School of Computer Science \\
 \vspace{-1.5mm}College of Physical \& Applied Sciences} \\

\vfill

{\setstretch{1.0}\LARGE \tgherosfontfoot\textbf{\@title} \\[10mm]}
\begin{center}\vspace{-0.4cm}
        \rule{0.6\textwidth}{.4pt}
    \end{center}\vspace{-4mm}
{\Large \@author } \\

\vfill

{\setstretch{1.1}\footnotesize Submitted in partial satisfaction of the requirements for the\\
 \ifx\pgcert\undefined Degree of\ \fi\degree\\
 \vspace{-2.7mm}in \@scheme}

\vspace{1cm}

{\footnotesize\setstretch{1.1}
\ifnum \FSSize{supervisors}>1 \textit{Supervisors} \else \textit{Supervisor} \fi
\newcounter{l}
\forloop[-1]{l}{\FSSize{supervisors}}{\value{l}>0}{%
\FSBottom{supervisors}\FSShift{supervisors}\ifnum \FSSize{supervisors}>0 \ \textit{and} \fi}
\vspace{1cm}

\@date}

\end{titlepage}
}

\RequirePackage{framed}
\DeclareDocumentCommand{\statements}{ O{} }{%
    \ifthenelse{\equal{#1}{}}{%
        \newcommand{\sig}{\vspace{2cm}}
    }{%
        \newcommand{\sig}{\includegraphics[height=2cm]{#1}}
    }
    \cleardoublepage
    \pdfbookmark[0]{Statement of Originality \& Availability}{Statements}
    %\chapter*{Statements}
    \label{chp:statements}
    {
    \setstretch{1.1}
    \null\vfill
    \begin{framed}
        {\noindent\bf Statement of Originality}\\
        \\
        The work presented in this thesis/dissertation is entirely from the studies of the
        individual student, except where otherwise stated. Where derivations are presented
        and the origin of the work is either wholly or in part from other sources, then full
        reference is given to the original author. This work has not been presented previously
        for any degree, nor is it at present under consideration by any other degree awarding
        body.

        \vspace{0.3cm}

        \noindent Student:

        \sig

        \noindent\@author
    \end{framed}
    \vfill
    \begin{framed}
        {\noindent\bf Statement of Availability}\\
        \\
        I hereby acknowledge the availability of any part of this thesis/dissertation for
        viewing, photocopying or incorporation into future studies, providing that full reference
        is given to the origins of any information contained herein.  I further give permission
        for a copy of this work to be deposited with the Bangor University Institutional Digital
        Repository, \ifdefined\phd the British Library ETHOS system,\ \fi and/or in any other
        repository authorised for use by Bangor University and where necessary have gained the
        required permissions for the use of third party material.  I acknowledge that Bangor
        University may make the title and a summary of this thesis/dissertation freely available.

        \vspace{0.3cm}

        \noindent Student:

        \sig

        \noindent\@author
    \end{framed}
    \vfill
    }
}

\RequirePackage[figure,table]{totalcount}
\newcommand{\tables}{
    \cleardoublepage
    \setcounter{tocdepth}{3}
    {\setstretch{1.2}
    \tableofcontents
    \iftotalfigures
        \cleardoublepage
        \listoffigures
    \fi
    \iftotaltables
        \cleardoublepage
        \listoftables
    \fi}
}

\newcommand{\thesisContent}{%
    \cleardoublepage
    \pagenumbering{arabic}     % arabic page numbering
    \setcounter{page}{1} % set page counter
    \pagestyle{maincontentstyle}  % fancy header and footer
}

\renewenvironment{abstract}
    {
        \cleardoublepage
        \pdfbookmark[0]{Abstract}{Abstract}
        \chapter*{\abstractname}\label{chp:abstract}
    }
    {}

\DeclareDocumentCommand{\acknowledgements}{ O{} O{} m }{%
    \cleardoublepage
    \pagenumbering{roman}
    \pagestyle{plain}
    \pdfbookmark[0]{Acknowledgements}{Acknowledgements}
    \chapter*{Acknowledgements}
    \label{chp:acknowledgement}
    \if\relax\detokenize{#1}\relax\else
    \chapterquote{#1}{#2}{\ }
    \fi

    #3
}
\endinput
%%
%% End of file `bangorcsthesis.cls'.
