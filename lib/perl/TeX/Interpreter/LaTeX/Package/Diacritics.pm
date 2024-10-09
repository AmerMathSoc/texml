package TeX::Interpreter::LaTeX::Package::Diacritics;

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

use TeX::Constants qw(:named_args :unicode_accents UCS);

use TeX::Token qw(:catcodes);

use TeX::TokenList qw(:factories);

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $class->install_diacritics($tex);

    return;
}

######################################################################
##                                                                  ##
##                   COMBINING DIACRITICAL MARKS                    ##
##                                                                  ##
######################################################################

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

        my $accented_char;

        for my $accent (@accents) {
            ($accented_char, my $error) = $tex->apply_accent($accent, $base);

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

                $tex->append_char(ord($tex->encode_character($enc, $char_code)), $enc);
            }
        } else {
            $tex->print_err("Can't apply $token to $base");

            $tex->error();
        }

        return;
    };
}

sub install_diacritics {
    my $self = shift;

    my $tex     = shift;

    $tex->define_csname(q{"} => make_accenter(COMBINING_DIAERESIS));
    $tex->define_csname(q{'} => make_accenter(COMBINING_ACUTE));
    $tex->define_csname(q{.} => make_accenter(COMBINING_DOT_ABOVE));
    $tex->define_csname(q{=} => make_accenter(COMBINING_MACRON));
    $tex->define_csname(q{^} => make_accenter(COMBINING_CIRCUMFLEX));
    $tex->define_csname(q{`} => make_accenter(COMBINING_GRAVE));
    $tex->define_csname(q{~} => make_accenter(COMBINING_TILDE));

    # We probably don't care about these, but just in case:
    $tex->let_csname('@acci'   => q{'});
    $tex->let_csname('@accii'  => q{`});
    $tex->let_csname('@acciii' => q{=});

    $tex->define_csname(b    => make_accenter(COMBINING_MACRON_BELOW));
    $tex->define_csname(c    => make_accenter(COMBINING_CEDILLA));
    $tex->define_csname(d    => make_accenter(COMBINING_DOT_BELOW));
    $tex->define_csname(H    => make_accenter(COMBINING_DOUBLE_ACUTE));
    $tex->define_csname(h    => make_accenter(COMBINING_HOOK_ABOVE));
    $tex->define_csname(horn => make_accenter(COMBINING_HORN));
    $tex->define_csname(k    => make_accenter(COMBINING_OGONEK));
    $tex->define_csname(r    => make_accenter(COMBINING_RING_ABOVE));
    $tex->define_csname(u    => make_accenter(COMBINING_BREVE));
    $tex->define_csname(v    => make_accenter(COMBINING_CARON));

    $tex->define_csname(textcommabelow => make_accenter(COMBINING_COMMA_BELOW));
    $tex->define_csname(textcommaabove => make_accenter(COMBINING_COMMA_ABOVE));

    ## Should move these to amsvnacc:

    ## Double accents (legacy support for amsvnacc).

    # These only makes sense when applied to 'a' or 'A'.

    $tex->define_csname(breac => make_accenter(COMBINING_BREVE,
                                                COMBINING_ACUTE));

    $tex->define_csname(bregr => make_accenter(COMBINING_BREVE,
                                                COMBINING_GRAVE));

    $tex->define_csname(breti => make_accenter(COMBINING_BREVE,
                                                COMBINING_TILDE));

    $tex->define_csname(breud => make_accenter(COMBINING_BREVE,
                                                COMBINING_DOT_BELOW));

    $tex->define_csname(brevn => make_accenter(COMBINING_BREVE,
                                                COMBINING_HOOK_ABOVE));

    # A, a, E, e, O, o

    $tex->define_csname(cirac => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_ACUTE));

    # $tex->define_csname(xcirac => $tex->get_handler(q{cirac}));
    # $tex->define_csname(xcirgr => $tex->get_handler(q{cirgr}));

    $tex->define_csname(cirgr => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_GRAVE));

    $tex->define_csname(cirti => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_TILDE));

    $tex->define_csname(cirud => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_DOT_BELOW));

    $tex->define_csname(cirvh => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_HOOK_ABOVE));

    # Aliases

    # $tex->define_csname(vacute => $tex->get_handler(q{'}));
    # $tex->define_csname(vgrave => $tex->get_handler(q{`}));
    # $tex->define_csname(vhook  => $tex->get_handler(q{h}));
    # $tex->define_csname(vtilde => $tex->get_handler(q{~}));

    return;
}

1;

__END__
