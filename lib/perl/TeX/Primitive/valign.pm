package TeX::Primitive::valign;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_hmode()) {
        $tex->init_align($self);

        return;
    }

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    if ($tex->is_mmode()) {
        $tex->insert_dollar_sign($cur_tok);

        return;
    }

    return;
}

1;

__END__
