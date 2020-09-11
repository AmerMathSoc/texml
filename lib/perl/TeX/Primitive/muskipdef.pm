package TeX::Primitive::muskipdef;

use strict;
use warnings;

use base qw(TeX::Primitive::RegisterDef);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(mu_val);

    return;
}

1;

__END__
