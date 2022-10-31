package TeX::Primitive::LuaTeX::letcharcode;

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

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Class;

my %modifier_of :ATTR(:get<modifier> :init_arg<modifier> :default(0));

use TeX::Constants qw(:booleans :tracing_macro_codes);

use TeX::Token qw(:catcodes);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $prefix = exists $_[0] ? shift : 0;

    my $modifier = $prefix | $self->get_modifier();

    my $char_code = $tex->scan_char_num();

    my $next_token = $tex->get_next();

    while ($next_token == CATCODE_SPACE) {
        $next_token = $tex->get_next();
    }

    if ($next_token == CATCODE_OTHER && $next_token eq "=") {
        $next_token = $tex->get_next();

        if ($next_token == CATCODE_SPACE) {
            $next_token = $tex->get_next();
        }
    }

    if ($tex->tracing_macros() & TRACING_MACRO_DEFS) {
        $tex->begin_diagnostic();

        $tex->print_ln();

        $tex->print("active char($char_code):=$next_token");

        $tex->print_ln();

        $tex->end_diagnostic(false);
    }

    my $equiv = $tex->get_meaning($next_token);

    $tex->define_active_char(chr($char_code), $equiv, $modifier);

    return;
}

1;

__END__
