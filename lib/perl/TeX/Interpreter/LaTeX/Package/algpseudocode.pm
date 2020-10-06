package TeX::Interpreter::LaTeX::Package::algpseudocode;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("algpseudocode", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::algpseudocode::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{algpseudocode}

%% This should be reviewed.  I don't think any of these are actually
%% part of algpseudocode per se.

\DeclareSVGEnvironment{algorithmic}
\DeclareSVGEnvironment{algo}

\def\floatc@ruled[2]{{\@fs@cfont #1.} #2\par}

\newcommand{\SetKwProg}[4]{}
\newcommand{\SetAlFnt}[1]{}
\newcommand{\SetAlCapFnt}[1]{}

\TeXMLendPackage

\endinput

__END__
