package TeX::Interpreter::LaTeX::Package::xy;

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

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{xy}

\RequirePackage{tikz}

\DeclareSVGEnvironment{xy}

\def\txt#1{%
    \ifmmode
        \begingroup
            \def\\{\string\\}%
            \string\txt{#1}%
        \endgroup
    \else
        % This is allowed in LaTeX, but I don't want to deal with it
        % unless forced to
        \@mathonly\txt
    \fi
}

\let\UseAllTwocells\@empty
\let\UseTwocells\@empty

\let\xyoption\@gobble

\def\SelectTips#1#2{}
\def\CompileMatrices{}

\let\newdir\@gobbletwo

\let\xymatrixcolsep\@gobble
\let\xymatrixrowsep\@gobble

\def\xymatrix#1#{%
    \xymatrix@body{#1}%
}

\let\xymatrixcolsep@\@empty
\def\xymatrixcolsep{\def\xymatrixcolsep@}

\def\xymatrix@body#1#2{%
    \begingroup
        \toks@{#2}%
        \edef\next@{
            \noexpand\TeXMLCreateSVG{$%
                \ifx\xymatrixcolsep@\@empty\else
                    \noexpand\xymatrixcolsep{\xymatrixcolsep@}
                \fi
                \noexpand\xymatrix#1{\the\toks@}%
            $}%
        }%
        \expandafter\next@
    \endgroup
}

\endinput

__END__
