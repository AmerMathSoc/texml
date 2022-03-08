package TeX::Interpreter::LaTeX::Package::booktabs;

use strict;
use warnings;

use version; our $VERSION = qv '1.2.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("booktabs", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::booktabs::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{booktabs}

\def\@BTrule[#1]{%
    \ifx\longtable\undefined
        \let\@BTswitch\@BTnormal
    \else\ifx\hline\LT@hline
        \let\@BTswitch\@BLTrule
    \else
        \let\@BTswitch\@BTnormal
    \fi\fi
    \global\@thisrulewidth=#1\relax
    % \ifnum\@thisruleclass=\tw@
    %     \vskip\@aboverulesep
    % \else
    %     \ifnum\@lastruleclass=\z@
    %         \vskip\@aboverulesep
    %     \else
    %         \ifnum\@lastruleclass=\@ne\vskip\doublerulesep\fi
    %     \fi
    % \fi
    \count@\alignrowno
    \def\@selector{table####\@currentTBLRid\space tr:nth-child(\the\count@)}%
    \edef\current@border@width{\the\@thisrulewidth}%
    \ifnum\alignrowno=\z@
        \advance\count@\@ne
        \addCSSclass{\@selector}{border-top: \current@border@properties;}%
    \else
        \addCSSclass{\@selector}{border-bottom: \current@border@properties;}%
    \fi
    \@BTswitch
}

%% Remove code that might increase the row number.

\def\@BTnormal{%
    \futurenonspacelet\@tempa\@BTendrule}

\def\@BTendrule{\ifnum0=`{\fi}}

\def\@@BLTrule(#1){%
        \global\@cmidlb\LT@cols
    \ifnum0=`{\fi}%
}

\def\@@@cmidrule[#1-#2]#3#4{%
        \global\@thisrulewidth=#3\relax
        \edef\current@border@width{\the\@thisrulewidth}%
        \count@\alignrowno
        \edef\@selector{%
            \@thistable\space
            tr:nth-child(\the\TeXMLtoprow \alignrowno \count@)\space
            \@nx\nth@col{\@nx\the\count@}%
        }%
        \count@#1
        \@tempcnta#2
        \advance\@tempcnta\@ne
        \@whilenum\count@<\@tempcnta\do{%
            \addCSSclass{\@selector}{border-bottom: \current@border@properties;}%
            \advance\count@\@ne
        }%
    \ifnum0=`{\fi}%
}

\def\tablestrut{}

\TeXMLendPackage

\endinput

__END__
