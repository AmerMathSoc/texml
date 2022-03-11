package TeX::Primitive::RegisterArithmetic;

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

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

use TeX::Arithmetic qw(:arithmetic);

use TeX::WEB2C qw(:command_codes :scan_types);

my %opcode_of :ATTR(:name<opcode> :default<-1>);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $token = $tex->get_x_token();

    if (my $meaning = $tex->get_meaning($token)) {
        if (UNIVERSAL::isa($meaning, "TeX::Primitive::Parameter")) {
            my $level = $meaning->get_level();

            my $eqvt_ptr;

            if (UNIVERSAL::isa($meaning, "TeX::Primitive::Register")) {
                $eqvt_ptr = $meaning->find_register($tex, $token);
            } else {
                $eqvt_ptr = $meaning->get_eqvt_ptr();
            }

            my $old_val = $$eqvt_ptr->get_equiv()->get_value();

            $tex->scan_keyword("by");
            
            my $op_code = $self->get_opcode();
            
            my $new_val;
            
            if ($op_code == advance) {
                my $op_val;

                if ($level < glue_val) {
                    $op_val = $level == int_val ? $tex->scan_int()
                                                : $tex->scan_normal_dimen();
                } else {
                    $op_val = $tex->scan_glue($level);
                }

                $new_val = $old_val + $op_val;
            } else {
                my $op_val = $tex->scan_int();
                
                if ($level < glue_val) {
                    if ($op_code == multiply) {
                        if ($level == int_val) {
                            $new_val = mult_integers($old_val, $op_val);
                        } else {
                            $new_val = nx_plus_y($old_val, $op_val, 0);
                        }
                    } else {
                        $new_val = x_over_n($old_val, $op_val);
                    }
                } else {
                    if ($op_code == multiply) {
                        $new_val = $old_val * $op_val;
                    } else {
                        $new_val = $old_val / $op_val;
                    }
                }
            }
            
            $tex->eq_define($eqvt_ptr, $new_val, $modifier);
        } else {
            $tex->print_err("You can't use `$token' after $cur_tok");

            $tex->error();
        }
    } else {
        $tex->print_err("Undefined csname: ", $token->get_datum());
        $tex->error();
    }

    return;
}

1;

__END__
