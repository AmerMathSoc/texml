package TeX::Interpreter::LaTeX::Package::cancel;

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("cancel", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::cancel::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{cancel}

\DeclareMathPassThrough{cancel}[1]
\DeclareMathPassThrough{bcancel}[1]
\DeclareMathPassThrough{xancel}[1]
\DeclareMathPassThrough{cancelto}[2]

\TeXMLendPackage

\endinput

__END__
