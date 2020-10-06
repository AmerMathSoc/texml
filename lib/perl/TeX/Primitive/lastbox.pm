package TeX::Primitive::lastbox;

use strict;
use warnings;

use base qw(TeX::Primitive::MakeBox);

use TeX::Class;

use TeX::Node::HListNode qw(new_null_box);

sub scan_box {
    my $self = shift;

    my $tex         = shift;
    my $box_context = shift;

    # @<If the current list ends with a box node, delete it from
    #   the list and make |cur_box| point to it; otherwise set
    #   |cur_box := null|@>;

    $tex->set_cur_box(new_null_box);

    $tex->box_end($box_context);

    return;
}

1;

__END__
