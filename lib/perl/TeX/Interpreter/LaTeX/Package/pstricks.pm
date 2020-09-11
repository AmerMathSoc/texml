package TeX::Interpreter::LaTeX::Package::pstricks;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("pstricks", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::pstricks::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{pstricks}

\DeclareSVGEnvironment{pspicture}

\TeXMLendPackage

\endinput

__END__
