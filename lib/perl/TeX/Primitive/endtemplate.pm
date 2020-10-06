package TeX::Primitive::endtemplate;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->confusion("frozen_end_template in the main loop");

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print("outer endtemplate");
    
    return;
}

1;

__END__
