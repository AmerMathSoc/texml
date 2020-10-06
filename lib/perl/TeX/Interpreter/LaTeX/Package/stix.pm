package TeX::Interpreter::LaTeX::Package::stix;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::stix::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{stix}

\RequirePackage{unicode-math}

\TeXMLendPackage

\endinput

__END__
