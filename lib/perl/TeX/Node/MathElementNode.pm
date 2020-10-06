package TeX::Node::MathElementNode;

use strict;
use warnings;

use TeX::Class;

my %inline_of :BOOLEAN(:name<inline>);
my %inner_tag_of :ATTR(:name<inner_tag>);

1;

__END__
