package TeX::Node::XmlAttributeNode;

use strict;
use warnings;

use base qw(TeX::Node::XmlNode);

use TeX::Class;

my %value_of :ATTR(:name<value>);

use overload q{""}  => \&to_string;

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();
    my $value = $self->get_value();

    return qq{$qName="$value"};
}

1;

__END__
