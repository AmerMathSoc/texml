package TeX::Interpreter::LaTeX::Package::adjustbox;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("adjustbox", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::adjustbox::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{adjustbox}

\newenvironment{adjustbox}[1]{}{}

\TeXMLendPackage

\endinput

__END__
