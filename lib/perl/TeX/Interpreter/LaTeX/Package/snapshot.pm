package TeX::Interpreter::LaTeX::Package::snapshot;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::snapshot::DATA{IO});

    $tex->define_csname(RequireVersions => \&do_RequireVersions);

    return;
}

sub do_RequireVersions {
    my $tex   = shift;
    my $token = shift;

    my $opt_arg = $tex->scan_optional_argument();

    my $versions = $tex->read_undelimited_parameter();

    return;
}

1;

__DATA__

\endinput

__END__
