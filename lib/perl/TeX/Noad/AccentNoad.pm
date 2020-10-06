package TeX::Noad::AccentNoad;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractNoad);

use TeX::Class;

use TeX::WEB2C qw(:math_params);

my %accent_of :ATTR(:get<accent> :set<accent>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_class(accent_noad);

    $accent_of{$ident} = $arg_ref->{accent};

    return;
}

1;

__END__
