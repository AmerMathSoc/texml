package TeX::Primitive::setbox;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::WEB2C qw(:box_params);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $prefix = exists $_[0] ? shift : 0;

    my $modifier = $prefix ; # | $self->get_modifier();

    my $n = $tex->scan_eight_bit_int();

    $n += 256 if $modifier & MODIFIER_GLOBAL;

    $tex->scan_optional_equals();

    if (! $tex->is_set_box_allowed()) {
        $tex->print_err("Improper ");
        $tex->print_esc("setbox");

        $tex->set_help("Sorry, \\setbox is not allowed after \\halign in a display,",
                       "or between \\accent and an accented character.");

        $tex->error();

        return;
    }

    $tex->scan_box(box_flag + $n);

    return;
}

1;

__END__
