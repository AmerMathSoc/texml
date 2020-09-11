package TeX::Primitive::endcsname;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->print_err("Extra ");
    $tex->print_esc("endcsname");

    $tex->set_help("I'm ignoring this, since I wasn't doing a \\csname.");

    $tex->error();

    return;
}

1;

__END__
