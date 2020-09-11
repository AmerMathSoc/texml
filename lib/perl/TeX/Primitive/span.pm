package TeX::Primitive::span;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->align_error($cur_tok);

    return;
}

1;

__END__
