package TeX::Primitive::write;

use strict;
use warnings;

use base qw(TeX::Primitive::FileOp);

use TeX::Constants qw(:booleans);

use TeX::Node::WriteNode;

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $fileno = $tex->scan_int();

    my $token_list = $tex->scan_toks(false, false);

    my $node = TeX::Node::WriteNode->new({ token_list => $token_list,
                                           fileno => $fileno });

    $tex->tail_append($node);                                           

    return;
}

1;

__END__
