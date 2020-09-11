package TeX::Output::HTML;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.2';

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
