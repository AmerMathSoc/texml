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
    % \typeout{*** OPEN #1}%
    \par
    \startXMLelement{\ALC@NS:#1}%
}

\newcommand{\ALC@close}[1]{%
    % \typeout{*** CLOSE #1}%
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

%% Top-level (sort of)

\newif\if@ALCnumbered
\@ALCnumberedfalse

\def\ALC@addlineno{%
    \if@ALCnumbered
        \refstepcounter{ALC@line}%
        \stepcounter{ALC@rem}%
        \ifnum\c@ALC@rem=\ALC@frequency
            \setXMLattribute{lineno}{\the\c@ALC@line}%
            \c@ALC@rem\z@
        \fi
    \fi
}

\def\defALC@toplevel{\maybe@st@rred{\defALC@toplevel@}}

\def\defALC@toplevel@#1#2{%
    \edef#1{%
        \@nx\ALC@endstatement
        \@nx\ALC@begingroup
            \let\@nx\ALC@endstatement\@nx\ALC@endgroup
            \ifst@rred\else
                \@nx\ALC@pushtag{line}%
                \@nx\ALC@addlineno
            \fi
            \@nx\ALC@pushtag{#2}%
    }%
}

\let\ALC@endstatement\@empty

\defALC@toplevel{\STATE}   {statement}
\defALC@toplevel{\GLOBALS} {globals}
\defALC@toplevel*{\REQUIRE}{require}
\defALC@toplevel*{\ENSURE} {ensure}

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

% These are defined inside the definition of \algorithmic in
%  algorithmic.sty, so we need to repeat them here.

\newcommand{\TRUE}{\algorithmictrue{}}
\newcommand{\FALSE}{\algorithmicfalse{}}
\newcommand{\AND}{\algorithmicand{} }
\newcommand{\OR}{\algorithmicor{} }
\newcommand{\XOR}{\algorithmicxor{} }
\newcommand{\NOT}{\algorithmicnot{} }
\newcommand{\TO}{\algorithmicto{} }

\newcount\ALC@frequency

% TODO: linenodelimiter

\renewenvironment{algorithmic}[1][0]{
    \par
    \xmlpartag{}%
    \def\\{\emptyXMLelement{br}}%
    \ALC@frequency=#1\relax
    \ifnum\ALC@frequency=\z@
        \@ALCnumberedfalse
    \else
        \@ALCnumberedtrue
        \c@ALC@line\z@
        \c@ALC@rem\z@
    \fi
    % TBD: Do we need ALC@unique?
    \ALC@begingroup
        \ALC@pushtag{algorithm}%
        \setXMLattribute{linenodelimiter}{\ALC@linenodelimiter}%
        \ifALC@noend
            \setXMLattribute{endtags}{no}%
        \else
            \setXMLattribute{endtags}{yes}%
        \fi
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
        \ALC@start@condition
            #3%
        \ALC@end@condition
        \ALC@com{#2}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ALC@end@structure}{%
            \ALC@endstatement
        \ALC@endgroup  % LEVEL 2
    \ALC@endgroup % LEVEL
}

\newcommand{\ALC@start@condition}{%
    \ALC@open{condition}%
    \ALC@open{line}%
    \ALC@addlineno
    \ALC@begingroup
}

\newcommand{\ALC@end@condition}{%
    \ALC@endgroup
    \ALC@close{line}%
    \ALC@close{condition}%
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

            \ALC@start@condition
                #1%
            \ALC@end@condition
            \ALC@com{#1}%
        \ALC@endgroup
    \ALC@endgroup
}

\let\ENDLOOP\ALC@end@structure

\TeXMLendPackage

\endinput

__END__

https://codepen.io/pkra/pen/339d4c791a24ab6f57d157e0ac69d537
