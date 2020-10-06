package TeX::Primitive::vrule;

use strict;
use warnings;

use base qw(TeX::Primitive::Rule);

use TeX::Class;

use TeX::WEB2C qw(ignore_depth);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    my $spec = $tex->scan_rule_spec();

    # $tex->tail_append($spec);

    $tex->set_spacefactor(1000);

    return;
}

1;

__END__
