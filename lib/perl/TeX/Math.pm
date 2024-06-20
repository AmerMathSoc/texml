package TeX::Math;

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

use TeX::Constants qw(:math_params :math_classes);

use base qw(Exporter);

our %EXPORT_TAGS = ('all' => [ qw(spacing_class parse_math_code) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT;

use constant {
    CLASS_ORD    =>  0,
    CLASS_OP     =>  1,
    CLASS_BIN    =>  2,
    CLASS_REL    =>  3,
    CLASS_OPEN   =>  4,
    CLASS_CLOSE  =>  5,
    CLASS_PUNCT  =>  6,
    CLASS_VAR    =>  7,
    CLASS_ACTIVE =>  8,
};

use constant {
    NOAD_ORD    =>  0,
    NOAD_OP     =>  1,
    NOAD_BIN    =>  2,
    NOAD_REL    =>  3,
    NOAD_OPEN   =>  4,
    NOAD_CLOSE  =>  5,
    NOAD_PUNCT  =>  6,
    NOAD_INNER  =>  7,
};

my @NOAD_CLASS = qw(ordinary large_op binop relation opening closing
                   punctuation variable);

my %MATH_CLASS_MAP = (mathalpha => MATH_ORD,
                      mathord   => MATH_ORD,
                      mathop    => MATH_OP,
                      mathbin   => MATH_BIN,
                      mathrel   => MATH_REL,
                      mathopen  => MATH_OPEN,
                      mathclose => MATH_CLOSE,
                      mathpunct => MATH_PUNCT,
                      mathinner => MATH_INNER,
    );

my @MATH_SPACING = ( [  0,   1,     -2,     -3,   0,      0,     0,  -1 ],
                     [  1,   1,  undef,     -3,   0,      0,     0,  -1 ],
                     [ -2,  -2,  undef,  undef,  -2,  undef, undef,  -2 ],
                     [ -3,  -3,  undef,      0,  -3,      0,     0,  -3 ],
                     [  0,   0,  undef,      0,   0,      0,     0,   0 ],
                     [  0,   1,     -2,     -3,   0,      0,     0,  -1 ],
                     [ -1,  -1,  undef,     -1,  -1,     -1,    -1,  -1 ],
                     [ -1,   1,     -2,     -3,  -1,      0,    -1,  -1 ],
    );

sub spacing_class($$) {
    my $left  = shift;
    my $right = shift;

    if (exists $MATH_SPACING[$left][$right]) {
        return $MATH_SPACING[$left][$right];
    } else {
        return 0;
    }
}

sub parse_math_code( $ ) {
    my $code = shift;

    my $char_code = $code & 0xFF;
    my $family    = ($code >> 8) & 0xF;
    my $class     = $code >> 12;

    return ($class, $family, $char_code);
}

1;

__END__
