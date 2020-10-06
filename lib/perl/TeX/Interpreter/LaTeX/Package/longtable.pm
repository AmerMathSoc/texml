package TeX::Interpreter::LaTeX::Package::longtable;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

#    $tex->load_latex_package("longtable", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::longtable::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{longtable}

\DeclareSVGEnvironment{longtable}

\TeXMLendPackage

\endinput

__END__
