package TeX::Interpreter::LaTeX::Package::paralist;

use strict;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("paralist", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::paralist::DATA{IO});

    return;
}

1;

__DATA__

\let\enumlabel\@mklab
\let\itemlabel\@mklab

\def\@asparaenum@{%
    \expandafter\list\csname label\@enumctr\endcsname{%
        \def\@listconfig{%
            \xmlpartag{p}%
            \let\@listpartag\@empty
        }%
        \let\@listelementname\@empty
        \let\@listitemname\@empty
        \usecounter{\@enumctr}%
        \let\@item\paralist@item
    }%
}

\def\@asparaitem@{%
    \expandafter\list\csname\@itemitem\endcsname{%
        \def\@listconfig{%
            \xmlpartag{p}%
            \let\@listpartag\@empty
        }%
        \let\@listelementname\@empty
        \let\@listitemname\@empty
        \let\@item\paralist@item
    }%
}

\def\paralist@item[#1]{%
    \@@par
    \if@noitemarg
        \@noitemargfalse
        \if@nmbrlist
            \refstepcounter\@listctr
        \fi
    \fi
    \everypar{\addXMLid#1\space\everypar{}}%
    \ignorespaces
}

\endinput

__END__
