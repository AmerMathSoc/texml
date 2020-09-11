package TeX::Interpreter::LaTeX::Package::csquotes;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::csquotes::DATA{IO});

    return;
}

1;

__DATA__

\def\enquote#1{``#1''}

\endinput

__END__
