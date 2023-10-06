package TeX::Interpreter::LaTeX::Package::DisablePackages;

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

\ProvidesPackage{DisablePackages}

\def\DisablePackage#1{\@namedef{ver@#1.sty}{Skip}}

% \DisablePackage{listings}
%\DisablePackage{mathabx}
%\DisablePackage{tabularx}
\DisablePackage{amsmathbfit}
\DisablePackage{amstix2}
\DisablePackage{amstixbb}
\DisablePackage{backrefs}
\DisablePackage{breakurl}
\DisablePackage{circuitikz}
\DisablePackage{ctable}
\DisablePackage{dutchcal}
\DisablePackage{etoolbox}
\DisablePackage{fontenc}
\DisablePackage{footmisc}
\DisablePackage{forest}
\DisablePackage{geometry}
\DisablePackage{grffile}
\DisablePackage{hypcap}%      %% This one looks worth a look
\DisablePackage{iftexml}
\DisablePackage{layout}
\DisablePackage{lmodern}
\DisablePackage{makeidx}
\DisablePackage{mathalfa}
\DisablePackage{morefloats}
\DisablePackage{ogonek}
\DisablePackage{pict2e}
\DisablePackage{pictexwd}
\DisablePackage{pspicture}
\DisablePackage{shaderef}
\DisablePackage{stix2}
\DisablePackage{textcomp}
\DisablePackage{thm-listof}
\DisablePackage{tikz-base}
\DisablePackage{tikz-fct}
\DisablePackage{tkz-graph}
\DisablePackage{tikz-qtree-compat}
\DisablePackage{tkz-euclide}
\DisablePackage{tikzsymbols}
\DisablePackage{xstring}

\endinput

__END__
