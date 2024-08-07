package TeX::Primitive::parshape;

# Copyright (C) 2022, 2024 American Mathematical Society
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

use base qw(TeX::Primitive::Parameter Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_parshape_parameter) ] );

our @EXPORT_OK = @{ $EXPORT_TAGS{factories} };

our @EXPORT;

use TeX::Constants qw(:scan_types);

use TeX::Class;

sub make_parshape_parameter {
    my $name     = shift;
    my $eqvt_ptr = shift;

    return __PACKAGE__->new({ level    => int_val,
                              eqvt_ptr => $eqvt_ptr,
                              name     => $name });
}

sub scan_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->scan_optional_equals();

    my $n = $tex->scan_int();

    my @values;

    for (1..(2 * $n)) {
        push @values, scalar $tex->scan_normal_dimen();
    }

    return \@values;
}

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $eqvt_ptr = $self->get_eqvt_ptr();

    return @{ ${ $eqvt_ptr }->get_equiv()->get_value() } / 2;
}

1;

__END__
