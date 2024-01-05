package TeX::Primitive::ifnum;

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

my %absolute_value_of :BOOLEAN(:name<abs> :default<0>);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $num_a = $tex->scan_int();

    my $op = $tex->scan_comparison_operator($cur_tok);

    my $num_b = $tex->scan_int();

    if ($self->is_abs()) {
        $num_a = abs($num_a);
        $num_b = abs($num_b);
    }

    my $bool = $tex->do_conditional_comparison($cur_tok, $num_a, $op, $num_b);

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
