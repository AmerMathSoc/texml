package TeX::Interpreter::LaTeX::Package::wasysym;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::wasysym::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{wasysym}

\RequirePackage{unicode-math}

\DeclareSVGMathChar\currency\mathord

\def\smiley{\ensuremath{\char"263A}}

\TeXMLendPackage

\endinput

__END__
