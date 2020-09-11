package TeX::Interpreter::LaTeX::Package::mleftright;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("mleftright", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::mleftright::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{mleftright}

\let\mleftright\@empty
\let\mleftrightrestore\@empty

\def\mleft{\left}
\def\mright{\right}

\TeXMLendPackage

\endinput

__END__
