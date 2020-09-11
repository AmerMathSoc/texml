package TeX::Primitive::number;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $number = $tex->scan_int();

    $tex->conv_toks($number);

    return;
}

1;

__END__
