package TeX::Primitive::uppercase;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->shift_case(1);

    return;
}

1;

__END__
