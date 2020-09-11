package TeX::Primitive::romannumeral;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

use TeX::Utils qw(int_as_roman);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $number = $tex->scan_int();

    $tex->conv_toks(int_as_roman($number));

    return;
}

1;

__END__
