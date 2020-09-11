package TeX::Node::MathCloseNode;

use strict;
use warnings;

use base qw(TeX::Node::XmlCloseNode TeX::Node::MathElementNode);

use overload q{""} => \&to_string;

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();

    if (defined $qName && $qName =~ m{\S}) {
        return qq{</$qName>};
    }

    return "";
}

1;

__END__
