package TeX::Interpreter::LaTeX::Package::amscyr;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amscyr::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{amscyr}

\def\Sha{\mathrm{\char"0428}}
\def\Shcha{\mathrm{\char"0429}}
\def\De{\mathrm{\char"0434}}

\TeXMLendPackage

\endinput

__END__
