package TeX::Node::RuleNode;

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

use TeX::Arithmetic qw(:string);

use TeX::Constants qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

my %height_of :ATTR(:get<height> :set<height>);
my %width_of  :ATTR(:get<width>  :set<width>);
my %depth_of  :ATTR(:get<depth>  :set<depth>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(rule_node);

    $width_of{$ident}  = $arg_ref->{width};
    $height_of{$ident} = $arg_ref->{height};
    $depth_of{$ident}  = $arg_ref->{depth};

    $self->set_visible(1);

    return;
}

sub is_rule {
    return 1;
}

sub show_node {
    my $self = shift;

    my $height = $self->get_height();
    my $depth  = $self->get_depth();
    my $width  = $self->get_width();

    my $node = sprintf '\\rule(%s+%s)x%s', (rule_dimen_to_string($height),
                                            rule_dimen_to_string($depth),
                                            rule_dimen_to_string($width));

    return $node;
}

1;

__END__
