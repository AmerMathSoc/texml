package TeX::Interpreter::LaTeX::Package::ccicons;

# Copyright (C) 2025 American Mathematical Society
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

\ProvidesPackage{ccicons}

% \LoadRawMacros

\DeclareSVGChar{\ccAttribution}
\DeclareSVGChar{\ccCopy}
\DeclareSVGChar{\ccLogo}
\DeclareSVGChar{\ccNoDerivatives}
\DeclareSVGChar{\ccNonCommercialEU}
\DeclareSVGChar{\ccNonCommercialJP}
\DeclareSVGChar{\ccNonCommercial}
\DeclareSVGChar{\ccPublicDomainAlt}
\DeclareSVGChar{\ccPublicDomain}
\DeclareSVGChar{\ccRemix}
\DeclareSVGChar{\ccSampling}
\DeclareSVGChar{\ccShareAlike}
\DeclareSVGChar{\ccShare}
\DeclareSVGChar{\ccZero}
\DeclareSVGChar{\ccbynceu}
\DeclareSVGChar{\ccbyncjp}
\DeclareSVGChar{\ccbyncndeu}
\DeclareSVGChar{\ccbyncndjp}
\DeclareSVGChar{\ccbyncnd}
\DeclareSVGChar{\ccbyncsaeu}
\DeclareSVGChar{\ccbyncsajp}
\DeclareSVGChar{\ccbyncsa}
\DeclareSVGChar{\ccbync}
\DeclareSVGChar{\ccbynd}
\DeclareSVGChar{\ccbysa}
\DeclareSVGChar{\ccby}
\DeclareSVGChar{\ccpd}
\DeclareSVGChar{\cczero}

\endinput

__END__
