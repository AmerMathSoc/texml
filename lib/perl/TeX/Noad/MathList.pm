package TeX::Noad::MathList;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

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
