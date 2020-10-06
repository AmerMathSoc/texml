package TeX::Node::LigatureNode;

use strict;
use warnings;

use TeX::WEB2C qw(:node_params);

use base qw(TeX::Node::CharNode);

use TeX::Class;

my %lig_ptr_of   :ATTR(:get<lig_ptr>   :set<lig_ptr>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(ligature_node);

    $lig_ptr_of{$ident} = $arg_ref->{lig_ptr};

    return;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    ## TBA

    ##  my $font = $self->get_font();
    ##  my $char = $self->get_char_code();
    ##  
    ##  $hlist->update_natural_width($font->get_char_width($char));
    ##  
    ##  $hlist->update_height($font->get_char_height($char));
    ##  $hlist->update_depth($font->get_char_depth($char));

    return;
}

1;

__END__
