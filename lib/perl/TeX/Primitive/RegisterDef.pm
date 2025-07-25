package TeX::Primitive::RegisterDef;

use v5.26.0;

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

## Abstract base class for \countdef, \dimendef, \muskipdef, \skipdef, \toksdef

use warnings;

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

use TeX::Primitive::relax;

use constant FROZEN_RELAX => TeX::Primitive::relax->new();

my %level_of :ATTR(:name<level> :default<-1>);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $r_token = $tex->get_r_token();

    $tex->define($r_token, FROZEN_RELAX);

    $tex->scan_optional_equals();

    ## We use scan_int() instead of scan_register_num() in order to
    ## allow an arbitrary number of registers.

    my $index = $tex->scan_int();

    my $level = $self->get_level();

    my $command = TeX::Primitive::Register->new({ index => $index,
                                                  level => $level });

    $tex->define($r_token, $command, $modifier);

    return;
}

1;

__END__
