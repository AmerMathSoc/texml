package TeX::Node::XmlComment;

use strict;
use warnings;

use base qw(TeX::Node::XmlNode);

use TeX::Class;

my %comment_of :ATTR(:name<comment>);

use overload q{""}  => \&to_string;

sub to_string {
    my $self = shift;

    my $comment = $self->get_comment();

    return qq{<!-- $comment -->};
}

1;

__END__
