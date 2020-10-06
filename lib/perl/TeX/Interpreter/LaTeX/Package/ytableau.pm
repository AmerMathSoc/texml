package TeX::Interpreter::LaTeX::Package::ytableau;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

#    $tex->load_latex_package("ytableau", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::ytableau::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{ytableau}

\let\ytableausetup\@gobble

\DeclareSVGEnvironment{ytableau}

\def\ydiagram#1{%
    \TeXMLCreateSVG{\ydiagram{#1}}%
}

\TeXMLendPackage

\endinput

__END__
