package TeX::Interpreter::LaTeX::Package::makecell;

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

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("makecell", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::makecell::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{makecell}

\RequirePackage{array}

\newcommand\Xhline[1]{%
    \noalign{\ifnum0=`}\fi
    \arrayrulewidth#1%
    \futurelet\reserved@a \texml@xhline
}

\def\texml@xhline{%
        \count@\alignrowno
        \def\@selector{table####\@currentTBLRid\space tr:nth-child(\the\count@)}%
        \def\current@border@width{\the\arrayrulewidth}%
        \ifnum\alignrowno=\z@
            \advance\count@\@ne
            \addCSSclass{\@selector}{border-top: \current@border@properties;}%
        \else
            \addCSSclass{\@selector}{border-bottom: \current@border@properties;}%
        \fi
    \ifnum0=`{\fi}%
}

\TeXMLendPackage

\endinput

__END__
