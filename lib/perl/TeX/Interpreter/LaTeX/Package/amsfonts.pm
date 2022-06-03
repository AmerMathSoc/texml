package TeX::Interpreter::LaTeX::Package::amsfonts;

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

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amsfonts::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{amsfonts}[2013/01/14 v3.01 Basic AMSFonts support (texml)]

\new@mathgroup\symAMSa
\new@mathgroup\symAMSb

\@namedef{U/msa/m/n}{}

\RequirePackage{unicode-math}

\DeclareRobustCommand{\frak}[1]{\mathfrak{#1}}
\DeclareRobustCommand{\bold}[1]{\mathbf{#1}}

\let\Bbb\relax
\DeclareRobustCommand{\Bbb}[1]{\mathbb{#1}}

%% These 4 are mathrel in unicode-math (which, FWIW, matches Unicode's
%% description of them as "relations").

\def\lhd  {\mathbin{\vartriangleleft}}  % U+22B2
\def\unlhd{\mathbin{\trianglelefteq}}   % U+22B4
\def\rhd  {\mathbin{\vartriangleright}} % U+22B3
\def\unrhd{\mathbin{\trianglerighteq}}  % U+22B5

\DeclareMathPassThrough{hbar}           % U+0127 [TeX/jax.js]

\def\yen{\mathyen}                      % U+00A5

\DeclareSVGMathChar\circledR\mathord

%% These three arrows are declared mathord in unicode-math, which is
%% probably a bug.

\def\dasharrow     {\mathrel{\rightdasharrow}}  % U+21E2
\def\dashrightarrow{\mathrel{\rightdasharrow}}  % U+21E2
\def\dashleftarrow {\mathrel{\leftdasharrow}}   % U+21E0

\DeclareMathPassThrough{lozenge}                % U+25CA [AMSsymbols.js]
\DeclareMathPassThrough{square}                 % U+25FB [AMSsymbols.js]

\RequirePackage{latexsym}

\endinput

__END__
