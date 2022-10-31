package TeX::Primitive::LuaTeX::immediateassigned;

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

use TeX::Class;

use TeX::Token qw(:catcodes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $save_scanner_status = $tex->scanner_status();

    my $next_token = $tex->get_next_non_blank_non_relax_non_call_token();

    my $cur_cmd = $tex->get_meaning($next_token);

    if ($cur_cmd == CATCODE_BEGIN_GROUP) {
        while (1) {
            $next_token = $tex->get_next_non_blank_non_relax_non_call_token();

            $cur_cmd = $tex->get_meaning($next_token);

            if ($cur_cmd == CATCODE_END_GROUP) {
                last;
            } else {
                $tex->set_set_box_allowed(0);

                $tex->prefixed_command($cur_cmd, $next_token);

                $tex->set_set_box_allowed(1);
            }
        }
    }

    $tex->set_scanner_status($save_scanner_status);

    return;
}

1;

__END__
