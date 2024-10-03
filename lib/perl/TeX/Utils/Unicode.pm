package TeX::Utils::Unicode;

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

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(make_accenter) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

use TeX::Output::Encoding qw(encode_character);

use TeX::Utils::Unicode::Diacritics qw(apply_accent);

use TeX::Constants qw(:named_args UCS);

use TeX::Output::Encoding qw(decode_character);

use TeX::Token qw(:catcodes);

use TeX::TokenList qw(:factories);

sub make_accenter( @ ) {
    my @accents = @_;

    return sub {
        my $tex   = shift;
        my $token = shift;

        if ($tex->is_vmode()) {
            $tex->back_input($token);

            $tex->new_graf();

            return;
        }

        my $raw_base = $tex->read_undelimited_parameter();

        $tex->back_list($raw_base);

        my ($base, $enc) = $tex->get_next_character();

        # my $enc  = $tex->get_encoding();

        # my $base = decode_character($enc, ord($raw_base));

        my $accented_char;

        for my $accent (@accents) {
            ($accented_char, my $error) = apply_accent($accent, $base);

            if (! defined $accented_char) {
                $error ||= "unknown error";
            }

            if (defined $error) {
                $tex->print_err("Can't compose accent '$accent' with $base ($error)");

                $tex->error();
            }

            $base = $accented_char;
        }

        if (defined $accented_char) {
            for my $char (split '', $accented_char) {
                my $char_code = ord($char);

                ## This might be the first time we've encountered this
                ## composite character.

                $tex->initialize_char_codes($char_code);

                $tex->append_char(ord(encode_character($enc, $char_code)), $enc);
            }
        } else {
            $tex->print_err("Can't apply $token to $base");

            $tex->error();
        }

        return;
    };
}

1;

__END__
