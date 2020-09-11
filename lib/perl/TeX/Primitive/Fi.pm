package TeX::Primitive::Fi;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

my %fi_code_of :COUNTER(:name<fi_code>); # fi_code, else_code or or_code

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    die;

    return;
}

1;

__END__
