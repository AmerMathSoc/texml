package TeX::Interpreter::LaTeX::Package::algorithm2e;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::algorithm2e::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{algorithm2e}

\newcounter{algocf}

\let\SetKw\@gobbletwo
\let\IncMargin\@gobble

\def\fnum@algocf{\algorithmcfname \thealgocf}

\def\algocfname{\algorithmcfname}

\newcommand{\NoCaptionOfAlgo}{%
    \let\algocfname\@empty
    \let\thealgocf\@empty
}

\let\algocf@algocfref\@empty

\newcommand{\SetAlgoRefName}[1]{%
    \def\algocf@algocfref{#1}%
}

\newcommand{\SetAlgorithmName}[3]{%
    \def\listalgorithmcfname{#3}%
    \def\algorithmcfname{#1}%
    \def\algorithmautorefname{#2}%
}%

\SetAlgorithmName{Algorithm}{algorithm}{List of algorithms}

\let\TeXML@caption\@empty
\let\TeXML@label\@empty

\let\algorithm\relax
\newcommand{\algorithm}[1][]{%
    \endgroup
    \begingroup
        \TeXMLSVGpaperwidth=8.5in
        \edef\texml@body{%
            % \noexpand\SetAlgoRefName{\algocf@algocfref}%
            \noexpand\begin{algorithm}%
        }%
        % \@tempa holds the name of the environment whose body
        % \texml@collect should collect (cf. \texml@process@env).
        \def\@tempa{algorithm}%
        \afterassignment\texml@collect
        \def\texml@callback{%
            \par
            \let\center\@empty
            \let\endcenter\@empty
            \xmlpartag{}%
            \leavevmode
            \def\@currentreftype{algorithm}%
            \def\@captype{algocf}%
            \def\jats@graphics@element{graphic}
            \startXMLelement{\jats@figure@element}%
            \addXMLid
            \setXMLattribute{content-type}{algorithm}%
            \set@float@fps@attribute{#1}%
            \@tempswafalse
            \TeXML@extract@caption
            \TeXML@extract@caption % Delete an empty \caption/\label
            \toks@\expandafter{\texml@body}%
            \edef\next@{\noexpand\TeXMLCreateSVG*{\the\toks@}}%
            \next@
            \if@tempswa
                \ifx\algocf@algocfref\@empty\else
                    \let\thealgocf\algocf@algocfref
                \fi
                \caption{\TeXML@caption}%
            \fi
            \ifx\TeXML@label\@empty\else
                \label{\TeXML@label}%
            \fi
            \endXMLelement{\jats@figure@element}%
            \par
        }%
}

\def\TeXML@extract@caption{%
    \expandafter\@TeXML@extract@caption\texml@body\caption{\@nil}\@nil
    \expandafter\@TeXML@extract@label\texml@body\label{\@nil}\@nil
}

\def\@TeXML@extract@caption#1\caption#2#3\@nil{%
    \def\@tempb{#2}%
    \ifx\@tempb\@nnil
        \def\texml@body{#1}%
    \else
        \@tempswatrue
        \def\TeXML@caption{#2}%
        \def\texml@body{#1#3}%
    \fi
}

\def\@TeXML@extract@label#1\label#2#3\@nil{%
    \def\@tempb{#2}%
    \ifx\@tempb\@nnil
        \def\texml@body{#1}%
    \else
        \def\TeXML@label{#2}%
        \def\texml@body{#1#3}%
    \fi
}

\TeXMLendPackage

\endinput

__END__
