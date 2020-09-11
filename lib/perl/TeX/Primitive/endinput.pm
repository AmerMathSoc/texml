package TeX::Primitive::endinput;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->set_force_eof(1);

    return;
}

1;

__END__
