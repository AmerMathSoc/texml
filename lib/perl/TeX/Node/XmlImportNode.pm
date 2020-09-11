package TeX::Node::XmlImportNode;

use strict;
use warnings;

use base qw(TeX::Node::XmlNode);

use TeX::Class;

use TeX::Utils::Misc;

my %xml_file_of :ATTR(:name<xml_file>);
my %xpath_of    :ATTR(:name<xpath>);

use overload q{""}  => \&to_string;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_qName("xml_import");

    return;
}

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();
    my $namespace = 'texml';

    my $string = "$qName";

    if (nonempty($namespace)) {
        $string = "${namespace}:$string";
    }

    my $xml_file = $self->get_xml_file();
    my $xpath    = $self->get_xpath();

    return "<$string file='$xml_file' xpath='$xpath'/>";
}

1;

__END__
