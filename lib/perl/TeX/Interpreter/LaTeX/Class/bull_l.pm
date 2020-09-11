package TeX::Interpreter::LaTeX::Class::bull_l;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_document_class('amsart', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::bull_l::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesClass{bull-l}[2009/05/07 v2.05 BULL Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions\relax

\LoadClass{amsart}[1996/10/24]

\def\publname{BULLETIN (New Series) OF THE\newline
  AMERICAN MATHEMATICAL SOCIETY}

\def\ISSN{0273-0979}

\def\bullPerspective{}

\newif\if@SuperTitle
\@SuperTitlefalse

\def\SuperTitle{%
    \@SuperTitletrue
    \def\@SuperTitle
}

\TeXMLendClass

\endinput

__END__
