package TeX::Primitive::ifeof;  ##INCOMPLETE

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::WEB2C qw(:io_status);

use TeX::Class;

use TeX::Constants qw(:booleans :tracing_macro_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $fileno = $tex->scan_four_bit_int();

    my $bool = $tex->get_read_open($fileno) == closed;

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->print("$fileno => ", $bool ? 'TRUE' : 'FALSE');

        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
