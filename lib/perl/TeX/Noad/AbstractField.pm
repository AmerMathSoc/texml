package TeX::Noad::AbstractField;

use strict;
use warnings;

use Carp;

use TeX::Class;

use TeX::WEB2C qw(:math_params :extras);

sub is_empty {
    return 0;
}

sub is_math_char {
    return 0;
}

sub is_math_text_char {
    return 0;
}

sub is_sub_box {
    return 0;
}

sub is_sub_mlist {
    return 0;
}

sub to_hlist {
    my $self = shift;

    my $engine = shift;

    croak "Method to_hlist not implemented for ", ref($self);

    return;
}

sub to_clean_box {
    my $self = shift;

    my $engine = shift;

    croak "Method to_clean_box not implemented for ", ref($self);

    return;
}

1;

__END__
