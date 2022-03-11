package TeX::Primitive::setbox;

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

use TeX::WEB2C qw(:box_params);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $prefix = exists $_[0] ? shift : 0;

    my $modifier = $prefix ; # | $self->get_modifier();

    my $n = $tex->scan_eight_bit_int();

    $n += 256 if $modifier & MODIFIER_GLOBAL;

    $tex->scan_optional_equals();

    if (! $tex->is_set_box_allowed()) {
        $tex->print_err("Improper ");
        $tex->print_esc("setbox");

        $tex->set_help("Sorry, \\setbox is not allowed after \\halign in a display,",
                       "or between \\accent and an accented character.");

        $tex->error();

        return;
    }

    $tex->scan_box(box_flag + $n);

    return;
}

1;

__END__
