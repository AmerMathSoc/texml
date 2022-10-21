package TeX::Primitive::LuaTeX::CombineTokens;

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

use base qw(TeX::Command::Executable Exporter);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Token qw(:catcodes);

use TeX::Class;

my %modifier_of :ATTR(:get<modifier> :init_arg<modifier> :default(0));

use TeX::Token qw(:catcodes);

use TeX::Constants qw(:booleans);
use TeX::WEB2C qw(:scan_types);

use TeX::Primitive::Macro;

sub __scan_token_list {
    my $tex = shift;

    my $next_tok = $tex->peek_next_non_blank_non_call_token();

    my $next_cmd = $tex->get_meaning($next_tok);

    if (! defined $next_cmd) {
        $tex->undefined($next_tok);

        return;
    }

    my $eqvt_ptr;

    if (eval { $next_cmd->isa('TeX::Primitive::Parameter') && $next_cmd->get_level() == tok_val}) {
        $tex->get_next(); # Consume $next_tok

        if ($next_cmd->isa('TeX::Primitive::Register')) {
            my $n = $next_cmd->get_index();

            $eqvt_ptr = $tex->find_toks_register($n);
        } else {
            $eqvt_ptr = $next_cmd->get_eqvt_ptr();
        }
    } else {
        my $n = $tex->scan_int();

        $eqvt_ptr = $tex->find_toks_register($n);
    }

    ## Should probably check that this succeeds and points to a token list.

    return $eqvt_ptr;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = $self->get_modifier();

    my $target = __scan_token_list($tex);

    my $cur_toks = eval { ${ $target }->get_equiv()->get_value()->clone() };

    my $extra_toks;

    my $next_tok = $tex->peek_next_non_blank_non_call_token();

    if ($next_tok == CATCODE_BEGIN_GROUP) {
        $extra_toks = $tex->scan_toks(false, $modifier & MODIFIER_EXPAND);
    } else {
        my $src = __scan_token_list($tex);

        $extra_toks = eval { ${ $src }->get_equiv()->get_value() };
    }

    if ($modifier & MODIFIER_APPEND) {
        $cur_toks->push($extra_toks);
    } else {
        $cur_toks->unshift($extra_toks);
    }

    $tex->eq_define($target, $cur_toks, $modifier);

    return;
}

1;

__END__
