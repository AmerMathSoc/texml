package TeX::Primitive::Extension::setXSLfile;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use base qw(TeX::Command::Executable);

use TeX::Utils::Misc;

use TeX::Constants qw(:named_args);

sub execute {
    my $self = shift;
 
    my $tex     = shift;
    my $cur_tok = shift;

    my $name = $tex->read_undelimited_parameter(EXPANDED);

    if (empty($name)) {
        $tex->delete_xsl_file();
    } else {
        $tex->set_xsl_file($name);
    }

    return;
}

1;

__END__
