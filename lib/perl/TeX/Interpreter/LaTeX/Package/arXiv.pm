package TeX::Interpreter::LaTeX::Package::arXiv;

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

## This is redundant with amsrefs now.

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::arXiv::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{arXiv}

% \newcommand{\arXiv}[1]{\href{https://arxiv.org/abs/#1}{\texttt{arXiv:#1}}}

\def\wikiurl#1{\url{https://en.wikipedia.org/wiki/#1}}
%    \begin{macro}{\parse@arXiv}
%    \begin{macrocode}
\def\parse@arXiv#1 [#2]#3\@nnil{%
    \def\arXiv@number{#1}%
    \def\arXiv@category{#2}%
    \def\arXiv@url{https://arxiv.org/abs/#1}%
}
%    \end{macrocode}
%    \end{macro}
%
%    \begin{macro}{\arXiv}
%    \begin{macrocode}
\def\arXiv#1{%
    \begingroup
        \parse@arXiv#1 []\@nil\@nnil
        \href{\arXiv@url}{%
            \texttt{arXiv:\arXiv@number}%
        }%
        \ifx\arXiv@category\@empty\else
            \space[\arXiv@category]%
        \fi
    \endgroup
}
%    \end{macrocode}
%    \end{macro}

\endinput

__END__
