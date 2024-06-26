package TeX::Node::MathNode;

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

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::Constants qw(:node_params);

my %width_of :ATTR(:get<width> :set<width>  :init_arg => 'width');
my %subtype_of :ATTR(:get<subtype> :set<subtype> :init_arg => 'subtype');

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_subtype($arg_ref->{subtype});

    return;
}

sub show_node {
    my $self = shift;

    my $subtype = $self->get_subtype();

    my $node = '\math' . ($subtype == before ? 'on' : 'off');

    return $node;
}

1;

__END__
