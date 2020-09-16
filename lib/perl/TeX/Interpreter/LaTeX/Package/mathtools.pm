package TeX::Interpreter::LaTeX::Package::mathtools;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("mathtools", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::mathtools::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{mathtools}

\AtBeginDocument{%
    \def\coloneqq{\coloneq}
}

\DeclareMathJaxMacro\coloneq
\DeclareMathJaxMacro\underbrace

\DefineAMSMathSimpleEnvironment{multlined}

\DefineAMSMathSimpleEnvironment{matrix*}

\DefineAMSMathSimpleEnvironment{bmatrix*}
\DefineAMSMathSimpleEnvironment{bsmallmatrix}

\DefineAMSMathSimpleEnvironment{psmallmatrix}

\DefineAMSMathSimpleEnvironment{dcases}

\let\xrightharpoonup\relax
\newcommand{\xrightharpoonup}[2][]{%
    \TeXMLCreateSVG{$\xrightharpoonup[#1]{#2}$}%
}

\let\xhookrightarrow\relax
\newcommand*\xhookrightarrow[2][]{%
    \TeXMLCreateSVG{$\xhookrightarrow[#1]{#2}$}%
}

\DeclareMathJaxMacro\xleftrightarrow

\TeXMLendPackage

__END__
