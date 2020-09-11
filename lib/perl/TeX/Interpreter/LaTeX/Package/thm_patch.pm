package TeX::Interpreter::LaTeX::Package::thm_patch;

use strict;
use warnings;

use TeX::Constants qw(:named_args);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::thm_patch::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{thm_patch}

\RequirePackage{amsthm}

\newcommand\addtotheorempostheadhook[1][generic]{}

\TeXMLendPackage

\endinput

__END__
