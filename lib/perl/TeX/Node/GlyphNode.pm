package TeX::Node::GlyphNode;

# Copyright (C) 2024 American Mathematical Society
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

# use TeX::Constants qw(:node_params);

use base qw(TeX::Node::WhatsitNode);

use TeX::Class;

my %font_of        :ATTR(:get<font>  :set<font>);
my %char_code_of    :ATTR(:get<char_code> :set<char_code>);
my %glyph_count_of :ATTR(:get<glyph_count> :set<glyph_count>);

my %width_of  :ATTR(:get<width>  :set<width>);
my %depth_of  :ATTR(:get<depth>  :set<depth>);
my %height_of :ATTR(:get<height> :set<height>);

use TeX::Utils qw(print_char_code);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    # $self->set_subtype(42); # XeTeX!

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

    my $font  = $self->get_font() || '<undef>';
    my $char  = $self->get_char_code();
    my $count = $self->get_glyph_count();

    return sprintf "%s %s (%d)", $font, print_char_code($char), $count;
}

1;

__END__
