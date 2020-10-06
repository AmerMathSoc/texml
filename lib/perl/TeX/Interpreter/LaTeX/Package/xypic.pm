package TeX::Interpreter::LaTeX::Package::xypic;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_package("xy");

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xypic::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\def\diagram#1\enddiagram{%
    \TeXMLCreateSVG{$\diagram#1\enddiagram$}%
}

\endinput

__END__
