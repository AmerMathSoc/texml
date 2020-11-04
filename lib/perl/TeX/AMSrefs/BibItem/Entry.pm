package TeX::AMSrefs::BibItem::Entry;

use strict;
use warnings;

use PTG::Class;

use PTG::Utils;

use overload (
    q{""}   => 'to_string',
    q{bool} => 'to_boolean',
);

my %key_of   :ATTR(init_arg => 'key'   :set<key>   :get<key>);
my %value_of :ATTR(init_arg => 'value' :set<value> :get<value>);

my %attributes_of :ATTR;

# sub BUILD {
#     my ($self, $ident, $arg_ref) = @_;
# }

sub set_attribute {
    my $self = shift;

    my $key   = shift;
    my $value = shift;

    return $attributes_of{ident $self}->{$key} = $value;
}

sub get_attribute {
    my $self = shift;

    my $key = shift;

    return unless defined $attributes_of{ident $self};

    return $attributes_of{ident $self}->{$key};
}

sub get_all_attributes {
    my $self = shift;

    my $key = shift;

    return unless defined $attributes_of{ident $self};

    return %{ $attributes_of{ident $self} };
}

sub to_string : STRINGIFY {
    my $self = shift;

    return $value_of{ident $self};
}

sub to_boolean : BOOLIFY {
    my $self = shift;

    return nonempty $value_of{ident $self};
}

1;

__END__
