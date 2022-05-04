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

use version; our $VERSION = qv '1.0.0';

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

\newcounter{ALC@line}      % counter for current line
\newcounter{ALC@rem}       % counter for lines not printed

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
        \let\ALC@endtoplevel\@empty
}

\def\ALC@endgroup{%
        \ALC@popstack
    \endgroup
}

%% Top-level (sort of)

\newif\if@ALCnumbered
\@ALCnumberedfalse

\newcount\ALC@frequency

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

\def\ALC@line#1#2{%
    \ALC@open{line}%
        \ALC@addlineno
        \ALC@begingroup
        \ALC@pushtag{statement}%
            #1\par
        \ALC@endgroup
        \ALC@com{#2}\par
    \ALC@close{line}%
}

\newcommand{\ALC@com}[1]{%
    \ifthenelse{\equal{#1}{default}}{}{%
        \if###1##\else
            \ \ALC@open{comment}#1\ALC@close{comment}%
        \fi
    }%
}

\def\defALC@toplevel{\maybe@st@rred{\defALC@toplevel@}}

\newcommand{\defALC@toplevel@}[3][]{%
    \edef#2{%
        \@nx\ALC@endtoplevel
        \@nx\ALC@begingroup
            \let\@nx\ALC@endtoplevel\@nx\ALC@endtoplevel@
            \@nx\ALC@pushtag{line}%
            \ifst@rred\else
                \@nx\ALC@addlineno
            \fi
            \@nx\ALC@begingroup
                \let\@nx\ALC@endtoplevel\@nx\ALC@endtoplevel@
                \@nx\ALC@pushtag{#3}%
                \if###1##\else
                    \@nx#1
                \fi
    }%
}

\let\ALC@endtoplevel\@empty
\def\ALC@endtoplevel@{\ALC@endgroup\ALC@endgroup}

% #1 XML tag (while, if, elsif, for, forall)
% #2 pre-condition keyword text
% #3 condition
% #4 comment (optional)
% #5 post-condition keyword

\newcommand{\ALC@begin@structure}[5]{%
    \ALC@endtoplevel
    \ALC@begingroup % LEVEL 1
        \ALC@pushtag{#1}%
        \ALC@start@condition
            \ALC@pushtag{statement}%
                #2 #3 #5\par
            \ALC@popstack
            \ALC@com{#4}\par
        \ALC@end@condition
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

% #1 keyword text

\newcommand{\ALC@end@structure}[1]{%
            \ALC@endtoplevel
        \ALC@endgroup  % LEVEL 2
        \ifALC@noend\else
            \ALC@line{#1}{}%
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

algorithm2e: very different markup

clrscode: ick
