package TeX::Primitive::fontname;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $fnt = $tex->scan_font_ident();

    $tex->conv_toks("a-font-name");

    return;
}

1;

__END__
