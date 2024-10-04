package TeX::Unicode;

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

use version; our $VERSION = qv '2.0.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(
    ascii_base
    base_characters
    decompose
) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT;

use TeX::Utils::Misc;

use Unicode::UCD qw(charinfo);

######################################################################
##                                                                  ##
##                     INTERNAL IMPLEMENTATION                      ##
##                                                                  ##
######################################################################

sub __decompose( $ ) {
    my $char = shift;

    my @decomposition;

    my @partial = (sprintf "%04X", ord($char));

    while (@partial) {
        my $first = shift @partial;

        ## Prepend "U+" to keep Unicode::UCD::_getcode() from
        ## interpreting a sequence of decimal digits as a decimal
        ## integer instead of a hexadecimal integer.

        my $charinfo = charinfo("U+$first");

        my $decomposition = $charinfo->{decomposition};

        if (nonempty($decomposition) && $decomposition =~ s{<(\w+)>\s+}{}smx) {
            my $type = $1;

            if ($type ne 'fraction' && $type ne 'compat') {
                undef $decomposition;
            }
        }

        if (empty($decomposition)) {
            push @decomposition, $first;

            next;
        }

        unshift @partial, split / /, $decomposition;
    }

    return map { chr(hex($_)) } @decomposition;
}

DECOMPOSE: {
    my %DECOMPOSITION;

    sub decompose( $ ) {
        my $char = shift;

        if (! exists $DECOMPOSITION{$char}) {
            $DECOMPOSITION{$char} = [ __decompose($char) ];
        }

        return @{ $DECOMPOSITION{$char} };
    }
}

sub __base_characters( $ ) {
    my $char = shift;

    my @base;

    my @decomposition = decompose($char);

    for my $piece (@decomposition) {
        if ($piece =~ /\P{Mark}/) {
            push @base, $piece;
        }
    }

    return concat(@base);
}

BASE_CHARACTERS: {
    my %BASE;

    sub base_characters( $ ) {
        my $char = shift;

        if (! exists $BASE{$char}) {
            $BASE{$char} = __base_characters($char);
        }

        return $BASE{$char};
    }
}

sub __ascii_base( $ ) {
    my $char = shift;

    my @ascii;

    for my $base (base_characters($char)) {
        if (ord($base) < 128) {
            push @ascii, $base;
        } else {
            ## drop it
            # push @ascii, "[:$char:]";
        }
    }

    return concat(@ascii);
}

ASCII_BASE: {
    my %ASCII_BASE;

    sub ascii_base( $ ) {
        my $char = shift;

        if (! exists $ASCII_BASE{$char}) {
            $ASCII_BASE{$char} = __ascii_base($char);
        }

        return $ASCII_BASE{$char};
    }
}

1;

__END__
