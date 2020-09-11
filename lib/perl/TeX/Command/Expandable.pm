package TeX::Command::Expandable;

use strict;
use warnings;

use base qw(TeX::Command);

use TeX::Class;

sub expand {
    my $self    = shift;
    my $engine  = shift;
    my $cur_tok = shift;

    $engine->print_err("Unimplemented primitive '$cur_tok'");

    $engine->set_help("The primitive at the end of the top line",
                      "of your error message has not been implemented yet.");

    $engine->error();

    return;
}

1;

__END__
