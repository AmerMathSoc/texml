package TeX::Primitive::UCSchardef;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

use TeX::WEB2C qw(:catcodes);

use TeX::Interpreter qw(FROZEN_RELAX);

use TeX::Interpreter::Constants qw(DEFAULT_CHARACTER_ENCODING);

use TeX::Primitive::CharGiven;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $r_token = $tex->get_r_token();

    $tex->define($r_token, FROZEN_RELAX);

    $tex->scan_optional_equals();

    my $char_code = $tex->scan_char_num();

    $tex->initialize_char_codes($char_code);

    my $command = TeX::Primitive::CharGiven->new({ name => "char",
                                                   value => $char_code,
                                                   encoding => DEFAULT_CHARACTER_ENCODING,
                                                 });

    $tex->define($r_token, $command, $modifier);

    return;
}

1;

__END__
