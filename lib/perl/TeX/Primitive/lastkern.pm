package TeX::Primitive::lastkern;

use strict;
use warnings;

use base qw(TeX::Primitive::LastItem);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    ## Most of these are integers, so use int_val as the default

    $self->set_level(dimen_val);

    return;
}

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $tail = $tex->tail_node();

    if (defined $tail && $tail->isa("TeX::Node::KernNode")) {
        return $tail->get_width();
    }

    return 0;
}

1;

__END__
