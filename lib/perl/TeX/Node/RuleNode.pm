package TeX::Node::RuleNode;

use strict;
use warnings;

use TeX::Arithmetic qw(:string);

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

my %height_of :ATTR(:get<height> :set<height>);
my %width_of  :ATTR(:get<width>  :set<width>);
my %depth_of  :ATTR(:get<depth>  :set<depth>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(rule_node);

    $width_of{$ident}  = $arg_ref->{width};
    $height_of{$ident} = $arg_ref->{height};
    $depth_of{$ident}  = $arg_ref->{depth};

    return;
}

sub is_rule {
    return 1;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    $hlist->update_natural_width($self->get_width());

    $hlist->update_height($self->get_height());
    $hlist->update_depth ($self->get_depth());

    return;
}

sub show_node {
    my $self = shift;

    my $height = $self->get_height();
    my $depth  = $self->get_depth();
    my $width  = $self->get_width();

    my $node = sprintf '\\rule(%s+%s)x%s', (rule_dimen_to_string($height),
                                            rule_dimen_to_string($depth),
                                            rule_dimen_to_string($width));

    return $node;
}

1;

__END__
