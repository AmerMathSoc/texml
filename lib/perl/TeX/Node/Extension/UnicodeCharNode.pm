package TeX::Node::Extension::UnicodeCharNode;

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

## This probably doesn't need to be separate from TeX::Node::CharNode.

use strict;
use warnings;

use TeX::Output::FontMapper qw(decode_character);

use base qw(TeX::Node::CharNode Exporter);

our %EXPORT_TAGS = (factories => [ qw(new_unicode_character) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT = ();

use TeX::Class;

use TeX::Interpreter::Constants;

my %CACHE;

sub new_unicode_character( $;$ ) {
    my $char_code = shift;

    my $encoding = shift || DEFAULT_CHARACTER_ENCODING;

    my $cached = $CACHE{$encoding}->{$char_code};

    return $cached if defined $cached;

    my $ucs_code = $char_code;

    if ($char_code < 256 && $encoding ne DEFAULT_CHARACTER_ENCODING) {
        $ucs_code = decode_character($encoding, $char_code);
    }

    $cached = __PACKAGE__->new({ char_code => $ucs_code });

    return $CACHE{$encoding}->{$char_code} = $cached;
}

1;

__END__
