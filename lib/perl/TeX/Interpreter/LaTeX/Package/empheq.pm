package TeX::Interpreter::LaTeX::Package::empheq;

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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{empheq}

\RequirePackage{mathtools}

\DefineAMSTaggedEnvironment{empheq}\st@rredfalse

\DeclareMathPassThrough{empheqbiglVert}
\DeclareMathPassThrough{empheqbiglangle}
\DeclareMathPassThrough{empheqbiglbrace}
\DeclareMathPassThrough{empheqbiglbrack}
\DeclareMathPassThrough{empheqbiglceil}
\DeclareMathPassThrough{empheqbiglfloor}
\DeclareMathPassThrough{empheqbiglparen}
\DeclareMathPassThrough{empheqbiglvert}
\DeclareMathPassThrough{empheqbigl}
\DeclareMathPassThrough{empheqbigrVert}
\DeclareMathPassThrough{empheqbigrangle}
\DeclareMathPassThrough{empheqbigrbrace}
\DeclareMathPassThrough{empheqbigrbrack}
\DeclareMathPassThrough{empheqbigrceil}
\DeclareMathPassThrough{empheqbigrfloor}
\DeclareMathPassThrough{empheqbigrparen}
\DeclareMathPassThrough{empheqbigrvert}
\DeclareMathPassThrough{empheqbigr}
\DeclareMathPassThrough{empheqlVert}
\DeclareMathPassThrough{empheqlangle}
\DeclareMathPassThrough{empheqlbrace}
\DeclareMathPassThrough{empheqlbrack}
\DeclareMathPassThrough{empheqlceil}
\DeclareMathPassThrough{empheqlfloor}
\DeclareMathPassThrough{empheqlparen}
\DeclareMathPassThrough{empheqlvert}
\DeclareMathPassThrough{empheql}
\DeclareMathPassThrough{empheqrVert}
\DeclareMathPassThrough{empheqrangle}
\DeclareMathPassThrough{empheqrbrace}
\DeclareMathPassThrough{empheqrbrack}
\DeclareMathPassThrough{empheqrceil}
\DeclareMathPassThrough{empheqrfloor}
\DeclareMathPassThrough{empheqrparen}
\DeclareMathPassThrough{empheqrvert}
\DeclareMathPassThrough{empheqr}

\endinput

__END__
