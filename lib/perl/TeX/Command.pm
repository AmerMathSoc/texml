package TeX::Command;

use strict;
use warnings;

use TeX::Class;

my %name_of :ATTR(:name<name>);

sub execute {
    my $self = shift;

    my $engine  = shift;
    my $cur_tok = shift;

    # $engine->print_err("Unimplemented primitive '$cur_tok'");
    # 
    # $engine->set_help("The primitive at the end of the top line",
    #                   "of your error message has not been implemented yet.");
    # 
    # $engine->error();

    return;
}

sub print_cmd_chr { # for print_cmd_chr()
    my $self = shift;

    my $tex = shift;

    if (defined(my $name = $self->get_name())) {
        $tex->print_esc($name);
    } else {
        $tex->print("[unknown command code!]");
    }

    return;
}

1;

__END__
