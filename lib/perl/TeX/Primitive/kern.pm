package TeX::Primitive::kern;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Constants qw(:booleans);

use TeX::Nodes qw(new_kern);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $width = $tex->scan_dimen(false, false, false);

    $tex->tail_append(new_kern($width));

    return;
}

1;

__END__
