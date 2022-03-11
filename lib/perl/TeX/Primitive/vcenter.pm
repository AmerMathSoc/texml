package TeX::Primitive::vcenter;

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

use TeX::WEB2C qw(:box_params :command_codes :save_stack_codes :token_types);

use TeX::Constants qw(:booleans);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if (! $tex->is_mmode()) {
        $tex->insert_dollar_sign($cur_tok);

        return;
    }

    my $cur_cmd = $tex->get_meaning($cur_tok);

    $tex->scan_spec(vcenter_group, false);

    # Then like a vbox...

    $tex->normal_paragraph();

    $tex->push_nest();

    $tex->set_cur_mode(- vmode);

    $tex->set_prevdepth(ignore_depth);

    $tex->begin_token_list($tex->get_toks_list('every_vbox'), every_vbox_text);

    return;
}

1;

__END__
