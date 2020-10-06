package TeX::Primitive::if;

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::Class;

use TeX::WEB2C qw(:catcodes);

use TeX::Constants qw(:booleans :tracing_macro_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $token_a = $tex->get_x_token_or_active_char();

    my $token_b = $tex->get_x_token_or_active_char();

    my $char_a = 256;

    if ($token_a->get_catcode() <= CATCODE_ACTIVE) {
        $char_a = ord($token_a->get_char());
    }

    my $char_b = 256;

    if ($token_b->get_catcode() <= CATCODE_ACTIVE) {
        $char_b = ord($token_b->get_char());
    }

    my $bool = $char_a == $char_b;

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->print("$char_a $char_b => ", $bool ? 'TRUE' : 'FALSE');

        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
