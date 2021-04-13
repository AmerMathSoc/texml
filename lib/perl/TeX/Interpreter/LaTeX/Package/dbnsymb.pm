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

\DeclareSVGMathChar{\doublepoint}{\mathord}
\DeclareSVGMathChar{\overcrossing}{\mathord}
\DeclareSVGMathChar{\undercrossing}{\mathord}
\DeclareSVGMathChar{\fourwheel}{\mathord}
% \DeclareSVGMathChar{\pentagon}{\mathord}
\DeclareSVGMathChar{\isolatedchord}{\mathord}
\DeclareSVGMathChar{\righttrefoil}{\mathord}
\DeclareSVGMathChar{\OpenHopfUp}{\mathord}
\DeclareSVGMathChar{\dbnframe}{\mathord}
\DeclareSVGMathChar{\HopfLink}{\mathord}
\DeclareSVGMathChar{\botright}{\mathord}
\DeclareSVGMathChar{\twowheel}{\mathord}
\DeclareSVGMathChar{\tetrahedron}{\mathord}
\DeclareSVGMathChar{\stonehenge}{\mathord}
\DeclareSVGMathChar{\lefttrefoil}{\mathord}
\DeclareSVGMathChar{\slashoverback}{\mathord}
\DeclareSVGMathChar{\backoverslash}{\mathord}
\DeclareSVGMathChar{\hsmoothing}{\mathord}
\DeclareSVGMathChar{\SGraph}{\mathord}
\DeclareSVGMathChar{\TGraph}{\mathord}
\DeclareSVGMathChar{\UGraph}{\mathord}
\DeclareSVGMathChar{\righttwist}{\mathord}
\DeclareSVGMathChar{\lefttwist}{\mathord}
\DeclareSVGMathChar{\MobiusSymbol}{\mathord}
\DeclareSVGMathChar{\Associator}{\mathord}
% \DeclareSVGMathChar{\hexagon}{\mathord}
\DeclareSVGMathChar{\inup}{\mathord}
\DeclareSVGMathChar{\isotopic}{\mathord}
\DeclareSVGMathChar{\dumbbell}{\mathord}
\DeclareSVGMathChar{\OpenHopf}{\mathord}
\DeclareSVGMathChar{\wiggle}{\mathord}
\DeclareSVGMathChar{\ThetaGraph}{\mathord}
\DeclareSVGMathChar{\IGraph}{\mathord}
\DeclareSVGMathChar{\HGraph}{\mathord}
\DeclareSVGMathChar{\XGraph}{\mathord}
\DeclareSVGMathChar{\crossing}{\mathord}
\DeclareSVGMathChar{\smoothing}{\mathord}
\DeclareSVGMathChar{\YGraph}{\mathord}
\DeclareSVGMathChar{\TwistedY}{\mathord}
\DeclareSVGMathChar{\HSaddleSymbol}{\mathord}
\DeclareSVGMathChar{\ISaddleSymbol}{\mathord}
\DeclareSVGMathChar{\CanadianFlag}{\mathord}
\DeclareSVGMathChar{\fourinwheel}{\mathord}
\DeclareSVGMathChar{\BigCirc}{\mathord}
\DeclareSVGMathChar{\virtualcrossing}{\mathord}
\DeclareSVGMathChar{\semivirtualover}{\mathord}
\DeclareSVGMathChar{\semivirtualunder}{\mathord}
\DeclareSVGMathChar{\rightarrowdiagram}{\mathord}
\DeclareSVGMathChar{\leftarrowdiagram}{\mathord}
\DeclareSVGMathChar{\actsonleft}{\mathord}
\DeclareSVGMathChar{\actsonright}{\mathord}
\DeclareSVGMathChar{\cappededge}{\mathord}
\DeclareSVGMathChar{\svslashoverback}{\mathord}
\DeclareSVGMathChar{\svbackoverslash}{\mathord}
\DeclareSVGMathChar{\upcap}{\mathord}
\DeclareSVGMathChar{\doubletree}{\mathord}
\DeclareSVGMathChar{\horizontalchord}{\mathord}
\DeclareSVGMathChar{\downcap}{\mathord}
\DeclareSVGMathChar{\uppertriang}{\mathord}
\DeclareSVGMathChar{\lowertriang}{\mathord}
\DeclareSVGMathChar{\OU}{\mathord}
\DeclareSVGMathChar{\upupsmoothing}{\mathord}
\DeclareSVGMathChar{\FlippedYGraph}{\mathord}

\endinput

__END__
