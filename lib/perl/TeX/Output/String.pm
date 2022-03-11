package TeX::Output::String;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

use strict;
use warnings;

use integer;

use Carp;

use base qw(TeX::Output);

use TeX::Class;

use Class::Multimethods;

my %translation_of :ATTR(:get<translation> :set<translation>);

use TeX::Arithmetic qw(scaled_to_string);

use TeX::Utils qw(print_char_code);

use TeX::WEB2C qw(:command_codes :node_params);

sub indent($@) {
    my $self = shift;

    my $string = join "", @_;

    $string =~ s{^}{    }gsmx;

    return $string;
}

sub write_trailer {
    my $self = shift;

    return;
}

sub reset {
    my $self = shift;

    $self->set_translation("");

    return;
}

# sub output {
#     my $self = shift;
# 
#     my $string = shift;
# 
#     $translation_of{ident $self} .= $string;
# 
#     return;
# }

multimethod ship_out
    => __PACKAGE__, qw(TeX::Node::HListNode)
    => sub {
    my $translator = shift;
    my $hlist = shift;

    $translator->output(translate($translator, $hlist));

    return;
};

multimethod "translate"
    => __PACKAGE__, qw(TeX::Node::HListNode)
    => sub {
    my $translator = shift;
    my $hlist = shift;

    my $tag = $hlist->is_hbox() ? "hlist" : "vlist";

    my $width  = scaled_to_string $hlist->get_width();
    my $height = scaled_to_string $hlist->get_height();
    my $depth  = scaled_to_string $hlist->get_depth();

    my $size = "($height+$depth)x$width";

    if ((my $shift = $hlist->get_shift()) != 0) {
        $size .= qq{, shifted } . scaled_to_string($shift);
    }

    my $string = qq{<$tag size="$size"};

    $string .= ">\n";

    my $node = $hlist->get_list_ptr();

    while (defined $node) {
        $string .= $translator->indent(translate($translator, $node));

        $node = $node->get_link();
    }

    $string .= "</$tag>\n";

    return $string;
};

multimethod "translate"
    => __PACKAGE__, qw(TeX::Node::CharNode)
    => sub {
    my $translator = shift;
    my $node = shift;

    my $string = "<char_node>\n";

    my $char_code = $node->get_char_code();
    my $font      = $node->get_font();

    $string .= "    <font>$font</font>\n";
    $string .= "    <char>" . print_char_code($char_code) . "</char>\n";

    $string .= "</char_node>\n";

    return $string;
};

multimethod "translate"
    => __PACKAGE__, qw(TeX::Node::KernNode)
    => sub {
    my $translator = shift;
    my $node = shift;

    my $width = scaled_to_string($node->get_width());

    my $string = qq{<kern width="${width}pt"/>\n};

    return $string;
};

multimethod "translate"
    => __PACKAGE__, qw(TeX::Node::GlueNode)
    => sub {
    my $translator = shift;
    my $node = shift;

    my $subtype = $node->get_subtype();

    my $width = scaled_to_string($node->get_width());

    my $string = qq{<glue subtype="$subtype" width="${width}pt"/>\n};

    return $string;
};

multimethod "translate"
    => __PACKAGE__, qw(TeX::Node::RuleNode)
    => sub {
    my $translator = shift;
    my $node = shift;

    my $height = $node->get_height();
    my $depth  = $node->get_depth();
    my $width  = $node->get_width();

    $height = ($height == null_flag) ? "*" : scaled_to_string($height);
    $depth  = ($depth  == null_flag) ? "*" : scaled_to_string($depth);
    $width  = ($width  == null_flag) ? "*" : scaled_to_string($width);

    return qq{<rule width="$width" height="$height" depth="$depth"/>\n};
};

multimethod "translate"
    => __PACKAGE__, qw(TeX::Node::MathNode)
    => sub {
    my $translator = shift;
    my $node = shift;

    my $subtype = $node->get_subtype();
    my $width = scaled_to_string($node->get_width());

    my $string = qq{<math};

    $string .= ($subtype == before) ? "on" : "off";

    if ($width != 0) {
        $string .= qq{ width = "} . scaled_to_string($width) . qq{"};
    }

    $string .= "/>\n";

    return $string;
};

1;

__END__
