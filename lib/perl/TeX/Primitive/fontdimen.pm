package TeX::Primitive::fontdimen;

use strict;
use warnings;

use base qw(TeX::Primitive::Register);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(dimen_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    return;
}

1;

__END__
