package TeX::Primitive::ifcase;

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::Constants qw(:booleans :tracing_macro_codes);

use TeX::WEB2C qw(:if_codes);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->push_cond_stack($self);

    my $n = $tex->scan_int();

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->print($n);

        $tex->end_diagnostic(true);
    }

    my $save_cond_ptr = $tex->get_cond_ptr();

    while ($n != 0) {
        my $cur_cmd = $tex->pass_text();

        if ($tex->get_cond_ptr() == $save_cond_ptr) {
            if ($cur_cmd->isa("TeX::Primitive::or")) {
                $n--;
            } else { # \else or \fi
                if ($cur_cmd->isa("TeX::Primitive::fi")) {
                    $tex->pop_cond_stack();
                } else {
                    $tex->set_if_limit(fi_code); # {wait for \.{\\fi}}
                }

                return;
            }
        } elsif ($cur_cmd->isa("TeX::Primitive::fi")) {
            $tex->pop_cond_stack();
        }
    }

    $tex->change_if_limit(or_code, $save_cond_ptr);

    return;
}

1;

__END__
