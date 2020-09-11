package TeX::Utils;

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
