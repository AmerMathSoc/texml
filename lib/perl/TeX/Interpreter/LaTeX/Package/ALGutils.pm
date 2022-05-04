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

use version; our $VERSION = qv '1.1.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::ALGutils::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{ALGutils}

\RequirePackage{ifthen}

\newboolean{ALG@noend}
\setboolean{ALG@noend}{false}

\newif\if@ALG@numbered
\@ALG@numberedfalse

\newcounter{ALG@frequency}

\newcounter{ALG@line}      % counter for current line
\newcounter{ALG@rem}       % counter for lines not printed

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
        \let\ALG@endtoplevel\@empty
}

\def\ALG@endgroup{%
        \ALG@popstack
    \endgroup
}

%% Top-level (sort of)

\def\ALG@addlineno{%
    \if@ALG@numbered
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
        \par\ALG@open{comment}#1\ALG@close{comment}\par
    \fi
}

\def\def@ALG@statement{\maybe@st@rred{\def@ALG@statement@}}

\def\patch@ALG@comments{\let\Comment\ALG@com}

\newcommand{\def@ALG@statement@}[3][]{%
    \edef#2{%
        \@nx\ALG@endtoplevel
\@nx\patch@ALG@comments
        \@nx\ALG@begingroup
            \let\@nx\ALG@endtoplevel\@nx\ALG@endtoplevel@
            \@nx\ALG@pushtag{line}%
            \ifst@rred\else
                \@nx\ALG@addlineno
            \fi
            \@nx\ALG@begingroup
                \let\@nx\ALG@endtoplevel\@nx\ALG@endtoplevel@
                \@nx\ALG@pushtag{#3}%
                \if###1##\else
                    \@nx#1
                \fi
    }%
}

\let\ALG@endtoplevel\@empty
\def\ALG@endtoplevel@{\ALG@endgroup\ALG@endgroup}

% #1 XML tag (while, if, elsif, for, forall)
% #2 pre-condition keyword text
% #3 condition
% #4 comment (optional)
% #5 post-condition keyword

\newcommand{\ALG@begin@structure}[5]{%
    \ALG@endtoplevel
    \ALG@begingroup % LEVEL 1
\patch@ALG@comments
        \ALG@pushtag{#1}%
        \ALG@start@condition
            \ALG@pushtag{statement}%
                #2 #3 #5\par
            \ALG@popstack
            \ALG@com{#4}%
        \ALG@end@condition
        \ALG@begingroup % LEVEL 2
            \ALG@pushtag{block}%
}

% #1 keyword text

\newcommand{\ALG@end@structure}[1]{%
            \ALG@endtoplevel
        \ALG@endgroup  % LEVEL 2
        \ifALG@noend\else
            \ALG@line{#1}{}%
        \fi
    \ALG@endgroup % LEVEL
}

\newcommand{\ALG@start@condition}{%
    \ALG@open{condition}%
    \ALG@open{line}%
    \ALG@addlineno
    \ALG@begingroup
}

\newcommand{\ALG@end@condition}{%
    \ALG@endgroup
    \ALG@close{line}%
    \ALG@close{condition}%
}

\TeXMLendPackage

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

  Structures: Structures nest inside each other

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
