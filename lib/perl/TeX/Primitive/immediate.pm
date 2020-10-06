package TeX::Primitive::immediate;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $next_token = $tex->get_x_token();
    my $next_cmd   = $tex->get_meaning($next_token);

    if ($next_cmd->isa("TeX::Primitive::FileOp")) {
        $next_cmd->execute($tex, $next_token);

        my $node = $tex->pop_node();

        if (defined($node)) {
            $tex->do_file_output($node);
        }
    } else {
        $tex->back_input($next_token);
    }

    return;
}

1;

__END__
