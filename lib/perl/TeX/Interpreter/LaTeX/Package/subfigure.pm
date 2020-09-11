package TeX::Interpreter::LaTeX::Package::subfigure;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    @options = grep { ! m{^normal$} } @options;

    $tex->load_latex_package("subfigure", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::subfigure::DATA{IO});

    return;
}

1;

__DATA__

% All figures will be enclosed by <fig-group> elements, which will be
% demoted back to <fig> by XML::Output::normalize_figures() if
% necessary.

\def\jats@figure@element{fig-group}

\def\thesubfigure{\alph{subfigure}}
\def\thesubtable{\alph{subtable}}

\def\subfigure{%
  \bgroup
    \let\subfig@oldlabel=\label
    \let\label=\subfloat@label
    \refstepcounter{sub\@captype}%
    \@ifnextchar [%
      {\@subfigure}%
      {\@subfigure[\@empty]}%
}

\let\subtable=\subfigure

% #1: type: 'subfigure' or 'subtable' (ignore)
% #2: list_entry                      (ignore)
% #3: subcaption
% #4: figure (for now, assume it's just an \includegraphics)

\long\def\@subfloat#1[#2][#3]#4{%
    \leavevmode
    \startXMLelement{fig}%
    \addXMLid
    \ifx\@empty#3\relax\else
        \@subcaption{#1}{#2}{#3}%
    \fi
    #4%
    \endXMLelement{fig}%
  \egroup
}

\renewcommand*{\@thesubfigure}{\thesubfigure}
\renewcommand*{\@thesubtable}{\thesubtable}

\renewcommand{\@makesubfigurecaption}[2]{%
    \begingroup
        \protected@edef\@tempa{\zap@space#1 \@empty}% Is this \edef safe?
        \ifx\@tempa\@empty\else
            \startXMLelement{label}%
            #1%
            \endXMLelement{label}%
        \fi
    \endgroup
    \st@rredtrue
    \@caption{}[]{#2}%
}

\let\@makesubtablecaption=\@makesubfigurecaption

\let\@caption\subfig@oldcaption

\endinput

__END__
