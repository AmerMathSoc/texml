package TeX::Type::GlueSpec;

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

use base qw(Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_glue_spec) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT;

use UNIVERSAL;

use TeX::Constants qw(:node_params);

use TeX::Arithmetic qw(:arithmetic);

use TeX::Class;

my %width_of         :ATTR(:name<width>         :default<0>);

my %stretch_of       :ATTR(:name<stretch>       :default<0>);
my %stretch_order_of :ATTR(:name<stretch_order> :default<normal>);

my %shrink_of        :ATTR(:name<shrink>        :default<0>);
my %shrink_order_of  :ATTR(:name<shrink_order>  :default<normal>);

use overload
    '+' => \&glue_add,
    '-' => \&glue_subtract,
    '*' => \&glue_multiply,
    '/' => \&glue_divide;

sub make_glue_spec( $$$ ) {
    my $width   = shift;
    my $stretch = shift;
    my $shrink  = shift;

    my $stretch_order = normal;
    my $shrink_order  = normal;

    if (UNIVERSAL::isa($stretch, 'ARRAY')) {
        ($stretch, $stretch_order) = @{ $stretch };
    }

    if (UNIVERSAL::isa($shrink, 'ARRAY')) {
        ($shrink, $shrink_order) = @{ $shrink };
    }

    return __PACKAGE__->new({ width         => $width,
                              stretch       => $stretch,
                              stretch_order => $stretch_order,
                              shrink        => $shrink,
                              shrink_order  => $shrink_order,
                            });
}

sub glue_add {
    my $a = shift;

    my $b = shift;

    my $sum = $a->clone();

    my $ident_sum = ident $sum;

    $width_of{$ident_sum} += $b->get_width();

    if ($sum->get_stretch() == 0) {
        $sum->set_stretch_order(normal);
    }

    my $a_stretch_order = $a->get_stretch_order();
    my $b_stretch_order = $b->get_stretch_order();

    if ($a_stretch_order == $b_stretch_order) {
        $stretch_of{$ident_sum} += $b->get_stretch();
    } elsif ( $a_stretch_order < $b_stretch_order && $b->get_stretch() != 0 ) {
        $sum->set_stretch($b->get_stretch());
        $sum->set_stretch_order($b_stretch_order);
    }

    my $a_shrink_order = $a->get_shrink_order();
    my $b_shrink_order = $b->get_shrink_order();

    if ($a_shrink_order == $b_shrink_order) {
        $shrink_of{$ident_sum} += $b->get_shrink();
    } elsif ( $a_shrink_order < $b_shrink_order && $b->get_shrink() != 0 ) {
        $sum->set_shrink($b->get_shrink());
        $sum->set_shrink_order($b_shrink_order);
    }

    return $sum;
}

sub glue_subtract {
    my $a = shift;

    my $b = shift;

    my $sum = $a->clone();

    my $ident_sum = ident $sum;

    $width_of{$ident_sum} -= $b->get_width();

    if ($sum->get_stretch() == 0) {
        $sum->set_stretch_order(normal);
    }

    my $a_stretch_order = $a->get_stretch_order();
    my $b_stretch_order = $b->get_stretch_order();

    if ($a_stretch_order == $b_stretch_order) {
        $stretch_of{$ident_sum} -= $b->get_stretch();
    } elsif ( $a_stretch_order < $b_stretch_order && $b->get_stretch() != 0 ) {
        $sum->set_stretch($b->get_stretch());
        $sum->set_stretch_order($b_stretch_order);
    }

    my $a_shrink_order = $a->get_shrink_order();
    my $b_shrink_order = $b->get_shrink_order();

    if ($a_shrink_order == $b_shrink_order) {
        $shrink_of{$ident_sum} -= $b->get_shrink();
    } elsif ( $a_shrink_order < $b_shrink_order && $b->get_shrink() != 0 ) {
        $sum->set_shrink($b->get_shrink());
        $sum->set_shrink_order($b_shrink_order);
    }

    return $sum;
}

sub glue_multiply {
    my $glue = shift;

    my $n = shift;

    my $width   = nx_plus_y($glue->get_width(),   $n, 0);
    my $stretch = nx_plus_y($glue->get_stretch(), $n, 0);
    my $shrink  = nx_plus_y($glue->get_shrink(),  $n, 0);

    return __PACKAGE__->new({ width   => $width,
                              stretch => $stretch,
                              stretch_order => $glue->get_stretch_order(),
                              shrink  => $shrink,
                              shrink_order => $glue->get_shrink_order(),
                            });
}

sub glue_divide {
    my $glue = shift;

    my $n = shift;

    my $width   = x_over_n($glue->get_width(),   $n);
    my $stretch = x_over_n($glue->get_stretch(), $n);
    my $shrink  = x_over_n($glue->get_shrink(),  $n);

    return __PACKAGE__->new({ width   => $width,
                              stretch => $stretch,
                              stretch_order => $glue->get_stretch_order(),
                              shrink  => $shrink,
                              shrink_order => $glue->get_shrink_order(),
                            });
}

sub to_string :STRINGIFY {
    my $self = shift;

    my $width = $self->get_width();

    my $stretch = $self->get_stretch();
    my $stretch_order = $self->get_stretch_order();

    my $shrink = $self->get_shrink();
    my $shrink_order = $self->get_shrink_order();

    return "$width plus $stretch ($stretch_order) minus $shrink ($shrink_order)";
}

1;

__END__
