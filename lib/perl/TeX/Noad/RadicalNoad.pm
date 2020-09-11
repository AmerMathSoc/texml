package TeX::Noad::RadicalNoad;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractNoad);

use TeX::Class;

use TeX::WEB2C qw(:math_params);

my %mathchar_of :ATTR(:set<mathchar> :get<matchar>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_class(radical_noad);

    return;
}

1;

__END__
