package TeX::Primitive::skewchar;

use strict;
use warnings;

use base qw(TeX::Primitive::Register);

use TeX::WEB2C qw(:scan_types);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(int_val);

    return;
}

sub read_value {
    return -1;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $eqvt_ptr = $self->find_register($tex, $cur_tok);

    my $value = $self->scan_value($tex, $cur_tok);

    # $tex->eq_define($eqvt_ptr, $value, $modifier);

    return;
}

sub find_register {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $fnt = $tex->scan_font_ident();

    return;
}

1;

__END__
