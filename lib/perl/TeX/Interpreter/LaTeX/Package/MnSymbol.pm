package TeX::Interpreter::LaTeX::Package::MnSymbol;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::MnSymbol::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{MnSymbol}

\RequirePackage{unicode-math}

\def\lsem{\lBrack}
\def\rsem{\rBrack}

\def\llangle{\lAngle}
\def\rrangle{\rAngle}

\TeXMLendPackage

\endinput

__END__
