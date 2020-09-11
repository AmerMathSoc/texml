package TeX::Node::DiscretionaryNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::WEB2C qw(:node_params);

my %replace_count_of :ATTR(:get<replace_count> :set<replace_count> :default(0));
my %pre_break_of     :ATTR(:get<pre_break>     :set<pre_break>);
my %post_break_of    :ATTR(:get<post_break>    :set<post_break>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(disc_node);

    $replace_count_of{$ident} = $arg_ref->{replace_count};
    $pre_break_of    {$ident} = $arg_ref->{pre_break};
    $post_break_of   {$ident} = $arg_ref->{post_break};

    return;
}

1;

__END__
