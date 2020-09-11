package TeX::Interpreter::LaTeX::Package::amsopn;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amsopn::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{amsopn}[1999/12/14 v2.01 operator names]

\def\operatornamewithlimits{\operatorname*}

\newcommand{\DeclareMathOperator}{%
  \@ifstar{\@declmathop m}{\@declmathop o}}

\long\def\@declmathop#1#2#3{%
    \@ifdefinable{#2}{%
        \if#1m%
            \def#2{\operatorname*{#3}}%
        \else
            \def#2{\operatorname{#3}}%
        \fi
    }%
}

\@onlypreamble\DeclareMathOperator
\@onlypreamble\@declmathop

\DeclareMathJaxMacro\operatorname

\DeclareMathJaxMacro\injlim
\DeclareMathJaxMacro\projlim
\DeclareMathJaxMacro\varinjlim
\DeclareMathJaxMacro\varliminf
\DeclareMathJaxMacro\varlimsup
\DeclareMathJaxMacro\varprojlim

\RequirePackage{amsgen}

\TeXMLendPackage

\endinput

__END__
