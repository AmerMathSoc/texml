package TeX::Primitive::vbox;

use strict;
use warnings;

use base qw(TeX::Primitive::MakeBox);

use TeX::Class;

use TeX::WEB2C qw(:box_params :command_codes :save_stack_codes :token_types);

use TeX::Constants qw(:booleans);

sub scan_box {
    my $self = shift;

    my $tex         = shift;
    my $box_context = shift;

    $tex->push_save_stack($box_context);

    $tex->scan_spec(vbox_group, true);

    $tex->normal_paragraph();

    $tex->push_nest();

    $tex->set_cur_mode(- vmode);

    $tex->set_prevdepth(ignore_depth);

    $tex->begin_token_list($tex->get_toks_list('every_vbox'), every_vbox_text);

    return;
}

1;

__END__
