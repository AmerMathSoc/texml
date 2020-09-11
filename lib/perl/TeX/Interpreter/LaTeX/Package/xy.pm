package TeX::Interpreter::LaTeX::Package::xy;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xy::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\DeclareSVGEnvironment{xy}

\let\UseAllTwocells\@empty

\let\xyoption\@gobble

\def\SelectTips#1#2{}
\def\CompileMatrices{}

\let\xymatrixcolsep\@gobble
\let\xymatrixrowsep\@gobble

\def\xymatrix#1#{%
    \xymatrix@body{#1}%
}

\let\xymatrixcolsep@\@empty
\def\xymatrixcolsep{\def\xymatrixcolsep@}

\def\xymatrix@body#1#2{%
    \begingroup
        \toks@{#2}%
        \edef\next@{
            \noexpand\TeXMLCreateSVG{$%
                \ifx\xymatrixcolsep@\@empty\else
                    \noexpand\xymatrixcolsep{\xymatrixcolsep@}
                \fi
                \noexpand\xymatrix#1{\the\toks@}%
            $}%
        }%
        \expandafter\next@
    \endgroup
}

\endinput

__END__
