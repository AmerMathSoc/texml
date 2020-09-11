package TeX::Primitive::ital_corr;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    ## NO-OP

    # if ($tex->is_vmode()) {
    #     $tex->report_illegal_case();
    # } elsif ($tex->is_hmode()) {
    #     $tex->append_italic_correction();
    # } elsif ($tex->is_mmode()) {
    #     $tex->tail_append(new_kern(0));
    # }

    return;
}

1;

__END__
