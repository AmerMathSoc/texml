package TeX::Interpreter::LaTeX::Class::carus;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_document_class('maabook', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::carus::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesClass{carus}

\TeXMLendClass

\endinput

__END__
