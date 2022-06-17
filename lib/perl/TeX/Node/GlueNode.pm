package TeX::Node::GlueNode;

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

use TeX::Arithmetic qw(:string);

use TeX::WEB2C qw(:node_params);

my %width_of   :ATTR(:get<width>   :set<width>);

my %stretch_of       :ATTR(:get<stretch> :set<stretch>);
my %stretch_order_of :ATTR(:get<stretch_order> :set<stretch_order>);

my %shrink_of  :ATTR(:get<shrink>  :set<shrink>);
my %shrink_order_of :ATTR(:get<shrink_order> :set<shrink_order>);

my %leader_ptr_of :ATTR(:get<leader_ptr> :set<leader_ptr>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(glue_node);

    if (exists $arg_ref->{glue}) {
        my $glue = $arg_ref->{glue};

        $width_of        {$ident} = $glue->get_width();

        $stretch_of      {$ident} = $glue->get_stretch();
        $stretch_order_of{$ident} = $glue->get_stretch_order();

        $shrink_of       {$ident} = $glue->get_shrink();
        $shrink_order_of {$ident} = $glue->get_shrink_order();
    } else {
        $width_of        {$ident} = $arg_ref->{width} || 0;

        $stretch_of      {$ident} = $arg_ref->{stretch}       || 0;
        $stretch_order_of{$ident} = $arg_ref->{stretch_order} || normal;

        $shrink_of       {$ident} = $arg_ref->{shrink}        || 0;
        $shrink_order_of {$ident} = $arg_ref->{shrink_order}  || normal;

        $leader_ptr_of   {$ident} = $arg_ref->{leader_ptr};
    }

    return;
}

sub is_glue {
    return 1;
}

sub show_node {
    my $self = shift;

    my $node = sprintf '\glue %s', scaled_to_string($self->get_width);

    my $stretch = $self->get_stretch();

    if ($stretch != 0) {
        my $order = $self->get_stretch_order();

        $node .= sprintf ' plus %s', glue_to_string($stretch, $order);
    }

    my $shrink = $self->get_shrink();

    if ($shrink != 0) {
        my $order = $self->get_shrink_order();

        $node .= sprintf ' minus %s', glue_to_string($shrink, $order);
    }

    return $node;
}

sub to_string :STRINGIFY {
    my $self = shift;

    return " ";
}

1;

__END__
