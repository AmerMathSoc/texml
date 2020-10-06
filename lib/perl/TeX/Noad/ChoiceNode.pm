package TeX::Noad::ChoiceNode;

use strict;
use warnings;

use TeX::WEB2C qw(:math_params :node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params);

my %choices_of :ATTR();

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(choice_node);

    return;
}

sub set_choice {
    my $self = shift;

    my $style = shift;
    my $mlist = shift;

    $choices_of{ident $self}->[$style/2] = $mlist;

    return;
}

sub get_choice {
    my $self = shift;

    my $style = shift;

    return $choices_of{ident $self}->[$style/2];
}

1;

__END__
