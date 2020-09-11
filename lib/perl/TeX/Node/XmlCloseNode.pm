package TeX::Node::XmlCloseNode;

use strict;
use warnings;

use base qw(TeX::Node::XmlNode);

use TeX::Class;

use overload q{""}  => \&to_string;

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();

    return "</$qName>";
}

1;

__END__
