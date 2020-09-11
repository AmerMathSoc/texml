package TeX::Node::AbstractNode;

use strict;
use warnings;

use TeX::Class;

use TeX::WEB2C qw(:node_params);

my %link_of    :ATTR(:get<link>    :set<link>);
my %type_of    :ATTR(:get<type>    :set<type> :default<-1>);
my %subtype_of :ATTR(:get<subtype> :set<subtype> :default(0));

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $link_of{$ident}    = $arg_ref->{link};
    $type_of{$ident}    = $arg_ref->{type};
    $subtype_of{$ident} = $arg_ref->{subtype};

    return;
}

sub is_char_node {
    return 0;
}

sub is_glue {
    return 0;
}

sub is_kern {
    return 0;
}

sub is_rule {
    return 0;
}

sub is_box {
    my $self = shift;

    return $self->get_type() <= vlist_node;
}

sub is_hbox {
    my $self = shift;

    return $self->get_type() == hlist_node;
}

sub is_vbox {
    my $self = shift;

    return $self->get_type() == vlist_node;
}

sub precedes_break {
    my $self = shift;

    return $self->get_type() < math_node;
}

sub non_discardable {
    my $self = shift;

    return $self->get_type() < math_node;
}

sub is_atom {
    my $self = shift;

    return;
}

sub first_pass {
    my $self = shift;

    return;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    return;
}

sub get_new_hlist {
    my $self = shift;

    return;
}

sub append {
    my $self = shift;

    my $node = shift;

    my $tail = $self;

    while (defined $tail->get_link()) {
        $tail = $tail->get_link();
    }

    $tail->set_link($node);

    return;
}

sub show_node {
    my $self = shift;

    return ref($self);
}

1;

__END__

*hlist_node                    => 0,
*vlist_node                    => 1,
*rule_node                     => 2,
*ins_node                      => 3,
*mark_node                     => 4,
*adjust_node                   => 5,
*ligature_node                 => 6,
*disc_node                     => 7,
*whatsit_node                  => 8,
*math_node                     => 9,
*glue_node                     => 10,
*kern_node                     => 11,
*penalty_node                  => 12,
*unset_node                    => 13,

style_node                    => 14,    # unset_node + 1
choice_node                   => 15,    # unset_node + 2

# delta_node                    => 2;

# Subtypes of whatsit_node:

*open_node                     => 0;
*write_node                    => 1;
*close_node                    => 2;
*special_node                  => 3;
*language_node                 => 4;
