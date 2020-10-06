package TeX::Output;

use strict;
use warnings;

use Carp;

use TeX::Class;

use Class::Multimethods;

my %fh_of :ATTR(:get<fh> :set<fh>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    if (defined $arg_ref->{fh}) {
        $fh_of{$ident} = $arg_ref->{fh};
    } else {
        $fh_of{$ident} = \*STDOUT;
    }

    return;
}

sub reset {
    my $self = shift;

    return;
}

sub output {
    my $self = shift;

    my $string = shift;

    print { $fh_of{ident $self} } $string;

    return;
}

sub write_header {
    my $self = shift;

    return;
}

sub write_trailer {
    my $self = shift;

    return;
}

multimethod translate
    => __PACKAGE__, qw(*)
    => sub {
        my $translator = shift;
        my $string = shift;

        return $string;
};

1;

__END__
