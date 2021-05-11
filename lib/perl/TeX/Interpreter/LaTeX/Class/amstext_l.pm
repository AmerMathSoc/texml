package TeX::Interpreter::LaTeX::Class::amstext_l;

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_document_class('amsbook', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::amstext_l::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesClass{amstext-l}

\newenvironment{inclusion}[1]{%
    \quotation
    \if###1##\else\textbf{#1}\par\fi
}{%
    \endquotation
}

\newenvironment{framedthm}[1]{%
    \def\@current@framed{#1}%
    \csname \@current@framed\endcsname
    % \setXMLattribute{framed}{yes}%
}{
    \csname end\@current@framed\endcsname
}

\TeXMLendClass

\endinput

__END__
