package TeX::Noad::StyleNode;

use strict;
use warnings;

use TeX::WEB2C qw(:math_params :node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::WEB2C qw(:node_params);

use TeX::Class;

my %style_of :ATTR(:set<style> :get<style> :init_arg => 'style');

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(style_node);

    return;
}

sub first_pass {
    my $self = shift;

    my $engine = shift;

    $engine->set_current_style($self->get_style());

    $engine->set_font_params();

    return;
}

1;

__END__
