package TeX::Primitive::Extension::setXMLdoctype;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

sub execute {
    my $self = shift;
 
    my $tex     = shift;
    my $cur_tok = shift;

    my $public_id = $tex->read_undelimited_parameter(EXPANDED);
    my $system_id = $tex->read_undelimited_parameter(EXPANDED);

    $tex->set_xml_public_id($public_id);
    $tex->set_xml_system_id($system_id);

    return;
}

1;

__END__
