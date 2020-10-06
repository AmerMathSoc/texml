package TeX::Node::VListNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::HListNode);

use TeX::Class;

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(vlist_node);

    return;
}

sub is_overline_box {
    my $self = shift;

    my $node = $self->get_list_ptr();

    return unless defined $node && $node->is_kern();

    $node = $node->get_link();

    return unless defined $node && $node->is_rule();

    $node = $node->get_link();

    return unless defined $node && $node->is_kern();

    $node = $node->get_link();

    return unless defined $node && $node->is_hbox();

    $node = $node->get_link();

    return if defined $node;

    return 1;
}

sub is_underline_box {
    my $self = shift;

    my $node = $self->get_list_ptr();

    return unless defined $node && $node->is_hbox();

    $node = $node->get_link();

    return unless defined $node && $node->is_kern();

    $node = $node->get_link();

    return unless defined $node && $node->is_rule();

    # return if defined $node;

    return 1;
}

1;

__END__
