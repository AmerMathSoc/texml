package TeX::Interpreter::LaTeX::Class::mathcal;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::mathcal::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesClass{mathcal}

\def\mchead#1{%
    \par
    \leavevmode
    \startXMLelement{bold}%
    \setXMLclass{mchead}%
    #1%
    \endXMLelement{bold}%
}

\def\mcloc#1{%
    \par
    \leavevmode
    \startXMLelement{bold}%
    \setXMLclass{mcloc}%
    Location:%
    \endXMLelement{bold}
    \startXMLelement{italic}%
    \setXMLclass{mcloc}%
    #1%
    \endXMLelement{italic}%
}

\TeXMLendClass

\endinput

__END__
