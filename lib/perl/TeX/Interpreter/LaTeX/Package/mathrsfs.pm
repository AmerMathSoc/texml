package TeX::Interpreter::LaTeX::Package::mathrsfs;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::mathrsfs::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{mathrsfs}

\def\mathscr{\mathcal}

\DeclareTeXMLMathAlphabet\mathscr

\TeXMLendPackage

\endinput

__END__
