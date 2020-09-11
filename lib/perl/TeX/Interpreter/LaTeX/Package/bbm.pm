package TeX::Interpreter::LaTeX::Package::bbm;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::bbm::DATA{IO});

    return;
}

1;

__DATA__

\def\mathbbm{\mathbb}

\endinput

__END__
