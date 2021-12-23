package TeX::Interpreter::LaTeX::Package::genyoungtabtikz;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("genyoungtabtikz", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::genyoungtabtikz::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{genyoungtabtikz}

\def\gyoung(#1){%
    \TeXMLCreateSVG{\gyoung(#1)}%
}

\TeXMLendPackage

\endinput

__END__
