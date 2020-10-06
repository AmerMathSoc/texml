package TeX::Interpreter::LaTeX::Package::slashbox;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("slashbox", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::slashbox::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{slashbox}

\def\backslashbox#1#2{\TeXMLCreateSVG{\backslashbox{#1}{#2}}}
\def\slashbox#1#2{\TeXMLCreateSVG{\slashbox{#1}{#2}}}

\TeXMLendPackage

\endinput

__END__
