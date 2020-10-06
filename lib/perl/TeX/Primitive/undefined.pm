package TeX::Primitive::undefined;

use strict;
use warnings;

use base qw(TeX::Command);

## Permanently undefined (and uncallable) control sequence.

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->undefined($cur_tok);

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print("undefined");

    return;
}

1;

__END__
