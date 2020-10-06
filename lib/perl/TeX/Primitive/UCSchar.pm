package TeX::Primitive::UCSchar;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Interpreter::Constants qw(DEFAULT_CHARACTER_ENCODING);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    my $char_code = $tex->scan_char_num();

    $tex->append_char($char_code, DEFAULT_CHARACTER_ENCODING);

    return;
}

1;

__END__
