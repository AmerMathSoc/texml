package TeX::Primitive::csname;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Constants qw(:booleans);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $e = $tex->no_new_control_sequence();

    $tex->set_no_new_control_sequence(false);

    my $new_tok = $tex->do_csname($cur_tok);

    $tex->set_no_new_control_sequence($e);

    $tex->back_input($new_tok);
}

1;

__END__
