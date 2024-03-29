package TeX::Interpreter::LaTeX::Package::caption3;

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

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{caption3}

\LoadRawMacros

% \newcommand\DeclareCaptionOption{\@gobbletwo}

% \def\captionsetup{\@ifstar\@gobble@opt\@gobble@opt}

% \newcommand*\caption@withoptargs[1]{%
%   \@ifstar
%     {\def\caption@tempa{*}\caption@@withoptargs{#1}}%
%     {\def\caption@tempa{}\caption@@withoptargs{#1}}}

\def\caption@@withoptargs#1{%
  \@ifnextchar[%]
    {\caption@@@withoptargs{#1}}%
    {\caption@@@@withoptargs{#1}}}

\def\caption@@@withoptargs#1[#2]{%
  \l@addto@macro\caption@tempa{[{#2}]}%
  \caption@@withoptargs{#1}}

\def\caption@@@@withoptargs#1{%
  \def\caption@tempb{#1}%
  \expandafter\caption@tempb\expandafter{\caption@tempa}}

\endinput

__END__
