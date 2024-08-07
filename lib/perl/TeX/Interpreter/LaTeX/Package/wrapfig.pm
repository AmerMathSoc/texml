package TeX::Interpreter::LaTeX::Package::wrapfig;

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
use warnings;

sub install ( $ ) {
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

\ProvidesPackage{wrapfig}

\newcommand{\wrapfigure}[2][]{%
    \@wrapfigure
}

\newcommand{\@wrapfigure}[2][]{%
    \figure[H]%
}

\let\endwrapfigure\endfigure

\endinput

__END__

\ProvidesPackage{wrapfig}

% Ignore optional args for now: \begin{wrapfigure}[12]{r}[34pt]{5cm}

% \newenvironment{wrapfigure}[2]{%
%     \begin{figure}[h]
% }{%
%     \end{figure}
% }

\def\wrapfigure#1#2{%
    \texml@process@env{wrapfigure}{%
        \toks@\expandafter{\texml@body}%
        \edef\next@{
            \afterpar{%
                \noexpand\begin{figure}[h]
                    \the\toks@
                \noexpand\end{figure}
                \afterpar{}%
            }%
        }%
        \next@
    }%
}

\endinput

__END__
