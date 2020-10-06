package TeX::Primitive::Extension::startXMLelement;

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

    # if ($tex->is_vmode()) {
    #     $tex->new_graf();
    # }

    $tex->start_xml_element($qName);

    return;
}

1;

__END__
