package TeX::Node::PenaltyNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params);

my %penalty_of :ATTR(:get<penalty> :set<penalty> :init_arg => 'penalty');

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(penalty_node);
    $self->set_subtype(0);

    return;
}

1;

__END__
