package TeX::Primitive::noindent;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->new_graf(UNINDENTED);
    }

    return;
}

1;

__END__
