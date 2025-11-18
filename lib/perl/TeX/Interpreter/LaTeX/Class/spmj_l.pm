package TeX::Interpreter::LaTeX::Class::spmj_l;

use v5.26.0;

use utf8;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
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

use warnings;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{spmj-l}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}

\ProcessOptions\relax

\LoadClass{amsart}[1996/10/24]

\RequirePackage{AMStrans}

\RequirePackage{amscyr}

\gdef\AMS@publkey{spmj}

\def\AMS@publname{St. Petersburg Mathematical Journal}
\def\AMS@publname@short{St. Petersburg Math. J.}

\def\AMS@eissn{1547-7371}
\def\AMS@pissn{1061-0022}

\def\AMS@series@url{https://www.ams.org/aboutspmj/}

\def\JATS@subject@group{Research article}
\def\JATS@subject@group@type{display-channel}

% https://www.mathnet.ru/php/journal.phtml?jrnid=aa

\def\AMS@orig@publname{Алгебра и анализ}
\def\AMS@orig@issn{0234-0852}

\endinput

__END__
