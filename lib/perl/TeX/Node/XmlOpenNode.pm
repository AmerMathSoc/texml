package TeX::Node::XmlOpenNode;

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

my %namespace_of  :ATTR(:name<namespace>);
my %attributes_of :HASH(:name<attribute>);
my %properties_of :HASH(:name<property> :sethash<set_properties> :gethash<get_properties>);
my %classes_of    :ARRAY(:name<class>);

use overload q{""}  => \&to_string;

sub to_string {
    my $self = shift;

    my $qName = $self->get_qName();

    my $string = "$qName";

    my $namespace = trim($self->get_namespace());

    if (nonempty($namespace)) {
        $string = "${namespace}:$string";
    }

    while (my ($key, $val) = each %{ $attributes_of{ident $self} }) {
        $string .= qq{ $key="$val"};
    }

    while (my ($key, $val) = each %{ $properties_of{ident $self} }) {
        $string .= qq{ $key="$val"};
    }

    return "<$string>";
}

1;

__END__
