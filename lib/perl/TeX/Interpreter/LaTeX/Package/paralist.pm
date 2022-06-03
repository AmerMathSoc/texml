package TeX::Interpreter::LaTeX::Package::paralist;

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

    $tex->package_load_notification(__PACKAGE__);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::paralist::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{paralist}

\LoadRawMacros

\let\enumlabel\@mklab
\let\itemlabel\@mklab

\def\@asparaenum@{%
    \expandafter\list\csname label\@enumctr\endcsname{%
        \def\@listconfig{%
            \xmlpartag{p}%
            \let\@listpartag\@empty
        }%
        \let\@listelementname\@empty
        \let\@listitemname\@empty
        \usecounter{\@enumctr}%
        \let\@item\paralist@item
    }%
}

\def\@asparaitem@{%
    \expandafter\list\csname\@itemitem\endcsname{%
        \def\@listconfig{%
            \xmlpartag{p}%
            \let\@listpartag\@empty
        }%
        \let\@listelementname\@empty
        \let\@listitemname\@empty
        \let\@item\paralist@item
    }%
}

\def\paralist@item[#1]{%
    \@@par
    \if@noitemarg
        \@noitemargfalse
        \if@nmbrlist
            \refstepcounter\@listctr
        \fi
    \fi
    \everypar{\addXMLid#1\space\everypar{}}%
    \ignorespaces
}

\endinput

__END__
