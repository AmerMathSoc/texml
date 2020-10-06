package TeX::Primitive::pdfTeX::ifincsname;

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $bool = 0;

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
