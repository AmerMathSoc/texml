package TeX::Interpreter::LaTeX::Package::nicefrac;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::nicefrac::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{nicefrac}

\DeclareRobustCommand*{\nicefrac}[3][]{#2/#3}

\TeXMLendPackage

\endinput

__END__
