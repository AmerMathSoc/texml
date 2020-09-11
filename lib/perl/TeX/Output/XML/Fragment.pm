package TeX::Output::XML::Fragment;

use strict;
use warnings;

use version; our $VERSION = qv '0.3.1';

use base qw(TeX::Output::XML);

my %fragment_of :ATTR(:name<fragment> :type<XML::LibXML::DocumentFragment>);

sub open_document {
    my $self = shift;

    my $filename = shift;  ## Dummy argument for this class.

    my $tex = $self->get_tex_engine();

    my $dom = XML::LibXML::Document->createDocument("1.0", "UTF-8");

    $self->set_dom($dom);

    my $root_node = $dom->createDocumentFragment();

    $self->set_fragment($root_node);

    $self->set_current_element($root_node);

    return;
}

sub close_document {
    my $self = shift;

    return $self->get_fragment();
}

1;

__END__
