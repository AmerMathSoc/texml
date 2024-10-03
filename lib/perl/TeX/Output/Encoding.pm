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

our %EXPORT_TAGS = ( functions => [ qw(decode_character encode_character
                                       get_encoding) ] );

our @EXPORT = @{ $EXPORT_TAGS{functions} };

our @EXPORT_OK = ( @{ $EXPORT_TAGS{functions} } );

use Carp;

use File::Spec::Functions;
use File::Basename;

use TeX::Constants qw(UCS);
use TeX::Utils::Misc;

use Exception::Class qw(TeX::Output::Encoding::Error);

my %ENCODING;

my $MAP_DIR = catdir(dirname($INC{"TeX/Output/Encoding.pm"}), "encodings");

sub __char_code {
    my $code_or_char = shift;

    if ($code_or_char =~ s{(?:U\+|")(.+)}{ hex($1) }e) {
        return $code_or_char;
    };

    return ord($code_or_char);
}

sub load_encoding {
    my $encoding = shift;

    return if $encoding eq UCS;

    CORE::state $octal = qr{'[0-3][0-7][0-7]};
    CORE::state $hex   = qr{"[[:xdigit:]][[:xdigit:]]}i;

    CORE::state $eight_bits = qr{^($octal|$hex)$}; # more or less

    my $map_file = "$MAP_DIR/$encoding.enc";

    my %map;

    my @decode;
    my @ligs;
    my @encode;

    open(my $map, "<:utf8", $map_file) or do {
        TeX::Output::Encoding::Error->throw("Encoding scheme `$encoding' unknown");
    };

    # Map the operators to their TFM lig_kern_command op_byte codes.
    # See section 545 of tex.web.

    my %op = (  '=:'    =>  0,
                '=:|'   =>  1,
                '=:|>'  =>  5,
               '|=:'    =>  2,
               '|=:>'   =>  6,
               '|=:|'   =>  3,
               '|=:|>'  =>  7,
               '|=:|>>' => 11,
                '=:>'   =>  4,
        );

    my $char_re = qr{(?:U\+[0-9a-z]+|"[0-9a-z]+|.)}i;

    local $_;

    while (<$map>) {
        ($_) = split /;;/;

        $_ = trim($_);

        next if /^\s*$/;

        m{^lig ($char_re) ($char_re) (\|?=:\|?>*) ($char_re)} and do {
            my $focus = $1;
            my $next  = $2;
            my $op    = $3;
            my $lig   = $4;

            $focus = __char_code($focus);
            $next  = __char_code($next);
            $lig   = __char_code($lig);

            # In a lig specification, the focus character is in the
            # output encoding (i.e., Unicode); the 'next' character is
            # in the input encoding; and the lig character is in the
            # output encoding, so we need to back-code the focus and
            # lig characters.

            $focus = $encode[$focus] // $focus;
            $lig   = $encode[$lig]   // $lig;

            $ligs[$focus]->[$next] = [$lig, $op{$op}];

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
            $decode[$char_code]     = $ucs_codepoint;
            $encode[$ucs_codepoint] = $char_code;
        }
    }

    close($map);

    return { ligs => \@ligs, decode => \@decode, encode => \@encode };
}

sub get_encoding {
    my $encoding = shift;

    return $ENCODING{$encoding} ||= load_encoding($encoding);
}

sub decode_character {
    my $encoding  = shift;
    my $char_code = shift;

    my $literal_char = chr($char_code);

    return $literal_char if $encoding eq UCS;

    my $map = eval { get_encoding($encoding) };

    if (! defined $map) {
        print STDERR "! Unknown encoding: $encoding\n";

        return $literal_char;
    }

    my $enc = $map->{decode};

    return chr($enc->[$char_code] // $char_code);
}

sub encode_character {
    my $encoding  = shift;
    my $char_code = shift;

    use Carp;

    if (! defined $encoding) {
        Carp::confess qq{*** encode_character: encoding='$encoding'; char_code='$char_code'\n};
    }

    my $literal_char = chr($char_code);

    return $literal_char if $encoding eq UCS;

    my $map = eval { get_encoding($encoding) };

    if (! defined $map) {
        print STDERR "! Unknown encoding: $encoding\n";

        return $literal_char;
    }

    my $enc = $map->{encode};

    return chr($enc->[$char_code] // $char_code);
}

1;

__END__

THE METAFONT RULES

[.] indicates focus

lig a b  =:    X    ; [a]bc... => [X] c...          op=0

lig a b  =:|   X    ; [a]bc... => [X]  b  c...      op=1
lib a b  =:|>  X    ; [a]bc... =>  X  [b] c...      op=5

lig a b |=:    X    ; [a]bc... => [a]  X  c...      op=2
lib a b |=:>   X    ; [a]bc... =>  a  [X] c...      op=6

lig a b |=:|   X    ; [a]bc... => [a]  X   b  c...  op=3
lib a b |=:|>  X    ; [a]bc... =>  a  [X]  b  c...  op=7
lib a b |=:|>> X    ; [a]bc... =>  a   X  [b] c...  op=11

NEW RULE

lig a b  =:>   X    ; [a]bc... => X[c]...           op=4
