package TeX::Primitive::copy;

use strict;
use warnings;

use base qw(TeX::Primitive::MakeBox);

use TeX::Class;

use TeX::Node::HListNode qw(new_null_box);

## This is a no-op for now

sub scan_box {
    my $self = shift;

    my $tex         = shift;
    my $box_context = shift;

    my $index = $tex->scan_eight_bit_int();

    my $box_ref = $tex->find_box_register($index);

    $tex->set_cur_box(${ $box_ref }->get_equiv());

    $tex->box_end($box_context);

    return;
}

1;

__END__
