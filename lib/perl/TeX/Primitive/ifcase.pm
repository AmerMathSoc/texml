package TeX::Primitive::ifcase;

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

use base qw(TeX::Primitive::BeginIf);

use TeX::Constants qw(:booleans :tracing_macro_codes);

use TeX::Constants qw(:if_codes);

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
