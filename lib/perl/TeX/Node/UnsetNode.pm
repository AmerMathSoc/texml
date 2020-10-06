package TeX::Node::UnsetNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params :type_bounds);

my %height_of     :ATTR(:get<height>     :set<height>     :default(0));
my %width_of      :ATTR(:get<width>      :set<width>      :default(0));
my %depth_of      :ATTR(:get<depth>      :set<depth>      :default(0));
my %span_count_of :ATTR(:get<span_count> :set<span_count> :default(0));
my %contents_of   :ATTR(:get<contents>   :set<contents>);
my %stretch_of    :ATTR(:get<stretch>    :set<stretch>    :default(0.0));
my %shrink_of     :ATTR(:get<shrink>     :set<shrink>     :default(0.0));
my %glue_sign_of  :ATTR(:get<glue_sign>  :set<glue_sign>  :default(normal));
my %glue_order_of :ATTR(:get<glue_order> :set<glue_order> :default(normal));

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(unset_node);
    $self->set_subtype(min_quarterword);

    return;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    $hlist->update_natural_width($self->get_width());

    $hlist->update_height($self->get_height());
    $hlist->update_depth ($self->get_depth());

    return;
}

1;

__END__
