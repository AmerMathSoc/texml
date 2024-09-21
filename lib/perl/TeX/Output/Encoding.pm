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

our %EXPORT_TAGS = ( functions => [ qw(decode_character get_encoding) ],
                     constants => [ qw(LIG_CONTINUE LIG_STOP LIG_KEEP_RIGHT) ]);

our @EXPORT = @{ $EXPORT_TAGS{functions} };

our @EXPORT_OK = ( @{ $EXPORT_TAGS{functions} }, @{ $EXPORT_TAGS{constants} } );

use Carp;

use File::Spec::Functions;
use File::Basename;

use TeX::Constants qw(UCS);
use TeX::Utils::Misc;

use Exception::Class qw(TeX::Output::Encoding::Error);

use constant {
    LIG_CONTINUE   => 0,
    LIG_STOP       => 1,
    LIG_KEEP_RIGHT => 2,
};

my %ENCODING;

my $MAP_DIR = catdir(dirname($INC{"TeX/Output/Encoding.pm"}), "encodings");

sub load_encoding {
    my $encoding = shift;

    CORE::state $octal = qr{'[0-3][0-7][0-7]};
    CORE::state $hex   = qr{"[[:xdigit:]][[:xdigit:]]}i;

    CORE::state $eight_bits = qr{^($octal|$hex)$}; # more or less

    return if $encoding eq UCS;

    my $map_file = "$MAP_DIR/$encoding.enc";

    my %map;

    open(my $map, "<:utf8", $map_file) or do {
        TeX::Output::Encoding::Error->throw("Encoding scheme `$encoding' unknown");
    };

    local $_;

    my %flag = ( '=:'  => LIG_CONTINUE,
                 ':='  => LIG_STOP,
                 '=:|' => LIG_KEEP_RIGHT);

    my $char_re = qr{(?:U\+[0-9a-z]+|.)}i;

    while (<$map>) {
        ($_) = split /;;/;

        $_ = trim($_);

        next if /^\s*$/;

        # In a lig specification, the first character is in the output
        # encoding (i.e., Unicode); the second character is in the
        # input encoding; and the third character is in the output
        # encoding.

        m{^lig ($char_re) ($char_re) (=:|:=|=:\|) ($char_re)} and do {
            my $char = $1;
            my $next = $2;
            my $op   = $3;
            my $lig  = $4;

            $char =~ s{U\+(.+)}{ chr(hex($1)) }e;
            $next =~ s{U\+(.+)}{ chr(hex($1)) }e;
            $lig  =~ s{U\+(.+)}{ chr(hex($1)) }e;

            $map{"${char}_lig"}->{$next} = [$lig, $flag{$op}];

            next;
        };

        next if m{^lig};

        my ($char_code, $ucs_codepoint) = split /\s*:\s*/, $_, 2;

        if ($char_code !~ m{$eight_bits}) {
            print STDERR "! Invalid char code ($char_code) on line $. of $map_file\n";
        }

        if ($char_code =~ s{^\'}{}) {
            $char_code = oct($char_code);
        } elsif ($char_code =~ s{^\"}{}) {
            $char_code = hex($char_code);
        }

        if ($ucs_codepoint =~ s{^U\+}{}) {
            $ucs_codepoint = hex($ucs_codepoint);
        } else {
            $ucs_codepoint = ord($ucs_codepoint); # literal character
        }

        if ($char_code != $ucs_codepoint) {
            $map{chr($char_code)} = chr($ucs_codepoint);
        }
    }

    close($map);

    return \%map;
}

sub get_encoding {
    my $encoding = shift;

    return $ENCODING{$encoding} ||= load_encoding($encoding);
}

sub decode_character {
    my $encoding  = shift;
    my $char_code = shift;

    return $char_code if $encoding eq UCS;

    my $map = get_encoding($encoding);

    my $literal_char = chr($char_code);

    if (! defined $map) {
        print STDERR "! Unknown encoding: $encoding\n";

        return $literal_char;
    }

    return $map->{$literal_char} // $literal_char;
}

1;

__END__
