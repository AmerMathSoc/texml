package TeX::Primitive::Extension::fontencoding;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Readable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $new_encoding = $tex->read_undelimited_parameter();

    $tex->set_encoding($new_encoding);

    return;
}

sub read_value {
    my $self = shift;

    my $tex = shift;

    return $tex->get_encoding();
}

1;

__END__
