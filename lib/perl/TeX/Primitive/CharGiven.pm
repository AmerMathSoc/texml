package TeX::Primitive::CharGiven;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Readable);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

my %encoding_of :ATTR(:name<encoding> :default<"">);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(int_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    my $char_code = $self->get_value();
    my $encoding  = $self->get_encoding();

    $tex->append_char($char_code, $encoding);

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print_esc("char");

    my $char_code = $self->get_value();

    $tex->print_hex($char_code);
    
    return;
}

1;

__END__
