package TeX::Primitive::input;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->start_input();

    return;
}

1;

__END__
