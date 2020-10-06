package TeX::Interpreter::LaTeX::Package::babel;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::babel::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{babel}

\let\selectlanguage\@gobble

\UCSchardef\guillemotleft"00AB
\UCSchardef\guillemotright"00BB

\def\og{\leavevmode\guillemotleft~\ignorespaces}

\def\fg{\unskip~\guillemotright}

\TeXMLendPackage

\endinput

__END__
