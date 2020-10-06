package TeX::Interpreter::LaTeX::Class::jams_l;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_document_class('amsart', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::jams_l::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesClass{jams-l}[2007/06/18 v2.01 JAMS article documentclass]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions\relax

\LoadClass{amsart}[1996/10/24]

\def\publname{JOURNAL OF THE\newline
  AMERICAN MATHEMATICAL SOCIETY}

\def\ISSN{0894-0347}

\TeXMLendClass

\endinput

__END__
