package TeX::Interpreter::LaTeX::Package::multirow;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::multirow::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{multirow}

\def\multirow#1#2#3{\TeXMLrowspan #1 1 #3}

\TeXMLendPackage

\endinput

__END__
