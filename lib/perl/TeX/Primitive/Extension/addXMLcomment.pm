package TeX::Primitive::Extension::addXMLcomment;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $comment = $tex->read_undelimited_parameter(EXPANDED);

    $tex->add_xml_comment($comment);

    return;
}

1;

__END__
