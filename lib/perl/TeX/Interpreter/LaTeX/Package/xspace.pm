package TeX::Interpreter::LaTeX::Package::xspace;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("xspace", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xspace::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

%% This is only necessary because the current implementation of
%% \noexpand is broken.

\def\@xspace@lettoken@if@expandable@TF{%
  % \expandafter %???
  \ifx
  % \noexpand %???
  \@let@token\@let@token%
    \expandafter\@secondoftwo
  \else
    \expandafter\@firstoftwo
  \fi
}

\endinput

__END__
