package TeX::Node::SpecialNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::WhatsitNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_subtype(special_node);

    return;
}

1;

__END__
