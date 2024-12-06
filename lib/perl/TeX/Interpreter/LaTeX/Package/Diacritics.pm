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

use TeX::Token qw(:catcodes :factories);

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
        my $self = shift;

        my $tex   = shift;
        my $token = shift;

        ## The next line removes braces around the argument.  E.g., it
        ## turns \~{a} into \~a.  This is needed because
        ## get_next_character() doesn't remove braces and is
        ## consistent with the way that \add@accent behaves.

        $tex->back_list($tex->read_undelimited_parameter());

        my ($base_code, $enc) = $tex->get_next_character(1);

        my $base_char = defined $base_code ? chr($base_code) : undef;

        my $arg1 = defined $base_char ? $base_char : '<undef>';

        my $accented_char;

        for my $accent (@accents) {
            ($accented_char, my $error) = $tex->apply_accent($accent,
                                                             $base_char);

            if (! defined $accented_char) {
                $error ||= "unknown error";
            }

            if (defined $error) {
                $tex->print_err("Can't compose accent '$accent' with $base_char ($error)");

                $tex->error();
            }

            $base_char = $accented_char;
        }

        my $chars = new_token_list();

        if (defined $accented_char) {
            for my $char (split '', $accented_char) {
                my $usv = ord($char);

                ## There could be a problem if the char_code is within

                my $char_code = $tex->encode_character($usv);

                ## This might be the first time we've encountered this
                ## composite character.

                $tex->initialize_char_codes($char_code);

                my $char = make_character_token(chr($char_code),
                                                $tex->get_catcode($char_code));

                $chars->push($char);
            }
        } else {
            $tex->print_err("Can't apply $token to $base_char");

            $tex->error();
        }

        $self->trace_anonymous_macro($tex, $token, '#1', $chars, $arg1);

        return $chars;
    };
}

sub install_diacritics {
    my $self = shift;

    my $tex     = shift;

    $tex->define_pseudo_macro(q{"} => make_accenter(COMBINING_DIAERESIS));
    $tex->define_pseudo_macro(q{'} => make_accenter(COMBINING_ACUTE));
    $tex->define_pseudo_macro(q{.} => make_accenter(COMBINING_DOT_ABOVE));
    $tex->define_pseudo_macro(q{=} => make_accenter(COMBINING_MACRON));
    $tex->define_pseudo_macro(q{^} => make_accenter(COMBINING_CIRCUMFLEX));
    $tex->define_pseudo_macro(q{`} => make_accenter(COMBINING_GRAVE));
    $tex->define_pseudo_macro(q{~} => make_accenter(COMBINING_TILDE));

    # We probably don't care about these, but just in case:
    $tex->let_csname('@acci'   => q{'});
    $tex->let_csname('@accii'  => q{`});
    $tex->let_csname('@acciii' => q{=});

    $tex->define_pseudo_macro(b    => make_accenter(COMBINING_MACRON_BELOW));
    $tex->define_pseudo_macro(c    => make_accenter(COMBINING_CEDILLA));
    $tex->define_pseudo_macro(d    => make_accenter(COMBINING_DOT_BELOW));
    $tex->define_pseudo_macro(H    => make_accenter(COMBINING_DOUBLE_ACUTE));
    $tex->define_pseudo_macro(h    => make_accenter(COMBINING_HOOK_ABOVE));
    $tex->define_pseudo_macro(horn => make_accenter(COMBINING_HORN));
    $tex->define_pseudo_macro(k    => make_accenter(COMBINING_OGONEK));
    $tex->define_pseudo_macro(r    => make_accenter(COMBINING_RING_ABOVE));
    $tex->define_pseudo_macro(u    => make_accenter(COMBINING_BREVE));
    $tex->define_pseudo_macro(v    => make_accenter(COMBINING_CARON));

    $tex->define_pseudo_macro(textcommabelow => make_accenter(COMBINING_COMMA_BELOW));
    $tex->define_pseudo_macro(textcommaabove => make_accenter(COMBINING_COMMA_ABOVE));

    ## Should move these to amsvnacc:

    ## Double accents (legacy support for amsvnacc).

    # These only makes sense when applied to 'a' or 'A'.

    $tex->define_pseudo_macro(breac => make_accenter(COMBINING_BREVE,
                                                COMBINING_ACUTE));

    $tex->define_pseudo_macro(bregr => make_accenter(COMBINING_BREVE,
                                                COMBINING_GRAVE));

    $tex->define_pseudo_macro(breti => make_accenter(COMBINING_BREVE,
                                                COMBINING_TILDE));

    $tex->define_pseudo_macro(breud => make_accenter(COMBINING_BREVE,
                                                COMBINING_DOT_BELOW));

    $tex->define_pseudo_macro(brevn => make_accenter(COMBINING_BREVE,
                                                COMBINING_HOOK_ABOVE));

    # A, a, E, e, O, o

    $tex->define_pseudo_macro(cirac => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_ACUTE));

    # $tex->define_pseudo_macro(xcirac => $tex->get_handler(q{cirac}));
    # $tex->define_pseudo_macro(xcirgr => $tex->get_handler(q{cirgr}));

    $tex->define_pseudo_macro(cirgr => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_GRAVE));

    $tex->define_pseudo_macro(cirti => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_TILDE));

    $tex->define_pseudo_macro(cirud => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_DOT_BELOW));

    $tex->define_pseudo_macro(cirvh => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_HOOK_ABOVE));

    # Aliases

    # $tex->define_pseudo_macro(vacute => $tex->get_handler(q{'}));
    # $tex->define_pseudo_macro(vgrave => $tex->get_handler(q{`}));
    # $tex->define_pseudo_macro(vhook  => $tex->get_handler(q{h}));
    # $tex->define_pseudo_macro(vtilde => $tex->get_handler(q{~}));

    return;
}

1;

__END__
