package TeX::Interpreter::LaTeX::Package::amsfonts;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amsfonts::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{amsfonts}[2013/01/14 v3.01 Basic AMSFonts support (texml)]

\new@mathgroup\symAMSa
\new@mathgroup\symAMSb

\@namedef{U/msa/m/n}{}

\RequirePackage{unicode-math}

\DeclareRobustCommand{\frak}[1]{\mathfrak{#1}}
\DeclareRobustCommand{\bold}[1]{\mathbf{#1}}

\let\Bbb\relax
\DeclareRobustCommand{\Bbb}[1]{\mathbb{#1}}

%% These 4 are mathrel in unicode-math (which, FWIW, matches Unicode's
%% description of them as "relations").

\UnicodeMathSymbol{"22B2}{\lhd  }{\mathbin}{}
\UnicodeMathSymbol{"22B3}{\unlhd}{\mathbin}{}
\UnicodeMathSymbol{"22B4}{\rhd  }{\mathbin}{}
\UnicodeMathSymbol{"22B5}{\unrhd}{\mathbin}{}

\DeclareMathJaxMacro\hbar   % U+0127 [TeX/jax.js]

\def\yen{\mathyen}

\DeclareSVGMathChar\circledR\mathord

%% These three arrows are declared mathord in unicode-math, which is
%% probably a bug.

\UnicodeMathSymbol{"21E2}{\dasharrow}     {\mathrel}{rightwards dashed arrow}
\UnicodeMathSymbol{"21E2}{\dashrightarrow}{\mathrel}{rightwards dashed arrow}
\UnicodeMathSymbol{"21E0}{\dashleftarrow} {\mathrel}{leftwards dashed arrow}

% \def\dasharrow     {\mathrel{\rightdasharrow}}
% \def\dashrightarrow{\mathrel{\rightdasharrow}}
% \def\dashleftarrow {\mathrel{\leftdasharrow}}

\DeclareMathJaxMacro\lozenge    % U+25CA [AMSsymbols.js]
\DeclareMathJaxMacro\square     % U+25FB [AMSsymbols.js]

\TeXMLendPackage

\endinput

__END__
