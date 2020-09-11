package TeX::Primitive::left;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::WEB2C qw(:save_stack_codes);

# use TeX::Constants qw(:booleans);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    # my $delim = $tex->scan_delimiter(false);

    $tex->conv_toks(q{\left});

    $tex->push_math(math_left_group);

    return;
}

1;

__END__
