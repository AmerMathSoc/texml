package TeX::Primitive::vsplit;

use strict;
use warnings;

use base qw(TeX::Primitive::MakeBox);

use TeX::Class;

use TeX::Node::HListNode qw(new_null_box);

sub scan_box {
    my $self = shift;

    my $tex         = shift;
    my $box_context = shift;

    # @<Split off part of a vertical box, make |cur_box| point to it@>;

    $tex->set_cur_box(new_null_box);

    $tex->box_end($box_context);

    return;
}

1;

__END__
