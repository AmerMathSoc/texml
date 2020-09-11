package TeX::Primitive::eTeX::firstmarks;

use strict;
use warnings;

use base qw(TeX::Primitive::TopBotMark);

use TeX::Class;

use TeX::WEB2C qw(:mark_codes);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_mark_code(first_mark_code + marks_code);

    return;
}

1;

__END__
