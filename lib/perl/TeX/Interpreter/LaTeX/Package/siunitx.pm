package TeX::Interpreter::LaTeX::Package::siunitx;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("siunitx", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::siunitx::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{siunitx}

\def\num#1{\siunitx@num#1ee\@nil}

\def\siunitx@num#1e#2e#3\@nil{
    \ensuremath{#1 \if###2##\else \times 10^{#2}\fi}%
}

\let\sisetup\@gobble

\TeXMLendPackage

\endinput

__END__
