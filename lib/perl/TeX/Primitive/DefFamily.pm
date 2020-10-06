package TeX::Primitive::DefFamily;

use strict;
use warnings;

use base qw(TeX::Command);

use TeX::Class;

# One of text_size, script_size, script_script_size

my %size_of :ATTR(:name<size> :default<-1>);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    return;
}

1;

__END__
