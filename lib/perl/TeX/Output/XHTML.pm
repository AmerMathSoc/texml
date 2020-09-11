package TeX::Output::XHTML;

use strict;
use warnings;

use version; our $VERSION = qv '0.1.0';

use UNIVERSAL;

use base qw(TeX::Output::XML);

use TeX::Class;

use XML::LibXML;

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %head_of :ATTR(:name<head> :type<XML::LibXML::Element>);
my %body_of :ATTR(:name<body> :type<XML::LibXML::Element>);

my %has_mathjax_loaded_of :BOOLEAN(:name<has_mathjax_loaded> :default<0>);

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub open_document {
    my $self = shift;

    my $filename = shift; ## Dummy argument.

    $self->SUPER::open_document();

    my $tex = $self->get_tex_engine();

    my $dom = $self->get_dom();

    my $root_node = $dom->getDocumentElement();

    my $head = $dom->createElement("head");
    my $body = $dom->createElement("body");

    $root_node->appendChild($head);
    $root_node->appendChild($body);

    $self->set_head($head);
    $self->set_body($body);

    $self->set_current_element($body);

    if ($tex->use_mathjax()) {
        $self->__include_mathjax();
    }

    return;
}

sub close_document {
    my $self = shift;

    my $tex = $self->get_tex_engine();

    my %css_classes = %{ $tex->get_css_classes };

    if (%css_classes) {
        my $dom = $self->get_dom();

        my $style = $dom->createElement("style");

        $style->setAttribute(type => "text/css");

        while (my ($selector, $body) = each %css_classes) {
            $style->appendText(qq{\n$selector { $body }});
        }

        $style->appendText(qq{\n});

        $self->append_to_head($style);
    }

    $self->SUPER::close_document();

    return;
}

sub __include_mathjax {
    my $self = shift;

    return if $self->has_mathjax_loaded();

    my $dom = $self->get_dom();

    ## There must be an easier way to do this.

    my $config_script = $dom->createElement("script");

    $config_script->setAttribute(type => "text/x-mathjax-config");

    $config_script->appendText(<< 'EOF');
  MathJax.Hub.Config({
    extensions: ["TeX/AMScd.js"],
  });
EOF

    my $load_script = $dom->createElement("script");

    $load_script->setAttribute(type => "text/javascript");

    # $load_script->setAttribute(src => "/mathjax/dpvc-MathJax-3a93b7a/MathJax.js?config=TeX-AMS-MML_HTMLorMML");

$load_script->setAttribute(src => "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML");

    $self->append_to_head($config_script, $load_script);

    return;
}

sub append_to_head {
    my $self = shift;

    my $head = $self->get_head();

    for my $node (@_) {
        $head->appendChild($node);
    }

    return;
}

sub add_link {
    my $self = shift;

    my $atts = shift;

    my $dom = $self->get_dom();

    my $link = $dom->createElement("link");

    if (defined $atts) {
        if (! UNIVERSAL->isa($atts, 'HASH')) {
            die "Stop being bloody daft";
        }

        while (my ($key, $val) = each %{ $atts }) {
            $link->setAttribute($key, $val);
        }
    }

    $self->append_to_head($link);

    return;
}

1;

__END__
