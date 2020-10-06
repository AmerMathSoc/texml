package TeX::Primitive::Prefix;

use strict;
use warnings;

use base qw(TeX::Command::Prefixed);

use TeX::Class;

my %mask_of :ATTR(:name<mask>);

## These are never executed directly.  They are handled by
## main_control() and prefixed_command().

1;

__END__
