package TeX::Primitive::Extension::boxtostring;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $index = $tex->scan_eight_bit_int();

    my $box_ref = $tex->find_box_register($index);

    my $box = ${ $box_ref }->get_equiv();

    $tex->conv_toks($box);

    return;
}

1;

__END__
