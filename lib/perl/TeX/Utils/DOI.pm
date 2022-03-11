package TeX::Utils::DOI;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

use strict;
use warnings;

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(doi_to_url url_to_doi) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = @EXPORT_OK;

use version; our $VERSION = qv '1.1.0';

use TeX::Utils;

######################################################################
##                                                                  ##
##                         EXPORTED METHODS                         ##
##                                                                  ##
######################################################################

my $DOI_URL_PREFIX = qq{https://doi.org};

sub doi_to_url( $ ) {
    my $doi = shift;

    ## Translate old-style DOI links.

    $doi =~ s{\A https://dx\.doi\.org/}{}smx;

    return $doi if $doi =~ m{\A $DOI_URL_PREFIX}smx;

    ## Don't try to encode anything that already has a % in it,
    ## because that probably means it has already been URL-encoded.

    ## This is kind of like URI::Escape::escape_uri, but it doesn't replace /

    if ($doi !~ m{%}) {
        $doi =~ s{([^A-Za-z0-9/\-\._~])}{ sprintf("%%%02X", ord($1)) }eg;
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
