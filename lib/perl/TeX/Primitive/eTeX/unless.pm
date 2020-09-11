package TeX::Primitive::eTeX::unless;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Constants qw(:booleans);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token = $tex->get_token();

    my $meaning = $tex->get_meaning($token);

    if ($meaning->isa("TeX::Primitive::If")) {
        return $meaning->expand($tex, $token, true);
    }

    $tex->print_err("You can't use `");
    $tex->print_esc("unless");
    $tex->print("' before `");
    $tex->print_cmd_chr($meaning);
    $tex->print_char("'");

    $tex->set_help("Continue, and I'll forget that it ever happened.");

    $tex->back_error($token);

    return;
}

1;

__END__
