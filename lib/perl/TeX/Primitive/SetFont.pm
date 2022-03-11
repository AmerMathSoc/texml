package TeX::Primitive::SetFont;

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

use base qw(TeX::Command);

use TeX::Class;

my %font :ATTR(:get<font> :set<font> :init_arg => 'font');

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->set_cur_font($self->get_font());

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print("select font ");

    # slow_print(font_name[chr_code]);
    # 
    # if font_size[chr_code] <> font_dsize[chr_code] then
    # begin
    #     print(" at ");
    #     print_scaled(font_size[chr_code]);
    #     print("pt");
    # end;

    return;
}

1;

__END__
