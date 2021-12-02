package TeX::Interpreter::LaTeX::Package::upgreek;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::upgreek::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{upgreek}

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

\TeXMLendPackage

\endinput

__END__
