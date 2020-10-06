package TeX::Node::CloseNode;

use strict;
use warnings;

use base qw(TeX::Node::FileNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_subtype(close_node);

    return;
}

1;

__END__
