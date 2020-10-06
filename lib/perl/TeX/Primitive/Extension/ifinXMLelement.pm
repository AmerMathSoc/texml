package TeX::Primitive::Extension::ifinXMLelement;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use base qw(TeX::Primitive::If);

use TeX::Constants qw(:booleans :named_args :tracing_macro_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $qName = $tex->read_undelimited_parameter(EXPANDED);

    my $qName_string = $qName->to_string();

    my $bool = false;

    for my $stack_qName ($tex->get_xml_stacks()) {
        if ($qName_string eq $stack_qName) {
            $bool = true;

            last;
        }
    }

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->show_token_list($qName, -1, 1);

        $tex->print("=> ", $bool ? 'TRUE' : 'FALSE');

        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
