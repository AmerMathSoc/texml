package TeX::Primitive::patterns;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::WEB2C qw(:catcodes);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $level = 0;

    while (my $token = $tex->get_next()) {
        if ($token == CATCODE_BEGIN_GROUP) {
            $level++;
        }
        elsif ($token == CATCODE_END_GROUP) {
            $level--;

            last if $level == 0;
        }
    }

    return;
}

1;

__END__
