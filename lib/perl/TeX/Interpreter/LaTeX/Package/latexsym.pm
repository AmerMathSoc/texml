package TeX::Interpreter::LaTeX::Package::latexsym;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::latexsym::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{latexsym}

\RequirePackage{unicode-math}

\def\Box{\mdlgwhtsquare}
\def\Diamond{\lozenge}
\def\leadsto{\rightsquigarrow}

\def\lhd{\vartriangleleft}
\def\rhd{\vartriangleright}
\def\unlhd{\trianglelefteq}
\def\unrhd{\trianglerighteq}

\TeXMLendPackage

\endinput

__END__
