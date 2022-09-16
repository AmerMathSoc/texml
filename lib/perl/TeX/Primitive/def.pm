package TeX::Primitive::def;

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

use TeX::Token qw(:catcodes);

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
        TeX::Primitive::Macro->new({
            parameter_text   => $param_text,
            replacement_text => $macro_text,
            outer     => $modifier & MODIFIER_OUTER,
            long      => $modifier & MODIFIER_LONG,
            protected => $modifier & MODIFIER_PROTECTED,
                                   });

    $tex->define($r_token, $macro, $modifier);

    return;
}

1;

__END__
