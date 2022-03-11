package TeX::Output::HTML;

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

use base qw(TeX::Output::XHTML);

use TeX::Class;

use TeX::Utils::Misc;

use XML::LibXML;

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub open_document {
    my $self = shift;

    my $filename = shift;  ## Dummy argument for this class.

    my $tex = $self->get_tex_engine();

    my $dom = XML::LibXML::Document->createDocument("1.0", "UTF-8");

    $self->set_dom($dom);

    my $xml_root = $tex->get_xml_doc_root();

    $dom->createInternalSubset($xml_root, "", "");

    my $root_node = $dom->createElement($xml_root);

    $dom->setDocumentElement($root_node);

    my $head = $dom->createElement("head");
    my $body = $dom->createElement("body");

    $root_node->appendChild($head);
    $root_node->appendChild($body);

    $self->set_head($head);
    $self->set_body($body);

    $self->set_current_element($body);

    if ($tex->use_mathjax()) {
        $self->__include_mathjax();
    }
    return;
}

sub close_document {
    my $self = shift;

    my $tex = $self->get_tex_engine();

    my %css_classes = %{ $tex->get_css_classes };

    if (%css_classes) {
        my $dom = $self->get_dom();

        my $style = $dom->createElement("style");

        $style->setAttribute(type => "text/css");

        while (my ($selector, $body) = each %css_classes) {
            $style->appendText(qq{\n$selector { $body }});
        }

        $style->appendText(qq{\n});

        $self->append_to_head($style);
    }

    my $output_file_name = $tex->get_output_file_name();

    if (nonempty($output_file_name)) {
        my $dom = $self->get_dom();

        open(my $fh, ">", $output_file_name);
        
        print { $fh } $dom->serialize_html();
        
        close($fh);
    }

    return;
}

1;

__END__
