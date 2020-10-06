package TeX::Interpreter::LaTeX::Package::textcmds;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use TeX::Class;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("textcmds", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::textcmds::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{textcmds}

\UCSchardef\textprimechar"2032
\UCSchardef\textlangle"2329
\UCSchardef\textrangle"232A

\let\tsub\relax
\DeclareRobustCommand{\tsub}{\XMLelement{sub}}

\let\tsup\relax
\DeclareRobustCommand{\tsup}{\XMLelement{sup}}

\TeXMLendPackage

__END__
