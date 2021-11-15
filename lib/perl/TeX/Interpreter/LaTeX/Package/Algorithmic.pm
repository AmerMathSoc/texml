package TeX::Interpreter::LaTeX::Package::Algorithmic;

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

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
            \setcounter{ALC@rem}{0}%
        \fi
    \fi
}

\def\ALC@line#1{%
    \ALC@open{line}%
        \ALC@addlineno
        #1
    \ALC@close{line}%
}

\def\defALC@toplevel{\maybe@st@rred{\defALC@toplevel@}}

\newcommand{\defALC@toplevel@}[3][]{%
    \edef#2{%
        \@nx\ALC@endstatement
        \@nx\ALC@begingroup
            \let\@nx\ALC@endstatement\@nx\ALC@endgroup
            \ifst@rred\else
                \@nx\ALC@pushtag{line}%
                \@nx\ALC@addlineno
            \fi
            \@nx\ALC@pushtag{#3}%
            \if###1##\else
                #1
            \fi
    }%
}

\let\ALC@endstatement\@empty

\defALC@toplevel{\STATE}{statement}
\defALC@toplevel[\algorithmicglobals]{\GLOBALS} {globals}
\defALC@toplevel*[\algorithmicrequire]{\REQUIRE}{require}
\defALC@toplevel*[\algorithmicensure]{\ENSURE} {ensure}

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
}{%
        \ALC@endstatement
    \ALC@endgroup
    \par
}

\newcommand{\INPUTS}[1][default]{%
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{inputs}%
        \ALC@line{\algorithmicinputs\ALC@com{#1}}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ENDINPUTS}{%
            \ALC@endstatement
        \ALC@endgroup
    \ALC@endgroup
}

\newcommand{\OUTPUTS}[1][default]{%
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{outputs}%
        \ALC@line{\algorithmicoutputs\ALC@com{#1}}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ENDOUTPUTS}{%
            \ALC@endstatement
        \ALC@endgroup
    \ALC@endgroup
}

\newcommand{\BODY}[1][default]{%
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{body}%
        \ALC@line{\algorithmicbody\ALC@com{#1}}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ENDBODY}{%
            \ALC@endstatement
        \ALC@endgroup
    \ALC@endgroup
}

% #1 XML tag (while, if, elsif, for, forall)
% #2 pre-condition keyword text
% #3 condition
% #4 comment (optional)
% #5 post-condition keyword

\newcommand{\ALC@begin@structure}[5]{%
    \ALC@endstatement
    \ALC@begingroup % LEVEL 1
        \ALC@pushtag{#1}%
        \ALC@start@condition
            #2 #3 #5 \ALC@com{#4}\par
        \ALC@end@condition
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

% #1 keyword text

\newcommand{\ALC@end@structure}[1]{%
            \ALC@endstatement
        \ALC@endgroup  % LEVEL 2
        \ifALC@noend\else
            \ALC@line{#1}%
        \fi
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
    \ALC@begin@structure{while}{\algorithmicwhile}{#2}{#1}{\algorithmicdo}
}

\def\ENDWHILE{\ALC@end@structure{\algorithmicendwhile}}

\newcommand{\IF}[2][default]{%
    \ALC@begin@structure{if}{\algorithmicif}{#2}{#1}{\algorithmicthen}
    \let\ALC@end@else\@empty
}

\newcommand{\ELSIF}[2][default]{%
                \ALC@endstatement
            \ALC@end@else
        \ALC@endgroup % end the block (LEVEL 2)
        \let\ALC@end@else\ALC@endgroup % (LEVEL 1)
        \ALC@begin@structure{elsif}{\algorithmicelsif}{#2}{#1}{\algorithmicthen}% LEVEL 3
}

\newcommand{\ELSE}[1][default]{% No condition
                \ALC@endstatement
            \ALC@end@else
        \ALC@endgroup % end if block
        \let\ALC@end@else\ALC@endgroup
        \ALC@begingroup
            \ALC@pushtag{else}
            \ALC@line{\algorithmicelse\ALC@com{#1}}%
            \ALC@begingroup
                \ALC@pushtag{block}%
}

\def\ENDIF{%
                \ALC@endstatement
            \ALC@end@else
        \ALC@endgroup % END BLOCK (LEVEL 2)
        \ifALC@noend\else
            \ALC@line{\algorithmicendif}
        \fi
    \ALC@endgroup
}

\newcommand{\FOR}[2][default]{%
    \ALC@begin@structure{for}{\algorithmicfor}{#2}{#1}{\algorithmicdo}
}

\newcommand{\FORALL}[2][default]{%
    \ALC@begin@structure{forall}{\algorithmicforall}{#2}{#1}{\algorithmicdo}
}

\def\ENDFOR{\ALC@end@structure{\algorithmicendfor}}

\newcommand{\LOOP}[1][default]{% No condition
    % \ALC@begin@structure{loop}{}{#2}{#1}
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{loop}%
        \ALC@line{\algorithmicloop\ALC@com{#1}}%
        \ALC@begingroup
            \ALC@pushtag{block}%
}

\newcommand{\REPEAT}[1][default]{% No condition
    \ALC@endstatement
    \ALC@begingroup
        \ALC@pushtag{repeat}%
        \ALC@line{\algorithmicrepeat\ALC@com{#1}}%
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
        \ALC@endgroup
    \ALC@endgroup
}

\def\ENDLOOP{\ALC@end@structure{\algorithmicendloop}}

\TeXMLendPackage

\endinput

__END__

https://codepen.io/pkra/pen/339d4c791a24ab6f57d157e0ac69d537

Packages:

algorithm.sty: Just defined algorithm float wrapper.
algorithmic.sty: Defined algorithmic environment (this package)

algorithmicx: extended algorithmic with more layout options
algpseudocode: algorithmic layout style in algorithmicx

algorithm2e: very different markup

clrscode: ick
