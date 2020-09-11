package TeX::Primitive::jobname;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->conv_toks($tex->get_job_name());

    return;
}

1;

__END__
