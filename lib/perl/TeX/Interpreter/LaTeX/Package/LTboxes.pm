package TeX::Interpreter::LaTeX::Package::LTboxes;

use 5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

sub install  {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{LTboxes}

%% Preserve \llap and \rlap in math mode.

\let\ltx@rlap\rlap

%% Add an extra \hbox around the argument of \rlap and \llap to
%% compensate for the fact that MathJax correctly switches to text
%% mode inside \hbox but not inside \rlap and \llap.

\def\rlap#1{%
    \ifmmode
        \string\rlap\string{\string\hbox\string{\hbox{#1}\string}\string}%
    \else
        \ltx@rlap{#1}%
    \fi
}

\let\ltx@llap\llap

\def\llap#1{%
    \ifmmode
        \string\llap\string{\string\hbox\string{\hbox{#1}\string}\string}%
    \else
        \ltx@llap{#1}%
    \fi
}

\def\centerline#1{\par#1\par}

\DeclareRobustCommand\parbox{%
    \@latex@warning@no@line{This document uses \string\parbox!}%
  \@ifnextchar[%]
    \@iparbox
    {\@iiiparbox c\relax[s]}}%

\long\def\@iiiparbox#1#2[#3]#4#5{%
    \leavevmode
    \@pboxswfalse
    \startXMLelement{span}%
    \setXMLattribute{specific-use}{parbox}%
    \ifmmode
        \text{#5}%
    \else
        #5\@@par
    \fi
    \endXMLelement{span}%
}

\DeclareMathJaxMacro\framebox

\long\def\fbox#1{%
    \leavevmode
    \begingroup
    \everypar{}%
    \startXMLelement{boxed-text}%
        \setXMLattribute{content-type}{fbox}%
        #1%\par 
    \endXMLelement{boxed-text}%
    \endgroup
}

\DeclareMathJaxMacro\fbox

\@namedef{fbox }#1{%
    \ifmmode
        \string\fbox{\hbox{#1}}%
    \else
        \@nameuse{non@mathmode@\string\fbox}{#1}%
    \fi
}

\endinput

__END__
