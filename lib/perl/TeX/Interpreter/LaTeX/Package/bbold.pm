package TeX::Interpreter::LaTeX::Package::bbold;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::bbold::DATA{IO});

    return;
}

1;

__DATA__

\DeclareTeXMLMathAlphabet\mathbb

\def\BbbLambda{%
    \TeXMLCreateSVG{%
\DeclareSymbolFont{MVbbold}{U}{bbold}{m}{n}%
\DeclareMathSymbol{\BbbLambda}{\mathord}{MVbbold}{"03}%
$\BbbLambda$%
    }%
}

\endinput

__END__
