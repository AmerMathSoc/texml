package TeX::Primitive::tabskip;

use strict;
use warnings;

use base qw(TeX::Primitive::Register);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(glue_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $eqvt_ptr = $tex->get_glue_parameter("tab_skip");

    $tex->scan_optional_equals();

    my $glue = $tex->scan_glue(glue_val);

    $tex->set_tab_skip($glue, $modifier);

    return;
}

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    return $tex->tab_skip();
}

1;

__END__
