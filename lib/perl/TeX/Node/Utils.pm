package TeX::Node::Utils;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(nodes_to_string) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT;

## This could probably be improved.

sub nodes_to_string( @ ) {
    my @nodes = @_;

    local $" = '';

    return "@nodes";
}

1;

__END__
