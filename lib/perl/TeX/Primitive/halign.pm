package TeX::Primitive::halign;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::WEB2C qw(:save_stack_codes);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_hmode()) {
        $tex->head_for_vmode($cur_tok);

        return;
    }

    if ($tex->is_vmode()) {
        $tex->init_align($self);

        return;
    }

    if ($tex->is_mmode()) {
        if ($tex->privileged($self)) {
            if ($tex->cur_group() == math_shift_group) {
                $tex->init_align($self);
            } else {
                $tex->off_save($cur_tok, "halign in mmode");
            }
        }

        return;
    }

    return;
}

1;

__END__
