package TeX::Primitive::penalty;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Nodes qw(new_penalty);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $penalty = $tex->scan_int();

    $tex->tail_append(new_penalty($penalty));

    return;
}

1;

__END__
