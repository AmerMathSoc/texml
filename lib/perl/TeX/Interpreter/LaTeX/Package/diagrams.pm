package TeX::Interpreter::LaTeX::Package::diagrams;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::diagrams::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\DeclareSVGEnvironment{diagram}

\def\diagramstyle[#1]{}
\newcommand{\newarrow}[6]{}

\endinput

__END__
