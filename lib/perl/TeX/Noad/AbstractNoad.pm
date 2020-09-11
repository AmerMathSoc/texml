package TeX::Noad::AbstractNoad;

use strict;
use warnings;

use Carp;

use TeX::Class;

use TeX::WEB2C qw(:math_params :math_classes :extras :styles);

use TeX::Utils qw(odd);

use TeX::Noad::EmptyField;

my $EMPTY = TeX::Noad::EmptyField->new();

my %class_of :ATTR(:get<class>);

my %nucleus_of     :ATTR(:set<nucleus>     :get<nucleus>     :default($EMPTY));
my %subscript_of   :ATTR(:set<subscript>   :get<subscript>   :default($EMPTY));
my %superscript_of :ATTR(:set<superscript> :get<superscript> :default($EMPTY));

my %limits_of      :ATTR(:get<limits>);

my %new_hlist_of   :ATTR(:get<new_hlist> :set<new_hlist>);

my %NOAD_NAME = (
    ord_noad     , 'ord_noad',
    op_noad      , 'op_noad',
    bin_noad     , 'bin_noad',
    rel_noad     , 'rel_noad',
    open_noad    , 'open_noad',
    close_noad   , 'close_noad',
    punct_noad   , 'punct_noad',
    inner_noad   , 'inner_noad',
    radical_noad , 'radical_noad',
    fraction_noad, 'fraction_noad',
    under_noad   , 'under_noad',
    over_noad    , 'over_noad',
    accent_noad  , 'accent_noad',
    vcenter_noad , 'vcenter_noad',
    left_noad    , 'left_noad',
    right_noad   , 'right_noad',
);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $class_of{$ident}       = $arg_ref->{class};
    $nucleus_of{$ident}     = $arg_ref->{nucleus};
    $subscript_of{$ident}   = $arg_ref->{subscript};
    $superscript_of{$ident} = $arg_ref->{superscript};
    $limits_of{$ident}      = $arg_ref->{limits} || display_limits;

    return;
}

sub set_class {
    my $self = shift;

    my $class = shift;

    if ($class < ord_noad || $class > right_noad) {
        croak "Invalid noad class $class";
    }

    $class_of{ident $self} = $class;

    return;
}

sub has_subscript {
    my $self = shift;

    my $script = $self->get_subscript();

    return defined $script && ! $script->is_empty();
}

sub has_superscript {
    my $self = shift;

    my $script = $self->get_superscript();

    return defined $script && ! $script->is_empty();
}

sub has_scripts {
    my $self = shift;

    return $self->has_subscript() || $self->has_superscript();
}

sub is_atom {
    my $self = shift;

    return 1;
}

sub get_spacing_class {
    my $self = shift;

    my $spacing_class = $self->get_class() - ord_noad;

    if ($spacing_class > MATH_VAR) {
        $spacing_class = MATH_ORD;
    }

    return $spacing_class;
}

sub is_ord_noad {
    my $self = shift;

    return $self->get_class() == MATH_ORD;
}

sub is_op_noad {
    my $self = shift;

    return $self->get_class() == MATH_OP;
}

sub is_bin_noad {
    my $self = shift;

    return $self->get_class() == MATH_BIN;
}

sub is_rel_noad {
    my $self = shift;

    return $self->get_class() == MATH_REL;
}

sub is_open_noad {
    my $self = shift;

    return $self->get_class() == MATH_OPEN;
}

sub is_close_noad {
    my $self = shift;

    return $self->get_class() == MATH_CLOSE;
}

sub is_punct_noad {
    my $self = shift;

    return $self->get_class() == MATH_PUNCT;
}

sub set_diplaylimits() {
    my $self = shift;

    $limits_of{ident $self} = display_limits;

    return;
}

sub set_limits() {
    my $self = shift;

    $limits_of{ident $self} = limits;

    return;
}

sub set_nolimits() {
    my $self = shift;

    $limits_of{ident $self} = no_limits;

    return;
}

sub get_class_name {
    my $self = shift;

    return $NOAD_NAME{ $self->get_class() };
}

sub first_pass {
    my $self = shift;
    my $engine = shift;
    my $prev_atom = shift;

    my $delta = $self->convert_to_hlist($engine);

    my $hlist = $self->get_new_hlist()->hpack($engine);

    return ($delta, $hlist->get_height(), $hlist->get_depth(), $hlist->get_width());
}

sub convert_to_hlist {
    my $self = shift;
    my $engine = shift;

    my $nucleus = $self->get_nucleus();

    my ($p, $delta) = $nucleus->to_hlist($engine, $self);

    $self->set_new_hlist($p);

    if ($self->has_scripts()) {
        $self->make_scripts($engine, $delta);
    }

    return $delta;
}

sub make_scripts {
    my $self = shift;

    my $engine = shift;
    my $delta = shift;

    use integer;

    my $cur_style = $engine->get_current_style();
    my $cur_size  = $engine->get_current_size();

    my $x_height = abs($engine->math_x_height($cur_size));

    my $p = $self->get_new_hlist();

    my $shift_up   = 0;
    my $shift_down = 0;

    if ($p->is_char_node()) {
        $shift_up = 0;
        $shift_down = 0;
    } else {
        my $z = $p->hpack($engine);

        my $t;

        if ($cur_style < script_style) {
            $t = script_size;
        } else {
            $t = script_script_size;
        }

        $shift_up   = $z->get_height() - $engine->sup_drop($t);
        $shift_down = $z->get_depth()  + $engine->sub_drop($t);
    }

    my $x;

    if ($self->has_superscript()) {
        $x = $engine->clean_box($self->get_superscript(),
                                sup_style($cur_style));
    
        $x->increase_width($engine->get_script_space());
    
        my $clr;

        if (odd($cur_style)) {
            $clr = $engine->math_sup3($cur_size);
        } elsif ($cur_style < text_style) {
            $clr = $engine->math_sup1($cur_size);
        } else {
            $clr = $engine->math_sup2($cur_size);
        }
    
        if ($shift_up < $clr) {
            $shift_up = $clr;
        }
    
        $clr = $x->get_depth() + $x_height/4;

        if ($shift_up < $clr) {
            $shift_up = $clr;
        }

        if ($self->has_subscript()) {
            # @<Construct a sub/superscript combination box |x|, with
            #   the superscript offset by |delta|@>;
        } else {
            $x->set_shift(-$shift_up);
        }
    } else {
        $x = $engine->clean_box($self->get_subscript(),
                                sub_style($cur_style));

        $x->increase_width($engine->get_script_space());

        my $sub1 = $engine->math_sub1($cur_size);

        if ($shift_down < $sub1) {
            $shift_down = $sub1;
        }

        my $clr = $x->get_height() - (4 * $x_height)/5;

        if ($shift_down < $clr) {
            $shift_down = $clr;
        }

        $x->set_shift($shift_down);
    }

    if (! defined $self->get_new_hlist()) {
        $self->set_new_hlist($x);
    } else {
        my $p = $self->get_new_hlist();

        $p->append($x);
    }

    return;
}

sub debug {
    my $self = shift;

    print STDERR "AbstractNoad::show($self):\n";
    print STDERR "\tnucleus = ", $self->get_nucleus(), "\n";
    print STDERR "\tsuperscript = ", $self->get_superscript(), "\n";
    print STDERR "\tsubscript = ", $self->get_subscript(), "\n";

    return;
}

1;

__END__

@d ord_noad      = unset_node+3    {|type| of a noad classified Ord}
@d op_noad       = ord_noad+1      {|type| of a noad classified Op}
@d bin_noad      = ord_noad+2      {|type| of a noad classified Bin}
@d rel_noad      = ord_noad+3      {|type| of a noad classified Rel}
@d open_noad     = ord_noad+4      {|type| of a noad classified Ope}
@d close_noad    = ord_noad+5      {|type| of a noad classified Clo}
@d punct_noad    = ord_noad+6      {|type| of a noad classified Pun}
@d inner_noad    = ord_noad+7      {|type| of a noad classified Inn}
@d radical_noad  = inner_noad+1    {|type| of a noad for square roots}
@d*fraction_noad = radical_noad+1  {|type| of a noad for generalized fractions}
@d under_noad    = fraction_noad+1 {|type| of a noad for underlining}
@d over_noad     = under_noad+1    {|type| of a noad for overlining}
@d accent_noad   = over_noad+1     {|type| of a noad for accented subformulas}
@d vcenter_noad  = accent_noad+1   {|type| of a noad for \.{\\vcenter}}
@d*left_noad     = vcenter_noad+1  {|type| of a noad for \.{\\left}}
@d*right_noad    = left_noad+1     {|type| of a noad for \.{\\right}}

@d scripts_allowed(#)==(type(#)>=ord_noad)and(type(#)<left_noad)
