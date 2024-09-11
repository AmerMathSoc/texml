package TeX::Interpreter::LaTeX::Package::amscyr;

# Copyright (C) 2022, 2024 American Mathematical Society
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

use TeX::Token qw(:catcodes :factories);
use TeX::TokenList qw(:factories);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{amscyr}

\def\mathcyr#1{\begingroup\fontencoding{OT2}#1\endgroup}

% \@declarefontcommand[OT2]\textcyr\mathcyr{cyrillic}

\DeclareRobustCommand\textcyr[1]{%
    \begingroup
        \fontencoding{OT2}%
        \ifmmode
            \string\mathcyr{#1}%
        \else
            \leavevmode
            #1%
        \fi
    \endgroup
}

\protected@edef\mitBe{\protect\mathit{\Uchar"0411 }}
\protected@edef\cyrCh{\protect\mathrm{\Uchar"0427 }}
\protected@edef\Sha{\protect\mathrm{\Uchar"0428 }}
\protected@edef\Shcha{\protect\mathrm{\Uchar"0429 }}
\protected@edef\De{\protect\mathrm{\Uchar"0434 }}

\protected@edef\cprime{\Uchar"044C }
\protected@edef\Cprime{\Uchar"042C }
\protected@edef\cdprime{\Uchar"044A }
\protected@edef\Cdprime{\Uchar"042A }

\newcommand{\dbar}{dj}
\newcommand{\Dbar}{Dj}

\protected@edef\dz{\Uchar"0455 }
\protected@edef\Dz{\Uchar"0405 }
\protected@edef\dzh{\Uchar"045F }
\protected@edef\Dzh{\Uchar"040F }

\endinput

__END__
