package TeX::Interpreter::LaTeX::Package::array;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("array", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::array::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{array}

\@ifundefined{extrarowheight}{%
    \newlength\extrarowheight
    \setlength{\extrarowheight}{0pt}%
}{}

\TeXMLendPackage

\endinput
__END__
