package TeX::Node::XmlOpenNode;

use strict;
use warnings;

use base qw(TeX::Node::XmlNode);

use TeX::Class;

use TeX::Utils::Misc;

my %namespace_of  :ATTR(:name<namespace>);
my %attributes_of :HASH(:name<attribute>);

use overload q{""}  => \&to_string;

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();

    my $string = "$qName";

    my $namespace = trim($self->get_namespace());

    if (nonempty($namespace)) {
        $string = "${namespace}:$string";
    }

    while (my ($key, $val) = each %{ $attributes_of{ident $self} }) {
        $string .= qq{ $key="$val"};
    }

    return "<$string>";
}

1;

__END__
