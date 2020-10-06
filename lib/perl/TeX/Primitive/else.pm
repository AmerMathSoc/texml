package TeX::Primitive::else;

use strict;
use warnings;

use base qw(TeX::Primitive::Fi);

use TeX::Class;

use TeX::WEB2C qw(:if_codes);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_fi_code(else_code);

    return;
}

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->end_conditional($cur_tok, $self);

    return;
}

1;

__END__
