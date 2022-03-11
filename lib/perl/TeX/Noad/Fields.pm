package TeX::Noad::Fields;

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

use TeX::WEB2C qw(:math_params :extras);

use base qw(Exporter);

our %EXPORT_TAGS = (factories => [ qw(make_char_field
                                      make_text_char_field
                                      make_box_field
                                      make_mlist_field
                                   ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT =  ( @{ $EXPORT_TAGS{factories} } );

use TeX::Noad::MathCharField;
use TeX::Noad::MathTextCharField;
use TeX::Noad::SubBoxField;
use TeX::Noad::SubMlistField;

sub make_char_field($$) {
    my $family = shift;
    my $char_code = shift;

    return TeX::Noad::MathCharField->new({ family => $family,
                                           char_code => $char_code });
}

sub make_text_char_field($$) {
    my $family = shift;
    my $char_code = shift;

    return TeX::Noad::MathTextCharField->new({ family => $family,
                                               char_code => $char_code });
}

sub make_box_field( $ ) {
    my $box = shift;

    return TeX::Noad::SubBoxField->new({ box => $box });
}

sub make_mlist_field( $ ) {
    my $mlist = shift;

    return TeX::Noad::SubMlistField->new({ mlist => $mlist });
}

1;

__END__
