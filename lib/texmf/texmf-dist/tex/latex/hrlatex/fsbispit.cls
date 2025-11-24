\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fsbispit}[2010/04/09 Marcelix za FSB]
\LoadClassWithOptions{article}

\RequirePackage[%
a4paper,%
left=2.2cm,%
top=2.15cm,%
right=1.6cm,
bottom=2cm%
%,showframe
]{geometry}




\RequirePackage{fsbmath} % fsbmath poziva hrlatex.sty
% 
% \ProcessOptions

\RequirePackage{txfonts}

\ProcessOptions*







\newcommand{\novirok}{
    \newpage
    \setcounter{zad}{0}
    \malititle
}





\pagestyle{plain}



\newcommand{\malititle}{
    \maketitle
    \section*{}
    \addcontentsline{toc}{subsubsection}{\@date}
}


\renewcommand{\maketitle}{%
   %\addcontentsline{toc}{subsection}{\@date}
    \thispagestyle{empty}
    \let\footnote\thanks

    \vskip 1.5em
    \noindent
    {\Large \textsf{\textbf{\@grupa}}}
     \\[-5ex]
    \parbox[t][][c]{\textwidth}{
        \Large\centering
        \textbf{
            \textsf{
                \MakeUppercase\@title}
            }
        } %parbox

    \begin{center}
        \textsf{(\@date)}
    \end{center}

    \vskip 1em
}                 %maketitle


\newcommand{\printtitle}{\@title}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555




\let\@grupa\empty
\newcommand{\grupa}[1]{\def\@grupa{#1}}



%%%%%
%
% obicni title

\newcommand{\makeheadertitle}{%
     \let\footnote\thanks

    \vskip 1.5em
    \noindent
    {\Large \textsf{\textbf{\@grupa}}}
     \\[-5ex]
    \parbox[t][][c]{\textwidth}{
        \Large\centering
        \textbf{
            \textsf{
                \MakeUppercase\@title}
            }
        } %parbox

    \begin{center}
        \textsf{(\@date)}
    \end{center}

    \vskip 1em
}                 %maketitle

\definecolor{shadecolor}{rgb}{0.8,0.85,0.95}



%%%============================
% trik za optional argument...
% Treba napraviti par \tcmd i \@tcmd komandi. \@dblarg pomaze da ako [#1] nije pozvan nego samo jedan argument, default
%          #1 <-  #2
%

\def\tcmd{\@dblarg{\@tcmd}}

\long\def\@tcmd[#1]#2{%
#1, #2
}
%
%===========================