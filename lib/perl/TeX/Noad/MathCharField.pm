package TeX::Noad::MathCharField;

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

use Carp;

use TeX::Nodes qw(:factories);
use TeX::Node::HListNode qw(:factories);

use base qw(TeX::Noad::AbstractField);

use TeX::Class;

my %family_of    :ATTR(:get<family>    :set<family>    :init_arg => 'family');
my %char_code_of :ATTR(:get<char_code> :set<char_code> :init_arg => 'char_code');

sub get_character {
    my $self = shift;

    return chr($self->get_char_code());
}

sub is_math_char {
    return 1;
}

sub to_hlist {
    my $self = shift;

    my $engine = shift;

    my $parent_noad = shift;

    my $fam = $self->get_family();
    my $char = $self->get_char_code();

    my $font = $engine->get_math_font($fam);

    my $h = $font->get_char_height($char);
    my $d = $font->get_char_depth($char);
    my $w = $font->get_char_width($char);

    my $delta = $font->get_char_italic_correction($char);

    if (! defined $delta) {
        croak "Unknown character $char in $font";
    }

    my $p = new_character($font, $char);

    if ($self->is_math_text_char() && $font->is_text_font()) {
        $delta = 0; # {no italic correction in mid-word of text font}
    }

    if (! $parent_noad->has_subscript() && $delta != 0) {
        $w += $delta;

        $p->set_link(new_kern($delta));

        $delta = 0;
    }

    return wantarray ? ($p, $delta) : $p;
}

sub to_clean_box {
    my $self = shift;

    return scalar $self->to_hlist(@_);
}

1;

__END__
