package TeX::Primitive::end;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->end_par();

    if ($tex->its_all_over()) { # its_all_over() currently a no-op
        $tex->do_end();
    }

    return;
}

1;

__END__
