package TeX::Interpreter::LaTeX::Package::blkarray;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("blkarray", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::blkarray::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{blkarray}

\DeclareSVGEnvironment*{blockarray}

\TeXMLendPackage

\endinput

__END__
