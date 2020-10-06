package TeX::Interpreter::LaTeX::Package::graphicx;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::graphicx::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{graphicx}

\RequirePackage{graphics}

\long\def\setkeys#1#2{}

\TeXMLendPackage

\endinput

__END__
