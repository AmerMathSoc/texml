package TeX::KPSE;

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
