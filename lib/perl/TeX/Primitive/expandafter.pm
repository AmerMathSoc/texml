package TeX::Primitive::expandafter;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

use TeX::TokenList;

use TeX::WEB2C qw(:token_types);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token_1 = $tex->get_next();

    my $token_2 = $tex->get_next();

    my $expandable = $tex->get_expandable_meaning($token_2);

    if (defined($expandable)) {
        $expandable->expand($tex, $token_2);
    } else {
        $tex->back_input($token_2);
    }

    $tex->back_input($token_1);

    return;
}

1;

__END__
