package TeX::Primitive::ignorespaces;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->ignorespaces();

    return;
}

1;

__END__
