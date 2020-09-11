package TeX::Node::XmlClassNode;

use strict;
use warnings;

use base qw(TeX::Node::XmlAttributeNode Exporter);

use TeX::Class;

my %opcode_of :ATTR(:name<opcode>);

our %EXPORT_TAGS = (constants => [ qw(XML_SET_CLASSES
                                      XML_ADD_CLASS
                                      XML_DELETE_CLASS) ]);

our @EXPORT_OK = @{ $EXPORT_TAGS{constants} };

our @EXPORT;

use constant {
    XML_SET_CLASSES  => 1,
    XML_ADD_CLASS    => 2,
    XML_DELETE_CLASS => 3,
};

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_qName("class");
}

1;

__END__
