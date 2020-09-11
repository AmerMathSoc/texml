package TeX::Primitive::MakeBox;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::WEB2C qw(null_ptr);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $cur_cmd = $tex->get_meaning($cur_tok);

    $tex->begin_box(0, $cur_cmd);

    return;
}

sub scan_box {
    my $self = shift;

    my $tex         = shift;
    my $box_context = shift;

    return null_ptr;
}

1;

__END__
