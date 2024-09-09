package TeX::Output::Encoding;

# Copyright (C) 2024 American Mathematical Society
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

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(decode_character) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(decode_character);

use Carp;

use File::Spec::Functions;
use File::Basename;

use TeX::Constants qw(UCS);

my %CHAR_MAP;

my $MAP_DIR = catdir(dirname($INC{"TeX/Output/Encoding.pm"}), "encodings");

my $UNKNOWN_CHARACTER = "<0xFFFD>";

sub load_character_map {
    my $encoding = shift;

    CORE::state $octal = qr{'\d\d[\dx]};
    CORE::state $hex   = qr{"[[:xdigit:]][[:xdigit:]]}i;

    CORE::state $eight_bits = qr{^($octal|$hex)$}; # more or less

    return if $encoding eq UCS;

    my $map_file = "$MAP_DIR/$encoding.enc";

    my @map;

    open(my $map, "<", $map_file) or die "Can't open $map_file: $!\n";

    local $_;

    while (<$map>) {
        chomp;

        next if /^\s*$/;

        my ($code, $ucs_codepoint) = split /: /;

        croak "Invalid code ($code)" unless $code =~ m{$eight_bits};

        if ($code =~ s{^\'}{}) {
            my $char_code = oct($code);

            if ($ucs_codepoint ne $UNKNOWN_CHARACTER) {
                $map[$char_code] = $ucs_codepoint;
            }

            next;
        }

        if ($code =~ s{^\"}{}) {
            my $char_code = hex($code);

            if ($ucs_codepoint ne $UNKNOWN_CHARACTER) {
                $map[$char_code] = $ucs_codepoint;
            }

            next;
        }

        if ($code =~ /^'(\d{2})x$/) {
            my $start_code = oct("${1}0");

            for my $i (0..7) {
                if ($ucs_codepoint =~ s{^( <0x[[:xdigit:]]{4}> | \\. | . )}{}msx) {
                    $map[$start_code + $i] = $1;
                }
            }

            next;
        }

        die "You should not have gotten here."
    }

    close($map);

    return \@map;
}

sub get_encoding {
    my $encoding = shift;

    if (exists $CHAR_MAP{$encoding}) {
        return $CHAR_MAP{$encoding};
    }

    return $CHAR_MAP{$encoding} = load_character_map($encoding)
}

sub decode_character {
    my $encoding  = shift;
    my $char_code = shift;

    return $char_code if $encoding eq UCS;

    my $map = get_encoding($encoding);

    if (! defined $map) {
        croak "Unknown encoding: $encoding";
    }

    my $unicode = $map->[$char_code];

    return $char_code unless defined $unicode;

    if ($unicode =~ s/\A < (.*?) > \z/$1/smx) {
        $unicode = oct($unicode) if $unicode =~ /^0/;
    } else {
        $unicode =~ s/\A \\(.) \z/$1/smx;

        $unicode = ord($unicode);
    }

    return $unicode;
}

1;

__END__
