package TeX::Primitive::closein;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $fileno = $tex->scan_four_bit_int();

    $tex->closein($fileno);

    return;
}

1;

__END__
