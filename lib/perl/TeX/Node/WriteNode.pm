package TeX::Node::WriteNode;

use strict;
use warnings;

use base qw(TeX::Node::FileNode);

use TeX::Class;

use TeX::TokenList;

my %token_list_of :ATTR(:name<token_list> :type<TeX::TokenList>);

use TeX::WEB2C qw(:node_params);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_subtype(write_node);

    return;
}

1;

__END__
