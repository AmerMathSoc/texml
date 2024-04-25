package TeX::Interpreter::LaTeX::Package::bbold;

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

\ProvidesPackage{bbold}

\DeclareTeXMLMathAlphabet\mathbb

\DeclareSymbolFont{MVbbold}{U}{bbold}{m}{n}%

\def\X#1#2{%
    \@namedef{Bbb#1}{%
        \mathord{%
            \TeXMLCreateSVG{%
                {\usefont{U}{bbold}{m}{n}\char#2}%
            }%
        }%
    }%
}

\X{Gamma}{"00}
\X{Delta}{"01}
\X{Theta}{"02}
\X{Lambda}{"03}
\X{Xi}{"04}
\X{Pi}{"05}
\X{Sigma}{"06}
\X{Upsilon}{"07}
\X{Phi}{"08}
\X{Psi}{"09}
\X{Omega}{"0A}

\X{alpha}{"0B}
\X{beta}{"0C}
\X{gamma}{"0D}
\X{delta}{"0E}
\X{epsilon}{"0F}
\X{zeta}{"10}
\X{eta}{"11}
\X{theta}{"12}
\X{iota}{"13}
\X{kappa}{"14}
\X{lambda}{"15}
\X{mu}{"16}
\X{nu}{"17}
\X{xi}{"18}
\X{pi}{"19}
\X{rho}{"1A}
\X{sigma}{"1B}
\X{tau}{"1C}
\X{upsilon}{"1D}
\X{phi}{"1E}
\X{chi}{"1F}

\X{psi}{"20}

\X{omega}{"7F}

\endinput

__END__
