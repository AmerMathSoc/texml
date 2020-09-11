package TeX::Interpreter::LaTeX::Package::algorithm;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("algorithm", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::algorithm::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{algorithm}

%% The following declarations might be misplaced.

\@ifpackagewith{algorithm}{section}{%
    \newcounter{algorithm}[section]%
    \def\thealgorithm{\thesection.\arabic{algorithm}}%
}{%
    \newcounter{algorithm}%
}

\def\algorithmname{Algorithm}

\providecommand{\fnum@algorithm}{\fname@algorithm}

\let\algorithm\relax
\let\endalgorithm\relax
\newenvironment{algorithm}[1][]{%
    \let\center\@empty
    \let\endcenter\@empty
    \par
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{algorithm}%
    \def\@captype{algorithm}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \addXMLid
}{%
    \endXMLelement{\jats@figure@element}%
    \par
}

\TeXMLendPackage

\endinput

__END__
