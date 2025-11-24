%%
%% This is file `screenplay.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% screenplay.dtx  (with options: `class')
%% +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
%% 
%% Authored by and Copyright (C)2006 by
%% John Pate <johnny@dvc.org.uk>
%% http://dvc.org.uk
%% Latest version is available as:
%% http://dvc.org.uk/sacrific.txt/screenplay.zip
%% 
%% This program is free software; you can redistribute it and/or
%% modify it under the terms of the GNU General Public License as
%% published by the Free Software Foundation; either version 2 of
%% the License, or (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public
%% License along with this program; if not, write to the Free
%% Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
%% MA 02110-1301 USA
%% 
%% GPL v2 text also available as:
%% http://dvc.org.uk/gplv2.txt
%% 
%% +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
%% \CheckSum{356}
\NeedsTeXFormat{LaTeX2e}[2003/12/01]
\ProvidesClass{screenplay}[2012/06/30 v1.6
LaTeX2e Draft Screenplay document class
(C)2006 John Pate
released under the GNU General Public License]
\DeclareOption*{%
    \PackageError{screenplay}{Unwanted option '\CurrentOption'}%
    {There are no options available for class screenplay v1.538}}
\ProcessOptions\relax
\RequirePackage{ifthen}[2001/05/26]
\LoadClass[12pt,letterpaper,onecolumn,oneside]{article}[2004/02/16]
\RequirePackage[dvips,letterpaper]{geometry}[2002/07/08]
\setlength{\paperheight}{11in}
\setlength{\paperwidth}{8.5in}
\RequirePackage{courier}[2004/09/15]
\renewcommand*{\familydefault}{\ttdefault}
\raggedright
\pagenumbering{arabic}
\pagestyle{myheadings}
\setlength{\baselineskip}{12pt plus 0pt minus 0pt}
\renewcommand*{\baselinestretch}{0.8}
\newcommand*{\dialfix}{\vspace{2pt}}
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0in}
\newcommand*{\slugspace}{\hspace{2.0em plus 0em minus 0em}}
\setlength{\evensidemargin}{0.5in}
\setlength{\oddsidemargin}{0.5in}
\setlength{\topmargin}{-0.5in}
\setlength{\headsep}{0.4in}
\setlength{\topskip}{0in}
\setlength{\textheight}{9.5in}
\setlength{\textwidth}{6.0in}
\newlength{\widthgutter}
\setlength{\widthgutter}{0.1in}
\addtolength{\textwidth}{\widthgutter}
\newlength{\dialwidth}
\setlength{\dialwidth}{3.0in}
\newlength{\dialgutter}
\setlength{\dialgutter}{0.2in}
\addtolength{\dialwidth}{\dialgutter}
\newcommand*{\dialtab}{\hspace*{1.5in}}
\newcommand*{\dialnametab}{\hspace*{1.2in}}
\newlength{\parenwidth}
\setlength{\parenwidth}{1.5in}
\addtolength{\parenwidth}{\dialgutter}
\newcommand*{\parentab}{\hspace{0.7in}}
\renewcommand*{\textfraction}{1}
\renewcommand*{\topfraction}{0}
\renewcommand*{\bottomfraction}{0}
\title{My First Screenplay}
\newlength{\titheadskip}
\setlength{\titheadskip}{2.25in}
\newcommand{\nicholl}{
\thispagestyle{empty}
\vspace*{\titheadskip}
\begin{center}\MakeUppercase{\@title}\end{center}
\newpage\setcounter{page}{1}
}
\author{Alan Smithee}
\newcommand{\@realauthor}{\@author}
\newcommand{\realauthor}[1]{\renewcommand{\@realauthor}{#1}}
\newcommand{\@address}{Contact via Agency}
\newcommand{\address}[1]{\renewcommand{\@address}{#1}}
\newcommand{\@agent}{~}
\newcommand{\agent}[1]{\renewcommand{\@agent}{#1}}
\newlength{\titskip}
\setlength{\titskip}{3.75in plus 0in minus 1.5in}
\newlength{\addrwidth}
\setlength{\addrwidth}{2.0in}
\newlength{\addrseplen}
\setlength{\addrseplen}{2.0in plus 0in minus 0.5in}
\newcommand*{\bytext}{by}
\newcommand*{\byskip}{\baselineskip}
\newcommand{\coverpage}{
\thispagestyle{empty}
\vspace*{\titheadskip}
\begin{center}{\MakeUppercase{\@title}}\\
\vspace{\byskip}
\bytext\\
\vspace{\byskip}
\@author
\end{center}
\vspace{\titskip}
\parbox[t]{\addrwidth}{\@agent}\hspace{\addrseplen}
\parbox[t]{\addrwidth}{\@realauthor\\\@address}
\newpage\setcounter{page}{1}
}
\newcommand*{\more}{(MORE)}
\newcommand*{\contd}{(CONT'D)}
\newcommand{\paren}[1]{%

\parentab\parbox[t]{\parenwidth}{\raggedright(#1)\dialfix}\\
}
\newenvironment{dialogue}[2][]{%

\dialtab\dialnametab\hbox{\MakeUppercase{#2}}\\*
\dialtab\begin{minipage}[b]{\dialwidth}
\dialfix
\raggedright
\ifthenelse{\not\equal{#1}{}}
{
\paren{#1}
}{}
}{%
\end{minipage}

}
\newcommand{\dialbreak}[2][]{%
\nopagebreak
\dialnametab\hbox{\more}%
\end{dialogue}
\newpage
\ifthenelse{\not\equal{#1}{}}
{
\begin{dialogue}[#1]{\MakeUppercase{#2} \contd}
}{
\begin{dialogue}{\MakeUppercase{#2} \contd}
}
}
\newcommand*{\placesep}{.~}
\newcommand{\slug}[3][]{%

\MakeUppercase{#2\placesep#3}%
\ifthenelse{\not\equal{#1}{}}
                {%
\slugspace\MakeUppercase{#1}\hspace{\fill}
                }{}
\nopagebreak

}
\newcommand*{\inttext}{INT}
\newcommand{\intslug}[2][]{\slug[#1]{\inttext}{#2}}
\newcommand*{\exttext}{EXT}
\newcommand{\extslug}[2][]{\slug[#1]{\exttext}{#2}}
\newcommand*{\sepintext}{./}
\newcommand{\intextslug}[2][]{%
\slug[#1]{\inttext\sepintext\exttext}{#2}}
\newcommand{\extintslug}[2][]{%
\slug[#1]{\exttext\sepintext\inttext}{#2}}
\newcommand*{%
\sccentre}[1]{\hspace*{\fill}{#1}\hspace{\fill}\hspace{\widthgutter}}
\newcommand*{%
\scflushright}[1]{\hspace*{\fill}{#1}\hspace{\widthgutter}}
\newcommand*{\punctchar}{:}
\newcommand*{\titleovertext}{TITLE~OVER}
\newenvironment{titleover}[1][]{%

\ifthenelse{\not\equal{#1}{}}
{%
\titleovertext #1\punctchar
}{%
\titleovertext\punctchar
}%
\\*[\baselineskip]
\dialtab\begin{minipage}[b]{\dialwidth}
\raggedright
}{%
\end{minipage}

}
\newcommand{\titbreak}{%
\nopagebreak
\dialnametab\hbox{\more}%
\end{titleover}
\newpage
\begin{titleover}[\contd]%
}
\newcommand{\centretitle}[1]{%

\titleovertext\punctchar\\*[\baselineskip]%
\sccentre{#1}

}
\newcommand*{\fadeintext}{FADE~IN}
\newcommand{\fadein}{%

\fadeintext\punctchar

}
\newcommand*{\fadeouttext}{FADE~OUT}
\newcommand{\fadeout}{%

\scflushright{\fadeouttext\punctchar}

}
\newcommand*{\intercuttext}{INTERCUT~WITH}
\newcommand{\intercut}{%

\scflushright{\intercuttext\punctchar}

}
\newcommand*{\pov}{P.O.V.}
\newcommand*{\revert}{REVERSE~\pov}
\newcommand*{\thirty}{THE~END}
\newcommand{\theend}{%

\sccentre{\thirty}

}%THE END
%% 
%% Hail Eris!  All Hail Discordia!
%%
%% End of file `screenplay.cls'.
