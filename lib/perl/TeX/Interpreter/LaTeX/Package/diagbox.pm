package TeX::Interpreter::LaTeX::Package::diagbox;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

#    $tex->load_latex_package("diagbox", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::diagbox::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{diagbox}

\newcommand{\diagbox}[3][]{%
    \TeXMLCreateSVG{\diagbox[#1]{#2}{#3}}%
}

\TeXMLendPackage

\endinput

__END__
