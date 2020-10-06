package TeX::Output::Buffer;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use TeX::Class;

use TeX::Interpreter;

my %buffer_of       :ATTR(:name<buffer>);
my %num_newlines_of :COUNTER(:name<num_newlines> :default<-1>);
my %empty_of        :BOOLEAN(:name<empty> :default<1>);

my %tex_engine_of :ATTR(:name<tex_engine> :type<TeX::Interpreter>);

sub open_document {
    my $self = shift;

    $self->set_empty(1);

    return;
}

sub close_document {
    my $self = shift;

    return;
}

sub clear_buffer {
    my $self = shift;

    my $text = $self->get_buffer();

    $self->set_buffer("");

    return $text;
}

sub flush_buffer {
    my $self = shift;

    return;
}

sub output( $ ) {
    my $self = shift;

    my $text = shift;

    $buffer_of{ident $self} .= $text;

    return;
}

sub newline( ;$ ) {
    my $self = shift;

    my $target = exists $_[0] ? shift : 1;

    $self->flush_buffer();

    return if $self->is_empty();

    my $num_newlines = $self->num_newlines();

    if ($num_newlines > -1) {
        if ($num_newlines < $target) {
            my $needed = $target - $num_newlines;

            $self->output("\n" x $needed);

            $self->flush_buffer();

            $self->set_num_newlines($target);
        }
    }

    return;
}

######################################################################
##                                                                  ##
##                     [32] SHIPPING PAGES OUT                      ##
##                                                                  ##
######################################################################

sub hlist_out {
    my $self = shift;

    my $box = shift;

    my $tex = $self->get_tex_engine();

    for my $node ($box->get_nodes()) {
        if ($node->isa('TeX::Node::Extension::UnicodeStringNode')) {
            $self->output($node->get_contents());

            next;
        }

        if ($node->isa('TeX::Node::CharNode')) {
            $self->output(chr($node->get_char_code()));

            next;
        }

        if ($node->isa('TeX::Token')) { ## Extension
            $self->output($node);

            next;
        }

        if ($node->isa("TeX::Node::VListNode")) {
            $self->vlist_out($node);

            next;
        }

        if ($node->isa("TeX::Node::HListNode")) {
            $self->hlist_out($node);

            next;
        }

        if ($node->isa("TeX::Node::RuleNode")) {
            ## rule_ht := height(p);
            ## rule_dp := depth(p);
            ## rule_wd := width(p);
            ## goto fin_rule;

            $tex->print_err("RuleNodes not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa("TeX::Node::WhatsitNode")) {
            ## @<Output the whatsit node |p| in an hlist@>;

            $tex->print_err("WhatsitNodes not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa('TeX::Node::GlueNode')) {
            $self->output(" ");

            next;
        }

        if ($node->isa('TeX::Node::KernNode')) {
            $self->output(" ");

            next;
        }

        if ($node->isa('TeX::Node::MathNode')) {
            $self->output(" "); # ???

            next;
        }

        if ($node->isa('TeX::Node::LigatureNode')) {
            # @<Make node |p| look like a |char_node| and |goto reswitch|@>;

            $tex->print_err("WhatsitNodes not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa('TeX::Node::MarkNode')) {
            next;
        }

        if ($node->isa('TeX::Node::PenaltyNode')) {
            next;
        }

        $tex->print_err("I didn't expect to find '$node' ",
                        ref($node),
                        " in the middle of an hlist!");

        $tex->error();
    }

    $self->flush_buffer();

    return;
}

sub vlist_out {
    my $self = shift;

    my $box = shift;

    my $tex = $self->get_tex_engine();

    my @nodes = $box->get_nodes();

    for my $node (@nodes) {
        if ($node->isa('TeX::Node::Extension::UnicodeStringNode')) {
            $self->output($node->get_contents());

            next;
        }

        if ($node->isa('TeX::Node::CharNode')) {
            $tex->confusion("vlistout");
        }

        if ($node->isa("TeX::Node::VListNode")) {
            $self->vlist_out($node);

            next;
        }

        if ($node->isa("TeX::Node::HListNode")) {
            $self->hlist_out($node);

            next;
        }

        if ($node->isa("TeX::Node::RuleNode")) {
            ## rule_ht := height(p);
            ## rule_dp := depth(p);
            ## rule_wd := width(p);
            ## goto fin_rule;

            $tex->print_err("RuleNodes not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa("TeX::Node::WhatsitNode")) {
            ## @<Output the whatsit node |p| in an hlist@>;

            $tex->print_err("WhatsitNodes not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa('TeX::Node::GlueNode')) {
            $self->newline($tex->newlines_per_par());

            next;
        }

        if ($node->isa('TeX::Node::KernNode')) {
            $self->newline($tex->newlines_per_par());

            next;
        }

        if ($node->isa('TeX::Token')) {
            $self->output($node->to_string());

            next;
        }

        if ($node->isa('TeX::Node::MarkNode')) {
            next;
        }

        if ($node->isa('TeX::Node::PenaltyNode')) {
            next;
        }

        $tex->print_err("I didn't expect to find a ",
                         ref($node),
                         " ('$node') in the middle of a vlist!");
        $tex->error();
    }

    $self->flush_buffer();

    return;
}

1;

__END__
