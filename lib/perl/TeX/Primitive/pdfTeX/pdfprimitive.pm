package TeX::Primitive::pdfTeX::pdfprimitive;

## INCOMPLETE

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::WEB2C qw(:catcodes);

use TeX::Interpreter qw(FROZEN_PRIMITIVE_TOKEN);

use TeX::Class;

my %subtype_of :COUNTER(:name<subtype>);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $next = $tex->get_token_careful();

    if ($next != CATCODE_CSNAME) {
        $self->missing_primitive($tex, $next);

        return;
    }

    my $prim = $tex->get_primitive($next->get_csname());

    if (! defined $prim) {
        $self->missing_primitive($tex, $next);

        return;
    }

    if ($prim->isa("TeX::Command::Expandable")) {
        return $prim->expand($tex, $next);
    }

    return;
}

sub missing_primitive {
    my $self = shift;

    my $tex = shift;
    my $tok = shift;

    $tex->print_err("Missing primitive name");

    $tex->set_help("The control sequence marked <to be read again> does not",
                   "represent any known primitive.");

    $tex->back_error($tok);

    return;
}

1;

__END__
