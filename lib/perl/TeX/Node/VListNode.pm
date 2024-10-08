package TeX::Node::VListNode;

# Copyright (C) 2022, 2024 American Mathematical Society
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

use TeX::Constants qw(:node_params);

use base qw(TeX::Node::HListNode);

use TeX::Class;

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_is_hbox(0);
    $self->set_is_vbox(1);

    return;
}

sub is_overline_box {
    my $self = shift;

    my $node = $self->get_list_ptr();

    return unless defined $node && $node->is_kern();

    $node = $node->get_link();

    return unless defined $node && $node->is_rule();

    $node = $node->get_link();

    return unless defined $node && $node->is_kern();

    $node = $node->get_link();

    return unless defined $node && $node->is_hbox();

    $node = $node->get_link();

    return if defined $node;

    return 1;
}

sub is_underline_box {
    my $self = shift;

    my $node = $self->get_list_ptr();

    return unless defined $node && $node->is_hbox();

    $node = $node->get_link();

    return unless defined $node && $node->is_kern();

    $node = $node->get_link();

    return unless defined $node && $node->is_rule();

    # return if defined $node;

    return 1;
}

1;

__END__
