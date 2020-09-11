package TeX::Primitive::Extension::setXMLattribute;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $qName = $tex->read_undelimited_parameter(EXPANDED);
    my $value = $tex->read_undelimited_parameter(EXPANDED);

    $tex->set_xml_attribute($qName, $value);

    return;
}

1;

__END__
