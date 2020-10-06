package TeX::Primitive::omit;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->print_err("Misplaced ");
    $tex->print_esc("omit");

    $tex->set_help("I expect to see \\omit only after tab marks or the \\cr of",
                   "an alignment. Proceed, and I'll ignore this case.");

    $tex->error();

    return;
}

1;

__END__
