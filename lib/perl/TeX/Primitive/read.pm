package TeX::Primitive::read;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $prefix = exists $_[0] ? shift : 0;

    my $fileno = $tex->scan_int();

    if (! $tex->scan_keyword("to")) {
        $tex->print_err("Missing `to' inserted");

        $tex->set_help("You should have said `\\read<number> to \\cs'.",
                       "I'm going to look for the \\cs now.");

        $tex->error();
    }

    my $r_token = $tex->get_r_token();

    my $token_list = $tex->read_toks($fileno, $cur_tok);

    my $macro = TeX::Primitive::Macro->new({ replacement_text => $token_list });

    $tex->define($r_token, $macro, $prefix);

    return;
}

1;

__END__
