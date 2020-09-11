package TeX::Primitive::the;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->ins_list($tex->the_toks($cur_tok));

    return;
}

1;

__END__
