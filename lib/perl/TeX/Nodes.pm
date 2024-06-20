package TeX::Nodes;

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

use base qw(Exporter);

our %EXPORT_TAGS = (factories => [ qw(new_character
                                      new_null_vbox
                                      new_rule
                                      new_ins
                                      new_mark
                                      new_adjust
                                      new_ligature
                                      new_lig_item
                                      new_disc
                                      new_math
                                      new_glue
                                      new_kern
                                      new_penalty
                                      new_unset
                                      new_whatsit
                                      new_glyph_node
                                      new_open_node
                                      new_close_node
                                      new_write_node
                                      new_special_node
                                      new_language_node
                                      new_xml_open_node
                                      new_xml_close_node
                                      new_xml_attribute_node
                                      new_xml_class_node
                                      new_css_property_node
                                      new_end_u_template_node
                                   ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT = ();

use TeX::Constants qw(:node_params);

use TeX::Node::AdjustNode;
use TeX::Node::CharNode;
use TeX::Node::GlueNode;
use TeX::Node::GlyphNode;
use TeX::Node::InsertNode;
use TeX::Node::KernNode;
use TeX::Node::LigatureNode;
use TeX::Node::MarkNode;
use TeX::Node::MathNode;
use TeX::Node::PenaltyNode;
use TeX::Node::RuleNode;
use TeX::Node::UnsetNode;
use TeX::Node::VListNode;
use TeX::Node::OpenNode;
use TeX::Node::CloseNode;
use TeX::Node::WriteNode;
use TeX::Node::SpecialNode;
use TeX::Node::LanguageNode;
use TeX::Node::XmlOpenNode;
use TeX::Node::XmlCloseNode;
use TeX::Node::XmlClassNode;
use TeX::Node::XmlCSSpropNode;
use TeX::Node::UTemplateMarker;

sub new_character {
    my $font = shift;
    my $char = shift;

    return TeX::Node::CharNode->new({ font => $font, char_code => $char });
}

######################################################################
##                                                                  ##
##         DATA STRUCTURES FOR BOXES AND THEIR FRIENDS [10]         ##
##                                                                  ##
######################################################################

sub new_null_vbox {
    my @nodes = @_;

    my $box = TeX::Node::VListNode->new();

    for my $node (@nodes) {
        $box->push_node($node);
    }

    return $box;
}

sub new_rule {
    my $width  = shift;
    my $height = shift;
    my $depth  = shift;

    return TeX::Node::RuleNode->new({ width  => $width,
                                      height => $height,
                                      depth  => $depth });
}

sub new_math {
    my $subtype = shift;
    my $width = shift;

    return TeX::Node::MathNode->new({ subtype => $subtype, width => $width });
}

sub new_glue {
    my $arg_hash = shift;

    return TeX::Node::GlueNode->new($arg_hash);
}

sub new_kern {
    my $width = shift;
    my $subtype = shift || normal;

    return TeX::Node::KernNode->new({ width => $width, subtype => $subtype });
}

sub new_penalty {
    my $penalty = shift;

    return TeX::Node::PenaltyNode->new({ penalty => $penalty });
}

######################################################################
##                                                                  ##
##                         EXTENSIONS [53]                          ##
##                                                                  ##
######################################################################

sub new_whatsit {
    my $arg_hash = shift;

    return TeX::Node::WhatsitNode->new($arg_hash);
}

sub new_glyph_node {
    my $arg_hash = shift;

    return TeX::Node::GlyphNode->new($arg_hash);
}

sub new_write_node {
    my $arg_hash = shift;

    return TeX::Node::WriteNode->new($arg_hash);
}

######################################################################
##                                                                  ##
##                              EXTRA                               ##
##                                                                  ##
######################################################################

sub new_open_node {
    my $arg_hash = shift;

    return TeX::Node::OpenNode->new($arg_hash);
}

sub new_close_node {
    my $arg_hash = shift;

    return TeX::Node::CloseNode->new($arg_hash);
}

sub new_special_node {
    my $arg_hash = shift;

    return TeX::Node::SpecialNode->new($arg_hash);
}

sub new_language_node {
    my $lang_no = shift;

    return TeX::Node::LanguageNode->new({ language => $lang_no} );
}

######################################################################
##                                                                  ##
##                               XML                                ##
##                                                                  ##
######################################################################

sub new_xml_open_node {
    my $qName = shift;
    my $atts  = shift || {};
    my $props = shift;

    return TeX::Node::XmlOpenNode->new({ qName => $qName,
                                         attribute => $atts,
                                         property  => $props,
                                       });
}

sub new_xml_close_node {
    my $qName = shift;

    return TeX::Node::XmlCloseNode->new({ qName => $qName });
}

sub new_xml_attribute_node {
    my $qName = shift;
    my $value = shift;

    return TeX::Node::XmlAttributeNode->new({ qName => $qName,
                                              value => $value,
                                            });
}

sub new_xml_class_node {
    my $opcode = shift;
    my $value  = shift;

    return TeX::Node::XmlClassNode->new({ opcode => $opcode,
                                          value  => $value,
                                        });
}

sub new_css_property_node {
    my $property = shift;
    my $value    = shift;

    return TeX::Node::XmlCSSpropNode->new({ property => $property,
                                            value  => $value,
                                          });
}

sub new_end_u_template_node {
    my $property = shift;
    my $value    = shift;

    return TeX::Node::UTemplateMarker->new();
}

######################################################################
##                                                                  ##
##                          DEPRECATED (?)                          ##
##                                                                  ##
######################################################################

# These are referenced in TeX::FMT::Mem, but are probably not really
# needed.

sub new_unset {
    my $arg_hash = shift;

    return TeX::Node::UnsetNode->new($arg_hash);
}

sub new_ins {
    my $arg_hash = shift;

    return TeX::Node::InsertNode->new($arg_hash);
}

sub new_mark {
    my $arg_hash = shift;

    return TeX::Node::MarkNode->new($arg_hash);
}

sub new_adjust {
    my $arg_hash = shift;

    return TeX::Node::AdjustNode->new($arg_hash);
}

sub new_disc {
    my $arg_hash = shift;

    return TeX::Node::DiscNode->new($arg_hash);
}

sub new_ligature {
    my $arg_hash = shift;

    return TeX::Node::LigatureNode->new($arg_hash);
}

1;

__END__
