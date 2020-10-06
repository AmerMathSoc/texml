package TeX::Primitive::XeTeX::XeTeXmathcode;

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

    my $math_class = $tex->scan_math_class_int();
    my $math_fam   = $tex->scan_math_fam_int();
    my $math_char  = $tex->scan_char_num();

    my $math_code = $math_fam << 24 + $math_class << 21 + $math_char;

    $tex->set_mathcode($char_code, $math_code, $modifier); # ???

    return;
}

sub read_value {
    my $self = shift;

    my $tex = shift;

    my $char_code = $tex->scan_char_num();

    return $tex->get_mathcode($char_code);
}

1;

__END__
