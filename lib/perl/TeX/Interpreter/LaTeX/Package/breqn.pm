package TeX::Interpreter::LaTeX::Package::breqn;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("breqn", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::breqn::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\endinput

__END__
