package TeX::Primitive::LastItem;

use strict;
use warnings;

use base qw(TeX::Primitive::Parameter);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    ## Most of these are integers, so use int_val as the default

    $self->set_level(int_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->report_illegal_case($self);

    return;
}

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->print_err("Unimplemented last_item primitive '$cur_tok'");

    return;
}

1;

__END__
