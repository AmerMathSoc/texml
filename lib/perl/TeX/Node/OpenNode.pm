package TeX::Node::OpenNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::FileNode);

use TeX::Class;

my %filename_of :ATTR(:name<filename>);

use TeX::WEB2C qw(:node_params);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_subtype(open_node);

    return;
}

1;

__END__
