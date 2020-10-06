package TeX::Primitive::mathchardef;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

use TeX::Interpreter qw(FROZEN_RELAX);

use TeX::Primitive::MathGiven qw(:factories);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $r_token = $tex->get_r_token();

    $tex->define($r_token, FROZEN_RELAX);

    $tex->scan_optional_equals();

    my $code = $tex->scan_fifteen_bit_int();

    my $command = make_math_given($code);

    $tex->define($r_token, $command, $modifier);

    return;
}

1;

__END__
