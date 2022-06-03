package TeX::Interpreter::LaTeX::Package::dbnsymb;

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

    $tex->package_load_notification(__PACKAGE__);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::dbnsymb::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{dbnsymb}

\DeclareMathPassThrough{doublepoint}
\DeclareMathPassThrough{overcrossing}
\DeclareMathPassThrough{undercrossing}
\DeclareMathPassThrough{fourwheel}
% \DeclareMathPassThrough{pentagon}
\DeclareMathPassThrough{isolatedchord}
\DeclareMathPassThrough{righttrefoil}
\DeclareMathPassThrough{OpenHopfUp}
\DeclareMathPassThrough{dbnframe}
\DeclareMathPassThrough{HopfLink}
\DeclareMathPassThrough{botright}
\DeclareMathPassThrough{twowheel}
\DeclareMathPassThrough{tetrahedron}
\DeclareMathPassThrough{stonehenge}
\DeclareMathPassThrough{lefttrefoil}
\DeclareMathPassThrough{slashoverback}
\DeclareMathPassThrough{backoverslash}
\DeclareMathPassThrough{hsmoothing}
\DeclareMathPassThrough{SGraph}
\DeclareMathPassThrough{TGraph}
\DeclareMathPassThrough{UGraph}
\DeclareMathPassThrough{righttwist}
\DeclareMathPassThrough{lefttwist}
\DeclareMathPassThrough{MobiusSymbol}
\DeclareMathPassThrough{Associator}
% \DeclareMathPassThrough{hexagon}
\DeclareMathPassThrough{inup}
\DeclareMathPassThrough{isotopic}
\DeclareMathPassThrough{dumbbell}
\DeclareMathPassThrough{OpenHopf}
\DeclareMathPassThrough{wiggle}
\DeclareMathPassThrough{ThetaGraph}
\DeclareMathPassThrough{IGraph}
\DeclareMathPassThrough{HGraph}
\DeclareMathPassThrough{XGraph}
\DeclareMathPassThrough{crossing}
\DeclareMathPassThrough{smoothing}
\DeclareMathPassThrough{YGraph}
\DeclareMathPassThrough{TwistedY}
\DeclareMathPassThrough{HSaddleSymbol}
\DeclareMathPassThrough{ISaddleSymbol}
\DeclareMathPassThrough{CanadianFlag}
\DeclareMathPassThrough{fourinwheel}
\DeclareMathPassThrough{BigCirc}
\DeclareMathPassThrough{virtualcrossing}
\DeclareMathPassThrough{semivirtualover}
\DeclareMathPassThrough{semivirtualunder}
\DeclareMathPassThrough{rightarrowdiagram}
\DeclareMathPassThrough{leftarrowdiagram}
\DeclareMathPassThrough{actsonleft}
\DeclareMathPassThrough{actsonright}
\DeclareMathPassThrough{cappededge}
\DeclareMathPassThrough{svslashoverback}
\DeclareMathPassThrough{svbackoverslash}
\DeclareMathPassThrough{upcap}
\DeclareMathPassThrough{doubletree}
\DeclareMathPassThrough{horizontalchord}
\DeclareMathPassThrough{downcap}
\DeclareMathPassThrough{uppertriang}
\DeclareMathPassThrough{lowertriang}
\DeclareMathPassThrough{OU}
\DeclareMathPassThrough{upupsmoothing}
\DeclareMathPassThrough{FlippedYGraph}

\endinput

__END__
