package TeX::Interpreter::LaTeX::Package::booktabs;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("booktabs", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::booktabs::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{booktabs}

\def\toprule{\hline}
\def\midrule{\hline}
\def\bottomrule{\hline}
\def\cmidrule{\cline}

\def\tablestrut{}

\TeXMLendPackage

\endinput

__END__
