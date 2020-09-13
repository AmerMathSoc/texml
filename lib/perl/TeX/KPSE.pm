package TeX::KPSE;

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(kpse_lookup
                             kpse_path_search
                             kpse_reset_program_name)
                    ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

sub kpse_lookup( $ ) {
    my $file_name = shift;

    chomp(my $path = qx{kpsewhich '$file_name'});

    return $path eq '' ? undef : $path;
}

sub kpse_path_search( $$ ) {
    my $search_path = shift;
    my $file_name   = shift;

    chomp(my $path = qx{kpsewhich -path '$search_path' '$file_name'});

    return $path eq '' ? undef : $path;
}

sub kpse_reset_program_name( $ ) {
    my $progname = shift;

    # NO_OP

    return;
}

1;

__END__
