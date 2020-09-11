package TeX::Interpreter::LaTeX::Package::subcaption;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::subcaption::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{subcaption}

\RequirePackage{caption}[2012/03/25] % needs v3.3 or newer

\def\jats@figure@element{fig-group}

\newcounter{subfigure}
\def\thesubfigure{\alph{subfigure}}

\renewenvironment{figure}[1][]{%
    \let\center\@empty
    \let\endcenter\@empty
    \par
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{fig}%
    \def\@captype{figure}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \addXMLid
    \setcounter{subfigure}{0}%
}{%
    \endXMLelement{\jats@figure@element}%
    \par
}

\newenvironment{subfigure}[2][]{%
    \let\center\@empty
    \let\endcenter\@empty
    \par
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{fig}%
    \def\@captype{figure}%
    \ifx\label\subcaption@label \else
        \let\subcaption@ORI@label\label
        \let\label\subcaption@label
    \fi
    \def\caption@{\@dblarg{\@caption{subfigure}}}
    \def\subcaption{\caption}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{fig}%
    \addXMLid
}{%
    \endXMLelement{fig}%
    \par
}

\let\subfigurename\@empty
\newcommand*\subcaption@label{\caption@withoptargs\subcaption@@label}

\newcommand*\subcaption@@label[2]{%
    \@bsphack
    \begingroup
        \protected@edef\@currentlabel{\csname thesub\@captype\endcsname}%
        \subcaption@ORI@label#1{sub@#2}%
        %% CHEAT
        %% This isn't right if the caption is at the top, but is it ok
        %% otherwise? 
        \expandafter\advance \csname c@\@captype\endcsname \@ne
        \protected@edef\@currentlabel{\csname the\@captype\endcsname\@currentlabel}%
        \subcaption@ORI@label#1{#2}%
      \endgroup
    \@esphack
}

\DeclareRobustCommand*\subref{%
  \@ifstar
    {\caption@withoptargs\subcaption@ref*}%
    {\caption@withoptargs\@subref}}

\newcommand*\@subref[2]{%
    \subcaption@ref{#1}{#2}%
}

\newcommand*\subcaption@ref[2]{%
    \begingroup
        %\caption@setoptions{sub}%
        \subcaption@reffmt\p@subref{\ref#1{sub@#2}}%
      \endgroup
}

\newcommand*\p@subref{}

\def\bothIfFirst#1#2{%
    \protected@edef\caption@tempa{#1}%
    \ifx \caption@tempa \@empty \else #1#2\fi
}

\def\subcaption@reffmt#1#2{\bothIfFirst {#1}{\nobreakspace }#2}

\endinput

__END__
