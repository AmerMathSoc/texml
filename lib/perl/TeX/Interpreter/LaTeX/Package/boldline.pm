package TeX::Interpreter::LaTeX::Package::boldline;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("boldline", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::boldline::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{boldline}

\def\hlineB#1{%
    \noalign{\ifnum0=`}\fi % I'm frankly astonished that this works.
        \def\current@border@width{medium}%
        \futurelet\@let@token\do@hline
}

\def\clineB#1#2{%
    \noalign{\ifnum0=`}\fi % I'm frankly astonished that this works.
        \def\current@border@width{medium}%
        \@cline#1\@nil
}

\TeXMLendPackage

\endinput

__END__
