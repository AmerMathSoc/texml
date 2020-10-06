package TeX::Primitive::openout;

use strict;
use warnings;

use base qw(TeX::Primitive::FileOp);

use TeX::Node::OpenNode;

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $fileno = $tex->scan_four_bit_int();

    $tex->scan_optional_equals();

    my $filename = $tex->scan_file_name();

    my $node = TeX::Node::OpenNode->new({ filename => $filename,
                                          fileno   => $fileno });

    $tex->tail_append($node);

    return;
}

1;

__END__
