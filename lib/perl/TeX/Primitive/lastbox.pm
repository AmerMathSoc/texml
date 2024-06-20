package TeX::Primitive::lastbox;

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

use base qw(TeX::Primitive::MakeBox);

use TeX::Class;

use TeX::Node::HListNode qw(new_null_box);

use TeX::Constants qw(:command_codes);

sub scan_box {
    my $self = shift;

    my $tex         = shift;
    my $box_context = shift;

    my $cur_box = new_null_box();

    my $mode = $tex->get_cur_mode();

    if (abs($mode) == mmode) {
        $tex->you_cant($self);

        $tex->set_help("Sorry; this \lastbox will be void.");

        $tex->error();
    }
    elsif ($mode == vmode) { #  and (head = tail
        $tex->you_cant($self);

        $tex->set_help("Sorry...I usually can't take things from the current page.",
                       "This \lastbox will therefore be void.");

        $tex->error();
    } else {
        my $cur_list = $tex->get_cur_list();

        my $node = $cur_list->get_node(-1);

        if ($node->is_box()) {
            $cur_list->pop_node();

            $cur_box = $node;
        }
    }

    $tex->set_cur_box($cur_box);

    $tex->box_end($box_context);

    return;
}

1;

__END__
