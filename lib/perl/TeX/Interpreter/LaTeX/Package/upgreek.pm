package TeX::Interpreter::LaTeX::Package::upgreek;

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

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::upgreek::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{upgreek}

\def\Updelta{\mupDelta}
\def\Upgamma{\mupGamma}
\def\Uplambda{\mupLambda}
\def\Upomega{\mupOmega}
\def\Upphi{\mupPhi}
\def\Uppi{\mupPi}
\def\Uppsi{\mupPsi}
\def\Upsigma{\mupSigma}
\def\Uptheta{\mupTheta}
\def\Upupsilon{\mupUpsilon}
\def\Upxi{\mupXi}

\def\upalpha{\mupalpha}
\def\upbeta{\mupbeta}
\def\upchi{\mupchi}
\def\updelta{\mupdelta}
\def\upepsilon{\mupepsilon}
\def\upeta{\mupeta}
\def\upgamma{\mupgamma}
\def\upiota{\mupiota}
\def\upkappa{\mupkappa}
\def\uplambda{\muplambda}
\def\upmu{\mupmu}
\def\upnu{\mupnu}
\def\upomega{\mupomega}
\def\upomicron{\mupomicron}
\def\upphi{\mupphi}
\def\uppi{\muppi}
\def\uppsi{\muppsi}
\def\uprho{\muprho}
\def\upsigma{\mupsigma}
\def\uptau{\muptau}
\def\uptheta{\muptheta}
\def\upupsilon{\mupupsilon}
\def\upvarepsilon{\mupvarepsilon}
\def\upvarphi{\mupvarphi}
\def\upvarpi{\mupvarpi}
\def\upvarrho{\mupvarrho}
\def\upvarsigma{\mupvarsigma}
\def\upvartheta{\mupvartheta}
\def\upxi{\mupxi}
\def\upzeta{\mupzeta}

\endinput

__END__
