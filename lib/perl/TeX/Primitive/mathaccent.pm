package TeX::Primitive::mathaccent;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->scan_fifteen_bit_int();

    return;
}

1;

__END__
