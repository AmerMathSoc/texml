package TeX::Utils::XML;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(xml_to_utf8_string) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT =  ( @{ $EXPORT_TAGS{all} } );

use XML::LibXML qw(:libxml);

use TeX::Utils::Misc qw(nonempty);

use PTG::Unicode::Translators qw(tex_math_to_unicode);

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
