package TeX::Node::InsertNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

my %box_number_of       :ATTR(:get<box_number>       :set<box_number>);
my %height_of           :ATTR(:get<height>           :set<height>);
my %depth_of            :ATTR(:get<depth>            :set<depth>);
my %split_top_ptr_of    :ATTR(:get<split_top_ptr>    :set<split_top_ptr>);
my %float_cost_of       :ATTR(:get<float_cost>       :set<float_cost>);
my %floating_penalty_of :ATTR(:get<floating_penalty> :set<floating_penalty>);
my %ins_ptr_of          :ATTR(:get<ins_ptr>          :set<ins_ptr>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(ins_node);

    $box_number_of      {$ident} = $arg_ref->{box_number};
    $height_of          {$ident} = $arg_ref->{height};
    $depth_of           {$ident} = $arg_ref->{depth};
    $split_top_ptr_of   {$ident} = $arg_ref->{split_top_ptr};
    $float_cost_of      {$ident} = $arg_ref->{float_cost};
    $floating_penalty_of{$ident} = $arg_ref->{floating_penalty};
    $ins_ptr_of         {$ident} = $arg_ref->{ins_ptr};

    return;
}

1;

__END__
