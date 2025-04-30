package TeX::Interpreter::LaTeX::Package::graphicx;

use 5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{graphicx}

\LoadRawMacros

\define@key{Gin}{alt}{\def\Gin@alt{#1}}

% Disable processing of the following keys -- leaving only width,
% height, and scale -- to keep them from causing problems.  EPS, MPS,
% or PDF files will be converted to SVGs, which will then be
% reimported without needings any of these attributes.

% When importing other graphics, there's really nothing useful texml
% can do with these keys.  Arguably, if we do encounter one of these
% keys, we should pass the whole thing to \TeXMLCreateSVG, but let's
% defer implementing that for now.

\define@key{Gin}{bb}{}
\define@key{Gin}{bbllx}{}
\define@key{Gin}{bblly}{}
\define@key{Gin}{bburx}{}
\define@key{Gin}{bbury}{}
\define@key{Gin}{hiresbb}{}
\define@key{Gin}{viewport}{}
\define@key{Gin}{trim}{}
\define@key{Gin}{angle}{}
\define@key{Gin}{origin}{}
\define@key{Gin}{totalheight}{}
\define@key{Gin}{keepaspectratio}{}
\define@key{Gin}{draft}{}
\define@key{Gin}{clip}{}
\define@key{Gin}{type}{}
\define@key{Gin}{ext}{}
\define@key{Gin}{read}{}
\define@key{Gin}{command}{}
\define@key{Gin}{decodearray}{}
\define@key{Gin}{quiet}{}
\define@key{Gin}{page}{}
\define@key{Gin}{interpolate}{}
\define@key{Gin}{pagebox}{}

\renewcommand{\rotatebox}[3][]{%
    \TeXMLCreateSVG{\rotatebox[#1]{#2}{#3}}%
}

\endinput

__END__
