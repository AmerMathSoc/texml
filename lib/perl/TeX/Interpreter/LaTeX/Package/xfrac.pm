package TeX::Interpreter::LaTeX::Package::xfrac;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("xfrac", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xfrac::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{xfrac}

\DeclareMathJaxMacro\sfrac

\TeXMLendPackage

\endinput

__END__
