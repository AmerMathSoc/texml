package TeX::Command;

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

my %name_of :ATTR(:name<name>);

sub execute {
    my $self = shift;

    my $engine  = shift;
    my $cur_tok = shift;

    # $engine->print_err("Unimplemented primitive '$cur_tok'");
    # 
    # $engine->set_help("The primitive at the end of the top line",
    #                   "of your error message has not been implemented yet.");
    # 
    # $engine->error();

    return;
}

sub print_cmd_chr { # for print_cmd_chr()
    my $self = shift;

    my $tex = shift;

    if (defined(my $name = $self->get_name())) {
        $tex->print_esc($name);
    } else {
        $tex->print("[unknown command code!]");
    }

    return;
}

1;

__END__
