% !TEX TS-program = pdflatex
% !TEX encoding = Windows Latin 1
% !TEX root = main.tex
%
% Clase para las tesis de ingenieria de la Universidad de los Andes
% 2012/07/27, v.1.9
% Autor: Nicolas Vaughan (nivaca@fastmail.net)


\NeedsTeXFormat{LaTeX2e}
\def\filedate{2012/03/09}
\def\fileversion{v1.9}
\typeout{\space}\typeout{************************************************************}
\typeout{Class tui \fileversion\space<\filedate> -- Uniandes Engineering Thesis Class}

\ProvidesClass{tui}[\filedate\space\fileversion\space Uniandes Thesis Class]

\RequirePackage{kvoptions}[2010/02/22] % para opciones avanzadas de la clase


%%%%%%%%%%%%%%%%%%%%%%%%%%  Class Options  %%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareBoolOption[false]{noblancas}  % No anadir paginas en blanco
\DeclareBoolOption[true]{spanish}     % En espanol
\DeclareComplementaryOption{english}{spanish} % En ingles
\DeclareBoolOption[false]{draft}      % Borrador
\DeclareBoolOption[false]{publish}    % Terminado para imprenta
\DeclareBoolOption[true]{microtype}   % Usar Microtype
\DeclareBoolOption[true]{kpfonts}     % Usar fuentes KPfonts
\DeclareBoolOption[false]{times}      % Usar fuente Times
\DeclareBoolOption[false]{nofonts}    % No cargar fuentes adicionales
\DeclareBoolOption[true]{mnsymbol}    % Usar simbolos de Minion Symbol
\DeclareBoolOption[false]{grande}     % Usar fuentes grandes (menos de 150 paginas)
\ProcessKeyvalOptions*


\iftui@noblancas
  \PassOptionsToClass{openany}{memoir}
\else
  \PassOptionsToClass{openright}{memoir}
\fi


% OJO:
% Si hay partes de la tesis en otras lenguas (e.g., el abstract en neerlandes), es necesario introducir estas al final de ambas listas, e.g.:
%	\iftui@spanish
%	  \PassOptionsToPackage{spanish,es-tabla,es-nolists,es-lcroman,english,dutch}{babel}
%	\else
%	  \PassOptionsToPackage{english,spanish,dutch}{babel}
%	\fi

\iftui@spanish
	\PassOptionsToPackage{spanish,es-tabla,es-nolists,es-lcroman,english}{babel}
\else 
	\PassOptionsToPackage{english,spanish,es-nolists,es-lcroman}{babel}
\fi


\iftui@draft
  \PassOptionsToClass{draft}{memoir}%
  \PassOptionsToPackage{draft}{hyperref}%
  \PassOptionsToPackage{final}{microtype}%  siempre es final aqui
\else
  \PassOptionsToClass{final}{memoir}%
  \PassOptionsToPackage{final}{hyperref}%
\fi

\iftui@microtype
  \PassOptionsToPackage{tracking=true,expansion=true,protrusion=true}{microtype}
\else
  \PassOptionsToPackage{draft}{microtype}
\fi

\iftui@publish
  \PassOptionsToClass{showtrims}{memoir}
  \PassOptionsToPackage{hidelinks=true, final}{hyperref}%
\else\relax
\fi

\iftui@grande
  \PassOptionsToClass{11pt}{memoir}
  \parindent=13pt
\else
	\PassOptionsToClass{10pt}{memoir}
	\parindent=12pt
\fi

% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

\LoadClass{memoir}[2011/03/06]

% Load required packages

\RequirePackage[latin1]{inputenc}[2008/03/30]  % Codificacion Latin 1

%\RequirePackage[utf8]{inputenc}[2008/03/30] % Si es unicode
%\RequirePackage[T1]{fontenc}[2005/09/27]    % Si es unicode


\RequirePackage{makeidx}

\RequirePackage{babel}

\RequirePackage[babel=true,
  verbose=false,
  tracking=true,
  expansion=true,
  protrusion=true
  ]{microtype}[2010/01/10] % Opciones tipograficas avanzadas

\SetTracking{encoding = *, shape = sc}{60}
\SetTracking[context = notracking]{encoding = *}{0}
\SetTracking[context = smalltracking]{encoding = *, shape = sc}{20}


\iftui@times\tui@kpfontsfalse\tui@nofontsfalse\else\relax\fi
\iftui@nofonts\tui@kpfontsfalse\else\relax\fi

\iftui@kpfonts
  \RequirePackage[uprightgreeks,nott]{kpfonts}[2010/08/20] % KPFonts
\else
  \iftui@times
    \RequirePackage{mathptmx}[2005/04/1] % Times
  \else\relax
  \fi
\fi

\RequirePackage[pdftex]{hyperref}[2011/03/09]
\RequirePackage{amsmath}[2000/07/18]
\RequirePackage{amsthm}[2004/08/06]
\RequirePackage{amssymb}[2009/06/22]
\RequirePackage{xcolor}[2007/01/21]
\RequirePackage[pdftex]{graphicx}[1999/02/1]
\RequirePackage{makeidx}
\RequirePackage{courier}[2005/04/12]
\RequirePackage[autostyle=false, style=british]{csquotes}[2011/03/25] % Comillas inteligentes
\RequirePackage{breakurl}[2009/01/24]


\iftui@mnsymbol
  \RequirePackage{MnSymbol}[2007/01/21]
\else\relax
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page Layout
\iftui@publish
  \setstocksize{28cm}{22cm}
  \settrimmedsize{24cm}{17cm}{*}
  \settrims{20mm}{20mm}
  \quarkmarks
\else
  \setstocksize{24cm}{17cm}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrimmedsize{24cm}{17cm}{*}
  \settrims{0pt}{0pt}
\fi
\settypeblocksize{18cm}{11cm}{*}
\setlrmargins{2.5cm}{*}{*}
\setulmargins{*}{*}{1}
\setmarginnotes{1em}{2cm}{\baselineskip}
\setlength{\footskip}{\onelineskip}
\setlength{\footnotesep}{\onelineskip}
\checkandfixthelayout[nearest]

\fixpdflayout
\pdfminorversion=4  % Para la imprenta

% Penalites etc.---------------------------------------------------------
\clubpenalty=10000
\widowpenalty=9500
\brokenpenalty=4991
\predisplaypenalty=10000
\postdisplaypenalty=1549
\displaywidowpenalty=1602
\flushbottom
\raggedbottom
\frenchspacing

% Headers y footers ----------------------------------------------------
\makepagestyle{tui}
\makeevenfoot{tui}{}{}{}
\makeoddfoot{tui}{}{}{}
\makeheadrule{tui}{\textwidth}{\normalrulethickness}
\newcommand*{\@tuimarks}{%
  \def\chaptermark##1{%
    \markboth{%
      \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
          \thechapter. \ %
        \fi
      \fi
      ##1}{}}
  \def \sectionmark##1{\markright{##1}}
  \def\tocmark{\markboth{\contentsname}{}}
  \def\lofmark{\markboth{\listfigurename}{}}
  \def\lotmark{\markboth{\listtablename}{}}
  \def\bibmark{\markboth{\bibname}{}}
  \def\appendixmark{\markboth{\appendixname}{}}
  \def\indexmark{\markboth{\indexname}{}}
  \def\glossarymark{\markboth{\nomname}{}}
}% \@tuimarks

\renewcommand*{\@tuimarks}{%
  \nouppercaseheads
  \createmark{chapter}{left}{nonumber}{\ }{. \ }
  \createmark{section}{right}{shownumber}{\microtypecontext{tracking=smalltracking}}{\ \ }
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{appendix}{both}{\appendixname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\nomname}
}% \@tuimarks

\makepsmarks{tui}{\@tuimarks}
\makeevenhead{tui}{{\normalfont\thepage}\quad{\scshape\leftmark}}{}{}
\makeoddhead{tui}{}{}{{\scshape\rightmark}\quad{\normalfont\thepage}}

%\aliaspagestyle{tui}{ruled}
\pagestyle{tui}

\newcommand*{\setupheaders}{\createmark{section}{right}{shownumber}{}{\ \ }}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document divisions
%
% Chapter style ------------------------------------
\makechapterstyle{tuics}{% requires graphicx package
  \chapterstyle{default}
  \setlength{\beforechapskip}{4\onelineskip}
  \renewcommand*{\chapnamefont}{%
    \normalfont\Large\scshape\raggedleft}
  \renewcommand*{\chaptitlefont}{%
    \normalfont\Huge\scshape\bfseries\raggedleft}
  \renewcommand*{\chapternamenum}{}
  \renewcommand*{\printchapternum}{%
    \makebox[0pt][l]{\hspace{0.4em}%
      \resizebox{!}{4ex}{%
        \chapnamefont\bfseries\color[gray]{.4}\thechapter}%
    }%
  }%
  \renewcommand*{\printchapternonum}{%
    \chapnamefont \phantom{\printchaptername \chapternamenum%
      \makebox[0pt][l]{\hspace{0.4em}%
        \resizebox{!}{4ex}{%
          \chapnamefont\bfseries 1}%
      }%
    }%
    \afterchapternum %
  }%
  \renewcommand*{\afterchapternum}{%
    \par\hspace{1.5cm}\hrule\vskip\midchapskip}}

\chapterstyle{tuics}

% Section style -----------------------------------
\setsecheadstyle{\raggedright\noindent\Large\bfseries\scshape}
\setbeforesecskip{-1\onelineskip plus -1ex minus -.2ex}
\setaftersecskip{2.3ex plus .2ex}

% Subsection style -----------------------------------
\setsubsecheadstyle{\raggedright\noindent\large\bfseries}
\setbeforesubsecskip{-1\onelineskip plus -1ex minus -.2ex}
\setaftersubsecskip{1.5ex plus .2ex}

% Subsubsection style -----------------------------------
\setsubsubsecheadstyle{\raggedright\noindent\large\em\bfseries}
\setbeforesubsubsecskip{-1\onelineskip plus -1ex minus -.2ex}
\setaftersubsubsecskip{1.5ex plus .2ex}

\setsecnumdepth{subsubsection}
\maxsecnumdepth{subsubsection}
\maxtocdepth{section}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           TOC etc.
\renewcommand*{\cftsectiondotsep}{\cftnodots}
\renewcommand*{\cftfiguredotsep}{\cftnodots}
\renewcommand*{\cfttabledotsep}{\cftnodots}

\renewcommand*{\cftchapterfont}{\bfseries\scshape}
\renewcommand*{\cftchapterpagefont}{\bfseries\scshape}
\renewcommand*{\cftsectionfont}{\normalfont}
\renewcommand*{\cftsectionpagefont}{\normalfont}
\renewcommand*{\cftfigurefont}{\normalfont}
\renewcommand*{\cftfigurepagefont}{\normalfont}
\renewcommand*{\cfttablefont}{\normalfont}
\renewcommand*{\cfttablepagefont}{\normalfont}

\setlength{\cftbeforechapterskip}{6pt}
\setlength{\cftbeforesectionskip}{0pt}
\setlength{\cftbeforefigureskip}{0pt}
\setlength{\cftbeforetableskip}{0pt}
\cftsetindents{section}{1.5em}{3.0em}
\cftsetindents{figure}{0em}{3.0em}
\cftsetindents{table}{0em}{3.0em}
\setrmarg{3.55em}
\setpnumwidth{3.55em}
\AtEndDocument{\addtocontents{toc}{\par}}
\AtEndDocument{\addtocontents{lof}{\par}}
\AtEndDocument{\addtocontents{lot}{\par}}
% -----------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Footnotes
\footmarkstyle{{\mbox{\textsuperscript{#1}}}\,}
\setfootnoterule[\vfill]{3pt}{48pt}{.5pt}

% Localizacion ----------------------------------------
\newcommand*{\Agradecimientos}{%
  \iftui@spanish%
    \chapter{Agradecimientos}%
  \else%
    \chapter{Acknowledgments}%
  \fi%
  \pagestyle{tui}%
}

\newcommand*{\Introduccion}{%
  \iftui@spanish%
    \chapter{Introducci{\'o}n}%
  \else%
    \chapter{Introduction}%
  \fi%
  \pagestyle{tui}%
}

\newcommand*{\CrearIndice}{%
\iftui@spanish%
   \renewcommand*{\indexname}{{\'I}ndice anal{\'i}tico}%
  \else\relax\fi%
	\printindex%
	\pagestyle{tui}%
}

\newcommand*{\ListofSymbols}{%
\iftui@spanish%
    \chapter{S{\'i}mbolos usados}%
  \else%
    \chapter{List of Symbols}%
  \fi%
  \pagestyle{tui}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Otros comandos


\iftui@noblancas%
	\def\cleardoublepage{\relax}
\else%
	\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
	  \hbox{}\thispagestyle{cleared}%
	  \newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}%
\fi	 


\newcommand*{\dosenblanco}{%
\iftui@noblancas\relax%
	\else%
	\hbox{}\newpage%
	\hbox{}\newpage%
	\fi
}


\newcommand*{\tuitableofcontents}{%
	\cleardoublepage%
\iftui@spanish
  \renewcommand*{\spanishcontentsname}{\'{I}ndice}
  \else\relax
  \fi
	\hbox{}%
	\tableofcontents*%
	\pagestyle{tui}%
}

\DeclareGraphicsExtensions{.eps,.bmp,.wmf,.pdf}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\sangrar}{\hspace*{13pt}}

\newcommand*{\elipsis}{.\,.\,.}

\bibliographystyle{plain}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language Options. . .
\newcommand*{\checklanguage}{%
\iftui@spanish
	\selectlanguage{spanish}
\else
	\selectlanguage{english}
\fi
}

% Setup everything. . . 
\newcommand*{\setupeverything}{%
\checklanguage
\setlength{\labelsep}{.5ex} % para description
}




% end of the style file: tui.cls
\typeout{End tui.cls}
\endinput
