package TeX::Node::MathNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params);

my %width_of :ATTR(:get<width> :set<width>  :init_arg => 'width');

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(math_node);

    $self->set_subtype($arg_ref->{subtype});

    return;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    $hlist->update_natural_width($self->get_width());

    return;
}

sub show_node {
    my $self = shift;

    my $subtype = $self->get_subtype();

    my $node = '\math' . ($subtype == before ? 'on' : 'off');

    return $node;
}

1;

__END__
