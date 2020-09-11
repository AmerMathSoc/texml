package TeX::Primitive::lastskip;

use strict;
use warnings;

use base qw(TeX::Primitive::LastItem);

use TeX::Type::GlueSpec qw(make_glue_spec);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    ## Most of these are integers, so use int_val as the default

    $self->set_level(glue_val);

    return;
}

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $tail = $tex->tail_node();

    if (defined $tail && $tail->isa("TeX::Node::GlueNode")) {
        return make_glue_spec($tail->get_width(),
                              [ $tail->get_stretch(), $tail->get_stretch_order() ],
                              [ $tail->get_shrink(), $tail->get_shrink_order() ]);
    }

    return make_glue_spec(0, 0, 0);
}

1;

__END__
