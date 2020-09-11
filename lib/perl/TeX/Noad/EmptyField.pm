package TeX::Noad::EmptyField;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractField);

use TeX::Class;

use TeX::Node::HListNode qw(:factories);

sub is_empty {
    return 1;
}

sub to_hlist {
    my $self = shift;

    my $engine = shift;

    return;
}

sub to_clean_box {
    my $self = shift;

    return new_null_box();
}

1;

__END__
