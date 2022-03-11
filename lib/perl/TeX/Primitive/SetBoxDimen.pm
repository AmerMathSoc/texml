package TeX::Primitive::SetBoxDimen;

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

use base qw(TeX::Command::Executable::Assignment
            TeX::Command::Executable::Readable);

use TeX::Class;

use TeX::WEB2C qw(:scan_types);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(dimen_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    # c := cur_chr;

    my $index = $tex->scan_eight_bit_int();

    $tex->scan_optional_equals();

    my $dimen = $tex->scan_normal_dimen();

    # if box($index) <> null then mem[box($index) + c].sc := cur_val;

    return;
}

sub read_value {
    my $self = shift;
    my $tex = shift;

    my $index = $tex->scan_eight_bit_int();

    my $cur_val = 0;

    # if box(cur_val) = null then
    #     cur_val := 0
    # else
    #     cur_val := mem[box(cur_val) + m].sc;

    return $cur_val;
}

1;

__END__
