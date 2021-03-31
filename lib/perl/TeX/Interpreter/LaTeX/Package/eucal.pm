package TeX::Interpreter::LaTeX::Package::eucal;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::eucal::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\DeclareTeXMLMathAlphabet\mathcal
\DeclareTeXMLMathAlphabet\mathscr

\let\EuScript\mathscr
\let\CMcal\mathscr

\endinput

__END__
