package TeX::Interpreter::LaTeX::Package::subfigure;

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

    my @options = $tex->get_module_options('subfigure', 'sty');

    my @new_options = grep { ! m{^normal$} } @options;

    $tex->set_module_options('subfigure', 'sty', @new_options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::subfigure::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{subfigure}

\LoadRawMacros

% All figures will be enclosed by <fig-group> elements, which will be
% demoted back to <fig> by XML::Output::normalize_figures() if
% necessary.

\def\jats@figure@element{fig-group}

\def\thesubfigure{\alph{subfigure}}
\def\thesubtable{\alph{subtable}}

\def\subfigure{%
  \bgroup
    \let\subfig@oldlabel=\label
    \let\label=\subfloat@label
    \refstepcounter{sub\@captype}%
    \@ifnextchar [%
      {\@subfigure}%
      {\@subfigure[\@empty]}%
}

\let\subtable=\subfigure

% #1: type: 'subfigure' or 'subtable' (ignore)
% #2: list_entry                      (ignore)
% #3: subcaption
% #4: figure (for now, assume it's just an \includegraphics)

\long\def\@subfloat#1[#2][#3]#4{%
    \leavevmode
    \startXMLelement{fig}%
    \addXMLid
    \ifx\@empty#3\relax\else
        \@subcaption{#1}{#2}{#3}%
    \fi
    #4%
    \endXMLelement{fig}%
  \egroup
}

\renewcommand*{\@thesubfigure}{\thesubfigure}
\renewcommand*{\@thesubtable}{\thesubtable}

\renewcommand{\@makesubfigurecaption}[2]{%
    \begingroup
        \protected@edef\@tempa{\zap@space#1 \@empty}% Is this \edef safe?
        \ifx\@tempa\@empty\else
            \startXMLelement{label}%
            #1%
            \endXMLelement{label}%
        \fi
    \endgroup
    \st@rredtrue
    \@caption{}[]{#2}%
}

\let\@makesubtablecaption=\@makesubfigurecaption

\let\@caption\subfig@oldcaption

\endinput

__END__
