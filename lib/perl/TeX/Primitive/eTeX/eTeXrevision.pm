package TeX::Primitive::eTeX::eTeXrevision;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->conv_toks(0);

    return;
}

1;

__END__
