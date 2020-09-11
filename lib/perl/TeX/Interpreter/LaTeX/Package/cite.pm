package TeX::Interpreter::LaTeX::Package::cite;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("cite", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::cite::DATA{IO});

    return;
}

1;

__DATA__

\def\@make@cite@list{%
    \@cite@dump@now
}

\def\@cite@out#1{%
    \startXMLelement{xref}%
    \setXMLattribute{rid}{\@citeb}%
    \setXMLattribute{ref-type}{bibr}%
    \citeform{\csname#1\endcsname}%
    \endXMLelement{xref}%
}

\endinput

__END__
