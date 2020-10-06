package TeX::Primitive::hskip;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::WEB2C qw(:scan_types);

use TeX::Nodes qw(new_glue);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    my $glue = $tex->scan_glue(glue_val);

    $tex->tail_append(new_glue({ glue => $glue }));

    return;
}

1;

__END__
