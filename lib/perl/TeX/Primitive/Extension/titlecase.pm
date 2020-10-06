package TeX::Primitive::Extension::titlecase;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

## \titlecase is much less useful than it seems.

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->shift_case(2);

    return;
}

1;

__END__
