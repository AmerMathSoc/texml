package TeX::Interpreter::LaTeX::Package::amssymb;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amssymb::DATA{IO});

    return;
}
1;

__DATA__

\TeXMLprovidesPackage{amssymb}

\RequirePackage{amsfonts}

% \def\square{\mdlgwhtsquare}
\def\Diamond{\lozenge}
\def\leadsto{\rightsquigarrow}

\def\lhd{\vartriangleleft}
\def\rhd{\vartriangleright}
\def\unlhd{\trianglelefteq}
\def\unrhd{\trianglerighteq}

\def\backepsilon{\smallni}

\DeclareMathPassThrough{varkappa}

% \DeclareSVGMathChar\blacklozenge\mathord
% \DeclareSVGMathChar\blacksquare\mathord
\def\centerdot{\smblkcircle}
\def\circlearrowleft{\acwopencirclearrow}
\def\circlearrowright{\cwopencirclearrow}
\DeclareMathPassThrough{circledS}    % U+24C8 [AMSsymbols.js]
\DeclareSVGMathChar\diagdown\mathord
\DeclareSVGMathChar\diagup\mathord
\DeclareSVGMathChar\digamma\mathord
\def\doteqdot{\Doteq}
\def\doublecap{\Cap}
\def\doublecup{\Cup}
\def\eth{\matheth}
\def\gggtr{\ggg}
\DeclareSVGMathChar\gvertneqq\mathrel
\def\llless{\lll}
\DeclareSVGMathChar\lvertneqq\mathrel
\DeclareSVGMathChar\ngeqq\mathrel
\DeclareSVGMathChar\ngeqslant\mathrel
\DeclareSVGMathChar\nleqq\mathrel
\DeclareSVGMathChar\nleqslant\mathrel
\DeclareSVGMathChar\npreceq\mathrel
\DeclareSVGMathChar\nshortmid\mathrel
\DeclareSVGMathChar\nshortparallel\mathrel
\DeclareSVGMathChar\nsubseteqq\mathrel
\DeclareSVGMathChar\nsucceq\mathrel
\DeclareSVGMathChar\nsupseteqq\mathrel
\DeclareSVGMathChar\ntriangleleft\mathrel
\DeclareSVGMathChar\ntriangleright\mathrel
\DeclareMathPassThrough{restriction}
\DeclareSVGMathChar\shortmid\mathrel
\DeclareSVGMathChar\shortparallel\mathrel
% \DeclareSVGMathChar\smallfrown\mathrel
\def\smallfrown{\frown}
\DeclareSVGMathChar\smallsmile\mathrel
\DeclareSVGMathChar\thickapprox\mathrel
\DeclareSVGMathChar\thicksim\mathrel

\DeclareSVGMathChar\varpropto\mathrel
\DeclareSVGMathChar\varsubsetneq\mathrel
\DeclareSVGMathChar\varsubsetneqq\mathrel
\DeclareSVGMathChar\varsupsetneq\mathrel
\DeclareSVGMathChar\varsupsetneqq\mathrel

\TeXMLendPackage

\endinput

__END__
