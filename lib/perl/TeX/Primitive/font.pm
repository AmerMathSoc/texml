package TeX::Primitive::font;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    $tex->new_font($modifier);

    return;
}

1;

__END__
