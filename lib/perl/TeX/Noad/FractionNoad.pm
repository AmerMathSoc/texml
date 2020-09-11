package TeX::Noad::FractionNoad;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractNoad);

use TeX::Class;

use TeX::WEB2C qw(:math_params);

my %complete_of :ATTR(:default(0));

my %thickness_of   :ATTR(:set<thickness>   :get<thickness>);
my %numerator_of   :ATTR(:set<numerator>   :get<numerator>);
my %denominator_of :ATTR(:set<denominator> :get<denominator>);
my %left_delim_of  :ATTR(:set<left_delim>  :get<left_delim>);
my %right_delim_of :ATTR(:set<right_delim> :get<right_delim>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_class(fraction_noad);

    $numerator_of{$ident}   = $arg_ref->{numerator};
    $denominator_of{$ident} = $arg_ref->{denominator};

    return;
}

sub get_spacing_class {
    my $self = shift;

    return inner_noad - ord_noad;
}

sub mark_completed {
    my $self = shift;

    $complete_of{ident $self} = 1;

    return;
}

sub is_incomplete {
    my $self = shift;

    return ! $complete_of{ident $self};
}

1;

__END__
