package TeX::Primitive::SetInteraction;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

my %mode_of :COUNTER(:name<mode> :default(-1));

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->set_interaction_mode($self->get_mode());

    return;
}

1;

__END__
