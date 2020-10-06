package TeX::Primitive::pdfTeX::ifpdfabsdim;

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

    my $dim_a = abs($tex->scan_normal_dimen());

    my $op = $tex->scan_comparison_operator($cur_tok);

    my $dim_b = abs($tex->scan_normal_dimen());

    my $bool = $tex->do_conditional_comparison($cur_tok, $dim_a, $op, $dim_b);

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
