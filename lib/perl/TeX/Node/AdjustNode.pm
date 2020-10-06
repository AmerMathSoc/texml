package TeX::Node::AdjustNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

my %adjust_ptr_of :ATTR(:get<adjust_ptr> :set<adjust_ptr>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(adjust_node);

    $adjust_ptr_of{$ident} = $arg_ref->{adjust_ptr};

    return;
}

1;

__END__
