package TeX::KPSE;

use strict;
use warnings;

use version; our $VERSION = qv '1.2.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(kpse_lookup kpse_reset_program_name) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

my $KPSE_PROGRAM_NAME;

sub _nonempty( $ ) {
    my $string = shift;

    return defined $string && $string =~ /\S/;
}

sub kpse_lookup( $; $ ) {
    my $file_name   = shift;
    my $search_path = shift;

    my $KPSEWHICH = qq{kpsewhich};

    if (_nonempty($KPSE_PROGRAM_NAME)) {
        $KPSEWHICH .= qq{ --progname='$KPSE_PROGRAM_NAME'};
    }

    if (_nonempty($search_path)) {
        $KPSEWHICH .= qq{ --path='$search_path'};
    }

    chomp(my $path = qx{$KPSEWHICH '$file_name'});

    return $path eq '' ? undef : $path;
}

sub kpse_reset_program_name( $ ) {
    $KPSE_PROGRAM_NAME = shift;

    return;
}

1;

__END__
