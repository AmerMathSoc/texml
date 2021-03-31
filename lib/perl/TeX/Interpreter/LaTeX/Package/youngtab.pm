package TeX::Interpreter::LaTeX::Package::youngtab;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::youngtab::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\newcount\Yvcentermath
\Yvcentermath=0

\def\young(#1){%
    \begingroup
        \edef\next@{%
            \noexpand\TeXMLCreateSVG{%
                $\noexpand\Yvcentermath\the\Yvcentermath\noexpand\young(#1)$%
            }%
        }%
    \expandafter\endgroup
    \next@
}

\def\yng(#1){%
    \begingroup
        \edef\next@{%
            \noexpand\TeXMLCreateSVG{%
                $\noexpand\Yvcentermath\the\Yvcentermath\noexpand\yng(#1)$%
            }%
        }%
    \expandafter\endgroup
    \next@
}

\endinput

__END__
