package TeX::Interpreter::LaTeX::Package::pinlabel;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::pinlabel::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{pinlabel}

\let\thelabellist\@empty

\long\def\labellist#1\endlabellist{%
    \def\thelabellist{\labellist#1\endlabellist}%
}

\TeXMLendPackage

\endinput

__END__
