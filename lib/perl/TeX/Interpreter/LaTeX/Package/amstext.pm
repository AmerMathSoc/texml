package TeX::Interpreter::LaTeX::Package::amstext;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amstext::DATA{IO});

    return;
}

1;

__DATA__

% \def\text#1{%
%     \string\text\string{\hbox{#1}\string}%
% }

\def\text#1{%
    \ifmmode
        \startXMLelement{text}%
        \hbox{#1}%
        \endXMLelement{text}%
    \else
        #1%
    \fi
}

\endinput

__END__
