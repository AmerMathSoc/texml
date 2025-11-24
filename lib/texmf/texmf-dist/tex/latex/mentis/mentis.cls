%%
%% This is file `mentis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mentis.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2006 by Georg M. Verweyen <Georg.Verweyen@rub.de>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{mentis}[2006/03/01 v1.5 mentis.cls]
%%%% \changes{v1.0}{2003/09/25}{Erste Fassung}

%%\usepackage{amsmath,amsfonts,amssymb}
\LoadClassWithOptions{scrbook}
\AtBeginDocument{%
%%%%%    \selectlanguage{ngerman}%
    \makeindex
    \pagestyle{scrheadings}
    \pagestyle{mentis}
    \raggedbottom
}
\RequirePackage[LY1,OT4,T5,OT1,T3,T1]{fontenc}
\RequirePackage{babel}
%%%    \begin{macrocode}
%%%\RequirePackage{lgreek}
%%%    \end{macrocode}
\RequirePackage{xspace}
\RequirePackage{textcomp}
\RequirePackage{scrpage2}
\RequirePackage{jurabib}
%%%    \begin{macrocode}
%%\RequirePackage{picinpar}
%%%    \end{macrocode}
\RequirePackage{makeidx}
\RequirePackage{relsize}
\RequirePackage[stretch=15,shrink=15,step=5]{microtype}
\RequirePackage{multicol}
\RequirePackage{ragged2e}
\RequirePackage{geometry}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{scrbook}%
}
\DeclareOption{mentisklein}{\m@ntisklein}
\DeclareOption{mentisgross}{\m@ntisgross}
\DeclareOption{mentisroemisch}{\m@ntisroemisch}
\renewcommand{\@pnumwidth}{1.95em}
\newlength{\ChapterExtraWidth}
\setlength{\ChapterExtraWidth}{0em}
\DeclareRobustCommand{\m@ntisroemisch}{%
    \setlength{\ChapterExtraWidth}{1em}%
    \renewcommand\thesection{\arabic{section}}
    \renewcommand\thechapter{\Roman{chapter}}
}
\newlength{\SectionExtraWidth}
\setlength{\SectionExtraWidth}{0em}
\newlength{\SubsectionExtraWidth}
\setlength{\SubsectionExtraWidth}{0em}
\newlength{\ChapterLabelWidth}%
\newlength{\SectionIndentWidth}
\newlength{\SubsectionIndentWidth}
\newlength{\SubsubsectionIndentWidth}
\newlength{\SectionLabelWidth}
\newlength{\SubsectionLabelWidth}
\newlength{\SubsubsectionLabelWidth}
\renewcommand*\l@chapter[2]{%
        \setlength{\ChapterLabelWidth}{1.5em}%
    \addtolength{\ChapterLabelWidth}{\ChapterExtraWidth}%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{\ChapterLabelWidth}%
    \if@tocleft
      \ifx\toc@l@number\@empty\else
        \setlength\@tempdima{0\toc@l@number}%
      \fi
    \fi
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \sectfont
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi%
}
\renewcommand*\l@section{%
        \setlength{\SectionLabelWidth}{2.3em}%
    \addtolength{\SectionLabelWidth}{\SectionExtraWidth}%
        \addtolength{\SectionLabelWidth}{-.5\ChapterExtraWidth}%
    \setlength{\SectionIndentWidth}{1.5em}%
        \addtolength{\SectionIndentWidth}{\ChapterExtraWidth}%
    \@dottedtocline{1}{\SectionIndentWidth}{\SectionLabelWidth}%
}
\renewcommand*\l@subsection{%
    \setlength{\SubsectionIndentWidth}{3.8em}%
    \addtolength{\SubsectionIndentWidth}{\ChapterExtraWidth}%
    \addtolength{\SubsectionIndentWidth}{\SectionExtraWidth}%
    \setlength{\SubsectionLabelWidth}{3.2em}%
    \addtolength{\SubsectionLabelWidth}{\SubsectionExtraWidth}%
    \addtolength{\SubsectionLabelWidth}{-\ChapterExtraWidth}%
    \@dottedtocline{2}{\SubsectionIndentWidth}{\SubsectionLabelWidth}%
}
\renewcommand*\l@subsubsection{%
\setlength{\SubsubsectionIndentWidth}{7.0em}%
\addtolength{\SubsubsectionIndentWidth}{\ChapterExtraWidth}%
\addtolength{\SubsubsectionIndentWidth}{\SectionExtraWidth}%
\addtolength{\SubsubsectionIndentWidth}{\SubsectionExtraWidth}%
\setlength{\SubsubsectionLabelWidth}{4.1em}%
\addtolength{\SubsubsectionLabelWidth}{-\ChapterExtraWidth}%
    \@dottedtocline{3}{\SubsubsectionIndentWidth}{\SubsubsectionLabelWidth}%
}
    \setlength{\marginparsep}{2mm}
    \setlength{\marginparwidth}{17mm}
    \setlength{\headsep}{.5\baselineskip}
\DeclareRobustCommand{\m@ntisgross}{
\geometry{width=117mm,height=195mm,includehead}
}
\DeclareRobustCommand{\m@ntisklein}{
    \geometry{width=100mm,height=182mm,includehead}
}
\ProcessOptions\relax
\renewcommand{\titlepagestyle}{empty}
\renewcommand{\partpagestyle}{empty}
\renewcommand{\chapterpagestyle}{empty}
\renewcommand{\indexpagestyle}{empty}
\renewcommand{\headfont}{\normalfont\small\itshape}
\newpagestyle{mentis}%
    {%
       {\rlap{\pagemark}%
            \hfill\leftmark\hfill
       }%
       {\hfill\rightmark\hfill
            \llap{\pagemark}%
       }%
       {\hfill\headmark\hfill
       }%
    }%
    {%
        {\hfill}%
        {\hfill}%
        {\hfill\pagemark\hfill}%
    }%
\renewcommand\@makefnmark{%
  \hbox{\ftntm@font{\textsuperscript{%
    \microtypecontext{protrusion=footnotes}\thefootnotemark}}}}
\SetProtrusion
 [ context = footnotes ]
 { font    = */*/*/*/scriptsize }
 { 0 = {,400},
   1 = {,650},
   2 = {,400},
   3 = {,400},
   4 = {,400},
   5 = {,400},
   6 = {,400},
   7 = {,500},
   8 = {,400},
   9 = {,400},
  }
\deffootnote[1.2em]{1.2em}{1.2em}{\textsuperscript{\thefootnotemark}\ }
\renewcommand*{\footnoterule}{%
  \hrule\@width 2cm
  \kern8\p@
}
\renewenvironment{quote}%
{\list{}{\setlength{\listparindent}{1em}%
         \setlength{\itemindent}{\z@}%
         \setlength{\leftmargin}{2em}%
         \setlength{\rightmargin}{\z@}%
         \setlength{\parsep}{\z@}%
        }%
    \smaller\item\relax\ignorespaces%
}%
{\endlist}%
\newenvironment{footquote}{\begin{quote}}{\end{quote}}%
\newcommand{\Dll}{\frqq}
\newcommand{\Drr}{\flqq}
\newcommand{\Dl}{\frq}
\newcommand{\Dr}{\flq}
\newcommand{\Ell}{\textquotedblleft}
\newcommand{\Err}{\textquotedblright}
\newcommand{\El}{\textquoteleft}
\newcommand{\Er}{\textquoteright}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \@maybeautodot\thechapter%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#2}%
                       \else
                         \addcontentsline{toc}{chapter}{#2}\fi
                    \else
                      \addcontentsline{toc}{chapter}{#2} %
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \@ifundefined{float@addtolists}{}{%
                      \float@addtolists{\protect\addvspace{10\p@}}}
                    \if@twocolumn
                      \if@at@twocolumn
                        \@makechapterhead{#2}%
                      \else
                        \@topnewpage[\@makechapterhead{#2}]%
                      \fi
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
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
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #8}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #8}}%
  \fi
  \@xsect{#5}%
}
\newcommand{\Pn@mskip}{\bigskip}%
\newcounter{Pn@msection}[chapter]%
\newcounter{Pn@msubsection}[section]%
\newcounter{Pn@msubsubsection}[subsection]%
\newcounter{Pn@mparagraph}[subsubsection]%
\newcommand*{\Pnum}[1]{%
    \ifthenelse{%
        \equal{#1}{}%
    }%
  {%
        \ifthenelse{%
            {\value{section}=0}\or{\value{Pn@msection}=1}%
        }{%
        \Pn@mskip\par\noindent%
        \refstepcounter{section}\setcounter{Pn@msection}{1}%
        {\usekomafont{sectioning}\thesection\ }%
        }%
        {%
            \ifthenelse{%
                {\value{subsection}=0}\or{\value{Pn@msubsection}=1}%
            }{%
                \Pn@mskip\par\noindent%
                \refstepcounter{subsection}\setcounter{Pn@msubsection}{1}%
                {\usekomafont{sectioning}\thesubsection\ }%
            }{%
                \ifthenelse{%
                    {\value{subsubsection}=0}\or{\value{Pn@msubsubsection}=1}%
                }{%
                    \Pn@mskip\par\noindent%
                    \refstepcounter{subsubsection}\setcounter{Pn@msubsubsection}{1}%
                    {\usekomafont{sectioning}\thesubsubsection\ }%
                }{%
                    \ifthenelse{%
                        {\value{paragraph}=0}\or{\value{Pn@mparagraph}=1}%
                    }{%
                        \Pn@mskip\par\noindent%
                        \refstepcounter{paragraph}\setcounter{Pn@mparagraph}{1}%
                        {\usekomafont{sectioning}\theparagraph\ }%
                    }{%

                        \ClassError{mentis}{Pnum hat kein Argument, findet aber auch keine Ebene mit Wert 0}%
                        {Pruefen Sie die Verwendung von Pnum!}%
                    }%
                }%
            }%
        }%
    }{%
    \Pn@mskip\par\noindent%
    {\usekomafont{sectioning}#1}\ %
    }%
}%
\newcommand{\absatz}{%
    {\removelastskip\medskip\centering $\star$ \\\medskip\noindent}%
}
\newcommand{\randnummer}[1]{\marginline{\small(#1)}}
\newcommand{\Psatz}[2]{%
    \begin{list}{}{%
        \setlength{\topsep}{0pt}%
        \setlength{\parsep}{0pt}%
        \setlength{\parskip}{0pt}%
        \setlength{\leftmargin}{2em}%
        \setlength{\rightmargin}{0pt}%
        \setlength{\listparindent}{\parindent}%
        }%
      \fussy%
      \ifthenelse{%
        \equal{#1}{}
      }%Dann:
      {\item{\makebox[0mm]{\rule{0mm}{0mm}}\ignorespaces#2}}
      {%
        \item{\makebox[0mm]{\rule{0mm}{0mm}}\randnummer{#1}\ignorespaces#2}%
      }
    \end{list}
}
\jurabibsetup{%
    authorformat=citationreversed,%
    authorformat=firstnotreversed,%
    authorformat=and,%
%%%    authorformat=indexed,%
    edby=true,%
    titleformat=all,%
    titleformat=colonsep,%
    ibidem=strict,%
    bibformat=ibidem,%
    see=true,%
    human=true,%
    commabeforerest=true%
}
\AddTo\bibsgerman{%
    \renewcommand*{\ibidemname}{Ebenda}
    \renewcommand*{\ibidemmidname}{ebenda}
}
\renewcommand*{\bibpldelim}{(}
\renewcommand*{\bibprdelim}{)}
\renewcommand*{\bibauthormultiple}{-- }
\renewcommand*{\bibfnfont}{}
\renewcommand*{\biblnfont}{\textsc}
\renewcommand*{\bibefnfont}{}
\renewcommand*{\bibelnfont}{\textsc}
\renewcommand*{\bibtfont}{\textit}
\renewcommand*{\bibbtfont}{\textit}
\renewcommand*{\bibjtfont}{\textit}
\providecommand*{\textAnfzeichen}[1]{{\Dll}#1{\Drr}}
\renewcommand{\bibapifont}{\textAnfzeichen}
\renewcommand{\jbapifont}{\textAnfzeichen}
\setlength{\jbbibhang}{1em}
\jbdotafterbibentry
\clubpenalty=5001 \widowpenalty=5001
\newcommand{\setB}{{\mathord{\mathbb B}}\xspace}
\newcommand{\setC}{{\mathord{\mathbb C}}\xspace}
\newcommand{\setN}{{\mathord{\mathbb N}}\xspace}
\newcommand{\setQ}{{\mathord{\mathbb Q}}\xspace}
\newcommand{\setR}{{\mathord{\mathbb R}}\xspace}
\newcommand{\setZ}{{\mathord{\mathbb Z}}\xspace}
\newcommand{\strich}{\ensuremath{{}^{\prime}}}%
\newcommand{\stern}{\ensuremath{{}^{\ast}}}
\newcommand{\spitz}[1]{%
\ensuremath{\langle\text{#1}\rangle}%
}
\newcommand{\textbfsf}[1]{%
{\sffamily\bfseries #1}%
}
\DeclareRobustCommand*\textsubscript[1]{%
  \@textsubscript{\selectfont#1}}%
\def\@textsubscript#1{%
  {\m@th\ensuremath{_{\mbox{\fontsize\sf@size\z@#1}}}}}
\newcommand{\tief}[1]{\textsubscript{#1}}%
\newcommand*{\hochtief}[2]{%
    {\m@th\ensuremath{%
        ^{\mbox{\fontsize\sf@size\z@\selectfont#1}}%
        _{\mbox{\fontsize\sf@size\z@\selectfont#2}}%
    }}%
}
\newcommand*{\roem}[1]{\textsc{\@roman{#1}}}
\newenvironment{tolerant}[1][4900]{%
    \par\tolerance=#1\relax
  }{%
    \par
  }
\newcommand{\fraktext}[1]{{\fontfamily{yfrak}\selectfont #1}}
\newcommand{\swabtext}[1]{{\fontfamily{yfrak}\textsl{#1}}}
\newcommand{\gothtext}[1]{{\fontfamily{yfrak}\textbf{#1}}}
\newcommand{\fett}[1]{\scalebox{1.25}[1]{#1}}
\newcommand{\antiktext}[1]{\textrm{\textup{#1}}}
\newcommand{\orgtheindex}{}
\let\orgtheindex\theindex
\let\orgendtheindex\endtheindex
\def\theindex{%
  \def\twocolumn{\begin{multicols}{2}}%
  \def\onecolumn{}%
  \clearpage\RaggedRight
  \orgtheindex
}
\def\endtheindex{%
  \end{multicols}%
  \orgendtheindex
}
\endinput
%%
%% End of file `mentis.cls'.
