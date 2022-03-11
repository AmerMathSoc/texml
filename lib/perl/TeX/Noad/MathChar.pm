package TeX::Noad::MathChar;

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

use TeX::Class;

my %class_of     :ATTR(:set<class>     :get<class>);
my %family_of    :ATTR(:set<family>    :get<family>);
my %char_code_of :ATTR(:set<char_code> :get<char_code>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $class_of{$ident}     = $arg_ref->{class};
    $family_of{$ident}    = $arg_ref->{family};
    $char_code_of{$ident} = $arg_ref->{char_code};

    return;
}

1;

__END__
