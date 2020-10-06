package TeX::Primitive::right;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::WEB2C qw(:save_stack_codes);

use TeX::Constants qw(:booleans);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $cur_group = $tex->cur_group();

    # $tex->DEBUG("Doing $cur_tok: cur_group = " . group_type($cur_group));

    if ($cur_group != math_left_group) {
        if ($cur_group == math_shift_group) {
            $tex->scan_delimiter(false);

            $tex->print_err("Extra ");
            $tex->print_esc("right");
    
            $tex->set_help("I'm ignoring a \\right that had no matching \\left.");
    
            $tex->error();
        } else {
            my $m = sprintf q{\right (cur_group = %s)}, group_type($cur_group);

            $tex->off_save($cur_tok, $m);
        }

        return;
    }

    # my $delim = $tex->scan_delimiter(false);

    my $saved_node = $tex->get_node_register('end_math_list');

    $tex->unsave(); # {end of |math_left_group|}

    my $head = $tex->pop_nest();

    $tex->tail_append(@{ $head });

    if (defined $saved_node) {
        $tex->tail_append($saved_node);
    }

    $tex->conv_toks(qq{\\right});

    return;
}

1;

__END__
