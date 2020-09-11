package TeX::Primitive::closeout;

use strict;
use warnings;

use base qw(TeX::Primitive::FileOp);

use TeX::Node::CloseNode;

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $fileno = $tex->scan_int();

    my $node = TeX::Node::CloseNode->new({ fileno => $fileno });

    $tex->tail_append($node);

    return;
}

1;

__END__
