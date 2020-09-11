package TeX::Interpreter::LaTeX::Package::wrapfig;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::wrapfig::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

% Ignore optional args for now: \begin{wrapfigure}[12]{r}[34pt]{5cm}

% \newenvironment{wrapfigure}[2]{%
%     \begin{figure}[h]
% }{%
%     \end{figure}
% }

\def\wrapfigure#1#2{%
    \texml@process@env{wrapfigure}{%
        \toks@\expandafter{\texml@body}%
        \edef\next@{
            \afterpar{%
                \noexpand\begin{figure}[h]
                    \the\toks@
                \noexpand\end{figure}
                \afterpar{}%
            }%
        }%
        \next@
    }%
}

\endinput

__END__
