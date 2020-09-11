package TeX::Primitive::openin;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $fileno = $tex->scan_four_bit_int();

    $tex->closein($fileno);

    $tex->scan_optional_equals();

    my $file_name = $tex->scan_file_name();

    $tex->openin($fileno, $file_name);

    return;
}

1;

__END__
