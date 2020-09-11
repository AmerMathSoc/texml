package TeX::Primitive::Extension::setXMLroot;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

sub execute {
    my $self = shift;
 
    my $tex     = shift;
    my $cur_tok = shift;

    my $root = $tex->read_undelimited_parameter(EXPANDED);

    $tex->set_xml_doc_root($root);

    return;
}

1;

__END__
