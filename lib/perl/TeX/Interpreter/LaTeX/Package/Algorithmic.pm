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

\newcommand{\ALC@open}[1]{\startXMLelement{\ALC@NS:#1}}
\newcommand{\ALC@close}[1]{\endXMLelement{\ALC@NS:#1}}

\newcommand{\TRUE}{\algorithmictrue{}}
\newcommand{\FALSE}{\algorithmicfalse{}}
\newcommand{\AND}{\algorithmicand{} }
\newcommand{\OR}{\algorithmicor{} }
\newcommand{\XOR}{\algorithmicxor{} }
\newcommand{\NOT}{\algorithmicnot{} }
\newcommand{\TO}{\algorithmicto{} }

\let\ALC@tagstack\@empty

\long\def\g@stack@push#1#2{%
    \protected@xdef#1{\protect#2#1}%
}

\def\ALC@pushtag#1{%
    \ALC@open{#1}%
    \g@stack@push\ALC@tagstack{\ALC@close{#1}}%
}

\def\ALC@poptags{%
    \par
    \ALC@tagstack
    \global\let\ALC@tagstack\@empty
}

\let\ALC@elsestack\@empty

\def\ALC@pushelse#1{%
    \ALC@open{#1}%
    \g@stack@push\ALC@elsestack{\ALC@close{#1}}%
}

\def\ALC@popelse{%
    \par
    \ALC@elsestack
    \global\let\ALC@elsestack\@empty
}

% \def\ALC@pushelse#1{%
%     \ALC@poptags
%     \ALC@open{#1}%
%     \gdef\ALC@close@else{%
%         \ALC@close{#1}%
%         \global\let\ALC@close@else\@empty
%     }%
% }

\let\ALC@close@else\@empty

\def\ALC@startline{%
    \ALC@poptags
    \par
    \ALC@endline
    \let\ALC@endline\ALC@endline@
    \par
    \ALC@open{line}%
}

\def\ALC@endline@{%
    \par
    \ALC@close{line}%
    \let\ALC@endline\@empty
    \par
}

\let\ALC@endline\@empty

\def\ALC@startblock{%
    \ALC@poptags
    \par
    \ALC@endblock
    \let\ALC@endblock\ALC@endblock@
    \par
    \ALC@open{block}%
}

\def\ALC@endblock@{%
    \par
    \ALC@poptags
    \par
    \ALC@close{block}%
    \let\ALC@endblock\@empty
    \par
}

\let\ALC@endblock\@empty

%% Top-level

\newcommand{\REQUIRE}{%
    \ALC@poptags
    \ALC@pushtag{require}%
}

\newcommand{\ENSURE}{
    \ALC@poptags
    \ALC@pushtag{ensure}%
}

\newcommand{\GLOBALS}{%
    \ALC@poptags
    \ALC@pushtag{globals}%
}

\newcommand{\STATE}{%
    \ALC@poptags
    \ALC@pushtag{line}%
    \ALC@pushtag{state}%
}

\newcommand{\PRINT}{%
    \STATE \algorithmicprint{} % keep this space
}

\newcommand{\RETURN}{%
    \STATE \algorithmicreturn{} % keep this space
}

\newcommand{\STMT}{\STATE}

\def\algorithmiccomment#1{%
    \ALC@open{comment}#1\ALC@close{comment}%
}

\newcommand{\COMMENT}[1]{\algorithmiccomment{#1}}

\newcommand{\ALC@com}[1]{%
    \ifthenelse{\equal{#1}{default}}{}{\ \COMMENT{#1}}%
}

\def\ALC@g#1{%
    \newenvironment{ALC@#1}{%
        \ALC@poptags
        \par
        \ALC@open{#1}%
    }{%
        %% TODO: ALC@noend
        \ALC@poptags
        \par
        \ALC@close{#1}%
        \par
    }%
}

\ALC@g{inputs}
\ALC@g{outputs}
\ALC@g{globals}
\ALC@g{body}
\ALC@g{if}
\ALC@g{elsif}
\ALC@g{else}
\ALC@g{for}
\ALC@g{forall}
\ALC@g{while}
\ALC@g{loop}
\ALC@g{repeat}
\ALC@g{until}

\newcommand{\INPUTS}[1][default]{%
    \begin{ALC@inputs}%
    \ALC@com{#1}%
}

\newcommand{\ENDINPUTS}{%
    \end{ALC@inputs}%
}

\newcommand{\OUTPUTS}[1][default]{%
    \begin{ALC@outputs}%
    \ALC@com{#1}%
}

\newcommand{\ENDOUTPUTS}{%
    \end{ALC@outputs}%
}

\newcommand{\BODY}[1][default]{%
    \begin{ALC@body}%
    \ALC@com{#1}%
}

\newcommand{\ENDBODY}{%
    \end{ALC@body}%
}

\newcommand{\IF}[2][default]{%
    \begin{ALC@if}%
    \ALC@open{condition}%
    \ALC@startline
        #2%
        \ALC@com{#1}%
    \ALC@endline
    \ALC@close{condition}%
    \ALC@startblock
}

\newcommand{\ELSIF}[2][default]{%
    \ALC@endblock
    \ALC@popelse
    \ALC@pushelse{elsif}
    \ALC@open{condition}%
    \ALC@startline
         #2%
         \ALC@com{#1}%
    \ALC@endline
    \ALC@close{condition}%
    \ALC@startblock
}

\newcommand{\ELSE}[1][default]{%
    \ALC@endblock
    \ALC@popelse
    \ALC@pushelse{else}
    \ALC@com{#1}%
    \ALC@startblock
}

\newcommand{\ENDIF}{%
    \ALC@endblock
    \ALC@popelse
    \end{ALC@if}%
}

\newcommand{\FOR}[2][default]{%
    \begin{ALC@for}
    \def\ALC@end@for{\end{ALC@for}}%
    \ALC@open{condition}%
    \ALC@startline
        #2%
        \ALC@com{#1}%
    \ALC@endline
    \ALC@close{condition}%
    \ALC@startblock
}

\newcommand{\FORALL}[2][default]{%
    \begin{ALC@forall}
    \def\ALC@end@for{\end{ALC@forall}}%
    \ALC@open{condition}%
    \ALC@startline
        #2%
        \ALC@com{#1}%
    \ALC@endline
    \ALC@close{condition}%
    \ALC@startblock
}

\newcommand{\ENDFOR}{%
    \ALC@endblock
    \ALC@end@for
}

\newcommand{\WHILE}[2][default]{%
    \begin{ALC@while}%
    \ALC@open{condition}%
    \ALC@startline
        #2%
    \ALC@endline
    \ALC@close{condition}%
    \ALC@com{#1}%
    \ALC@startblock
}

\newcommand{\ENDWHILE}{\ALC@endblock\end{ALC@while}}

\newcommand{\LOOP}[1][default]{%
    \begin{ALC@loop}%
    \ALC@open{condition}%
    \ALC@startline
        #1%
    \ALC@endline
    \ALC@close{condition}%
    \ALC@startblock
}

\newcommand{\REPEAT}[1][default]{%
    \begin{ALC@repeat}%
    \ALC@com{#1}%
    \ALC@startblock
}

\newcommand{\UNTIL}[1]{%
    \ALC@endblock
    \end{ALC@repeat}%
    \begin{ALC@until}%
    \ALC@open{condition}%
    \ALC@startline
        #1%
    \ALC@endline
    \ALC@close{condition}%
    \end{ALC@until}%
}

\newcommand{\ENDLOOP}{%
    \ALC@endblock
    \end{ALC@loop}%
}

\renewenvironment{algorithmic}[1][0]{
    \par
    \xmlpartag{}%
    \ALC@open{algorithm}
%
    \renewcommand{\\}{\@centercr}% TBD
    \newcommand{\ALC@it}{%
        \stepcounter{ALC@rem}%
    % UGGGG
        \ifthenelse{\equal{\arabic{ALC@rem}}{#1}}{\setcounter{ALC@rem}{0}}{}%
        \stepcounter{ALC@line}%
        \refstepcounter{ALC@unique}%
        % \item\def\@currentlabel{\theALC@line}%
        \par
    }
}{%
    \ALC@poptags
    \par
    \ALC@close{algorithm}
    \par
}

\TeXMLendPackage

\endinput

__END__

https://codepen.io/pkra/pen/339d4c791a24ab6f57d157e0ac69d537
