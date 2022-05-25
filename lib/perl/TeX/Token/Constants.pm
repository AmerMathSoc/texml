package TeX::Token::Constants;

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

## This is a flyweight object -- with rare exceptions, at any given
## time there should only be a single object with a given catcode and
## datum.  This saves memory and speeds up token equality checks.

use strict;
use warnings;

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(BEGIN_GROUP END_GROUP
                                BEGIN_OPT   END_OPT   OPT_ARG
                                STAR) ] );

our @EXPORT_OK = @{ $EXPORT_TAGS{all} };

our @EXPORT = @EXPORT_OK;

use TeX::Token qw(:catcodes :factories);

use constant {
    BEGIN_GROUP => make_character_token('{', CATCODE_BEGIN_GROUP),
    END_GROUP   => make_character_token('}', CATCODE_END_GROUP)
};

use constant {
    BEGIN_OPT => make_character_token('[', CATCODE_OTHER),
    END_OPT   => make_character_token(']', CATCODE_OTHER),
};

use constant {
    OPT_ARG   => [ BEGIN_OPT, make_param_ref_token(1), END_OPT],
};

use constant {
    STAR => make_character_token('*', CATCODE_OTHER),
};

1;

__END__
