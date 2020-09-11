package TeX::Primitive::ifnum;

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

    my $num_a = $tex->scan_int();

    my $op = $tex->scan_comparison_operator($cur_tok);

    my $num_b = $tex->scan_int();

    my $bool = $tex->do_conditional_comparison($cur_tok, $num_a, $op, $num_b);

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
