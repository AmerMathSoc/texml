package TeX::Output::FontMapper;

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

use Carp;

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(encode_character decode_character font_spec) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(encode_character font_spec);

use File::Spec::Functions;
use File::Basename;

use TeX::Constants qw(UCS);

my %CHAR_MAP;
my %ENCODING_OF;
my %FONT_MAP;

my $MAP_DIR = catdir(dirname($INC{"TeX/Output/FontMapper.pm"}), "encodings");

my $UNKNOWN_CHARACTER = "<0xFFFD>";

#INIT {
    my $map_file = catfile($MAP_DIR, "fontmap.txt");

    open(my $map, "<", $map_file) or die "Can't open $map_file: $!\n";

    while (<$map>) {
        chomp;

        next if /^\s*$/;

        next if /^%/;

        my ($tex_name, $encoding, $spec) = split / +/, $_, 3;

        $FONT_MAP{$tex_name} = [ split /,\s*/, $spec ];
        $ENCODING_OF{$tex_name} = $encoding;
    }

    close($map);
#}

sub font_spec( $ ) {
    my $tex_name = shift;

    return $FONT_MAP{$tex_name};
}

sub load_character_map( $ ) {
    my $encoding = shift;

    return if $encoding eq UCS;

    ## FIXME
    use Carp;

    if ($encoding eq '\\encodingdefault ') {
        croak "Bad encoding '$encoding'";
    }

    my $map_file = "$MAP_DIR/$encoding.aitt";

    my @map;

    open(my $map, "<", $map_file) or die "Can't open $map_file: $!\n";

    while (<$map>) {
        chomp;

        next if /^\s*$/;

        my ($code, $encoding) = split /: /;

        croak "Invalid code ($code)" unless $code =~ /^\'\d\d[x\d]$/;

        if ($code =~ /^\'(\d+)$/) {
            my $char_code = oct($1);

            if ($encoding ne $UNKNOWN_CHARACTER) {
                $map[$char_code] = $encoding;
            }

            next;
        }

        $code =~ /(\d+)/;

        my $start_code = oct("${1}0");

        for my $i (0..7) {
            if ($encoding =~ s/^( <0x.{4}> | \\. | . )//msx) {
                $map[$start_code + $i] = $1;
            }
        }
    }

    close($map);

    return \@map;
}

sub get_font_encoding( $ ) {
    my $font = shift;

    my $encoding = $ENCODING_OF{$font};

    croak "Unknown font $font" unless defined $encoding;

    return get_encoding($encoding);
}

sub get_encoding( $ ) {
    my $encoding = shift;

    if (exists $CHAR_MAP{$encoding}) {
        return $CHAR_MAP{$encoding};
    }

    return $CHAR_MAP{$encoding} = load_character_map($encoding)
}

sub encode_character($$) {
    my $font = shift;
    my $char_code = shift;

    # return $char_code; # if $encoding eq UCS;

    my $map = get_font_encoding($font);

    if (! defined $map) {
        croak "Unknown font: $font";
    }

    my $encoding = $map->[$char_code];

    if (! defined $encoding) {
        croak "Unknown character in $font: $char_code";
    }

    return $encoding;
}

sub decode_character( $$ ) {
    my $encoding  = shift;
    my $char_code = shift;

    return $char_code if $encoding eq UCS;

    my $map = get_encoding($encoding);

    if (! defined $map) {
        croak "Unknown encoding: $encoding";
    }

    my $unicode = $map->[$char_code];

    if (! defined $unicode) {
        croak "Unknown character in $encoding: $char_code";
    }

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
