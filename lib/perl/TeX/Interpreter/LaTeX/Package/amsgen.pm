package TeX::Interpreter::LaTeX::Package::amsgen;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("amsgen", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amsgen::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{amsgen}

%% Keep \@saveprimitive from generating unneeded noise.

\let\@saveprimitive\@gobbletwo

%% Might as well disable these as well -- they don't do anything useful.

\let\glb@settings\@empty
\def\set@fontsize#1#2#3{}
\let\compute@ex@\@empty

\TeXMLendPackage

\endinput

__END__
