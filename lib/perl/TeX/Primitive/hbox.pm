package TeX::Primitive::hbox;

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

    if ( $box_context < box_flag && $tex->is_vmode() ) {
        $tex->scan_spec(adjusted_hbox_group, true);     
    } else {
        $tex->scan_spec(hbox_group, true);
    }

    $tex->push_nest();

    $tex->set_cur_mode(- hmode);

    $tex->set_spacefactor(1000);

    $tex->begin_token_list($tex->get_toks_list('every_hbox'), every_hbox_text);

    return;
}

1;

__END__
