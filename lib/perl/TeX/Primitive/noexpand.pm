package TeX::Primitive::noexpand;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

use TeX::Interpreter qw(FROZEN_DONT_EXPAND_TOKEN);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->back_input(FROZEN_DONT_EXPAND_TOKEN);

    return;
}

1;

__END__
