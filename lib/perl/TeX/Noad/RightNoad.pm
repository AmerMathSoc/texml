package TeX::Noad::RightNoad;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractNoad);

use TeX::Class;

use TeX::WEB2C qw(:math_params);

my %mathchar_of :ATTR(:get<mathchar> :set<mathchar>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_class(right_noad);

    return;
}

1;

__END__
