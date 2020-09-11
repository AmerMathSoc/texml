package TeX::Interpreter::LaTeX::Package::amsbsy;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amsbsy::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{amsbsy}

\DeclareTeXMLMathAlphabet\boldsymbol

%% TODO: Can \pmb be replaced by \boldsymbol?

\DeclareTeXMLMathAlphabet\pmb

\TeXMLendPackage

\endinput

__END__
