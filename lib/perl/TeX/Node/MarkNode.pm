package TeX::Node::MarkNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::TokenList;

my %token_list_of :ATTR(:name<token_list> :type<TeX::TokenList>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(mark_node);

    return;
}

1;

__END__
