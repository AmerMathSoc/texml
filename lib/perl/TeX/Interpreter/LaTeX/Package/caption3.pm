package TeX::Interpreter::LaTeX::Package::caption3;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::caption3::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{caption3}

\newcommand\DeclareCaptionOption{\@gobbletwo}

\def\captionsetup{\@ifstar\@gobble@opt\@gobble@opt}

\newcommand*\caption@withoptargs[1]{%
  \@ifstar
    {\def\caption@tempa{*}\caption@@withoptargs{#1}}%
    {\def\caption@tempa{}\caption@@withoptargs{#1}}}

\def\caption@@withoptargs#1{%
  \@ifnextchar[%]
    {\caption@@@withoptargs{#1}}%
    {\caption@@@@withoptargs{#1}}}

\def\caption@@@withoptargs#1[#2]{%
  \l@addto@macro\caption@tempa{[{#2}]}%
  \caption@@withoptargs{#1}}

\def\caption@@@@withoptargs#1{%
  \def\caption@tempb{#1}%
  \expandafter\caption@tempb\expandafter{\caption@tempa}}

\TeXMLendPackage

\endinput

__END__
