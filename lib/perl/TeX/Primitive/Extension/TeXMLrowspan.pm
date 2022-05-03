package TeX::Primitive::Extension::TeXMLrowspan;

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

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $num_rows = $tex->scan_int();
    my $num_cols = $tex->scan_int();

    if ($num_rows < 1) {
        $tex->print_err("$num_rows is an invalid num_rows parameter for \\TeXMLrowspan");

        $tex->set_help("It should be at least 2.");

        $tex->error();

        return;
    }

    if ($num_cols < 1) {
        $tex->print_err("$num_cols is an invalid num_cols parameter for \\TeXMLrowspan");

        $tex->set_help("It should be at least 1.");

        $tex->error();

        return;
    }

    $tex->init_span_record($num_rows, $num_cols);

    return;
}

1;

__END__
