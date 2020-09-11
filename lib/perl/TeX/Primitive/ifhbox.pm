package TeX::Primitive::ifhbox;

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::Class;

use TeX::Constants qw(:booleans :tracing_macro_codes);
use TeX::WEB2C qw(:node_params);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $box_no = $tex->scan_eight_bit_int();

    my $box_ref = $tex->find_box_register($box_no);

    my $equiv = ${ $box_ref }->get_equiv();

    my $bool = defined $equiv && $equiv->get_type() == hlist_node;

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
