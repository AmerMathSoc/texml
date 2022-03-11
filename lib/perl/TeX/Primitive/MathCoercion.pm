package TeX::Primitive::MathCoercion;

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

use base qw(TeX::Command::Executable Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_coercion) ] );

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ();

use TeX::Noads;

use TeX::Class;

my %class :ATTR(:get<class> :set<class> :init_arg => "class");

sub make_coercion($$) {
    my $name  = shift;
    my $class = shift;

    return __PACKAGE__->new({ name => $name, class => $class });
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $mlist = $self->read_math_sublist();

    if (! defined $mlist) {
        die "Missing argument for \\", $self->get_name(), "\n";
    }

    $tex->add_noad(make_noad($self->get_class(), $mlist));

    return;
}

1;

__END__
