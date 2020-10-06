package TeX::Primitive::lastpenalty;

use strict;
use warnings;

use base qw(TeX::Primitive::LastItem);

use TeX::Class;

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $tail = $tex->tail_node();

    if (defined $tail && $tail->isa("TeX::Node::PenaltyNode")) {
        return $tail->get_penalty();
    }

    return 0;
}

1;

__END__
