package TeX::Interpreter::LaTeX::Package::arcs;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::arcs::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{arcs}

\def\overarc#1{%
    \string\overarc\string{\hbox{#1}\string}%
}

\endinput

__END__
