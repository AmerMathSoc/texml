package TeX::Primitive::showthe;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token_list = $tex->the_toks($cur_tok);

    return;
}

1;

__END__
