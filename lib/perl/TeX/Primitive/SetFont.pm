package TeX::Primitive::SetFont;

use strict;
use warnings;

use base qw(TeX::Command);

use TeX::Class;

my %font :ATTR(:get<font> :set<font> :init_arg => 'font');

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->set_cur_font($self->get_font());

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print("select font ");

    # slow_print(font_name[chr_code]);
    # 
    # if font_size[chr_code] <> font_dsize[chr_code] then
    # begin
    #     print(" at ");
    #     print_scaled(font_size[chr_code]);
    #     print("pt");
    # end;

    return;
}

1;

__END__
