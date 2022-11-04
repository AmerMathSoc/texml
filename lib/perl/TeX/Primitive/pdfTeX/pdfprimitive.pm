package TeX::Primitive::pdfTeX::pdfprimitive;

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

## INCOMPLETE

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Token qw(:catcodes);

use TeX::Interpreter qw(FROZEN_PRIMITIVE_TOKEN);

use TeX::Class;

my %subtype_of :COUNTER(:name<subtype>);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $save_scanner_status = $tex->scanner_status();

    $tex->set_scanner_status(0); # normal

    my $next = $tex->get_next();

    $tex->set_scanner_status($save_scanner_status);

    if ($next != CATCODE_CSNAME) {
        $self->missing_primitive($tex, $next);

        return;
    }

    my $prim = $tex->get_primitive($next->get_csname());

    if (! defined $prim) {
        $self->missing_primitive($tex, $next);

        return;
    }

    if ($prim->isa("TeX::Command::Expandable")) {
        return $prim->expand($tex, $next);
    }

    return;
}

sub missing_primitive {
    my $self = shift;

    my $tex = shift;
    my $tok = shift;

    $tex->print_err("Missing primitive name");

    $tex->set_help("The control sequence marked <to be read again> does not",
                   "represent any known primitive.");

    $tex->back_error($tok);

    return;
}

1;

__END__
