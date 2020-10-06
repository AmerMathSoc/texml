package TeX::Primitive::RegisterDef;

## Abstract base class for \countdef, \dimendef, \muskipdef, \skipdef, \toksdef

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

use TeX::Primitive::relax;

use constant FROZEN_RELAX => TeX::Primitive::relax->new();

my %level_of :ATTR(:name<level> :default<-1>);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $r_token = $tex->get_r_token();

    $tex->define($r_token, FROZEN_RELAX);

    $tex->scan_optional_equals();

    ## We use scan_int() instead of scan_eight_bit_int() in order to
    ## allow an arbitrary number of registers.

    my $index = $tex->scan_int();

    my $level = $self->get_level();

    my $command = TeX::Primitive::Register->new({ index => $index,
                                                  level => $level });

    $tex->define($r_token, $command, $modifier);

    return;
}

1;

__END__
