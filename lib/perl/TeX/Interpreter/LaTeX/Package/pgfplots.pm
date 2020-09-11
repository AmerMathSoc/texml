package TeX::Interpreter::LaTeX::Package::pgfplots;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::pgfplots::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{pgfplots}

\RequirePackage{graphicx}
\RequirePackage{tikz}

\RequirePackage{color}

%% There are undoubtably more of these we should add.

\let\pgfplotsset\@gobble

\def\pgfdeclarepatternformonly#1#2#3#4#5{}

\def\pgfplotstableread#1#2{}

\TeXMLendPackage

\endinput

__END__
