package TeX::Primitive::SetBoxDimen;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment
            TeX::Command::Executable::Readable);

use TeX::Class;

use TeX::WEB2C qw(:scan_types);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(dimen_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    # c := cur_chr;

    my $index = $tex->scan_eight_bit_int();

    $tex->scan_optional_equals();

    my $dimen = $tex->scan_normal_dimen();

    # if box($index) <> null then mem[box($index) + c].sc := cur_val;

    return;
}

sub read_value {
    my $self = shift;
    my $tex = shift;

    my $index = $tex->scan_eight_bit_int();

    my $cur_val = 0;

    # if box(cur_val) = null then
    #     cur_val := 0
    # else
    #     cur_val := mem[box(cur_val) + m].sc;

    return $cur_val;
}

1;

__END__
