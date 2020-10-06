package TeX::Interpreter::LaTeX::Package::upref;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use TeX::Class;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("upref");

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::upref::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{upref}[2010/10/01 v2.05]

\AtBeginDocument{%
    \providecommand\printref{\textup}%
}

\providecommand\@upn{\textup}

\TeXMLendPackage

\endinput

__END__
