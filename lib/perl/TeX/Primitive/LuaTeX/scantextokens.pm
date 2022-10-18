package TeX::Primitive::LuaTeX::scantextokens;

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

use base qw(TeX::Command::Expandable);

use TeX::Constants qw(:file_types);

use TeX::Class;

## Still need to implement these:
##
## * \scantextokens never raises an EOF error
##
## * There are no `...while end of file...' error tests executed.
##   This allows expansion to end on a different grouping level or
##   while a conditional is still incomplete.
##
## But actually texml is a lot more lax about those things than TeX
## is, so we might not need to worry about it.

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->pseudo_start(pseudo_file2);

    return;
}

1;

__END__
