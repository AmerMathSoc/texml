package TeX::Primitive::eTeX::currentgrouptype;

use strict;
use warnings;

use base qw(TeX::Primitive::LastItem);

use TeX::Class;

use TeX::WEB2C qw(:command_codes);

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    return $tex->cur_group();
}

1;

__END__
