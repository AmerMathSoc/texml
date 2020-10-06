package TeX::Interpreter::LaTeX::Package::esint;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::esint::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{esint}

\RequirePackage{unicode-math}

%% esint defines these in pairs, as so:
%%
%%    \DeclareMathSymbol{\Xop}...
%%    \def\X{\Xop\nolimits}
%%
%%    I'm not going to worry about the \Xop versions.

\DeclareSVGMathChar\dotsint\mathop
\DeclareSVGMathChar\landdownint\mathop
\DeclareSVGMathChar\landupint\mathop
\DeclareSVGMathChar\ointclockwise\mathop
\DeclareSVGMathChar\sqiint\mathop

%% Let's not worry about the variant shapes.

\def\varoiint{\oiint}
\def\varointctrclockwise{\ointctrclockwise}

\TeXMLendPackage

\endinput

__END__
