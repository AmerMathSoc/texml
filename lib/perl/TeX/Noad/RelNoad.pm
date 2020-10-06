package TeX::Noad::RelNoad;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractNoad);

use TeX::Class;

use TeX::WEB2C qw(:math_params);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_class(rel_noad);

    return;
}

1;

__END__
