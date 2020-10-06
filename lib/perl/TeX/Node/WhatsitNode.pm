package TeX::Node::WhatsitNode;

## It's not clear that having a separate subclass of WhatsitNodes is
## really useful.  In fact, it's almost certain that it's not.  But
## for now I'll keep them.

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(whatsit_node);

    return;
}

1;

__END__
