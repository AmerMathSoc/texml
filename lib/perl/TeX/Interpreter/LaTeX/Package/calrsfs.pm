package TeX::Interpreter::LaTeX::Package::calrsfs;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::calrsfs::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{calrsfs}

\def\mathrsfs{\mathcal}

\TeXMLendPackage

\endinput

__END__
