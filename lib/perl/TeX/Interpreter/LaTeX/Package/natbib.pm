package TeX::Interpreter::LaTeX::Package::natbib;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("natbib", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::natbib::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{natbib}

%% NB: This is just enough to compile spec/plambeck.

%% TODO: This assumes maabook has been loaded.  FIX THIS

\AtBeginDocument{\let\MAA@NAT@wrap\XMLgeneratedText}

\def\hyper@natlinkstart#1{%
    \startXMLelement{xref}%
    \setXMLattribute{rid}{bibr-#1}%
    \setXMLattribute{ref-type}{bibr}%
}

\def\hyper@natlinkend{%
    \endXMLelement{xref}%
}

\def\hyper@natlinkbreak#1#2{#1}

\providecommand\hyper@natanchorstart[1]{}%
\providecommand\hyper@natanchorend{}%

\def\NAT@anchor#1#2{%
    \setXMLattribute{id}{bibr-#1}%
    \hyper@natanchorstart{#1\@extra@b@citeb}%
        \def\@tempa{#2}%
        \@ifx{\@tempa\@empty}{}{\@biblabel{#2}}%
    \hyper@natanchorend
}%

\def\@lbibitem[#1]#2{%
    \if\relax\@extra@b@citeb\relax\else
        \@ifundefined{br@#2\@extra@b@citeb}{}{%
            \@namedef{br@#2}{\@nameuse{br@#2\@extra@b@citeb}}%
        }%
    \fi
    \@ifundefined{b@#2\@extra@b@citeb}{%
        \def\NAT@num{}%
    }{%
        \NAT@parse{#2}%
    }%
    \def\NAT@tmp{#1}%
    \expandafter\let\expandafter\bibitemOpen\csname NAT@b@open@#2\endcsname
    \expandafter\let\expandafter\bibitemShut\csname NAT@b@shut@#2\endcsname
    \@ifnum{\NAT@merge>\@ne}{%
        \NAT@bibitem@first@sw{%
            \@firstoftwo
        }{%
            \@ifundefined{NAT@b*@#2}{%
                \@firstoftwo
            }{%
                \expandafter\def\expandafter\NAT@num\expandafter{\the\c@NAT@ctr}%
                \@secondoftwo
            }%
        }%
    }{%
        \@firstoftwo
    }%
    {%
        \global\advance\c@NAT@ctr\@ne
        \@ifx{\NAT@tmp\@empty}{\@firstoftwo}{%
            \@secondoftwo
        }%
        {%
            \expandafter\def\expandafter\NAT@num\expandafter{\the\c@NAT@ctr}%
            \global\NAT@stdbsttrue
        }{}%
        \bibitem@fin
        \item[\hfil\NAT@anchor{#2}{\NAT@num}]%
        \global\let\NAT@bibitem@first@sw\@secondoftwo
        \NAT@bibitem@init
    }%
    {%
        \NAT@anchor{#2}{}%
        \NAT@bibitem@cont
        \bibitem@fin
    }%
    \@ifx{\NAT@tmp\@empty}{%
        \NAT@wrout{\the\c@NAT@ctr}{}{}{}{#2}%
    }{%
        \expandafter\NAT@ifcmd\NAT@tmp(@)(@)\@nil{#2}%
    }%
}

%% spec/plambeck chapter bibliographies.  This is probably not good
%% enough in general.

\def\biblist@sec@level{1}

\renewenvironment{thebibliography}[1]{%
    % \if@backmatter
    %     \@clear@sectionstack
    % \else
    %     \backmatter
    % \fi
    %% I'm not sure what to do with \bibpreamble or if it should even be
    %% here to begin with, so I'm going to disable it for now.  Ditto
    %% \bibpostamble below.
    % \ifx\@empty\bibpreamble \else
    %     \begingroup
    %         \bibpreamble\par
    %     \endgroup
    % \fi
% \section*{}%
\@pop@sectionstack{\biblist@sec@level}%
    \def\@listelementname{ref-list}%
    \def\@listitemname{ref}%
    % \def\@listlabelname{label}
    \let\@listlabelname\@empty
    \def\@listdefname{mixed-citation}
    \list{%
        \@biblabel{\the\c@NAT@ctr}%
    }{%
        \@bibsetup{#1}%
        \global\c@NAT@ctr\z@
        \@listXMLidtrue
    }%
     \let\NAT@bibitem@first@sw\@firstoftwo
    \let\citeN\cite
    \let\shortcite\cite
    \let\citeasnoun\cite
    \startXMLelement{title}%
    \refname
    \endXMLelement{title}%
    \let\@listpartag\@empty
}{%
    \bibitem@fin
    %% See above
    % \bibpostamble
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

\TeXMLendPackage

\endinput

__END__
