package TeX::Primitive::pdfTeX::ifpdfprimitive;

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::Interpreter qw(UNDEFINED_CS);
use TeX::Constants qw(:booleans :tracing_macro_codes);
use TeX::WEB2C qw(:catcodes);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $next = $tex->get_next_careful();

    my $bool = false;

    if ($next == CATCODE_CSNAME) {
        my $meaning = $tex->get_meaning($next);

        if (ident($meaning) != ident(UNDEFINED_CS)) {
            my $prim = $tex->get_primitive($next->get_csname());

            $bool = defined($prim) && ident($meaning) == ident($prim);
        }
    }

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->print("=> ", $bool ? 'TRUE' : 'FALSE');

        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
