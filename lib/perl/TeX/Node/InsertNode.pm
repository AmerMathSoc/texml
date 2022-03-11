package TeX::Node::InsertNode;

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

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

my %box_number_of       :ATTR(:get<box_number>       :set<box_number>);
my %height_of           :ATTR(:get<height>           :set<height>);
my %depth_of            :ATTR(:get<depth>            :set<depth>);
my %split_top_ptr_of    :ATTR(:get<split_top_ptr>    :set<split_top_ptr>);
my %float_cost_of       :ATTR(:get<float_cost>       :set<float_cost>);
my %floating_penalty_of :ATTR(:get<floating_penalty> :set<floating_penalty>);
my %ins_ptr_of          :ATTR(:get<ins_ptr>          :set<ins_ptr>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(ins_node);

    $box_number_of      {$ident} = $arg_ref->{box_number};
    $height_of          {$ident} = $arg_ref->{height};
    $depth_of           {$ident} = $arg_ref->{depth};
    $split_top_ptr_of   {$ident} = $arg_ref->{split_top_ptr};
    $float_cost_of      {$ident} = $arg_ref->{float_cost};
    $floating_penalty_of{$ident} = $arg_ref->{floating_penalty};
    $ins_ptr_of         {$ident} = $arg_ref->{ins_ptr};

    return;
}

1;

__END__
