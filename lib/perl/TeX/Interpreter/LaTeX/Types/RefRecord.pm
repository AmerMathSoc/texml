package TeX::Interpreter::LaTeX::Types::RefRecord;

# Copyright (C) 2023 American Mathematical Society
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

use version; our $VERSION = qv '0.0.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all       => [ qw(parse_ref_record new_refrecord) ],
                    factories => [ qw(new_refrecord) ]);

our @EXPORT_OK = ( qw(parse_ref_record), @{ $EXPORT_TAGS{factories} } );

our @EXPORT = ();

use TeX::Class;

my %refkey_of   :ATTR(:name<refkey>);

my %label_of    :ATTR(:name<label>);
my %xml_id_of   :ATTR(:name<xml_id>);
my %ref_type_of :ATTR(:name<ref_type>);
my %sub_type_of :ATTR(:name<sub_type>);

my %prev_ref_of :ATTR(:name<prev_ref>);
my %next_ref_of :ATTR(:name<next_ref>);

# my %resolved_of :BOOLEAN(:name<resolved>);

sub parse_ref_record( $ ) {
    my $ref_record = shift;

    # {@currentlabel}{@currentXMLid}{@currentreftype}{@currentrefsubtype}

    if ($ref_record =~ m{\A \{(.*)\} \{(.*)\} \{(.*)\} \{(.*)\} \z}smx) {
        return ($2, $3, $1, $4);
    }

    return;
}

sub new_refrecord {
    my $refkey   = shift;
    my $data     = shift;
    my $prev_ref = shift;

    my ($xml_id, $ref_type, $label, $sub_type) = parse_ref_record($data);

    return __PACKAGE__->new( {
        refkey   => $refkey,
        label    => $label,
        xml_id   => $xml_id,
        ref_type => $ref_type,
        sub_type => $sub_type,
        prev_ref => $prev_ref,
                         });
}

1;

__END__
