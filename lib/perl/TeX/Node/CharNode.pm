package TeX::Node::CharNode;

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

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::Arithmetic qw(scaled_to_string);

use TeX::Utils qw(print_char_code);

use TeX::Constants qw(:node_params :type_bounds);

use TeX::Node::HListNode qw(:factories);

my %font_of      :ATTR(:get<font>      :set<font>);
my %char_code_of :ATTR(:get<char_code> :set<char_code>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(max_halfword);

    $font_of{$ident}      = $arg_ref->{font};
    $char_code_of{$ident} = $arg_ref->{char_code};

    $self->set_visible(1);

    return;
}

sub is_char_node {
    return 1;
}

sub to_string :STRINGIFY {
    my $self = shift;

    my $char = $self->get_char_code();

    return chr($char);
}

sub show_node {
    my $self = shift;

    my $font = $self->get_font();
    my $char = $self->get_char_code();

    return sprintf "%s %s", $font, print_char_code($char);
}

1;

__END__
