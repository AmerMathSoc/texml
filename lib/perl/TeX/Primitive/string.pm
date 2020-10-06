package TeX::Primitive::string;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

use TeX::WEB2C qw(:catcodes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token = $tex->get_next();

    my $string = $token->get_datum();

    if ($token == CATCODE_CSNAME) {
        my $escape_char = $tex->escape_char();

        if ($escape_char >= 0 && $escape_char < 256) {
            $string = chr($escape_char) . $string;
        }
    }

    $tex->conv_toks($string);

    return;
}

1;

__END__
