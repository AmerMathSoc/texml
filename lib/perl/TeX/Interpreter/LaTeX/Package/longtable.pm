package TeX::Interpreter::LaTeX::Package::longtable;

use 5.26.0;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
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

use warnings;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{longtable}

\DeclareOption{errorshow}{}

\DeclareOption{pausing}{}

\DeclareOption{set}{}

\DeclareOption{final}{}

\ProcessOptions

\newbox\LT@head
\newbox\LT@firsthead
\newbox\LT@foot
\newbox\LT@lastfoot

\let\LTcapwidth\@tempdima

\def\longtable{%
    \par
    \figure[H]%
    \xmltabletag{}%
    \xmlpartag{}%
    \let\@footnotetext\tab@footnotetext
    \reset@border@style
    \leavevmode
    \begingroup
        \@ifnextchar[\LT@array{\LT@array[x]}%
}

\def\LT@array[#1]#2{%
    \refstepcounter{table}%
    \let\kill\LT@kill
    \let\caption\LT@caption
    \html@tabskip\z@
    \html@next@tabskip\z@
    \begingroup
        \tab@makepreamble{#2}%
        \xdef\LT@bchunk{%
            \setbox\z@\vbox\bgroup
                \noexpand\ialign\bgroup
                    \@preamble \cr
        }%
    \endgroup
    \let\hline\HTMLtable@hline
    \let\\\@tabularcr
    \let\tabularnewline\\%
    \let\color\set@cell@fg@color
    \let\par\@empty % ??? is this a good idea?
    \let\@sharp##%
    \set@typeset@protect
    \@arrayleft
    \LT@bchunk
}

\def\LT@echunk{%
        \crcr
    \egroup
    \unskip
  \egroup
}

\def\endlongtable{%
        \crcr
        \LT@echunk
        \LT@caption@box
        \startXMLelement{table}%
            \addTBLRid
            \setCSSproperty{border-collapse}{collapse}%
            \unvbox\ifvoid\LT@firsthead\LT@head\else\LT@firsthead\fi
            \unvbox\z@
            \unvbox\ifvoid\LT@lastfoot\LT@foot\else\LT@lastfoot\fi
            \par
        \endXMLelement{table}%
    \endgroup
    \endfigure
}

\def\LT@kill{%
    \crcr
    \noalign{\global\setbox\z@\lastbox}%
}

\def\LT@end@hd@ft#1{%
    \LT@echunk
    % \ifx\LT@start\endgraf
    %     \LT@err
    %         {Longtable head or foot not at start of table}%
    %         {Increase LTchunksize}%
    % \fi
    \setbox#1\box\z@
    \LT@bchunk
}

\def\endfirsthead{\LT@end@hd@ft\LT@firsthead}

\def\endhead{\LT@end@hd@ft\LT@head}

\def\endfoot{\LT@end@hd@ft\LT@foot}

\def\endlastfoot{\LT@end@hd@ft\LT@lastfoot}

\let\LT@caption@box\@empty

\def\LT@caption{%
    \noalign\bgroup
        \@ifnextchar[{\egroup\LT@c@ption\@firstofone}\LT@capti@n}

\def\LT@capti@n{%
  \@ifstar
    {\egroup\LT@c@ption\@gobble[]}%
    {\egroup\@xdblarg{\LT@c@ption\@firstofone}}}

\def\LT@c@ption#1[#2]#3{%
    \LT@makecaption#1\fnum@table{#3}%
}

\providecommand\LT@texml@caption@sep{\XMLgeneratedText:}

\def\LT@makecaption#1#2#3{%
    \protected@xdef\LT@caption@box{%
        \ifx#1\@gobble\else
            \par\startXMLelement{label}%
                #2\LT@texml@caption@sep\par
            \endXMLelement{label}\par
        \fi
        \if###3##\else
            \par\startXMLelement{caption}%
                %% TBD: \xmlpartag{p} doesn't work.  Why???
                \startXMLelement{p}%
                    #3\@@par
                \endXMLelement{p}%
            \endXMLelement{caption}\par
        \fi
    }%
}

\endinput

__END__
