package TeX::Interpreter::LaTeX::Package::multicol;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::multicol::DATA{IO});

    return;
}

1;

__DATA__

\newdimen\multicolsep

\endinput

__END__
