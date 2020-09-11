package TeX::Interpreter::LaTeX::Package::etoolbox;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("etoolbox", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::etoolbox::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{etoolbox}

\def\patchcmd#1#2#3#4#5{}

\TeXMLendPackage

\endinput

__END__
