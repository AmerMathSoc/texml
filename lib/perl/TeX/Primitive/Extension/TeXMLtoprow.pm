package TeX::Primitive::Extension::TeXMLtoprow;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

use base qw(TeX::Primitive::LastItem);

use TeX::Class;

use TeX::WEB2C qw(:command_codes);

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $row = $tex->scan_int();
    my $col = $tex->scan_int();

    my $cur_align = $tex->get_cur_alignment();

    if (! defined $cur_align) {
        $tex->print_err("You can't use \\TeXMLtoprow outside of an alignment");

        $tex->set_help("Really, mate, you can't.");

        $tex->error();

        return;
    }

    return $cur_align->top_row($row, $col);
}

1;

__END__
