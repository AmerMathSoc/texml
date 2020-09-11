package TeX::Primitive::RegisterArithmetic;

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
