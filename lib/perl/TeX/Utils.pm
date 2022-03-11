package TeX::Utils;

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

use version; our $VERSION = qv '2.2.2';

use Carp;

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(
    int_as_hex
    int_as_roman
    is_hex
    norm_min
    min
    odd
    print_char_code
) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

use IO::Handle;

sub min( $$ ) {
    my $a = shift;
    my $b = shift;

    return $a < $b ? $a : $b;
}

sub odd( $ ) {
    my $integer = shift;

    return $integer % 2;
}

sub is_hex( $ ) {
    my $char = shift;

    ## Case sensitive!!

    return $char =~ m/[0-9a-z]/;
}

######################################################################
##                                                                  ##
##                       STRING HANDLING [4]                        ##
##                                                                  ##
######################################################################

## Cf. @<Make the first 256 strings@>;

sub print_char_code( $ ) {
    my $char_code = shift;

    if ($char_code >= 32 && $char_code < 127) {
        return chr($char_code);
    }

    if ($char_code < 64) {
        return sprintf "^^%c", $char_code + 64;
    }

    if ($char_code < 128) {
        return sprintf "^^%c", $char_code - 64;
    }

    return sprintf "^^%02x", $char_code;
}

######################################################################
##                                                                  ##
##                ON-LINE AND OFF-LINE PRINTING [5]                 ##
##                                                                  ##
######################################################################

sub int_as_hex( $ ) {
    my $n = shift;

    return sprintf '"%X', $n;
}

sub int_as_roman {
    my $n = shift;

    my @str_pool = qw(m 2 d 5 c 2 l 5 x 2 v 5 i);

    my $j = 0;

    my $v = 1000;

    my $roman = "";

    while(1) {
        while ($n >= $v) {
            $roman .= $str_pool[$j];

            $n -= $v;
        }

        last if $n <= 0;

        my $k = $j + 2;

        my $u = $v / $str_pool[$k - 1];

        if ($str_pool[$k - 1] == 2) {
            $k += 2;

            $u = $u / $str_pool[$k - 1];
        }

        if ($n + $u >= $v) {
            $roman .= $str_pool[$k];

            $n += $u;
        } else {
            $j += 2;

            $v = $v / $str_pool[$j - 1]
        }        
    }

    return $roman;
}

######################################################################
##                                                                  ##
##                  BUILDING BOXES AND LISTS [47]                   ##
##                                                                  ##
######################################################################

sub norm_min {
    my $h = shift;

    if ($h <= 0) {
        $h = 1;
    } elsif ($h >= 63) {
        $h = 63;
    }

    return $h;
}

1;

__END__
