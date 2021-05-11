package TeX::Primitive::futurelet;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $r_token = $tex->get_r_token();

    my $saved_token  = $tex->get_next();
    my $future_token = $tex->get_next();

    $tex->back_input($future_token);
    $tex->back_input($saved_token);

    my $equiv = $tex->get_meaning($future_token);

    $tex->define($r_token, $equiv, $modifier);

    return;
}

1;

__END__
