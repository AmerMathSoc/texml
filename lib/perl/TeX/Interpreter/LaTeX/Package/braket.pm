package TeX::Interpreter::LaTeX::Package::braket;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("braket", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::braket::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{braket}

\DeclareMathPassThrough{bra}[1]
\DeclareMathPassThrough{ket}[1]
\DeclareMathPassThrough{braket}[1]
\DeclareMathPassThrough{set}[1]
\DeclareMathPassThrough{Bra}[1]
\DeclareMathPassThrough{Ket}[1]
\DeclareMathPassThrough{Braket}[1]
\DeclareMathPassThrough{Set}[1]
\DeclareMathPassThrough{ketbra}[1]
\DeclareMathPassThrough{Ketbra}[1]

\TeXMLendPackage

\endinput

__END__
