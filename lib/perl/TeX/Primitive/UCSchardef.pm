package TeX::Primitive::UCSchardef;

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

use base qw(TeX::Command::Executable::Assignment);

use TeX::Class;

use TeX::Interpreter qw(FROZEN_RELAX);

use TeX::Interpreter::Constants qw(DEFAULT_CHARACTER_ENCODING);

use TeX::Primitive::CharGiven;

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $r_token = $tex->get_r_token();

    $tex->define($r_token, FROZEN_RELAX);

    $tex->scan_optional_equals();

    my $char_code = $tex->scan_char_num();

    $tex->initialize_char_codes($char_code);

    my $command = TeX::Primitive::CharGiven->new({ name => "char",
                                                   value => $char_code,
                                                   encoding => DEFAULT_CHARACTER_ENCODING,
                                                 });

    $tex->define($r_token, $command, $modifier);

    return;
}

1;

__END__
