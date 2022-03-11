package TeX::Output;

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
