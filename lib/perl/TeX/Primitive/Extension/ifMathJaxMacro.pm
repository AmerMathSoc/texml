package TeX::Primitive::Extension::ifMathJaxMacro;

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

use base qw(TeX::Primitive::If);

use TeX::Class;

use TeX::Token qw(make_csname_token);

use TeX::Constants qw(:booleans :tracing_macro_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $token = $tex->get_next();

    my $bool = 0;

    if (defined (my $surface = $tex->get_macro_expansion_text($token))) {
        if ($surface->length() == 2) {
            my ($first, $second) = $surface->get_tokens();

            my $csname = $token->get_csname();

            if ($first->get_csname() eq 'protect' &&
                $second->get_csname() eq "$csname ") {
                my $internal = $tex->get_macro_expansion_text("$csname ");

                my $x = make_csname_token("non\@mathmode\@\\$csname");
                my $y = make_csname_token("frozen\@\\$csname");

                $bool = $internal->contains($x) || $internal->contains($y);
            }
        }
    }                

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();
    
        # $tex->print_nl("module = $module");
    
        $tex->print("=> ", $bool ? 'TRUE' : 'FALSE');
    
        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
