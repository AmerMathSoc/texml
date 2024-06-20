package TeX::Primitive::endv;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:save_stack_codes :token_types :lexer_states);

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
