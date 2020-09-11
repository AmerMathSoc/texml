package TeX::Utils::Unicode;

use strict;
use warnings;

use version; our $VERSION = qv '0.6.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(
    make_accenter
) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

use TeX::Utils::Unicode::Diacritics qw(apply_accent);

use TeX::Constants qw(:named_args);

use TeX::Interpreter::Constants qw(DEFAULT_CHARACTER_ENCODING);

use TeX::Output::FontMapper qw(decode_character);

use TeX::TokenList qw(:factories);

use TeX::WEB2C qw(:token_types :catcodes);

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
                    $enc ||= $tex->get_encoding() || DEFAULT_CHARACTER_ENCODING;

                    if ($enc ne DEFAULT_CHARACTER_ENCODING) {
                        $char_code = decode_character($enc, $char_code);
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
