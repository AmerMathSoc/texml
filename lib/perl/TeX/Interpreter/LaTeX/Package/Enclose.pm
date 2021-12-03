package TeX::Interpreter::LaTeX::Package::Enclose;

# Support for the MathJax Enclose extension.

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::Enclose::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{Enclose}

\let\MathJax@enclose@end\@empty

\newcommand{\enclose}[1]{%
    \leavevmode
    \begingroup
        % This allows \enclose to be used in text mode.  It's sort of
        % like an automatic \ensuremath.
        \ifmmode
            \def\MathJax@enclose@end{}%
        \else
            $\def\MathJax@enclose@end{$}%
        \fi
        \string\enclose\string{#1\string}%
        \MathJax@enclose@continue
}

\newcommand{\MathJax@enclose@continue}[2][]{%
        \if###1##\else[#1]\fi
        \string{#2\string}%
        \MathJax@enclose@end
    \endgroup
}

\TeXMLendPackage

\endinput

__END__
