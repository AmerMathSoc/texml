package TeX::Primitive::accent;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    if ($tex->is_hmode()) {
        $tex->make_accent();
    }

    if ($tex->is_mmode()) {
        $tex->print_err("Please use ");
        $tex->print_esc("mathaccent");
        $tex->print(" for accents in math mode");

        $tex->set_help("I'm changing \\accent to \\mathaccent here; wish me luck.",
                        "(Accents are not the same in formulas as they are in text.)");

        $tex->error();

        $tex->math_ac();
    }

    return;
}

1;

__END__
