package TeX::Interpreter::LaTeX::Package::tcolorbox;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("tcolorbox", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::tcolorbox::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{tcolorbox}

\providecommand{\tcbuselibrary}[1]{}

\newenvironment{tcolorbox}[1][]{%
    \par
    \startXMLelement{boxed-text}
    \setXMLattribute{content-type}{tcolorbox}%
    \setXMLattribute{position}{anchor}%
    \setXMLattribute{border-color}{black}%
    \setXMLattribute{background-color}{lightgray}%
    \par
}{%
    \par
    \endXMLelement{boxed-text}
    \par
}

\TeXMLendPackage

\endinput

__END__
