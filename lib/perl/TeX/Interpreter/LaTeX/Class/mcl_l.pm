package TeX::Interpreter::LaTeX::Class::mcl_l;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_class('mcl-l', @options);

    $tex->load_document_class('amsbook', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::mcl_l::DATA{IO});

    return;
}

1;

__DATA__

\let\dedication\relax
\let\enddedication\relax

\newenvironment{dedication}{%
    \frontmatter
    \def\\{\emptyXMLelement{break}}%
    \startXMLelement{dedication}
        \startXMLelement{book-part-meta}
            \startXMLelement{title-group}
                \thisxmlpartag{title}%
                Dedication\par
            \endXMLelement{title-group}
        \endXMLelement{book-part-meta}
        \startXMLelement{named-book-part-body}
        \par
}{%
        \par
        \endXMLelement{named-book-part-body}
    \endXMLelement{dedication}
}

\newcounter{problem}
\newcounter{solution}

\newenvironment{problem}[1][]{%
    \par
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{\@currenvir}%
    \refstepcounter{problem}%
    \thisxmlpartag{label}%
    Problem \theproblem#1\par
    \ignorespaces
}{%
    \par
    \endXMLelement{statement}%
}

\newenvironment{solution}{%
    \par
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{\@currenvir}%
    \refstepcounter{solution}%
    \thisxmlpartag{label}%
    Solution \thesolution\par
    \ignorespaces
}{%
    \par
    \endXMLelement{statement}
}

\newenvironment{Remark}{%
    \par
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{\@currenvir}%
    \thisxmlpartag{label}%
    Remark\par
    \ignorespaces
}{%
    \par
    \endXMLelement{statement}%
}

\newcommand{\answ}[2]{
  \textbf{#1.}\enspace #2\quad
}

\newenvironment{fsl}{%
  \emph{First solution.}\enskip\ignorespaces
}{%
  \par\addvspace{\medskipamount}%
}

\newenvironment{ssl}{%
  \noindent \emph{Second solution.}\enskip\ignorespaces
}{%
  \par\addvspace{\medskipamount}%
}

\def\upstrut{\noindent\vbox to \normalbaselineskip{}}
\def\downstrut{\noindent\lower.5em\vbox{}}

\def\emdash{\unskip\textemdash\ignorespaces}

\endinput

__END__
