package TeX::Primitive::eTeX::unless;

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

use base qw(TeX::Command::Expandable);

use TeX::Constants qw(:booleans);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token = $tex->get_token();

    my $meaning = $tex->get_meaning($token);

    if ($meaning->isa("TeX::Primitive::If")) {
        return $meaning->expand($tex, $token, true);
    }

    $tex->print_err("You can't use `");
    $tex->print_esc("unless");
    $tex->print("' before `");
    $tex->print_cmd_chr($meaning);
    $tex->print_char("'");

    $tex->set_help("Continue, and I'll forget that it ever happened.");

    $tex->back_error($token);

    return;
}

1;

__END__
