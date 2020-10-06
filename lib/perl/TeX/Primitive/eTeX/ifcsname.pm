package TeX::Primitive::eTeX::ifcsname;

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::Class;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $token = $tex->do_csname($cur_tok);

    my $meaning = $tex->get_meaning($token);

    my $bool = defined $meaning && ! UNIVERSAL::isa($meaning, "TeX::Primitive::undefined");

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
