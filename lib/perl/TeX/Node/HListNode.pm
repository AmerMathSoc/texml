package TeX::Node::HListNode;

use strict;
use warnings;

use integer;

use base qw(Exporter);

our %EXPORT_TAGS = (factories => [ qw(new_null_box) ] );

our @EXPORT_OK = @{ $EXPORT_TAGS{factories} };

our @EXPORT;

use TeX::Arithmetic qw(:string unity);

use TeX::WEB2C qw(:box_params :node_params :type_bounds);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

## list_ptr is used when we're extracting information from a .fmt file.
## node is used by TeX::Interpreter

my %list_ptr_of   :ATTR(:name<list_ptr>);

my %node_of      :ARRAY(:name<node>);

my %height_of     :ATTR(:name<height> :default<0>);
my %width_of      :ATTR(:name<width>  :default<0>);
my %depth_of      :ATTR(:name<depth>  :default<0>);
my %shift_of      :ATTR(:name<shift>  :default<0>);

my %glue_set_of   :ATTR(:name<glue_set>   :default<0.0>);
my %glue_sign_of  :ATTR(:name<glue_sign>  :default<normal>);
my %glue_order_of :ATTR(:name<glue_order> :default<normal>);

my %total_stretch_of :ATTR;
my %total_shrink_of  :ATTR;

my %natural_width_of :ATTR(:get<natural_width> :set<natural_width>);

sub new_null_box {
    my $arg_hash = shift || {};

    return TeX::Node::HListNode->new($arg_hash);
}

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_type(hlist_node);
    $self->set_subtype(min_quarterword);

    return;
}

sub clear_dimensions {
    my $self = shift;

    my $ident = ident $self;

    $self->set_height(0);
    $self->set_depth(0);
    $self->set_natural_width(0);

    $total_stretch_of{$ident} = [0, 0, 0, 0];
    $total_shrink_of{$ident}  = [0, 0, 0, 0];

    return;
}

sub update_height {
    my $self = shift;

    my $new_height = shift;

    if ($new_height > $self->get_height()) {
        $self->set_height($new_height);
    }

    return;
}

sub update_depth {
    my $self = shift;

    my $new_depth = shift;

    if ($new_depth > $self->get_depth()) {
        $self->set_depth($new_depth);
    }

    return;
}

sub update_natural_width {
    my $self = shift;

    my $width = shift;

    $natural_width_of{ident $self} += $width;

    return;
}

sub update_stretch {
    my $self = shift;

    my $order = shift;
    my $width = shift;

    $total_stretch_of{ident $self}->[$order] += $width;

    return;
}

sub update_shrink {
    my $self = shift;

    my $order = shift;
    my $width = shift;

    $total_shrink_of{ident $self}->[$order] += $width;

    return;
}

sub increase_width {
    my $self = shift;

    my $extra = shift;

    $width_of{ident $self} += $extra;
}

sub get_total_shrink {
    my $self = shift;

    my @glue = @{ $total_shrink_of{ident $self} };

    return wantarray ? @glue : \@glue;
}

sub shrink_order {
    my $self = shift;

    my @glue = $self->get_total_shrink();

    for my $order (filll, fill, fil) {
        return $order if $glue[$order] != 0;
    }

    return normal;
}

sub get_total_stretch {
    my $self = shift;

    my @glue = @{ $total_stretch_of{ident $self} };

    return wantarray ? @glue : \@glue;
}

sub stretch_order {
    my $self = shift;

    my @glue = $self->get_total_stretch();

    for my $order (filll, fill, fil) {
        return $order if $glue[$order] != 0;
    }

    return normal;
}

sub __glue_ratio {
    my $num = shift;
    my $den = shift;

    no integer;

    return $num/$den;
}

sub hpack {
    my $self = shift;

    my $width = shift || 0;

    # mode:
    #   0: width is exact      (\hbox to...)
    #   1: width is additional (\hbox spread...)

    my $mode  = defined $_[0] ? shift : additional;

    # verbose("## hpacking ", $self->show_node, "\n");
    # verbose("## width=", scaled_to_string($width), "\n");
    # verbose("## mode=", qw(exactly additional)[$mode], "\n");

    my $box = new_null_box();

    $box->clear_dimensions();

    $box->set_list_ptr($self->get_list_ptr());

    my $node = $self->get_list_ptr();

    while (defined $node) {
        $node->incorporate_size($box);

        $node = $node->get_link();
    }

    my $natural_width = $box->get_natural_width();

    if ($mode == additional) {
        $width += $natural_width;
    }

    $box->set_width($width);

    my $excess = $width - $natural_width;

    # verbose("## goal width=", scaled_to_string($width), "\n");
    # verbose("## natural width=", scaled_to_string($natural_width), "\n");
    # verbose("## excess=", scaled_to_string($excess), "\n");

    if ($excess == 0) {
        $box->set_glue_sign(normal);
        $box->set_glue_order(normal);
        $box->set_glue_set(0.0);
    } else {
        if ($excess > 0) {
            my $order = $box->stretch_order();

            $box->set_glue_order($order);
            $box->set_glue_sign(stretching);

            my $stretch = $box->get_total_stretch()->[$order];

            # verbose("## stretch = ", glue_to_string($stretch, $order), "\n");

            if ($stretch != 0) {
                $box->set_glue_set(__glue_ratio($excess, $stretch));
            } else {
                $box->set_glue_sign(normal);
                $box->set_glue_set(0.0);
            }

            # Omit underfull hbox warning.
        } else {
            my $order = $box->shrink_order();

            $box->set_glue_order($order);
            $box->set_glue_sign(shrinking);

            my $shrink = $box->get_total_shrink()->[$order];
        
            # verbose("## shrink = ", glue_to_string($shrink, $order), "\n");

            if ($shrink != 0) {
                $box->set_glue_set(__glue_ratio(-x, $shrink));
            } else {
                $box->set_glue_sign(normal);
                $box->set_glue_set(0.0);
            }

            # Omit overfull and tight hbox warnings.
        }
    }

    return $box;
}

sub incorporate_size {
    my $self = shift;

    my $hlist = shift;

    $hlist->update_natural_width($self->get_width());

    my $s = $self->get_shift();

    $hlist->update_height($self->get_height() - $s);
    $hlist->update_depth ($self->get_depth()  + $s);

    return;
}

sub show_node {
    my $self = shift;

    my $height = $self->get_height();
    my $depth  = $self->get_depth();
    my $width  = $self->get_width();

    my $box_type = $self->get_type() == hlist_node ? 'hbox' : 'vbox';

    my $node = sprintf '\\%s(%s+%s)x%s', ($box_type,
                                          scaled_to_string($height),
                                          scaled_to_string($depth),
                                          scaled_to_string($width));

    my $glue_set   = $self->get_glue_set();
    my $glue_sign  = $self->get_glue_sign();

    if ($glue_set != 0.0 && $glue_sign != normal) {
        $node .= ", glue set ";

        if ($glue_sign == shrinking) {
            $node .= "-";
        }

        $node .= glue_set_to_string($glue_set, $self->get_glue_order());
    }

    my $shift = $self->get_shift();

    if ($shift != 0) {
        $node .= ", shifted ";
        $node .= scaled_to_string($shift);
    }

    return $node;
}

sub to_string :STRINGIFY {
    my $self = shift;

    my @nodes = $self->get_nodes();

    local $" = '';

    return "@nodes";
}

1;

__END__
