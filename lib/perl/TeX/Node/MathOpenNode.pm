package TeX::Node::MathOpenNode;

use strict;
use warnings;

use base qw(TeX::Node::XmlOpenNode TeX::Node::MathElementNode);

use TeX::Class;

use overload q{""} => \&to_string;

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();

    if (defined $qName && $qName =~ m{\S}) {
        return qq{<$qName>};
    }

    return "";
}

1;

__END__
