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

\newcommand{\TRUE}{\algorithmictrue{}}
\newcommand{\FALSE}{\algorithmicfalse{}}
\newcommand{\AND}{\algorithmicand{} }
\newcommand{\OR}{\algorithmicor{} }
\newcommand{\XOR}{\algorithmicxor{} }
\newcommand{\NOT}{\algorithmicnot{} }
\newcommand{\TO}{\algorithmicto{} }

\newif\ifALC@toplevel@
\ALC@toplevel@false

\let\ALC@tagstack\@empty

\long\def\g@stack@push#1#2{%
    \protected@xdef#1{\protect#2#1}%
}

\def\ALC@pushtag#1{%
    \startXMLelement{algo-#1}%
    \g@stack@push\ALC@tagstack{\endXMLelement{algo-#1}}%
}

\def\ALC@poptags{%
    \par
    \ALC@tagstack
    \global\let\ALC@tagstack\@empty
}

\def\ALC@startline{%
    \ALC@poptags
    \par
    \ALC@endline
    \let\ALC@endline\ALC@endline@
    \par
    \startXMLelement{algo-line}%
}

\def\ALC@endline@{%
    \par
    \endXMLelement{algo-line}%
    \let\ALC@endline\@empty
    \par
}

\let\ALC@endline\@empty

%% Top-level

\newcommand{\REQUIRE}{%
    \ALC@poptags
    \ALC@pushtag{require}%
}

\newcommand{\ENSURE}{
    \ALC@poptags
    \ALC@pushtag{ensure}%
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

\newcommand{\COMMENT}[1]{\algorithmiccomment{##1}}

\def\ALC@g#1#2{%
    \newenvironment{ALC@#1}{%
        \ALC@poptags
        \par
        \startXMLelement{algo-#2}%
    }{%
        %% TODO: ALC@noend
        \ALC@poptags
        \par
        \endXMLelement{algo-#2}%
        \par
    }%
}

\ALC@g{inputs}{inputs}
\ALC@g{outputs}{outputs}
\ALC@g{globals}{globals}
\ALC@g{body}{body}
\ALC@g{if}{if}
\ALC@g{for}{for}
\ALC@g{while}{while}
\ALC@g{loop}{loop}
\ALC@g{rpt}{repeat}

\renewenvironment{algorithmic}[1][0]{
    \par
    \xmlpartag{}%
    \startXMLelement{algo-algo}
%
    \let\@item\ALC@item

    \renewcommand{\\}{\@centercr}

    \ALC@toplevel@true

    \newcommand{\ALC@it}{%
        \stepcounter{ALC@rem}%
        \ifthenelse{\equal{\arabic{ALC@rem}}{#1}}{\setcounter{ALC@rem}{0}}{}%
        \stepcounter{ALC@line}%
        \refstepcounter{ALC@unique}%
        % \item\def\@currentlabel{\theALC@line}%
        \par
    }

    \newcommand{\ALC@com}[1]{%
        \ifthenelse{\equal{##1}{default}}{}{\ \algorithmiccomment{##1}}%
    }

    \newcommand{\INPUTS}[1][default]{%
        \ALC@it\algorithmicinputs\ \ALC@com{##1}\begin{ALC@inputs}%
    }
    \newcommand{\ENDINPUTS}{\end{ALC@inputs}}

    \newcommand{\OUTPUTS}[1][default]{%
        \ALC@it\algorithmicoutputs\ \ALC@com{##1}\begin{ALC@outputs}%
    }
    \newcommand{\ENDOUTPUTS}{\end{ALC@outputs}}

    \newcommand{\GLOBALS}{\ALC@it\algorithmicglobals\ }

    \newcommand{\BODY}[1][default]{%
        \ALC@it\algorithmicbody\ \ALC@com{##1}\begin{ALC@body}%
    }
    \newcommand{\ENDBODY}{\end{ALC@body}}

    \newcommand{\IF}[2][default]{%
        \begin{ALC@if}%
        \ALC@startline
            ##2%\ \algorithmicthen
            \ALC@com{##1}
        \ALC@endline
    }

    \newcommand{\ELSE}[1][default]{%
        \end{ALC@if}%
        \begin{ALC@if}%
        \setXMLattribute{type}{else}%
    }

    \newcommand{\ELSIF}[2][default]{%
        \end{ALC@if}%
        \begin{ALC@if}%
        \setXMLattribute{type}{elsif}%
        \ALC@startline
            % \algorithmicelseif
            ##2%\ \algorithmicthen
            \ALC@com{##1}%
        \ALC@endline
    }

    \newcommand{\FOR}[2][default]{%
        \ALC@it\algorithmicfor\ ##2\ \algorithmicdo
        \ALC@com{##1}\begin{ALC@for}%
    }

    \newcommand{\FORALL}[2][default]{%
        \ALC@it\algorithmicforall\ ##2\ \algorithmicdo
        \ALC@com{##1}\begin{ALC@for}%
    }

    \newcommand{\WHILE}[2][default]{%
        \begin{ALC@while}%
        \ALC@startline
            ##2%\ \algorithmicdo
        \ALC@endline
        \ALC@com{##1}
    }

    \newcommand{\LOOP}[1][default]{%
        \ALC@it\algorithmicloop \ALC@com{##1}\begin{ALC@loop}%
    }
    \newcommand{\REPEAT}[1][default]{%
        \ALC@it\algorithmicrepeat \ALC@com{##1}\begin{ALC@rpt}%
    }
    \newcommand{\UNTIL}[1]{\end{ALC@rpt}\ALC@it\algorithmicuntil\ ##1}

    % \ifthenelse{\boolean{ALC@noend}}{
        \newcommand{\ENDIF}{\end{ALC@if}}
        \newcommand{\ENDFOR}{\end{ALC@for}}
        \newcommand{\ENDWHILE}{\end{ALC@while}}
        \newcommand{\ENDLOOP}{\end{ALC@loop}}
    % }{%
    %     \newcommand{\ENDIF}{\end{ALC@if}\ALC@it\algorithmicendif}
    %     \newcommand{\ENDFOR}{\end{ALC@for}\ALC@it\algorithmicendfor}
    %     \newcommand{\ENDWHILE}{\end{ALC@while}\ALC@it\algorithmicendwhile}
    %     \newcommand{\ENDLOOP}{\end{ALC@loop}\ALC@it\algorithmicendloop}
    % }
}{%
    \ALC@poptags
    \par
    \endXMLelement{algo-algo}
    \par
}

\TeXMLendPackage

\endinput

__END__

https://codepen.io/pkra/pen/339d4c791a24ab6f57d157e0ac69d537
