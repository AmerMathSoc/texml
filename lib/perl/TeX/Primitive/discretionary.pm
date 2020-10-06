package TeX::Primitive::discretionary;

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

    my $pre_break  = $tex->read_undelimited_parameter();

    my $post_break = $tex->read_undelimited_parameter();

    # my $no_break   = $tex->read_undelimited_parameter();
    # 
    # $tex->back_input($no_break);

    $tex->set_spacefactor(1000); # cf. append_discretionary

    return;
}

1;

__END__
