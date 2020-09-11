package TeX::Primitive::Extension::setXMLclass;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

use TeX::Node::XmlClassNode qw(:constants);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $value = $tex->read_undelimited_parameter(EXPANDED);

    $tex->modify_xml_class($value, XML_SET_CLASSES);

    return;
}

1;

__END__
