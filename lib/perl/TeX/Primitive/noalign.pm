package TeX::Primitive::noalign;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->print_err("Misplaced ");
    $tex->print_esc("noalign");

    $tex->set_help("I expect to see \\noalign only after the \\cr of",
                   "an alignment. Proceed, and I'll ignore this case.");

    $tex->error();

    return;
}

1;

__END__
