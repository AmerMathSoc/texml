package TeX::Node::HListNode;

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

use integer;

use base qw(Exporter);

our %EXPORT_TAGS = (factories => [ qw(new_null_box) ] );

our @EXPORT_OK = @{ $EXPORT_TAGS{factories} };

our @EXPORT;

use List::Util qw(any);

use TeX::Arithmetic qw(:string unity);

use TeX::WEB2C qw(:box_params :node_params :type_bounds);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

## list_ptr is used when we're extracting information from a .fmt file.
## node is used by TeX::Interpreter

my %list_ptr_of   :ATTR(:name<list_ptr>);
my %node_of       :ARRAY(:name<node>);

sub new_null_box {
    my @nodes = @_;

    my $box = __PACKAGE__->new();

    for my $node (@nodes) {
        $box->push_node($node);
    }

    return $box;
}

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(hlist_node);
    $self->set_subtype(min_quarterword);

    return;
}

sub get_head {
    my $self = shift;

    return $self->get_node(0);
}

sub is_visible {
    my $self = shift;

    ## TODO: Note that this will consider a list consisting solely of
    ## an XML open tag to be empty.  This is ok for the one place we
    ## currently use this (TeX::Interpreter::fin_col()), but might not
    ## be adequate in general.  It probably makes more sense to mark
    ## XmlOpenNodes and XmlCloseNodes as visible; then we can use this
    ## is_visible in TeX::Interpreter::__is_empty_par().

    return any { $_->is_visible() } $self->get_nodes();
}

sub to_string :STRINGIFY {
    my $self = shift;

    my @nodes = $self->get_nodes();

    local $" = '';

    return "@nodes";
}

1;

__END__
