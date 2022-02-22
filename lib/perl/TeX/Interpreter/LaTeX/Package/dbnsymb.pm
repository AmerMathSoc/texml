package TeX::Interpreter::LaTeX::Package::dbnsymb;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

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
