package TeX::Primitive::begingroup;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::WEB2C qw(:save_stack_codes);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->begingroup();

    return;
}

1;

__END__
