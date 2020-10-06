package TeX::Primitive::raise;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $cur_val = $tex->scan_normal_dimen();

    $tex->scan_box(-$cur_val);

    return;
}

1;

__END__
