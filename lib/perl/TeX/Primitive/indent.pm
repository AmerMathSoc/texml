package TeX::Primitive::indent;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->new_graf();
    } else {
        if ($tex->is_hmode()) {
            $tex->set_spacefactor(1000);
        } else { # mmode
            # q := new_noad;
            # math_type(nucleus(q)) := sub_box;
            # info(nucleus(q)) := p;
            # p := q;
        }

        $tex->append_normal_space(); #* should check value of \parindent
    }

    return;
}

1;

__END__
