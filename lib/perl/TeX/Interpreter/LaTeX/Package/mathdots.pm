package TeX::Interpreter::LaTeX::Package::mathdots;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::mathdots::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{mathdots}

\RequirePackage{unicode-math}

\def\iddots{\adots}

\TeXMLendPackage

\endinput

__END__
