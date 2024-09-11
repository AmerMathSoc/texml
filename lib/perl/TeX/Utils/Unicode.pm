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

our %EXPORT_TAGS = (all => [ qw(
    make_accenter
) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

use TeX::Utils::Unicode::Diacritics qw(apply_accent);

use TeX::Constants qw(:named_args UCS);

use TeX::Output::Encoding qw(decode_character);

use TeX::Token qw(:catcodes);

use TeX::TokenList qw(:factories);

sub make_accenter( @ ) {
    my @accents = @_;

    return sub {
        my $macro = shift;

        my $tex   = shift;
        my $token = shift;

        my $arg = $tex->read_undelimited_parameter();

        $tex->begingroup();

        $tex->ins_list($arg);

        my $next = $tex->get_x_token();

        my $char;

        my $catcode = $next->get_catcode();

        if ($catcode == CATCODE_LETTER || $catcode == CATCODE_OTHER) {
            $char = $next->get_char();
        } elsif ($catcode == CATCODE_CSNAME) {
            my $cur_cmd = $tex->get_meaning($next);

            my $char_code;
            my $enc;

            if ($cur_cmd->isa("TeX::Primitive::CharGiven")) {
                $char_code = $cur_cmd->get_value();

                $enc = $cur_cmd->get_encoding();
            } elsif ($cur_cmd->isa("TeX::Primitive::char")) {
                $char_code = $tex->scan_char_num();
            }

            if (defined($char_code)) {
                if ($char_code < 256) {
                    $enc ||= $tex->get_encoding() || UCS;

                    if ($enc ne UCS) {
                        $char = decode_character($enc, $char_code);
                    }
                }

                $char = chr($char_code);
            }
        }

        for my $accent (@accents) {
            ($char, my $error) = apply_accent($accent, $char);

            if (! defined $char) {
                $error ||= "unknown error";
            }

            if (defined $error) {
                $tex->print_err("Can't compose accent '$accent' with $arg ($error)");

                $tex->error();
            }
        }

        my $token_list;

        if (! defined $char) {
            $tex->print_err("Can't apply $token to $arg");

            $tex->error();

            $token_list = new_token_list();
        } else {
            $token_list = $tex->str_toks($char);
        }

        $tex->endgroup();

        return $token_list;
    };
}

1;

__END__
