package TeX::Interpreter::LaTeX::Package::amssymb;

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

    $tex->package_load_notification(__PACKAGE__);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amssymb::DATA{IO});

    return;
}
1;

__DATA__

\ProvidesPackage{amssymb}

\RequirePackage{amsfonts}

% \def\square{\mdlgwhtsquare}
\def\Diamond{\lozenge}
\def\leadsto{\rightsquigarrow}

\def\lhd{\vartriangleleft}
\def\rhd{\vartriangleright}
\def\unlhd{\trianglelefteq}
\def\unrhd{\trianglerighteq}

\def\backepsilon{\smallni}

\DeclareMathPassThrough{varkappa}

% \DeclareSVGMathChar\blacklozenge\mathord
% \DeclareSVGMathChar\blacksquare\mathord
\def\centerdot{\smblkcircle}
\def\circlearrowleft{\acwopencirclearrow}
\def\circlearrowright{\cwopencirclearrow}
\DeclareMathPassThrough{circledS}    % U+24C8 [AMSsymbols.js]
\DeclareSVGMathChar\diagdown\mathord
\DeclareSVGMathChar\diagup\mathord
% \DeclareSVGMathChar\digamma\mathord
\def\digamma{\updigamma}
\def\doteqdot{\Doteq}
\def\doublecap{\Cap}
\def\doublecup{\Cup}
\def\eth{\matheth}
\def\gggtr{\ggg}
\DeclareSVGMathChar\gvertneqq\mathrel
\def\llless{\lll}
\DeclareSVGMathChar\lvertneqq\mathrel
\DeclareSVGMathChar\ngeqq\mathrel
\DeclareSVGMathChar\ngeqslant\mathrel
\DeclareSVGMathChar\nleqq\mathrel
\DeclareSVGMathChar\nleqslant\mathrel
\DeclareSVGMathChar\npreceq\mathrel
\DeclareSVGMathChar\nshortmid\mathrel
\DeclareSVGMathChar\nshortparallel\mathrel
\DeclareSVGMathChar\nsubseteqq\mathrel
\DeclareSVGMathChar\nsucceq\mathrel
\DeclareSVGMathChar\nsupseteqq\mathrel
\DeclareSVGMathChar\ntriangleleft\mathrel
\DeclareSVGMathChar\ntriangleright\mathrel
\DeclareMathPassThrough{restriction}
\DeclareSVGMathChar\shortmid\mathrel
\DeclareSVGMathChar\shortparallel\mathrel
% \DeclareSVGMathChar\smallfrown\mathrel
\def\smallfrown{\frown}
\DeclareSVGMathChar\smallsmile\mathrel
\DeclareSVGMathChar\thickapprox\mathrel
\DeclareSVGMathChar\thicksim\mathrel

\DeclareSVGMathChar\varpropto\mathrel

%% The next 4 should actually produce the StyleSet 11 variants.

\def\varsubsetneqq{\subsetneqq}
\def\varsupsetneqq{\supsetneqq}
\def\varsubsetneq{\subsetneq}
\def\varsupsetneq{\supsetneq}

\endinput

__END__
