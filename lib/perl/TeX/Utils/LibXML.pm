package TeX::Utils::LibXML;

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

use version; our $VERSION = qv '1.0.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(append_xml_element
                                copy_xml_node
                                find_unique_node
                                new_child_element
                                new_xml_element
                             ) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

use TeX::Utils::Misc;

use XML::LibXML;

sub find_unique_node( $$ ) {
    my $node  = shift;
    my $xpath = shift;

    my @nodes = $node->findnodes($xpath);

    if (@nodes == 0) {
        TeX::RunError->throw("No '$xpath' node found");
    } elsif (@nodes > 1) {
        TeX::RunError->throw("Multiple '$xpath' nodes found");
    }

    return $nodes[0];
}

sub new_xml_element( $ ) {
    my $name = shift;

    return XML::LibXML::Element->new($name);
}

sub new_child_element( $$ ) {
    my $parent = shift;
    my $element_name = shift;

    my $child = new_xml_element($element_name);

    $parent->appendChild($child);

    return $child;
}

sub copy_xml_node( $$$ ) {
    my $xpath = shift;
    my $src   = shift;
    my $dst   = shift;

    for my $node ($src->findnodes($xpath)) {
        $dst->appendChild($node);
    }

    return;
}

sub append_xml_element( $$;$$ ) {
    my $parent       = shift;
    my $element_name = shift;
    my $pcdata       = shift;

    my $atts = shift;

    my $child;

    if (empty($element_name)) {
        if (nonempty($pcdata)) {
            $parent->appendChild(XML::LibXML::Text->new($pcdata));
        }
    } else {
        $child = XML::LibXML::Element->new($element_name);

        $parent->appendChild($child);

        if (nonempty($pcdata)) {
            if (eval { $pcdata->isa("XML::LibXML::Node") }) {
                $child->appendChild($pcdata);
            } else {
                $child->appendText($pcdata);
            }
        }

        if (defined $atts) {
            while (my ($key, $val) = each %{ $atts }) {
                $child->setAttribute($key, $val);
            }
        }
    }

    return $child;
}

1;

__END__
