package TeX::Primitive::right;

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

use TeX::WEB2C qw(:save_stack_codes);

use TeX::Constants qw(:booleans);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $cur_group = $tex->cur_group();

    # $tex->DEBUG("Doing $cur_tok: cur_group = " . group_type($cur_group));

    if ($cur_group != math_left_group) {
        if ($cur_group == math_shift_group) {
            $tex->scan_delimiter(false);

            $tex->print_err("Extra ");
            $tex->print_esc("right");
    
            $tex->set_help("I'm ignoring a \\right that had no matching \\left.");
    
            $tex->error();
        } else {
            my $m = sprintf q{\right (cur_group = %s)}, group_type($cur_group);

            $tex->off_save($cur_tok, $m);
        }

        return;
    }

    # my $delim = $tex->scan_delimiter(false);

    my $saved_node = $tex->get_node_register('end_math_list');

    $tex->unsave(); # {end of |math_left_group|}

    my $head = $tex->pop_nest();

    $tex->tail_append(@{ $head });

    if (defined $saved_node) {
        $tex->tail_append($saved_node);
    }

    $tex->conv_toks(qq{\\right});

    return;
}

1;

__END__
