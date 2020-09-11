package TeX::Primitive::box;

use strict;
use warnings;

use base qw(TeX::Primitive::MakeBox);

use TeX::Class;

use TeX::Node::HListNode qw(new_null_box);

sub scan_box {
    my $self = shift;

    my $tex         = shift;
    my $box_context = shift;

    my $index = $tex->scan_eight_bit_int();

    my $box_ref = $tex->find_box_register($index);

    $tex->set_cur_box(${ $box_ref }->get_equiv());

    # box(cur_val) := null; {the box becomes void, at the same level}

    $tex->box_end($box_context);

    return;
}

1;

__END__
