package TeX::Primitive::Extension::importXMLfragment;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

use TeX::KPSE qw(kpse_lookup);

use TeX::Utils::Misc qw(empty);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $xpath    = $tex->read_undelimited_parameter(EXPANDED);
    my $xml_file = $tex->read_undelimited_parameter(EXPANDED);

    my $xml_path = kpse_lookup($xml_file);

    if (empty($xml_path)) {
        $tex->print_err("I can't find file `$xml_file'.");
        $tex->error();

        return;
    }

    $tex->import_xml_fragment($xml_path, $xpath);

    return;
}

1;

__END__
