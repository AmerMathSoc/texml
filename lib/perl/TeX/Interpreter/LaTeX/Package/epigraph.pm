package TeX::Interpreter::LaTeX::Package::epigraph;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("epigraph", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::epigraph::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{epigraph}

\def\epigraph#1#2{%
    \startXMLelement{disp-quote}%
    \setXMLattribute{content-type}{epigraph}%
    #1\par
    \thisxmlpartag{attrib}#2\par
    \endXMLelement{disp-quote}%
}

\TeXMLendPackage

\endinput

__END__
