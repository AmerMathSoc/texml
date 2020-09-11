package TeX::Noad::MathList;

use TeX::Nodes qw(:factories);

use TeX::Class;

my %noads_of :ATTR;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $noads_of{$ident} = [];

    return;
}

sub add_noad {
    my $self = shift;
    my $noad = shift;

    push @{ $noads_of{ident $self} }, $noad;

    return;
}

sub add_noads {
    my $self  = shift;
    my @noads = @_;

    push @{ $noads_of{ident $self} }, @noads;

    return;
}

sub get_noads {
    my $self = shift;

    my $list_r = $noads_of{ident $self};

    return wantarray ? @{ $list_r } : $list_r;
}

sub get_head {
    my $self = shift;

    return $noads_of{ident $self}->[0];
}

sub get_tail {
    my $self = shift;

    my @noads = $self->get_noads();

    shift @noads;

    return @noads;
}

sub get_noad {
    my $self = shift;
    my $n    = shift;

    return $noads_of{ident $self}->[$n];
}

sub get_last_noad {
    my $self = shift;

    return $noads_of{ident $self}->[-1];
}

sub length {
    my $self = shift;

    return scalar @{ $noads_of{ident $self} };
}

1;

__END__
