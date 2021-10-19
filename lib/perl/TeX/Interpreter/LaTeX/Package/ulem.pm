package TeX::Interpreter::LaTeX::Package::ulem;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("ulem", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::ulem::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{ulem}

\RequirePackage{cancel}

\let\normalem\@empty

\def\xout{\cancel}

\TeXMLendPackage

\endinput

__END__
