package TeX::Primitive::over;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Noad::MathList;
use TeX::Noads;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    # my $noad = make_fraction_noad($tex->get_current_list());
    # 
    # $tex->set_current_list(TeX::Noad::MathList->new());
    # 
    # $tex->add_noad($noad);

    return;
}

1;

__END__
