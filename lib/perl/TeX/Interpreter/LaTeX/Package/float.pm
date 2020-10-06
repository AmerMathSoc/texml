package TeX::Interpreter::LaTeX::Package::float;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::float::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\let\floatstyle\@gobble
\def\newfloat#1#2#3{\@gobbleopt}
\let\floatname\@gobbletwo

% Provide a fake definition of this in case someone wants to
%  \renewcommand it (mcom3342).

\providecommand\floatc@ruled[2]{{\@fs@cfont #1} #2\par}

\endinput

__END__
