package TeX::Noad::SubMlistField;

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

use base qw(TeX::Noad::AbstractField);

use TeX::Class;

my %mlist_of :ATTR(:get<mlist> :set<mlist> :init_arg => 'mlist');

sub is_sub_mlist {
    return 0;
}

sub to_hlist {
    my $self = shift;
    my $engine = shift;

    my $save_style = $engine->get_current_style();

    my $hlist = $engine->mlist_to_hlist($self->get_mlist());

    $engine->set_current_style($save_style);

    $engine->set_font_params();

    return wantarray ? ($hlist->hpack($engine, 0, 1), undef) : $hlist;
}

sub to_clean_box {
    my $self = shift;

    my $clean_box = scalar $self->to_hlist(@_);

    return $clean_box;
}

1;

__END__
