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

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{booktabs}

\LoadRawMacros

\def\tablestrut{}

%% This takes care of \toprule, \midrule, and \bottomrule and maybe
%% (at least partially) \specialrule (needs to be tested).

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

%% TODO: \cmidrule

% #3 = rule width
% $4 = trim (ignored)

\def\@@@cmidrule[#1-#2]#3#4{%
        \@thisrulewidth=#3
        \edef\current@border@width{\the\@thisrulewidth}%
        \count@#1
        \@tempcnta#2
        % I'm not sure this behaviour of an initial starting column of
        % zero is an intentional feature, but let's preserve it.
        \ifnum\count@=\z@
            \advance\count@\@ne
            \advance\@tempcnta\@ne
        \fi
        \advance\@tempcnta\@ne
        \@whilenum\count@<\@tempcnta\do{%
            \setColumnCSSproperty{\the\count@}{border-top}{\current@border@properties}%
            \advance\count@\@ne
        }%
    \ifnum0=`{\fi}%
}

\endinput

__END__
