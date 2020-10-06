package TeX::Primitive::let;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

use TeX::Constants qw(:booleans :tracing_macro_codes);

use TeX::WEB2C qw(:catcodes);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $r_token = $tex->get_r_token();

    my $next_token = $tex->get_next();

    while ($next_token == CATCODE_SPACE) {
        $next_token = $tex->get_next();
    }

    if ($next_token == CATCODE_OTHER && $next_token eq "=") {
        $next_token = $tex->get_next();

        if ($next_token == CATCODE_SPACE) {
            $next_token = $tex->get_next();
        }
    }

    if ($tex->tracing_macros() & TRACING_MACRO_DEFS) {
        $tex->begin_diagnostic();

        $tex->print_ln();

        $tex->print("$cur_tok$r_token:=$next_token");

        $tex->print_ln();

        $tex->end_diagnostic(false);
    }

    my $equiv = $tex->get_meaning($next_token);

    $tex->define($r_token, $equiv, $modifier);

    return;
}

1;

__END__
