package TeX::Interpreter::LaTeX::Package::subfig;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("subfig", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::subfig::DATA{IO});

    return;
}

1;

__DATA__

% All figures will be enclosed by <fig-group> elements, which will be
% demoted back to <fig> by XML::Output::normalize_figures() if
% necessary.

\def\jats@figure@element{fig-group}

\let\caption@settype\@gobble

% #1 = sub\@captype
% #2 = list-entry (ignored)
% #3 = caption
% #4 = figure

\def\sf@subfloat{%
    \begingroup
        \sf@ifpositiontop{%
            \maincaptiontoptrue
        }{%
            \maincaptiontopfalse
        }%
        \ifmaincaptiontop\else
            \advance\@nameuse{c@\@captype}\@ne
        \fi
        \refstepcounter{sub\@captype}%
        \setcounter{sub\@captype @save}{\value{sub\@captype}}%
        \@ifnextchar [%  %] match left bracket
            {\sf@@subfloat}%
            {\sf@@subfloat[\@empty]}%
}

\long\def\sf@@@subfloat#1[#2][#3]#4{%
        \leavevmode
        \startXMLelement{fig}%
            \addXMLid
            \sf@subcaption{#1}{#2}{#3}%
            #4%
        \endXMLelement{fig}%
    \endgroup
    \ignorespaces
}

\long\def\sf@subcaption#1#2#3{%
    \protected@edef\@tempa{\csname sub\@captype name\endcsname}%
    \ifx\@tempa\@empty\else
        \protected@edef\@tempa{\@tempa\space}%
    \fi
    \protected@edef\@tempa{\@tempa\@nameuse{thesub\@captype}}%
    \ifx\@tempa\@empty\else
        \startXMLelement{label}%
            \@tempa
        \endXMLelement{label}%
    \fi
    \if###3##\else
        \startXMLelement{caption}%
            \startXMLelement{p}%
            #3%
            \endXMLelement{p}%
        \endXMLelement{caption}%
    \fi
}

\AtBeginDocument{
    \RestoreEnvironmentDefinition{figure}
    \RestoreEnvironmentDefinition{figure*}
    \RestoreEnvironmentDefinition{table}
    \RestoreEnvironmentDefinition{table*}
    \RestoreMacroDefinition\caption
    \RestoreMacroDefinition\caption@
    \RestoreMacroDefinition\@caption
}

\endinput

__END__
