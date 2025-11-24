%%
%% This is file `musuos.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% musuos.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2011 by Tobias Weh
%%                       www.tobias-weh.de
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.2 of this license or (at your option) any later
%% version. The latest version of this license is in:
%% 
%%   http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of
%% LaTeX version 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[2009/01/01]
\ProvidesClass{musuos}
  [2011/12/17 v1.1d a class for typesetting
   papers. Uni Osnabrueck, music dept.]
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=MU,
  prefix=MU@
}
\RequirePackage{environ}
\RequirePackage{etoolbox}
\DeclareStringOption[withqmarks]{blockquote}[withqmarks]
\DeclareStringOption[german]{qmarks}[german]
\newif\if@poorlayout
\DeclareOption{poorlayout}{\@poorlayouttrue}
\newif\if@manyfnotes
\DeclareOption{manyfnotes}{\@manyfnotestrue}
\newif\if@twocolfnotes
\DeclareOption{twocolfnotes}{\@twocolfnotestrue}
\newif\if@nofnoterule
\DeclareOption{nofnoterule}{\@nofnoteruletrue}
\newif\if@centerfloats
\@centerfloatstrue
\DeclareOption{dontcenterfloats}{\@centerfloatsfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\PassOptionsToClass{fontsize=12pt,titlepage=true}{scrartcl}
\ProcessKeyvalOptions*\relax
\ProcessOptions\relax
\LoadClass{scrartcl}
\newif\if@bqqmarks
\expandafter\ifstrequal\expandafter{\MU@blockquote}{withqmarks}{
  \@bqqmarkstrue
}{
  \expandafter\ifstrequal\expandafter{\MU@blockquote}{withoutqmarks}{
    \@bqqmarksfalse
  }{
    \ClassError{musuos}{Unkown value for option 'blockquote'}
      {This option needs either 'qwithqmarks' or 'withoutmarks'}
  }
}
\RequirePackage{geometry}
\if@poorlayout
  \geometry{left=2cm, right=3cm, top=3cm, bottom=3cm}
  \usepackage{txfonts}
  \usepackage[scaled=0.9]{helvet}
  \usepackage{setspace}
   \setstretch{1.45}
  \ClassWarningNoLine{musuos}{Are you shure that you would
    like to use the poor layout?}
\else
  \geometry{left=3.5cm, right=4.75cm, top=3.25cm, bottom=5.5cm}
  \usepackage{kpfonts}
  \usepackage[scale=0.9]{tgheros}
  \KOMAoptions{fontsize=11.5pt}
\fi
\tolerance 1414
\hbadness 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\widowpenalty=10000
\clubpenalty=5000
\vfuzz
\hfuzz
\raggedbottom
\newcommand{\@city}{}
\newcommand{\@street}{}
\newcommand{\@email}{}
\newcommand{\@phone}{}
\newcommand{\@lecturer}{}
\newcommand{\@seminar}{}
\newcommand{\@term}{}
\newcommand{\@uni}{}
\newcommand{\@study}{}
\newcommand{\@sterm}{}
\newcommand{\@examinerI}{}
\newcommand{\@examinerIlabel}{}
\newcommand{\@examinerII}{}
\newcommand{\@examinerIIlabel}{}
\newcommand*{\city}[1]{\renewcommand{\@city}{#1}}
\newcommand*{\street}[1]{\renewcommand{\@street}{#1}}
\newcommand*{\email}[1]{\renewcommand{\@email}{#1}}
\newcommand*{\phone}[1]{\renewcommand{\@phone}{#1}}
\newcommand*{\lecturer}[1]{\renewcommand{\@lecturer}{#1}}
\newcommand*{\seminar}[1]{\renewcommand{\@seminar}{#1}}
\newcommand*{\term}[1]{\renewcommand{\@term}{#1}}
\newcommand*{\uni}[1]{\renewcommand{\@uni}{#1}}
\newcommand*{\study}[1]{\renewcommand{\@study}{#1}}
\newcommand*{\sterm}[1]{\renewcommand{\@sterm}{#1}}
\newcommand*{\examinerI}[2]{%
  \renewcommand{\@examinerIlabel}{#1}%
  \renewcommand{\@examinerI}{#2}%
}
\newcommand*{\examinerII}[2]{%
  \renewcommand{\@examinerIIlabel}{#1}%
  \renewcommand{\@examinerII}{#2}%
}
\newcommand*{\examiner}[2]{%
  \renewcommand{\@examinerIlabel}{#1}%
  \renewcommand{\@examinerI}{#2}%
  \ClassWarning{musuos}{\string\examiner\space is obsolete use \string\examinerI}
}
\newif\if@letesep\@leteseptrue
\renewcommand{\maketitle}{%
  \newgeometry{left=4cm,right=4cm,top=4cm,bottom=4cm}%
  \begin{titlepage}
  \expandafter\ifstrempty\expandafter{\@lecturer}{\@letesepfalse}{}
  \expandafter\ifstrempty\expandafter{\@term}{\@letesepfalse}{}
    \if@poorlayout\singlespacing\fi
    \centering
    \textbf{\@uni}\par
    \@seminar\par
    \@lecturer\
    \if@letesep -- \fi
    \@term\par
    \vspace{4.5cm}
    \textit{\@subject}\par
    \if@poorlayout\vspace{0.35cm}\else\vspace{0.5cm}\fi
    \sffamily\Huge\textbf{\@title}\par
    \vspace{0.5cm}
    \large\@subtitle\par
    \vspace{3cm}
    \normalfont\normalsize
    \begin{tabular}{ll}
      \@examinerIlabel & \@examinerI \\
      \@examinerIIlabel & \@examinerII \\
    \end{tabular}\par
    \vspace{\fill}
    \raggedright
    \textbf{\@author}\par
    \@study\hfill\@street\par
    \@sterm\hfill\@city\par
    \@email\hfill\@phone\par
    \vspace{1\baselineskip}
    \@date
  \end{titlepage}
  \restoregeometry
  \@afterindentfalse
  \@afterheading%
}
\newcommand{\makeshorttitle}{
  \if@poorlayout\singlespacing\fi
  \vspace*{1cm}
  {\centering
    \@author\par
    \vspace{0.35cm}
    \LARGE\sffamily\bfseries\@title\par
    \vspace{0.2cm}
    \normalsize\@subtitle\par
    \vspace{0.6cm}
    \normalfont
    \@date\par
  }
  \vspace{1cm}
  \if@poorlayout\setstretch{1.45}\fi
  \@afterindentfalse
  \@afterheading%
}
\if@titlepage\else
  \let\maketitle\makeshorttitle
\fi
\RequirePackage{titletoc}
\titlecontents{section}
  [0mm]
  {\addvspace{5mm}}
  {\sffamily\bfseries\large
  \makebox[7mm][l]{\thecontentslabel}}
  {\sffamily\bfseries}
  {\hfill\sffamily\bfseries\large\contentspage}
\titlecontents{subsection}
  [7mm]
  {\addvspace{1mm}}
  {\makebox[7mm][l]{\thecontentslabel}}
  {}
  {,~\thecontentspage}
\titlecontents*{subsubsection}
  [14mm]
  {\filright}
  {\itshape}
  {\itshape}
  {\itshape,~\thecontentspage}
  [~$\cdot$~]
\setcounter{tocdepth}{3}
\if@poorlayout
  \preto\tableofcontents{\singlespacing}
  \appto\tableofcontents{\setstretch{1.45}}
\fi
\KOMAoptions{listof=totoc}
\PassOptionsToPackage{bibliography=totoc}{biblatex}
\if@manyfnotes
  \deffootnote[1.75em]{1.75em}{1em}{
    \makebox[1.75em][l]{\thefootnotemark}
  }
\else
  \deffootnote[1.5em]{1.5em}{1em}{\makebox[1.5em][l]{\thefootnotemark}}
\fi
\if@twocolfnotes
  \usepackage{dblfnote}
  \setlength{\DFNcolumnsep}{2em}
  \setkomafont{footnote}{\scriptsize}
  \renewcommand{\footnoterule}{\noindent\rule{85mm}{.4pt}\vspace{1mm}}
\fi
\if@nofnoterule
  \renewcommand{\footnoterule}{\rule{0mm}{.4pt}\vspace{1mm}}
\fi
\renewcommand{\labelitemi}{\rule[0.35ex]{0.5ex}{0.5ex}}
\renewcommand{\labelitemii}{\rule[0.35ex]{0.5ex}{0.5ex}}
\renewcommand{\labelitemiii}{\rule[0.35ex]{0.5ex}{0.5ex}}
\renewcommand{\labelitemiv}{\rule[0.35ex]{0.5ex}{0.5ex}}
\renewcommand{\labelenumi}{\theenumi)}
\renewcommand{\labelenumii}{\theenumii)}
\renewcommand{\labelenumiii}{\theenumiii)}
\renewcommand{\labelenumiv}{\theenumiv)}
\AtEndPreamble{
\@ifpackageloaded{csquotes}{
  \ClassWarning{musuos}{csquotes.sty loaded by user.\MessageBreak
  Option 'qmarks' will be ignored.}
}{
\RequirePackage{csquotes}
\expandafter\ifstrequal\expandafter{\MU@qmarks}{german}{
  \ExecuteQuoteOptions{style=german,german=quotes}
}{
  \expandafter\ifstrequal\expandafter{\MU@qmarks}{gfrench}{
    \ExecuteQuoteOptions{style=german,german=guillemets}
  }{
    \expandafter\ifstrequal\expandafter{\MU@qmarks}{english}{
      \ExecuteQuoteOptions{style=english,english=american}
    }{
      \expandafter\ifstrequal\expandafter{\MU@qmarks}{french}{
        \ExecuteQuoteOptions{style=french,french=guillemets}
      }{
        \ClassError{musuos}{Unkown value for option 'qmarks'}{
          Use 'german', 'gfrench', 'french', 'english'\MessageBreak
          or load csquotes.sty by yourself.
        }
      }
    }
  }
}
}}
\let\quote\relax
\let\endquote\relax
\newkomafont{quotetext}{\footnotesize}
\newlength{\blockmargin}
\setlength{\blockmargin}{\leftmargini}
\NewEnviron{quote}[1][]{%
  \par\vspace{0.5\baselineskip}%
  \if@poorlayout\setstretch{1.1}\fi%
  \begin{addmargin}{\blockmargin}%
    \usekomafont{quotetext}%
    \if@bqqmarks\enquote{\BODY}\else\BODY\fi%
    #1%
  \end{addmargin}%
  \vspace{0.5\baselineskip}
  \if@poorlayout\setstretch{1.45}\fi%
}
\RequirePackage{xspace}
\newcommand{\elp}{[\kern0.5pt\dots\kern-1pt]\xspace}
\newcommand{\sic}{[sic]\xspace}
\newcommand{\miss}[1]{[#1]}
\NewEnviron{block}[1][]{%
  \par\vspace{0.5\baselineskip}%
  \if@poorlayout\setstretch{1.1}\fi%
  \begin{addmargin}{\blockmargin}%
    \usekomafont{quotetext}%
    \BODY
  \end{addmargin}%
  \vspace{0.5\baselineskip}
  \if@poorlayout\setstretch{1.45}\fi%
}
\RequirePackage{verse}
\verselinenumbersleft
\setlength{\vrightskip}{-1.5\leftmargin}
\newkomafont{linenumbers}{\normalfont\tiny}
\verselinenumfont{\usekomafont{linenumbers}}
\newcommand{\mu@ln@modulo}{2}
\newcommand*{\linenumbermodulo}[1]{%
  \if@integer{#1}%
    \renewcommand{\mu@ln@modulo}{#1}
  \else
    \ClassError{musuos}{%
      \string\linenumbermodulo\space needs an integer
    }{%
      The command \string\linenumbermodulo\space
      needs an Integer as value.\MessageBreak
      If you sure that you gave an
      integer you found a bug,\MessageBreak
      please contact the class maintainer.
    }%
  \fi
}
\let\mu@orig@verse\verse
\let\mu@orig@endverse\endverse
\newkomafont{verse}{\itshape}
\def\if@integer#1{%
  \begingroup \lccode`\-=`\0 \lccode`+=`\0
    \lccode`\1=`\0 \lccode`\2=`\0 \lccode`\3=`\0
    \lccode`\4=`\0 \lccode`\5=`\0 \lccode`\6=`\0
    \lccode`\7=`\0 \lccode`\8=`\0 \lccode`\9=`\0
  \lowercase{\endgroup
    \expandafter\ifx\expandafter\delimiter
    \romannumeral0\string#1}\delimiter
}
\let\verse\relax
\let\endverse\relax
\NewEnviron{verse}[1][]{%
  \usekomafont{verse}%
  \mu@orig@verse%
    \if@integer{#1}%
      \poemlines{\mu@ln@modulo}%
      \setverselinenums{#1}{#1}
    \else%
      \ClassWarning{musuos}{%
        The optinal argument of verse seems to\MessageBreak
        be no number. I'm going to ignore it.
      }%
    \fi%
    \BODY%
  \mu@orig@endverse%
  \if@integer{#1}\poemlines{0}\fi%
}
\usepackage{float}
\newfloat{music}{htpb}{lom}
\floatname{music}{Notenbeispiel}
\AtBeginDocument{%
  \@ifpackageloaded{subcaption}{%
    \DeclareCaptionSubType{music}%
  }{}%
}
\newcommand{\listofmusic}{%
  \listof{music}{Notenbeispiele}
}
\if@centerfloats
\let\mu@orig@music\music
\let\mu@orig@endmusic\endmusic
\renewenvironment{music}[1][htpb]{%
  \mu@orig@music[#1]
  \centering}%
  {\mu@orig@endmusic}

\let\mu@orig@table\table
\let\mu@orig@endtable\endtable
\renewenvironment{table}[1][htpb]{%
  \mu@orig@table[#1]
  \centering}%
  {\mu@orig@endtable}

\let\mu@orig@figure\figure
\let\mu@orig@endfigure\endfigure
\renewenvironment{figure}[1][htpb]{%
  \mu@orig@figure[#1]
  \centering}%
  {\mu@orig@endfigure}
\fi
\endinput
%%
%% End of file `musuos.cls'.
