package TeX::Primitive::ifcat;

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

use TeX::Class;

use TeX::Constants qw(:booleans :tracing_macro_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $token_a = $tex->get_x_token_or_active_char();

    my $token_b = $tex->get_x_token_or_active_char();

    my $code_a = $token_a->get_catcode();
    my $code_b = $token_b->get_catcode();

    my $bool = $code_a == $code_b;

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->print("$code_a $code_b => ", $bool ? 'TRUE' : 'FALSE');

        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
