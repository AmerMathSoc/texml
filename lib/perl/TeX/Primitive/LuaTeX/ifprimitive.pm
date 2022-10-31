package TeX::Primitive::LuaTeX::ifprimitive;

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

use Scalar::Util qw(refaddr);

use TeX::Interpreter qw(UNDEFINED_CS);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $bool = 0;

    my $cs = $tex->get_next();

    my $csname = $cs->get_csname();

    if (defined (my $prim_meaning = $tex->get_primitive($csname))) {
        my $cur_meaning = $tex->get_meaning($cs);

        if (refaddr($cur_meaning) != refaddr(UNDEFINED_CS())) {
            $bool = refaddr($cur_meaning) == refaddr($prim_meaning); 
        }
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
