package TeX::Interpreter::LaTeX::Package::ALGutils;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification(__PACKAGE__);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::ALGutils::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{ALGutils}

\RequirePackage{ifthen}

\newboolean{ALG@noend}
\setboolean{ALG@noend}{false}

\DeclareOption{noend}{\setboolean{ALG@noend}{true}}
\DeclareOption{end}{\setboolean{ALG@noend}{false}}

\ProcessOptions

\newif\ifALG@numbered
\ALG@numberedfalse

\newcounter{ALG@frequency}

\ifx\c@ALG@line\undefined
    \newcounter{ALG@line}      % counter for current line
    \newcounter{ALG@rem}       % counter for lines not printed
\fi

\newcommand{\ALG@linenodelimiter}{:}

\let\algorithmic\relax
\let\endalgorithmic\relax

\newenvironment{algorithmic}[1][0]{
    \par
    \xmlpartag{}%
    \def\\{\emptyXMLelement{br}}%
    \c@ALG@frequency=#1\relax
    \ifnum\c@ALG@frequency=\z@
        \ALG@numberedfalse
    \else
        \ALG@numberedtrue
        \c@ALG@line\z@
        \c@ALG@rem\z@
    \fi
    % TBD: Do we need ALC@unique?
    \ALG@begingroup
        \ALG@pushtag{algorithm}%
        \setXMLattribute{linenodelimiter}{\ALG@linenodelimiter}%
        \ALG@inlinefalse
        \ALG@instatementfalse
        \ALG@inconditionfalse
        \ALG@instructurefalse
}{%
        \ALG@end@structure
    \ALG@endgroup
    \par
}

\def\ALG@NS{alg}

\newcommand{\ALG@open}[1]{%
    % \typeout{*** OPEN #1}%
    \par
    \startXMLelement{\ALG@NS:#1}%
}

\newcommand{\ALG@close}[1]{%
    % \typeout{*** CLOSE #1}%
    \par
    \endXMLelement{\ALG@NS:#1}%
}

\let\ALG@tagstack\@empty

\long\def\g@push@stack#1#2{%
    \protected@edef#1{\protect#2#1}%
}

\def\ALG@clearstack{\let\ALG@tagstack\@empty}

\def\ALG@pushtag#1{%
    \ALG@open{#1}%
    \g@push@stack\ALG@tagstack{\ALG@close{#1}}%
}

\def\ALG@popstack{%
    \par
    \ALG@tagstack
    \ALG@clearstack
}

\def\ALG@begingroup{%
    \begingroup
        \ALG@clearstack
}

\def\ALG@endgroup{%
        \ALG@popstack
    \endgroup
}

%% Top-level (sort of)

% May not need all of these

\newif\ifALG@inline
\newif\ifALG@instatement
\newif\ifALG@incondition
\newif\ifALG@instructure
\newif\ifALG@inblock

%* = unnumbered line
\def\ALG@begin@statement{\maybe@st@rred\ALG@begin@statement@}%SAFE

\def\ALG@begin@statement@#1{%
    \double@expand{%
        \protect\ALG@end@line
        \protect\ALG@end@condition
        \protect\ALG@begin@line\ifst@rred*\fi
    }%
    \ALG@begingroup
        \ALG@pushtag{#1}%
        \ALG@instatementtrue
}

\def\ALG@end@statement{%
    \ifALG@instatement
        \par
        \ALG@endgroup
    \fi
}

\newif\ifALG@startblock
\def\ALG@startblocktrue{\global\let\ifALG@startblock\iftrue}
\def\ALG@startblockfalse{\global\let\ifALG@startblock\iffalse}
\ALG@startblockfalse

\def\ALG@begin@line{\@ifstar\ALG@begin@line@\ALG@begin@line@@}

\def\ALG@begin@line@{%
    \ALG@end@statement
    \ALG@end@line
    \ifALG@startblock
        \ALG@begin@block
        \ALG@startblockfalse
    \fi
    \ALG@begingroup
        \ALG@inlinetrue
        \ALG@pushtag{line}%
}

\def\ALG@begin@line@@{%
    \ALG@begin@line@
    \ALG@addlineno
}

\def\ALG@end@line{%
    \ALG@end@statement
    \ifALG@inline
        \ALG@endgroup
    \fi
}

\def\ALG@begin@block{%
    \ALG@end@block
    \ALG@begingroup
        \ALG@inblocktrue
        \ALG@pushtag{block}%
}

\def\ALG@end@block{%
    \ALG@end@line
    \ALG@end@condition % paranoia
    \ALG@startblockfalse
    \ifALG@inblock
        \ALG@endgroup
    \fi
}

\def\ALG@begin@structure{\@ifstar\ALG@begin@structure@\ALG@begin@structure@@}

\def\ALG@begin@structure@#1{%
    \ALG@end@condition
    \ALG@end@line%?
    \ifALG@startblock
        \ALG@begin@block
        \ALG@startblockfalse
    \fi
    \ALG@begingroup
        % First, erase the memory of enclosing structures.
        \ALG@inlinefalse
        \ALG@instatementfalse
        \ALG@inconditionfalse
        \ALG@inblockfalse
        % Then start the new one.
        \ALG@pushtag{#1}%
        \ALG@instructuretrue
}

\def\ALG@begin@structure@@#1{%
    \ALG@begin@structure@{#1}%
    \ALG@begin@condition
}

\def\ALG@end@structure{%
    \ALG@end@condition
    \ALG@end@line
    \ifALG@instructure
        \ALG@endgroup
    \fi
}

\def\ALG@begin@condition{%
    \ALG@end@line
    \ALG@begingroup
        \ALG@pushtag{condition}%
        \ALG@inconditiontrue
}

\def\ALG@end@condition{%
    \ALG@end@line
    \ifALG@incondition
        \ALG@endgroup
    \fi
}

\def\ALG@addlineno{%
    \ifALG@numbered
        \refstepcounter{ALG@line}%
        \stepcounter{ALG@rem}%
        \ifnum\c@ALG@rem=\c@ALG@frequency
            \setXMLattribute{lineno}{\the\c@ALG@line}%
            \setcounter{ALG@rem}{0}%
        \fi
    \fi
}

\def\ALG@line#1#2{%
    \ALG@open{line}%
        \ALG@addlineno
        \ALG@begingroup
            \ALG@pushtag{statement}%
                #1\par
        \ALG@endgroup
        \ALG@com{#2}%
    \ALG@close{line}%
}

\newcommand{\ALG@com}[1]{%
    \if###1##\else
        \ALG@end@statement
        \par\ALG@open{comment}#1\ALG@close{comment}\par
    \fi
}

\def\def@ALG@statement{\maybe@st@rred\def@ALG@statement@}% SAFE

\newcommand{\def@ALG@statement@}[3][]{%
    \edef#2{%
        \@nx\ALG@begin@statement\ifst@rred*\fi{#3}%
        \if###1##\else
            \@nx#1
        \fi
    }%
}

% *  no <condition>
% #1 XML tag (while, if, elsif, for, forall)
% #2 pre-condition keyword text
% #3 condition
% #4 comment (optional)
% #5 post-condition keyword

\newcommand{\ALG@open@structure}{\maybe@st@rred\ALG@open@structure@}%SAFE?

\newcommand{\ALG@open@structure@}[5]{%
    \double@expand{%
        \protect\ALG@begin@structure\ifst@rred*\fi{#1}%
    }
    \ALG@begin@line
    \ALG@begingroup
        % Begin statement manually so we don't prematurely close the condition.
        \ALG@pushtag{statement}% maybe just a line here?
            \ALG@instatementtrue
            #2 #3 #5\par
            \ALG@com{#4}%
        % Can't end the condition here because there might be a \Comment
        \ALG@startblocktrue
}

% #1 keyword text

\newcommand{\ALG@close@structure}[1]{%
    \ALG@end@block
    \ifALG@noend\else
        \if###1##\else
            \ALG@line{#1}{}%
        \fi
    \fi
    \ALG@end@structure
}

\endinput

__END__

https://codepen.io/pkra/pen/339d4c791a24ab6f57d157e0ac69d537

Packages:

algorithm.sty: Just defines algorithm float wrapper.

===========================================================================

algorithmic: Defines algorithmic environment (this package)

algorithmicx: Redefined algorithmic environment with more layout
    options and other extensions -- independent implementation from
    algorithmic.sty

algpseudocode: algorithmic layout style built on top of algorithmicx

===========================================================================

algorithm2e: very different markup; defines algorithm environment

clrscode: ick

===========================================================================
===========================================================================

  Structures: Structures nest inside each other, but a structure ends
      a statement

        INPUTS...ENDINPUTS
        OUTPUTS...ENDOUTPUTS

        BODY...ENDBODY
        IF...ENDIF
        FOR...ENDFOR,
        FORALL...ENDFORALL
        WHILE...ENDWHILE
        LOOP...ENDLOOP
        REPEAT...UNTIL

    Statements (implicit end tag): Standalone or nested within a
        structure; each ends a previous statement/line.

        STATE
        REQUIRE
        ENSURE
        GLOBALS
        RETURN
        PRINT

    Argument: \COMMENT    [Ends a statement, but not a line.]

<algorithm>
    (<inputs> | <outputs>)*
    (<structure> | <line>)*
</algorithm>

<line>
    <statement>
    <comment>
</line>
