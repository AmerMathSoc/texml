package TeX::Command::Executable::Assignment;

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

use Carp;

use base qw(TeX::Command::Prefixed Exporter);

our %EXPORT_TAGS = ( modifiers => [ qw(MODIFIER_LONG   MODIFIER_OUTER
                                       MODIFIER_GLOBAL MODIFIER_EXPAND
                                       MODIFIER_PROTECTED MODIFIER_APPEND
                                    ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{modifiers} } );

our @EXPORT = ();

use constant {
    MODIFIER_LONG      =>  1,
    MODIFIER_OUTER     =>  2,
    MODIFIER_GLOBAL    =>  4,
    MODIFIER_EXPAND    =>  8,
    MODIFIER_PROTECTED => 16, # eTeX extension
    MODIFIER_APPEND    => 32, # LuaTeX extension (combine_toks)
};

use TeX::Class;

1;

__END__
