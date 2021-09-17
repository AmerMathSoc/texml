package TeX::Interpreter::LaTeX::Class::notices;

use strict;
use warnings;

use version; our $VERSION = qv '1.2.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_document_class('amsart', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::notices::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesClass{notices}

\setcounter{secnumdepth}{3}

\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{xspace}
\RequirePackage{amsthm}
\RequirePackage{subfig}
\RequirePackage{xcolor}

\RequirePackage[lite,nobysame]{amsrefs}

\RequirePackage{hyperref}

\let\category\@gobble

\newcommand{\titlepic}{\def\@titlepic}

\let\@titlepic\@empty

\def\thanks{\authorbio}

% \newcommand{\notiemail}[1]{\texttt{\upshape\nolinkurl{#1}}}
\newcommand{\notiemail}{\XMLelement{email}}

% Doesn't handle catcode changes

\newcommand{\notiurl}[2][\@empty]{%
    \begingroup
        \upshape\ttfamily
        \ifx\@empty#1%
            \href{https://#2}{\nolinkurl{#2}}%
        \else
            \href{https://#2}{\nolinkurl{#1}}%
        \fi
    \endgroup
}

\newcounter{@authcnt}
\newcommand{\authorgraphics}[1][0pt]{%
  \let\endauthorgraphics\relax%
  \par
  \begingroup
    \baselineskip=0pt\parindent=0pt%
    \setcounter{@authcnt}{0}%
    \sffamily\fontsize{9}{11}\selectfont
    \@tempdima 1pc
    \advance\@tempdima #1%
    \addvspace\@tempdima
    \@authorgraphicsi
}
\newcommand{\@authorgraphicsi}{\@ifnextchar\endauthorgraphics{\@endauthorgraphics}{\@authorgraphicsii}}
\newcommand{\@authorgraphicsii}[2]{%
%   \ifodd\value{@authcnt}\kern1pc\else
%   \ifnum\value{@authcnt}>0 \\[1pc]\fi\fi
%   \parbox[t]{7pc}{\baselineskip=0pt\includegraphics[width=7pc,height=9pc]{#2}\\[3bp]#1}%
  \stepcounter{@authcnt}\@authorgraphicsi%
}
\newcommand{\@endauthorgraphics}{\endgroup\par}

\let\c@refhead\c@section
\def\therefhead{\thesection}

\newcommand{\refhead}{%
    \@startsection
        {refhead}%
        {10}%
        {0pt}%
        {9pt}%
        {2pt}%
        {%
            \sffamily\bfseries
            \fontsize{9}{11pt}\selectfont
            \color{Aheadcolor}%
        }%
}

\let\c@zhead\c@section
\def\thezhead{\thesection}

\def\zhead{%
    \@startsection
        {zhead}%
        {1}%
        \z@
        {17pt}%
        {12pt}%
        {%
            \normalfont\fontsize{18}{21}\selectfont
            \color{Zheadcolor}%
        }%
}

\let\c@zauthor\c@section
\def\thezauthor{\thesection}

\newcommand{\zauthor}{%
    \@startsection
        {zauthor}%
        {100}% never numbered
        {0pt}%
        {0pt}%
        {7pt}%
        {%
            \normalfont\itshape
            \fontsize{16}{18pt}\selectfont
        }%
}

\newcommand{\zthanks}[1]{%
    \begingroup
    \let\@makefnmark\relax
    \let\@thefnmark\relax
    \@footnotetext{%
        \normalfont
        \fontsize{8}{11pt}\selectfont
        \parindent\z@
        \emergencystretch0em
        \begingroup
        \itshape
        #1\@addpunct.\par
        \endgroup
    }%
    \endgroup
}

\newenvironment{PhotoCredits}[1][Credits]{%
    \par
    \refhead{#1}
}{%
    \par
}

\newenvironment{acknowledgment}[1][Acknowledgment]{%
    \def\XML@section@tag{sec}
    \section*{#1}
}{%
}

\newenvironment{intro}{%
    \section*{}
}{%
}

\def\reviewheaderskip#1{%
    \parskip#1%
    \everypar{{\setbox\z@\lastbox}\parskip\z@\everypar{}}%
}
%    \end{macrocode}
%    \end{macro}
%
%    \begin{macro}{\reviewedwork}
%    Arguments of \cs{reviewedwork}:
%\begin{verbatim}
%    #1       #2      #3      #4       #5       #6       #7
% [# LINES][BORDER?]{GRAPHIC}{BYLINE}{TITLE}{SUBTITLE}{AUTHORS}
%\end{verbatim}
%    \begin{macrocode}

\def\reviewedwork{%
  \@ifnextchar[%
    {\reviewedwork@border}
    {\reviewedwork@border[7]}%
}

\def\reviewedwork@border[#1]{%
  \@ifnextchar[%
    {\reviewedwork@main{#1}}
    {\reviewedwork@main{#1}[]}%
}

% [# LINES][BORDER?]{GRAPHIC}{BYLINE}{TITLE}{SUBTITLE}{AUTHORS}

\def\reviewedwork@main#1[#2]#3#4#5#6#7{%
    \par
    \startXMLelement{sec}%
    \setXMLattribute{specific-use}{reviewedwork}%
    \par
    \if###3##\else
        {\xmlpartag{title}#3\par}%
    \fi
    \if###4##\else
        {\xmlpartag{subtitle}#4\par}%
    \fi
    \if###5##\else
        {\xmlpartag{authors}#5\par}%
    \fi
    \if###1##\else
        {\xmlpartag{graphic}#6\par}%
    \fi
    \if###2##\else
        {\xmlpartag{byline}#2\par}%
    \fi
    \endXMLelement{sec}%
}

\def\fullcolumnad{\end{document}}

\TeXMLendClass

\endinput

__END__
