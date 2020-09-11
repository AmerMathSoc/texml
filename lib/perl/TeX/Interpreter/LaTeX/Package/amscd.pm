package TeX::Interpreter::LaTeX::Package::amscd;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amscd::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

%% It turns out that MathJax doesn't understand \setlength, so let's
%% forget about it.

\newdimen\minCDarrowwidth
% \minCDarrowwidth2.5pc

\def\CD{%
%    \string\setlength{\string\minCDarrowwidth}{\the\minCDarrowwidth}%
    \string\begin{CD}%
    \let\\\@arraycr
}
\def\endCD{\string\end{CD}}

\endinput

__END__
