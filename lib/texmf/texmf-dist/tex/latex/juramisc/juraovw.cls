% last change   : 20-Jun-03 23:29:56
% status        : beta
% created       : 20-Nov-01 12:20:26
%
% subject       : uebersichten, scripte
%
% to do         : 
%
% © Axel Sodtalbers

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{juraovw}[2003/06/20 V0.10 jur. uebersichten (AS)]

\RequirePackage{array}
\RequirePackage{pifont}
\RequirePackage{fancybox}
\RequirePackage{color} % model should be given in main document
\RequirePackage{jurabase}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}} % Begleiter 489  
\ProcessOptions\relax

\LoadClass[headsepline,normalheadings,pointlessnumbers]{scrartcl}

\newlength{\oldparskip}
\setlength{\oldparskip}{\parskip}

\newcommand{\biggerparskip}{\setlength{\parskip}{2.0ex}\normalsize}
\newcommand{\resetparskip}{\setlength{\parskip}{\oldparskip}} % wichtig fuer toc

\AtBeginDocument{%
  \pagestyle{headings}
  \setlength{\parindent}{0pt}
  \biggerparskip}  

\renewcommand{\contentsname}{\"Ubersicht}

\let\oldtoc\tableofcontents
\renewcommand{\tableofcontents}{%
  \resetparskip%
  \oldtoc}

% \settheme
% #1: Thema
% #2: angelegt am #2

\newcommand{\settheme}[2]{%
  \thispagestyle{empty}%
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}
  \begin{center}
  {\LARGE\sectfont #1% \sectfont kommt aus den koma-klassen
  \footnote[1]{Angelegt am #2; letzte \"Anderung am \today.}\bigskip}%
  \end{center}
  \renewcommand{\thefootnote}{\arabic{footnote}}
  }

\newcommand{\litname}{Lit.:}
\newcommand{\lithinweis}[1]{%
  \begin{description}
  \item[\litname]
  #1
  \end{description}%
  }

\newlength{\jdefboxwidth}
\addtolength{\jdefboxwidth}{\linewidth} % GePackt S. 232 - trotzdem in Liste zu gross
\addtolength{\jdefboxwidth}{-8em}

\setlength{\fboxsep}{6pt}

\definecolor{black}{gray}{0}
\definecolor{dark}{gray}{0.20}
\definecolor{middle}{gray}{0.40}
\definecolor{light}{gray}{0.80}
\definecolor{superlight}{gray}{0.90}

%\newcommand{\jdef}[1]{%
%  \begin{center}%
%  \ovalbox{%
%  \begin{minipage}{\jdefboxwidth}
%  #1%
%  \end{minipage}}
%  \end{center}
%  }

% #1: Quelle (optional, Textgroesse: footnotesize)
% #2: Definitionstext
\newcommand{\jdef}[2][blubb]{%
  \setlength{\fboxrule}{1.0pt} % standard=0.4pt
  \begin{center}
  \fcolorbox{black}{superlight}{%
    \begin{minipage}{\jdefboxwidth}
    #2%
    \ifthenelse{\equal{#1}{blubb}}
    {}% keine Quelle
  % else
    {\hspace*{\fill}{\footnotesize(#1)}}
    \end{minipage}
    }%
  \end{center}  
  }

\let\fall\jdef

\newcommand{\merkename}{Merke:}
\newcommand{\merke}[1]{%
  \setlength{\fboxrule}{.8pt} % standard=0.4pt
  \begin{center}
  \fcolorbox{middle}{light}{%
    \begin{minipage}{\jdefboxwidth}
      \ding{46}\space\textbf{\merkename}\space #1%
    \end{minipage}
    }%
  \end{center}  
  }
  
% #1: Breite (default: \jdefboxwidth)
% #2: Auszugebender Text.
\newcommand{\greybox}[2][\jdefboxwidth]{%
  \setlength{\fboxrule}{.8pt} % standard=0.4pt
  \begin{center}
  \fcolorbox{middle}{superlight}{%
    \begin{minipage}{#1}
      #2%
    \end{minipage}
    }%
  \end{center}  
  }  

\newcommand{\bspname}{Bsp.:}
\newenvironment{beispiel}%
  {\begin{small}%
   \begin{description}
   \item[\bspname]
  }
  {\end{description}
   \end{small}
  }

\newenvironment{hinweis}%
  {\begin{small}}
  {\end{small}}
   
\newenvironment{uebersicht}
  {\begin{center}
   \begin{Sbox} % this is from fancybox
   \begin{minipage}{0.1pt}% is ignored anyway (but why?)
  }
  {\end{minipage}
   \end{Sbox}
   \shadowbox{\TheSbox}
   \end{center}%
  }   

% #1: Paragraph
% #2: Bennenung (sollte optional sein!)

\newenvironment{gesetzestext}[2]
 {\begin{center}
  \begin{minipage}{.65\textwidth}%
  \setlength{\parindent}{1em}%
  \begin{scriptsize}
  \begin{center}
  {\bfseries #1\par #2\par}%
  \end{center} 
 }
 {\end{scriptsize}
  \end{minipage}%
  \end{center}
 }
  
% Begleiter 345
\newcommand{\okay}{\ding{52}}

\newcommand{\hand}{\ding{43}} 

\newenvironment{hands}%
  {\begin{dinglist}{43}}
  {\end{dinglist}}

\newcommand{\lonelyhand}[1]{%
  \begin{haende}
  \item #1
  \end{haende}%
  }
    
\newenvironment{stars}%
  {\begin{dinglist}{72}}
  {\end{dinglist}}

\newenvironment{triangles}%
  {\begin{dinglist}{228}}
  {\end{dinglist}} 
  
\newcommand{\lonelytriangle}[1]{%
  \begin{triangles}
  \item #1
  \end{triangles}%
  }    
  
\newenvironment{aufzaehlung}%
  {\begin{dingautolist}{192}}
  {\end{dingautolist}}  
  
\newcommand{\formulierung}[1]{%
  \begin{quote}%
  \begin{itshape}%
  "`\marginpar{Frm}%
  #1"'%
  \end{itshape}%
  \end{quote}
  }
  
%\newcommand{\jhint}{1}{% Hinweise in den Rand.
%  \marginpar{\hfill #1}{}%
%  }
  

\endinput
% end of juraovw.cls
