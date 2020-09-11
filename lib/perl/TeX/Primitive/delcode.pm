package TeX::Primitive::delcode;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Readable
            TeX::Command::Executable::Assignment);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(int_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $char_code = $tex->scan_char_num();

    $tex->scan_optional_equals();

    my $del_code = $tex->scan_int();

    if ($del_code < 0 || $del_code > 0xFFFFFF) {
        $tex->print_err("Invalid delcode ($del_code), ",
                                "should be in the range 0..\"FFFFFF");

        $tex->set_help("I'm going to use 0 instead of that illegal code value.");

        $tex->error();

        $del_code = 0;
    }

    $tex->set_delcode($char_code, $del_code, $modifier);

    return;
}

sub read_value {
    my $self = shift;

    my $tex = shift;

    my $char_code = $tex->scan_char_num();

    return $tex->get_delcode($char_code);
}

1;

__END__
