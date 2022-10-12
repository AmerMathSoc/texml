package TeX::Primitive::texml::TeXMLtoprow;

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

use version; our $VERSION = qv '0.0.0';

use base qw(TeX::Primitive::LastItem);

use TeX::Class;

use TeX::WEB2C qw(:command_codes);

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $row = $tex->scan_int();
    my $col = $tex->scan_int();

    my $cur_align = $tex->get_cur_alignment();

    if (! defined $cur_align) {
        $tex->print_err("You can't use \\TeXMLtoprow outside of an alignment");

        $tex->set_help("Really, mate, you can't.");

        $tex->error();

        return;
    }

    return $cur_align->top_row($row, $col);
}

1;

__END__
