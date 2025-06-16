package TeX::Primitive::ifx;

use v5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

use warnings;

use base qw(TeX::Primitive::BeginIf);

use TeX::Class;

use TeX::Constants qw(:booleans :tracing_macro_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self, $cur_tok);

    my $token_1 = $tex->get_next();
    my $token_2 = $tex->get_next();

    my $meaning_1 = $tex->get_meaning($token_1);
    my $meaning_2 = $tex->get_meaning($token_2);

    my $type_1 = ref($meaning_1);
    my $type_2 = ref($meaning_2);

    ## I think this is fairly close, but it's not perfect.  For one
    ## thing, it doesn't recognize subclasses; so, for example,
    ## anonymous macros will be treated as primitives, not as macros.
    ## On the other hand, since anonymous macros don't have accessible
    ## parameter_text or replacement_text lists, that's probably ok.

    ##FIXME: This might not work for CharGiven's and MathGiven's now.

    my $bool = $type_1 eq $type_2 && $meaning_1 == $meaning_2;

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);

        $tex->show_token_list($token_1, -1, 1);

        $tex->show_token_list($token_2, -1, 1);

        $tex->print("=> ", $bool ? 'TRUE' : 'FALSE');

        # use UNIVERSAL qw(isa);
        # if (UNIVERSAL::isa($meaning_1, "TeX::Primitive::Macro")) {
        #     $tex->print_nl("     ");
        #     $tex->show_token_list($token_1, -1, 1);
        #     if (defined (my $param_text = $meaning_1->get_parameter_text())) {
        #         $tex->token_show($param_text);
        #     }
        #     $tex->print("->");
        #     $tex->token_show($meaning_1->get_replacement_text());
        # }
        # 
        # if (UNIVERSAL::isa($meaning_2, "TeX::Primitive::Macro")) {
        #     $tex->print_nl("     ");
        #     $tex->show_token_list($token_2, -1, 1);
        #     if (defined (my $param_text = $meaning_2->get_parameter_text())) {
        #         $tex->token_show($param_text);
        #     }
        #     $tex->print("->");
        #     $tex->token_show($meaning_2->get_replacement_text());
        # }

        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
