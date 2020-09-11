package TeX::Noad::BinNoad;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractNoad);

use TeX::Class;

use TeX::WEB2C qw(:math_params);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_class(bin_noad);

    return;
}

sub first_pass {
    my $self = shift;
    my $engine = shift;
    my $prev_atom = shift;

    my $prev_type = $prev_atom->get_class();

    if (    (op_noad <= $prev_type && $prev_type <= open_noad)
         || ($prev_type == punct_noad) 
         || ($prev_type == left_noad))
    {
        $self->set_class(ord_noad);
    }

    return $self->SUPER::first_pass($engine, $prev_atom);
}

1;

__END__
