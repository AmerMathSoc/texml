package TeX::Interpreter::LaTeX::Package::pgf;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::pgf::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{pgf}

\RequirePackage{color}

%% There are undoubtably more of these we should add.

\let\pgfmathsetmacro\@gobbletwo

\let\pgfdeclareshape\@gobbletwo

\let\usepgflibrary\@gobble

\TeXMLendPackage

\endinput

__END__
