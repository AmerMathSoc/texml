package TeX::Interpreter::LaTeX::Package::NLM;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # Restore some primitives that are modified for MathJax.

    for my $primitive (qw(noalign omit)) {
        $tex->primitive($primitive);
    }

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::NLM::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{NLM}

\newenvironment{NLMnote}[2][publishers-note]{%
    \par
    \startXMLelement{notes}%
    \addXMLid
    \setXMLattribute{notes-type}{#1}%
    \addcontentsline{toc}{chapter}{\protect\tocchapter{}{}{#2}{\@currentXMLid}}%
    \thisxmlpartag{title}#2\par
}{%
    \par
    \endXMLelement{notes}%
    \par
}

\TeXMLendPackage

\endinput

__END__
