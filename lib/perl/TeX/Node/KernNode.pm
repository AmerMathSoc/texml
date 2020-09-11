package TeX::Node::KernNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::Arithmetic qw(scaled_to_string);

use TeX::WEB2C qw(:node_params);

my %width_of :ATTR(:get<width> :set<width> :init_arg => 'width');

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(kern_node);
    $self->set_subtype($arg_ref->{subtype} || normal);

    return;
}

sub is_kern {
    return 1;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    $hlist->update_natural_width($self->get_width());

    return;
}

sub show_node {
    my $self = shift;

    my $width  = $self->get_width();

    my $node = sprintf '\\kern%s', scaled_to_string($width);

    return $node;
}

1;

__END__
