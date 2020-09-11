package TeX::Interpreter::LaTeX::Package::epsfig;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::epsfig::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{epsfig}

\RequirePackage{graphicx}

%% TBD

\def\reflectbox#1{%
    \TeXMLCreateSVG{\reflectbox{#1}}%
}

\TeXMLendPackage

\endinput

__END__
