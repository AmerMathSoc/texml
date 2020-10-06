package TeX::Primitive::catcode;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Readable
            TeX::Command::Executable::Assignment);

use TeX::WEB2C qw(:command_codes :scan_types);

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

    my $cat_code = $tex->scan_int();

    if ($cat_code < 0 || $cat_code > max_char_code) {
        $tex->print_err("Invalid catcode ($cat_code), ",
                        "should be in the range 0..", max_char_code);

        $tex->set_help("I'm going to use 0 instead of that illegal code value.");

        $tex->error();

        $cat_code = 0;
    }

    $tex->set_catcode($char_code, $cat_code, $modifier);

    return;
}

sub read_value {
    my $self = shift;

    my $tex = shift;

    my $char_code = $tex->scan_char_num();

    return $tex->get_catcode($char_code);
}

1;

__END__
