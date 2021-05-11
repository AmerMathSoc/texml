package TeX::Interpreter::LaTeX::Package::siunitx;

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

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

\def\num#1{\siunitx@num#1\@nil}

\def\siunitx@num#1e#2\@nil{
    \ensuremath{#1 \times 10^{#2}}%
}

\let\sisetup\@gobble

\TeXMLendPackage

\endinput

__END__
