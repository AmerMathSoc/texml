package TeX::Primitive::sfcode;

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

    my $sf_code = $tex->scan_int();

    if ($sf_code < 0 || $sf_code > 077777) {
        $tex->print_err("Invalid sfcode ($sf_code), ",
                                "should be in the range 0..", 077777);

        $tex->set_help("I'm going to use 0 instead of that illegal code value.");

        $tex->error();

        $sf_code = 0;
    }

    $modifier ||= 0;

    $tex->set_sfcode($char_code, $sf_code, $modifier);

    return;
}

sub read_value {
    my $self = shift;

    my $tex = shift;

    my $char_code = $tex->scan_char_num();

    return $tex->get_sfcode($char_code);
}

1;

__END__
