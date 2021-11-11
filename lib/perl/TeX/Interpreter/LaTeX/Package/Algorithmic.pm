package TeX::Interpreter::LaTeX::Package::Algorithmic;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("algorithmic", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::Algorithmic::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{Algorithmic}

\@namedef{ver@algorithmic.sty}{XXX}

\def\ALC@NS{alg}

\newcommand{\ALC@open}[1]{%
    \typeout{*** OPEN #1}%
    \par
    \startXMLelement{\ALC@NS:#1}%
}

\newcommand{\ALC@close}[1]{%
    \typeout{*** CLOSE #1}%
    \par
    \endXMLelement{\ALC@NS:#1}%
}

\let\ALC@tagstack\@empty

\long\def\g@push@stack#1#2{%
    \protected@edef#1{\protect#2#1}%
}

\def\ALC@clearstack{\let\ALC@tagstack\@empty}

\def\ALC@pushtag#1{%
    \ALC@open{#1}%
    \g@push@stack\ALC@tagstack{\ALC@close{#1}}%
}

\def\ALC@popstack{%
    \par
    \ALC@tagstack
    \ALC@clearstack
}

\def\ALC@begingroup{%
    \begingroup
        \ALC@clearstack
        \let\ALC@endstatement\@empty
}

\def\ALC@endgroup{%
        \ALC@popstack
    \endgroup
}

\let\ALC@endblock\@empty

%% Top-level (sort of)

\def\ALC@toplevel{\maybe@st@rred{\ALC@toplevel@}}

\def\ALC@toplevel@#1{%
    \ALC@endstatement
    \ALC@begingroup
        \let\ALC@endstatement\ALC@endgroup
        \ifst@rred\else
            \ALC@pushtag{line}%
        \fi
        \ALC@pushtag{#1}%
}

\let\ALC@endstatement\@empty

\newcommand{\STATE}{\ALC@toplevel{statement}}
\newcommand{\GLOBALS}{\ALC@toplevel{globals}}
\newcommand{\REQUIRE}{\ALC@toplevel*{require}}
\newcommand{\ENSURE}{\ALC@toplevel*{ensure}}

\let\STMT\STATE

\newcommand{\PRINT}{%
    \STATE \algorithmicprint{} % keep this space
}

\newcommand{\RETURN}{%
    \STATE \algorithmicreturn{} % keep this space
}

\def\algorithmiccomment#1{%
    \ALC@open{comment}#1\ALC@close{comment}%
}

\let\COMMENT\algorithmiccomment

\newcommand{\ALC@com}[1]{%
    \ifthenelse{\equal{#1}{default}}{}{\ \COMMENT{#1}}%
}

\newcommand{\TRUE}{\algorithmictrue{}}
\newcommand{\FALSE}{\algorithmicfalse{}}
\newcommand{\AND}{\algorithmicand{} }
\newcommand{\OR}{\algorithmicor{} }
\newcommand{\XOR}{\algorithmicxor{} }
\newcommand{\NOT}{\algorithmicnot{} }
\newcommand{\TO}{\algorithmicto{} }

\renewenvironment{algorithmic}[1][0]{
    \par
    \xmlpartag{}%
    \def\\{\emptyXMLelement{br}}%
    \ALC@begingroup
        \ALC@pushtag{algorithm}
    % \newcommand{\ALC@it}{%       TBD
    %     \stepcounter{ALC@rem}%
    % % UGGGG
    %     \ifthenelse{\equal{\arabic{ALC@rem}}{#1}}{\setcounter{ALC@rem}{0}}{}%
    %     \stepcounter{ALC@line}%
    %     \refstepcounter{ALC@unique}%
    %     % \item\def\@currentlabel{\theALC@line}%
    %     \par
    % }
}{%
        \ALC@endstatement
    \ALC@endgroup
    \par
}

\newcommand{\INPUTS}[1][default]{%
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{inputs}
        \ALC@com{#1}%
}

\newcommand{\ENDINPUTS}{%
        \ALC@endstatement
    \ALC@endgroup
}

\newcommand{\OUTPUTS}[1][default]{%
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{outputs}
        \ALC@com{#1}%
}

\newcommand{\ENDOUTPUTS}{%
        \ALC@endstatement
    \ALC@endgroup
}

\newcommand{\BODY}[1][default]{%
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{body}
        \ALC@com{#1}%
}

\newcommand{\ENDBODY}{%
        \ALC@endstatement
    \ALC@endgroup
}

\newcommand{\ALC@begin@structure}[3]{%
    \ALC@endstatement
    \ALC@begingroup % LEVEL 1
        \ALC@pushtag{#1}%
        \ALC@open{condition}%
        \ALC@open{line}%
        \ALC@begingroup
            #3%
        \ALC@endgroup
        \ALC@close{line}%
        \ALC@close{condition}%
        \ALC@com{#2}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ALC@end@structure}{%
            \ALC@endstatement
        \ALC@endgroup  % LEVEL 2
    \ALC@endgroup % LEVEL
}

\newcommand{\WHILE}[2][default]{%
    \ALC@begin@structure{while}{#1}{#2}
}

\let\ENDWHILE\ALC@end@structure

\newcommand{\IF}[2][default]{%
    \ALC@begin@structure{if}{#1}{#2}%
    \let\ALC@end@else\@empty
}

\newcommand{\ELSIF}[2][default]{%
                \ALC@endstatement
            \ALC@end@else
        \ALC@endgroup % end the block (LEVEL 2)
        \let\ALC@end@else\ALC@endgroup % (LEVEL 1)
        \ALC@begin@structure{elsif}{#1}{#2}% LEVEL 3
}

\newcommand{\ELSE}[1][default]{% No condition
                \ALC@endstatement
            \ALC@end@else
        \ALC@endgroup % end if block
        \let\ALC@end@else\ALC@endgroup
        \ALC@begingroup
            \ALC@pushtag{else}
            \ALC@begingroup
                \ALC@pushtag{block}%
}

\def\ENDIF{%
                \ALC@endstatement
            \ALC@end@else
        \ALC@endgroup % END BLOCK (LEVEL 2)
    \ALC@endgroup
}

\newcommand{\FOR}[2][default]{%
    \ALC@begin@structure{for}{#1}{#2}
}

\newcommand{\FORALL}[2][default]{%
    \ALC@begin@structure{forall}{#1}{#2}
}

\let\ENDFOR\ALC@end@structure

\newcommand{\LOOP}[1][default]{% No condition
    % \ALC@begin@structure{loop}{#1}{#2}
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{loop}%
        \ALC@com{#1}%
        \ALC@begingroup
            \ALC@pushtag{block}%
}

\newcommand{\REPEAT}[1][default]{% No condition
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{repeat}%
        \ALC@com{#1}%
        \ALC@begingroup
            \ALC@pushtag{block}%
}

\newcommand{\UNTIL}[1]{%
            \ALC@endstatement
        \ALC@endgroup
        \ALC@begingroup
            \ALC@pushtag{until}%
            \ALC@open{condition}%
            \ALC@open{line}%
            \ALC@begingroup
                #1%
            \ALC@endgroup
            \ALC@close{line}%
            \ALC@close{condition}%
            \ALC@com{#1}%
        \ALC@endgroup
    \ALC@endgroup
}

\let\ENDLOOP\ALC@end@structure

\TeXMLendPackage

\endinput

__END__

https://codepen.io/pkra/pen/339d4c791a24ab6f57d157e0ac69d537
