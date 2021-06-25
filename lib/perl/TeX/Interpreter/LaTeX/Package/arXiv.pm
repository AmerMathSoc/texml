package TeX::Interpreter::LaTeX::Package::arXiv;

## This is redundant with amsrefs now.

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::arXiv::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{arXiv}

% \newcommand{\arXiv}[1]{\href{https://arxiv.org/abs/#1}{\texttt{arXiv:#1}}}

\def\wikiurl#1{\url{https://en.wikipedia.org/wiki/#1}}
%    \begin{macro}{\parse@arXiv}
%    \begin{macrocode}
\def\parse@arXiv#1 [#2]#3\@nnil{%
    \def\arXiv@number{#1}%
    \def\arXiv@category{#2}%
    \def\arXiv@url{https://arxiv.org/abs/#1}%
}
%    \end{macrocode}
%    \end{macro}
%
%    \begin{macro}{\arXiv}
%    \begin{macrocode}
\def\arXiv#1{%
    \begingroup
        \parse@arXiv#1 []\@nil\@nnil
        \href{\arXiv@url}{%
            \texttt{arXiv:\arXiv@number}%
        }%
        \ifx\arXiv@category\@empty\else
            \space[\arXiv@category]%
        \fi
    \endgroup
}
%    \end{macrocode}
%    \end{macro}

\TeXMLendPackage

\endinput

__END__
