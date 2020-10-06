package TeX::Command::Executable::Readable;

use strict;
use warnings;

use Carp;

use base qw(TeX::Command::Executable);

use TeX::Class;

my %value_of :ATTR(:name<value> :default<0>);
my %level_of :ATTR(:name<level> :default<-1>);

sub read_value {
    my $self = shift;
    my $engine = shift;

    return $self->get_value();
}

1;

__END__
