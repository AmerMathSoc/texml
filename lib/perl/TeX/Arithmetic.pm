package TeX::Arithmetic;

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

use version; our $VERSION = qv '1.3.0';

use integer;

use Carp;

use base qw(Exporter);

our %EXPORT_TAGS;

$EXPORT_TAGS{arithmetic} = [ qw(half
                                round_decimals
                                mult_and_add
                                nx_plus_y
                                mult_integers
                                x_over_n
                                xn_over_d
                                badness
                                unity
                             ) ];

$EXPORT_TAGS{string} = [ qw(glue_to_string
                            glue_set_to_string
                            glue_order_to_string
                            rule_dimen_to_string
                            scaled_to_string
                            sprint_scaled
                            sprint_spec
                            sprint_glue
) ];

$EXPORT_TAGS{all} = [ @{ $EXPORT_TAGS{arithmetic} },
                      @{ $EXPORT_TAGS{string} } ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT;

use TeX::WEB2C qw(:node_params :penalties);

######################################################################
##                                                                  ##
##              ARITHMETIC WITH SCALED DIMENSIONS [7]               ##
##                                                                  ##
######################################################################

use constant unity => 2**16;
use constant two   => 2**17;

sub half( $ ) {
    my $n = shift;

    if ($n % 2 == 1) {
        return ($n + 1)/2;
    } else {
        return $n/2;
    }
}

sub round_decimals(@) {
    my @digs = @_;

    my $a = 0;

    for my $dig (reverse @digs) {
        $a = ($a + $dig * two) / 10;
    }

    return ($a + 1) / 2;
}

sub mult_and_add($$$$) { # nx + y
    my $n = shift;
    my $x = shift;
    my $y = shift;
    my $max = shift;

    if ($n < 0) {
        $x = -$x;
        $n = -$n;
    }

    if ($n == 0) {
        return $y;
    } elsif ( ($ x <= ($max - $y) / $n) && (-$x <= ($max + $y) / $n) ) {
        return $n * $x + $y;
    } else {
        croak "Arithmetic overflow exception";
    }
}

sub nx_plus_y( $$$ ) {
    my $n = shift;
    my $x = shift;
    my $y = shift;

    return mult_and_add($n, $x, $y, 07777777777);
}

sub mult_integers( $$ ) {
    my $n = shift;
    my $x = shift;

    return mult_and_add($n, $x, 0, 017777777777);
}

sub x_over_n($$) {
    my $x = shift;
    my $n = shift;

    use integer;

    my $negative = 0;

    my $x_over_n;
    my $remainder;

    if ($n == 0) {
        croak "Arithmetic exception: Can't divide by 0";
    } else {
        if ($n < 0) {
            $x = -$x;
            $n = $n;
            $negative = 1;
        }

        if ($x >= 0) {
            $x_over_n  = $x / $n;
            $remainder = $x % $n;
        } else {
            $x_over_n  = -((-$x) / $n);
            $remainder = -((-$x) % $n);
        }
    }

    if ($negative) {
        $remainder = -$remainder;
    }

    return wantarray ? ($x_over_n, $remainder) : $x_over_n;
}

sub xn_over_d( $$$ ) {
    my $x = shift; # scaled; 
    my $n = shift; # integer
    my $d = shift; # integer

    my $positive = ($x >= 0);

    if (! $positive) {
        $x = -$x;
    }

    my $t = ($x % 0100000) * $n;
    my $u = ($x / 0100000) * $n + ($t / 0100000);
    my $v = ($u % $d) * 0100000 + ($t % 0100000);

    if ($u/$d >= 0100000) {
        croak "Arithmetic overflow";
    } else {
        $u = 0100000 * ($u/$d) + ($v/$d);
    }

    my ($xn_over_d, $remainder);

    if ($positive) {
        $xn_over_d = $u;
        $remainder = $v % $d;
    } else {
        $xn_over_d = -$u;
        $remainder = -($v % $d);
    }

    return wantarray ? ($xn_over_d, $remainder) : $xn_over_d;
}

sub badness($$) {
    my $t = shift; # scaled
    my $s = shift; # scaled

    if ($t == 0) {
        return  0
    }

    if ($s <= 0) {
        return inf_bad;
    }

    my $r = $t;

    if ($t <= 7230584) {
        $r = ($t * 297) / $s;    # 297^3 = 99.94 \times 2^{18}
    } elsif ($s >= 1663497) {
        $r = $t / ($s / 297);
    }

    if ($r > 1290) {
        return inf_bad;          # 1290^3 < 2^{31} < 1291^3
    } else {
        return ($r * $r * $r + 0400000) / 01000000;
    }
}

######################################################################
##                                                                  ##
##                        DISPLAYING VALUES                         ##
##                                                                  ##
######################################################################

## This implements tex.web's print_scaled, but returns a string rather
## than printing the result directly.

sub sprint_scaled( $ ) {
    my $s = shift;

    use integer;

    my $string = "";

    my $delta;

    if ($s < 0) {
        $string .= "-";
        $s = -$s;
    }

    $string .= $s/unity; # {print the integer part}
    $string .= ".";

    $s = 10 * ($s % unity) + 5;
    $delta = 10;

    do {
        if ($delta > unity) {
            $s = $s + 0100000 - 50000; # {round the last digit}
        }

        $string .= $s/unity;

        $s = 10 * ($s % unity);
        $delta *= 10;
    } until $s <= $delta;

    return $string;
}

## scaled_to_string() is deprecated.

sub scaled_to_string( $ ) {
    my $scaled = shift;

    return sprint_scaled($scaled);
}

sub sprint_glue( $$$ ) {
    my $scaled = shift;
    my $order  = shift;
    my $units  = shift;

    my $string = sprint_scaled($scaled);

    if ( $order < normal || $order > filll ) {
        $string .= "foul";
    } elsif ($order > normal) {
        $string .= "fil";

        while ($order > fil) {
            $string .= "l";
            $order--;
        }
    } elsif (defined $units) {
        $string .= $units;
    }

    return $string;
}

## Like print_spec, but returns a string.

sub sprint_spec( $;$ ) {
    my $glue  = shift;
    my $units = shift;

    my $string = sprint_scaled($glue->get_width());

    $string .= $units if defined $units;

    if (my $stretch = $glue->get_stretch()) {
        $string .= " plus ";
        $string .= sprint_glue($stretch, $glue->get_stretch_order(), $units);
    }

    if (my $shrink = $glue->get_shrink()) {
        $string .= " minus ";
        $string .= sprint_glue($shrink, $glue->get_shrink_order(), $units);
    }

    return $string;
}

######################################################################
##                                                                  ##
##                       DISPLAYING BOXES [12]                      ##
##                                                                  ##
######################################################################

sub rule_dimen_to_string( $ ) {
    my $d = shift;

    if ($d == null_flag) {
        return '*';
    } 

    return sprint_scaled($d);
}

sub glue_to_string( $$ ) {
    my $scaled = shift;

    my $order  = shift || normal;

    my $string = sprint_scaled($scaled);

    $string .= glue_order_to_string($order);

    return $string;
}

sub glue_set_to_string( $$ ) {
    my $glue_ratio = shift;

    my $order  = shift || normal;

    my $scaled = eval { no integer; unity * $glue_ratio };

    return glue_to_string($scaled, $order);
}

sub glue_order_to_string( $ ) {
    my $o = shift;

    return "" unless $o > 0;

    return 'fi' . 'l' x $o;
}

1;

__END__
