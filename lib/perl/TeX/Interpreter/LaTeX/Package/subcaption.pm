package TeX::Interpreter::LaTeX::Package::subcaption;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{subcaption}

\RequirePackage{caption}[2012/03/25] % needs v3.3 or newer

\def\jats@figure@element{fig-group}

\newcounter{subfigure}
\def\thesubfigure{\alph{subfigure}}

\newenvironment{subfigure}[2][]{%
    \par
    \leavevmode
    \ifx\label\subcaption@label \else
        \let\subcaption@ORI@label\label
        \let\label\subcaption@label
    \fi
    \def\caption@{\@dblarg{\@caption{subfigure}}}
    \def\subcaption{\caption}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{fig}%
    \addXMLid
}{%
    \endXMLelement{fig}%
    \par
}

\let\subfigurename\@empty

\newcommand*\subcaption@label{\caption@withoptargs\subcaption@@label}

\newcounter{subtable}
\def\thesubtable{\alph{subtable}}

\newenvironment{subtable}[2][]{%
    \par
    \leavevmode
    \ifx\label\subcaption@label \else
        \let\subcaption@ORI@label\label
        \let\label\subcaption@label
    \fi
    \def\caption@{\@dblarg{\@caption{subtable}}}
    \def\subcaption{\caption}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{fig}%
    \addXMLid
}{%
    \endXMLelement{fig}%
    \par
}

\let\subtablename\@empty

\newcommand*\subcaption@@label[2]{%
    \@bsphack
    \begingroup
        \protected@edef\@currentlabel{\csname thesub\@captype\endcsname}%
        \subcaption@ORI@label#1{sub@#2}%
        %%
        %% TBD: For tables, we expect the main caption at the
        %% beginning, before any subcaptions; for figure, we expect
        %% the main caption at the end, *after* any subcaptions.  So,
        %% we need to pre-increment the figure counter in order to set
        %% the subcaption labels.
        %%
        \def\@tempa{figure}%
        \ifx\@captype\@tempa
            \expandafter\advance \csname c@\@captype\endcsname \@ne
        \fi
        \protected@edef\@currentlabel{\csname the\@captype\endcsname\@currentlabel}%
        \subcaption@ORI@label#1{#2}%
      \endgroup
    \@esphack
}

\DeclareRobustCommand*\subref{%
  \@ifstar
    {\caption@withoptargs\subcaption@ref*}%
    {\caption@withoptargs\@subref}}

\newcommand*\@subref[2]{%
    \subcaption@ref{#1}{#2}%
}

\newcommand*\subcaption@ref[2]{%
    \begingroup
        %\caption@setoptions{sub}%
        \subcaption@reffmt\p@subref{\ref#1{sub@#2}}%
      \endgroup
}

\newcommand*\p@subref{}

\def\bothIfFirst#1#2{%
    \protected@edef\caption@tempa{#1}%
    \ifx \caption@tempa \@empty \else #1#2\fi
}

\def\subcaption@reffmt#1#2{\bothIfFirst {#1}{\nobreakspace }#2}

% \subcaptionbox[<list entry>]{<heading>}[<width>][<inner-pos>]{<contents>}
% \subcaptionbox*             {<heading>}[<width>][<inner-pos>]{<contents>}
%
% \subcaption[<list entry>]{<heading>}
% \subcaption*             {<heading>}

\def\subcaptionbox{%
    \@ifstar{\st@rredtrue\subcaptionbox@}{\st@rredfalse\subcaptionbox@}%
}

\newcommand{\subcaptionbox@}[2][]{%
    \@ifnextchar[{\subcaptionbox@@{#2}}{\subcaptionbox@@{#2}[]}%
}

\def\subcaptionbox@@#1[#2]{%
    \@ifnextchar[{\subcaptionbox@@@{#1}}{\subcaptionbox@@@{#1}[]}%
}

\def\subcaptionbox@@@#1[#2]#3{%
    \begin{subfigure}{}\caption{#1}#3\end{subfigure}%
}

\endinput

__END__
