package TeX::Utils::DOI;

use strict;
use warnings;

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(doi_to_url url_to_doi) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = @EXPORT_OK;

use version; our $VERSION = qv '1.0.0';

use TeX::Utils;

use URI::Escape;

######################################################################
##                                                                  ##
##                         EXPORTED METHODS                         ##
##                                                                  ##
######################################################################

my $DOI_URL_PREFIX = qq{https://doi.org};

sub doi_to_url( $;$ ) {
    my $doi = shift;

    my $escape = shift;

    ## Translate old-style DOI links.

    $doi =~ s{\A https://dx\.doi\.org/}{}smx;

    return $doi if $doi =~ m{\A $DOI_URL_PREFIX}smx;

    if ($escape) {
        $doi = uri_escape($doi);
    }

    return qq{$DOI_URL_PREFIX/$doi};
}

sub url_to_doi( $;$ ) {
    my $url = shift;

    my $unescape = shift;

    (my $doi = $url) =~ s{\A https?://(dx\.)?doi\.org/}{}smx;

    if ($unescape) {
        $doi = uri_unescape($doi);
    }

    return $doi;
}

1;
