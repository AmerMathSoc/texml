package TeX::Utils::Misc;

use 5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

use warnings;

use UNIVERSAL;

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(concat
                                empty
                                nonempty
                                trim
                                pluralize
                                file_mtime
                                iso_8601_timestamp
                                string_to_chars
                             ) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT =  ( @{ $EXPORT_TAGS{all} } );

use Exception::Class qw(TeX::RunError);

use File::MMagic::XS;

my $MMAGIC = new File::MMagic::XS;

## I don't think these are currently needed for texml.  If they do,
## I'll have to figure out how to specify them in File::MMagic::XS.

# $MMAGIC->addSpecials("image/eps",     qr/\xc5\xd0\xd3\xc6/);
# $MMAGIC->addSpecials("image/svg+xml", qr/<\?xml\b/, qr/<svg\b/);

$MMAGIC->add_file_ext('svg', 'image/svg+xml');

sub concat {
    return join '', @_;
}

sub string_to_chars( $ ) {
    my $string = shift;

    return split '', $string;
}

## I'm not completely happy with how complicated nonempty() has
## become, but with so many TeX::TokenList's and PTG::XML::Element's
## running around masquerading as strings, it's either this or be
## careful about inserting explicit calls to to_string() all over the
## place..

sub nonempty(;$) {
    my $string = @_ == 1 ? shift : $_;

    return unless defined $string;

    return $string !~ /^\s*$/ unless ref($string);

    ## Otherwise stringify it and hope for the best.

    no warnings; ## *sigh*  Why is this necessary?

    return "$string" !~ /^\s*$/;
}

sub empty($) {
    my $string = shift;

    return not nonempty $string;
}

sub trim($) {
    my $string = defined $_[0] ? $_[0] : '';

    $string =~ s/\s+/ /g;
    $string =~ s/^ | $//g;

    return $string;
}

sub pluralize( $$;$ ){
    my $singular = shift;
    my $cnt      = shift || 0;

    my $plural   = shift || "${singular}s";

    return $cnt == 1 ? $singular : $plural;
}

sub file_mtime( $ ) {
    my $file = shift;

    return (stat($file))[9];
}

sub iso_8601_timestamp() {
    my ($sec, $min, $hour, $mday, $mon, $year) = gmtime(time);

    return sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ",
                   $year + 1900,
                   $mon + 1,
                   $mday,
                   $hour,
                   $min,
                   $sec);
}

1;

__END__
