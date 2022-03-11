package TeX::Node::XmlImportNode;

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

use base qw(TeX::Node::XmlNode);

use TeX::Class;

use TeX::Utils::Misc;

my %xml_file_of :ATTR(:name<xml_file>);
my %xpath_of    :ATTR(:name<xpath>);

use overload q{""}  => \&to_string;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_qName("xml_import");

    return;
}

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();
    my $namespace = 'texml';

    my $string = "$qName";

    if (nonempty($namespace)) {
        $string = "${namespace}:$string";
    }

    my $xml_file = $self->get_xml_file();
    my $xpath    = $self->get_xpath();

    return "<$string file='$xml_file' xpath='$xpath'/>";
}

1;

__END__
