package TeX::Interpreter::LaTeX::Package::enumerate;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("enumerate", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::enumerate::DATA{IO});

    return;
}

1;

__DATA__

\def\@enum@{%
    \list{\csname label\@enumctr\endcsname}{%
        \usecounter{\@enumctr}%
%        \def\makelabel##1{\hss\llap{##1}}%
    }%
}

\endinput

__END__
