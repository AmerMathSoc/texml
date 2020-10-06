package TeX::Interpreter::LaTeX::Package::framed;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("framed", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::framed::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{framed}

\newenvironment{framed}{%
    \par
    \everypar{}%
    \startXMLelement{boxed-text}%
    \setXMLattribute{content-type}{\@currenvir}%
}{%
    \par
    \endXMLelement{boxed-text}%
}

\TeXMLendPackage

\endinput

__END__
