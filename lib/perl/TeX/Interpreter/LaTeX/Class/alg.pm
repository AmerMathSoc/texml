package TeX::Interpreter::LaTeX::Class::alg;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_latex_class("alg", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::alg::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\let\textnormal\@firstofone

\def\textsc#1{\leavevmode\startXMLelement{sc}#1\endXMLelement{sc}}
\def\textbfsc#1{\leavevmode\startXMLelement{sc}#1\endXMLelement{sc}}

\endinput

__END__
