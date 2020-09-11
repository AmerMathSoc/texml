package TeX::Noad::SubBoxField;

use strict;
use warnings;

use base qw(TeX::Noad::MathCharField);

use TeX::Class;

my %box_of :ATTR(:get<box> :set<box> :init_arg => 'box');

sub is_sub_box {
    return 1;
}

sub to_hlist {
    my $self = shift;

    my $engine = shift;

    return ($self->get_box(), undef);
}

sub to_clean_box {
    my $self = shift;

    return $self->get_box();
}

1;

__END__
