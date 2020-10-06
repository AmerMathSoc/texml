package TeX::Node::XmlNode;

use strict;
use warnings;

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

my %qName_of :ATTR(:name<qName>);

use overload q{eq}  => \&xml_node_eq;

sub xml_node_eq {
    my $self = shift;

    my $other = shift;

    if (! defined $other) {
        croak("Can't compare a " . __PACKAGE__ . " to an undefined value");
    }

    ## Force stringification of both arguments.

    return "$self" eq "$other";
}

1;

__END__
