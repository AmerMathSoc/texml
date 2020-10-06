package TeX::Primitive::badness;

use strict;
use warnings;

use base qw(TeX::Primitive::LastItem);

use TeX::Class;

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    return $tex->last_badness();

    return;
}

1;

__END__
