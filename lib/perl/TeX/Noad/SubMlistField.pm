package TeX::Noad::SubMlistField;

use strict;
use warnings;

use base qw(TeX::Noad::AbstractField);

use TeX::Class;

my %mlist_of :ATTR(:get<mlist> :set<mlist> :init_arg => 'mlist');

sub is_sub_mlist {
    return 0;
}

sub to_hlist {
    my $self = shift;
    my $engine = shift;

    my $save_style = $engine->get_current_style();

    my $hlist = $engine->mlist_to_hlist($self->get_mlist());

    $engine->set_current_style($save_style);

    $engine->set_font_params();

    return wantarray ? ($hlist->hpack($engine, 0, 1), undef) : $hlist;
}

sub to_clean_box {
    my $self = shift;

    my $clean_box = scalar $self->to_hlist(@_);

    return $clean_box;
}

1;

__END__
