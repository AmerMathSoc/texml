package TeX::Interpreter::LaTeX::Package::textgreek;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("textgreek", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::textgreek::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{textgreek}

\UCSchardef\textAlpha   "0391
\UCSchardef\textBeta    "0392
\UCSchardef\textGamma   "0393
\UCSchardef\textDelta   "0394
\UCSchardef\textEpsilon "0395
\UCSchardef\textZeta    "0396
\UCSchardef\textEta     "0397
\UCSchardef\textTheta   "0398
\UCSchardef\textIota    "0399
\UCSchardef\textKappa   "039A
\UCSchardef\textLambda  "039B
\UCSchardef\textMu      "039C
\UCSchardef\textMugreek "039C
\UCSchardef\textNu      "039D
\UCSchardef\textXi      "039E
\UCSchardef\textOmikron "039F
\UCSchardef\textPi      "03A0
\UCSchardef\textRho     "03A1
\UCSchardef\textSigma   "03A3
\UCSchardef\textTau     "03A4
\UCSchardef\textUpsilon "03A5
\UCSchardef\textPhi     "03A6
\UCSchardef\textChi     "03A7
\UCSchardef\textPsi     "03A8
\UCSchardef\textOmega   "03A9

\UCSchardef\textalpha   "03B1
\UCSchardef\textbeta    "03B2
\UCSchardef\textgamma   "03B3
\UCSchardef\textdelta   "03B4
\UCSchardef\textepsilon "03B5
\UCSchardef\textzeta    "03B6
\UCSchardef\texteta     "03B7
\UCSchardef\texttheta   "03B8
\UCSchardef\textiota    "03B9
\UCSchardef\textkappa   "03BA
\UCSchardef\textlambda  "03BB
\UCSchardef\textmu      "03BC
\UCSchardef\textnu      "03BD
\UCSchardef\textxi      "03BE
\UCSchardef\textomikron "03BF
\UCSchardef\textpi      "03C0
\UCSchardef\textrho     "03C1
\UCSchardef\textsigma   "03C3
\UCSchardef\texttau     "03C4
\UCSchardef\textupsilon "03C5
\UCSchardef\textphi     "03C6
\UCSchardef\textchi     "03C7
\UCSchardef\textpsi     "03C8
\UCSchardef\textomega   "03C9

\UCSchardef\textvarsigma"03C2
% \UCSchardef\straightphi
% \UCSchardef\scripttheta
% \UCSchardef\straighttheta
% \UCSchardef\straightepsilon

\TeXMLendPackage

\endinput

__END__
