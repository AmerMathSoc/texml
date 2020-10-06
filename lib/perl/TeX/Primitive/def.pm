package TeX::Primitive::def;

use strict;
use warnings;

use version; our $VERSION = qv '1.7.2';

use base qw(TeX::Command::Executable::Assignment);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Class;

my %modifier_of :ATTR(:get<modifier> :init_arg<modifier> :default(0));

use TeX::WEB2C qw(:catcodes);

use TeX::Constants qw(:booleans :tracing_macro_codes);

use TeX::Primitive::Macro;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $prefix = exists $_[0] ? shift : 0;

    my $modifier = $prefix | $self->get_modifier();

    my $r_token = $tex->get_r_token();

    my $param_text = $tex->read_parameter_text();
    my $macro_text = $tex->scan_toks(true, $modifier & MODIFIER_EXPAND);

    ## Extension.

    if ($tex->tracing_macros() & TRACING_MACRO_DEFS) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);
        $tex->show_token_list($r_token, -1, 1);
        $tex->print(":=");
        $tex->token_show($param_text);
        $tex->print("->");
        $tex->token_show($macro_text);

        $tex->end_diagnostic(true);
    }

    my $last_param_token = $param_text->index(-1);

    if (defined $last_param_token && $last_param_token == CATCODE_BEGIN_GROUP) {
        $macro_text->push($last_param_token);
    }

    my $macro = 
        TeX::Primitive::Macro->new({ parameter_text   => $param_text,
                                     replacement_text => $macro_text,
                                     outer => $modifier & MODIFIER_OUTER,
                                     long  => $modifier & MODIFIER_LONG,
                                   });

    $tex->define($r_token, $macro, $modifier);

    return;
}

1;

__END__
