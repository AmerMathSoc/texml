package TeX::Interpreter::LaTeX::Package::unicode_math;

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

## Should unicode-math be added to DisablePackages?

use strict;
use warnings;

use TeX::Token qw(make_anonymous_token);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{unicode_math}

\RequirePackage{fontspec}

%% These are from stix2 and not unicode_math, but we want to pretend
%% that stix2 is always loaded to avoid conflicts with amsmath.sty,
%% which means we can't easily optionally load stix2.pm.

%% The next 4 should actually produce the StyleSet 11 variants.
\DeclareMathPassThrough{varsubsetneq}
\DeclareMathPassThrough{varsupsetneq}
\DeclareMathPassThrough{varsubsetneqq}
\DeclareMathPassThrough{varsupsetneqq}

\DeclareMathPassThrough{varkappa}

\let\shortparallel\relax
\DeclareMathPassThrough{shortparallel}
\def\doteqdot{\Doteq}

\endinput

__END__

\mathbin
\mathclose
\mathop
\mathopen
\mathord
\mathpunct
\mathrel

\mathalpha == \mathord

\mathover       % over accent
\mathunder      % under accent

% \mathfence
% \mathaccent
% \mathaccentoverlay
% \mathaccentwide
% \mathbotaccent
% \mathbotaccentwide
