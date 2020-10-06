package TeX::Primitive::hrule;

use strict;
use warnings;

use base qw(TeX::Primitive::Rule);

use TeX::Class;

use TeX::WEB2C qw(ignore_depth);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_mmode()) {
        $tex->insert_dollar_sign($cur_tok);

        return;
    }

    if ($tex->is_hmode()) {
        $tex->head_for_vmode($cur_tok);

        return;
    }

    my $spec = $tex->scan_rule_spec();

    # $tex->tail_append($spec);

    $tex->set_prevdepth(ignore_depth);

    return;
}

1;

__END__
