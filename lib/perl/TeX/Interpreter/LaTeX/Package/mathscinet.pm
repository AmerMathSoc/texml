package TeX::Interpreter::LaTeX::Package::mathscinet;

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

use TeX::Utils::Unicode::Diacritics qw(:names);

use TeX::Utils::Unicode qw(make_accenter);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->define_pseudo_macro(utilde => make_accenter(COMBINING_TILDE_BELOW));
    $tex->define_pseudo_macro(uarc   => make_accenter(COMBINING_BREVE_BELOW));
    $tex->define_pseudo_macro(lfhook => make_accenter(COMBINING_COMMA_BELOW));
    $tex->define_pseudo_macro(dudot  => make_accenter(COMBINING_DIAERESIS_BELOW));

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

\ProvidesPackage{mathscinet}

\RequirePackage{textcmds}

\UCSchardef\lasp"02BF
\UCSchardef\rasp"02BE

\UCSchardef\cprime "2032 % AMS transliteration (really U+042C)
\UCSchardef\cdprime"2033 % AMS transliteration (really U+042A)

\UCSchardef\Dbar"0110
\UCSchardef\dbar"0111
\UCSchardef\bud "042A

\def\bold#1{\mathbf{#1}}
\def\scr#1{\mathcal{#1}}
\def\germ#1{\mathfrak{#1}}
\def\Bbb#1{\mathbb{#1}}
\def\ssf#1{\mathsf{#1}}
\def\cyr#1{#1}

\def\cflex{\^}
\def\ocirc{\r}
\def\polhk{\k}
\def\udot{\d}

% \def\.{\dot} %% Not really mathscinet

\def\cftil{\cirti}

\def\cydot{$\cdot$}

\endinput

__END__
