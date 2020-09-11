package TeX::Interpreter::LaTeX::Package::hyperams;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::hyperams::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{hyperams}

\RequirePackage{hyperref}

\TeXMLendPackage

\endinput

__END__
