package TeX::Primitive::unskip;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $cur_list = $tex->get_cur_list();

    my $tail = $cur_list->get_node(-1);

    return unless defined $tail;

    ## TODO: Check for TeX::Node::XmlAttributeNode, etc.?

    if ($tail->isa("TeX::Node::GlueNode")) {
        $cur_list->pop_node();
    } elsif ($tail->isa("TeX::Node::CharNode")) {
        my $char_code = $tail->get_char_code();

        if ($tex->is_whitespace($char_code)) {
            $cur_list->pop_node();
        }
    }

    return;
}

1;

__END__
