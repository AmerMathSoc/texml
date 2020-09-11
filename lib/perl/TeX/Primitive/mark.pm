package TeX::Primitive::mark;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Constants qw(:booleans);

use TeX::Node::MarkNode;

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $mark = $tex->scan_toks(false, true);

    my $mark_node = TeX::Node::MarkNode->new({ token_list => $mark });

    $tex->tail_append($mark_node);

    return;
}

1;

__END__
