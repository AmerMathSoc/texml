package TeX::Primitive::texml::setXMLrootAttribute;

use v5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $qName = $tex->read_undelimited_parameter(EXPANDED);
    my $value = $tex->read_undelimited_parameter(EXPANDED);

    if (defined(my $dom = $tex->current_dom())) {
        $dom->documentElement()->setAttribute($qName, $value);
    } else {
        $tex->set_xml_root_attribute($qName, $value);
    }

    return;
}

1;

__END__
