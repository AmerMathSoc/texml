package TeX::Interpreter::LaTeX::Package::eurom;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::eurom::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\def\EuRom#1{\TeXMLSVGmathchoice{\EuRom{#1}}}
\let\matheurm\EuRom

\def\matheurb#1{\TeXMLSVGmathchoice{\boldsymbol{\EuRom{#1}}}}

\endinput

__END__
