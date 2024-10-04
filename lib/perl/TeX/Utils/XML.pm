package TeX::Utils::XML;

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

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(xml_to_utf8_string) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT =  ( @{ $EXPORT_TAGS{all} } );

use XML::LibXML qw(:libxml);

use TeX::Utils::Misc qw(nonempty);

use TeX::Unicode::Translators qw(tex_math_to_unicode);

sub xml_to_utf8_string( $ );
sub xml_to_utf8_string( $ ) {
    my $xml_node = shift;

    my $type = $xml_node->nodeType();

    if ($type == XML_TEXT_NODE) {
        my $content = $xml_node->nodeValue();

        return $content;
    } elsif ($type == XML_ELEMENT_NODE) {
        my $name = $xml_node->nodeName();

        return "" if $name eq 'fn';

        if ($name eq 'xref') {
            my $ref_type = $xml_node->getAttribute('ref-type');

            return "" if nonempty($ref_type) && $ref_type eq 'fn';
        }

        if ($name eq 'inline-formula') {
            my $tex = $xml_node->firstChild()->textContent();

            return tex_math_to_unicode(qq{\$$tex\$});
        }

        my $utf8 = "";

        for my $child ($xml_node->childNodes()) {
            $utf8 .= xml_to_utf8_string($child);
        }

        return $utf8;
    }

    return;
}

1;

__END__
