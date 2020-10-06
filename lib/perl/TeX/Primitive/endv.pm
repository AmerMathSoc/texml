package TeX::Primitive::endv;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::WEB2C qw(:save_stack_codes :token_types :lexer_states);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_mmode()) {
        $tex->insert_dollar_sign($cur_tok);

        return;
    }

    # while (input_stack[base_ptr].index_field <> v_template) and
    #       (input_stack[base_ptr].loc_field   =  null) and
    #       (input_stack[base_ptr].state_field =  token_list) do
    #     decr(base_ptr);
    # 
    # if (input_stack[base_ptr].index_field <> v_template) or
    #    (input_stack[base_ptr].loc_field   <> null) or
    #    (input_stack[base_ptr].state_field <> token_list) then
    #     fatal_error("(interwoven alignment preambles are not allowed)");

    if ($tex->cur_group() == align_group) {
        $tex->end_graf();

        if ($tex->fin_col()) {
            $tex->fin_row();
        }
    } else {
        $tex->off_save($cur_tok, "endv");
    }

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print("end of alignment template");
    
    return;
}

1;

__END__
