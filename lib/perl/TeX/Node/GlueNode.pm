package TeX::Node::GlueNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::Arithmetic qw(:string);

use TeX::WEB2C qw(:node_params);

my %width_of   :ATTR(:get<width>   :set<width>);

my %stretch_of       :ATTR(:get<stretch> :set<stretch>);
my %stretch_order_of :ATTR(:get<stretch_order> :set<stretch_order>);

my %shrink_of  :ATTR(:get<shrink>  :set<shrink>);
my %shrink_order_of :ATTR(:get<shrink_order> :set<shrink_order>);

my %leader_ptr_of :ATTR(:get<leader_ptr> :set<leader_ptr>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(glue_node);

    if (exists $arg_ref->{glue}) {
        my $glue = $arg_ref->{glue};

        $width_of        {$ident} = $glue->get_width();

        $stretch_of      {$ident} = $glue->get_stretch();
        $stretch_order_of{$ident} = $glue->get_stretch_order();

        $shrink_of       {$ident} = $glue->get_shrink();
        $shrink_order_of {$ident} = $glue->get_shrink_order();
    } else {
        $width_of        {$ident} = $arg_ref->{width} || 0;

        $stretch_of      {$ident} = $arg_ref->{stretch}       || 0;
        $stretch_order_of{$ident} = $arg_ref->{stretch_order} || normal;

        $shrink_of       {$ident} = $arg_ref->{shrink}        || 0;
        $shrink_order_of {$ident} = $arg_ref->{shrink_order}  || normal;

        $leader_ptr_of   {$ident} = $arg_ref->{leader_ptr};
    }

    return;
}

sub is_glue {
    return 1;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    $hlist->update_natural_width($self->get_width());

    $hlist->update_stretch($self->get_stretch_order(), $self->get_stretch());

    $hlist->update_shrink($self->get_shrink_order(), $self->get_shrink());

    return;
}

sub show_node {
    my $self = shift;

    my $node = sprintf '\glue %s', scaled_to_string($self->get_width);

    my $stretch = $self->get_stretch();

    if ($stretch != 0) {
        my $order = $self->get_stretch_order();

        $node .= sprintf ' plus %s', glue_to_string($stretch, $order);
    }

    my $shrink = $self->get_shrink();

    if ($shrink != 0) {
        my $order = $self->get_shrink_order();

        $node .= sprintf ' minus %s', glue_to_string($shrink, $order);
    }

    return $node;
}

sub to_string :STRINGIFY {
    my $self = shift;

    return " ";
}

1;

__END__
