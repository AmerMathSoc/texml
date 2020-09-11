package TeX::Interpreter::LaTeX::Package::hyperref;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::hyperref::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{hyperref}

\RequirePackage{url}

\let\phantomsection\relax
\let\hypersetup\@gobble
\newcommand{\pdfbookmark}[3][]{}
\let\@currentHref\@empty

\def\autoref#1{%
    \expandafter\@setref\csname r@#1\endcsname\set@autoref{#1}\autoref
}

\def\set@autoref#1#2#3#4{%
    \begingroup
        \edef\@tempa{\auto@ref@label{#3}}%
        \ifx\@tempa\@empty\else
            \XMLgeneratedText\@tempa~%
        \fi
        #1%
    \endgroup
}

\providecommand*\AMSautorefname{\equationautorefname}
\providecommand*\Hfootnoteautorefname{\footnoteautorefname}
\providecommand*\Itemautorefname{\itemautorefname}
\providecommand*\itemautorefname{item}
\providecommand*\equationautorefname{Equation}
\providecommand*\footnoteautorefname{footnote}
\providecommand*\itemautorefname{item}
\providecommand*\figureautorefname{Figure}
\providecommand*\tableautorefname{Table}
\providecommand*\partautorefname{Part}
\providecommand*\appendixautorefname{Appendix}
\providecommand*\chapterautorefname{chapter}
\providecommand*\sectionautorefname{section}
\providecommand*\subsectionautorefname{subsection}
\providecommand*\subsubsectionautorefname{subsubsection}
\providecommand*\paragraphautorefname{paragraph}
\providecommand*\subparagraphautorefname{subparagraph}
\providecommand*\FancyVerbLineautorefname{line}
\providecommand*\theoremautorefname{Theorem}
\providecommand*\pageautorefname{page}

\let\nolinkurl\@firstofone

\let\href\relax

\newcommand{\href}[3][]{%
    \begingroup
        \protected@edef\@tempa{#2}%
        \TeXML@NormalizeURL\@tempa
        \setbox\@tempboxa\hbox{\@tempa}%
        \leavevmode
        \startXMLelement{ext-link}%
        \setXMLattribute{xlink:href}{\boxtostring\@tempboxa}%
        % The extra braces around the arg are to handle things like \tt.
        {#3}%
        \endXMLelement{ext-link}%
    \endgroup
}

\newcommand{\hyperref}[2][]{%
    \if###1##
        #2%
    \else
        \expandafter\@sethyperref
            \csname r@#1\endcsname\@firstofone{#1}\hyperref{#2}%
    \fi
}

% #1 = \r@LABEL
% #2 = getter
% #3 = LABEL
% %4 = \hyperref
% %5 = text

%% TODO: Merge this with \@setref

\def\@sethyperref#1#2#3#4#5{%
    \leavevmode
    \startXMLelement{xref}%
    \if@TeXMLend
        \@ifundefined{r@#3}{%
            \setXMLattribute{specific-use}{undefined}%
            \texttt{?#3}%
        }{%
            \begingroup
                \double@expand{%
                    \edef\noexpand\@ref@label@attr{%
                        \noexpand\auto@ref@label{\expandafter\@thirdoffour#1}%
                    }%
                }%
                \ifx\@ref@label@attr\@empty\else
                    \setXMLattribute{ref-label}{\@ref@label@attr}%
                \fi
            \endgroup
            \setXMLattribute{specific-use}{\expandafter\@gobble\string#4}%
            \setXMLattribute{rid}{\expandafter\@thirdoffour#1}%
            \setXMLattribute{ref-type}{\expandafter\@fourthoffour#1}%
            % \protect\printref{\expandafter#2#1}%
        }%
    \else
        \setXMLattribute{ref-key}{#3}%
        \setXMLattribute{specific-use}{unresolved \expandafter\@gobble\string#4}%
    \fi
    #5%
    \endXMLelement{xref}%
}

\def\hyperlink#1#2{%
    \leavevmode
    \startXMLelement{xref}%
    \setXMLattribute{rid}{#1}%
    \setXMLattribute{ref-type}{text}%
    #2%
    \endXMLelement{xref}%
}

\def\hypertarget#1#2{%
    \leavevmode
    \startXMLelement{target}%
    \setXMLattribute{id}{#1}%
    \setXMLattribute{target-type}{text}%
    #2%
    \endXMLelement{target}%
}

\TeXMLendPackage

\endinput

__END__
