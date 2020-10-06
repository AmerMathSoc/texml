package TeX::Interpreter::LaTeX::Package::euscript;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_package("eucal", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::euscript::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{euscript}

%% Need to handle options.

\DeclareTeXMLMathAlphabet\mathscr

\def\EuScript{\mathscr}

\TeXMLendPackage

\endinput

__END__
