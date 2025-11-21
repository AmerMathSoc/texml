package TeX::Interpreter::LaTeX::Package::physics;

use v5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

\ProvidesPackage{physics}

% \LoadRawMacros

% Just enough for mcom3897

\def\ket#1{\left|#1\right\rangle}

\def\bra#1{\left\langle#1\right|}

\DeclareMathOperator{\trace}{tr} % Trace of a matrix
\let\tr\trace
\DeclareMathOperator{\Trace}{Tr} % Trace of a matrix (alternate)
\let\Tr\Trace
\DeclareMathOperator{\rank}{rank} % Rank of a matrix
\DeclareMathOperator{\erf}{erf} % Gauss error function
\DeclareMathOperator{\Residue}{Res} % Residue

\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}

\let\Re\relax
\DeclareMathOperator{\Re}{Re}
\let\Im\relax
\DeclareMathOperator{\Im}{Im}

%% I think this is a reasonable emulation of \dd.

\newcommand{\dd}{%
    \begingroup
        \let\@texml@dd@n\@empty
        \@ifnextchar[\texml@dd{\texml@dd[]}%
}

\def\texml@dd[#1]{%
        \def\@texml@dd@n{#1}%
        \futurelet\@let@token\texml@dd@
}

\def\texml@dd@{%
        \ifx\@let@token\bgroup
            \let\next@\texml@dd@G
        \else\ifx\@let@token(%
            \let\next@\texml@dd@P
        \else
            \let\next@\texml@dd@B
        \fi\fi
        \next@
}

\def\texml@dd@B{%
        \mathrm{d}%
        \ifx\@texml@dd@n\@empty\else
            ^{\@texml@dd@n}%
        \fi
    \endgroup
}

\def\texml@dd@G#1{%
        \mathinner{
            \mathrm{d}%
            \ifx\@texml@dd@n\@empty\else
                ^{\@texml@dd@n}%
            \fi
            #1
        }
    \endgroup
}

\def\texml@dd@P(#1){%
        \mathinner{
            \mathrm{d}%
            \ifx\@texml@dd@n\@empty\else
                ^{\@texml@dd@n}%
            \fi
            \left(#1\right)
        }
    \endgroup
}

\endinput

__END__
