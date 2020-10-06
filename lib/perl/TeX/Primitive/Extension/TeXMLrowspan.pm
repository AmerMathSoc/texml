package TeX::Primitive::Extension::TeXMLrowspan;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

use TeX::Utils::Misc;

use Digest::MD5 qw(md5_hex);

use File::Spec::Functions qw(catdir);

use File::Copy;

use XML::LibXML;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $num_rows = $tex->scan_int();
    my $num_cols = $tex->scan_int();

    if ($num_rows < 1) {
        $tex->print_err("$num_rows is an invalid num_rows parameter for \\TeXMLrowspan");

        $tex->set_help("It should be at least 2.");

        $tex->error();

        return;
    }

    if ($num_cols < 1) {
        $tex->print_err("$num_cols is an invalid num_cols parameter for \\TeXMLrowspan");

        $tex->set_help("It should be at least 1.");

        $tex->error();

        return;
    }

    $tex->init_span_record($num_rows, $num_cols);

    return;
}

1;

__END__
