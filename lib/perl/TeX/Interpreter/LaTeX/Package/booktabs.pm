package TeX::Interpreter::LaTeX::Package::booktabs;

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

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("booktabs", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::booktabs::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{booktabs}

%% This takes care of \toprule, \midrule, and \bottomrule and maybe
%% (at least partially) \specialrule (needs to be tested).
%% TODO: \cmidrule

\def\@BTrule[#1]{%
    \ifx\longtable\undefined
        \let\@BTswitch\@BTnormal
    \else\ifx\hline\LT@hline
        \let\@BTswitch\@BLTrule
    \else
        \let\@BTswitch\@BTnormal
    \fi\fi
    \global\@thisrulewidth=#1\relax
    % \ifnum\@thisruleclass=\tw@
    %     \vskip\@aboverulesep
    % \else
    %     \ifnum\@lastruleclass=\z@
    %         \vskip\@aboverulesep
    %     \else
    %         \ifnum\@lastruleclass=\@ne\vskip\doublerulesep\fi
    %     \fi
    % \fi
    \edef\current@border@width{\the\@thisrulewidth}%
    \setRowCSSproperty{border-top}{\current@border@properties}%
    \@BTswitch
}

%% Remove code that might increase the row number.

\def\@BTnormal{%
    \futurenonspacelet\@tempa\@BTendrule}

\def\@BTendrule{\ifnum0=`{\fi}}

\def\@@BLTrule(#1){%
        \global\@cmidlb\LT@cols
    \ifnum0=`{\fi}%
}

\def\tablestrut{}

\TeXMLendPackage

\endinput

__END__
