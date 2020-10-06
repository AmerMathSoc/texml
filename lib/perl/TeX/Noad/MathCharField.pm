package TeX::Noad::MathCharField;

use strict;
use warnings;

use Carp;

use TeX::Nodes qw(:factories);
use TeX::Node::HListNode qw(:factories);

use base qw(TeX::Noad::AbstractField);

use TeX::Class;

my %family_of    :ATTR(:get<family>    :set<family>    :init_arg => 'family');
my %char_code_of :ATTR(:get<char_code> :set<char_code> :init_arg => 'char_code');

sub get_character {
    my $self = shift;

    return chr($self->get_char_code());
}

sub is_math_char {
    return 1;
}

sub to_hlist {
    my $self = shift;

    my $engine = shift;

    my $parent_noad = shift;

    my $fam = $self->get_family();
    my $char = $self->get_char_code();

    my $font = $engine->get_math_font($fam);

    my $h = $font->get_char_height($char);
    my $d = $font->get_char_depth($char);
    my $w = $font->get_char_width($char);

    my $delta = $font->get_char_italic_correction($char);

    if (! defined $delta) {
        croak "Unknown character $char in $font";
    }

    my $p = new_character($font, $char);

    if ($self->is_math_text_char() && $font->is_text_font()) {
        $delta = 0; # {no italic correction in mid-word of text font}
    }

    if (! $parent_noad->has_subscript() && $delta != 0) {
        $w += $delta;

        $p->set_link(new_kern($delta));

        $delta = 0;
    }

    return wantarray ? ($p, $delta) : $p;
}

sub to_clean_box {
    my $self = shift;

    return scalar $self->to_hlist(@_);
}

1;

__END__
