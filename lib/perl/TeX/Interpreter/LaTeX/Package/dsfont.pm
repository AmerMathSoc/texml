package TeX::Interpreter::LaTeX::Package::dsfont;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::dsfont::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{dsfont}[1995/08/01 v0.1 Double stroke roman fonts (texml)]

\DeclareTeXMLMathAlphabet\mathds

\TeXMLendPackage

\endinput

__END__
