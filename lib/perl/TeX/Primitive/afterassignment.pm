package TeX::Primitive::afterassignment;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $next_token = $tex->get_next();

    $tex->set_after_token($next_token);

    return;
}

1;

__END__
